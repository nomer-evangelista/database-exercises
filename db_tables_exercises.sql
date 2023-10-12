# List all the databases
show databases;
# Write the SQL code necessary to use the albums_db database
use albums_db;
# Show the currently selected database
select database();
# List all tables in the database
show tables;
# Write the SQL code to switch to the employees database
show databases;
# Show the currently selected database
use employees;
select database();
show tables;
# Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)
-- int , date varchar(14), varchar(16), enum('M', 'F') 
describe departments;
describe dept_emp;
describe dept_manager;
describe employees;
describe salaries;
describe titles;
# Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)
-- departments, dept_emp, dept_manager, employees, salaries, title
# Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)
-- departments, dept_emp, dept_manager, employees, titles
# Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)
-- dept_emp, dept_manager, dept_manager, employees, titles
# What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
-- emp_no
show databases;
use employees;
select database();
show tables;
describe dept_manager;
-- Right click on dept_manager (table inspector) and click DDL to show soure code
show tables;
describe dept_manager;
# Show the SQL code that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
show create table dept_manager;



