# Pulse Fitness SQL Analytics Platform

![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Database Design](https://img.shields.io/badge/Database%20Design-Relational-green)
![Analytics](https://img.shields.io/badge/Analytics-Business%20SQL-orange)
![Status](https://img.shields.io/badge/Status-Portfolio%20Project-lightgrey)

*A full SQL database design and analytics project for a simulated multi-location fitness business, covering relational modelling, attendance tracking, revenue analysis, member retention, trainer performance, class utilisation, and operational efficiency.*

## Project Overview

This project designs and implements a relational SQL analytics platform for Pulse Fitness, a simulated multi-location fitness business. The system models members, memberships, trainers, classes, class sessions, attendance, facility visits, personal training, and payments. It then uses SQL analytics to answer business questions related to member retention, revenue generation, class utilisation, trainer performance, and operational efficiency.

This project is a redesigned and expanded portfolio version of an earlier individual SQL project. The portfolio version improves the ERD, adds attendance tracking, expands the business analytics layer, and includes structured query outputs with business recommendations.

## Business Problem

Pulse Fitness needs a reliable data model and analytics layer to understand which memberships generate revenue, which branches operate efficiently, where payment recovery is needed, which classes are underused, and which members may be at risk of churn.

## Project Objectives

- Design a normalized MySQL schema for a fitness business.
- Correct the Chen ERD design and remove unclear relationship arrows.
- Separate class types from scheduled class sessions.
- Add explicit attendance tracking.
- Generate realistic dummy data for analysis.
- Write 12 SQL queries from basic to expert level.
- Document insights, assumptions, and recommendations for business users.

## Tools and Technologies

- MySQL 8+
- SQL DDL and DML
- Chen notation ERD modelling
- Draw.io / diagrams.net
- Markdown documentation
- CSV query outputs

## Database Design Overview

The Version 2 schema contains 11 tables:

`GymLocation`, `MembershipType`, `Member`, `Trainer`, `FitnessClass`, `ClassSession`, `ClassEnrollment`, `ClassAttendance`, `PersonalTrainingSession`, `FacilityVisit`, and `Payment`.

The key design improvement is the attendance-aware class model:

- `FitnessClass` stores reusable class types.
- `ClassSession` stores scheduled class occurrences.
- `ClassEnrollment` stores member bookings.
- `ClassAttendance` stores actual attendance outcomes.

See `schema/schema_design_explanation.md` and `docs/data_dictionary.md` for full details.

## ERD

The corrected Chen ERD source is available at:

- `erd/pulse_fitness_chen_erd_v2_corrected.drawio`
- `erd/erd_design_notes.md`

PNG and PDF exports can be generated manually from the Draw.io file.

## Repository Structure

```text
pulse-fitness-sql-analytics-platform/
|-- README.md
|-- LICENSE
|-- schema/
|-- data/
|-- analysis/
|-- results/
|-- reports/
|-- docs/
|-- erd/
`-- archive/
```

## Analytics Workflow

Run the scripts in this order:

```sql
source schema/01_create_database.sql;
source schema/02_create_tables_v2.sql;
source schema/03_constraints_indexes.sql;
source data/01_insert_static_data.sql;
source data/02_insert_dummy_members_trainers.sql;
source data/03_insert_dummy_activity_payments.sql;
source data/04_insert_dummy_attendance.sql;
```

Then run the SQL files in `analysis/` and export outputs to `results/`.

If you prefer not to share MySQL credentials, run the setup scripts in MySQL Workbench and then export the analysis outputs locally with:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/export_analysis_results.ps1 -User root
python scripts/update_recommendations_from_results.py
```

The PowerShell script prompts for your MySQL password locally. The password does not need to be shared or stored in the repository.

## Business Questions

1. Which membership types generated the most paid revenue?
2. Which gym branches generated the highest paid revenue?
3. How much revenue was lost due to failed or refunded payments?
4. What are the busiest check-in hours by location?
5. Which classes have the highest and lowest attendance rates?
6. Which trainers deliver the most sessions and receive the highest ratings?
7. Which active paying members have visited fewer than three times recently?
8. How can members be segmented by engagement?
9. Which members are most likely to churn?
10. Which members have generated the highest lifetime revenue?
11. Which Basic or Student members should be targeted for upgrades?
12. Which gym locations are most operationally efficient?

## Skills Demonstrated

- Relational database modelling
- Chen notation ERD design
- Primary key and foreign key design
- Data integrity constraints
- Index design for analytics
- Dummy data generation
- Analytical SQL
- CTEs and window functions
- Conditional aggregation
- KPI scorecards
- Business insight communication

## Results Status

The `results/` files contain exported MySQL outputs for the 12 portfolio analysis queries. The recommendations report summarises the generated CSV results.

## Author

Shitab Mashrur
