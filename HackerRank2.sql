-- MySQL TRIM removes spaces at start and end, but in SQL server it removes the character from string
-- MySQL doesn't have full join, but Oracle does
-- MySQL and doesnt' have pivot


SELECT COUNT(NAME) FROM CITY WHERE POPULATION>100000;

SELECT SUM(POPULATION) FROM CITY WHERE COUNTRYCODE = 'JPN';

SELECT MAX(POPULATION) - MIN(POPULATION) FROM CITY;

SELECT ID, Name, REPLACE(CAST(Salary AS CHAR(15)), '0', '') AS Salar
FROM EMPLOYEES;

SELECT SUM(Salary) - SUM(CAST(REPLACE(CAST(Salary AS CHAR(15)), '0', '')as UNSIGNED))
FROM EMPLOYEES