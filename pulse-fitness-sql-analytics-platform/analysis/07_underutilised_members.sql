/*
Query Name: Underutilised Active Member Detection
Difficulty Level: Intermediate
Business Question: Which active paying members have visited fewer than three times in the last 60 days of the analysis period?
Why This Matters: Identifies disengaged members who may be at risk of churn.
Analysis Period: 2025-05-01 to 2025-06-30
SQL Concepts Used: LEFT JOIN, HAVING, date filtering
Expected Output: Member, membership type, location, visit count, last visit date
*/

USE PulseFitnessAnalytics;

WITH paid_members AS (
    SELECT DISTINCT MemberID
    FROM Payment
    WHERE PaymentStatus = 'Paid'
      AND PaymentDate BETWEEN '2025-05-01' AND '2025-06-30'
)
SELECT
    m.MemberID,
    m.FullName,
    mt.TypeName AS MembershipType,
    gl.LocationName,
    COUNT(fv.VisitID) AS VisitCountLast60Days,
    MAX(fv.CheckInTime) AS LastVisitDate
FROM `Member` m
JOIN MembershipType mt ON m.MembershipTypeID = mt.MembershipTypeID
JOIN GymLocation gl ON m.LocationID = gl.LocationID
JOIN paid_members pm ON m.MemberID = pm.MemberID
LEFT JOIN FacilityVisit fv
    ON m.MemberID = fv.MemberID
   AND fv.CheckInTime BETWEEN '2025-05-01' AND '2025-06-30 23:59:59'
WHERE m.MemberStatus = 'Active'
GROUP BY m.MemberID, m.FullName, mt.TypeName, gl.LocationName
HAVING VisitCountLast60Days < 3
ORDER BY VisitCountLast60Days ASC, LastVisitDate ASC;
