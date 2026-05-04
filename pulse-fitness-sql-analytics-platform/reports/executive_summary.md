# Executive Summary

## Business Context

Pulse Fitness is a fictional multi-location fitness business offering memberships, group classes, personal training, and facility access. The business needs a structured database and SQL analytics layer to understand revenue, usage, attendance, retention risk, trainer utilisation, and branch efficiency.

## Database Solution

The Version 2 database uses a normalized MySQL schema with 11 tables. The design separates members, memberships, locations, trainers, class types, scheduled class sessions, bookings, attendance outcomes, facility visits, personal training sessions, and payments.

The most important design improvement is explicit attendance tracking. Bookings are stored in `ClassEnrollment`, while actual attendance outcomes are stored in `ClassAttendance`.

## Analytics Approach

The analytics layer contains 12 SQL queries covering revenue, branch performance, payment failure, facility usage, class attendance, trainer performance, member segmentation, churn risk, lifetime value, upgrade targeting, and location efficiency.

## Expected Management Value

The project enables management to:

- Identify revenue-driving membership plans and branches.
- Prioritise payment recovery.
- Optimise staffing and facility coverage around peak usage.
- Improve class scheduling based on attendance rates.
- Recognise high-performing trainers.
- Target disengaged members before cancellation.
- Find upgrade opportunities among Basic and Student members.

## Final Recommendation

Pulse Fitness should use the database as the operational foundation for recurring monthly reporting. The next practical step is to execute the scripts in MySQL, export the result CSVs, and connect the outputs to a dashboard for executive monitoring.
