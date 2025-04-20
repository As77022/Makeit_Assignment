--Assuming a table which contating the data having columns like order_id , customer_id, Product_Name 
WITH product_pairs AS (
    SELECT 
        o1.product_name AS product_name_1,
        o2.product_name AS product_name_2,
        COUNT(*) AS pair_count,
        COUNT(DISTINCT o1.order_id) AS total_orders
    FROM orders o1
    JOIN orders o2 
        ON o1.order_id = o2.order_id 
        AND o1.product_name < o2.product_name  -- Avoid duplicate pairs
    GROUP BY product_name_1, product_name_2
),
support_calc AS (
    SELECT 
        product_name_1,
        product_name_2,
        pair_count * 1.0 / total_orders AS support
    FROM product_pairs
)
SELECT 
    product_name_1, 
    product_name_2, 
    support
FROM support_calc
ORDER BY support DESC
LIMIT 10;