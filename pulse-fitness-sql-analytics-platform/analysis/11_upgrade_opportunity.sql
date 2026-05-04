/*
Query Name: Membership Upgrade Opportunity Detection
Difficulty Level: Expert
Business Question: Which Basic or Student members behave like Premium members and should be targeted for an upgrade campaign?
Why This Matters: Identifies revenue growth opportunities through targeted upselling.
Analysis Period: 2025-01-01 to 2025-06-30
SQL Concepts Used: CTEs, conditional logic, joins, revenue uplift estimate
Expected Output: Member, current plan, visits, classes attended, PT sessions, current price, premium price, estimated uplift
*/

USE PulseFitnessAnalytics;

WITH member_activity AS (
    SELECT
        m.MemberID,
        COUNT(DISTINCT fv.VisitID) AS VisitCount,
        COUNT(DISTINCT CASE WHEN ca.AttendanceStatus IN ('Present', 'Late') THEN ca.AttendanceID END) AS ClassesAttended,
        COUNT(DISTINCT pts.PTSessionID) AS PTSessionCount
    FROM `Member` m
    LEFT JOIN FacilityVisit fv
        ON m.MemberID = fv.MemberID
       AND fv.CheckInTime BETWEEN '2025-01-01' AND '2025-06-30 23:59:59'
    LEFT JOIN ClassEnrollment ce ON m.MemberID = ce.MemberID
    LEFT JOIN ClassAttendance ca ON ce.EnrollmentID = ca.EnrollmentID
    LEFT JOIN ClassSession cs
        ON ce.SessionID = cs.SessionID
       AND cs.SessionStart BETWEEN '2025-01-01' AND '2025-06-30 23:59:59'
    LEFT JOIN PersonalTrainingSession pts
        ON m.MemberID = pts.MemberID
       AND pts.SessionStart BETWEEN '2025-01-01' AND '2025-06-30 23:59:59'
       AND pts.SessionStatus = 'Completed'
    GROUP BY m.MemberID
),
failed_payment_flags AS (
    SELECT
        MemberID,
        SUM(CASE WHEN PaymentStatus = 'Failed' THEN 1 ELSE 0 END) AS FailedPayments
    FROM Payment
    WHERE PaymentDate BETWEEN '2025-01-01' AND '2025-06-30'
    GROUP BY MemberID
),
premium_price AS (
    SELECT PricePerMonth AS PremiumMonthlyPrice
    FROM MembershipType
    WHERE TypeName = 'Premium'
)
SELECT
    m.MemberID,
    m.FullName,
    mt.TypeName AS CurrentMembership,
    ma.VisitCount,
    ma.ClassesAttended,
    ma.PTSessionCount,
    mt.PricePerMonth AS CurrentMonthlyPrice,
    pp.PremiumMonthlyPrice,
    ROUND(pp.PremiumMonthlyPrice - mt.PricePerMonth, 2) AS EstimatedMonthlyRevenueUplift
FROM `Member` m
JOIN MembershipType mt ON m.MembershipTypeID = mt.MembershipTypeID
JOIN member_activity ma ON m.MemberID = ma.MemberID
LEFT JOIN failed_payment_flags fpf ON m.MemberID = fpf.MemberID
CROSS JOIN premium_price pp
WHERE mt.TypeName IN ('Basic', 'Student')
  AND m.MemberStatus = 'Active'
  AND ma.VisitCount >= 6
  AND ma.ClassesAttended >= 6
  AND ma.PTSessionCount >= 1
  AND COALESCE(fpf.FailedPayments, 0) = 0
ORDER BY EstimatedMonthlyRevenueUplift DESC, ma.VisitCount DESC, ma.ClassesAttended DESC;
