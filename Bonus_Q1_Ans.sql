WITH cte AS 
(
    SELECT 
        customer_id,
        DATE_TRUNC('month', MIN(order_date)) AS cohort_month
    FROM Orders
    where total_amount >= 1 
    and order_date between '2023-01-01' and '2023-12-31'
    and shipping_address not like '%Unknown%'
    GROUP BY customer_id
),
cte1 AS (
    SELECT 
        o.customer_id,
        c.cohort_month,
        DATE_TRUNC('month', o.order_date) AS order_month,
        date_diff('month', c.cohort_month,o.order_date) AS months_since_first_order
    FROM Orders o
    JOIN cte c ON o.customer_id = c.customer_id
	where o.total_amount >= 1 
    and o.order_date between '2023-01-01' and '2023-12-31'
    and o.shipping_address not like '%Unknown%' )
SELECT 
    c.cohort_month,
    c1.months_since_first_order,
    (COUNT(DISTINCT c1.customer_id) * 100 / COUNT(DISTINCT c.customer_id)) AS retention_rate
FROM cte c
JOIN cte1 c1 ON c.customer_id = c1.customer_id
GROUP BY c.cohort_month, c1.months_since_first_order
ORDER BY c.cohort_month, c1.months_since_first_order;