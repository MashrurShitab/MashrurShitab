# Data Dictionary

## GymLocation

Business purpose: Stores gym branch information.

| Column | Data Type | Key Type | Description | Example |
|---|---:|---|---|---|
| LocationID | INT | PK | Unique branch identifier | 1 |
| LocationName | VARCHAR(100) | Attribute | Branch name | Bankstown |
| City | VARCHAR(100) | Attribute | City or suburb | Sydney |
| State | VARCHAR(100) | Attribute | State | NSW |
| Postcode | VARCHAR(20) | Attribute | Postal code | 2000 |

## MembershipType

Business purpose: Stores subscription plan definitions.

| Column | Data Type | Key Type | Description | Example |
|---|---:|---|---|---|
| MembershipTypeID | INT | PK | Unique plan identifier | 2 |
| TypeName | VARCHAR(50) | Attribute | Plan name | Premium |
| PricePerMonth | DECIMAL(10,2) | Attribute | Monthly plan price | 60.00 |
| ClassLimitPerWeek | INT | Attribute | Weekly class limit; NULL means unlimited | NULL |
| IncludesFreePT | BOOLEAN | Attribute | Whether plan includes free PT | TRUE |

## Member

Business purpose: Stores member profile and subscription relationship.

| Column | Data Type | Key Type | Description | Example |
|---|---:|---|---|---|
| MemberID | INT | PK | Unique member identifier | 101 |
| FullName | VARCHAR(150) | Attribute | Member display name | Pulse Member 101 |
| Email | VARCHAR(150) | Attribute | Unique member email | member101@pulsefitness.example |
| JoinDate | DATE | Attribute | Membership start date | 2024-09-12 |
| MembershipTypeID | INT | FK | Links to `MembershipType` | 1 |
| LocationID | INT | FK | Home gym branch | 3 |
| MemberStatus | VARCHAR(30) | Attribute | Active, Cancelled, or Suspended | Active |

## Trainer

Business purpose: Stores trainer profile and branch relationship.

| Column | Data Type | Key Type | Description | Example |
|---|---:|---|---|---|
| TrainerID | INT | PK | Unique trainer identifier | 5 |
| FullName | VARCHAR(150) | Attribute | Trainer name | Sofia Patel |
| Specialisation | VARCHAR(100) | Attribute | Trainer expertise | Spin |
| LocationID | INT | FK | Home gym branch | 3 |
| EmploymentStatus | VARCHAR(30) | Attribute | Active or Inactive | Active |

## FitnessClass

Business purpose: Stores reusable class types.

| Column | Data Type | Key Type | Description | Example |
|---|---:|---|---|---|
| ClassID | INT | PK | Unique class type identifier | 6 |
| ClassName | VARCHAR(100) | Attribute | Class type name | HIIT |
| DifficultyLevel | VARCHAR(50) | Attribute | Beginner, Intermediate, or Advanced | Advanced |
| DefaultDurationMinutes | INT | Attribute | Standard class duration | 40 |

## ClassSession

Business purpose: Stores scheduled class occurrences.

| Column | Data Type | Key Type | Description | Example |
|---|---:|---|---|---|
| SessionID | INT | PK | Unique scheduled session identifier | 120 |
| ClassID | INT | FK | Links to `FitnessClass` | 6 |
| TrainerID | INT | FK | Trainer conducting the session | 4 |
| LocationID | INT | FK | Branch hosting the session | 2 |
| SessionStart | DATETIME | Attribute | Scheduled start time | 2025-03-14 18:00:00 |
| SessionEnd | DATETIME | Attribute | Scheduled end time | 2025-03-14 18:40:00 |
| MaxCapacity | INT | Attribute | Maximum member capacity | 18 |
| SessionStatus | VARCHAR(30) | Attribute | Scheduled, Completed, or Cancelled | Completed |

## ClassEnrollment

Business purpose: Stores member bookings into class sessions.

| Column | Data Type | Key Type | Description | Example |
|---|---:|---|---|---|
| EnrollmentID | INT | PK | Unique enrollment identifier | 5001 |
| MemberID | INT | FK | Enrolled member | 101 |
| SessionID | INT | FK | Booked class session | 120 |
| EnrollmentDate | DATETIME | Attribute | Booking timestamp | 2025-03-10 09:00:00 |
| BookingStatus | VARCHAR(30) | Attribute | Booked, Cancelled, or Waitlisted | Booked |

## ClassAttendance

Business purpose: Stores actual attendance outcome for class bookings.

| Column | Data Type | Key Type | Description | Example |
|---|---:|---|---|---|
| AttendanceID | INT | PK | Unique attendance identifier | 5001 |
| EnrollmentID | INT | FK | Links to class enrollment | 5001 |
| AttendanceStatus | VARCHAR(30) | Attribute | Present, Late, Absent, or No-show | Present |
| CheckInTime | DATETIME | Attribute | Class check-in timestamp | 2025-03-14 17:55:00 |
| CheckOutTime | DATETIME | Attribute | Class check-out timestamp | 2025-03-14 18:42:00 |

## PersonalTrainingSession

Business purpose: Stores one-to-one personal training activity.

| Column | Data Type | Key Type | Description | Example |
|---|---:|---|---|---|
| PTSessionID | INT | PK | Unique PT session identifier | 800 |
| MemberID | INT | FK | Member receiving PT | 101 |
| TrainerID | INT | FK | Trainer delivering PT | 5 |
| LocationID | INT | FK | Branch hosting PT | 3 |
| SessionStart | DATETIME | Attribute | Session start time | 2025-02-20 10:00:00 |
| SessionEnd | DATETIME | Attribute | Session end time | 2025-02-20 11:00:00 |
| Rating | INT | Attribute | Member rating from 1 to 5 | 5 |
| Feedback | VARCHAR(500) | Attribute | Optional feedback text | Great coaching |
| SessionStatus | VARCHAR(30) | Attribute | Scheduled, Completed, Cancelled, or No-show | Completed |

## FacilityVisit

Business purpose: Stores general gym facility usage.

| Column | Data Type | Key Type | Description | Example |
|---|---:|---|---|---|
| VisitID | INT | PK | Unique visit identifier | 2200 |
| MemberID | INT | FK | Visiting member | 101 |
| LocationID | INT | FK | Visited branch | 3 |
| CheckInTime | DATETIME | Attribute | Facility check-in time | 2025-04-01 07:00:00 |
| CheckOutTime | DATETIME | Attribute | Facility check-out time | 2025-04-01 08:15:00 |
| FacilityUsed | VARCHAR(100) | Attribute | Main facility used | Cardio Zone |

## Payment

Business purpose: Stores payment transactions and payment outcomes.

| Column | Data Type | Key Type | Description | Example |
|---|---:|---|---|---|
| PaymentID | INT | PK | Unique payment identifier | 3001 |
| MemberID | INT | FK | Paying member | 101 |
| PaymentDate | DATE | Attribute | Payment date | 2025-05-05 |
| Amount | DECIMAL(10,2) | Attribute | Payment amount | 60.00 |
| PaymentMethod | VARCHAR(50) | Attribute | Payment channel | Credit Card |
| PaymentStatus | VARCHAR(30) | Attribute | Paid, Failed, Refunded, or Pending | Paid |
| PaymentCategory | VARCHAR(50) | Attribute | Revenue category | Membership |
