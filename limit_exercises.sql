SHOW databases;
USE employees;
SELECT database();
SHOW tables;
SELECT * FROM titles;
/* 2. MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. 
For example, to find all the unique titles within the company, we could run the following query:
SELECT DISTINCT title FROM titles;
List the first 10 distinct last names sorted in descending order. */
SELECT DISTINCT title FROM titles WHERE title IS NOT NULL ORDER BY last_name DESC;

/* 3. Find all previous or current employees hired in the 90s and born on Christmas. 
Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. 
Write a comment in your code that lists the five names of the employees returned. */
SELECT * FROM employees WHERE hire_date LIKE '199%' AND birth_date LIKE '%12-25' ORDER BY first_name ASC LIMIT 5;

/* 4. Try to think of your results as batches, sets, or pages. The first five results are your first page. 
The five after that would be your second page, etc. Update the query to find the tenth page of results.
LIMIT and OFFSET can be used to create multiple pages of data. 
What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number? */
SELECT * FROM employees WHERE hire_date LIKE '199%' AND birth_date LIKE '%12-25' ORDER BY first_name ASC LIMIT 5 OFFSET 45;
# (Limit multiplied  by page number (10) - the first page (5) = 45 )



