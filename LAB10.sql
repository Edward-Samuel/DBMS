use jdbc;
DROP TABLE employee;
CREATE TABLE employee(
    emp_id INT PRIMARY KEY,
    ename VARCHAR(30),
    salary INT
);

INSERT INTO employee VALUES (1, "Ram", 100000);
INSERT INTO employee VALUES (2, "Ravi", 300000);
INSERT INTO employee VALUES (3, "Ramya", 200000);
SELECT * FROM employee;