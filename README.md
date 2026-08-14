# Customer Churn Prediction & Analysis

## Problem Statement
Subscription-based businesses lose significant revenue to customer churn. This project analyzes a telecom customer dataset to identify the key drivers of churn and builds machine learning models to predict which customers are likely to leave, enabling proactive retention efforts.

## Dataset
Telco Customer Churn dataset (Kaggle) — 7,043 customers, including demographics, account details (contract type, tenure, payment method), service subscriptions (internet, tech support, streaming), billing information, and churn status.

## Approach
1. Imported the raw CSV into SQL Server using SSMS
2. Cleaned the data: identified and resolved a data quality issue where 11 customers with zero tenure had blank TotalCharges values (new customers not yet billed), corrected to 0
3. Wrote exploratory SQL queries to analyze churn rate by contract type, tenure, monthly/total charges, internet service type, payment method, and add-on services
## Approach (continued)
4. Engineered features: one-hot encoded 15 categorical variables, scaled numerical features, and split data (80/20, stratified) into training and test sets
5. Built and compared three classification models: Logistic Regression, Random Forest, and XGBoost

## Model Results

| Model | Accuracy | Precision | Recall | F1 Score | ROC-AUC |
|---|---|---|---|---|---|
| Logistic Regression | 0.807 | 0.658 | 0.567 | 0.609 | 0.844 |
| Random Forest | 0.800 | 0.654 | 0.521 | 0.580 | 0.844 |
| XGBoost | 0.796 | 0.639 | 0.535 | 0.582 | 0.839 |

## Key Findings (Modeling)
- Logistic Regression, the simplest model tested, performed best or tied-best across every metric — a useful reminder that model complexity doesn't guarantee better performance, particularly on a clean, moderately-sized dataset with largely additive relationships
- All three models achieved similar ROC-AUC (~0.84), indicating consistent discriminative power regardless of algorithm choice
- Tenure and two-year contracts are the strongest churn-reducing factors; fiber optic internet service and electronic check payment are the strongest churn-increasing factors, directly confirming patterns identified in the SQL exploration phase
- The model surfaced a nuance beyond the SQL averages: after controlling for other variables, higher total charges are associated with increased churn likelihood, even though churners have lower average total charges overall — a reminder that raw averages and model-adjusted effects can tell different parts of the same story
- The model correctly identifies 212 of 374 actual churners in the test set (56.7% recall), while maintaining 65.8% precision — in a business context, this means roughly half of at-risk customers could be flagged for proactive retention outreach

## Visualizations
![Feature Importance](images/feature_importance.png)
![ROC Comparison](images/roc_comparison.png)
![Confusion Matrix](images/confusion_matrix.png)

## Tools Used
SQL Server & SSMS · Python (pandas, scikit-learn, XGBoost) · Matplotlib, Seaborn

## Future Improvements
- Hyperparameter tuning (GridSearch/RandomizedSearch) for Random Forest and XGBoost, which may close or reverse the current performance gap
- Address class imbalance (73.5% vs 26.5%) using techniques like SMOTE to potentially improve recall
- Deploy the model as a simple scoring tool to flag at-risk customers in real time

## Key Findings (SQL Exploration)
- Overall churn rate is 26.54% — roughly 1 in 4 customers churned
- Contract type is the strongest churn driver identified: month-to-month customers churn at 42.7%, compared to 11.3% for one-year contracts and just 2.8% for two-year contracts
- Nearly half of customers churn within their first 12 months (47.4%), dropping to 9.5% for customers with 49+ months of tenure — churn risk is heavily front-loaded
- Fiber optic internet customers churn at 41.9%, notably higher than DSL (19.0%) or no internet service (7.4%) — a counterintuitive finding given fiber is typically the premium offering, suggesting a possible pricing or service-quality issue worth further investigation
- Electronic check users churn at 45.3%, dramatically higher than automatic payment methods like bank transfer or credit card (~15-17%), suggesting payment friction or lower customer commitment
- Customers with online security subscribed churn at 15.2%, compared to 41.6% without it
- Churned customers pay more per month on average (74.44 vs 61.27) but have much lower total lifetime charges (1,531.80 vs 2,549.91), consistent with shorter average tenure


## AUTHOR
EDWIN SUNDAY UMANA
