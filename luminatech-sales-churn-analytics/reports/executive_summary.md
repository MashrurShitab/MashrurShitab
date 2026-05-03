# Executive Summary

## Business Context

LuminaTech needs to understand sales performance, profitability, operational efficiency, and customer churn risk across a large multi-year transaction dataset.

## Analytical Approach

The project cleans and analyses 1.97M transaction rows, generates management-level charts, runs statistical tests and regression analysis, builds a sales prediction model, and improves the churn workflow using leakage-aware time-based validation.

## Key Results

- Total cleaned sales: approximately **814.9M**
- Total cleaned profit: approximately **292.3M**
- Average order-to-invoice gap: **3.53 days**
- Sales prediction R-squared: **0.9198**
- Improved churn model accuracy: **0.885**
- Improved churn model recall: **0.896**
- Improved churn model ROC-AUC: **0.953**

## Management Implications

The improved churn model is the most important upgrade. The original perfect accuracy was not realistic, so the final version uses a business-style scoring date and predicts churn over the next 90 days. This produces customer risk bands that can support retention prioritisation.

## Final Recommendation

Use this project as a decision-support analytics workflow, not as an automated production system. The next best step is to build a customer risk scoring table and validate the models across more monthly time windows.
