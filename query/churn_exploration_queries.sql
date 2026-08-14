SELECT TOP 10 * FROM customer_churn;
GO 

SELECT * FROM customer_churn WHERE TotalCharges = '' OR TotalCharges IS NULL;
GO

--converting Null and blanks to numeric column
UPDATE customer_churn
SET TotalCharges = '0'
WHERE TRIM(TotalCharges) = '';

ALTER TABLE customer_churn
ALTER COLUMN TotalCharges FLOAT;
GO

SELECT COUNT(*) AS total_rows FROM customer_churn;
GO

/*-- checking for blank Total charges rows
SELECT customerID, tenure, MonthlyCharges, TotalCharges, Churn
FROM customer_churn
WHERE TRIM(TotalCharges) = '';

SELECT COUNT(*) AS blank_total_charges
FROM customer_churn
WHERE TRIM(TotalCharges) = '';

SELECT COUNT(*) AS zero_tenure_customers
FROM customer_churn
WHERE tenure = 0;*/

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customer_churn' AND COLUMN_NAME = 'TotalCharges';
GO

-- finding null rows
SELECT customerID, tenure, MonthlyCharges, TotalCharges, Churn
FROM customer_churn
WHERE TotalCharges IS NULL;

--comparing to tenure with totalcharges
SELECT COUNT(*) AS null_total_charges
FROM customer_churn
WHERE TotalCharges IS NULL;

SELECT COUNT(*) AS zero_tenure_customers
FROM customer_churn
WHERE tenure = 0;

UPDATE customer_churn
SET TotalCharges = 0
WHERE TotalCharges IS NULL;

--Overall churn rate
SELECT 
    Churn,
    COUNT(*) AS num_customers,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM customer_churn), 2) AS pct_of_total
FROM customer_churn
GROUP BY Churn;
GO

-- churn by contract type
SELECT 
    Contract,
    Churn,
    COUNT(*) AS num_customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY Contract), 2) AS pct_within_contract
FROM customer_churn
GROUP BY Contract, Churn
ORDER BY Contract, Churn;
GO

-- Churn by tenure bracket
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_bracket,
    Churn,
    COUNT(*) AS num_customers
FROM customer_churn
GROUP BY 
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END,
    Churn
ORDER BY tenure_bracket, Churn;
GO

-- churn by monthly charges 
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(TotalCharges), 2) AS avg_total_charges
FROM customer_churn
GROUP BY Churn;

-- Churn by internet service type
SELECT 
    InternetService,
    Churn,
    COUNT(*) AS num_customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY InternetService), 2) AS pct_within_service
FROM customer_churn
GROUP BY InternetService, Churn
ORDER BY InternetService, Churn;
GO

-- churn by payment method
SELECT 
    PaymentMethod,
    Churn,
    COUNT(*) AS num_customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY PaymentMethod), 2) AS pct_within_method
FROM customer_churn
GROUP BY PaymentMethod, Churn
ORDER BY PaymentMethod, Churn;
GO

-- does onlinne security reduce churn
SELECT 
    TechSupport,
    Churn,
    COUNT(*) AS num_customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY TechSupport), 2) AS pct_within_group
FROM customer_churn
GROUP BY TechSupport, Churn
ORDER BY TechSupport, Churn;