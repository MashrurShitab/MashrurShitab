# Assumptions

- Pulse Fitness is a fictional business created for a SQL portfolio project.
- All member, trainer, payment, attendance, and activity data is simulated.
- Dummy data is designed to reflect plausible gym operating patterns.
- Revenue analysis is based on payment records.
- Payment status is simplified into Paid, Failed, Refunded, and Pending.
- Attendance status is simplified into Present, Late, Absent, and No-show.
- Class capacity is stored at the scheduled session level.
- A class booking does not guarantee attendance.
- Churn risk is calculated using a rule-based SQL score, not a machine learning model.
- The default analysis period is `2025-01-01` to `2025-06-30`.
- Result CSV files were generated from the MySQL analysis queries using the simulated dataset.
