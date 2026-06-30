	/*
==========================================================
Project    : Data Analyst SQL Practice
Topic      : Sales Table
Database   : PostgreSQL

Author     : Chandra Patel
GitHub     : https://github.com/Chandrabhawan

Description:
This script creates the sales table used for
CTE, Window Functions, Ranking, LEAD/LAG,
Running Total, and SQL interview practice.
==========================================================
*/

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


-- Drop table if it already exists
DROP TABLE IF EXISTS sales;

-- Create Sales Table
CREATE TABLE sales (
    salesperson_id INT,
    order_number INT PRIMARY KEY,
    order_date DATE,
    amount NUMERIC(10,2)
);

-- Insert Sample Data
INSERT INTO sales
(salesperson_id, order_number, order_date, amount)
VALUES
(1, 30, '1995-07-14', 460),
(2, 10, '1996-08-02', 540),
(2, 40, '1998-01-29', 2400),
(7, 50, '1998-02-03', 600),
(7, 60, '1998-03-02', 720),
(7, 70, '1998-05-06', 150),
(8, 20, '1999-01-30', 1800);

-- Verify Data
SELECT *
FROM sales
ORDER BY salesperson_id, order_date;