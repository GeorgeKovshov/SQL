USE girrafe_database;

SELECT *
FROM employee
ORDER BY sex, first_name, second_name
LIMIT 5;

SELECT first_name as forename, second_name as surname
FROM employee;

SELECT DISTINCT sex
FROM employee;

SELECT DISTINCT branch_name
FROM branch;

SELECT COUNT(emp_id)
FROM employee;
-- doesn't count null
SELECT COUNT(super_id)
FROM employee;

SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_day > '1970-01-01';


SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

SELECT SUM(salary)
FROM employee
WHERE sex = 'M';

SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;

-- ---------------------------
--      % = any # characters,     _ = one character

SELECT *
FROM client_table
WHERE client_name LIKE '%LLC';


SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '% Label%';

SELECT *
FROM employee
WHERE birth_day LIKE '____-02%';

SELECT *
FROM client_table
WHERE (client_name LIKE '%school%' OR client_name LIKE '%LLC%');

-- -----------UNIONS-----------------

SELECT first_name
FROM employee
UNION
SELECT branch_name
FROM branch;

-- UNION'd SELECT's have to have the same number of columns and of similar type
SELECT first_name, second_name
FROM employee
UNION
SELECT branch_name
FROM branch;

SELECT first_name AS Various_Names
FROM employee
UNION
SELECT branch_name
FROM branch
UNION
SELECT client_name
FROM client_table;

SELECT client_name, client_table.branch_id
FROM client_table
UNION 
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

SELECT salary
FROM employee
UNION
SELECT total_sales
FROM works_with;

-- ---------JOINS-----------

INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);

-- default JOIN is INNER join;  FULL OUTER JOIN is both left and right join
-- MySQL doesn't have FULL OUTER JOIN

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id;


SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id;


-- -----------------

SELECT employee.first_name, employee.second_name
FROM employee
WHERE employee.emp_id in (
	SELECT works_with.emp_id
	FROM works_with
	WHERE works_with.total_sales > 30000
);

SELECT client_table.client_name
FROM client_table
WHERE client_table.branch_id = (
	SELECT branch.branch_id
	FROM branch
	WHERE branch.mgr_id = 102
    LIMIT 1
);

SELECT * FROM employee WHERE (emp_id % 2 = 0);
SELECT * FROM employee WHERE sex = 'm';
SELECT if(sex = 'm', 'Man', 'Female') FROM employee;
SELECT 'MAN' FROM (
	SELECT * FROM employee WHERE sex = 'm'
);

SELECT CONCAT(first_name, '(', LEFT(salary, 1), ')') as result
FROM employee
UNION
(SELECT CONCAT('There are a total of ', COUNT(sex), if(sex='m', ' men.', ' women.')) as result
FROM employee
GROUP BY sex
)
;

(SELECT CONCAT(t0.first_name, '(', LEFT(t0.salary, 1), ')') as result
FROM (
	SELECT DISTINCT first_name, salary 
    FROM employee
    order by first_name
    ) as t0

)
UNION
(SELECT CONCAT('There are a total of ', t1.count_sex, if(t1.sex='m', ' men.', ' women.')) 
FROM (
	SELECT employee.sex, count(employee.sex) as count_sex from employee group by employee.sex order by count_sex
	) as t1
)
;

SELECT DISTINCT sex 
FROM employee;


CREATE TABLE Meeting
(
    ID INT,
    Meeting_id INT,
    field_key VARCHAR(100),
    field_value VARCHAR(100)
);

INSERT INTO Meeting(ID,Meeting_id,field_key,field_value)
VALUES (1, 1,'first_name' , 'Alec');
INSERT INTO Meeting(ID,Meeting_id,field_key,field_value)
VALUES (2, 1,'last_name' , 'Jones');
INSERT INTO Meeting(ID,Meeting_id,field_key,field_value)
VALUES (3, 1,'occupation' , 'engineer');
INSERT INTO Meeting(ID,Meeting_id,field_key,field_value)
VALUES (4,2,'first_name' , 'John');
INSERT INTO Meeting(ID,Meeting_id,field_key,field_value)
VALUES (5,2,'last_name' , 'Doe');
INSERT INTO Meeting(ID,Meeting_id,field_key,field_value)
VALUES (6,2,'occupation' , 'engineer');


-- dynamycally generate pivoting without knowing column names

SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'max(case when field_key = ''',
      field_key,
      ''' then field_value end) ',
      field_key
    )
  ) INTO @sql
FROM
  Meeting;
SET @sql = CONCAT('SELECT Meeting_id, ', @sql, ' 
                  FROM Meeting 
                   GROUP BY Meeting_id');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;














