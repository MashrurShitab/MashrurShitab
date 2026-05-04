/*
Query Name: Failed and Refunded Payment Analysis
Difficulty Level: Basic to Intermediate
Business Question: How much revenue was lost due to failed or refunded payments during the selected analysis period?
Why This Matters: Supports payment recovery and finance process improvement.
Analysis Period: 2025-01-01 to 2025-06-30
SQL Concepts Used: WHERE, GROUP BY, conditional aggregation
Expected Output: Payment status, transaction count, affected members, missed or reversed revenue
*/

USE PulseFitnessAnalytics;

SELECT
    p.PaymentStatus,
    COUNT(*) AS TransactionCount,
    COUNT(DISTINCT p.MemberID) AS AffectedMemberCount,
    ROUND(SUM(p.Amount), 2) AS MissedOrReversedRevenue
FROM Payment p
WHERE p.PaymentDate BETWEEN '2025-01-01' AND '2025-06-30'
  AND p.PaymentStatus IN ('Failed', 'Refunded')
GROUP BY p.PaymentStatus
ORDER BY MissedOrReversedRevenue DESC;
