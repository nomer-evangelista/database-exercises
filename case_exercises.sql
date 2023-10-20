/* 1. Write a query that returns all employees, their department number,
 their start date, their end date, and a new column 'is_current_employee' that 
is a 1 if the employee is still with the company and 0 if not. 
DO NOT WORRY ABOUT DUPLICATE EMPLOYEES */

SHOW databases;
USE employees;
SELECT database();

DESCRIBE dept_emp;
DESCRIBE employees;

SELECT 
		first_name,
        last_name,
        dept_no,
        from_date,
        to_date,
	CASE
		WHEN to_date > NOW() THEN True
        ELSE False
	END AS 'is_current_employees'
FROM employees AS e
JOIN dept_emp AS de
	USING (emp_no)
;

/* 2. Write a query that returns all employee names (previous and current), 
and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending 
on the first letter of their last name. */
SELECT
        last_name,
	CASE 
		WHEN last_name BETWEEN 'A%' AND 'H%' THEN 'A_to_H_Group' -- Alternate: WHEN left(last_name,1) <= THEN 'A-H'
        WHEN last_name BETWEEN 'I%' AND 'Q%' THEN 'I_to_Q_Group' -- Alternate: WHEN substring(last_name, 1,1) <= 'Q'
        ELSE 'R_to_Z_Group'
	END AS 'alpha_group'
FROM employees  
ORDER BY first_name
;

/* 3. How many employees (current or previous) were born in each decade? */
SELECT COUNT(*),
	CASE 
        WHEN birth_date BETWEEN '1970-01-01' AND '1979-12-31' THEN 'born_1970+'
		WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN 'born_1960+'
        WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN 'born_1950+'
        ELSE 'born_earlier than 1940\'s'
	END AS 'employees_birth_year'
FROM employees
GROUP BY employees_birth_year
;

/* 4. What is the current average salary for each of the following department 
groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service? */
DESCRIBE employees; -- emp_no, 
DESCRIBE departments; -- dept_no, dept_name
DESCRIBE salaries; -- emp_no, salary, from_date, to_date
DESCRIBE dept_emp; -- emp_no, dept_no, from_date, to_date

SELECT 
	CASE
			WHEN dept_name IN ('Customer Service') THEN 'Customer Service' 
            WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
            WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
            WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
            WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
	ELSE 'Others'
	END AS dept_group
    , ROUND(AVG(salary), 2)
FROM departments AS d
	JOIN dept_emp AS de
		ON de.dept_no = d.dept_no AND de.to_date > NOW()
	JOIN salaries AS s
		ON s.emp_no = de.emp_no AND s.to_date > NOW()
GROUP BY dept_group
;


SELECT *
FROM departments
WHERE dept_name IN (SELECT 
			dept_name, ROUND(AVG(salary), 2), 
		CASE
			WHEN dept_name IN ('Customer Service') THEN 'Customer Service' 
            WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
            WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
            WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
            WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
		ELSE 'Others'
		END AS 'department group'
		FROM departments AS d
			JOIN dept_emp AS de
				ON de.dept_no = d.dept_no AND de.to_date > NOW()
			JOIN salaries AS s
				ON s.emp_no = de.emp_no AND s.to_date > NOW()
		GROUP BY dept_name)
;

