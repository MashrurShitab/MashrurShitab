/*
Query Name: Peak Facility Usage Hours
Difficulty Level: Intermediate
Business Question: What are the busiest check-in hours by location?
Why This Matters: Helps optimise staffing, cleaning rosters, trainer availability, and equipment planning.
Analysis Period: 2025-01-01 to 2025-06-30
SQL Concepts Used: HOUR(), COUNT, GROUP BY, date/time analysis
Expected Output: Location, hour of day, visit count, unique visitors
*/

USE PulseFitnessAnalytics;

SELECT
    gl.LocationName,
    HOUR(fv.CheckInTime) AS HourOfDay,
    COUNT(*) AS VisitCount,
    COUNT(DISTINCT fv.MemberID) AS UniqueVisitors
FROM FacilityVisit fv
JOIN GymLocation gl ON fv.LocationID = gl.LocationID
WHERE DATE(fv.CheckInTime) BETWEEN '2025-01-01' AND '2025-06-30'
GROUP BY gl.LocationID, gl.LocationName, HOUR(fv.CheckInTime)
ORDER BY gl.LocationName, VisitCount DESC;
