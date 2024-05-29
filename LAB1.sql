DROP DATABASE CIT;
CREATE DATABASE CIT;
USE CIT;
SHOW databases;
DROP TABLE student;
CREATE TABLE Student(
    Register_no BIGINT primary key auto_increment,
    Name char(30),
    Gender char(1),
    Age int(2),
    Sem1_gpa float(3),
    Sem2_gpa float(3),
    Sem3_gpa float(3),
    Sem4_gpa float(3)
)auto_increment=71762209001;
DESCRIBE Student;
INSERT INTO student (Name,Gender,Age,Sem1_gpa,Sem2_gpa,Sem3_gpa,Sem4_gpa)
VALUES ('Ashish','M',20,8.5,9,8.7,9.3),
('Anand','M',19,6.5,7.5,7.8,8);
ALTER TABLE student add Cgpa float(3);
UPDATE student set cgpa=8.75 where Register_no=71762209001;
SELECT * FROM student;
ALTER TABLE Student RENAME TO College_students;
DROP TABLE student;
TRUNCATE TABLE student;
