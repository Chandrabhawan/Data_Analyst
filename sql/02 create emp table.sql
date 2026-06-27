-- ========================================================== -- Database : data_analyst
-- Table : employees
-- Author : Chandra Patel
-- GitHub : https://github.com/Chandrabhawan
-- Created : 27-Jun-2026
-- Database : PostgreSQL
-- -- Description:
-- This table stores employee information such as
-- employee details, department, salary, and joining date.
-- ==========================================================

-- Database: data_analyst

-- DROP DATABASE IF EXISTS data_analyst;

CREATE DATABASE data_analyst
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

create table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp
values
(1, 'Ankit', 100,10000, 4, 39);
insert into emp
values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp
values (3, 'Vikas', 100, 10000,4,37);
insert into emp
values (4, 'Rohit', 100, 5000, 2, 16);
insert into emp
values (5, 'Mudit', 200, 12000, 6,55);
insert into emp
values (6, 'Agam', 200, 12000,2, 14);
insert into emp
values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp
values (8, 'Ashish', 200,5000,2,12);
insert into emp
values (9, 'Mukesh',300,6000,6,51);
insert into emp
values (10, 'Rakesh',300,7000,6,50);
insert into emp
values (10, 'Chandra Patel',300,70000,6,25);