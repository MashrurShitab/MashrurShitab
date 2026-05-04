/*
Pulse Fitness SQL Analytics Platform
Script: 02_create_tables_v2.sql
Purpose: Create the Version 2 operational schema with attendance-aware class tracking.
Target: MySQL 8+
*/

USE PulseFitnessAnalytics;

DROP TABLE IF EXISTS ClassAttendance;
DROP TABLE IF EXISTS ClassEnrollment;
DROP TABLE IF EXISTS PersonalTrainingSession;
DROP TABLE IF EXISTS FacilityVisit;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS ClassSession;
DROP TABLE IF EXISTS FitnessClass;
DROP TABLE IF EXISTS Trainer;
DROP TABLE IF EXISTS `Member`;
DROP TABLE IF EXISTS MembershipType;
DROP TABLE IF EXISTS GymLocation;

CREATE TABLE GymLocation (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    Postcode VARCHAR(20) NOT NULL
);

CREATE TABLE MembershipType (
    MembershipTypeID INT PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL UNIQUE,
    PricePerMonth DECIMAL(10,2) NOT NULL,
    ClassLimitPerWeek INT NULL,
    IncludesFreePT BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE `Member` (
    MemberID INT PRIMARY KEY,
    FullName VARCHAR(150) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    JoinDate DATE NOT NULL,
    MembershipTypeID INT NOT NULL,
    LocationID INT NOT NULL,
    MemberStatus VARCHAR(30) NOT NULL DEFAULT 'Active',
    CONSTRAINT fk_member_membership
        FOREIGN KEY (MembershipTypeID) REFERENCES MembershipType(MembershipTypeID),
    CONSTRAINT fk_member_location
        FOREIGN KEY (LocationID) REFERENCES GymLocation(LocationID)
);

CREATE TABLE Trainer (
    TrainerID INT PRIMARY KEY,
    FullName VARCHAR(150) NOT NULL,
    Specialisation VARCHAR(100) NOT NULL,
    LocationID INT NOT NULL,
    EmploymentStatus VARCHAR(30) NOT NULL DEFAULT 'Active',
    CONSTRAINT fk_trainer_location
        FOREIGN KEY (LocationID) REFERENCES GymLocation(LocationID)
);

CREATE TABLE FitnessClass (
    ClassID INT PRIMARY KEY,
    ClassName VARCHAR(100) NOT NULL UNIQUE,
    DifficultyLevel VARCHAR(50) NOT NULL,
    DefaultDurationMinutes INT NOT NULL
);

CREATE TABLE ClassSession (
    SessionID INT PRIMARY KEY,
    ClassID INT NOT NULL,
    TrainerID INT NOT NULL,
    LocationID INT NOT NULL,
    SessionStart DATETIME NOT NULL,
    SessionEnd DATETIME NOT NULL,
    MaxCapacity INT NOT NULL,
    SessionStatus VARCHAR(30) NOT NULL DEFAULT 'Scheduled',
    CONSTRAINT fk_session_class
        FOREIGN KEY (ClassID) REFERENCES FitnessClass(ClassID),
    CONSTRAINT fk_session_trainer
        FOREIGN KEY (TrainerID) REFERENCES Trainer(TrainerID),
    CONSTRAINT fk_session_location
        FOREIGN KEY (LocationID) REFERENCES GymLocation(LocationID)
);

CREATE TABLE ClassEnrollment (
    EnrollmentID INT PRIMARY KEY,
    MemberID INT NOT NULL,
    SessionID INT NOT NULL,
    EnrollmentDate DATETIME NOT NULL,
    BookingStatus VARCHAR(30) NOT NULL DEFAULT 'Booked',
    CONSTRAINT fk_enrollment_member
        FOREIGN KEY (MemberID) REFERENCES `Member`(MemberID),
    CONSTRAINT fk_enrollment_session
        FOREIGN KEY (SessionID) REFERENCES ClassSession(SessionID),
    CONSTRAINT uq_member_session UNIQUE (MemberID, SessionID)
);

CREATE TABLE ClassAttendance (
    AttendanceID INT PRIMARY KEY,
    EnrollmentID INT NOT NULL UNIQUE,
    AttendanceStatus VARCHAR(30) NOT NULL,
    CheckInTime DATETIME NULL,
    CheckOutTime DATETIME NULL,
    CONSTRAINT fk_attendance_enrollment
        FOREIGN KEY (EnrollmentID) REFERENCES ClassEnrollment(EnrollmentID)
);

CREATE TABLE PersonalTrainingSession (
    PTSessionID INT PRIMARY KEY,
    MemberID INT NOT NULL,
    TrainerID INT NOT NULL,
    LocationID INT NOT NULL,
    SessionStart DATETIME NOT NULL,
    SessionEnd DATETIME NOT NULL,
    Rating INT NULL,
    Feedback VARCHAR(500) NULL,
    SessionStatus VARCHAR(30) NOT NULL DEFAULT 'Completed',
    CONSTRAINT fk_pt_member
        FOREIGN KEY (MemberID) REFERENCES `Member`(MemberID),
    CONSTRAINT fk_pt_trainer
        FOREIGN KEY (TrainerID) REFERENCES Trainer(TrainerID),
    CONSTRAINT fk_pt_location
        FOREIGN KEY (LocationID) REFERENCES GymLocation(LocationID)
);

CREATE TABLE FacilityVisit (
    VisitID INT PRIMARY KEY,
    MemberID INT NOT NULL,
    LocationID INT NOT NULL,
    CheckInTime DATETIME NOT NULL,
    CheckOutTime DATETIME NOT NULL,
    FacilityUsed VARCHAR(100) NOT NULL,
    CONSTRAINT fk_visit_member
        FOREIGN KEY (MemberID) REFERENCES `Member`(MemberID),
    CONSTRAINT fk_visit_location
        FOREIGN KEY (LocationID) REFERENCES GymLocation(LocationID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    MemberID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentStatus VARCHAR(30) NOT NULL,
    PaymentCategory VARCHAR(50) NOT NULL,
    CONSTRAINT fk_payment_member
        FOREIGN KEY (MemberID) REFERENCES `Member`(MemberID)
);
