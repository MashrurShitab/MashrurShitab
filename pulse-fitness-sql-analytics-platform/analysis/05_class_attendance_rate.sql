/*
Query Name: Class Attendance Rate Analysis
Difficulty Level: Intermediate
Business Question: Which classes have the highest and lowest attendance rates?
Why This Matters: Helps management expand popular classes, reschedule weak classes, and reduce no-shows.
Analysis Period: 2025-01-01 to 2025-06-30
SQL Concepts Used: JOIN, conditional aggregation, attendance rate calculation
Expected Output: Class, sessions, bookings, attended count, no-show count, attendance rate
*/

USE PulseFitnessAnalytics;

SELECT
    fc.ClassName,
    COUNT(DISTINCT cs.SessionID) AS SessionCount,
    COUNT(DISTINCT ce.EnrollmentID) AS BookingCount,
    SUM(CASE WHEN ca.AttendanceStatus IN ('Present', 'Late') THEN 1 ELSE 0 END) AS AttendedCount,
    SUM(CASE WHEN ca.AttendanceStatus = 'No-show' THEN 1 ELSE 0 END) AS NoShowCount,
    ROUND(
        100 * SUM(CASE WHEN ca.AttendanceStatus IN ('Present', 'Late') THEN 1 ELSE 0 END)
        / NULLIF(COUNT(ca.AttendanceID), 0),
        2
    ) AS AttendanceRatePct
FROM FitnessClass fc
JOIN ClassSession cs ON fc.ClassID = cs.ClassID
LEFT JOIN ClassEnrollment ce ON cs.SessionID = ce.SessionID
LEFT JOIN ClassAttendance ca ON ce.EnrollmentID = ca.EnrollmentID
WHERE cs.SessionStart BETWEEN '2025-01-01' AND '2025-06-30 23:59:59'
GROUP BY fc.ClassID, fc.ClassName
ORDER BY AttendanceRatePct DESC, BookingCount DESC;
