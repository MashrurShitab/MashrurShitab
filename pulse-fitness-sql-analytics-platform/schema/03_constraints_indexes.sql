/*
Pulse Fitness SQL Analytics Platform
Script: 03_constraints_indexes.sql
Purpose: Add business-rule constraints and query-supporting indexes.
Target: MySQL 8+
*/

USE PulseFitnessAnalytics;

ALTER TABLE MembershipType
    ADD CONSTRAINT chk_membership_price_non_negative CHECK (PricePerMonth >= 0),
    ADD CONSTRAINT chk_membership_class_limit CHECK (ClassLimitPerWeek IS NULL OR ClassLimitPerWeek >= 0);

ALTER TABLE `Member`
    ADD CONSTRAINT chk_member_status CHECK (MemberStatus IN ('Active', 'Cancelled', 'Suspended'));

ALTER TABLE Trainer
    ADD CONSTRAINT chk_trainer_status CHECK (EmploymentStatus IN ('Active', 'Inactive'));

ALTER TABLE FitnessClass
    ADD CONSTRAINT chk_class_duration CHECK (DefaultDurationMinutes > 0),
    ADD CONSTRAINT chk_class_difficulty CHECK (DifficultyLevel IN ('Beginner', 'Intermediate', 'Advanced'));

ALTER TABLE ClassSession
    ADD CONSTRAINT chk_session_end_after_start CHECK (SessionEnd > SessionStart),
    ADD CONSTRAINT chk_session_capacity CHECK (MaxCapacity > 0),
    ADD CONSTRAINT chk_session_status CHECK (SessionStatus IN ('Scheduled', 'Completed', 'Cancelled'));

ALTER TABLE ClassEnrollment
    ADD CONSTRAINT chk_booking_status CHECK (BookingStatus IN ('Booked', 'Cancelled', 'Waitlisted'));

ALTER TABLE ClassAttendance
    ADD CONSTRAINT chk_attendance_status CHECK (AttendanceStatus IN ('Present', 'Absent', 'Late', 'No-show')),
    ADD CONSTRAINT chk_attendance_checkout_after_checkin CHECK (
        CheckOutTime IS NULL OR CheckInTime IS NULL OR CheckOutTime > CheckInTime
    );

ALTER TABLE PersonalTrainingSession
    ADD CONSTRAINT chk_pt_end_after_start CHECK (SessionEnd > SessionStart),
    ADD CONSTRAINT chk_pt_rating CHECK (Rating IS NULL OR Rating BETWEEN 1 AND 5),
    ADD CONSTRAINT chk_pt_status CHECK (SessionStatus IN ('Scheduled', 'Completed', 'Cancelled', 'No-show'));

ALTER TABLE FacilityVisit
    ADD CONSTRAINT chk_visit_checkout_after_checkin CHECK (CheckOutTime > CheckInTime);

ALTER TABLE Payment
    ADD CONSTRAINT chk_payment_amount_non_negative CHECK (Amount >= 0),
    ADD CONSTRAINT chk_payment_status CHECK (PaymentStatus IN ('Paid', 'Failed', 'Refunded', 'Pending')),
    ADD CONSTRAINT chk_payment_category CHECK (PaymentCategory IN ('Membership', 'Personal Training', 'Class Fee', 'Merchandise'));

CREATE INDEX idx_payment_date ON Payment (PaymentDate);
CREATE INDEX idx_member_membership ON `Member` (MembershipTypeID);
CREATE INDEX idx_member_location ON `Member` (LocationID);
CREATE INDEX idx_visit_checkin ON FacilityVisit (CheckInTime);
CREATE INDEX idx_session_start ON ClassSession (SessionStart);
CREATE INDEX idx_attendance_status ON ClassAttendance (AttendanceStatus);
CREATE INDEX idx_payment_status ON Payment (PaymentStatus);

CREATE INDEX idx_payment_member_date ON Payment (MemberID, PaymentDate);
CREATE INDEX idx_visit_member_checkin ON FacilityVisit (MemberID, CheckInTime);
CREATE INDEX idx_session_location_start ON ClassSession (LocationID, SessionStart);
CREATE INDEX idx_enrollment_session_status ON ClassEnrollment (SessionID, BookingStatus);
