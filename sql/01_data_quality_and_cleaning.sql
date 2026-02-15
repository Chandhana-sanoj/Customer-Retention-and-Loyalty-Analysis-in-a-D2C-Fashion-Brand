use customer_retention_db

-- Description: This script validates data integrity, checks missing values,detects duplicates, and standardizes fields for analysis.

-- SECTION 1: DATA QUALITY AUDIT

-- Validate row counts after loading CSV files

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;

-- Check missing acquisition channel

SELECT COUNT(*) AS missing_acquisition_channel
FROM customers
WHERE acquisition_channel IS NULL;

-- Check missing campaign type

SELECT COUNT(*) AS missing_campaign_type
FROM orders
WHERE campaign_type IS NULL;

-- Check duplicate customers

SELECT customer_id, COUNT(*) 
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check duplicate orders

SELECT order_id, COUNT(*) 
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Validate order date range

SELECT 
MIN(order_date) AS earliest_order,
MAX(order_date) AS latest_order
FROM orders;

-- Inspect city values

SELECT city, COUNT(*) 
FROM customers
GROUP BY city
ORDER BY COUNT(*) DESC;

-- SECTION 2: DATA CLEANING

-- Standardize city names

UPDATE customers
SET city = 'Kochi'
WHERE city IN ('Cochin', 'Kochi ');

-- Replace NULL campaign types with Organic

UPDATE orders
SET campaign_type = 'Organic'
WHERE campaign_type IS NULL;

SELECT COUNT(*) 
FROM orders
WHERE campaign_type IS NULL;

 