use customer_retention_db

-- This script calculates core business KPIs such as total customers, total orders, total revenue,average order value, and repeat purchase rate.

-- SECTION 3: BUSINESS METRICS

-- 1. Total Customers
-- Purpose: Understand how many unique customers exist in the dataset

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customers;

-- 2. Total Orders
-- Purpose: Measure total transactions placed

SELECT COUNT(*) AS total_orders
FROM orders;

-- 3. Total Revenue

SELECT 
SUM(quantity * price) AS total_revenue
FROM order_items;

-- 4. Average Order Value (AOV)

SELECT 
SUM(quantity * price) * 1.0 / COUNT(DISTINCT order_id) AS average_order_value
FROM order_items;

-- 5. Repeat Purchase Rate
-- Purpose: Calculate percentage of customers who placed more than one order

SELECT 
ROUND(
    CAST(COUNT(*) AS FLOAT) * 100 /
    CAST((SELECT COUNT(DISTINCT customer_id) FROM orders) AS FLOAT),
    2
) AS repeat_purchase_rate_percent
FROM (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) AS repeat_customers;


