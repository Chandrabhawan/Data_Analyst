/*
==========================================================
Project   : Data Analyst SQL Practice
Database  : PostgreSQL
Table     : returns_data
Author    : Chandra Patel
GitHub    : https://github.com/Chandrabhawan

Description:
This table stores product return information,
including the order ID and the reason for return.
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

CREATE TABLE returns_data (
    order_id VARCHAR(20) PRIMARY KEY,
    return_reason VARCHAR(50) NOT NULL
);

INSERT INTO returns_data (order_id, return_reason)
VALUES
('CA-2018-143336', 'Bad Quality'),
('CA-2020-109806', 'Wrong Items'),
('CA-2020-111682', 'Wrong Items'),
('US-2019-108966', 'Others'),
('CA-2018-167164', 'Bad Quality'),
('US-2018-164175', 'Wrong Item'),
('US-2021-119662', 'Bad Quality');
