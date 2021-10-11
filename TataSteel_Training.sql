--DDL  :: Data defination language 
--1.Create - Done
--2.Alter - Done
--3.Drop - Done

--DML :: Data manipulation language
--1.Insert - Done
--2.Update - Done
--3.Delete - Done

--1. Create table in oracle
CREATE TABLE persons (
    person_id NUMBER(4),
    first_name VARCHAR2(20),
    last_name varchar2(20)
);

CREATE TABLE discounts (
    discount_id NUMBER(4),
    discount_name VARCHAR2(50),
    amount NUMBER(4),
    start_date DATE,
    expired_date DATE    
);

--1.Insert
INSERT INTO persons values(101,'Vivek','Gohil');
INSERT INTO persons(person_id,first_name) values(102,'Abhishek');

INSERT INTO discounts values(1,'Summber Promotion',10,DATE '2021-10-10' , DATE '2021-11-10');

--Select
SELECT 
    *
FROM
    persons;

SELECT 
    *
FROM
    discounts;
    
DESC persons;   
DESC discounts;   

--Alter table :: Add single column
ALTER TABLE persons
ADD birthdate date;

--Alter table :: Add multiple columns
ALTER TABLE persons
ADD (
    phone VARCHAR2(20),
    email VARCHAR2(50)
);

--Alter table :: remove single column
ALTER TABLE persons
DROP COLUMN birthdate;

--Alter table :: remove multiple columns
ALTER TABLE persons
DROP (
    phone,email
);

DESC persons;

--Alter table :: rename column
ALTER TABLE persons
RENAME COLUMN first_name to person_first_name;

ALTER TABLE persons
RENAME COLUMN last_name to person_last_name;

--Alter table :: rename table
ALTER TABLE persons RENAME TO people;

DESCRIB persons;
DESCRIB people;


--Drop Table
DROP TABLE people;


--Insert 
SELECT
    *
FROM
    discounts;

INSERT INTO discounts values(2,'Diwali Promotion',20,DATE '2021-11-10' , DATE '2021-11-30');
INSERT INTO discounts values(3,'X-Mas Promotion',15,DATE '2021-12-10' , DATE '2021-12-24');
INSERT INTO discounts values(4,'Holi Promotion',10,DATE '2021-04-10' , DATE '2021-05-10');

--promotion_2021
CREATE TABLE promotion_2021 (
    discount_id NUMBER(4),
    discount_name VARCHAR2(50),
    amount NUMBER(4),
    start_date DATE,
    expired_date DATE    
);

SELECT 
    *
FROM
    promotion_2021;
    
INSERT INTO promotion_2021 
select * from discounts;

------------------------------------------
DROP TABLE promotion_2021;

CREATE TABLE promotion_2021
AS
    SELECT
        *
    FROM
        discounts;
        
SELECT 
    *
FROM
    promotion_2021;
    
--Update
CREATE TABLE parts (
  part_id NUMBER,
  part_name VARCHAR(50) NOT NULL,
  lead_time NUMBER(2,0) NOT NULL,
  cost NUMBER(9,2) NOT NULL,
  status NUMBER(1,0) NOT NULL
);

INSERT INTO parts VALUES (1,'sed dictum',5,134,0);
INSERT INTO parts VALUES (2,'tristique neque',3,62,1);
INSERT INTO parts VALUES (3,'dolor quam,',16,82,1);
INSERT INTO parts VALUES (4,'nec, diam.',41,10,1);
INSERT INTO parts VALUES (5,'vitae erat',22,116,0);
INSERT INTO parts VALUES (6,'parturient montes,',32,169,1);
INSERT INTO parts VALUES (7,'metus. In',45,88,1);
INSERT INTO parts VALUES (8,'at, velit.',31,182,0);
INSERT INTO parts VALUES (9,'nonummy ultricies',7,146,0);
INSERT INTO parts VALUES (10,'a, dui.',38,116,0);
INSERT INTO parts VALUES (11,'arcu et',37,72,1);
INSERT INTO parts VALUES (12,'sapien. Cras',40,197,1);
INSERT INTO parts VALUES (13,'et malesuada',24,46,0);
INSERT INTO parts VALUES (14,'mauris id',4,153,1);
INSERT INTO parts VALUES (15,'eleifend egestas.',2,146,0);
INSERT INTO parts VALUES (16,'cursus. Nunc',9,194,1);
INSERT INTO parts VALUES (17,'vivamus sit',37,93,0);
INSERT INTO parts VALUES (18,'ac orci.',35,134,0);
INSERT INTO parts VALUES (19,'arcu. Aliquam',36,154,0);
INSERT INTO parts VALUES (20,'at auctor',32,56,1);
INSERT INTO parts VALUES (21,'purus, accumsan',33,12,1);

SELECT 
    *
FROM 
    parts;
    
--Update one column of a single row
--Change the cost of part with partid 1

UPDATE
    parts
SET
    cost = 130
WHERE
    part_id = 1;
    
---------------------------    
SELECT 
    *
FROM 
    parts
WHERE
    part_id = 5;
    
--Update multiple columns of a single row
UPDATE
    parts
SET
    lead_time = 30,
    cost = 150,
    status = 1
WHERE
    part_id = 5;
    
-- Update multiple rows 
--increase the costs of all parts by 5%
UPDATE
    parts
SET
    cost = cost * 1.05;
    
    
SELECT 
    *
FROM 
    parts;    


--Delete
--Delete one row from table 
DELETE
FROM
    parts
WHERE
    part_id = 5;

--Delete multiple rows from table     
DELETE
FROM
    parts
WHERE
    status = 0;  

--Delete all rows from table     
DELETE
FROM
    parts;
    
--Oracle introduced the TRUNCATE TABLE statement that allows you to delete all rows from a big table.
TRUNCATE TABLE parts;

--Constraints
--1.Primary Key - Done
--2.Foreign Key - Done
--3.NOT NULL - Done
--4.Unique Constraint
--5.Check Constraint

--Primary key
CREATE TABLE supplier_groups (
    group_id NUMBER(5),
    group_name VARCHAR2(30) NOT NULL,
    PRIMARY KEY(group_id)
);

INSERT INTO supplier_groups values(1,'One-time Supplier');
INSERT INTO supplier_groups values(2,'Third-party Supplier');
INSERT INTO supplier_groups values(3,'Inter-co Supplier');
--You cannot insert null and duplicate values into primary key column
--INSERT INTO supplier_groups values(NULL,'Own Supplier');

SELECT 
    *
FROM
    supplier_groups;
    
--Foreign Key
CREATE TABLE suppliers (
    supplier_id NUMBER(5),
    supplier_name VARCHAR2(40) NOT NULL,
    group_id NUMBER(5) NOT NULL,
    PRIMARY KEY(supplier_id),
    FoREIGN KEY(group_id) REFERENCES supplier_groups(group_id)
);

INSERT INTO suppliers VALUES(101 , 'Toshiba',3);
INSERT INTO suppliers VALUES(102 , 'LG',1);
INSERT INTO suppliers VALUES(103 , 'Samsung',3);

INSERT INTO suppliers VALUES(104 ,NULL,NULL);

SELECT 
    *
FROM
    suppliers;

--Unique Constraint

DROP TABLE suppliers;

CREATE TABLE suppliers (
    supplier_id NUMBER(5),
    supplier_name VARCHAR2(40) NOT NULL UNIQUE,
    group_id NUMBER(5) NOT NULL,
    PRIMARY KEY(supplier_id),
    FOREIGN KEY(group_id) REFERENCES supplier_groups(group_id)
);

INSERT INTO suppliers VALUES(101 , 'Toshiba',3);
INSERT INTO suppliers VALUES(102 , 'LG',1);

--Check Constraint
DESCRIB parts;
DROP TABLE parts;

CREATE TABLE parts (
    part_id VARCHAR(5) CHECK (part_id like 'P%'),
    part_name VARCHAR(22) NOT NULL ,
    buy_price NUMBER(9,2) CHECK(buy_price > 0),
    PRIMARY KEY(part_id)
);

INSERT INTO parts VALUES('P101' , 'Screen',10);
INSERT INTO parts VALUES('P102' , 'Key board',500000.00);

SELECT
    *
FROM
    parts;


CREATE TABLE persons (
    person_id NUMBER(4),
    first_name VARCHAR2(20),
    last_name varchar2(20),
    gender VARCHAR2(5) CHECK (gender in ('Male' , 'Female'))
);

ALTER TABLE persons
MODIFY gender VARCHAR2(15) CHECK(gender in ('Male' , 'Female'));

ALTER TABLE persons
ADD city VARCHAR2(30) DEFAULT 'MUMBAI';

DESCRIB persons;

INSERT INTO persons values(101,'Vivek','Gohil','Male');

INSERT INTO persons values(102,'Reema','Rai','Female');

INSERT INTO persons values(103,'Seema','Rao','Female',DEFAULT);

INSERT INTO persons(person_id,first_name,last_name,gender) 
VALUES(104,'Test' ,'Test','Female');

SELECT 
    *
FROM
    persons;
    
CREATE TABLE challan_details (
challan_no VARCHAR2(6) CONSTRAINT fornKeyCHLNO REFERENCES challan_header(challan_no),
product_no VARCHAR2(6) CONSTRAINT fornKeyPNO REFERENCES product_master(product_no),
qty_disp NUMBER(4,2) NOT NULL,
CONSTRAINT prmKeyCHLNO primary key(challan_no , ______________  )
);


SELECT 
    *
FROM 
    USER_CONSTRAINTS
WHERE
    TABLE_NAME = 'ORDER_ITEMS';
    

--Day 2
COMMIT;
--
SELECT 
    *
FROM
    customers;
    
    
SELECT 
    customer_id,
    name,
    credit_limit
FROM
    customers;
    
--Sorting data Using Order by
SELECT 
    customer_id,
    name,
    credit_limit
FROM
    customers
ORDER BY
    name ASC;

SELECT 
    customer_id,
    name,
    credit_limit
FROM
    customers
ORDER BY
    credit_limit DESC;

SELECT
    *
FROM
    employees;

SELECT
    job_title,
    first_name,
    last_name
FROM
    employees;
    
--Arrange the employee details in asc order by job title   
SELECT
    job_title,
    first_name,
    last_name
FROM
    employees
ORDER BY
    job_title;
    
SELECT
    job_title,
    first_name,
    last_name
FROM
    employees
ORDER BY
    1,2;
       
SELECT
    job_title,
    first_name,
    last_name
FROM
    employees
ORDER BY
    job_title,first_name;
    
--Sorting rows with NULL values
SELECT
    *
FROM
    locations;

SELECT
    country_id,
    city,
    state
FROM
    locations;
    
SELECT
    country_id,
    city,
    state
FROM
    locations
ORDER BY
    city;
    
SELECT
    country_id,
    city,
    state
FROM
    locations
ORDER BY
    city,state;
    
SELECT
    country_id,
    city,
    state
FROM
    locations
ORDER BY
   state NULLS FIRST;

--Sorting by date
SELECT
    *
FROM
    orders
ORDER BY
    order_date DESC;
    
--Section 3
--DISTINCT
SELECT
    *
FROM
    contacts;

SELECT
    first_name
FROM
    contacts
ORDER BY
    first_name;
--get unique first names from contacts

SELECT DISTINCT
    first_name
FROM
    contacts
ORDER BY
    first_name;   

SELECT DISTINCT
    product_id,quantity
FROM
    order_items
ORDER BY
    product_id;

--Distinct with NULL
SELECT
    DISTINCT state
FROM
    locations
ORDER BY 
    state NULLS FIRST;
    
--Where
DESC products;
SELECT
    product_id,
    category_id,
    product_name,
    list_price
FROM
    products
WHERE
    list_price > 500
    AND
    category_id = 4
ORDER BY
    list_price DESC;
    
--Print the products details whose list prices are between 650 and 680
SELECT
    product_id,
    category_id,
    product_name,
    list_price
FROM
    products
WHERE
    list_price > 650
    AND
    list_price < 680
ORDER BY
    list_price DESC;


--Between
SELECT
    product_id,
    category_id,
    product_name,
    list_price
FROM
    products
WHERE
    list_price BETWEEN 650 AND 680
ORDER BY
    list_price DESC;

--OR
--Print the products details which have the category id as 1 or 4
SELECT
    product_name,
    category_id
FROM
    products
WHERE
    category_id = 1
    OR
    category_id = 4
ORDER BY
    product_name;
    
--IN
SELECT
    product_name,
    category_id
FROM
    products
WHERE
    category_id IN (1,4)
ORDER BY
    product_name;
    
SELECT
    *
FROM
    orders;

--query returns the orders that belong to the customer id 44 and have status as canceled or pending.
SELECT
    *
FROM
    orders
WHERE
    status IN( 'Canceled','Pending')
    AND
    customer_id = 44;

SELECT
    *
FROM
    orders
WHERE
    (
        status = 'Canceled'
        OR
        status = 'Pending'
    )
    AND
    customer_id = 44;


--Print the products whose standard costs are not in between 500 and 600 
SELECT
   product_name,
   standard_cost
FROM
    products
WHERE
    standard_cost NOT BETWEEN 500 AND 600
ORDER BY
    standard_cost;

--Like
SELECT
   product_name,
   standard_cost
FROM
    products
WHERE
    product_name LIKE 'I%';

--From Contacts prin the contacts whose last name end with 'er' 
SELECT
    *
FROM
    contacts
WHERE
    last_name LIKE '%er';
    
--find contacts whose phone numbers do not start with '+1':
SELECT
    *
FROM
    contacts
WHERE
    phone NOT LIKE '+1%';
    
    
--IS NULL and IS NOT NULL
SELECT
    *
FROM
    orders
WHERE salesman_id IS NULL;

SELECT
    *
FROM
    orders
WHERE salesman_id IS NOT NULL;

--Joins
--Setting up sample table
--Will create two new table with same structure 

CREATE TABLE palette_a (
    id NUMBER PRIMARY KEY,
    color VARCHAR2(20)
);

CREATE TABLE palette_b (
    id NUMBER PRIMARY KEY,
    color VARCHAR2(20)
);

INSERT INTO palette_a
VALUES(1,'Red');

INSERT INTO palette_a
VALUES(2,'Green');

INSERT INTO palette_a
VALUES(3,'Blue');

INSERT INTO palette_a
VALUES(4,'Purple');
---------------------------------------
INSERT INTO palette_b
VALUES(1,'Green');

INSERT INTO palette_b
VALUES(2,'Red');
    
INSERT INTO palette_b
VALUES(3,'Cyan');

INSERT INTO palette_b
VALUES(4,'Brown');

SELECT
    *
FROM
    palette_a;
    
SELECT
    *
FROM
    palette_b;

--Cross Join
SELECT
    *
FROM
    palette_a , palette_b;
    
--Inner Join
SELECT
    *
FROM
    palette_a
    INNER JOIN
    palette_b
ON
    palette_a.color = palette_b.color;

--Left Join
SELECT
    *
FROM
    palette_a LEFT JOIN palette_b
ON
    palette_a.color = palette_b.color;
    

--Right Join
SELECT
    *
FROM
    palette_a RIGHT JOIN palette_b
ON
    palette_a.color = palette_b.color;

--Full Join
SELECT
    *
FROM
    palette_a FULL JOIN palette_b
ON
    palette_a.color = palette_b.color;
    
--Self Join
SELECT 
    *
FROM
    employees;
    
SELECT 
    e.employee_id employee_id,
    e.first_name employee_first_name,
    e.last_name employee_last_name,
    m.first_name manager_first_name,
    m.last_name manager_last_name
FROM
    employees e
    INNER JOIN
    employees m
ON
    m.employee_id  = e.manager_id;

SELECT 
    
    (e.first_name || ' ' || e.last_name) employee,
    (m.first_name || ' ' || m.last_name) manager,
    e.job_title
FROM
    employees e
    INNER JOIN
    employees m
ON
    m.employee_id  = e.manager_id;
    
SELECT * FROM orders;
SELECT * FROM order_items WHERE order_id = 105;

select 
    *
FROM
    orders o
    INNER JOIN
    order_items oi
ON
   oi.order_id  =  o.order_id;
   
--Right join
SELECT * FROM  orders;
SELECT * FROM  employees;

SELECT 
    o.order_id,
    e.first_name,
    e.last_name
FROM
    employees e
    RIGHT JOIN
    orders o
ON
    o.salesman_id = e.employee_id
ORDER BY
    order_id;
    
--Section 5 - Grouping Data
--Group by

SELECT
    *
FROM
    orders;

SELECT
    status
FROM
    orders;

SELECT DISTINCT
    status
FROM
    orders;    

--Get the total count of orders whos have a status as Shipped

SELECT 
    COUNT(status)
FROM
    orders
WHERE 
    status = 'Shipped';

SELECT 
    COUNT(status)
FROM
    orders
WHERE 
    status = 'Pending';
    
SELECT 
    COUNT(status)
FROM
    orders
WHERE 
    status = 'Canceled';    


--Group By
SELECT DISTINCT
    status,
    COUNT(status)
FROM
    orders
GROUP BY
    status;
-------------------------------------
SELECT 
   job_title,
   count(job_title)
FROM
    employees
GROUP BY
    job_title
ORDER BY
    job_title;

----------------------------------
SELECT
    *
FROM
    order_items
WHERE
    ORDER_ID = 70;
---------------------------------------
SELECT
    order_id,
    sum(quantity * unit_price) total
FROM
    order_items
GROUP BY
    order_id
ORDER BY
    total DESC;

--Print the order details(order_id and total) which have total value > 1000000
SELECT
    order_id,
    sum(quantity * unit_price) total
FROM
    order_items
GROUP BY
    order_id
HAVING
    sum(quantity * unit_price) > 1000000
ORDER BY
    total DESC;
    
--find orders whose values are greater than 500,000 and the number of products in each order is between 10 and 12:
 SELECT
    order_id,
    sum(quantity * unit_price) total,
    COUNT(order_id) count
FROM
    order_items
GROUP BY
    order_id
HAVING
    sum(quantity * unit_price) > 500000
    AND
    COUNT(order_id) BETWEEN 10 AND 12
ORDER BY
    total DESC;   

--Section 6 . Subquery OR Nested Query

SELECT
    *
FROM
    products;

SELECT
    MAX(LIST_PRICE)
FROM
    products;
    
SELECT
    *
FROM
    products
WHERE
    list_price = 8867.99;


--SubQuery
SELECT
    *
FROM
    products
WHERE
    list_price = (
        SELECT
            MAX(LIST_PRICE)
        FROM
        products
    );
    

--print cheapest products from the products table using a subquery in the WHERE clause.
SELECT
    *
FROM
    products
WHERE
    list_price = (
        SELECT
            MIN(LIST_PRICE)
        FROM
        products
    );
    
SELECT  
    *
FROM
    customers;
SELECT  
    *
FROM
    orders;
    
--find all customers who have the order
SELECT 
    *
FROM
    customers c
where
    EXISTS (
        SELECT
            *
        FROM
            orders
        WHERE
            customer_id = c.customer_id
    );
--finds all customers who have no order
SELECT 
    *
FROM
    customers c
where
    NOT EXISTS (
        SELECT
            *
        FROM
            orders
        WHERE
            customer_id = c.customer_id
    );

SELECT 
    *
FROM
    orders;

SELECT 
    *
FROM
    customers;
    
SELECT
    name,
    count(order_id) order_count
FROM
    orders o
    INNER JOIN
    customers c
ON
    o.customer_id = c.customer_id
GROUP BY
    name
ORDER BY
    order_count DESC;
