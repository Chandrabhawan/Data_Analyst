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

--withount CTE
select *
from emp
where salary > (select avg(salary) from emp);


--With CTE
with avg_salary as (
select avg(salary) as avg_sal from emp
)
select * from emp
inner join avg_salary on salary > avg_sal;


with avg_salary as (
select avg(salary) as avg_sal from emp
),
max_sal as (select max(avg_sal) as maxsal from avg_salary)
select * from max_sal;
--inner join avg_salary on salary > avg_sal;

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


--all about aggregation in sql. sum(), avg(), min(), max()

select * from sales;

select sum(amount) from sales;

select salesperson_id, sum(amount) 
from sales
group by salesperson_id;

--window function
select salesperson_id, order_number, order_date
,sum(amount) over(partition by salesperson_id) as total_salesperson_sales
from sales;


select salesperson_id, order_number, order_date, amount
,sum(amount) over(order by order_date)
from sales;

select salesperson_id, order_number, order_date, amount
,sum(amount) over(PARTITION by salesperson_id order by order_date)
from sales;


select salesperson_id, order_number, order_date, amount
,sum(amount) over(order by order_date rows between 2 PRECEDING and current ROW)
from sales;

select salesperson_id, order_number, order_date, amount
,sum(amount) over(order by order_date rows between 2 PRECEDING and 1 PRECEDING)
from sales;


select salesperson_id, order_number, order_date, amount
,sum(amount) over(order by order_date rows between 1 PRECEDING and 1 FOLLOWING)
from sales;


select salesperson_id, order_number, order_date, amount
,sum(amount) over(order by order_date rows between UNBOUNDED PRECEDING and current row)
from sales;

select salesperson_id, order_number, order_date, amount
,sum(amount) over(PARTITION by salesperson_id order by order_date rows between 1 PRECEDING and current row)
from sales;

select salesperson_id, order_number, order_date, amount
,sum(amount) over(order by order_date rows between 1 PRECEDING and 1 PRECEDING)
from sales;







	