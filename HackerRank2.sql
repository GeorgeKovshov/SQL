-- MySQL TRIM removes spaces at start and end, but in SQL server it removes the character from string
-- MySQL doesn't have full join, but Oracle does
-- MySQL and doesnt' have pivot


SELECT COUNT(NAME) FROM CITY WHERE POPULATION>100000;

SELECT SUM(POPULATION) FROM CITY WHERE COUNTRYCODE = 'JPN';

SELECT MAX(POPULATION) - MIN(POPULATION) FROM CITY;

SELECT ID, Name, REPLACE(CAST(Salary AS CHAR(15)), '0', '') AS Salar
FROM EMPLOYEES;

SELECT SUM(Salary) - SUM(CAST(REPLACE(CAST(Salary AS CHAR(15)), '0', '')as UNSIGNED))
FROM EMPLOYEES;

SELECT t0.m, COUNT(e.salary * e.months)
FROM (
    SELECT MAX(months * salary) as m
    FROM Employee
) as t0
JOIN Employee as e
ON e.salary * e.months = t0.m
GROUP by m;

select (salary * months)as earnings ,count(*) 
from employee 
group by 1 
order by earnings desc 
limit 1;
-- it meants group by first column from SELECT . The same pattern could be used for ORDER BY

SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (SELECT MAX(LAT_N) FROM STATION WHERE LAT_N<137.2345);

 Select round(long_w,4) from Station where lat_n < 137.2345 order by lat_n desc limit 1;
 
SELECT ROUND(ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W)), 4)
FROM STATION;

SELECT ROUND(MIN(LAT_N),4) FROM STATION WHERE LAT_N>38.7780;

select round(LONG_W,4) from STATION where LAT_N>38.7780 order by LAT_N limit 1;

select round(LONG_W,4) from STATION where LAT_N=(select min(LAT_N) from STATION where LAT_N>38.7780);








