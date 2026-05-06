-- 1. DATA OVERVIEW
SELECT 
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT cc_num) AS total_customers,
    COUNT(DISTINCT merchant) AS total_merchants,
    MIN(trans_date_trans_time) AS earliest_date,
    MAX(trans_date_trans_time) AS latest_date
FROM credit_card_transactions;

-- 2. FRAUD STATISTICS
SELECT 
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 4) AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END), 2) AS total_fraud_loss,
    ROUND(AVG(CASE WHEN is_fraud = 1 THEN amt END), 2) AS avg_fraud_amount
FROM credit_card_transactions;

-- 3. FRAUD BY HOUR
SELECT 
    EXTRACT(HOUR FROM trans_date_trans_time) AS hour,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 4) AS fraud_rate_pct
FROM credit_card_transactions
GROUP BY hour
ORDER BY fraud_rate_pct DESC
LIMIT 5;

-- 4. FRAUD BY DAY OF WEEK
SELECT 
    TO_CHAR(trans_date_trans_time, 'Day') AS day_name,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 4) AS fraud_rate_pct
FROM credit_card_transactions
GROUP BY day_name, EXTRACT(DOW FROM trans_date_trans_time)
ORDER BY fraud_rate_pct DESC;

-- 5. FRAUD BY AMOUNT BUCKET
SELECT 
    CASE 
        WHEN amt <= 50 THEN '0-50'
        WHEN amt <= 100 THEN '51-100'
        WHEN amt <= 250 THEN '101-250'
        WHEN amt <= 500 THEN '251-500'
        WHEN amt <= 1000 THEN '501-1000'
        ELSE '1000+'
    END AS amount_bucket,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 4) AS fraud_rate_pct
FROM credit_card_transactions
GROUP BY amount_bucket
ORDER BY MIN(amt);

-- 6. HIGHEST RISK CATEGORIES
SELECT 
    category,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 4) AS fraud_rate_pct
FROM credit_card_transactions
GROUP BY category
HAVING COUNT(*) >= 100
ORDER BY fraud_rate_pct DESC
LIMIT 10;

-- 7. FRAUD LOSS BY CATEGORY
SELECT 
    category,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END), 2) AS total_fraud_loss,
    COUNT(CASE WHEN is_fraud = 1 THEN 1 END) AS fraud_count
FROM credit_card_transactions
GROUP BY category
ORDER BY total_fraud_loss DESC
LIMIT 10;

-- 8. HIGHEST RISK STATES
SELECT 
    state,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 4) AS fraud_rate_pct
FROM credit_card_transactions
GROUP BY state
HAVING COUNT(*) >= 500
ORDER BY fraud_rate_pct DESC
LIMIT 10;

-- 9. CUSTOMER RISK SEGMENTATION
SELECT 
    CASE 
        WHEN fraud_rate > 10 THEN 'High Risk (>10%)'
        WHEN fraud_rate BETWEEN 2 AND 10 THEN 'Medium Risk (2-10%)'
        ELSE 'Low Risk (<2%)'
    END AS risk_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(transaction_count), 1) AS avg_transactions,
    ROUND(AVG(avg_amount), 2) AS avg_amount
FROM (
    SELECT 
        cc_num,
        COUNT(*) AS transaction_count,
        AVG(amt) AS avg_amount,
        SUM(is_fraud) * 100.0 / COUNT(*) AS fraud_rate
    FROM credit_card_transactions
    GROUP BY cc_num
    HAVING COUNT(*) >= 10
) t
GROUP BY risk_category;

-- 10. TOP FRAUDULENT CUSTOMERS
SELECT 
    cc_num,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END), 2) AS total_loss
FROM credit_card_transactions
GROUP BY cc_num
HAVING COUNT(*) >= 10 AND SUM(is_fraud) > 0
ORDER BY fraud_rate_pct DESC
LIMIT 10;

-- 11. HIGHEST RISK MERCHANTS
SELECT 
    merchant,
    category,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 4) AS fraud_rate_pct
FROM credit_card_transactions
GROUP BY merchant, category
HAVING COUNT(*) >= 50
ORDER BY fraud_rate_pct DESC
LIMIT 10;

-- 12. WEEKEND VS WEEKDAY
SELECT 
    CASE 
        WHEN EXTRACT(DOW FROM trans_date_trans_time) IN (0, 6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 4) AS fraud_rate_pct
FROM credit_card_transactions
GROUP BY day_type;

-- 13. MONTHLY FRAUD TREND
SELECT 
    DATE_TRUNC('month', trans_date_trans_time) AS month,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 4) AS fraud_rate_pct
FROM credit_card_transactions
GROUP BY month
ORDER BY month;

-- 14. AMOUNT PERCENTILES
SELECT 
    ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY amt), 2) AS median,
    ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY amt), 2) AS p75,
    ROUND(PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY amt), 2) AS p90,
    ROUND(PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY amt), 2) AS p95,
    ROUND(PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY amt), 2) AS p99
FROM credit_card_transactions;

-- 15. CORRELATION (amount vs fraud)
SELECT 
    CORR(amt, is_fraud) AS amount_fraud_correlation
FROM credit_card_transactions;