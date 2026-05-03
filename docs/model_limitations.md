# Model Limitations

- The sales prediction model requires strict target leakage review before operational use.
- Full production forecasting should use a time-based train-test split rather than a random split.
- Perfect or near-perfect churn accuracy should be treated cautiously because it may indicate overfitting, data leakage, or an easy classification boundary. The improved churn notebook addresses this by using time-based snapshots and future-window churn labels.
- External market variables were not included, including promotions, competitor pricing, macroeconomic conditions, and seasonality outside the transaction records.
- Model results are based on historical transaction data only.
- Outliers can influence regression coefficients and prediction performance.
- Some identifiers and categorical fields may require stronger governance before public sharing or production deployment.
- Future work should include rolling time-window validation, XGBoost or LightGBM comparison, SHAP explainability, probability calibration, monitoring, and documented data-quality checks.
