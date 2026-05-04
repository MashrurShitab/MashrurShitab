/*
Pulse Fitness SQL Analytics Platform
Script: 03_insert_dummy_activity_payments.sql
Purpose: Insert readable dummy activity and payment data.

Analysis period supported: 2025-01-01 to 2025-06-30.

Design choice:
This file starts with plain INSERT ... VALUES statements for the curated
scenario records. It then adds simple supplemental payments and visits for
members 31-600 so the analytics operate on a 600-member dataset.
*/

USE PulseFitnessAnalytics;

/* -------------------------------------------------------------------------
1. Class sessions

FitnessClass stores the class type. ClassSession stores the scheduled event.
--------------------------------------------------------------------------- */

INSERT INTO ClassSession (
    SessionID, ClassID, TrainerID, LocationID,
    SessionStart, SessionEnd, MaxCapacity, SessionStatus
) VALUES
(1, 1, 1, 1, '2025-01-08 07:00:00', '2025-01-08 08:00:00', 22, 'Completed'),
(2, 2, 7, 2, '2025-01-15 18:00:00', '2025-01-15 18:45:00', 26, 'Completed'),
(3, 3, 6, 3, '2025-02-05 17:30:00', '2025-02-05 18:30:00', 18, 'Completed'),
(4, 4, 3, 4, '2025-02-19 09:00:00', '2025-02-19 09:50:00', 22, 'Completed'),
(5, 5, 5, 5, '2025-03-06 06:30:00', '2025-03-06 07:15:00', 26, 'Completed'),
(6, 6, 4, 1, '2025-03-20 18:30:00', '2025-03-20 19:10:00', 18, 'Completed'),
(7, 1, 1, 2, '2025-04-03 07:00:00', '2025-04-03 08:00:00', 22, 'Completed'),
(8, 2, 7, 3, '2025-04-17 18:00:00', '2025-04-17 18:45:00', 26, 'Completed'),
(9, 3, 6, 4, '2025-05-08 17:30:00', '2025-05-08 18:30:00', 18, 'Completed'),
(10, 4, 3, 5, '2025-05-22 09:00:00', '2025-05-22 09:50:00', 22, 'Completed'),
(11, 5, 5, 1, '2025-06-05 06:30:00', '2025-06-05 07:15:00', 26, 'Completed'),
(12, 6, 4, 2, '2025-06-19 18:30:00', '2025-06-19 19:10:00', 18, 'Completed');

/* -------------------------------------------------------------------------
2. Class enrollments

Members 2 and 3 are intentionally high-engagement Basic/Student members.
They support the upgrade-opportunity query.
--------------------------------------------------------------------------- */

INSERT INTO ClassEnrollment (
    EnrollmentID, MemberID, SessionID, EnrollmentDate, BookingStatus
) VALUES
(1, 2, 1, '2025-01-04 10:00:00', 'Booked'),
(2, 3, 1, '2025-01-04 10:05:00', 'Booked'),
(3, 1, 1, '2025-01-05 12:00:00', 'Booked'),
(4, 4, 1, '2025-01-06 08:30:00', 'Booked'),
(5, 11, 1, '2025-01-07 09:30:00', 'Cancelled'),
(6, 2, 2, '2025-01-10 10:00:00', 'Booked'),
(7, 3, 2, '2025-01-10 10:05:00', 'Booked'),
(8, 4, 2, '2025-01-12 11:00:00', 'Booked'),
(9, 7, 2, '2025-01-13 13:00:00', 'Booked'),
(10, 12, 2, '2025-01-14 15:00:00', 'Booked'),
(11, 2, 3, '2025-02-01 10:00:00', 'Booked'),
(12, 3, 3, '2025-02-01 10:05:00', 'Booked'),
(13, 5, 3, '2025-02-02 09:00:00', 'Booked'),
(14, 13, 3, '2025-02-03 12:00:00', 'Booked'),
(15, 18, 3, '2025-02-04 15:00:00', 'Waitlisted'),
(16, 2, 4, '2025-02-15 10:00:00', 'Booked'),
(17, 3, 4, '2025-02-15 10:05:00', 'Booked'),
(18, 7, 4, '2025-02-16 09:00:00', 'Booked'),
(19, 14, 4, '2025-02-17 12:00:00', 'Booked'),
(20, 19, 4, '2025-02-18 15:00:00', 'Booked'),
(21, 2, 5, '2025-03-01 10:00:00', 'Booked'),
(22, 3, 5, '2025-03-01 10:05:00', 'Booked'),
(23, 10, 5, '2025-03-02 09:00:00', 'Booked'),
(24, 15, 5, '2025-03-03 12:00:00', 'Booked'),
(25, 20, 5, '2025-03-04 15:00:00', 'Cancelled'),
(26, 2, 6, '2025-03-15 10:00:00', 'Booked'),
(27, 3, 6, '2025-03-15 10:05:00', 'Booked'),
(28, 1, 6, '2025-03-16 09:00:00', 'Booked'),
(29, 16, 6, '2025-03-17 12:00:00', 'Booked'),
(30, 21, 6, '2025-03-18 15:00:00', 'Booked'),
(31, 2, 7, '2025-03-30 10:00:00', 'Booked'),
(32, 3, 7, '2025-03-30 10:05:00', 'Booked'),
(33, 4, 7, '2025-03-31 09:00:00', 'Booked'),
(34, 17, 7, '2025-04-01 12:00:00', 'Booked'),
(35, 27, 7, '2025-04-02 15:00:00', 'Booked'),
(36, 2, 8, '2025-04-12 10:00:00', 'Booked'),
(37, 3, 8, '2025-04-12 10:05:00', 'Booked'),
(38, 5, 8, '2025-04-13 09:00:00', 'Booked'),
(39, 23, 8, '2025-04-14 12:00:00', 'Booked'),
(40, 29, 8, '2025-04-15 15:00:00', 'Waitlisted'),
(41, 2, 9, '2025-05-02 10:00:00', 'Booked'),
(42, 3, 9, '2025-05-02 10:05:00', 'Booked'),
(43, 7, 9, '2025-05-03 09:00:00', 'Booked'),
(44, 19, 9, '2025-05-04 12:00:00', 'Booked'),
(45, 24, 9, '2025-05-05 15:00:00', 'Booked'),
(46, 2, 10, '2025-05-16 10:00:00', 'Booked'),
(47, 3, 10, '2025-05-16 10:05:00', 'Booked'),
(48, 10, 10, '2025-05-17 09:00:00', 'Booked'),
(49, 25, 10, '2025-05-18 12:00:00', 'Booked'),
(50, 30, 10, '2025-05-19 15:00:00', 'Booked'),
(51, 2, 11, '2025-05-31 10:00:00', 'Booked'),
(52, 3, 11, '2025-05-31 10:05:00', 'Booked'),
(53, 1, 11, '2025-06-01 09:00:00', 'Booked'),
(54, 16, 11, '2025-06-02 12:00:00', 'Booked'),
(55, 21, 11, '2025-06-03 15:00:00', 'Booked'),
(56, 2, 12, '2025-06-14 10:00:00', 'Booked'),
(57, 3, 12, '2025-06-14 10:05:00', 'Booked'),
(58, 4, 12, '2025-06-15 09:00:00', 'Booked'),
(59, 12, 12, '2025-06-16 12:00:00', 'Booked'),
(60, 27, 12, '2025-06-17 15:00:00', 'Booked');

/* Supplemental class enrollments for members 31-600.
   Each supplemental member receives two class bookings so class attendance
   analysis reflects the full 600-member population, not only the curated
   first 30 members. */

INSERT INTO ClassEnrollment (
    EnrollmentID,
    MemberID,
    SessionID,
    EnrollmentDate,
    BookingStatus
)
WITH booking_slots AS (
    SELECT 1 AS SlotNo
    UNION ALL
    SELECT 2
)
SELECT
    60 + ROW_NUMBER() OVER (ORDER BY m.MemberID, bs.SlotNo) AS EnrollmentID,
    m.MemberID,
    CASE
        WHEN bs.SlotNo = 1 THEN MOD(m.MemberID - 1, 12) + 1
        ELSE MOD(m.MemberID + 5, 12) + 1
    END AS SessionID,
    CASE
        WHEN bs.SlotNo = 1 THEN '2025-01-03 10:00:00'
        ELSE '2025-03-03 10:00:00'
    END AS EnrollmentDate,
    CASE
        WHEN bs.SlotNo = 1 THEN 'Booked'
        WHEN MOD(m.MemberID, 97) = 0 THEN 'Cancelled'
        WHEN MOD(m.MemberID, 83) = 0 THEN 'Waitlisted'
        ELSE 'Booked'
    END AS BookingStatus
FROM `Member` m
CROSS JOIN booking_slots bs
WHERE m.MemberID BETWEEN 31 AND 600;

/* Catch-up bookings for members without an attendance-eligible class booking.
   This keeps member-level analysis complete across all 600 members. */

INSERT INTO ClassEnrollment (
    EnrollmentID,
    MemberID,
    SessionID,
    EnrollmentDate,
    BookingStatus
)
SELECT
    1200 + ROW_NUMBER() OVER (ORDER BY m.MemberID) AS EnrollmentID,
    m.MemberID,
    (
        SELECT MIN(cs.SessionID)
        FROM ClassSession cs
        WHERE NOT EXISTS (
            SELECT 1
            FROM ClassEnrollment existing
            WHERE existing.MemberID = m.MemberID
              AND existing.SessionID = cs.SessionID
        )
    ) AS SessionID,
    '2025-06-20 10:00:00' AS EnrollmentDate,
    'Booked' AS BookingStatus
FROM `Member` m
WHERE NOT EXISTS (
    SELECT 1
    FROM ClassEnrollment ce
    WHERE ce.MemberID = m.MemberID
      AND ce.BookingStatus IN ('Booked', 'Cancelled')
);

/* -------------------------------------------------------------------------
3. Membership payments

Includes paid revenue plus failed, refunded, and pending transactions.
--------------------------------------------------------------------------- */

INSERT INTO Payment (
    PaymentID, MemberID, PaymentDate, Amount,
    PaymentMethod, PaymentStatus, PaymentCategory
) VALUES
(1, 1, '2025-01-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(2, 1, '2025-02-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(3, 1, '2025-03-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(4, 1, '2025-04-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(5, 1, '2025-05-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(6, 1, '2025-06-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(7, 2, '2025-01-05', 30.00, 'Debit Card', 'Paid', 'Membership'),
(8, 2, '2025-02-05', 30.00, 'Debit Card', 'Paid', 'Membership'),
(9, 2, '2025-03-05', 30.00, 'Debit Card', 'Paid', 'Membership'),
(10, 2, '2025-04-05', 30.00, 'Debit Card', 'Paid', 'Membership'),
(11, 2, '2025-05-05', 30.00, 'Debit Card', 'Paid', 'Membership'),
(12, 2, '2025-06-05', 30.00, 'Debit Card', 'Paid', 'Membership'),
(13, 3, '2025-01-05', 25.00, 'Digital Wallet', 'Paid', 'Membership'),
(14, 3, '2025-02-05', 25.00, 'Digital Wallet', 'Paid', 'Membership'),
(15, 3, '2025-03-05', 25.00, 'Digital Wallet', 'Paid', 'Membership'),
(16, 3, '2025-04-05', 25.00, 'Digital Wallet', 'Paid', 'Membership'),
(17, 3, '2025-05-05', 25.00, 'Digital Wallet', 'Paid', 'Membership'),
(18, 3, '2025-06-05', 25.00, 'Digital Wallet', 'Paid', 'Membership'),
(19, 4, '2025-01-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(20, 4, '2025-02-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(21, 4, '2025-03-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(22, 4, '2025-04-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(23, 4, '2025-05-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(24, 4, '2025-06-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(25, 5, '2025-01-05', 30.00, 'Direct Debit', 'Paid', 'Membership'),
(26, 5, '2025-02-05', 30.00, 'Direct Debit', 'Paid', 'Membership'),
(27, 5, '2025-03-05', 30.00, 'Direct Debit', 'Failed', 'Membership'),
(28, 5, '2025-04-05', 30.00, 'Direct Debit', 'Paid', 'Membership'),
(29, 5, '2025-05-05', 30.00, 'Direct Debit', 'Paid', 'Membership'),
(30, 5, '2025-06-05', 30.00, 'Direct Debit', 'Paid', 'Membership'),
(31, 6, '2025-01-05', 25.00, 'Digital Wallet', 'Paid', 'Membership'),
(32, 6, '2025-02-05', 25.00, 'Digital Wallet', 'Paid', 'Membership'),
(33, 6, '2025-03-05', 25.00, 'Digital Wallet', 'Failed', 'Membership'),
(34, 6, '2025-04-05', 25.00, 'Digital Wallet', 'Pending', 'Membership'),
(35, 7, '2025-01-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(36, 7, '2025-02-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(37, 7, '2025-03-05', 60.00, 'Credit Card', 'Refunded', 'Membership'),
(38, 7, '2025-04-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(39, 7, '2025-05-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(40, 7, '2025-06-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(41, 8, '2025-05-05', 30.00, 'Debit Card', 'Paid', 'Membership'),
(42, 8, '2025-06-05', 30.00, 'Debit Card', 'Paid', 'Membership'),
(43, 9, '2025-05-05', 25.00, 'Digital Wallet', 'Paid', 'Membership'),
(44, 9, '2025-06-05', 25.00, 'Digital Wallet', 'Paid', 'Membership'),
(45, 10, '2025-01-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(46, 10, '2025-02-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(47, 10, '2025-03-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(48, 10, '2025-04-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(49, 10, '2025-05-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(50, 10, '2025-06-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(51, 13, '2025-05-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(52, 16, '2025-05-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(53, 19, '2025-05-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(54, 21, '2025-05-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(55, 24, '2025-05-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(56, 27, '2025-05-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(57, 30, '2025-05-05', 60.00, 'Credit Card', 'Paid', 'Membership'),
(58, 12, '2025-05-05', 25.00, 'Debit Card', 'Failed', 'Membership'),
(59, 15, '2025-05-05', 25.00, 'Debit Card', 'Paid', 'Membership'),
(60, 20, '2025-05-05', 30.00, 'Debit Card', 'Refunded', 'Membership');

/* Supplemental payments for members 31-600. */

INSERT INTO Payment (
    PaymentID,
    MemberID,
    PaymentDate,
    Amount,
    PaymentMethod,
    PaymentStatus,
    PaymentCategory
)
WITH RECURSIVE payment_months AS (
    SELECT 0 AS MonthOffset
    UNION ALL
    SELECT MonthOffset + 1
    FROM payment_months
    WHERE MonthOffset < 5
)
SELECT
    60 + ROW_NUMBER() OVER (ORDER BY m.MemberID, pm.MonthOffset) AS PaymentID,
    m.MemberID,
    DATE_ADD('2025-01-05', INTERVAL pm.MonthOffset MONTH) AS PaymentDate,
    mt.PricePerMonth AS Amount,
    CASE MOD(m.MemberID + pm.MonthOffset, 4)
        WHEN 0 THEN 'Credit Card'
        WHEN 1 THEN 'Debit Card'
        WHEN 2 THEN 'Direct Debit'
        ELSE 'Digital Wallet'
    END AS PaymentMethod,
    CASE
        WHEN MOD(m.MemberID + pm.MonthOffset, 89) = 0 THEN 'Refunded'
        WHEN MOD(m.MemberID + pm.MonthOffset, 43) = 0 THEN 'Failed'
        WHEN MOD(m.MemberID + pm.MonthOffset, 71) = 0 THEN 'Pending'
        ELSE 'Paid'
    END AS PaymentStatus,
    'Membership' AS PaymentCategory
FROM `Member` m
JOIN MembershipType mt ON m.MembershipTypeID = mt.MembershipTypeID
CROSS JOIN payment_months pm
WHERE m.MemberID BETWEEN 31 AND 600;

/* -------------------------------------------------------------------------
4. Facility visits

Members 2 and 3 have high visit volume for upgrade targeting.
Members 5 and 6 have low or old activity for churn-risk analysis.
--------------------------------------------------------------------------- */

INSERT INTO FacilityVisit (
    VisitID, MemberID, LocationID, CheckInTime, CheckOutTime, FacilityUsed
) VALUES
(1, 2, 1, '2025-01-09 07:00:00', '2025-01-09 08:15:00', 'Cardio Zone'),
(2, 2, 1, '2025-01-22 18:00:00', '2025-01-22 19:15:00', 'Weights Area'),
(3, 2, 1, '2025-02-06 07:00:00', '2025-02-06 08:15:00', 'Functional Zone'),
(4, 2, 1, '2025-02-20 18:00:00', '2025-02-20 19:15:00', 'Weights Area'),
(5, 2, 1, '2025-03-07 07:00:00', '2025-03-07 08:15:00', 'Cardio Zone'),
(6, 2, 1, '2025-04-04 18:00:00', '2025-04-04 19:15:00', 'Functional Zone'),
(7, 2, 1, '2025-05-09 07:00:00', '2025-05-09 08:15:00', 'Weights Area'),
(8, 2, 1, '2025-06-06 18:00:00', '2025-06-06 19:15:00', 'Cardio Zone'),
(9, 3, 2, '2025-01-10 07:00:00', '2025-01-10 08:15:00', 'Cardio Zone'),
(10, 3, 2, '2025-01-24 18:00:00', '2025-01-24 19:15:00', 'Weights Area'),
(11, 3, 2, '2025-02-07 07:00:00', '2025-02-07 08:15:00', 'Functional Zone'),
(12, 3, 2, '2025-02-21 18:00:00', '2025-02-21 19:15:00', 'Weights Area'),
(13, 3, 2, '2025-03-08 07:00:00', '2025-03-08 08:15:00', 'Cardio Zone'),
(14, 3, 2, '2025-04-05 18:00:00', '2025-04-05 19:15:00', 'Functional Zone'),
(15, 3, 2, '2025-05-10 07:00:00', '2025-05-10 08:15:00', 'Weights Area'),
(16, 3, 2, '2025-06-07 18:00:00', '2025-06-07 19:15:00', 'Cardio Zone'),
(17, 1, 1, '2025-05-15 07:00:00', '2025-05-15 08:15:00', 'Weights Area'),
(18, 1, 1, '2025-06-10 07:00:00', '2025-06-10 08:15:00', 'Cardio Zone'),
(19, 4, 2, '2025-05-20 18:00:00', '2025-05-20 19:15:00', 'Cardio Zone'),
(20, 4, 2, '2025-06-12 18:00:00', '2025-06-12 19:15:00', 'Weights Area'),
(21, 5, 3, '2025-01-18 09:00:00', '2025-01-18 10:15:00', 'Cardio Zone'),
(22, 6, 3, '2025-02-12 09:00:00', '2025-02-12 10:15:00', 'Pool'),
(23, 7, 4, '2025-05-12 07:00:00', '2025-05-12 08:15:00', 'Weights Area'),
(24, 7, 4, '2025-06-14 07:00:00', '2025-06-14 08:15:00', 'Functional Zone'),
(25, 10, 5, '2025-05-17 18:00:00', '2025-05-17 19:15:00', 'Cardio Zone'),
(26, 10, 5, '2025-06-16 18:00:00', '2025-06-16 19:15:00', 'Weights Area'),
(27, 13, 3, '2025-05-18 07:00:00', '2025-05-18 08:15:00', 'Functional Zone'),
(28, 16, 1, '2025-06-04 07:00:00', '2025-06-04 08:15:00', 'Cardio Zone'),
(29, 19, 4, '2025-05-19 18:00:00', '2025-05-19 19:15:00', 'Weights Area'),
(30, 21, 1, '2025-06-11 18:00:00', '2025-06-11 19:15:00', 'Functional Zone'),
(31, 24, 4, '2025-05-21 07:00:00', '2025-05-21 08:15:00', 'Cardio Zone'),
(32, 27, 2, '2025-06-13 07:00:00', '2025-06-13 08:15:00', 'Weights Area'),
(33, 30, 5, '2025-05-23 18:00:00', '2025-05-23 19:15:00', 'Cardio Zone');

/* Supplemental visits for members 31-600.
   Each active supplemental member receives four recent visits so that the
   underutilised-member query is driven by the named scenario members above,
   while the wider dataset still supports location and usage analysis. */

INSERT INTO FacilityVisit (
    VisitID,
    MemberID,
    LocationID,
    CheckInTime,
    CheckOutTime,
    FacilityUsed
)
WITH visit_slots AS (
    SELECT 1 AS VisitSlot, TIMESTAMP('2025-05-08 07:00:00') AS BaseCheckIn
    UNION ALL
    SELECT 2, TIMESTAMP('2025-05-23 18:00:00')
    UNION ALL
    SELECT 3, TIMESTAMP('2025-06-12 07:00:00')
    UNION ALL
    SELECT 4, TIMESTAMP('2025-06-24 18:00:00')
)
SELECT
    33 + ROW_NUMBER() OVER (ORDER BY m.MemberID, vs.VisitSlot) AS VisitID,
    m.MemberID,
    m.LocationID,
    DATE_ADD(vs.BaseCheckIn, INTERVAL MOD(m.MemberID, 5) DAY) AS CheckInTime,
    DATE_ADD(DATE_ADD(vs.BaseCheckIn, INTERVAL MOD(m.MemberID, 5) DAY), INTERVAL 75 MINUTE) AS CheckOutTime,
    CASE vs.VisitSlot
        WHEN 1 THEN 'Cardio Zone'
        WHEN 2 THEN 'Weights Area'
        ELSE 'Functional Zone'
    END AS FacilityUsed
FROM `Member` m
CROSS JOIN visit_slots vs
WHERE m.MemberID BETWEEN 31 AND 600
  AND m.MemberStatus = 'Active';

/* -------------------------------------------------------------------------
5. Personal training sessions

Enough PT records are included for trainer workload and rating analysis.
--------------------------------------------------------------------------- */

INSERT INTO PersonalTrainingSession (
    PTSessionID, MemberID, TrainerID, LocationID,
    SessionStart, SessionEnd, Rating, Feedback, SessionStatus
) VALUES
(1, 2, 1, 1, '2025-01-25 10:00:00', '2025-01-25 11:00:00', 5, 'Strong progress and consistent attendance.', 'Completed'),
(2, 3, 1, 2, '2025-02-08 10:00:00', '2025-02-08 11:00:00', 5, 'Excellent engagement and class participation.', 'Completed'),
(3, 1, 1, 1, '2025-03-15 10:00:00', '2025-03-15 11:00:00', 4, 'Good strength improvement.', 'Completed'),
(4, 4, 5, 2, '2025-01-29 11:00:00', '2025-01-29 12:00:00', 4, 'Solid PT session.', 'Completed'),
(5, 7, 5, 4, '2025-02-26 11:00:00', '2025-02-26 12:00:00', 5, 'Excellent motivation and technique.', 'Completed'),
(6, 10, 5, 5, '2025-03-26 11:00:00', '2025-03-26 12:00:00', 5, 'High satisfaction session.', 'Completed'),
(7, 13, 5, 3, '2025-04-23 11:00:00', '2025-04-23 12:00:00', 4, 'Good coaching outcome.', 'Completed'),
(8, 16, 5, 1, '2025-05-28 11:00:00', '2025-05-28 12:00:00', 5, 'Very positive training feedback.', 'Completed'),
(9, 19, 6, 4, '2025-03-12 13:00:00', '2025-03-12 14:00:00', 3, 'Needs more tailored programming.', 'Completed'),
(10, 24, 6, 4, '2025-04-16 13:00:00', '2025-04-16 14:00:00', 4, 'Good conditioning work.', 'Completed'),
(11, 27, 6, 2, '2025-05-14 13:00:00', '2025-05-14 14:00:00', 4, 'Consistent strength progression.', 'Completed'),
(12, 30, 6, 5, '2025-06-18 13:00:00', '2025-06-18 14:00:00', 5, 'Strong client satisfaction.', 'Completed');

/* Supplemental PT sessions for a broader member sample.
   Not every member uses personal training, but this adds PT activity beyond
   the curated scenario members for more realistic trainer utilisation. */

INSERT INTO PersonalTrainingSession (
    PTSessionID,
    MemberID,
    TrainerID,
    LocationID,
    SessionStart,
    SessionEnd,
    Rating,
    Feedback,
    SessionStatus
)
SELECT
    12 + ROW_NUMBER() OVER (ORDER BY m.MemberID) AS PTSessionID,
    m.MemberID,
    MOD(m.MemberID, 10) + 1 AS TrainerID,
    m.LocationID,
    DATE_ADD(
        TIMESTAMP('2025-02-01 10:00:00'),
        INTERVAL MOD(m.MemberID * 3, 130) DAY
    ) AS SessionStart,
    DATE_ADD(
        DATE_ADD(
            TIMESTAMP('2025-02-01 10:00:00'),
            INTERVAL MOD(m.MemberID * 3, 130) DAY
        ),
        INTERVAL 60 MINUTE
    ) AS SessionEnd,
    CASE
        WHEN MOD(m.MemberID, 19) = 0 THEN 3
        WHEN MOD(m.MemberID, 7) = 0 THEN 5
        ELSE 4
    END AS Rating,
    'Supplemental PT feedback for scaled portfolio analysis.' AS Feedback,
    'Completed' AS SessionStatus
FROM `Member` m
WHERE m.MemberID BETWEEN 31 AND 600
  AND m.MemberStatus = 'Active'
  AND MOD(m.MemberID, 5) = 0;
