# Methodology

## Data Preparation

The project combines 2012 and 2013 transaction files, standardises date fields, removes redundant fields, normalises currency labels, excludes invalid district and zero-sales records where appropriate, and creates profit and processing-time fields.

The portfolio notebooks keep these steps visible in direct pandas code rather than hiding them behind advanced helper functions. This makes the workflow easier to review, run, and explain in an interview.

## Exploratory Analysis

EDA examines sales and profit performance across time, district, business chain, product type, currency, and customer acquisition cohorts. Charts are exported to `visuals/` when plotting dependencies are installed.

## Statistical Testing

Two-sample tests compare new versus returning customer spend and selected district profit margins. These tests are used to support business questions, not to replace commercial judgement.

## Regression Analysis

Regression models assess how cost, quantity, market segment, and invoice month relate to sales value. The goal is interpretability and diagnostic insight into sales drivers.

## Sales Prediction

A baseline regression model predicts `value_sales` using transaction features. The portfolio version removes the target from predictors and clearly documents the need for leakage checks and time-based validation.

## Churn Analysis

Customer-level features are engineered from transaction history, including recency, order frequency, spend, profit, value quantity, and processing time. The improved churn workflow uses cutoff-date snapshots: features are created only from customer behaviour available before the cutoff, and churn is defined as no purchase in the following 90 days.

This avoids the main weakness of the original perfect-accuracy churn model, where the model was likely using information too close to the target definition.

## Business Interpretation

Outputs are interpreted as decision-support evidence for sales planning, margin review, operational monitoring, and customer retention strategy.
