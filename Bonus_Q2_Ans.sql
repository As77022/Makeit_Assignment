--Assuming we have log table with columns user_id , event_name and event Timestamp
WITH funnel_counts AS (
    SELECT 
        event_name,
        COUNT(DISTINCT user_id) AS user_count
    FROM event_log
    WHERE event_name IN ('Product Page View', 'Add to Cart', 'Checkout Started', 'Order Placed')
    GROUP BY event_name
),
conversion_rates AS (
    SELECT 
        f1.event_name AS step_name,
        f1.user_count,
        CASE 
            WHEN f2.user_count IS NOT NULL THEN f1.user_count * 1.0 / f2.user_count
            ELSE NULL
        END AS conversion_rate
    FROM funnel_counts f1
    LEFT JOIN funnel_counts f2 
    ON f1.event_name = CASE 
        WHEN f1.event_name = 'Add to Cart' THEN 'Product Page View'
        WHEN f1.event_name = 'Checkout Started' THEN 'Add to Cart'
        WHEN f1.event_name = 'Order Placed' THEN 'Checkout Started'
        ELSE NULL
    END
)
SELECT * FROM conversion_rates;

-- Clickhouse specific solution with windowFunnel function 
SELECT 
    user_id,
    windowFunnel(3600)(
        event_time,
        event_name = 'Product Page View',
        event_name = 'Add to Cart',
        event_name = 'Checkout Started',
        event_name = 'Order Placed'
    ) AS funnel_stage
FROM event_log
GROUP BY user_id;