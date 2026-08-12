# Customer Churn Prediction & Analysis

## Problem Statement
Subscription-based businesses lose significant revenue to customer churn. This project analyzes a telecom customer dataset to identify the key drivers of churn and builds machine learning models to predict which customers are likely to leave, enabling proactive retention efforts.

## Dataset
Telco Customer Churn dataset (Kaggle) — 7,043 customers, including demographics, account details (contract type, tenure, payment method), service subscriptions (internet, tech support, streaming), billing information, and churn status.

## Approach
1. Imported the raw CSV into SQL Server using SSMS
2. Cleaned the data: identified and resolved a data quality issue where 11 customers with zero tenure had blank TotalCharges values (new customers not yet billed), corrected to 0
3. Wrote exploratory SQL queries to analyze churn rate by contract type, tenure, monthly/total charges, internet service type, payment method, and add-on services
4. [To be added after Phase 4] Built and compared three classification models (Logistic Regression, Random Forest, XGBoost) in Python to predict churn and identify the strongest predictive features

## Key Findings (SQL Exploration)
- Overall churn rate is 26.54% — roughly 1 in 4 customers churned
- Contract type is the strongest churn driver identified: month-to-month customers churn at 42.7%, compared to 11.3% for one-year contracts and just 2.8% for two-year contracts
- Nearly half of customers churn within their first 12 months (47.4%), dropping to 9.5% for customers with 49+ months of tenure — churn risk is heavily front-loaded
- Fiber optic internet customers churn at 41.9%, notably higher than DSL (19.0%) or no internet service (7.4%) — a counterintuitive finding given fiber is typically the premium offering, suggesting a possible pricing or service-quality issue worth further investigation
- Electronic check users churn at 45.3%, dramatically higher than automatic payment methods like bank transfer or credit card (~15-17%), suggesting payment friction or lower customer commitment
- Customers with online security subscribed churn at 15.2%, compared to 41.6% without it
- Churned customers pay more per month on average (74.44 vs 61.27) but have much lower total lifetime charges (1,531.80 vs 2,549.91), consistent with shorter average tenure

## Tools Used
SQL Server & SSMS · Python (in progress) · scikit-learn, XGBoost (in progress)


EDWIN SUNDAY UMANA
