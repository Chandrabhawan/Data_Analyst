/*
==========================================
Project   : Data Analyst SQL Practice
Database  : PostgreSQL
Author    : Chandra Patel
Created   : 27-Jun-2026
Version   : 1.0

Description:
This file contains PostgreSQL queries
for SQL practice and interview preparation.

GitHub:
https://github.com/Chandrabhawan
==========================================
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


select order_id, order_date, sales
from orders_data;


--top 10
select order_id, order_date, sales, profit 
from orders_data 
limit 10;

select order_id, order_date, sales, profit 
from orders_data 
limit 10 offset 10;

--LIMIT 10 → Return 10 rows.
--OFFSET 0 → Skip 0 rows.


select *
from orders_data
order by order_date, profit;

select *
from orders_data
order by order_date desc limit 5 --profit;

select *
from orders_data
order by order_date desc, profit desc;

select *
from orders_data
order by sales desc limit 5;

--from->select->order by->top

select * ,profit/sales
from orders_data;

select * ,profit/sales as profit_ratio
from orders_data;

select * ,profit/sales as profit_ratio, sales-profit as difference
from orders_data
order by profit_ratio;

select * 
from orders_data
where region='Central';

select * 
from orders_data
where quantity<=5
order by quantity;

select * 
from orders_data
where quantity>=5
order by quantity;

select * 
from orders_data
where quantity=5;

select order_id, order_date, sales, region
from orders_data
where region='Central';

select 
* from orders_data
where order_date>'2020-09-17'
order by order_date limit 10;

--from->where->select->order by->top

select
* from orders_data
where region='Central' and category='Technology' and quantity>2


select
* from orders_data
where (region='Central' or category='Technology') and quantity>5
order by quantity

select
* from orders_data
where quantity>= 3 and quantity<=5
	