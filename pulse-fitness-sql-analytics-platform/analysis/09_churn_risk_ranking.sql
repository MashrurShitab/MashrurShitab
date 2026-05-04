/*
Query Name: Churn Risk Ranking
Difficulty Level: Advanced
Business Question: Which members are most likely to churn based on inactivity, failed payments, and low engagement?
Why This Matters: Helps management prioritise retention outreach.
Analysis Period: Risk measured as of 2025-06-30
SQL Concepts Used: CTEs, recency calculation, scoring logic, CASE, ranking
Expected Output: Member, membership type, engagement indicators, churn risk score, risk band, rank
*/

USE PulseFitnessAnalytics;

WITH latest_activity AS (
    SELECT
        m.MemberID,
        MAX(fv.CheckInTime) AS LastVisitTime,
        MAX(CASE WHEN ca.AttendanceStatus IN ('Present', 'Late') THEN cs.SessionStart END) AS LastClassAttendance,
        MAX(pts.SessionStart) AS LastPTSession
    FROM `Member` m
    LEFT JOIN FacilityVisit fv ON m.MemberID = fv.MemberID
    LEFT JOIN ClassEnrollment ce ON m.MemberID = ce.MemberID
    LEFT JOIN ClassAttendance ca ON ce.EnrollmentID = ca.EnrollmentID
    LEFT JOIN ClassSession cs ON ce.SessionID = cs.SessionID
    LEFT JOIN PersonalTrainingSession pts
        ON m.MemberID = pts.MemberID
       AND pts.SessionStatus = 'Completed'
    GROUP BY m.MemberID
),
payment_flags AS (
    SELECT
        MemberID,
        SUM(CASE WHEN PaymentStatus = 'Failed' THEN 1 ELSE 0 END) AS RecentFailedPayments
    FROM Payment
    WHERE PaymentDate BETWEEN '2025-05-01' AND '2025-06-30'
    GROUP BY MemberID
),
scored AS (
    SELECT
        m.MemberID,
        m.FullName,
        mt.TypeName AS MembershipType,
        la.LastVisitTime,
        la.LastClassAttendance,
        la.LastPTSession,
        COALESCE(pf.RecentFailedPayments, 0) AS RecentFailedPayments,
        (
            CASE WHEN la.LastVisitTime IS NULL OR la.LastVisitTime < '2025-06-01' THEN 3 ELSE 0 END
          + CASE WHEN la.LastClassAttendance IS NULL OR la.LastClassAttendance < '2025-06-01' THEN 2 ELSE 0 END
          + CASE WHEN COALESCE(pf.RecentFailedPayments, 0) > 0 THEN 2 ELSE 0 END
          + CASE WHEN mt.TypeName = 'Basic' THEN 1 ELSE 0 END
          + CASE WHEN la.LastPTSession IS NULL THEN 1 ELSE 0 END
        ) AS ChurnRiskScore
    FROM `Member` m
    JOIN MembershipType mt ON m.MembershipTypeID = mt.MembershipTypeID
    JOIN latest_activity la ON m.MemberID = la.MemberID
    LEFT JOIN payment_flags pf ON m.MemberID = pf.MemberID
    WHERE m.MemberStatus = 'Active'
)
SELECT
    MemberID,
    FullName,
    MembershipType,
    LastVisitTime,
    LastClassAttendance,
    LastPTSession,
    RecentFailedPayments,
    ChurnRiskScore,
    CASE
        WHEN ChurnRiskScore >= 6 THEN 'High Risk'
        WHEN ChurnRiskScore >= 3 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS RiskBand,
    RANK() OVER (ORDER BY ChurnRiskScore DESC, RecentFailedPayments DESC, MemberID) AS RiskRank
FROM scored
ORDER BY RiskRank;
