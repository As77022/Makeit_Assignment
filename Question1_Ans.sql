WITH cte AS ( -- Created a Common Table Expression (cte) to represent the table as per output requirement
    SELECT DISTINCT c.email,  -- For unique email addresses to remove duplicate
        c.first_name, c.last_name,
        o.order_id, o.order_date, o.total_amount
    FROM Orders o
    INNER JOIN Customers c 
        ON o.customer_id = c.customer_id -- Making sure email is valid (not null, not empty, and contains '@')
        AND c.email IS NOT NULL AND c.email <> '' AND c.email LIKE '%@%'
    WHERE 
        -- Only include orders with a non-negative amount and placed in the year 2023
        o.total_amount >= 0 AND o.order_date BETWEEN '2023-01-01' AND '2023-12-31'
    ORDER BY 
        c.last_name,         -- Sort by last name alphabetically
        o.order_date DESC    -- Within each last name, show most recent orders first
)
SELECT 
    cte.first_name, cte.last_name, cte.email, cte.order_id, cte.order_date, cte.total_amount
FROM cte;
