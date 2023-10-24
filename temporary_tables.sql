SHOW databases;
USE ursula_2327;
USE employees;
SELECT database();
DESCRIBE ursula_2327;
SHOW TABLES;

DESCRIBE employees;
DESCRIBE departments;
DESCRIBE dept_emp;

/* 1. Using the example from the lesson, create a temporary table called 
employees_with_departments that contains first_name, last_name, and dept_name for employees 
currently with that department. Be absolutely sure to create this table on your own database. 
If you see "Access denied for user ...", it means that the query was attempting to write a new 
table to a database that you can only read.

a. Add a column named full_name to this table. It should be a VARCHAR whose 
length is the sum of the lengths of the first name and last name columns.
b. Update the table so that the full_name column contains the correct data.
c. Remove the first_name and last_name columns from the table.
d. What is another way you could have ended up with this same table?
*/
CREATE TEMPORARY TABLE employees_with_departments AS 
SELECT 
		first_name, 
        last_name, 
        dept_no, 
        dept_name
FROM employees.employees
	JOIN employees.dept_emp 
		USING (emp_no)
	JOIN employees.departments 
		USING (dept_no)
WHERE to_date > NOW()
LIMIT 100
;

SELECT *
FROM employees_with_departments;

DROP TABLE employees_with_departments;

-- A. 
ALTER TABLE employees_with_departments 
	ADD full_name VARCHAR(100) 
; 
UPDATE employees_with_departments
	SET full_name = CONCAT(first_name, ' ', last_name) 
;

-- C. 
ALTER TABLE employees_with_departments
	DROP COLUMN first_name, DROP COLUMN last_name
;

-- D.
CREATE TEMPORARY TABLE employees_with_departments AS 
SELECT dept_no, dept_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees.employees
	JOIN employees.dept_emp 
		USING (emp_no)
	JOIN employees.departments 
		USING (dept_no)
LIMIT 100
;

/* 2. Create a temporary table based on the payment table from the sakila database.

Write the SQL necessary to transform the amount column such that it is stored as an 
integer representing the number of cents of the payment. 
For example, 1.99 should become 199. */
SHOW databases;
USE sakila;
SELECT database();
DESCRIBE payment;

SELECT *
FROM payment;

CREATE TEMPORARY TABLE payment AS
SELECT 
		payment_id, 
        customer_id, 
        staff_id, 
        rental_id, 
        amount, 
        payment_date, 
        last_update -- Alternate: CAST(amount * 100 as signed)
FROM sakila.payment
;
SELECT *
FROM payment;

ALTER TABLE payment 
	ADD updated_payment INT(10) 
;

UPDATE payment
	SET updated_payment = amount * 100
;

/* 3. Go back to the employees database. Find out how the current average pay in each department
 compares to the overall current pay for everyone at the company. 
 For this comparison, you will calculate the z-score for each salary. 
 In terms of salary, what is the best department right now to work for? The worst? */
SELECT *
FROM employees;
SELECT *
FROM new_employee_table;


DESCRIBE employees; -- emp_no
DESCRIBE salaries; -- emp_no, salary, from_date, to_date
DESCRIBE dept_emp; -- emp_no, dept_no, from_date, to_date
DESCRIBE departments; -- dept_no, dept_name

SELECT 
			dept_name,
            AVG(salary)
FROM employees.departments AS dept
	JOIN employees.dept_emp AS de
		USING (dept_no)
	JOIN employees.salaries AS s
		USING (emp_no)
GROUP BY dept_name
;

CREATE TEMPORARY TABLE new_employee_table AS -- create new main table
			(SELECT 		
					dept_name,
					AVG(salary)
			FROM employees.departments AS dept
				JOIN employees.dept_emp AS de
					USING (dept_no)
				JOIN employees.salaries AS s
					USING (emp_no)
			GROUP BY dept_name)
;

SELECT *
FROM new_employee_table
;
DROP TABLE new_employee_table;		

SELECT 
		ROUND(AVG(salary), 2),
        ROUND(STDDEV(salary), 2)
FROM employees.salaries
WHERE to_date > NOW()
;

CREATE TEMPORARY TABLE new_employee_table_2 AS
		(SELECT 
				ROUND(AVG(salary), 2) AS avg_salary,
				ROUND(STDDEV(salary), 2) AS STD
		FROM employees.salaries
		WHERE to_date > NOW())
;
 
SELECT *
FROM new_employee_table_2;
DROP TABLE new_employee_table_2;

ALTER TABLE new_employee_table		-- Add standard deviation column name to new_employee_table main table
	ADD avg_salary float(10);
;

ALTER TABLE new_employee_table
	ADD STD float(10);
    
ALTER TABLE new_employee_table
	ADD zscore float(10);

UPDATE new_employee_table
	SET avg_salary = (SELECT avg_salary
						FROM new_employee_table_2)
;

UPDATE new_employee_table
	SET STD = (SELECT STD 
				FROM new_employee_table_2)
;

UPDATE new_employee_table
	SET zscore = (SELECT zscore 
					FROM information_zscore)
;

SELECT 		-- to get the value of zscore
		salary,  
		(salary - (SELECT ROUND(AVG(salary), 2) 
		FROM employees.salaries
		WHERE to_date > NOW()))
/
		(SELECT ROUND(stddev(salary), 2) -- standard deviation for salary
		FROM salaries
		WHERE to_date > now()) AS zscore
FROM employees.salaries
WHERE to_date > NOW()
ORDER BY zscore DESC
;

CREATE TEMPORARY TABLE information_zscore AS 	-- create new zscore table
			(SELECT  
					(salary - (SELECT ROUND(AVG(salary), 2) 
			FROM employees.salaries
			WHERE to_date > NOW()))
			/
			(SELECT ROUND(stddev(salary), 2) -- standard deviation for salary
			FROM employees.salaries
			WHERE to_date > now()) AS zscore
	FROM employees.salaries
	WHERE to_date > NOW()
	ORDER BY zscore DESC)
;

SELECT *
FROM information_zscore
;

DROP TABLE information_zscore
;


/* Needed current salary and dept_name; another table with only avg salary and std and add zscore 
add add table of salary and std to the main table and add zscore to the main table */














