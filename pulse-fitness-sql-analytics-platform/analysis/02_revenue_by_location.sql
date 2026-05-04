/*
Query Name: Revenue by Gym Location
Difficulty Level: Basic
Business Question: Which gym branches generated the highest paid revenue during the selected analysis period?
Why This Matters: Supports branch-level performance comparison and resource allocation.
Analysis Period: 2025-01-01 to 2025-06-30
SQL Concepts Used: JOIN, GROUP BY, ORDER BY, date filtering
Expected Output: Location, city, active member count, paid payment count, total revenue
*/

USE PulseFitnessAnalytics;

SELECT
    gl.LocationName,
    gl.City,
    COUNT(DISTINCT m.MemberID) AS ActiveMemberCount,
    COUNT(p.PaymentID) AS PaidPaymentCount,
    ROUND(SUM(p.Amount), 2) AS TotalPaidRevenue
FROM Payment p
JOIN `Member` m ON p.MemberID = m.MemberID
JOIN GymLocation gl ON m.LocationID = gl.LocationID
WHERE p.PaymentStatus = 'Paid'
  AND p.PaymentDate BETWEEN '2025-01-01' AND '2025-06-30'
GROUP BY gl.LocationID, gl.LocationName, gl.City
ORDER BY TotalPaidRevenue DESC;
