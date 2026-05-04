# Local Export Helpers

These scripts let you finish the result-generation step without sharing a MySQL password.

## 1. Run the Database Scripts in MySQL

Run the schema and data files in MySQL Workbench in this order:

1. `schema/01_create_database.sql`
2. `schema/02_create_tables_v2.sql`
3. `schema/03_constraints_indexes.sql`
4. `data/01_insert_static_data.sql`
5. `data/02_insert_dummy_members_trainers.sql`
6. `data/03_insert_dummy_activity_payments.sql`
7. `data/04_insert_dummy_attendance.sql`

## 2. Export Analysis CSVs

From the project root, run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/export_analysis_results.ps1 -User root
```

The script prompts for your MySQL password locally and exports all 12 query outputs into `results/`.

If you want the script to run the schema/data scripts as well, use:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/export_analysis_results.ps1 -User root -RunSetup
```

## 3. Update the Recommendations Report

After CSV export, run:

```powershell
python scripts/update_recommendations_from_results.py
```

This reads `results/*.csv` and updates `reports/query_results_and_recommendations.md` with numeric summaries.
