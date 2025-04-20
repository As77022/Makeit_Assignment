WITH 
cte AS (
    SELECT 
    	DISTINCT oi.order_id, -- Removing dublicates
        SUBSTRING_INDEX(o.shipping_address, ',', -1) AS country,-- Extracting country from shipping address
        pd.product_name,
        SUM(oi.quantity) OVER (PARTITION BY country, pd.product_name) 
        	AS total_quantity_sold -- calculate total sold quantity with windows function
    FROM OrderItems oi
    INNER JOIN Products pd ON oi.product_id = pd.product_id 
        	   AND pd.category != 'Unknown'  -- Excluding 'Unknown' category products
    LEFT JOIN Orders o ON oi.order_id = o.order_id
    WHERE oi.quantity BETWEEN 1 AND 10 ), 
cte1 AS (
	SELECT 
    	cte.country, cte.product_name, cte.total_quantity_sold,
    -- Now ranking based on the total_quantity_sold within each country
    RANK() OVER (PARTITION BY cte.country
        			ORDER BY cte.total_quantity_sold DESC
    				) AS product_rank
	FROM cte
	ORDER BY cte.country, product_rank)
SELECT 
	cte1.country, cte1.product_name, cte1.total_quantity_sold
FROM cte1 
WHERE cte1.product_rank <= 3;