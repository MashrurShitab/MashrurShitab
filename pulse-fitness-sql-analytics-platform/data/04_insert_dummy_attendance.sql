/*
Pulse Fitness SQL Analytics Platform
Script: 04_insert_dummy_attendance.sql
Purpose: Add attendance outcomes for booked class enrollments.

Portfolio note:
Attendance is derived from enrollment records so the project can demonstrate
the difference between booking a class and actually attending it.
*/

USE PulseFitnessAnalytics;

/* -------------------------------------------------------------------------
Attendance outcomes

Rules:
- Cancelled bookings become Absent.
- A small named set of bookings become No-show.
- A small named set of bookings become Late.
- Everyone else is marked Present.
--------------------------------------------------------------------------- */

INSERT INTO ClassAttendance (
    AttendanceID,
    EnrollmentID,
    AttendanceStatus,
    CheckInTime,
    CheckOutTime
)
SELECT
    ce.EnrollmentID AS AttendanceID,
    ce.EnrollmentID,
    CASE
        WHEN ce.BookingStatus = 'Cancelled' THEN 'Absent'
        WHEN ce.EnrollmentID IN (13, 24, 38, 49) THEN 'No-show'
        WHEN ce.EnrollmentID IN (8, 20, 33, 54) THEN 'Late'
        ELSE 'Present'
    END AS AttendanceStatus,
    CASE
        WHEN ce.BookingStatus = 'Cancelled' OR ce.EnrollmentID IN (13, 24, 38, 49) THEN NULL
        WHEN ce.EnrollmentID IN (8, 20, 33, 54) THEN DATE_ADD(cs.SessionStart, INTERVAL 8 MINUTE)
        ELSE DATE_SUB(cs.SessionStart, INTERVAL 5 MINUTE)
    END AS CheckInTime,
    CASE
        WHEN ce.BookingStatus = 'Cancelled' OR ce.EnrollmentID IN (13, 24, 38, 49) THEN NULL
        ELSE DATE_ADD(cs.SessionEnd, INTERVAL 2 MINUTE)
    END AS CheckOutTime
FROM ClassEnrollment ce
JOIN ClassSession cs ON ce.SessionID = cs.SessionID
WHERE ce.BookingStatus IN ('Booked', 'Cancelled');
