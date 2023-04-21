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

SELECT DISTINCT Company.company_code, Company.founder, COUNT(lead_manager_code) as lead
FROM Company
JOIN Lead_Manager 
ON Company.company_code = Lead_Manager.company_code
GROUP BY Company.company_code, Company.founder
ORDER BY company_code;


SELECT DISTINCT Company.company_code, Company.founder, 
                COUNT(Lead_Manager.lead_manager_code) as lead,
                count(Senior_Manager.senior_manager_code) as senior
FROM Company
JOIN Lead_Manager 
ON Company.company_code = Lead_Manager.company_code
JOIN Senior_Manager
ON Company.company_code = Senior_Manager.company_code
GROUP BY Company.company_code, Company.founder
ORDER BY company_code


SELECT DISTINCT senior_manager_code, lead_manager_code
FROM Senior_Manager
ORDER BY lead_manager_code


SELECT t0.company_code, t0.founder, 
                COUNT(t1.lead_manager_code) as lead,
                count(t2.senior_manager_code) as senior
FROM (
        SELECT DISTINCT Company.company_code, Company.founder
        FROM Company
    ) as t0
JOIN (SELECT COUNT(lead_manager_code) as lead
     FROM
        (
            SELECT DISTINCT lead_manager_code, company_code
            FROM Lead_manager
        ) as c1
     WHERE company_code = t0.company_code) as t1
ON t0.company_code = t1.company_code
JOIN (
     SELECT DISTINCT senior_manager_code, lead_manager_code
     FROM Senior_manager
    ) as t2
ON t1.lead_manager_code = t2.lead_manager_code
GROUP BY t0.company_code, t0.founder
ORDER BY company_code

SELECT Company.company_code, Company.founder,
        COUNT(DISTINCT Lead_manager.lead_manager_code),
        COUNT(DISTINCT Senior_manager.senior_manager_code),
        COUNT(DISTINCT Manager.manager_code),
        COUNT(DISTINCT Employee.employee_code)
FROM Company, Manager, Employee, Senior_Manager, Lead_Manager
WHERE
    Company.company_code = Lead_Manager.company_code
    AND Lead_Manager.lead_manager_code = Senior_Manager.lead_manager_code
    AND Senior_Manager.senior_manager_code = Manager.senior_manager_code
    AND Manager.manager_code = Employee.manager_code
GROUP BY Company.company_code, Company.founder
ORDER BY Company.company_code;


SELECT Company.company_code, Company.founder,
        COUNT(DISTINCT Lead_manager.lead_manager_code),
        COUNT(DISTINCT Senior_manager.senior_manager_code),
        COUNT(DISTINCT Manager.manager_code),
        COUNT(DISTINCT Employee.employee_code)
FROM Company
JOIN Lead_Manager
ON Company.company_code = Lead_Manager.company_code
JOIN Senior_Manager
ON Lead_Manager.lead_manager_code = Senior_Manager.lead_manager_code
JOIN Manager
ON Senior_Manager.senior_manager_code = Manager.senior_manager_code
JOIN Employee
ON Manager.manager_code = Employee.manager_code

GROUP BY Company.company_code, Company.founder
ORDER BY Company.company_code;


SELECT ROUND(SQRT(POWER(t0.a - t0.b, 2) + POWER(t0.c - t0.d, 2)), 4)
FROM
    (SELECT MIN(LAT_N) AS a, MAX(LAT_N) AS b, MIN(LONG_W) AS c, MAX(LONG_W) AS d
    FROM STATION) AS t0;
    
    
    
    

SELECT FriendSalary.Name 
FROM
    (SELECT s1.ID as ID, Name, Salary
    FROM Students s1
    JOIN Friends f1
    ON s1.ID = f1.ID
    JOIN Packages p1
    ON f1.Friend_ID = p1.ID) as FriendSalary
JOIN
    (SELECT s.ID as ID, Name, Salary
    FROM Students s
    JOIN Packages p
    ON s.ID = p.ID) as PersonSalary
ON FriendSalary.ID = PersonSalary.ID
WHERE FriendSalary.Salary>PersonSalary.Salary
ORDER BY FriendSalary.Salary

SELECT s.name
FROM students s
JOIN friends f
ON s.id = f.id
JOIN packages p
ON f.id = p.id
JOIN packages p2
ON f.friend_id = p2.id
WHERE p.salary < p2.salary
ORDER BY p2.salary;










