USE lab3;

-- SUBQUERY
SELECT * FROM employee; 
SELECT avg(salary) FROM employee;
SELECT * FROM employee
WHERE salary>(
    SELECT avg(salary) FROM employee
);

select c.customer_id,c.Customer_name,o.order_Amount
from customer as c
JOIN Orders as o
ON c.customer_id=o.customer_id
where o.order_amount>(
SELECT avg(orders.order_Amount) from orders);

SELECT * FROM Employee
WHERE job_desc!=
(SELECT job_desc FROM Employee
WHERE job_desc="MANAGER");

SELECT avg(salary),job_desc FROM Employee
GROUP BY job_desc
order BY AVG(salary) DESC;

-- JOINS
SELECT c.customer_id,c.Customer_name,c.Age,c.orders,o.Order_id,o.order_amount,c.Place
FROM Customer AS c
JOIN Orders AS o
ON c.customer_id=o.customer_id;

select e.Emp_id,e.emp_name,e.job_desc,e.salary,d.Department_id,d.Department_name
from employee as e
join departments as d
on e.Department_id=d.Department_id;

select p.Product_id,p.Product_name,p.Category,s.Sales_amount
from product as p
join sales as s
on p.Product_id=s.Product_id;

CREATE view Orders_Customer AS
SELECT c.customer_id,c.Customer_name,c.Age,c.orders,o.Order_id,o.order_amount,c.Place
FROM Customer AS c
JOIN Orders AS o
ON c.customer_id=o.customer_id;

select * from Orders_Customer
where Place="tamilnadu";

SELECT d.Department_id,d.Department_name,m.Manager_id,m.Manager_name
FROM departments AS d
JOIN managers as m
on d.Manager_id=m.Manager_id;

-- COMBINED
SELECT d.Department_id,d.Department_name,count(e.Emp_id)
FROM Departments AS d
left JOIN employee as e
on d.Department_id=e.Department_id
GROUP BY d.Department_id;

SELECT * FROM Employee as e
WHERE Salary>(
    SELECT avg(salary) FROM Employee as e1
    WHERE e.job_desc=e1.job_desc
)
GROUP BY job_desc,emp_id,salary;