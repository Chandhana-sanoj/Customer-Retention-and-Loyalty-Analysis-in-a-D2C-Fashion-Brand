use customer_retention_db

-- SECTION 03: RETENTION AND RFM ANALYSIS
-- Objective:Identify customer behavior using Recency, Frequency, and Monetary metrics
-- and segments customers based on purchasing behavior.

-- Calculate Recency, Frequency, Monetary base metrics

SELECT
    o.customer_id,
    MAX(o.order_date) AS last_purchase_date,
    COUNT(DISTINCT o.order_id) AS frequency,
    SUM(oi.quantity * oi.price) AS monetary_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY monetary_value DESC;


-- Calculate recency in days

SELECT
    r.customer_id,
    DATEDIFF(DAY, r.last_purchase_date, max_date.max_order_date) AS recency_days,
    r.frequency,
    r.monetary_value
FROM (
    SELECT
        o.customer_id,
        MAX(o.order_date) AS last_purchase_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(oi.quantity * oi.price) AS monetary_value
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
) r
CROSS JOIN (
    SELECT MAX(order_date) AS max_order_date FROM orders
) max_date;


-- verify recency calculations and customer activity


SELECT TOP 20 *
FROM (
    SELECT
        r.customer_id,
        DATEDIFF(DAY, r.last_purchase_date, max_date.max_order_date) AS recency_days,
        r.frequency,
        r.monetary_value
    FROM (
        SELECT
            o.customer_id,
            MAX(o.order_date) AS last_purchase_date,
            COUNT(DISTINCT o.order_id) AS frequency,
            SUM(oi.quantity * oi.price) AS monetary_value
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        GROUP BY o.customer_id
    ) r
    CROSS JOIN (
        SELECT MAX(order_date) AS max_order_date FROM orders
    ) max_date
) t
ORDER BY recency_days ASC;


-- Customer Segmentation using RFM
-- Purpose: Classify customers into behavioral segments

SELECT
    r.customer_id,
    r.recency_days,
    r.frequency,
    r.monetary_value,

    CASE
        WHEN r.frequency >= 3 AND r.recency_days <= 60 THEN 'Loyal'
        WHEN r.frequency = 2 THEN 'Occasional'
        WHEN r.recency_days > 90 THEN 'At Risk'
        ELSE 'New / Low Activity'
    END AS customer_segment

FROM (
    SELECT
        r.customer_id,
        DATEDIFF(DAY, r.last_purchase_date, max_date.max_order_date) AS recency_days,
        r.frequency,
        r.monetary_value
    FROM (
        SELECT
            o.customer_id,
            MAX(o.order_date) AS last_purchase_date,
            COUNT(DISTINCT o.order_id) AS frequency,
            SUM(oi.quantity * oi.price) AS monetary_value
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        GROUP BY o.customer_id
    ) r
    CROSS JOIN (
        SELECT MAX(order_date) AS max_order_date FROM orders
    ) max_date
) r;


-- Count customers per segment

SELECT
    customer_segment,
    COUNT(*) AS number_of_customers
FROM (SELECT
    r.customer_id,
    r.recency_days,
    r.frequency,
    r.monetary_value,

    CASE
        WHEN r.frequency >= 3 AND r.recency_days <= 60 THEN 'Loyal'
        WHEN r.frequency = 2 THEN 'Occasional'
        WHEN r.recency_days > 90 THEN 'At Risk'
        ELSE 'New / Low Activity'
    END AS customer_segment

FROM (
    SELECT
        r.customer_id,
        DATEDIFF(DAY, r.last_purchase_date, max_date.max_order_date) AS recency_days,
        r.frequency,
        r.monetary_value
    FROM (
        SELECT
            o.customer_id,
            MAX(o.order_date) AS last_purchase_date,
            COUNT(DISTINCT o.order_id) AS frequency,
            SUM(oi.quantity * oi.price) AS monetary_value
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        GROUP BY o.customer_id
    ) r
    CROSS JOIN (
        SELECT MAX(order_date) AS max_order_date FROM orders
    ) max_date
) r
) t
GROUP BY customer_segment;
