# Dummy Data Notes

## Purpose

The dummy data scripts create a realistic demonstration dataset for the Pulse Fitness SQL Analytics Platform. The data is simulated and designed for portfolio analytics, not for operational use.

## Generation Approach

The project uses a hybrid dummy-data approach. The first 30 members and their activity records are curated by hand so the business scenarios are easy to inspect. Members 31-600 are generated with simple SQL so the project still demonstrates analytics at portfolio scale.

The scripts create:

- 5 gym locations.
- 3 membership types: Basic, Premium, and Student.
- 6 fitness class types: Yoga, Zumba, CrossFit, Pilates, Spin, and HIIT.
- 10 trainers.
- 600 sample members.
- Class sessions across January to June 2025.
- Class enrollments and attendance outcomes.
- Facility visits across different locations and hours.
- Personal training sessions with ratings.
- Paid, failed, refunded, and pending payment records.

## Business Scenarios Supported

The data is shaped to support:

- High-engagement members with frequent visits and class attendance.
- Low-engagement and inactive members for churn-risk analysis.
- Basic and Student members who behave like Premium members.
- Failed and refunded payments for missed revenue analysis.
- Location-level differences in visits, payments, trainer activity, and attendance.
- Trainer workload and customer rating analysis.

## Assumptions

- The business and members are fictional.
- The default analysis period is `2025-01-01` to `2025-06-30`.
- Payment records are simplified for portfolio analytics.
- Churn scoring is rule-based SQL logic, not a predictive machine learning model.
- Attendance statuses are simplified to Present, Late, Absent, and No-show.
