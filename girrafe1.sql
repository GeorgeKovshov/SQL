CREATE DATABASE girrafe_database;

USE girrafe_database;

CREATE TABLE student (
	student_id INT PRIMARY KEY,
    stud_name VARCHAR(20),
    major VARCHAR(20)
);

CREATE TABLE student (
	student_id INT,
    stud_name VARCHAR(20) NOT NULL,
    major VARCHAR(20) UNIQUE,
    PRIMARY KEY(student_id)
);

CREATE TABLE student (
	student_id INT AUTO_INCREMENT,
    stud_name VARCHAR(20),
    major VARCHAR(20) DEFAULT 'undecided',
    PRIMARY KEY(student_id)
);

DESCRIBE student;

DESCRIBE giraffe_database;

DROP TABLE student;

ALTER TABLE student ADD gpa DECIMAL(3,2);

ALTER TABLE student DROP COLUMN gpa;

INSERT INTO student VALUES(1, 'Jack', 'Biology');
INSERT INTO student VALUES(2, 'Kate', 'Sociology');
INSERT INTO student(student_id,stud_name) VALUES(3, 'Claire');
INSERT INTO student VALUES(3, 'Claire', 'Chemistry');
INSERT INTO student VALUES(4, 'Jack', 'Biology');
INSERT INTO student VALUES(5, 'Mike', 'Computer Science');


INSERT INTO student(stud_name, major) VALUES('Jack', 'Biology');
INSERT INTO student(stud_name, major) VALUES('Kate', 'Sociology');
INSERT INTO student(stud_name) VALUES('Claire');
INSERT INTO student(stud_name, major) VALUES('Jack', 'Biology');
INSERT INTO student(stud_name, major) VALUES('Mike', 'Computer Science');

SELECT * FROM student;

UPDATE student 
SET major = 'Bio'
WHERE major = 'Biology';

UPDATE student 
SET major = 'Biochemistry'
WHERE major = 'Bio' OR major = 'Sociology';

UPDATE student 
SET stud_name= 'Tom', major = 'eating fish'
WHERE student_id = 1;

UPDATE student 
SET major = 'undecided';

DELETE FROM student;

DELETE FROM student
WHERE student_id = 5;

DELETE FROM student
WHERE stud_name = 'Tom' AND major = 'undecided';

SELECT stud_name, major 
FROM student;

SELECT student.stud_name 
FROM student;

SELECT stud_name, major 
FROM student
ORDER BY stud_name;

SELECT CURRENT_USER();

SELECT stud_name, major 
FROM student
ORDER BY stud_name DESC;

SELECT *
FROM student
ORDER BY major ASC, student_id DESC;

SELECT *
FROM student
LIMIT 2;


SELECT *
FROM student
ORDER BY student_id DESC
LIMIT 2;

SELECT stud_name, student_id
FROM student
WHERE major = 'Biology' or stud_name = 'Kate';

-- <, >, <=, >=, =, <>, AND, OR

SELECT stud_name, student_id
FROM student
WHERE major <> 'Biology';

SELECT *
FROM student
WHERE stud_name IN ('Claire', 'Kate', 'Mike') AND student_id > 2;



