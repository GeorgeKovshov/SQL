SELECT * FROM CITY WHERE ID = 1661;

SELECT * FROM CITY WHERE CountryCode = 'JPN';

SELECT NAME FROM CITY WHERE CountryCode = 'JPN';

SELECT CITY, STATE FROM STATION;

SELECT ROUND(SUM(LAT_N),2) AS lat, ROUND(SUM(LONG_W),2) AS lon FROM STATION;

SELECT DISTINCT CITY FROM STATION WHERE (ID % 2 = 0);

SELECT (COUNT(CITY) - COUNT(DISTINCT CITY)) FROM STATION;


(SELECT CITY, LENGTH(CITY) FROM STATION WHERE LENGTH(CITY) = (
    SELECT MIN(LENGTH(CITY)) FROM STATION
)
ORDER BY CITY
LIMIT 1)
UNION
(SELECT CITY, LENGTH(CITY) FROM STATION WHERE LENGTH(CITY) = (
    SELECT MAX(LENGTH(CITY)) FROM STATION
)
ORDER BY CITY
LIMIT 1);

SELECT CITY FROM STATION WHERE LEFT(CITY,1) IN ('a','e','i','o','u');
SELECT DISTINCT CITY FROM STATION WHERE RIGHT(CITY,1) IN ('a','e','i','o','u');
SELECT DISTINCT CITY FROM STATION WHERE RIGHT(CITY,1) IN ('a','e','i','o','u') AND LEFT(CITY,1) IN ('a','e','i','o','u');
SELECT DISTINCT CITY FROM STATION WHERE LEFT(CITY,1) NOT IN ('a','e','i','o','u');
SELECT DISTINCT CITY FROM STATION WHERE RIGHT(CITY,1) NOT IN ('a','e','i','o','u');

SELECT ROUND(SUM(LAT_N), 4) FROM STATION WHERE LAT_N >38.7880 AND LAT_N<137.2345;

SELECT CASE
    WHEN A+B>C AND A+C>B AND B+C>A THEN
        CASE
            WHEN A=B AND A=C THEN 'Equilateral'
            WHEN A=B OR A=C OR B=C THEN 'Isosceles'
            ELSE 'Scalene'
        END
    ELSE 'Not A Triangle'
    END AS triangle_type
FROM TRIANGLES;

SELECT if(sex = 'm', 'Man', 'Female') FROM employee;

SELECT Name FROM STUDENTS WHERE Marks>75
ORDER BY RIGHT(Name, 3), ID ASC;

SELECT NAME FROM EMPLOYEE WHERE SALARY>2000 AND MONTHS<10;


(SELECT CONCAT(t0.Name, '(', LEFT(t0.Occupation, 1), ')') as nam_prof
FROM (
    SELECT DISTINCT Name, Occupation
    FROM OCCUPATIONS
    ORDER BY Name
    ) as t0
)
UNION
(SELECT CONCAT('There are a total of ', t1.count_occup, ' ', LOWER(t1.Occupation), 's.')
FROM (
    SELECT Occupation, COUNT(Occupation) as count_occup
    FROM OCCUPATIONS
    GROUP BY Occupation
    ORDER BY count_occup ASC, Occupation ASC
    ) AS t1
);

SELECT CONCAT(Name,'(', LEFT(Occupation, 1), ')') 
FROM (
SELECT Name, Occupation, row_number() OVER (order by Name ASC) as RowNum  FROM OCCUPATIONS
) as X 
UNION ALL
SELECT CONCAT('There are a total of ', cou, ' ', Lower(Occupation), 's.')
FROM (
SELECT Occupation, COUNT(Occupation) as cou, row_number() over(order by COUNT(Occupation), Occupation) 
FROM OCCUPATIONS GROUP BY Occupation
) as Y;


