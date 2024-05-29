USE CIT;
CREATE TABLE Books(
    Book_id INT PRIMARY KEY,
    Title VARCHAR(30),
    Author VARCHAR(30),
    Publisher VARCHAR(30),
    ISBN VARCHAR(17)
);
CREATE TABLE Patrons(
    P_id int(11) PRIMARY KEY,
    P_name char(20),
    email VARCHAR(100)
);
CREATE TABLE Transactions(
    Transaction_id INT auto_increment PRIMARY KEY,
    checkout_date date,
    due_date date
);
DROP TABLE Transactions;
INSERT INTO Transactions (checkout_date, due_date)
VALUES (CURDATE(),DATE_ADD(CURDATE(),INTERVAL 30 DAYS));
SELECT * FROM transactions;