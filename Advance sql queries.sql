-- Find the top 5 customers who generated the highest total sales amount.

SELECT c.customerName, c.customerNumber, ROUND(SUM(od.quantityOrdered*priceEach),2) as total_sales
FROM customers c 
JOIN orders o 
	ON c.customerNumber = o.customerNumber

JOIN orderdetails od
ON o.orderNumber = od.orderNumber
where o.status = 'Shipped' 
GROUP BY c.customerName, c.customerNumber
ORDER BY  total_sales DESC
LIMIT 5;

-- Display each product line with:
-- total products
-- average buy price
-- highest MSRP

SELECT pl.productLine,
       COUNT(*) AS total_products,
       ROUND(AVG(CAST(p.buyPrice AS DECIMAL(10,2))), 2) AS avg_buy_price,
       MAX(CAST(p.MSRP AS DECIMAL(10,2))) AS highest_msrp
FROM products p
JOIN productlines pl ON p.productLine = pl.productLine
WHERE p.quantityInStock <> 'NULL'
GROUP BY pl.productLine;
        

-- Find offices where the average employee count is above the overall average employees per office.

WITH office_count as 
(SELECT officeCode, 
		COUNT(employeeNumber) as total_employee_per_office 
        FROM employees 
        GROUP BY officeCode)
SELECT *
FROM office_count
WHERE total_employee_per_office  > (SELECT AVG(total_employee_per_office) 
								FROM office_count) ;

--  Show employees who manage more than 3 employees.

SELECT CONCAT(m.firstName,' ', m.lastName) as manager_name,
        COUNT(e.employeeNumber) as employee_count
FROM employees e
JOIN employees m 
	ON e.reportsTo = m.employeeNumber
GROUP BY CONCAT(m.firstName,' ', m.lastName), m.employeeNumber
HAVING COUNT(e.employeeNumber) > 3
 ;
 
 -- Find customers who never placed an order.
SELECT c.customerName,
		c.customerNumber
FROM customers c 
LEFT JOIN orders o 
	ON c.customerNumber = o.customerNumber
WHERE o.customerNumber IS NULL;

-- Find products whose buy price is greater than the average buy price of their product line.

WITH valid_products AS (
    SELECT productName, productLine,
           CAST(buyPrice AS DECIMAL(10,2)) AS buyPrice
    FROM products
    WHERE quantityInStock <> 'NULL'
)
SELECT productName, buyPrice, productLine
FROM valid_products p
WHERE buyPrice > (SELECT AVG(buyPrice)
                  FROM valid_products
                  WHERE productLine = p.productLine);
                            
-- Find customers whose total payments are greater than the average payment of all customers.

WITH total_amount as (SELECT c.customerNumber,
		c.customerName,
        SUM(p.amount) as total_payment
FROM customers c
JOIN payments p 
	ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber,
		c.customerName)
SELECT c.customerNumber,
		c.customerName,
        ta.total_payment
FROM customers c 
JOIN total_amount ta
	ON c.customerNumber = ta.customerNumber
WHERE ta.total_payment > (SELECT AVG(total_payment) FROM total_amount)
;













