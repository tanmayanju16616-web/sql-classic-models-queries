use company;


-- Q-1: There is no product under category of 'Boats'. Hence, delete the 'Boats' entry from productlines table.
-- Now, how many rows does the ‘productlines’ table contain?

DELETE FROM productlines
WHERE productline = 'Boats';
SELECT COUNT(*) from productlines;
Select * FROM productlines;



-- Q-2: Count the entries in "orderdetails" table with "productCode" starts with S18 and "priceEach" greater than 150.

SELECT COUNT(*) 
FROM orderdetails
WHERE productCode like 'S18%' 
	AND priceEach > 150;


-- Q-3: What are the top three countries which have the maximum number of customers?
SELECT country, COUNT(*) as total_customers
FROM customers
GROUP BY country
ORDER BY total_customers DESC
LIMIT 3;






-- Q-4: What is the average credit limit for Singapore from "customers" table?

SELECT avg(creditLimit)
FROM customers
WHERE country = 'Singapore';




-- Q-5: What is the total amount to be paid by the customer named as “Euro+Shopping Channel”?
-- You need to use the “customers” and “payments” tables to answer this question.

SELECT customerName, SUM(p.amount) as total_paid
FROM customers as c
INNER JOIN payments as p
ON c.customerNumber = p.customerNumber
WHERE customerName like '%Euro%'
GROUP BY customerName;



-- Q-6: Which month has recieved the maximum aggragated payments from the customers? 
-- Q-6: What is the aggregated value of the payment recieved from that month?
SELECT month(paymentDate) as p_month, SUM(amount)as total_amount
FROM payments
GROUP BY p_month
ORDER BY total_amount DESC
LIMIT 1;




-- Q-7: Inner join:  What is the average value of credit limit corresponds to the customers which have been contacted by the employees with their office located in “Tokyo” city? 
SELECT AVG(creditLimit) as avg_credit_limit
FROM customers as c
INNER JOIN employees as e
ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN offices as o
ON e.officeCode = o.officeCode
WHERE o.office_city = 'Tokyo';


    
-- Q-8: Outer Join: What is the name of the customer which has paid the lowest amount to the company. 
SELECT c.customerName, SUM(p.amount) as total_paid
FROM customers as c
LEFT JOIN payments as p
ON c.customerNumber = p.customerNumber
GROUP BY c.customerName
HAVING total_paid IS NOT NULL
ORDER BY total_paid
LIMIT 1;