# Schema Design Explanation

## Design Goal

The Version 2 schema models Pulse Fitness as a multi-location fitness business with memberships, trainers, reusable class types, scheduled class sessions, class bookings, attendance outcomes, facility visits, personal training sessions, and payments.

The schema is designed for analytical SQL while still preserving operational data integrity.

## Normalisation

The design separates stable reference data from transactional activity:

- `MembershipType` stores plan definitions instead of repeating plan price and plan rules on every member.
- `GymLocation` stores branch data once and links to members, trainers, visits, sessions, and PT activity.
- `FitnessClass` stores reusable class definitions, while `ClassSession` stores each scheduled class event.
- `Payment`, `FacilityVisit`, `PersonalTrainingSession`, `ClassEnrollment`, and `ClassAttendance` store business events.

This reduces duplication and supports reliable joins across revenue, usage, attendance, and retention analysis.

## Many-to-Many Resolution

Members can enrol in many class sessions, and each class session can have many enrolled members. This many-to-many relationship is resolved through `ClassEnrollment`.

Attendance is then recorded separately in `ClassAttendance`, which allows the database to distinguish between a booking and the actual attendance outcome.

## Attendance Tracking

The attendance-aware class model uses four tables:

- `FitnessClass`: class type, such as Yoga or HIIT.
- `ClassSession`: scheduled occurrence with trainer, location, date/time, and capacity.
- `ClassEnrollment`: booking or waitlist record for a member and session.
- `ClassAttendance`: actual attendance result for an enrollment.

This supports attendance rates, no-show analysis, trainer utilisation, class demand analysis, and churn-risk scoring.

## Analytical Support

The schema supports:

- Revenue by membership type and location.
- Payment failure monitoring.
- Peak check-in hour analysis.
- Class attendance and no-show reporting.
- Trainer workload and rating analysis.
- Member engagement segmentation.
- Churn-risk scoring.
- Upgrade opportunity detection.
- Location efficiency scorecards.
