show databases;
use employees;
show tables;
desc  salaries;

-- Question 1
CREATE VIEW view_employees AS
    SELECT 
        *
    FROM
        employees
    WHERE
        emp_no BETWEEN 10001 AND 10005;


CREATE VIEW view_emp_dept AS
    SELECT 
        *
    FROM
        dept_emp
    WHERE
        (emp_no BETWEEN 10004 AND 10008);

SELECT 
    *
FROM
    view_employees e
        LEFT OUTER JOIN
    view_emp_dept d ON e.emp_no = d.emp_no 
UNION SELECT 
    *
FROM
    view_employees e
        RIGHT OUTER JOIN
    view_emp_dept d ON e.emp_no = d.emp_no;


-- Question 2

SELECT 
    CONCAT(first_name, ' ', last_name) Name,
    CASE
        WHEN gender = 'M' THEN 'Male'
        WHEN gender = 'F' THEN 'Female'
    END Gender
FROM
    employees
WHERE
    (CONCAT(first_name, ' ', last_name) = 'Aamod Radwan'
        AND gender = 'M')
        OR (CONCAT(first_name, ' ', last_name) = 'Arve Erde'
        AND gender = 'F');
        
        
-- Question 3

SELECT 
    title Title, COUNT(*) Count
FROM
    titles
GROUP BY title
HAVING title IN ('Senior Engineer' , 'Assistant Engineer');

-- Question 4

SELECT 
    '<50000' AS Salary,
    AVG(CASE
        WHEN salary < 50000.00 THEN salary
        ELSE NULL
    END) AS average_amount
FROM
    salaries 
UNION ALL SELECT 
    '50000 - 100000' AS Salary,
    AVG(CASE
        WHEN salary BETWEEN 50000.00 AND 100000.00 THEN salary
        ELSE NULL
    END) AS average_amount
FROM
    salaries 
UNION ALL SELECT 
    '100000' AS Salary,
    AVG(CASE
        WHEN salary > 100000.00 THEN salary
        ELSE NULL
    END) AS average_amount
FROM
    salaries;
