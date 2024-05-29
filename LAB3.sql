CREATE DATABASE LAB3;
USE LAB3;
CREATE TABLE Product(
    Product_id INT PRIMARY KEY AUTO_INCREMENT,
    Product_name VARCHAR(50),
    Category VARCHAR(50)
) AUTO_INCREMENT=1;

INSERT INTO product (Product_name, Category)
VALUES ('T-Shirt', 'Clothing'),
('Laptop', 'Electronics'),
('Coffee Mug', 'Kitchenware'),
('Headphones', 'Electronics'),
('Book', 'Stationery');
SELECT * FROM product;

CREATE TABLE Sales(
    Sales_amount FLOAT,
    Product_id INT,
    Order_id INT,
    FOREIGN KEY(Product_id) REFERENCES Product(Product_id),
    FOREIGN KEY(Order_id) REFERENCES Orders(Order_id)
);
DROP TABLE sales;
INSERT INTO sales (Sales_amount,Product_id,Order_id)
VALUES (345,3,72351),(267,2,72352),(234,2,72353),(423,5,72354),(212,1,72355),(576,3,72356),(986,5,72357);
SELECT * FROM sales;
SELECT sum(Sales_amount) TOTAL_SALES FROM sales;

CREATE TABLE Employee(
    Emp_id int primary key auto_increment,
    emp_name varchar(30),
    Department_id int,
    job_desc varchar(15),
    Salary FLOAT,
    Date_joined date,
    CONSTRAINT fk1 FOREIGN key(Department_id) REFERENCES departments(Department_id)
);
INSERT INTO employee (emp_name,Department_id,job_desc,Salary,Date_joined)
VALUES ("Olivia",2,"BILLER",20000,"2020-01-27"),
("Ethan",1,"COORDINATOR",500000,"2019-01-27"),
("Sophia",5,"ACCOUNTANT",25000,"2020-01-01"),
("Mason",2,"SALES EXECUTIVE",60000,"2021-04-01"),
("Ava",5,"MANAGER",90000,"2023-07-01"),
("Jackson",1,"COORDINATOR",45000,"2023-07-01");
SELECT * FROM employee;
SELECT AVG(Salary) AVERAGE_SALARY FROM employee;

CREATE TABLE Customer(
    Customer_id INT primary key auto_increment,
    Customer_name varchar(20),
    Age INT(2),
    Orders int,
    Place varchar(50)
)auto_increment=17490;
INSERT INTO customer (Customer_name,Age,Orders,Place)
VALUES ("Alexander",33,4,"Gujarat"),
("Emily",21,1,"Tamilnadu"),
("Sophia",25,4,"Haryana"),
("Benjamin",32,8,"Tamilnadu"),
("Olivia",30,7,"Kerala"),
("Liam",47,20,"Andhra"),
("Ava",50,10,"Karnataka");
SELECT * FROM customer;
SELECT MAX(Age) FROM customer;
SELECT MIN(Age) FROM customer;

SELECT sum(Sales_amount) 2023_Sales_amount FROM sales WHERE Year="2023";

SELECT AVG(salary) FROM employee WHERE Date_joined>"2020-01-01";

SELECT sum(orders) TN_ORDERS FROM customer WHERE Place="Tamilnadu";

SELECT Customer_name,Orders FROM customer ORDER BY Orders DESC LIMIT 5;

with MEDIAN as(
   select salary,
        row_number() over (order by salary) as row_index,
        count(*) over () as total_rows
    from Employee
)
select avg(salary) as MEDIAN_SALARY
FROM MEDIAN
where row_index in (FLOOR((total_rows+1)/2),FLOOR((total_rows+2)/2));

SELECT Category,count(Category) FROM product
GROUP BY Category
ORDER BY count(*) DESC
LIMIT 1;

CREATE TABLE Orders(
    Order_id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_id INT,
    Order_amount FLOAT,
    Order_date DATE,
    FOREIGN KEY(Customer_id) REFERENCES Customer(Customer_id)
)AUTO_INCREMENT=72351;
DROP TABLE Orders;

INSERT INTO orders (Customer_id,order_Amount,Order_date)
VALUES (17490,5782,"2022-07-13"),(17491,3526,"2023-04-15"),(17492,8632,"2021-04-19"),(17493,9743,"2024-05-09"),(17494,4341,"2021-06-09"),(17495,9112,"2023-09-03"),(17496,7322,"2023-04-25");
SELECT * FROM orders;
SELECT count(*) AS TOTAL_ORDERS FROM orders;
SELECT AVG(Order_amount) AS AVG_TOTAL_ORDERS FROM orders;

SELECT Customer.Customer_id,customer.Customer_name,orders.order_amount
FROM customer
JOIN orders ON customer.customer_id=Orders.Customer_id
ORDER BY Order_amount DESC;

CREATE TABLE Managers(
    Manager_id INT primary key auto_increment,
    Manager_name varchar(25)
);
INSERT INTO managers (Manager_name)
VALUES ("Ram"),("Gita"),("Sita"),("Muthu"),("Ravi");
SELECT * FROM managers;

CREATE TABLE Departments(
    Department_id INT PRIMARY KEY AUTO_INCREMENT,
    Department_name VARCHAR(20),
    Manager_id int,
    FOREIGN key(Manager_id) REFERENCES managers(Manager_id)
)AUTO_INCREMENT=01;
DROP TABLE departments;
INSERT INTO departments (Department_name,Manager_id)
VALUES ("Sales Development",3),("Client Relations",5),("Sales Analytics",2),("E-commerce Sales",1),("Account Management",4);
SELECT * FROM departments;