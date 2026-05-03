# LuminaTech Sales Forecasting & Customer Churn Analytics

![Python](https://img.shields.io/badge/Python-Analytics-blue)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Preparation-green)
![Scikit-learn](https://img.shields.io/badge/Scikit--learn-Machine%20Learning-orange)
![Statsmodels](https://img.shields.io/badge/Statsmodels-Regression-purple)
![Business Analytics](https://img.shields.io/badge/Business%20Analytics-Portfolio%20Project-lightgrey)

An end-to-end business analytics project using Python, statistical testing, regression analysis, sales prediction, and customer churn modelling to support strategic decision-making for a retail lighting company.

## Project Overview

This project converts multi-year transactional sales data into business insights, predictive modelling outputs, and customer retention recommendations. The workflow covers data cleaning, exploratory analysis, statistical testing, regression modelling, sales prediction, and churn-risk analysis.

This project was originally completed as part of a group analytics project during my Master of Business Analytics at Macquarie University. This portfolio version has been cleaned, restructured, documented, and reframed by me for professional presentation.

## My Contribution

My contribution included data cleaning, exploratory analysis, statistical interpretation, modelling support, business insight generation, and portfolio documentation. This GitHub version focuses on professional restructuring, reproducibility, and employer-facing communication.

## Business Problem

LuminaTech needs to understand sales performance, profitability patterns, operational efficiency, and customer churn risk across districts, products, business chains, and time periods. The goal is to translate historical transaction data into management actions for revenue growth, margin improvement, and customer retention.

## Project Objectives

- Clean and combine multi-year transactional datasets.
- Analyse sales, profit, product, district, currency, and customer acquisition trends.
- Test spending and margin differences across customer groups and districts.
- Build regression models to explain sales drivers.
- Create a baseline sales prediction model.
- Engineer customer-level churn features and train a churn classifier.
- Document limitations, leakage risks, and practical next steps.

## Tools and Technologies

Python, pandas, NumPy, matplotlib, seaborn, SciPy, statsmodels, scikit-learn, Jupyter Notebook, and Excel metadata.

## Repository Structure

```text
luminatech-sales-churn-analytics/
├── data/
│   ├── sample/
│   ├── metadata/
│   └── README_data_access.md
├── notebooks/
├── src/
├── reports/
├── docs/
├── visuals/
└── archive/
```

## Analytics Workflow

1. Data cleaning and preparation.
2. Exploratory business analysis.
3. Statistical testing and regression.
4. Sales prediction modelling.
5. Customer churn feature engineering and modelling.
6. Business interpretation and recommendations.

The notebooks are the primary analysis workflow. They are intentionally written in a clear, step-by-step style using direct pandas, matplotlib, statsmodels, and scikit-learn code so the analysis is easy to follow and explain. The `src/` folder contains only small optional helper examples.

## Key Insights

- Order-to-invoice timing can be used as an operational efficiency indicator.
- Sales and profit performance vary across customer districts, business chains, and product groups.
- Customer acquisition analysis helps separate new-customer growth from repeat-customer value.
- Regression analysis supports interpretation of transaction-level sales drivers such as cost, quantity, market segment, and timing.
- Churn analysis highlights customer recency and order frequency as practical retention signals.

## Model Summary

The sales prediction model is a baseline regression workflow for estimating `value_sales` from transaction features. The portfolio version explicitly separates `value_sales` from predictors to reduce target leakage risk.

The churn model was improved after the original workflow produced suspicious perfect accuracy. The final version uses time-based customer snapshots and predicts whether customers churn in the next 90 days. The selected Random Forest model achieved **0.885 accuracy**, **0.896 recall**, **0.833 F1-score**, and **0.953 ROC-AUC** on the later test snapshot.

## Business Recommendations

- Monitor districts and products with high sales but weaker profit contribution.
- Use order-to-invoice gap analysis to identify operational bottlenecks.
- Segment customers by recency, frequency, and value to prioritise retention campaigns.
- Use churn-risk scoring as a decision-support tool rather than an automated customer decisioning system.
- Strengthen forecasting with time-based validation before using predictions for planning.

## Limitations

- The full raw data is not included publicly due to file size and academic data-sharing restrictions.
- Baseline models use historical transaction data only and do not include market, competitor, promotion, or macroeconomic variables.
- Production forecasting should use time-based splits and leakage audits.
- Perfect or near-perfect churn accuracy should be treated as a warning sign until validated rigorously.

## How to Run

1. Create and activate a Python environment.
2. Install dependencies:

```bash
pip install -r requirements.txt
```

3. Review the sample dataset:

```text
data/sample/sample_luminatech_data.csv
```

4. Run the notebooks in order from `notebooks/`.
5. To use the full local dataset, place the original files in `raw_data/` as described in `data/README_data_access.md`.

## Portfolio Note

This repository is designed as a professional analytics case study for data analyst, business analyst, BI analyst, data scientist, data engineer, and analytics consultant roles. Contact and portfolio links can be added here before publishing.
