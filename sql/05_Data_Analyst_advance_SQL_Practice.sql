/* ========================================================== 
Project : 05_Data_Analyst_advance_SQL_Practice
Topic : Advanced SQL Concepts
Database : PostgreSQL 
Author : Chandra Patel 
GitHub : https://github.com/Chandrabhawan 
Created : 29-Jun-2026 Version : 1.0 
Description: This file contains advanced PostgreSQL SQL queries commonly asked in Data Analyst interviews.

========================================================== */

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


-- ==========================================================
-- SUBQUERIES
-- ==========================================================

-- Why do we need Subqueries?
-- A subquery is a query written inside another SQL query.
-- It helps break complex problems into smaller, reusable queries.

-- Types of Subqueries:
-- 1. Independent (Non-Correlated) Subquery
-- 2. Correlated Subquery


-- ==========================================================
-- Independent (Non-Correlated) Subquery
-- ==========================================================

-- Problem:
-- Display employees whose salary is greater than
-- the average salary of their department.

-- Step 1:
-- Calculate the average salary for each department.
-- Step 2:
-- Join the result with the employee table.
-- Step 3:
-- Filter employees whose salary is greater than
-- their department's average salary.

SELECT
    e.*,
    d.avg_dept_salary
FROM emp e
INNER JOIN
(
    SELECT
        dept_id,
        AVG(salary) AS avg_dept_salary
    FROM emp
    GROUP BY dept_id
) d
ON e.dept_id = d.dept_id
WHERE e.salary > d.avg_dept_salary;

-- Characteristics:
-- ✔ Can be executed independently.
-- ✔ Executes only once.
-- ✔ Generally performs better for large datasets.


-- ==========================================================
-- Correlated Subquery
-- ==========================================================

-- Problem:
-- Display employees whose salary is greater than
-- the average salary of their own department.

-- The inner query references the outer query (e1),
-- so it is evaluated once for every row returned
-- by the outer query.

SELECT *
FROM emp e1
WHERE salary >
(
    SELECT AVG(e2.salary)
    FROM emp e2
    WHERE e1.dept_id = e2.dept_id
);

-- Characteristics:
-- ✔ Cannot be executed independently.
-- ✔ References columns from the outer query.
-- ✔ Executes once for each row processed by the outer query.
-- ✔ Usually slower than a non-correlated subquery on large datasets.


-- ==========================================================
-- Interview Tip
-- ==========================================================

-- Independent Subquery
-- • Runs once.
-- • Can execute independently.
-- • Better performance.

-- Correlated Subquery
-- • Runs once for every outer row.
-- • Depends on the outer query.
-- • Easier to write for row-by-row comparisons.


-- CTE: common table expesion / with clause


-- ==========================================================
-- COMMON TABLE EXPRESSIONS (CTE)
-- ==========================================================

-- CTE (Common Table Expression) using the WITH clause.
-- CTEs improve query readability and simplify complex SQL logic.

-- ----------------------------------------------------------
-- Find employees whose salary is greater than the
-- overall average salary without using a CTE.
-- ----------------------------------------------------------

select *
from emp
where salary > (select avg(salary) from emp);


-- ----------------------------------------------------------
-- Find employees whose salary is greater than the
-- overall average salary using a CTE.
-- ----------------------------------------------------------

with avg_salary as (
select avg(salary) as avg_sal from emp
)
select * from emp
inner join avg_salary on salary > avg_sal;


-- ----------------------------------------------------------
-- Demonstrate multiple CTEs.
-- First CTE calculates average salary.
-- Second CTE performs another calculation on the CTE result.
-- ----------------------------------------------------------

with avg_salary as (
select avg(salary) as avg_sal from emp
),
max_sal as (select max(avg_sal) as maxsal from avg_salary)
select * from max_sal;

-- ----------------------------------------------------------
-- Calculate department-wise average salary and
-- find the highest department average salary.
-- ----------------------------------------------------------

WITH avg_salary AS (
    SELECT
        dept_id,
        AVG(salary) AS avg_sal
    FROM emp
    GROUP BY dept_id
),
max_sal AS (
    SELECT MAX(avg_sal) AS max_avg_salary
    FROM avg_salary
)
SELECT *
FROM max_sal;


-- ==========================================================
-- AGGREGATE FUNCTIONS
-- ==========================================================

-- Display all sales records.

select * from sales;

-- Calculate total sales amount.

select sum(amount) from sales;

-- Calculate total sales for each salesperson.

select salesperson_id, sum(amount)
from sales
group by salesperson_id;


-- ==========================================================
-- WINDOW FUNCTIONS
-- ==========================================================

-- Calculate total sales for each salesperson
-- while preserving all rows.

select salesperson_id, order_number, order_date
,sum(amount) over(partition by salesperson_id) as total_salesperson_sales
from sales;

-- Calculate cumulative (running) sales
-- ordered by order date.

select salesperson_id, order_number, order_date, amount
,sum(amount) over(order by order_date)
from sales;

-- Calculate running total separately
-- for each salesperson.

select salesperson_id, order_number, order_date, amount
,sum(amount) over(PARTITION by salesperson_id order by order_date)
from sales;

-- Calculate moving sum using the current row
-- and the previous two rows.

select salesperson_id, order_number, order_date, amount
,sum(amount) over(order by order_date rows between 2 PRECEDING and current ROW)
from sales;

-- Calculate the sum of only the previous two rows.

select salesperson_id, order_number, order_date, amount
,sum(amount) over(order by order_date rows between 2 PRECEDING and 1 PRECEDING)
from sales;

-- Calculate moving sum using one previous row,
-- current row and one following row.

select salesperson_id, order_number, order_date, amount
,sum(amount) over(order by order_date rows between 1 PRECEDING and 1 FOLLOWING)
from sales;

-- Calculate cumulative total from the
-- first row to the current row.

select salesperson_id, order_number, order_date, amount
,sum(amount) over(order by order_date rows between UNBOUNDED PRECEDING and current row)
from sales;

-- Calculate moving total for each salesperson.

select salesperson_id, order_number, order_date, amount
,sum(amount) over(PARTITION by salesperson_id order by order_date rows between 1 PRECEDING and current row)
from sales;

-- Display only the previous row's value.

select salesperson_id, order_number, order_date, amount
,sum(amount) over(order by order_date rows between 1 PRECEDING and 1 PRECEDING)
from sales;


-- ==========================================================
-- RANKING FUNCTIONS
-- ==========================================================

-- Compare RANK(), DENSE_RANK() and ROW_NUMBER()
-- based on employee salary.

select *
, rank() over(order by salary desc) as rn
, dense_rank() over(order by salary desc) as dense_rn
, row_number() over(order by salary desc) as row_num_rn
from emp;

-- Compare ranking functions using
-- salary and employee age.

select *
, rank() over(order by salary desc, emp_age desc) as rn
, dense_rank() over(order by salary desc, emp_age desc) as dense_rn
, row_number() over(order by salary desc, emp_age desc) as row_num_rn
from emp;

-- Rank employees based on employee ID.

select *
, rank() over(order by emp_id desc) as rn
, dense_rank() over(order by emp_id desc) as dense_rn
, row_number() over(order by emp_id desc) as row_num_rn
from emp;

-- Rank employees within each department
-- and manager.

select *
, rank() over(partition by dept_id, manager_id order by salary desc) as rn
, dense_rank() over(partition by dept_id, manager_id order by salary desc) as dense_rn
, row_number() over(partition by dept_id, manager_id order by salary desc) as row_num_rn
from emp;


-- ==========================================================
-- TOP N EMPLOYEES PER DEPARTMENT
-- ==========================================================

-- Retrieve the highest-paid employee(s)
-- from each department.

with cte as (
select *
, rank() over(partition by dept_id order by salary desc) as rn
, dense_rank() over(partition by dept_id order by salary desc) as dense_rn
, row_number() over(partition by dept_id order by salary desc) as row_num_rn
from emp)
select * from cte
where dense_rn = 1;

-- Alternative approach using DENSE_RANK().

SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) AS salary_rank
    FROM emp
) t
WHERE salary_rank = 1;


-- ----------------------------------------------------------
-- Retrieve the top 2 highest-paid employees
-- from each department.
-- ----------------------------------------------------------

with cte as (
select *
, rank() over(partition by dept_id order by salary desc) as rn
, dense_rank() over(partition by dept_id order by salary desc) as dense_rn
, row_number() over(partition by dept_id order by salary desc) as row_num_rn
from emp)
select * from cte
where row_num_rn <= 2;


--LEAD/LAG window FUNCTIONS

-- ==========================================================
-- LEAD() & LAG() WINDOW FUNCTIONS
-- ==========================================================

-- LEAD() and LAG() are window functions used to access
-- values from the next or previous row without using
-- a self join.

select * from orders;


-- ----------------------------------------------------------
-- Calculate total sales for each year.
-- Use LAG() to retrieve the previous year's sales.
-- Calculate Year-over-Year (YoY) sales difference.
-- ----------------------------------------------------------

with year_sales AS
(select extract(year from order_date) as order_year, sum(sales) as sales
from orders
group by extract(year from order_date))
select *
,lag(sales, 1,0) over(order by order_year) as previour_year_sales
,sales-lag(sales,1,0) over(order by order_year)
from year_sales
order by order_year;


-- ----------------------------------------------------------
-- Calculate total sales for each year.
-- Use LEAD() to retrieve the next year's sales.
-- ----------------------------------------------------------

with year_sales AS
(select extract(year from order_date) as order_year, sum(sales) as sales
from orders
group by extract(year from order_date))
select *
,lead(sales, 1,0) over(order by order_year) as next_year_sales
from year_sales
order by order_year;


-- ----------------------------------------------------------
-- Use LEAD() with descending order.
-- Since the data is sorted in descending order,
-- LEAD() returns the previous year's sales.
-- ----------------------------------------------------------

with year_sales AS
(select extract(year from order_date) as order_year, sum(sales) as sales
from orders
group by extract(year from order_date))
select *
,lead(sales, 1,0) over(order by order_year desc) as prev_year_sales
from year_sales
order by order_year;


-- ----------------------------------------------------------
-- Calculate yearly sales for each region.
-- This result can be used for regional trend analysis
-- and further LEAD()/LAG() operations.
-- ----------------------------------------------------------

with year_sales AS
(select region, extract(year from order_date) as order_year, sum(sales) as sales
from orders
group by region, extract(year from order_date))
select *
--,lead(sales, 1,0) over(order by order_year desc) as prev_year_sales
from year_sales
order by order_year;


-- ==========================================================
-- Interview Notes
-- ==========================================================

-- LAG(column, offset, default)
-- • Returns a value from a previous row.
-- • Commonly used for Year-over-Year (YoY) analysis.
-- • Useful for trend and variance calculations.

-- LEAD(column, offset, default)
-- • Returns a value from a following row.
-- • Used for forecasting and future comparisons.

-- offset
-- • Number of rows to move forward or backward.
-- • Default value is 1.

-- default
-- • Value returned when no previous or next row exists.
-- • In these examples, 0 is returned.


with year_sales AS
(select region, extract(year from order_date) as order_year, sum(sales) as sales
from orders
group by region, extract(year from order_date))
select *
,lag(sales, 2,0) over(PARTITION by region order by order_year) as prev_year_sales
from year_sales
order by order_year;


--self JOIN

select e.emp_id, e.emp_name, m.emp_name as manager_name, e.salary, m.salary as manager_s
from emp e
inner join emp m on e.manager_id = m.emp_id
where e.salary > m.salary;


--interview quetion: no of records with diffrent kinds of join when there are duplicate key value
insert into t1 values (1);
INSERT into t2 values (1);
select * from t1;
select * from t2;

select * from t1
inner join t2 on t1.id1=t2.id2;

select * from t1
LEFT join t2 on t1.id1=t2.id2;

select * from t1
right join t2 on t1.id1=t2.id2;

select * from t1
full outer join t2 on t1.id1=t2.id2;





