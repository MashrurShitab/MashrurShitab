# ERD Design Notes

## Purpose

The Version 2 ERD redesign turns the original academic database concept into a cleaner operational model for a fictional multi-location fitness business.

## What Was Improved

- Relationship connectors use plain lines instead of arrows to better match Chen notation.
- Primary key attributes are marked in the diagram with underlined labels.
- Class modelling is separated into `FitnessClass` and `ClassSession`.
- Attendance tracking is represented explicitly through `ClassEnrollment` and `ClassAttendance`.
- Cardinalities are shown with `1`, `M`, and optional `0/1` markers.
- The diagram focuses on core entities and relationships so the model remains readable.

## Why ClassSession Was Added

`FitnessClass` should describe a reusable class type such as Yoga, Zumba, CrossFit, Pilates, Spin, or HIIT. A class type alone cannot answer scheduling questions such as which trainer ran the class, where it occurred, when it started, or how many members could attend.

`ClassSession` represents a scheduled occurrence of a class at a specific time, location, trainer, and capacity. This makes utilisation, attendance rate, peak scheduling, and trainer workload analysis possible.

## Why ClassAttendance Was Added

Booking a class is not the same as attending it. `ClassEnrollment` records intent to attend, while `ClassAttendance` records the actual outcome: Present, Late, Absent, or No-show.

This separation supports analytics such as attendance rate, no-show monitoring, class demand quality, and churn-risk scoring.

## Export Notes

The corrected ERD source is available at `erd/pulse_fitness_chen_erd_v2_corrected.drawio`.

PNG and PDF exports are available at:

- `erd/pulse_fitness_chen_erd_v2_corrected.png`
- `erd/pulse_fitness_chen_erd_v2_corrected.pdf`

Draw.io CLI was not available in this local environment, so the exported image/PDF were generated locally from the same Version 2 ERD structure. To create a native Draw.io export manually:

1. Open the `.drawio` file in diagrams.net or Draw.io Desktop.
2. Export as PNG to `erd/pulse_fitness_chen_erd_v2_corrected.png`.
3. Export as PDF to `erd/pulse_fitness_chen_erd_v2_corrected.pdf`.
