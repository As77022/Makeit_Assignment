SELECT 
	pd.product_name,
	SUM(pd.price * oi.quantity) AS total_sales_amount 
FROM OrderItems oi
LEFT JOIN Orders o ON oi.order_id = o.order_id 
		  AND o.total_amount >= 1 -- Excluding negative total amounts
LEFT JOIN Products pd ON oi.product_id = pd.product_id 
		  AND pd.price >= 1 --Removing products with zero or negetive prices
INNER JOIN Promotions p ON pd.product_id = p.product_id
WHERE o.order_date BETWEEN p.start_date AND p.end_date --Valid promotion dates
    AND oi.quantity >= 1 --Removing the order items with zero or negetive quantities
GROUP BY pd.product_name
ORDER BY total_sales_amount DESC;
