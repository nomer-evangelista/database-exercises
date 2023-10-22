SHOW databases;
USE employees;
SELECT database();
SELECT * FROM employees;
SELECT * FROM titles; 
/* 1. In your script, use DISTINCT to find the unique titles in the titles table. 
How many unique titles have there ever been? Answer that in a comment in your SQL file.*/ 
SELECT DISTINCT title 
FROM titles;
# 7 unique titles

/* 2. Write a query to find a list of all unique last names that start 
and end with 'E' using GROUP BY.*/
SELECT last_name 
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;

/* 3. Write a query to to find all unique combinations of first and 
last names of all employees whose last names start and end with 'E'. */ 
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY first_name, last_name;

/* 4. Write a query to find the unique last names with a 'q' but not 'qu'. 
Include those names in a comment in your sql code. */
SELECT last_name
FROM employees 
WHERE last_name LIKE '%Q%' AND last_name NOT LIKE '%QU%'
GROUP BY last_name;

/* 5. Add a COUNT() to your results for exercise 5 to find the number of employees 
with the same last name. */
SELECT last_name, COUNT(*)
FROM employees
WHERE last_name LIKE '%Q%' AND last_name NOT LIKE '%QU%'
GROUP BY last_name;

/* 6. Find all employees with first names 'Irena', 'Vidya', or 'Maya'. 
Use COUNT(*) and GROUP BY to find the number of employees with those names for each gender. */
SELECT first_name, gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
ORDER BY first_name ASC;

/* 7. Using your query that generates a username for all employees, 
generate a count of employees with each unique username. */
SELECT CONCAT(LOWER(SUBSTRING(first_name, 1, 1)), LOWER(SUBSTRING(last_name, 1, 4)), '_',
SUBSTRING(birth_date, 6, 2), SUBSTRING(birth_date, 3, 2)) AS username, 
COUNT(*)   
FROM employees 
GROUP BY username;

/* 8. From your previous query, are there any duplicate usernames? 
What is the highest number of times a username shows up? 
Bonus: How many duplicate usernames are there? */
SELECT CONCAT(LOWER(SUBSTRING(first_name, 1, 1)), LOWER(SUBSTRING(last_name, 1, 4)), '_',
SUBSTRING(birth_date, 6, 2), SUBSTRING(birth_date, 3, 2)) AS username, 
COUNT(*) AS C
FROM employees 
GROUP BY username
	HAVING C > 1
ORDER BY C DESC;
/* Yes, there are duplicate usernames; The highest number of username showed up is 6 */
  
  -- BONUS
/* Using the dept_emp table, count how many current employees work in each department.
  The query result should show 9 rows, one for each department and the employee count.*/
SELECT dept_no, COUNT(*)
FROM dept_emp
GROUP BY dept_no;
  
/* 11. Determine how many different salaries each employee has had. 
  This includes both historic and current.*/
SELECT emp_no, salary
FROM salaries
GROUP BY emp_no, salary
	HAVING salary > 1
ORDER BY salary DESC;

/* 12. For each employee, find their minimum and maximum salary, and standard deviation of salaries. */
SELECT salary, MIN(salary), MAX(salary)
FROM salaries
GROUP BY salary
;

SELECT emp_no, STD(salary)
FROM salaries
GROUP BY emp_no;

/* 13. Find the max salary for each employee where that max salary is greater than $150,000. */
SELECT emp_no, salary
FROM salaries
GROUP BY emp_no, salary
	HAVING MAX(salary) > 150000
ORDER BY salary ASC;

/* 14. Find the average salary for each employee where that average salary is between $80k and $90k. */
SELECT emp_no, AVG(salary) AS average_salary
FROM salaries
GROUP BY emp_no
	HAVING average_salary BETWEEN 80000 and 90000
;
  
  
  
  
  
  
  
  
  
  

