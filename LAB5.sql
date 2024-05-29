USE LAB3;
SELECT * FROM sales;
SELECT p.Product_id,p.Product_name,SUM(s.Sales_amount) AS TOTAL_SALES_AMT
FROM sales AS s
JOIN product as p
ON p.Product_id=s.Product_id
GROUP BY s.Product_id
ORDER BY Product_id;

SELECT d.Department_id,d.Department_name,AVG(e.salary) AS AVERAGE_SALARY
FROM employee AS e
RIGHT JOIN departments AS d
ON e.Department_id=d.Department_id
GROUP BY d.Department_id; 

SELECT YEAR(Order_date) AS YEAR,SUM(Order_amount) AS TOTAL_ORDER_AMT
FROM orders
GROUP BY YEAR(Order_date)
ORDER BY YEAR(Order_date);

SELECT MONTH(Order_date) AS MONTH,COUNT(MONTH(Order_date)) AS TOTAL_ORDERS
FROM orders
WHERE YEAR(Order_date)=2023
GROUP BY MONTH; 

SELECT DATE_FORMAT(Order_date,"%M %Y") AS MONTH_YEAR,p.Category
FROM sales AS s
JOIN product AS p
ON s.Product_id=p.Product_id
JOIN orders AS o
ON o.Order_id=s.Order_id;

SELECT d.Department_id,d.Department_name,AVG(Salary) AS 2023_AVG_SALARY 
FROM employee AS e
RIGHT JOIN departments AS d
ON e.Department_id=d.Department_id
WHERE YEAR(Date_joined)=2023
GROUP BY Department_id;

SELECT YEAR(o.Order_date),p.Product_id,p.Product_name,o.Order_amount
FROM sales AS s
JOIN product AS p
ON s.Product_id=p.Product_id
JOIN orders AS o
ON o.Order_id=s.Order_id
GROUP BY p.Product_id,O.Order_id,YEAR(o.Order_date)
ORDER BY YEAR(o.Order_date);

SELECT now();
SELECT CURDATE();
SELECT CURTIME();