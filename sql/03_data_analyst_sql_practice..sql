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


-- ==========================================================
-- IN Operator
-- Retrieve records where quantity is either 3, 4, or 5.
-- ==========================================================

SELECT *
FROM orders_data
WHERE quantity IN (3,4,5)
ORDER BY quantity;


-- ==========================================================
-- OR Operator
-- Retrieve records where quantity is either 3 or 5.
-- Equivalent to using the IN operator.
-- ==========================================================

SELECT *
FROM orders_data
WHERE quantity = 3 OR quantity = 5
ORDER BY quantity;


-- ==========================================================
-- IN Operator with String Values
-- Retrieve records where city is Los Angeles or Houston.
-- ==========================================================

SELECT *
FROM orders_data
WHERE city IN ('Los Angeles','Houston')
ORDER BY city;


-- ==========================================================
-- BETWEEN Operator
-- Retrieve orders placed between two dates (inclusive).
-- ==========================================================

SELECT *
FROM orders_data
WHERE order_date BETWEEN '2019-12-27' AND '2021-12-09'
ORDER BY order_date;


-- ==========================================================
-- NOT IN Operator
-- Retrieve records excluding quantities 3 and 5.
-- ==========================================================

SELECT *
FROM orders_data
WHERE quantity NOT IN (3,5);


-- ==========================================================
-- Pattern Matching using LIKE
-- Customer name starts with 'S'
-- ==========================================================

SELECT *
FROM orders_data
WHERE customer_name LIKE 'S%';


-- ==========================================================
-- Customer name ends with 'n'
-- ==========================================================

SELECT *
FROM orders_data
WHERE customer_name LIKE '%n';


-- ==========================================================
-- Customer name contains the letter 'e'
-- ==========================================================

SELECT *
FROM orders_data
WHERE customer_name LIKE '%e%';


-- ==========================================================
-- Customer name where the second character is 'e'
-- ==========================================================

SELECT *
FROM orders_data
WHERE customer_name LIKE '_e%';


-- ==========================================================
-- Regular Expression
-- Customer name where the second character is 'a' or 'e'
-- ==========================================================

SELECT *
FROM orders_data
WHERE customer_name ~ '^.[ae]';


-- ==========================================================
-- SIMILAR TO
-- Alternative to regular expressions.
-- ==========================================================

SELECT *
FROM orders_data
WHERE customer_name SIMILAR TO '(_[ae]%)';


-- ==========================================================
-- Aggregate Functions
-- Calculate total sales.
-- ==========================================================

SELECT SUM(sales) AS total_sales
FROM orders_data;


-- ==========================================================
-- Find minimum sales value.
-- ==========================================================

SELECT MIN(sales) AS min_sales
FROM orders_data;


-- ==========================================================
-- Find maximum sales value.
-- ==========================================================

SELECT MAX(sales) AS max_sales
FROM orders_data;


-- ==========================================================
-- Calculate total sales and total profit.
-- ==========================================================

SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders_data;


-- ==========================================================
-- Calculate average sales.
-- ==========================================================

SELECT AVG(sales) AS avg_sales
FROM orders_data;


-- ==========================================================
-- Count total number of records.
-- ==========================================================

SELECT COUNT(*) AS no_of_records
FROM orders_data;


-- ==========================================================
-- Calculate average sales manually.
-- ==========================================================

SELECT SUM(sales) / COUNT(*) AS avg_sales
FROM orders_data;


-- ==========================================================
-- Update city to NULL for selected orders.
-- Used for practicing NULL handling.
-- ==========================================================

UPDATE orders_data
SET city = NULL
WHERE order_id IN ('CA-2020-152156','CA-2018-115812');


-- ==========================================================
-- COUNT(column) ignores NULL values.
-- ==========================================================

SELECT COUNT(city)
FROM orders_data;


-- ==========================================================
-- Retrieve rows where city is NULL.
-- ==========================================================

SELECT *
FROM orders_data
WHERE city IS NULL;


-- ==========================================================
-- Retrieve rows where city is NOT NULL.
-- ==========================================================

SELECT *
FROM orders_data
WHERE city IS NOT NULL;


-- ==========================================================
-- Difference between COUNT(*), COUNT(column),
-- COUNT(1), and COUNT(DISTINCT).
-- ==========================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS total_orders,
    COUNT(city) AS no_of_city,
    COUNT(1) AS count_one
FROM orders_data;


-- ==========================================================
-- Retrieve unique product categories.
-- ==========================================================

SELECT DISTINCT category
FROM orders_data;


-- ==========================================================
-- COUNT Examples
-- ==========================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id),
    COUNT(city),
    COUNT('chandra'),
    COUNT(DISTINCT category),
    COUNT(DISTINCT city)
FROM orders_data;


-- ==========================================================
-- GROUP BY
-- Calculate total sales and profit by category and region.
-- ==========================================================

SELECT
    category,
    region,
    SUM(sales) AS category_sales,
    SUM(profit) AS category_profit
FROM orders_data
GROUP BY category, region
ORDER BY region, category;


-- ==========================================================
-- HAVING Clause
-- Display cities where total sales exceed 500.
-- ==========================================================

SELECT
    city,
    SUM(sales) AS city_sales
FROM orders_data
GROUP BY city
HAVING SUM(sales) > 500;


-- ==========================================================
-- WHERE + GROUP BY + HAVING
-- Calculate city sales only for the West region.
-- ==========================================================

SELECT
    city,
    SUM(sales) AS city_sales
FROM orders_data
WHERE region = 'West'
GROUP BY city
HAVING SUM(sales) > 500
ORDER BY city_sales
LIMIT 2;


-- Query Execution Order:
-- FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT


-- ==========================================================
-- Display return records.
-- ==========================================================

SELECT *
FROM returns_data;


-- ==========================================================
-- INNER JOIN
-- Retrieve matching records from orders_data and returns_data.
-- ==========================================================

SELECT *
FROM orders_data
INNER JOIN returns_data
ON orders_data.order_id = returns_data.order_id;


-- ==========================================================
-- Calculate sales by category for returned orders.
-- ==========================================================

SELECT
    category,
    SUM(sales)
FROM orders_data
INNER JOIN returns_data
ON orders_data.order_id = returns_data.order_id
GROUP BY category;


-- ==========================================================
-- Display orders returned due to "Wrong Items".
-- ==========================================================

SELECT *
FROM orders_data
INNER JOIN returns_data
ON orders_data.order_id = returns_data.order_id
WHERE return_reason = 'Wrong Items';


-- ==========================================================
-- Case-insensitive filtering using ILIKE.
-- ==========================================================

SELECT *
FROM orders_data o
INNER JOIN returns_data r
ON o.order_id = r.order_id
WHERE r.return_reason ILIKE 'wrong items'
AND o.city = 'Los Angeles';


-- ==========================================================
-- Retrieve details for a specific order.
-- ==========================================================

SELECT *
FROM orders_data
INNER JOIN returns_data
ON orders_data.order_id = returns_data.order_id
WHERE orders_data.order_id = 'CA-2020-109806';

```sql
-- ==========================================================
-- JOINS
-- ==========================================================

-- Retrieve the order date and return reason for a specific order.
SELECT o.order_date, r.return_reason
FROM orders_data o
INNER JOIN returns_data r
ON o.order_id = r.order_id
WHERE o.order_id = 'CA-2020-109806';

-- Query Execution Order:
-- FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT

-- Retrieve all orders along with their return information.
-- Orders without returns will display NULL values.
SELECT *
FROM orders_data o
LEFT JOIN returns_data r
ON o.order_id = r.order_id;

-- Retrieve orders that have not been returned.
SELECT *
FROM orders_data o
LEFT JOIN returns_data r
ON o.order_id = r.order_id
WHERE r.return_reason IS NULL;

-- Retrieve only returned orders.
SELECT o.*, r.return_reason
FROM orders_data o
INNER JOIN returns_data r
ON o.order_id = r.order_id;

-- Calculate total sales grouped by return reason.
SELECT
    r.return_reason,
    SUM(o.sales) AS return_sales
FROM orders_data o
LEFT JOIN returns_data r
ON o.order_id = r.order_id
GROUP BY r.return_reason;

-- Correct an incorrect order_id in returns_data.
UPDATE returns_data
SET order_id = 'US-2019-164175'
WHERE order_id = 'US-2018-164175';

-- Standardize inconsistent return reasons using CASE.
SELECT *,
       CASE
           WHEN return_reason = 'Wrong Item'
           THEN 'Wrong Items'
           ELSE return_reason
       END AS new_return_reason
FROM returns_data;


-- ==========================================================
-- CASE WHEN
-- ==========================================================

-- Categorize orders based on profit values.
SELECT *,
       CASE
           WHEN profit < 0 THEN 'Loss'
           WHEN profit < 50 THEN 'Low Profit'
           WHEN profit < 100 THEN 'High Profit'
           ELSE 'Very High Profit'
       END AS profit_bucket
FROM orders_data;

-- Categorize profit using the BETWEEN operator.
SELECT *,
       CASE
           WHEN profit < 0 THEN 'Loss'
           WHEN profit BETWEEN 0 AND 49 THEN 'Low Profit'
           WHEN profit BETWEEN 50 AND 99 THEN 'High Profit'
           ELSE 'Very High Profit'
       END AS profit_bucket
FROM orders_data;


-- ==========================================================
-- STRING FUNCTIONS
-- ==========================================================

-- Demonstration of commonly used PostgreSQL string functions.
-- LENGTH(), LEFT(), RIGHT(), SUBSTRING(), REPLACE()

SELECT *,
       LENGTH(customer_name) AS cust_length,
       LEFT(order_id,2) AS order_prefix,
       RIGHT(order_id,6) AS order_suffix,
       SUBSTRING(order_id,4,4) AS order_year,
       SUBSTRING(order_id,6,2) AS order_sequence,
       REPLACE(customer_name,'Cl','Pa') AS updated_name
FROM orders_data;


-- ==========================================================
-- DATE FUNCTIONS
-- ==========================================================

-- Extract different parts of a date.
SELECT
    order_id,
    order_date,
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    EXTRACT(WEEK FROM order_date) AS order_week
FROM orders_data;

-- Calculate total monthly sales.
SELECT
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(sales) AS total_sales
FROM orders_data
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY order_month;

-- Calculate monthly sales by year.
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(sales) AS total_sales
FROM orders_data
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    order_year,
    order_month;

-- Format dates using TO_CHAR().
SELECT
    order_id,
    order_date,
    TO_CHAR(order_date,'Month') AS order_month,
    TO_CHAR(order_date,'Mon') AS order_month_short,
    TO_CHAR(order_date,'Day') AS order_day,
    TO_CHAR(order_date,'YYYY') AS order_year
FROM orders_data;


-- ==========================================================
-- DATE DIFFERENCE
-- ==========================================================

-- Calculate shipping duration in days.
SELECT
    order_id,
    order_date,
    ship_date,
    ship_date - order_date AS shipping_days
FROM orders_data;

-- Calculate the interval between order and shipping dates.
SELECT
    order_id,
    order_date,
    ship_date,
    AGE(ship_date, order_date) AS shipping_interval
FROM orders_data;

-- Extract the month component from the interval.
SELECT
    order_id,
    order_date,
    ship_date,
    EXTRACT(MONTH FROM AGE(ship_date, order_date)) AS shipping_month
FROM orders_data;

-- Extract the year component from the interval.
SELECT
    order_id,
    order_date,
    ship_date,
    EXTRACT(YEAR FROM AGE(ship_date, order_date)) AS shipping_year
FROM orders_data;


-- ==========================================================
-- DATE ARITHMETIC
-- ==========================================================

-- Add 10 days to the order date.
SELECT
    order_id,
    order_date,
    ship_date,
    order_date + 10 AS new_date
FROM orders_data;

-- Add and subtract intervals from a date.
SELECT
    order_id,
    order_date,
    ship_date,
    order_date + INTERVAL '10 days' AS plus_10_days,
    order_date + INTERVAL '1 month' AS plus_1_month,
    order_date + INTERVAL '1 year' AS plus_1_year,
    order_date - INTERVAL '15 days' AS minus_15_days
FROM orders_data;


-- ==========================================================
-- LEAD TIME & DELIVERY DATE
-- ==========================================================

-- This query will fail because quantity is NUMERIC.
SELECT
    order_id,
    order_date,
    ship_date,
    quantity,
    ship_date - order_date AS lead_days,
    ship_date + quantity AS delivery_date
FROM orders_data;

-- Convert quantity to INTEGER before adding it to a DATE.
SELECT
    order_id,
    order_date,
    ship_date,
    quantity,
    ship_date - order_date AS lead_days,
    ship_date + quantity::INTEGER AS delivery_date
FROM orders_data;

