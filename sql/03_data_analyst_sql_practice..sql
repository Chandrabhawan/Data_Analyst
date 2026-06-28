/*
==========================================================
Project   : Data Analyst SQL Practice
Database  : PostgreSQL
Author    : Chandra Patel
Created   : 27-Jun-2026
Version   : 1.0

Description:
This file contains PostgreSQL queries for learning
basic SQL concepts and interview preparation.

GitHub:
https://github.com/Chandrabhawan
==========================================================
*/

-- ==========================================================
-- Create Database
-- Creates a new PostgreSQL database named 'data_analyst'
-- ==========================================================

CREATE DATABASE data_analyst
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = FALSE;


-- ==========================================================
-- Display selected columns from the orders_data table
-- ==========================================================

SELECT order_id,
       order_date,
       sales
FROM orders_data;


-- ==========================================================
-- Retrieve the first 10 records from the table
-- ==========================================================

SELECT order_id,
       order_date,
       sales,
       profit
FROM orders_data
LIMIT 10;


-- ==========================================================
-- Pagination Example
-- Skip the first 10 rows and return the next 10 rows
-- ==========================================================

SELECT order_id,
       order_date,
       sales,
       profit
FROM orders_data
LIMIT 10 OFFSET 10;


-- LIMIT 10  -> Return 10 rows
-- OFFSET 10 -> Skip the first 10 rows


-- ==========================================================
-- Sort records by order_date (ascending) and profit (ascending)
-- ==========================================================

SELECT *
FROM orders_data
ORDER BY order_date, profit;


-- ==========================================================
-- Display the latest 5 orders
-- ==========================================================

SELECT *
FROM orders_data
ORDER BY order_date DESC
LIMIT 5;


-- ==========================================================
-- Sort records by latest order date and highest profit
-- ==========================================================

SELECT *
FROM orders_data
ORDER BY order_date DESC,
         profit DESC;


-- ==========================================================
-- Display the top 5 highest sales records
-- ==========================================================

SELECT *
FROM orders_data
ORDER BY sales DESC
LIMIT 5;


-- ==========================================================
-- Calculate Profit Ratio
-- Formula:
-- Profit Ratio = Profit / Sales
-- ==========================================================

SELECT *,
       profit / sales
FROM orders_data;


-- ==========================================================
-- Calculate Profit Ratio using an alias
-- ==========================================================

SELECT *,
       profit / sales AS profit_ratio
FROM orders_data;


-- ==========================================================
-- Calculate:
-- 1. Profit Ratio
-- 2. Difference between Sales and Profit
-- ==========================================================

SELECT *,
       profit / sales AS profit_ratio,
       sales - profit AS difference
FROM orders_data
ORDER BY profit_ratio;


-- ==========================================================
-- Display records where Region is Central
-- ==========================================================

SELECT *
FROM orders_data
WHERE region = 'Central';


-- ==========================================================
-- Display records where Quantity is less than or equal to 5
-- ==========================================================

SELECT *
FROM orders_data
WHERE quantity <= 5
ORDER BY quantity;


-- ==========================================================
-- Display records where Quantity is greater than or equal to 5
-- ==========================================================

SELECT *
FROM orders_data
WHERE quantity >= 5
ORDER BY quantity;


-- ==========================================================
-- Display records where Quantity equals 5
-- ==========================================================

SELECT *
FROM orders_data
WHERE quantity = 5;


-- ==========================================================
-- Display selected columns for Central region
-- ==========================================================

SELECT order_id,
       order_date,
       sales,
       region
FROM orders_data
WHERE region = 'Central';


-- ==========================================================
-- Display orders placed after 17-Sep-2020
-- ==========================================================

SELECT *
FROM orders_data
WHERE order_date > '2020-09-17'
ORDER BY order_date
LIMIT 10;


-- Query Execution Order:
-- FROM → WHERE → SELECT → ORDER BY → LIMIT


-- ==========================================================
-- Multiple conditions using AND
-- Returns records matching all conditions
-- ==========================================================

SELECT *
FROM orders_data
WHERE region = 'Central'
  AND category = 'Technology'
  AND quantity > 2;


-- ==========================================================
-- Multiple conditions using OR and AND
-- Parentheses control operator precedence
-- ==========================================================

SELECT *
FROM orders_data
WHERE (region = 'Central'
       OR category = 'Technology')
  AND quantity > 5
ORDER BY quantity;


-- ==========================================================
-- Display records where Quantity is between 3 and 5
-- ==========================================================

SELECT *
FROM orders_data
WHERE quantity >= 3
  AND quantity <= 5
order by quantity;

-- Alternative:
-- WHERE quantity BETWEEN 3 AND 5;

SELECT *
FROM orders_data
WHERE quantity between 3 and 5
order by quantity;


SELECT *
FROM orders_data
WHERE quantity in(3,4,5)
order by quantity;

SELECT *
FROM orders_data
--WHERE quantity in(3,5)
where quantity=3 or quantity=5
order by quantity;

select *
from orders_data
where city in ('Los Angeles' , 'Houston')
order by city;

select *
from orders_data
where order_date between '2019-12-27' and '2021-12-09'
order by order_date;

select *
from orders_data
where quantity not in (3,5);

--Pattern matching

select *
from orders_data
where customer_name like 'S%';

select *
from orders_data
where customer_name like '%n';

select *
from orders_data
where customer_name like '%e%';


select *
from orders_data
where customer_name like '_e%';

-- 2nd char a or e

SELECT *
FROM orders_data
WHERE customer_name ~ '^.[ae]';

   ---or---

SELECT *
FROM orders_data
WHERE customer_name SIMILAR TO '(_[ae]%)';


--aggregation

SELECT
    SUM(sales) AS total_sales
FROM orders_data;

SELECT
    MIN(sales) AS min_sales
FROM orders_data;

SELECT
    MAX(sales) AS max_sales
FROM orders_data;

SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders_data;

select avg(sales) as avg_sales
from orders_data;

select count(*) as no_of_records
from orders_data;

select sum(sales)/count(*) as avg_sales
from orders_data;

select * from orders_data;


update orders_data set city = null 
where order_id in ('CA-2020-152156', 'CA-2018-115812');


select count(city) from orders_data;


SELECT *
FROM orders_data
WHERE city IS NULL;


SELECT *
FROM orders_data
WHERE city IS not NULL

select count(*), count(order_id), count(city) as no_of_city,
count(1)
from orders_data;

select distinct category
from orders_data;

select count(*), count(order_id), count(city) as no_of_city,
count('chandra'), count(distinct category), count(distinct city)
from orders_data;




























