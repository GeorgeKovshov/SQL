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

select concat(Name,'(',Substring(Occupation,1,1),')') as Name
from occupations
Order by Name;
select concat('There are total',' ',count(occupation),' ',lower(occupation),'s.') as total
from occupations
group by occupation
order by total;

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





SELECT b1.Doctor, b1.Professor, b2.Singer, b2.Actor
from
    (SELECT t0.Doctor as Doctor, t1.Professor as Professor,
     row_number() OVER () as RowNum
     FROM
        (   Select Name as Doctor,
            row_number() OVER (order by Name ASC) as RowNum
            FROM OCCUPATIONS
            WHERE Occupation = 'Doctor') as t0
        RIGHT join
        (   SELECT Name as Professor,
            row_number() OVER (order by Name ASC) as RowNum
            FROM OCCUPATIONS
            WHERE Occupation = 'Professor') as t1
        on t0.RowNum = t1.RowNum) as b1
    
LEFT JOIN
    (SELECT t2.Singer as Singer, t3.Actor as Actor,
     row_number() OVER () as RowNum
     FROM
            (SELECT Name as Singer,
            row_number() OVER (order by Name ASC) as RowNum
            FROM OCCUPATIONS
            WHERE Occupation = 'Singer') as t2
     LEFT JOIN
            (SELECT Name as Actor,
            row_number() OVER (order by Name ASC) as RowNum
            FROM OCCUPATIONS
            WHERE Occupation = 'Actor') as t3
      on t2.RowNum = t3.RowNum) as b2
    
on b1.RowNum = b2.RowNum
;


set @r1=0, @r2=0, @r3=0, @r4=0;
select min(Doctor), min(Professor), min(Singer), min(Actor)
from(
  select case when Occupation='Doctor' then (@r1:=@r1+1)
            when Occupation='Professor' then (@r2:=@r2+1)
            when Occupation='Singer' then (@r3:=@r3+1)
            when Occupation='Actor' then (@r4:=@r4+1) end as RowNumber,
    case when Occupation='Doctor' then Name end as Doctor,
    case when Occupation='Professor' then Name end as Professor,
    case when Occupation='Singer' then Name end as Singer,
    case when Occupation='Actor' then Name end as Actor
  from OCCUPATIONS
  order by Name
) Temp
group by RowNumber;


SELECT MAX(C1), MAX(C2), MAX(C3), MAX(C4) FROM
	(
		SELECT
		COUNT(*) Rank,
		IF (STRCMP(T1.Occupation, 'Doctor') = 0, T1.Name, NULL) AS C1,
		IF (STRCMP(T1.Occupation, 'Professor') = 0, T1.Name, NULL) AS C2,
		IF (STRCMP(T1.Occupation, 'Singer') = 0, T1.Name, NULL) AS C3,
		IF (STRCMP(T1.Occupation, 'Actor ') = 0, T1.Name, NULL) AS C4
		FROM Occupations T1 
		LEFT JOIN Occupations T2 
		ON T1.Occupation = T2.Occupation AND STRCMP(T1.Name, T2.Name) >= 0 
		GROUP BY T1.Name, T1.Occupation 
		ORDER BY Rank, T1.Name
    ) AS MyOccupations GROUP BY Rank;
	-- SELECT * FROM Occupations;
    
    
SELECT N,
    CASE 
        WHEN P IS NULL THEN 'Root'
        WHEN N NOT IN (SELECT DISTINCT P FROM BST) THEN 'Leaf' 
        ELSE 'Inner'    
    END AS Node_type
FROM BST;


SELECT SUM(CITY.POPULATION)
FROM CITY
JOIN (
    SELECT * FROM COUNTRY WHERE CONTINENT='Asia'   
) as t0
ON CITY.COUNTRYCODE = t0.CODE;

SELECT COUNTRY.CONTINENT, ROUND(AVG(CITY.POPULATION),0)
FROM COUNTRY
JOIN CITY
ON COUNTRY.CODE = CITY.COUNTRYCODE
GROUP BY COUNTRY.CONTINENT;

Asia 693038
Oceania 109190
Europe 175138
South America 147435
Africa 274439

North America
Asia
Europe
Oceania
Africa
South America
Antarctica

SELECT COUNTRY.NAME, CITY.NAME
FROM COUNTRY
JOIN CITY
ON COUNTRY.CODE = CITY.COUNTRYCODE
ORDER BY COUNTRY.NAME;

SELECT DISTINCT COUNTRY.NAME, AVG(CITY.POPULATION)
FROM COUNTRY
JOIN CITY
ON COUNTRY.CODE = CITY.COUNTRYCODE
GROUP BY COUNTRY.NAME
ORDER BY COUNTRY.NAME;

SELECT COUNTRY.CONTINENT, floor(AVG(avg_pop))
FROM COUNTRY
JOIN
(   
    SELECT DISTINCT COUNTRY.NAME AS cname, AVG(CITY.POPULATION) AS avg_pop
    FROM COUNTRY
    JOIN CITY
    ON COUNTRY.CODE = CITY.COUNTRYCODE
    GROUP BY COUNTRY.NAME
 ) AS t0
 ON COUNTRY.NAME = t0.cname
 GROUP BY COUNTRY.CONTINENT;

SELECT Students.Name, Grades.Grade
from Students
join Grades
on (Students.Marks <= Grades.Max_Mark) and (Students.Marks >= Grades.Min_Mark);

SELECT IF(Grades.Grade>=8,Students.Name,NULL) as sname, Grades.Grade, Students.Marks
from Students
join Grades
on (Students.Marks <= Grades.Max_Mark) and (Students.Marks >= Grades.Min_Mark)
ORDER BY Grades.Grade DESC, sname, Students.Marks ASC;

SELECT IF(GRADE < 8, NULL, NAME), GRADE, MARKS
FROM STUDENTS JOIN GRADES
WHERE MARKS BETWEEN MIN_MARK AND MAX_MARK
ORDER BY GRADE DESC, NAME


SELECT DISTINCT Hackers.hacker_id, Hackers.name, t0.scorr
FROM Hackers
JOIN (
    SELECT t1.hacker_id, t1.scorr
    FROM(
        SELECT DISTINCT hacker_id, SUM(high_score) AS scorr
        FROM(
            SELECT DISTINCT hacker_id, challenge_id, MAX(score) as high_score
            FROM Submissions
            GROUP BY hacker_id, challenge_id
        ) as t2
        GROUP BY hacker_id
    )as t1
    WHERE scorr>0
) as t0
ON Hackers.hacker_id = t0.hacker_id
GROUP BY Hackers.name, Hackers.hacker_id
ORDER BY t0.scorr DESC, Hackers.hacker_id;




select h.hacker_id, name, sum(score) as total_score
from
hackers as h inner join
/* find max_score*/
(select hacker_id,  max(score) as score from submissions group by challenge_id, hacker_id) max_score

on h.hacker_id=max_score.hacker_id
group by h.hacker_id, name

/* don't accept hackers with total_score=0 */
having total_score > 0

/* finally order as required */
order by total_score desc, h.hacker_id
;


SELECT Hackers.name
from Hackers
JOIN
Submissions
ON Hackers.hacker_id = Submissions.hacker_id


SELECT Submissions.hacker_id as hack_id, Submissions.score as hack_score, max_challenge.max_score as max_score
FROM
Submissions
JOIN
    (SELECT Challenges.challenge_id as chan_id, Difficulty.score as max_score
    FROM Difficulty
    JOIN Challenges
    ON Difficulty.difficulty_level = Challenges.difficulty_level) as max_challenge
HAVING hack_score = max_score  


 SELECT full_list.hacker_id, Hackers.name,
 FROM
 Hackers
 JOIN
   (SELECT DISTINCT great_hacks.hack_id as hacker_id, COUNT(great_hacks.hack_id) as count_hacks
    FROM
        (SELECT Submissions.hacker_id as hack_id, 
        Submissions.score as hack_score, max_challenge.max_score as max_score
        FROM
        Submissions
        JOIN
            (SELECT Challenges.challenge_id as chan_id, Difficulty.score as max_score
            FROM Difficulty
            JOIN Challenges
            ON Difficulty.difficulty_level = Challenges.difficulty_level) as max_challenge
        HAVING hack_score = max_score) as great_hacks
    GROUP BY hacker_id
    HAVING count_hacks > 1) as full_list
ON full_list.hacker_id = Hackers.hacker_id
ORDER BY full_list.count_hacks DESC, full_list.hacker_id;

 SELECT full_list.hacker_id, Hackers.name
 FROM
 Hackers
 JOIN
   (SELECT DISTINCT great_hacks.hack_id as hacker_id, COUNT(great_hacks.hack_id) as count_hacks
    FROM
        (SELECT Submissions.hacker_id as hack_id, 
        Submissions.score as hack_score, max_challenge.max_score as max_score
        FROM
        Submissions
        JOIN
            (SELECT Challenges.challenge_id as chan_id, Difficulty.score as max_score
            FROM Difficulty
            JOIN Challenges
            ON Difficulty.difficulty_level = Challenges.difficulty_level) as max_challenge
        ON Submissions.challenge_id = max_challenge.chan_id
        -- GROUP BY hack_id, max_challenge.chan_id, max_score
        HAVING hack_score = max_score) as great_hacks
    GROUP BY hacker_id
    HAVING count_hacks > 1) as full_list
ON full_list.hacker_id = Hackers.hacker_id
ORDER BY full_list.count_hacks DESC, full_list.hacker_id;


select h.hacker_id, h.name
from submissions s
	inner join challenges c
	on s.challenge_id = c.challenge_id
		inner join difficulty d
		on c.difficulty_level = d.difficulty_level 
			inner join hackers h
			on s.hacker_id = h.hacker_id
where s.score = d.score and c.difficulty_level = d.difficulty_level
group by h.hacker_id, h.name
having count(s.hacker_id) > 1
order by count(s.hacker_id) desc, s.hacker_id asc;


SELECT id, t0.age, coin, pw
FROM
    (SELECT age, MIN(coins_needed) as coin, Wands.power as pw
    FROM Wands
    JOIN Wands_Property
    ON Wands.code = Wands_Property.code
    WHERE Wands_Property.is_evil = 0
    GROUP BY age, pw) as t0
join Wands as w
on (t0.coin = w.coins_needed) AND (t0.pw = w.power)
join Wands_property as wp
on wp.age = t0.age
ORDER BY pw DESC, t0.age DESC;

SELECT w.id, wp.age, w.coins_needed, w.power
FROM Wands as w
join Wands_Property as wp
on w.code = wp.code
WHERE is_evil = 0 AND coins_needed = 
    (SELECT min(coins_needed)
    FROM Wands as w1
    JOIN Wands_Property as wp1
    ON w1.code = wp1.code
    Where (wp1.age = wp.age) and (w1.power = w.power))
ORDER BY w.power DESC, wp.age DESC;



SELECT t0.hack_id, Hackers.name, t0.count_chal
from (SELECT h.hacker_id AS hack_id, COUNT(c.challenge_id) as count_chal
    FROM Hackers as h
    JOIN Challenges as c
    on h.hacker_id = c.hacker_id
    GROUP BY hack_id) as t0
JOIN Hackers
ON Hackers.hacker_id = t0.hack_id
WHERE t0.count_chal = 
    (SELECT max(t1.count_chal1) 
     from 
         (SELECT h1.hacker_id AS hack_id1, COUNT(c1.challenge_id) as count_chal1
        FROM Hackers as h1
        JOIN Challenges as c1
        on h1.hacker_id = c1.hacker_id
        GROUP BY hack_id1) as t1
    )
ORDER BY t0.count_chal DESC, t0.hack_id;

-- the one you work on

SET @maxt = (SELECT max(t1.count_chal1) 
     from 
         (SELECT h1.hacker_id AS hack_id1, COUNT(c1.challenge_id) as count_chal1
        FROM Hackers as h1
        JOIN Challenges as c1
        on h1.hacker_id = c1.hacker_id
        GROUP BY hack_id1) as t1
    );
    
(SELECT Hackers.name, t0.count_chal
from (SELECT h.hacker_id AS hack_id, COUNT(c.challenge_id) as count_chal
    FROM Hackers as h
    JOIN Challenges as c
    on h.hacker_id = c.hacker_id
    GROUP BY hack_id) as t0
JOIN Hackers
ON Hackers.hacker_id = t0.hack_id
WHERE t0.count_chal = @maxt
ORDER BY t0.count_chal DESC, t0.hack_id)

UNION

(SELECT MAX(Hackers.name), t1.count_chal1
from (SELECT h1.hacker_id AS hack_id1, COUNT(c1.challenge_id) as count_chal1
    FROM Hackers as h1
    JOIN Challenges as c1
    on h1.hacker_id = c1.hacker_id
    GROUP BY hack_id1) as t1
JOIN Hackers
ON Hackers.hacker_id = t1.hack_id1
WHERE t1.count_chal1 < @maxt
GROUP BY t1.count_chal1
ORDER BY t1.count_chal1 DESC)
;




SET @maxt = (SELECT max(t1.count_chal1) 
     from 
         (SELECT h1.hacker_id AS hack_id1, COUNT(c1.challenge_id) as count_chal1
        FROM Hackers as h1
        JOIN Challenges as c1
        on h1.hacker_id = c1.hacker_id
        GROUP BY hack_id1) as t1
    );
    
(SELECT t0.hack_id as col1, Hackers.name as col2, t0.count_chal as col3
from (SELECT h.hacker_id AS hack_id, COUNT(c.challenge_id) as count_chal
    FROM Hackers as h
    JOIN Challenges as c
    on h.hacker_id = c.hacker_id
    GROUP BY hack_id) as t0
JOIN Hackers
ON Hackers.hacker_id = t0.hack_id
WHERE t0.count_chal = @maxt)

UNION    
    
(SELECT t3.iiid, t3.hack_name, t3.count_chal2 as cc
FROM
    (SELECT MIN(t1.hack_id1) as iiid, MAX(Hackers.name) as hack_name, t1.count_chal1 as count_chal2
    from (SELECT h1.hacker_id AS hack_id1, COUNT(c1.challenge_id) as count_chal1
        FROM Hackers as h1
        JOIN Challenges as c1
        on h1.hacker_id = c1.hacker_id
        GROUP BY hack_id1) as t1
    JOIN Hackers
    ON Hackers.hacker_id = t1.hack_id1
    WHERE t1.count_chal1 < @maxt
    GROUP BY t1.count_chal1
    ORDER BY t1.count_chal1 DESC) AS t3
JOIN Hackers
ON t3.hack_name = Hackers.name
GROUP BY  cc, t3.hack_name)
ORDER BY col3 DESC, col1 ASC
;






