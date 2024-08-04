show databases;
use employees;
show tables;


-- Question 1
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    e.hire_date,
    d.dept_name,
    t.title,
    s.salary
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    (SELECT 
        s1.emp_no, s1.salary
    FROM
        salaries s1
    JOIN (SELECT 
        emp_no, MAX(to_date) AS latest_paid_date
    FROM
        salaries
    GROUP BY emp_no) s2 ON s1.emp_no = s2.emp_no
        AND s1.to_date = s2.latest_paid_date) s ON e.emp_no = s.emp_no
ORDER BY e.emp_no;



-- Question 2
DELIMITER //

CREATE PROCEDURE sp_update_insert_employee (
    IN p_emp_no INT,
    IN p_birth_date DATE,
    IN p_first_name VARCHAR(14),
    IN p_last_name VARCHAR(16),
    IN p_gender ENUM('M','F'),
    IN p_hire_date DATE
)
BEGIN

    IF EXISTS (SELECT 1 FROM employees WHERE emp_no = p_emp_no) THEN
    -- Update
        UPDATE employees
        SET
            birth_date = p_birth_date,
            first_name = p_first_name,
            last_name = p_last_name,
            gender = p_gender,
            hire_date = p_hire_date
        WHERE emp_no = p_emp_no;
    ELSE
        -- Insert 
        INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
        VALUES (p_emp_no, p_birth_date, p_first_name, p_last_name, p_gender, p_hire_date);
    END IF;
END //

DELIMITER ;



-- QUestion 3
DELIMITER $$

CREATE FUNCTION get_emp_exp(p_emp_no INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_hire_date DATE;
     DECLARE v_last_date DATE;
    DECLARE v_experience INT;

    -- Get the hire date 
SELECT 
    hire_date
INTO v_hire_date FROM
    employees
WHERE
    emp_no = p_emp_no;
    
    -- Get last salary date
SELECT 
    MAX(to_date)
INTO v_last_date FROM
    salaries
WHERE
    emp_no = p_emp_no;

    SET v_experience = TIMESTAMPDIFF(YEAR, v_hire_date,v_last_date) ;

    RETURN v_experience;
END $$

DELIMITER ;





