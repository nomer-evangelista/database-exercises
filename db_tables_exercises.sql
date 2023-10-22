# 3.  List all the databases
show databases;

# 4. Write the SQL code necessary to use the albums_db database
use albums_db;

# 5. Show the currently selected database
select database();

# 6.List all tables in the database
show tables;

# 7. Write the SQL code to switch to the employees database
show databases;
use employees;
select database();

# 8. Show the currently selected database
use employees;
select database();
show tables;

# 9. List all tables in the database
show tables;
-- departments, dept_emp, dept_manager, employees, salaries, titles

# 10. Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)
describe departments;
describe dept_emp;
describe dept_manager;
describe employees;
describe salaries;
describe titles;
-- dept_emp, dept_manager, employees, salaries, title

# 11. Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment) 
-- int , date varchar(14), varchar(16), enum('M', 'F') 

# 12. Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)
-- departments, dept_emp, dept_manager, employees, titles

# 13. Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)
-- dept_emp, dept_manager, dept_manager, employees, titles

# 14. What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
-- emp_no
show databases;
use employees;
select database();
show tables;
describe dept_manager;
-- Right click on dept_manager (table inspector) and click DDL to show soure code
show tables;
describe dept_manager;

# 15. how the SQL code that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
show create table dept_manager;



