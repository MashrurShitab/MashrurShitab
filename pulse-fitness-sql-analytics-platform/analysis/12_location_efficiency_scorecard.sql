/*
Query Name: Location Efficiency Scorecard
Difficulty Level: Expert
Business Question: Which gym locations are most efficient when comparing revenue, visits, attendance, trainer utilisation, payment success, and member count?
Why This Matters: Creates a branch-level management scorecard for strategic decision-making.
Analysis Period: 2025-01-01 to 2025-06-30
SQL Concepts Used: Multiple CTEs, derived KPIs, window functions, ranking
Expected Output: Location, revenue, members, visits, revenue per visit, attendance rate, trainer rating, failed payment rate, rank
*/

USE PulseFitnessAnalytics;

WITH revenue AS (
    SELECT
        m.LocationID,
        SUM(CASE WHEN p.PaymentStatus = 'Paid' THEN p.Amount ELSE 0 END) AS TotalRevenue,
        SUM(CASE WHEN p.PaymentStatus IN ('Paid', 'Failed', 'Refunded', 'Pending') THEN 1 ELSE 0 END) AS PaymentCount,
        SUM(CASE WHEN p.PaymentStatus = 'Failed' THEN 1 ELSE 0 END) AS FailedPaymentCount
    FROM Payment p
    JOIN `Member` m ON p.MemberID = m.MemberID
    WHERE p.PaymentDate BETWEEN '2025-01-01' AND '2025-06-30'
    GROUP BY m.LocationID
),
members AS (
    SELECT
        LocationID,
        COUNT(*) AS MemberCount
    FROM `Member`
    WHERE MemberStatus = 'Active'
    GROUP BY LocationID
),
visits AS (
    SELECT
        LocationID,
        COUNT(*) AS TotalVisits
    FROM FacilityVisit
    WHERE CheckInTime BETWEEN '2025-01-01' AND '2025-06-30 23:59:59'
    GROUP BY LocationID
),
attendance AS (
    SELECT
        cs.LocationID,
        SUM(CASE WHEN ca.AttendanceStatus IN ('Present', 'Late') THEN 1 ELSE 0 END) AS AttendedCount,
        COUNT(ca.AttendanceID) AS AttendanceRecordCount
    FROM ClassSession cs
    JOIN ClassEnrollment ce ON cs.SessionID = ce.SessionID
    JOIN ClassAttendance ca ON ce.EnrollmentID = ca.EnrollmentID
    WHERE cs.SessionStart BETWEEN '2025-01-01' AND '2025-06-30 23:59:59'
    GROUP BY cs.LocationID
),
trainer_rating AS (
    SELECT
        LocationID,
        AVG(Rating) AS AverageTrainerRating
    FROM PersonalTrainingSession
    WHERE SessionStatus = 'Completed'
      AND SessionStart BETWEEN '2025-01-01' AND '2025-06-30 23:59:59'
    GROUP BY LocationID
),
scorecard AS (
    SELECT
        gl.LocationID,
        gl.LocationName,
        gl.City,
        COALESCE(r.TotalRevenue, 0) AS TotalRevenue,
        COALESCE(m.MemberCount, 0) AS MemberCount,
        COALESCE(v.TotalVisits, 0) AS TotalVisits,
        ROUND(COALESCE(r.TotalRevenue, 0) / NULLIF(v.TotalVisits, 0), 2) AS RevenuePerVisit,
        ROUND(100 * COALESCE(a.AttendedCount, 0) / NULLIF(a.AttendanceRecordCount, 0), 2) AS ClassAttendanceRate,
        ROUND(tr.AverageTrainerRating, 2) AS AverageTrainerRating,
        ROUND(100 * COALESCE(r.FailedPaymentCount, 0) / NULLIF(r.PaymentCount, 0), 2) AS FailedPaymentRate
    FROM GymLocation gl
    LEFT JOIN revenue r ON gl.LocationID = r.LocationID
    LEFT JOIN members m ON gl.LocationID = m.LocationID
    LEFT JOIN visits v ON gl.LocationID = v.LocationID
    LEFT JOIN attendance a ON gl.LocationID = a.LocationID
    LEFT JOIN trainer_rating tr ON gl.LocationID = tr.LocationID
)
SELECT
    LocationID,
    LocationName,
    City,
    ROUND(TotalRevenue, 2) AS TotalRevenue,
    MemberCount,
    TotalVisits,
    RevenuePerVisit,
    ClassAttendanceRate,
    AverageTrainerRating,
    FailedPaymentRate,
    RANK() OVER (
        ORDER BY
            COALESCE(RevenuePerVisit, 0) DESC,
            COALESCE(ClassAttendanceRate, 0) DESC,
            COALESCE(AverageTrainerRating, 0) DESC,
            COALESCE(FailedPaymentRate, 100) ASC
    ) AS EfficiencyRank
FROM scorecard
ORDER BY EfficiencyRank;
