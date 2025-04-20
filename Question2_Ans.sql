SELECT 
    pd.category,
    SUM(oi.quantity * oi.item_price) AS total_revenue
FROM OrderItems oi
LEFT JOIN Products pd ON oi.product_id = pd.product_id
WHERE oi.item_price >= 1 and oi.item_price IS NOT NULL  --Excluding products where price is negetive,zero and null
AND pd.category != 'Unknown' --Excluding products where category is Unknown
AND oi.quantity BETWEEN 1 AND 10  -- Assuming per valid order the maximum quantity is 10.
GROUP BY pd.category -- To get the unique category wise total revenue
ORDER BY total_revenue DESC; --To get top performing categories.