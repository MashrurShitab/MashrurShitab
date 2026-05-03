# LuminaTech Sales Forecasting & Customer Churn Analytics

## 1. Business Context

LuminaTech is a retail lighting business with multi-year transactional sales data across customers, districts, products, business chains, and currencies. Management needs a clearer view of revenue performance, profitability, operational timing, and customer churn risk.

This portfolio version reframes the original academic group project into a professional business analytics case study. The goal is not only to build models, but to show how analytics can support practical decisions around sales planning, margin improvement, and customer retention.

## 2. Problem Statement

The project answers four business questions:

- Which districts, business chains, and product groups contribute most to sales and profit?
- Are customer spending and district profit-margin differences statistically meaningful?
- Can transaction features support a baseline sales prediction model?
- Can customer churn risk be predicted realistically without leaking future information?

## 3. Data Overview

The cleaned local dataset contains:

- **1,966,082** cleaned transaction rows
- **42** columns after adding engineered fields
- **4,478** unique customers after loading customer IDs consistently as text
- Invoice dates from **2012-01-02** to **2013-12-31**
- Total sales of approximately **814.9M**
- Total profit of approximately **292.3M**
- Average order-to-invoice gap of **3.53 days**

The full raw data remains local-only because of file size and academic data-sharing restrictions. A small anonymized sample is included in `data/sample/` to show the structure.

## 4. Methodology

The project follows a notebook-first workflow:

1. Clean and combine 2012 and 2013 transaction datasets.
2. Explore sales, profit, operational timing, currency, product, district, and customer acquisition trends.
3. Run statistical tests and regression models for business interpretation.
4. Build a leakage-aware sales prediction model.
5. Replace the suspicious perfect churn model with a realistic time-based churn model.

The notebooks use direct pandas, matplotlib, statsmodels, and scikit-learn code so the workflow remains easy to understand and explain.

## 5. Exploratory Insights

The EDA notebook exported charts into `visuals/` and showed that sales and profit are concentrated across a subset of districts, product types, and business chains.

Top sales districts by total sales:

- Intercompany Sales
- Sydney
- Melbourne
- Brisbane
- Perth

Top business chains by sales:

- InterGlobal Trading
- Metro Electrical Distributors
- NextGen Electrical Solutions
- UtilityWorks Group
- Nationwide Lighting Group

Profit contribution is strongest in selected product types, with item types `1`, `7`, `5`, and `6` contributing the largest profit totals in the cleaned local dataset.

## 6. Statistical Testing

Two Welch two-sample t-tests were used:

- New vs returning customer spend:
  - t-statistic: **5.99**
  - p-value: **3.61e-09**
- District 200 vs District 300 profit margin:
  - t-statistic: **5.49**
  - p-value: **3.93e-08**

These results suggest statistically significant differences in the historical data. In business terms, this supports deeper review of customer lifecycle value and district-level margin drivers.

## 7. Regression Analysis

Two OLS regression models were used for interpretation:

- Sales value explained by quantity, cost, and market segment.
- Sales value explained by cost and invoice month.

Both models produced an R-squared around **0.805-0.806**, showing that cost and related transaction features explain a large portion of historical sales value. However, the regression summaries also showed strong non-normality and possible numerical issues, so the results should be interpreted as business diagnostics rather than final production models.

## 8. Sales Prediction

The sales prediction notebook uses a leakage-aware baseline regression model. The target variable is `value_sales`, and it is explicitly excluded from model inputs.

Sales prediction results:

- RMSE: **836.29**
- MAE: **144.41**
- R-squared: **0.9198**

This is a strong baseline result, but it should still be improved with time-based validation, outlier handling, and a review of possible indirect leakage before operational forecasting use.

## 9. Customer Churn Analysis

The original academic churn model achieved perfect accuracy, which is suspicious in real-world modelling. The likely issue was leakage: churn was defined using final inactivity, while recency was also calculated from the final observed dataset.

The improved portfolio model uses a more realistic snapshot approach:

- Use customer history up to a cutoff date.
- Predict whether the customer will make no purchase in the next 90 days.
- Train on March and June 2013 snapshots.
- Test on the later September 2013 snapshot.

The test period contained:

- **4,350** customer snapshots
- **31.93%** churn rate

Model comparison:

| Model | Accuracy | Precision | Recall | F1-score | ROC-AUC |
|---|---:|---:|---:|---:|---:|
| Dummy baseline | 0.681 | 0.000 | 0.000 | 0.000 | 0.500 |
| Random Forest | **0.885** | 0.778 | **0.896** | **0.833** | **0.953** |
| Gradient Boosting | 0.878 | **0.863** | 0.736 | 0.794 | 0.952 |

The Random Forest was selected as the final model because customer retention usually values recall: it is important to identify as many likely churners as possible for follow-up.

Random Forest confusion matrix:

| | Predicted Not Churn | Predicted Churn |
|---|---:|---:|
| Actual Not Churn | 2,605 | 356 |
| Actual Churn | 144 | 1,245 |

Risk segmentation output:

| Risk band | Customers | Actual churn rate | Average predicted churn probability |
|---|---:|---:|---:|
| Low risk | 2,620 | 4.12% | 7.24% |
| Medium risk | 502 | 43.23% | 55.94% |
| High risk | 1,228 | 86.64% | 87.64% |

This is much more industry-relevant than the original perfect-accuracy model because it uses time-based validation and produces an actionable customer risk list.

## 10. Model Choice: XGBoost, Random Forest, or LSTM?

For this project, I would prefer tree-based tabular models over LSTM.

LSTM is not the best first choice because the dataset is structured transaction data, not a detailed sequential event stream. XGBoost or LightGBM would be strong industry choices for tabular churn, but they add extra dependencies. For this portfolio version, Random Forest is a strong practical choice because it is available in scikit-learn, explainable, robust, and performed well on the time-based churn test.

In a production extension, I would compare Random Forest against XGBoost or LightGBM and tune thresholds based on retention cost and expected customer value.

## 11. Business Recommendations

- Use churn risk bands to prioritise customer retention campaigns.
- Focus immediate outreach on high-risk customers, especially those with high historical spend or profit.
- Monitor medium-risk customers with lighter-touch engagement.
- Use district and product profitability analysis to review margin strategy.
- Track order-to-invoice gap as an operational service metric.
- Use sales prediction as a planning support tool only after time-based validation.

## 12. Limitations

- The full dataset is historical and does not include external factors such as promotions, market demand, competitor pricing, or account-management activity.
- The sales model still needs time-based validation before being treated as a forecasting model.
- The improved churn model is more realistic, but it still uses only three cutoff snapshots.
- Recency is valid in the improved model because it is calculated only as of the scoring date, but it should still be monitored carefully because it is closely related to churn behaviour.
- Production deployment would require probability calibration, threshold tuning, monitoring, and business cost-benefit analysis.

## 13. Future Improvements

- Compare Random Forest with XGBoost or LightGBM.
- Add rolling monthly churn snapshots for stronger validation.
- Tune the churn threshold based on campaign cost and customer value.
- Add SHAP explainability.
- Create a customer-level churn scoring table for CRM use.
- Build a Power BI, Tableau, or Streamlit dashboard.
- Add automated data validation and model monitoring.

## 14. Skills Demonstrated

Data cleaning, exploratory data analysis, statistical testing, regression modelling, leakage-aware machine learning, churn analytics, time-based validation, feature engineering, model interpretation, business reporting, and portfolio-ready project communication.
