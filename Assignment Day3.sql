show databases;
use employees;
show tables;


-- Assignment 2
desc employees;
SELECT * FROM employees where first_name like'Y%n';

-- Assignment 3
desc salaries;
select emp_no,salary*1.3 increased_salary from salaries;


-- Assignment 4
desc titles;
select distinct title from titles;