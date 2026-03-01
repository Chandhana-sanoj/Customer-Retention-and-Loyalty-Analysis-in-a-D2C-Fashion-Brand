use customer_retention_db

-- SECTION 05 : TIME TREND ANALYSIS
-- Goal: Understand how the business performs month by month.



SELECT 
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,

    -- Count of unique orders
    COUNT(DISTINCT o.order_id) AS total_orders,

    -- Count of unique customers
    COUNT(DISTINCT o.customer_id) AS total_customers,

    -- Revenue calculation
    SUM(oi.quantity * oi.price) AS total_revenue

FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id

GROUP BY 
    YEAR(o.order_date),
    MONTH(o.order_date)

ORDER BY 
    order_year,
    order_month;


-- Campaign performance across months

SELECT 
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    o.campaign_type,

    SUM(oi.quantity * oi.price) AS total_revenue

FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id

GROUP BY 
    YEAR(o.order_date),
    MONTH(o.order_date),
    o.campaign_type

ORDER BY 
    order_year,
    order_month;
