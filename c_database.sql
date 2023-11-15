CREATE DATABASE DataBase1;
USE DataBase1;

DESCRIBE inventory; # tested table

DESCRIBE water_company;
INSERT INTO water_company VALUES(1,10,100, 1000);
INSERT INTO water_company(start, end, price) VALUES(10,100, 1000);

DELETE FROM water_company;

SELECT * FROM water_company;

SELECT price FROM water_company WHERE id = 8;

SELECT SUM(price) FROM water_company WHERE start>6 AND start<11;

SELECT SUM(end - start) from water_company WHERE end > 6 and end <22;

CREATE TABLE users ( id INT NOT NULL auto_increment PRIMARY KEY, username VARCHAR(30) NOT NULL, pwd VARCHAR(255) NOT NULL, email VARCHAR(100) NOT NULL); 

DESCRIBE users;

SELECT * FROM users;