# Data Access

The full original transaction datasets are not included in the GitHub-ready portfolio structure because they are large local files and were supplied in an academic project context.

This repository includes `data/sample/sample_luminatech_data.csv`, a small anonymized sample that preserves the original column structure for review and demonstration. Sensitive transactional identifiers such as customer, invoice, order, item, salesperson, and line identifiers have been replaced with neutral sample IDs.

To run the full analysis locally, place the original files in `raw_data/`:

- `raw_data/2012_Data.csv`
- `raw_data/2013_Data.csv`
- `raw_data/Metadata.xlsx`

The notebooks and helper modules use relative paths and can be adapted to either the sample dataset or the full local dataset.
