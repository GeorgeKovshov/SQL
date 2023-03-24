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

