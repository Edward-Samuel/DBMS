USE LAB8;
CREATE TABLE employee(
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
)AUTO_INCREMENT=38741;

INSERT INTO employee(name)
VALUES("Ram"),("Ravi"),("Muthu"),("Sita"),("Geetha");
SELECT * FROM employee;

DROP FUNCTION cal_salary;
DELIMITER //
CREATE FUNCTION cal_salary(
    hrs_worked DECIMAL(10,2),
    hr_rate DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_salary DECIMAL(10,2);
    SET total_salary=hrs_worked*hr_rate;
    RETURN total_salary;
END
// DELIMITER ;
SELECT cal_salary(40,100) AS salary;
SELECT cal_salary(60,100) AS salary;
SELECT cal_salary(90,100) AS salary;

DELIMITER //
CREATE FUNCTION get_emp_name(
    emp_id INT
)
RETURNS VARCHAR(100)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE emp_name VARCHAR(100);
    SELECT name INTO emp_name FROM employee WHERE employee_id=emp_id;
    RETURN emp_name;
END
// DELIMITER ;
SELECT get_emp_name(38741) AS employee_name;
SELECT get_emp_name(38743) AS employee_name;
SELECT get_emp_name(38745) AS employee_name;
   

CREATE TABLE employee1(
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeName VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO employee1 (EmployeeName, Salary) VALUES 
('John Doe', 50000),
('Jane Smith', 60000),
('Michael Johnson', 55000);


CREATE TABLE Orders(
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE
);
INSERT INTO Orders (OrderDate) VALUES 
('2024-04-01'),
('2024-04-05'),
('2024-04-10');


CREATE TABLE Products(
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    Quantity INT
);
INSERT INTO Products (Quantity) VALUES 
(5),
(15),
(7),
(25);

CREATE TABLE Customers(
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(50),
    TotalOrders INT
);
-- Customers
INSERT INTO Customers (CustomerName) VALUES 
('ACME Corporation'),
('XYZ Corp');


CREATE TABLE Inventory(
    ProductID INT PRIMARY KEY,
    Quantity INT,
    RecorderLevel INT
);
INSERT INTO Inventory (ProductID, Quantity, RecorderLevel) VALUES 
(1, 3, 10),
(2, 20, 15),
(3, 8, 10),
(4, 30, 20);

CREATE TABLE ReorderItems(
    ProductID INT,
    Quantity INT
);


-- Task 1: Fetch employee names using cursor
DELIMITER //
CREATE PROCEDURE EmployeeCursor()
BEGIN
    DECLARE emp_name VARCHAR(50);
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT EmployeeName FROM employee1;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO emp_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SELECT emp_name;
    END LOOP;
    
    CLOSE cur;
END//

DELIMITER ;

CALL EmployeeCursor();

-- Task 2: Update order dates using cursor
DELIMITER //

CREATE PROCEDURE OrderCursor()
BEGIN
    DECLARE ord_id INT;
    DECLARE ord_date DATE;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT OrderID, OrderDate FROM Orders;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO ord_id, ord_date;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        UPDATE Orders SET OrderDate = CURDATE() WHERE OrderID = ord_id;
    END LOOP;
    
    CLOSE cur;
END//

DELIMITER ;

CALL OrderCursor();

-- Task 3: Delete products with quantity less than 10
DELIMITER //

CREATE PROCEDURE ProductCursor()
BEGIN
    DECLARE prod_id INT;
    DECLARE prod_qty INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT ProductID, Quantity FROM Products;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO prod_id, prod_qty;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF prod_qty < 10 THEN
            DELETE FROM Products WHERE ProductID = prod_id;
        END IF;
    END LOOP;
    
    CLOSE cur;
END//

DELIMITER ;

CALL ProductCursor();

-- Task 4: Calculate and update total orders for each customer
DELIMITER //

CREATE PROCEDURE CustomerCursor()
BEGIN
    DECLARE cust_id INT;
    DECLARE total_ord INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT CustomerID FROM Customers;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO cust_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SELECT COUNT(*) INTO total_ord FROM Orders WHERE CustomerID = cust_id;
        
        UPDATE Customers SET TotalOrders = total_ord WHERE CustomerID = cust_id;
    END LOOP;
    
    CLOSE cur;
END//

DELIMITER ;

CALL CustomerCursor();

-- Task 5: Insert records into ReorderItems table for products needing reorder
DELIMITER //

CREATE PROCEDURE RecorderCursor()
BEGIN
    DECLARE prod_id INT;
    DECLARE prod_qty INT;
    DECLARE rec_level INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT ProductID, Quantity, RecorderLevel FROM Inventory;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO prod_id, prod_qty, rec_level;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF prod_qty < rec_level THEN
            INSERT INTO ReorderItems(ProductID, Quantity) VALUES(prod_id, prod_qty);
        END IF;
    END LOOP;
    
    CLOSE cur;
END//

DELIMITER ;

CALL RecorderCursor();

-- Task 6: Calculate average salary and print employee1 with salary above average
DELIMITER //

CREATE PROCEDURE SalaryCursor()
BEGIN
    DECLARE avg_sal DECIMAL(10,2);
    
    SELECT AVG(Salary) INTO avg_sal FROM employee1;
    
    SELECT EmployeeName, Salary FROM employee1 WHERE Salary > avg_sal;
    
END//

DELIMITER ;

CALL SalaryCursor();