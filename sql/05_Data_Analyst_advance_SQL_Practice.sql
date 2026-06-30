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

-- Find employees whose salary is greater than the
-- overall average salary without using a CTE.

SELECT *
FROM emp
WHERE salary > (
    SELECT AVG(salary)
    FROM emp
);

-- Calculate the overall average salary using a CTE
-- and compare each employee's salary with it.

WITH avg_salary AS (
    SELECT AVG(salary) AS avg_sal
    FROM emp
)
SELECT *
FROM emp
INNER JOIN avg_salary
ON salary > avg_sal;

-- Demonstrate multiple CTEs.
-- The first CTE calculates the average salary,
-- while the second CTE performs another calculation
-- on the first CTE result.

WITH avg_salary AS (
    SELECT AVG(salary) AS avg_sal
    FROM emp
),
max_sal AS (
    SELECT MAX(avg_sal) AS maxsal
    FROM avg_salary
)
SELECT *
FROM max_sal;

-- Calculate department-wise average salary and
-- find the highest department average salary.

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

SELECT *
FROM sales;

-- Calculate total sales amount.

SELECT SUM(amount)
FROM sales;

-- Calculate total sales for each salesperson.

SELECT
    salesperson_id,
    SUM(amount)
FROM sales
GROUP BY salesperson_id;


-- ==========================================================
-- WINDOW FUNCTIONS
-- ==========================================================

-- Calculate total sales for each salesperson
-- without collapsing rows.

SELECT
    salesperson_id,
    order_number,
    order_date,
    SUM(amount) OVER (
        PARTITION BY salesperson_id
    ) AS total_salesperson_sales
FROM sales;

-- Calculate cumulative (running) sales ordered
-- by order date.

SELECT
    salesperson_id,
    order_number,
    order_date,
    amount,
    SUM(amount) OVER (
        ORDER BY order_date
    )
FROM sales;

-- Calculate running total separately
-- for each salesperson.

SELECT
    salesperson_id,
    order_number,
    order_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY salesperson_id
        ORDER BY order_date
    )
FROM sales;

-- Calculate moving sum using
-- current row and previous two rows.

SELECT
    salesperson_id,
    order_number,
    order_date,
    amount,
    SUM(amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    )
FROM sales;

-- Calculate sum of previous two rows only.

SELECT
    salesperson_id,
    order_number,
    order_date,
    amount,
    SUM(amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING
    )
FROM sales;

-- Calculate moving sum using one previous,
-- current and one following row.

SELECT
    salesperson_id,
    order_number,
    order_date,
    amount,
    SUM(amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    )
FROM sales;

-- Calculate cumulative total from
-- first row until current row.

SELECT
    salesperson_id,
    order_number,
    order_date,
    amount,
    SUM(amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    )
FROM sales;

-- Calculate moving total for each salesperson.

SELECT
    salesperson_id,
    order_number,
    order_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY salesperson_id
        ORDER BY order_date
        ROWS BETWEEN 1 PRECEDING
        AND CURRENT ROW
    )
FROM sales;

-- Return only the previous row value.

SELECT
    salesperson_id,
    order_number,
    order_date,
    amount,
    SUM(amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 1 PRECEDING
        AND 1 PRECEDING
    )
FROM sales;


-- ==========================================================
-- RANKING FUNCTIONS
-- ==========================================================

-- Compare RANK(), DENSE_RANK(),
-- and ROW_NUMBER() based on salary.

SELECT *,
       RANK() OVER (ORDER BY salary DESC) AS rn,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rn,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num_rn
FROM emp;

-- Compare ranking using salary
-- and employee age.

SELECT *,
       RANK() OVER (ORDER BY salary DESC, emp_age DESC) AS rn,
       DENSE_RANK() OVER (ORDER BY salary DESC, emp_age DESC) AS dense_rn,
       ROW_NUMBER() OVER (ORDER BY salary DESC, emp_age DESC) AS row_num_rn
FROM emp;

-- Rank employees by employee ID.

SELECT *,
       RANK() OVER (ORDER BY emp_id DESC) AS rn,
       DENSE_RANK() OVER (ORDER BY emp_id DESC) AS dense_rn,
       ROW_NUMBER() OVER (ORDER BY emp_id DESC) AS row_num_rn
FROM emp;

-- Rank employees within each
-- department and manager.

SELECT *,
       RANK() OVER (
           PARTITION BY dept_id, manager_id
           ORDER BY salary DESC
       ) AS rn,
       DENSE_RANK() OVER (
           PARTITION BY dept_id, manager_id
           ORDER BY salary DESC
       ) AS dense_rn,
       ROW_NUMBER() OVER (
           PARTITION BY dept_id, manager_id
           ORDER BY salary DESC
       ) AS row_num_rn
FROM emp;


-- ==========================================================
-- TOP N EMPLOYEES PER DEPARTMENT
-- ==========================================================

-- Retrieve the highest-paid employee(s)
-- from each department.

WITH cte AS (
    SELECT *,
           RANK() OVER (
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) AS rn,
           DENSE_RANK() OVER (
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) AS dense_rn,
           ROW_NUMBER() OVER (
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) AS row_num_rn
    FROM emp
)
SELECT *
FROM cte
WHERE dense_rn = 1;

-- Alternative solution using DENSE_RANK().

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

-- Retrieve the top two highest-paid
-- employees from each department.

WITH cte AS (
    SELECT *,
           RANK() OVER (
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) AS rn,
           DENSE_RANK() OVER (
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) AS dense_rn,
           ROW_NUMBER() OVER (
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) AS row_num_rn
    FROM emp
)
SELECT *
FROM cte
WHERE row_num_rn <= 2;














	