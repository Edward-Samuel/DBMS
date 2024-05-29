CREATE DATABASE TNEA;
USE TNEA;
CREATE TABLE Stud(
    Reg_No INT PRIMARY KEY AUTO_INCREMENT,
    Name_ VARCHAR(30),
    Tamil FLOAT(5,2),
    English FLOAT(5,2),
    Maths FLOAT(5,2),
    Physics FLOAT(5,2),
    Chemistry FLOAT(5,2),
    Biology FLOAT(5,2),
    Total FLOAT,
    Cutoff FLOAT,
    Status_ char(1),
    Rank_ char(1)
);

CREATE TABLE stud_log(
    Reg_No INT,
    Cutoff FLOAT,
    Rank_ CHAR(1)
);

DROP TABLE stud;
CREATE TRIGGER Total_calculation
before INSERT ON stud
FOR EACH ROW
SET new.Total = new.Tamil + new.English + new.Maths + new.Physics + new.Chemistry + new.Biology / 6;
DROP TRIGGER Total_calculation;

CREATE TRIGGER Cutoff_calculation
before INSERT ON stud
FOR EACH ROW
SET new.Cutoff = (new.Physics+new.Chemistry+new.Maths)/4;
DROP TRIGGER Cutoff_calculation;

CREATE TRIGGER Status_calculation
before INSERT ON stud
FOR EACH ROW
if new.Tamil<75 OR new.English<75 OR new.Maths<75 OR new.Physics<75 OR new.Chemistry<75 OR new.Biology<75
THEN SET new.Status_='F';
else
SET new.Status_='P';
END IF;

CREATE TRIGGER Calculate_Rank
AFTER INSERT ON Stud
FOR EACH ROW
SET @rank := 0;
UPDATE Stud 
SET Rank_ = (@rank := @rank + 1) 
ORDER BY Cutoff DESC;

DROP TRIGGER Calculate_Rank;

CREATE TRIGGER Insert_Validation
BEFORE INSERT ON Stud
FOR EACH ROWZ
IF NEW.Tamil<=0 OR NEW.English<=0 OR NEW.Maths<=0 OR NEW.Physics<=0 OR NEW.Chemistry<=0 OR NEW.Biology<=0 THEN
    SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT="INVALID MARKS:SUBJECT MARK MUST BE GREATER THAN OR EQUAL TO 0";
END IF;

DROP TRIGGER Insert_Validation;

DROP TABLE stud;
INSERT INTO stud(Name_,Tamil,English,Maths,Physics,Chemistry,Biology)
VALUES ('Michael Smith',189.5,192.3,195.1,187.8,191.5,188.9),
('Emily Johnson',178.6,186.7,180.2,185.5,182.9,187.3),
('David Brown',192.8,194.5,190.1,191.3,193.2,195.7),
('Sophia Wilson',185.4,189.2,184.6,188.7,186.9,191.8),
('Ethan Miller',177.9,181.3,179.8,180.5,178.2,182.6);
INSERT INTO stud(Name_,Tamil,English,Maths,Physics,Chemistry,Biology)
VALUES ('Steve Smith',189.5,192.3,195.1,187.8,191.5,188.9);
INSERT INTO stud(Name_,Tamil,English,Maths,Physics,Chemistry,Biology)
VALUES ('Steve Smith',-140,192.3,195.1,187.8,191.5,188.9);
TRUNCATE TABLE stud;

SELECT * FROM stud;

//;
DELETE FROM Stud
WHERE Reg_No=3;

CREATE TRIGGER delete_message
AFTER DELETE ON Stud
FOR EACH ROW
SIGNAL SQLSTATE "45001" SET MEBSSAGE_TEXT="A RECORD HAS BEEN DELETED";
DROP TRIGGER delete_message;

CREATE TRIGGER record_log
AFTER DELETE ON Stud
FOR EACH ROW
INSERT INTO stud_log (Reg_No, Cutoff, Rank_)
VALUES (OLD.Reg_No,OLD.Cutoff,OLD.Rank_);

SELECT * FROM stud_log;

CREATE VIEW 3_ATTRIBUTES AS
SELECT Reg_No,Name_,Cutoff
FROM Stud;

SELECT * FROM 3_ATTRIBUTES;

CREATE VIEW 2_ATTRIBUTES AS
SELECT Reg_No,Rank_
FROM Stud;

SELECT * FROM 2_ATTRIBUTES;

DELETE FROM Stud
WHERE Reg_No=3;

UPDATE 2_attributes
SET Rank_=2
WHERE Rank_=1;

SELECT * FROM stud;

UPDATE stud
SET Rank_=1
WHERE Rank_=2;