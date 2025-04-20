SELECT c.first_name,c.last_name,pd.product_name,
AVG(
	CASE --trasforming data to include all feedback/rating 
		WHEN pr.rating = 1 THEN 1
		WHEN pr.rating = 2 THEN 2
		WHEN pr.rating = 3 THEN 3
		WHEN pr.rating = 4 THEN 4
		WHEN pr.rating = 5 THEN 5
		-- Note: Assumptions have been made based on observed data patterns and behavior.
		WHEN pr.rating BETWEEN 6 AND 10 THEN 5 -- Assuming rating 6 to 10 shows deep appreciation and love for the product.
		WHEN pr.rating >= 11 THEN 1 -- Assuming rating 11 and more are putted in frustration due to bad quality of the product.
		ELSE 0  
	END ) 
AS average_rating
FROM ProductReviews pr 
INNER JOIN Customers c ON pr.customer_id = c.customer_id --Including customers who have left at least one review
LEFT JOIN Products pd ON pr.product_id = pd.product_id
GROUP BY c.first_name,c.last_name,pd.product_name
ORDER BY pd.product_name,
		 average_rating DESC;