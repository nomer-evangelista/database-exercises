SHOW databases;
USE join_example_db;
SELECT database();
SHOW tables;

# Join Example Database
/* 1. Use the join_example_db. Select all the records from both the users 
and roles tables. */
SELECT * 
FROM users;
SELECT *
FROM roles;

/* 2. Use join, left join, and right join to combine results from the users 
and roles tables as we did in the lesson. Before you run each query, 
guess the expected number of results. */
SELECT *
FROM users AS u
JOIN roles AS r 
ON u.id = r.id;

SELECT *
FROM users AS u
LEFT JOIN roles AS r
ON u.id = r.id;

SELECT *
FROM users AS u
RIGHT JOIN roles AS r
ON u.id = r.id;

/* 3.Although not explicitly covered in the lesson, aggregate functions 
like count can be used with join queries. Use count and the appropriate 
join type to get a list of roles along with the number of users that have the role.
 Hint: You will also need to use group by in the query. */
SELECT role_id, COUNT(*)
FROM users AS u
RIGHT JOIN roles AS r
ON u.id = r.id
GROUP BY role_id;

# Employee Database
SHOW databases;
USE employees;
SELECT database();
SHOW tables;

SELECT *
FROM departments;
SELECT *
FROM dept_manager;
SELECT *
FROM employees;
SELECT *
FROM titles;
SELeCT *
FROM dept_emp;
/* 2. Using the example in the Associative Table Joins section as a guide, 
write a query that shows each department along with the name of the 
current manager for that department. */
SELECT dept_name, CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM departments AS dp
JOIN dept_manager AS dm
ON dp.dept_no = dm.dept_no
JOIN employees AS emp
ON dm.emp_no = emp.emp_no
GROUP BY to_date, dept_name, first_name, last_name
HAVING to_date LIKE '9999%';

/** 3. Find the name of all departments currently managed by women. */
SELECT dept_name, CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM departments AS dp
JOIN dept_manager AS dm
ON dp.dept_no = dm.dept_no
JOIN employees AS emp
ON dm.emp_no = emp.emp_no
GROUP BY to_date, dept_name, first_name, last_name, gender
HAVING to_date LIKE '9999%' AND gender = 'F';

/* 4. Find the current titles of employees currently working 
in the Customer Service department. */
SELECT title, dept_name, COUNT(*)
FROM departments AS dp
JOIN dept_emp AS de
ON dp.dept_no = de.dept_no
JOIN titles AS t
ON de.emp_no = t.emp_no
WHERE dept_name LIKE 'Customer Service' AND de.to_date LIKE '9999%'
AND t.to_date LIKE '9999%'
GROUP BY title, dept_name;

/* 5.Find the current salary of all current managers. */
SELECT dept.dept_name, CONCAT(first_name, ' ', last_name) AS manager, salary 
FROM dept_manager AS dm
JOIN salaries AS sal
ON dm.emp_no = sal.emp_no
JOIN employees AS e
ON e.emp_no = dm.emp_no
JOIN departments AS dept
ON dm.dept_no = dept.dept_no
WHERE dm.to_date LIKE '9999%' AND sal.to_date LIKE '9999%'
ORDER BY dept_name;

/* 6. Find the number of current employees in each department. */
SELECT de.dept_no, dept.dept_name, COUNT(*) AS num_employees
FROM employees AS e
JOIN dept_emp AS de
ON e.emp_no = de.emp_no
JOIN departments AS dept
on dept.dept_no = de.dept_no
WHERE de.to_date LIKE '9999%'
GROUP BY de.dept_no, dept.dept_name
ORDER BY de.dept_no;

/* 7. Which department has the highest average salary? Hint: Use current not historic information. */
SELECT dept.dept_name, round(AVG(salary), 2) AS average_salary -- *, dept.dept_name 
FROM salaries AS s
JOIN dept_emp AS de
ON s.emp_no = de.emp_no
JOIN departments AS dept
ON dept.dept_no = de.dept_no
WHERE s.to_date LIKE '9999%' AND de.to_date LIKE '9999%'
GROUP BY dept.dept_name 
ORDER BY average_salary DESC
LIMIT 1;

/* 8. Who is the highest paid employee in the Marketing department?
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+ */

SELECT first_name, last_name
FROM employees AS e
JOIN salaries AS s
ON e.emp_no = s.emp_no
JOIN dept_emp AS de
ON de.emp_no = e.emp_no
JOIN departments AS dept
ON dept.dept_no = de.dept_no
WHERE dept_name IN ('Marketing')
ORDER BY salary DESC
LIMIT 1;

/* 9. Which current department manager has the highest salary? */
DESCRIBE employees; -- first_name, last_name, emp_no
DESCRIBE salaries; -- emp_no, to_date
DESCRIBE departments; -- dept_no, dept_name
DESCRIBE dept_emp; -- emp_no, dept_no, to-date
DESCRIBE dept_manager; -- emp_no, dept_no, from_date, to_date

SELECT e.first_name, e.last_name, s.salary, dept.dept_name
FROM employees AS e 
JOIN dept_manager AS dm
	ON e.emp_no = dm.emp_no AND dm.to_date > NOW()
JOIN salaries AS s
	ON e.emp_no = s.emp_no AND s.to_date > NOW()
JOIN departments AS dept
	ON dept.dept_no = dm.dept_no
ORDER BY salary DESC 
LIMIT 1
;

/* 10. Determine the average salary for each department. 
Use all salary information and round your results. */
SELECT 
		d.dept_name,
        ROUND(AVG(s.salary),0) AS average_salary -- s.salary AS Average_Salary 
FROM salaries AS s
	JOIN dept_emp AS de
		ON de.emp_no = s.emp_no 
	JOIN departments AS d
		ON d.dept_no = de.dept_no
GROUP BY d.dept_name 
ORDER BY average_salary ASC
;

-- BONUS
/* 11. Find the names of all current employees, 
their department name, and their current manager's name. */
SELECT  
	CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', 
	dept.dept_name AS 'Department Name',
    CONCAT(manager.first_name, ' ', manager.last_name) AS 'Manager Name'
FROM employees AS e
		JOIN dept_emp AS de
			ON de.emp_no = e.emp_no AND de.to_date > CURDATE()
		JOIN dept_manager AS dm
			ON dm.dept_no = de.dept_no AND dm.to_date > NOW() 
		JOIN departments AS dept
			ON dept.dept_no = dm.dept_no
		JOIN employees AS manager
			ON manager.emp_no = dm.emp_no
ORDER BY dept.dept_name
;



