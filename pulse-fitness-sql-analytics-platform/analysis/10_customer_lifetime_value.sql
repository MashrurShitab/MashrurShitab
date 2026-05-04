/*
Query Name: Customer Lifetime Value
Difficulty Level: Advanced
Business Question: Which members have generated the highest lifetime revenue, and how does value differ by membership type?
Why This Matters: Supports VIP retention, referral programs, and personalised offers.
Analysis Period: All available payment history through 2025-06-30
SQL Concepts Used: CTEs, aggregation, tenure calculation
Expected Output: Member, membership type, tenure, lifetime revenue, revenue rank within plan
*/

USE PulseFitnessAnalytics;

WITH member_revenue AS (
    SELECT
        m.MemberID,
        m.FullName,
        mt.TypeName AS MembershipType,
        m.JoinDate,
        TIMESTAMPDIFF(MONTH, m.JoinDate, '2025-06-30') + 1 AS TenureMonths,
        SUM(CASE WHEN p.PaymentStatus = 'Paid' THEN p.Amount ELSE 0 END) AS LifetimePaidRevenue
    FROM `Member` m
    JOIN MembershipType mt ON m.MembershipTypeID = mt.MembershipTypeID
    LEFT JOIN Payment p ON m.MemberID = p.MemberID
    GROUP BY m.MemberID, m.FullName, mt.TypeName, m.JoinDate
)
SELECT
    MemberID,
    FullName,
    MembershipType,
    JoinDate,
    TenureMonths,
    ROUND(LifetimePaidRevenue, 2) AS LifetimePaidRevenue,
    ROUND(LifetimePaidRevenue / NULLIF(TenureMonths, 0), 2) AS RevenuePerTenureMonth,
    RANK() OVER (PARTITION BY MembershipType ORDER BY LifetimePaidRevenue DESC) AS RevenueRankWithinMembership
FROM member_revenue
ORDER BY LifetimePaidRevenue DESC, RevenuePerTenureMonth DESC;
