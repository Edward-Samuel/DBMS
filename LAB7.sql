USE PLSQL;
CREATE TABLE employees(
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    dep_id INT,
    salary DECIMAL(10,2)
)AUTO_INCREMENT=1;

INSERT INTO employees (dep_id, salary)
VALUES(1,27000),(8,50000),(8,75000),(2,20000),(3,100000);
SELECT * FROM employees;
TRUNCATE TABLE employees;

CREATE TABLE products(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT
)AUTO_INCREMENT=235471;

DROP TABLE products;
INSERT INTO products(quantity)
VALUES (10),(24),(5),(37),(40);
SELECT * FROM products;
TRUNCATE TABLE products;

--PROCEDURE-1
DELIMITER //
CREATE PROCEDURE update_salary(
    IN e_id INT,
    IN inc_per DECIMAL(5,2)
)
BEGIN
    DECLARE cur_salary DECIMAL(10,2);
    DECLARE new_salary DECIMAL(10,2);
    SELECT salary INTO cur_salary FROM employees WHERE e_id=emp_id LIMIT 1;
    SET new_salary=cur_salary+(cur_salary*inc_per/100);
    UPDATE employees SET salary=new_salary WHERE e_id=emp_id;
    SELECT new_salary;
END
// DELIMITER ;
CALL update_salary(3,5);

--PROCEDURE-2
DELIMITER //
CREATE PROCEDURE dep_avg_salary(
    IN dept_id INT,
    OUT avg_salary DECIMAL(10,2)
)
BEGIN
    SELECT AVG(salary) INTO avg_salary FROM employees WHERE dep_id=dept_id;
END 
// DELIMITER ;
CALL dep_avg_salary(8,@avg_salary);
SELECT @avg_salary;

--PROCEDURE-3
DELIMITER //
CREATE PROCEDURE decr_quantity(
    IN p_id INT,
    IN stock INT
)
BEGIN
    DECLARE cur_stock INT;
    SELECT quantity INTO cur_stock FROM products WHERE product_id = p_id;
    IF cur_stock >= stock THEN
        UPDATE products SET quantity = cur_stock - stock WHERE product_id = p_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "INSUFFICIENT STOCK";
    END IF;
END 
// DELIMITER ;

SELECT * FROM products;
CALL decr_quantity(235471,1);
