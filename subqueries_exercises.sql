/* 1. Find all the current employees with the same hire date as employee 101010 using a subquery. */
SHOW databases;
USE employees;
SELECT database();
SHOW tables;

SELECT e.first_name, e.last_name
FROM employees AS e
JOIN dept_emp AS de
		ON de.emp_no = e.emp_no
WHERE hire_date = (SELECT hire_date
		FROM employees
		WHERE emp_no IN ('101010')
        ) AND de.to_date > NOW()
ORDER BY e.first_name, e.last_name
;

/* 2. Find all the titles ever held by all current employees with the first name Aamod. */
SELECT e.first_name
FROM employees AS e
WHERE first_name = 'Aamod'
LIMIT 1;

SELECT title, e.first_name, e.last_name
FROM titles AS t
JOIN employees AS e
	USING (emp_no)
JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
WHERE e.first_name = (SELECT e.first_name
			FROM employees AS e
			WHERE first_name = 'Aamod'
			LIMIT 1) 
            AND t.to_date > NOW()
            AND de.to_date > NOW()
ORDER BY e.last_name
;
DESCRIBE titles;
DESCRIBE employees;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE salaries;
/* 3. How many people in the employees table are no longer working for the company? 
Give the answer in a comment in your code. */
SELECT de.to_date
FROM dept_emp AS de
WHERE de.to_date NOT LIKE '9999%'
;

SELECT COUNT(e.emp_no)
FROM employees AS e
JOIN dept_emp AS de
	USING (emp_no)
WHERE de.to_date IN (SELECT de.to_date
			FROM dept_emp AS de
			WHERE de.to_date NOT LIKE '9999%')
; -- Answer: 91479

/* 4. Find all the current department managers that are female. 
List their names in a comment in your code. */
SELECT emp_no
FROM dept_manager AS de
WHERE to_date LIKE '9999%'
;

SELECT e.first_name, e.last_name
FROM employees AS e
JOIN dept_manager AS dm
	USING (emp_no)
WHERE dm.emp_no	IN (SELECT emp_no
		FROM dept_manager AS de
		WHERE to_date LIKE '9999%') 
        AND e.gender = 'F'
GROUP BY e.first_name, e.last_name
ORDER BY e.first_name, e.last_name
;

/* 5. Find all the employees who currently have a higher salary than the companie's overall, 
historical average salary. */
DESCRIBE salaries;
SELECT ROUND(AVG(salary), 2)
FROM salaries;

SELECT first_name, last_name, salary
FROM employees AS e
JOIN salaries AS s
	USING (emp_no)
WHERE salary > (SELECT ROUND(AVG(salary), 2)
			FROM salaries) 
            AND s.to_date > NOW()
ORDER BY first_name, last_name
;

/* 6. How many current salaries are within 1 standard deviation of the current highest salary? 
(Hint: you can use a built-in function to calculate the standard deviation.) 
What percentage of all salaries is this?
Hint You will likely use multiple subqueries in a variety of ways
Hint It's a good practice to write out all of the small queries that you can. 
Add a comment above the query showing the number of rows returned. You will use this number
 (or the query that produced it) in other, larger queries. */
SELECT first_name, last_name
FROM employees AS e
JOIN salaries AS s
	USING (emp_no)
WHERE salary > (SELECT ROUND(AVG(salary), 2)
				FROM salaries)
				AND s.to_date > NOW() AND salary <= ROUND(STDDEV(salary), 2)
-- ORDER BY first_name, last_name 
;

-- BONUS
/* 1. Find all the department names that currently have female managers. */
SELECT first_name, last_name, gender
FROM employees AS e
WHERE gender = 'F';

SELECT *
FROM dept_manager AS de 
		(SELECT first_name, last_name, gender
		FROM employees AS e
		WHERE gender = 'F')
JOIN employees AS e


;


