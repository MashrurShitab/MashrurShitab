/*
Pulse Fitness SQL Analytics Platform
Script: 02_insert_dummy_members_trainers.sql
Purpose: Insert trainers, curated scenario members, and supplemental members for scale.

Design choice:
The project uses curated sample records instead of complex data-generation
logic. The first 30 members are hand-authored business scenarios. Members
31-600 are generated with simple, predictable rules so the project still
demonstrates analysis at a 600-member scale.
*/

USE PulseFitnessAnalytics;

/* -------------------------------------------------------------------------
1. Trainers
--------------------------------------------------------------------------- */

INSERT INTO Trainer (TrainerID, FullName, Specialisation, LocationID, EmploymentStatus) VALUES
(1, 'Ava Mitchell', 'Yoga', 1, 'Active'),
(2, 'Noah Singh', 'Strength Training', 1, 'Active'),
(3, 'Mia Chen', 'Pilates', 2, 'Active'),
(4, 'Ethan Brooks', 'HIIT', 2, 'Active'),
(5, 'Sofia Patel', 'Spin', 3, 'Active'),
(6, 'Lucas Nguyen', 'CrossFit', 3, 'Active'),
(7, 'Isabella Wright', 'Zumba', 4, 'Active'),
(8, 'Oliver Khan', 'Functional Training', 4, 'Active'),
(9, 'Amelia Garcia', 'Personal Training', 5, 'Active'),
(10, 'Liam Johnson', 'Mobility', 5, 'Active');

/* -------------------------------------------------------------------------
2. Curated scenario members

The sample intentionally includes:
- Premium members for high-value revenue analysis.
- Basic and Student members who behave like Premium members.
- Low-engagement members for retention analysis.
- A few non-active members for status filtering.
--------------------------------------------------------------------------- */

INSERT INTO `Member` (
    MemberID,
    FullName,
    Email,
    JoinDate,
    MembershipTypeID,
    LocationID,
    MemberStatus
) VALUES
(1, 'Alex Carter', 'alex.carter@pulsefitness.example', '2024-01-12', 2, 1, 'Active'),
(2, 'Maya Thompson', 'maya.thompson@pulsefitness.example', '2024-02-03', 1, 1, 'Active'),
(3, 'Liam Wilson', 'liam.wilson@pulsefitness.example', '2024-03-18', 3, 2, 'Active'),
(4, 'Olivia Brown', 'olivia.brown@pulsefitness.example', '2024-01-29', 2, 2, 'Active'),
(5, 'Noah Davis', 'noah.davis@pulsefitness.example', '2024-04-10', 1, 3, 'Active'),
(6, 'Emma Johnson', 'emma.johnson@pulsefitness.example', '2024-05-06', 3, 3, 'Active'),
(7, 'Ethan Lee', 'ethan.lee@pulsefitness.example', '2024-02-21', 2, 4, 'Active'),
(8, 'Ava Martin', 'ava.martin@pulsefitness.example', '2024-06-14', 1, 4, 'Active'),
(9, 'Lucas White', 'lucas.white@pulsefitness.example', '2024-07-01', 3, 5, 'Active'),
(10, 'Mia Harris', 'mia.harris@pulsefitness.example', '2024-01-07', 2, 5, 'Active'),
(11, 'Chloe King', 'chloe.king@pulsefitness.example', '2024-08-12', 1, 1, 'Active'),
(12, 'Ben Scott', 'ben.scott@pulsefitness.example', '2024-09-05', 3, 2, 'Active'),
(13, 'Grace Young', 'grace.young@pulsefitness.example', '2024-02-16', 2, 3, 'Active'),
(14, 'Henry Walker', 'henry.walker@pulsefitness.example', '2024-03-09', 1, 4, 'Active'),
(15, 'Zoe Hall', 'zoe.hall@pulsefitness.example', '2024-04-25', 3, 5, 'Active'),
(16, 'Isaac Green', 'isaac.green@pulsefitness.example', '2024-01-20', 2, 1, 'Active'),
(17, 'Lily Adams', 'lily.adams@pulsefitness.example', '2024-05-13', 1, 2, 'Active'),
(18, 'Daniel Hill', 'daniel.hill@pulsefitness.example', '2024-06-02', 3, 3, 'Active'),
(19, 'Ella Baker', 'ella.baker@pulsefitness.example', '2024-03-27', 2, 4, 'Active'),
(20, 'Oscar Wright', 'oscar.wright@pulsefitness.example', '2024-07-19', 1, 5, 'Active'),
(21, 'Ruby Clark', 'ruby.clark@pulsefitness.example', '2024-02-08', 2, 1, 'Active'),
(22, 'Jack Turner', 'jack.turner@pulsefitness.example', '2024-04-04', 1, 2, 'Cancelled'),
(23, 'Sophie Allen', 'sophie.allen@pulsefitness.example', '2024-05-21', 3, 3, 'Active'),
(24, 'Leo Mitchell', 'leo.mitchell@pulsefitness.example', '2024-01-30', 2, 4, 'Active'),
(25, 'Hannah Lewis', 'hannah.lewis@pulsefitness.example', '2024-08-02', 1, 5, 'Active'),
(26, 'Adam Cooper', 'adam.cooper@pulsefitness.example', '2024-09-11', 3, 1, 'Active'),
(27, 'Natalie Ward', 'natalie.ward@pulsefitness.example', '2024-03-03', 2, 2, 'Active'),
(28, 'Ryan Price', 'ryan.price@pulsefitness.example', '2024-10-10', 1, 3, 'Suspended'),
(29, 'Sarah Bell', 'sarah.bell@pulsefitness.example', '2024-11-04', 3, 4, 'Active'),
(30, 'Tom Evans', 'tom.evans@pulsefitness.example', '2024-02-25', 2, 5, 'Active');

/* -------------------------------------------------------------------------
3. Supplemental members for portfolio-scale analysis

These rows make the dataset large enough to demonstrate joins, aggregation,
segmentation, ranking, and scorecard queries across 600 members.
--------------------------------------------------------------------------- */

INSERT INTO `Member` (
    MemberID,
    FullName,
    Email,
    JoinDate,
    MembershipTypeID,
    LocationID,
    MemberStatus
)
WITH RECURSIVE supplemental_members AS (
    SELECT 31 AS MemberID
    UNION ALL
    SELECT MemberID + 1
    FROM supplemental_members
    WHERE MemberID < 600
)
SELECT
    MemberID,
    CONCAT('Pulse Member ', LPAD(MemberID, 3, '0')) AS FullName,
    CONCAT('member', LPAD(MemberID, 3, '0'), '@pulsefitness.example') AS Email,
    DATE_ADD('2024-01-01', INTERVAL MOD(MemberID * 7, 330) DAY) AS JoinDate,
    CASE
        WHEN MOD(MemberID, 10) IN (0, 1, 2) THEN 2
        WHEN MOD(MemberID, 10) IN (3, 4, 5) THEN 3
        ELSE 1
    END AS MembershipTypeID,
    MOD(MemberID - 1, 5) + 1 AS LocationID,
    CASE
        WHEN MOD(MemberID, 97) = 0 THEN 'Cancelled'
        WHEN MOD(MemberID, 149) = 0 THEN 'Suspended'
        ELSE 'Active'
    END AS MemberStatus
FROM supplemental_members;
