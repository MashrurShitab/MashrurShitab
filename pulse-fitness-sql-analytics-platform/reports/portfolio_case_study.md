# Pulse Fitness SQL Analytics Platform Case Study

## Executive Summary

This project builds a standalone SQL analytics platform for Pulse Fitness, a fictional multi-location gym business. It demonstrates database design, data integrity, dummy data generation, analytical SQL, and business recommendation writing.

## Business Context

Pulse Fitness operates across multiple branches and offers memberships, classes, personal training, and facility access. Management needs reliable reporting to understand performance across revenue, member engagement, attendance, trainer utilisation, and branch efficiency.

## Problem Statement

The business requires a normalized data model and SQL analytics framework that can answer practical operating questions. The original design did not separate scheduled class sessions from class types and did not track attendance as a first-class business event.

## Database Design Objectives

- Model the core fitness business entities.
- Enforce referential integrity through primary and foreign keys.
- Add constraints for statuses, ratings, dates, and financial values.
- Support attendance-aware class analytics.
- Keep the model clear enough for portfolio review and extensible enough for dashboards.

## Corrected ERD Design

The corrected Chen ERD removes arrow-based connectors, uses entity rectangles, relationship diamonds, attribute ovals, underlined primary keys, and clear cardinality labels.

The model adds `ClassSession` and `ClassAttendance` so the database can distinguish class definitions, scheduled sessions, member bookings, and actual attendance outcomes.

## Relational Schema Design

The schema contains 11 tables and follows normalized design principles. Many-to-many class participation is resolved through `ClassEnrollment`, while attendance outcomes are stored in `ClassAttendance`.

The schema supports both operational events and analytical reporting across revenue, visits, class activity, trainer performance, and retention risk.

## Dummy Data and Business Assumptions

The dummy data uses a hybrid approach: 30 curated scenario members plus supplemental records up to 600 members. It includes multiple locations, 10 trainers, class sessions across six months, payments, facility visits, PT sessions, bookings, and attendance records.

The data is simulated and intentionally shaped to support realistic business scenarios such as churn risk, payment failure, high engagement, low engagement, and membership upgrade opportunities.

## SQL Analytics Framework

The project includes 12 SQL queries ranging from basic aggregation to expert-level KPI scorecards. The queries use joins, date filters, conditional aggregation, CTEs, CASE logic, HAVING clauses, and window functions.

## Query Results and Insights

The result CSV files have been generated from the MySQL analysis queries. The recommendations report summarises the exported outputs and translates them into management-facing insights.

## Strategic Recommendations

- Use membership revenue reports to evaluate pricing and plan mix.
- Use payment failure analysis to prioritise recovery workflows.
- Use attendance rates to adjust class schedules and reduce no-shows.
- Use churn-risk ranking to prioritise retention outreach.
- Use upgrade targeting to identify Basic and Student members likely to accept Premium offers.
- Use the location scorecard for branch-level operational planning.

## Limitations

- The business and data are simulated.
- Churn scoring is rule based, not predictive modelling.
- Result CSVs require MySQL execution before numeric claims can be made.
- ERD PNG/PDF exports require manual export from Draw.io.

## Future Enhancements

Potential extensions include a BI dashboard, stored procedures, recurring KPI views, attendance capacity triggers, automated ETL, role-based access control, and predictive churn modelling.

## Skills Demonstrated

Relational modelling, SQL schema creation, constraints, indexes, dummy data design, analytical SQL, CTEs, window functions, KPI design, business problem framing, and executive communication.
