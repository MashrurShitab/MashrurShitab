/*
Query Name: Membership Revenue by Plan
Difficulty Level: Basic
Business Question: Which membership types generated the most paid revenue during the selected analysis period?
Why This Matters: Helps Pulse Fitness evaluate pricing strategy and identify which plans drive revenue.
Analysis Period: 2025-01-01 to 2025-06-30
SQL Concepts Used: JOIN, GROUP BY, SUM, COUNT, date filtering
Expected Output: Membership type, member count, paid payment count, total revenue, average revenue per member
*/

USE PulseFitnessAnalytics;

SELECT
    mt.TypeName AS MembershipType,
    COUNT(DISTINCT m.MemberID) AS MemberCount,
    COUNT(p.PaymentID) AS PaidPaymentCount,
    ROUND(SUM(p.Amount), 2) AS TotalPaidRevenue,
    ROUND(SUM(p.Amount) / NULLIF(COUNT(DISTINCT m.MemberID), 0), 2) AS AvgRevenuePerMember
FROM Payment p
JOIN `Member` m ON p.MemberID = m.MemberID
JOIN MembershipType mt ON m.MembershipTypeID = mt.MembershipTypeID
WHERE p.PaymentStatus = 'Paid'
  AND p.PaymentDate BETWEEN '2025-01-01' AND '2025-06-30'
GROUP BY mt.TypeName
ORDER BY TotalPaidRevenue DESC;
