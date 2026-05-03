# Model Card: Leakage-Aware Customer Churn Model

## Model Purpose

The churn model estimates whether a customer is likely to make no purchase in the next 90 days from a given scoring date.

## Model Type

Final selected model: `RandomForestClassifier`.

Comparison models:

- Dummy baseline
- Random Forest
- Gradient Boosting

## Prediction Target

`churned_next_90_days`: a binary label where `1` means the customer did not purchase in the 90 days after the cutoff date.

## Validation Design

The model uses a time-based snapshot design:

- Train on March 2013 and June 2013 customer snapshots.
- Test on September 2013 customer snapshots.
- Use only customer behaviour available up to the cutoff date.

This is more realistic than random splitting because it simulates future customer scoring.

## Key Features

- Recency days as of the scoring date
- Order frequency per month
- Order count
- Total quantity
- Total spend
- Total profit
- Average order value
- Profit margin
- Average order-to-invoice time gap
- Customer district code
- Tenure days

## Evaluation Summary

On the September 2013 test snapshot:

- Accuracy: **0.885**
- Precision: **0.778**
- Recall: **0.896**
- F1-score: **0.833**
- ROC-AUC: **0.953**

The dummy baseline achieved 0.681 accuracy but 0.000 recall, meaning it failed to identify churners. The Random Forest was selected because it identified most churners while maintaining strong overall performance.

## Business Use Case

The model supports retention prioritisation by assigning customers to low, medium, and high churn-risk bands. High-risk customers can be reviewed by sales or account-management teams for targeted re-engagement.

## Important Limitation

The earlier churn model achieved perfect accuracy, which was suspicious and likely caused by leakage. This improved version reduces leakage by using time-based feature cutoffs and future-window labels. It is still a portfolio model and should be validated across more time periods before production use.

## Ethical and Technical Limitations

The model should not be used for fully automated customer decisions. It should support human review. Historical transaction behaviour may not capture contract status, service issues, relationship quality, or external market context.

## Future Validation Steps

- Add more monthly cutoff snapshots.
- Compare Random Forest with XGBoost or LightGBM.
- Calibrate churn probabilities.
- Tune risk thresholds based on campaign cost and customer value.
- Add SHAP explainability.
- Monitor performance after deployment.
