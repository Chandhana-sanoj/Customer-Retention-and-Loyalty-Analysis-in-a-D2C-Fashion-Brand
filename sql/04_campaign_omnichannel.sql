use customer_retention_db

-- SECTION 04: CAMPAIGN OMNICHANNEL ANALYSIS
-- DESCRIPTION:This script analyzes campaign performance and customer omnichannel behavior.


-- Revenue and orders by campaign type

SELECT
    o.campaign_type,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.campaign_type
ORDER BY total_revenue DESC;


-- Repeat customers by campaign type

SELECT
    campaign_type,
    COUNT(DISTINCT customer_id) AS repeat_customers
FROM (
    SELECT
        customer_id,
        campaign_type,
        COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id, campaign_type
    HAVING COUNT(order_id) > 1
) t
GROUP BY campaign_type
ORDER BY repeat_customers DESC;


-- Customers by channel usage

SELECT
    channel_type,
    COUNT(*) AS number_of_customers
FROM (
    SELECT
        customer_id,
        CASE
            WHEN COUNT(DISTINCT order_channel) = 1 
                 AND MAX(order_channel) = 'Online' THEN 'Online Only'

            WHEN COUNT(DISTINCT order_channel) = 1 
                 AND MAX(order_channel) = 'Store' THEN 'Store Only'

            ELSE 'Omnichannel'
        END AS channel_type
    FROM orders
    GROUP BY customer_id
) t
GROUP BY channel_type
ORDER BY number_of_customers DESC;


-- Revenue by channel

SELECT
    order_channel,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY order_channel;

