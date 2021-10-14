select @@version;

--Load Sample Database
--Section 1. Querying data

--Basic SQL Server SELECT statement
--The following query finds the first name and last name of all customers
SELECT
    first_name,
    last_name
FROM
    sales.customers;

--The following statement returns the first names, last names, and emails of all customers
SELECT
    first_name,
    last_name,
    email
FROM
    sales.customers;

--SQL Server SELECT – retrieve all columns from a table
SELECT
    *
FROM
    sales.customers;

-- SQL Server SELECT – sort the result set
--To filter rows based on one or more conditions, you use a WHERE clause
SELECT
    *
FROM
    sales.customers
WHERE
    state = 'CA';

--To sort the result set based on one or more columns, you use the ORDER BY clause
SELECT
    *
FROM
    sales.customers
WHERE
    state = 'CA'
ORDER BY
    first_name;

--SQL Server SELECT – group rows into groups example
--the following statement returns all the cites of customers located in California and the number of customers in each city.
SELECT
    city,
    COUNT (*)
FROM
    sales.customers
WHERE
    state = 'CA'
GROUP BY
    city
ORDER BY
    city;

-- SQL Server SELECT – filter groups example
--To filter groups based on one or more conditions, you use the HAVING clause. 
--The following example returns the city in California which has more than 10 customers
SELECT
    city,
    COUNT (*)
FROM
    sales.customers
WHERE
    state = 'CA'
GROUP BY
    city
HAVING
    COUNT (*) > 10
ORDER BY
    city;

--Section 2. Sorting data
--SQL Server ORDER BY In Detail
--Sort a result set by one column in ascending order
--The following statement sorts the customer list by the first name in ascending order
SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    first_name;

--Sort a result set by one column in descending order
--The following statement sorts the customer list by the first name in descending order.
SELECT
	first_name,
	last_name
FROM
	sales.customers
ORDER BY
	first_name DESC;

--Sort a result set by multiple columns
--The following statement retrieves the first name, last name, and city of the customers. 
--It sorts the customer list by the city first and then by the first name.
SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city,
    first_name;

--Sort a result set by multiple columns and different orders
--The following statement sorts the customers by the city in descending order and the sort the sorted result set by the first name in ascending order.
SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city DESC,
    first_name ASC;

--Sort a result set by a column that is not in the select list
--the following statement sorts the customer by the state even though the state column does not appear on the select list.
SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    state;

--Sort a result set by an expression
--The following statement uses the LEN() function in the ORDER BY clause to retrieve a customer list sorted by the length of the first name.
SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    LEN(first_name) DESC;

--Sort by ordinal positions of columns
--The following statement sorts the customers by first name and last name. But instead of specifying the column names explicitly, it uses the ordinal positions of the columns
SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    1,
    2;

--Section 3. Limiting rows
--SQL Server OFFSET FETCH
--The following query returns all products from the products table and sorts the products by their list prices and names:
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name;

--To skip the first 10 products and return the rest, you use the OFFSET clause as shown in the following statement:
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS;

--To skip the first 10 products and select the next 10 products, you use both OFFSET and FETCH clauses as follows:
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;

--To get the top 10 most expensive products you use both OFFSET and FETCH clauses
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC,
    product_name 
OFFSET 0 ROWS 
FETCH FIRST 10 ROWS ONLY;

--SQL Server SELECT TOP
--Using TOP with a constant value
--The following example uses a constant value to return the top 10 most expensive products.
SELECT TOP 10
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;

--Using TOP to return a percentage of rows
--The following example uses PERCENT to specify the number of products returned in the result set.
--The production.products table has 321 rows, therefore, one percent of 321 is a fraction value ( 3.21), SQL Server rounds it up to the next whole number which is four ( 4) in this case.
SELECT TOP 1 PERCENT
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;

--Using TOP WITH TIES to include rows that match the values in the last row
--The following statement returns the top three most expensive products:
SELECT TOP 3 WITHOUT TIES
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;

--Section 4. Filtering data
--DISTINCT one column example
--The following statement returns all cities of all customers in the customers tables:
SELECT
    city
FROM
    sales.customers
ORDER BY
    city;

--To get distinct cities, you add the DISTINCT keyword as follows:
SELECT DISTINCT
    city
FROM
    sales.customers
ORDER BY
    city;

--DISTINCT multiple columns example
--This statement returns all cities and states of all customers
SELECT
    city,
    state
FROM
    sales.customers
ORDER BY 
    city, 
    state;

--The following statement finds the distinct city and state of all customers.
SELECT DISTINCT
    city,
    state
FROM
    sales.customers

--DISTINCT with null values example
--The following example finds the distinct phone numbers of the customers:
SELECT DISTINCT
    phone
FROM
    sales.customers
ORDER BY
    phone;

--SQL Server WHERE examples
--Finding rows by using a simple equality
--The following statement retrieves all products with the category id 1:
SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    category_id = 1
ORDER BY
    list_price DESC;

--Finding rows that meet two conditions
--The following example returns products that meet two conditions: category id is 1 and the model is 2018.
--It uses the logical operator AND to combine the two conditions.
SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    category_id = 1 AND model_year = 2018
ORDER BY
    list_price DESC;

--Finding rows by using a comparison operator
--The following statement finds the products whose list price is greater than 300 and model is 2018.
SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price > 300 AND model_year = 2018
ORDER BY
    list_price DESC;

--Finding rows that meet any of two conditions
--The following query finds products whose list price is greater than 3,000 or model is 2018.
--Any product that meets one of these conditions is included in the result set.
SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price > 3000 OR model_year = 2018
ORDER BY
    list_price DESC;

--Finding rows with the value between two values
--The following statement finds the products whose list prices are between 1,899 and 1,999.99:
SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price BETWEEN 1899.00 AND 1999.99
ORDER BY
    list_price DESC;

--Finding rows that have a value in a list of values
--The following example uses the IN operator to find products whose list price is 299.99 or 466.99 or 489.99.
SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price IN (299.99, 369.99, 489.99)
ORDER BY
    list_price DESC;

--Finding rows whose values contain a string
--The following example uses the LIKE operator to find products whose name contains the string 'Cruiser'
SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    product_name LIKE '%Cruiser%'
ORDER BY
    list_price;

--SQL Server AND in detail
--Using AND operator example
--The following example finds the products where the category identification number is 1 and the list price is greater than 400:
SELECT
    *
FROM
    production.products
WHERE
    category_id = 1
AND list_price > 400
ORDER BY
    list_price DESC;

--Using multiple AND operators example
--The following statement finds the products that meet all the following conditions: category id is 1, the list price is greater than 400, and the brand id is 1:
SELECT
    *
FROM
    production.products
WHERE
    category_id = 1
AND list_price > 400
AND brand_id = 1
ORDER BY
    list_price DESC;

--Using the AND operator with other logical operators
SELECT
    *
FROM
    production.products
WHERE
   (brand_id = 1 OR brand_id = 2)
AND list_price > 1000
ORDER BY
    brand_id DESC;

--SQL Server OR
--Using OR operator example
--The following example finds the products whose list price is less than 200 or greater than 6,000:
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price < 200
OR list_price > 6000
ORDER BY
    list_price;

--Using multiple OR operators example
--The following statement finds the products whose brand id is 1, 2, or 4:
SELECT
    product_name,
    brand_id
FROM
    production.products
WHERE
    brand_id = 1
OR brand_id = 2
OR brand_id = 4
ORDER BY
    brand_id DESC;

--You can replace multiple OR operators by the IN operator as shown in the following query:
SELECT
    product_name,
    brand_id
FROM
    production.products
WHERE
    brand_id IN (1, 2, 3)
ORDER BY
    brand_id DESC;

--SQL Server IN operator in detail
--Using SQL Server IN with a list of values example
--The following statement finds the products whose list price is one of the following values: 89.99, 109.99, and 159.99:
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price IN (89.99, 109.99, 159.99)
ORDER BY
    list_price;

--To find the products whose list prices are not one of the prices above, you use the NOT IN operator as shown in the following query:
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price NOT IN (89.99, 109.99, 159.99)
ORDER BY
    list_price;

--Using SQL Server IN operator with a subquery example
--The following query returns a list of product identification numbers of the products located in the store id one and has the quantity greater than or equal to 30:
SELECT
    product_id
FROM
    production.stocks
WHERE
    store_id = 1 AND quantity >= 30;

--You can use the query above as a subquery in as shown in the following query:
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    product_id IN (
        SELECT
            product_id
        FROM
            production.stocks
        WHERE
            store_id = 1 AND quantity >= 30
    )
ORDER BY
    product_name;

--SQL Server BETWEEN Operator
--The following query finds the products whose list prices are between 149.99 and 199.99:
SELECT
    product_id,
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price BETWEEN 149.99 AND 199.99
ORDER BY
    list_price;

--To get the products whose list prices are in the range 149.99 and 199.99, you use the NOT BETWEEN operator as follows:
SELECT
    product_id,
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price NOT BETWEEN 149.99 AND 199.99
ORDER BY
    list_price;

--Using SQL Server BETWEEN with dates
--The following query finds the orders that customers placed between January 15, 2017 and January 17, 2017
SELECT
    order_id,
    customer_id,
    order_date,
    order_status
FROM
    sales.orders
WHERE
    order_date BETWEEN '20170115' AND '20170117'
ORDER BY
    order_date;

--SQL Server LIKE operator in detail
--Pattern
--The pattern is a sequence of characters to search for in the column or expression. It can include the following valid wildcard characters:

--The percent wildcard (%): any string of zero or more characters.
--The underscore (_) wildcard: any single character.
--The [list of characters] wildcard: any single character within the specified set.
--The [character-character]: any single character within the specified range.
--The [^]: any single character not within a list or a range.

--The % (percent) wildcard examples
--The following example finds the customers whose last name starts with the letter z:
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE 'z%'
ORDER BY
    first_name;

--The following example returns the customers whose last name ends with the string er
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '%er'
ORDER BY
    first_name;

--The following statement retrieves the customers whose last name starts with the letter t and ends with the letter s
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE 't%s'
ORDER BY
    first_name;

--The _ (underscore) wildcard example
--the following statement returns the customers where the second character is the letter u
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '_u%'
ORDER BY
    first_name;

--the following query returns the customers where the first character in the last name is Y or Z
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '[YZ]%'
ORDER BY
    last_name;

--the following query finds the customers where the first character in the last name is the letter in the range A through C:
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '[A-C]%'
ORDER BY
    first_name;

-- the following query returns the customers where the first character in the last name is not the letter in the range A through X:
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '[^A-X]%'
ORDER BY
    last_name;

--The following example uses the NOT LIKE operator to find customers where the first character in the first name is not the letter A:
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    first_name NOT LIKE 'A%'
ORDER BY
    first_name;

--SQL Server LIKE with ESCAPE example
--First, create a new table for the demonstration:
CREATE TABLE sales.feedbacks (
   feedback_id INT IDENTITY(1, 1) PRIMARY KEY, 
    comment     VARCHAR(255) NOT NULL
);

--Second, insert some rows into the sales.feedbacks table:
INSERT INTO sales.feedbacks(comment)
VALUES('Can you give me 30% discount?'),
      ('May I get me 30USD off?'),
      ('Is this having 20% discount today?');

--Third, query data from the sales.feedbacks table:
SELECT * FROM sales.feedbacks;

--If you want to search for 30% in the comment column, you may come up with a query like this
SELECT 
   feedback_id,
   comment
FROM 
   sales.feedbacks
WHERE 
   comment LIKE '%30%';

--The query returns the comments that contain 30% and 30USD, which is not what we expected.
--To solve this issue, you need to use the ESCAPE clause:
SELECT 
   feedback_id, 
   comment
FROM 
   sales.feedbacks
WHERE 
   comment LIKE '%30!%%' ESCAPE '!';

--SQL Server column alias
--When you use the SELECT statement to query data from a table, SQL Server uses the column names as the column headings for the output. 
SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    first_name;

--To get full names of customers, you can concatenate the first name, space, and the last name using the concatenation  + operator
SELECT
    first_name + ' ' + last_name
FROM
    sales.customers
ORDER BY
    first_name;

--rewrite the query using a column alias
SELECT
    first_name + ' ' + last_name AS full_name
FROM
    sales.customers
ORDER BY
    first_name;

--rewrite the query using a column alias
SELECT
    first_name + ' ' + last_name AS 'Full Name'
FROM
    sales.customers
ORDER BY
    first_name;

--The following example shows how to assign an alias to a column
SELECT
    category_name 'Product Category'
FROM
    production.categories;

--When you assign a column an alias, you can use either the column name or the column alias in the ORDER BY clause 
SELECT
    category_name 'Product Category'
FROM
    production.categories
ORDER BY
    category_name;  


SELECT
    category_name 'Product Category'
FROM
    production.categories
ORDER BY
    'Product Category';

--Section 5. Joining tables
--Setting up sample tables
--First, create a new schema named hr:
CREATE SCHEMA hr;
GO

--Second, create two new tables named candidates and employees in the hr schema
CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

--Third, insert some rows into the candidates and employees tables
INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');


INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');

--SQL Server Inner Join
--Inner join produces a data set that includes rows from the left table which have matching rows from the right table.
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    INNER JOIN hr.employees e 
        ON e.fullname = c.fullname;

--SQL Server Left Join
--Left join selects data starting from the left table and matching rows in the right table. 
--The left join returns all rows from the left table and the matching rows from the right table. 
--If a row in the left table does not have a matching row in the right table, the columns of the right table will have nulls
SELECT  
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname employee_name
FROM 
	hr.candidates c
	LEFT JOIN hr.employees e 
		ON e.fullname = c.fullname;

--SQL Server Right Join
--The right join or right outer join selects data starting from the right table. It is a reversed version of the left join.
--The right join returns a result set that contains all rows from the right table and the matching rows in the left table. If a row in the right table that does not have a matching row in the left table, all columns in the left table will contain nulls.

--The following example uses the right join to query rows from candidates and employees tables:
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    RIGHT JOIN hr.employees e 
        ON e.fullname = c.fullname;

--SQL Server full join
--The full outer join or full join returns a result set that contains all rows from both left and right tables,
--with the matching rows from both sides where available. 
--In case there is no match, the missing side will have NULL values.

--The following example shows how to perform a full join between the candidates and employees tables:
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    FULL JOIN hr.employees e 
        ON e.fullname = c.fullname;

--SQL Server Cross Join
--The following statement returns the combinations of all products and stores. The result set can be used for stocktaking procedure during the month-end and year-end closings:
SELECT
    product_id,
    product_name,
    store_id,
    0 AS quantity
FROM
    production.products
CROSS JOIN sales.stores
ORDER BY
    product_name,
    store_id;

--SQL Server self join examples
--To get who reports to whom, you use the self join as shown in the following query
SELECT
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager
FROM
    sales.staffs e
INNER JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;

--Section 6. Grouping data
--the GROUP BY clause produced a group for each combination of the values in the columns listed in the GROUP BY clause
SELECT
    customer_id,
    YEAR (order_date) order_year
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
ORDER BY
    customer_id;

--Let’s add a GROUP BY clause to the query to see the effect
SELECT
    customer_id,
    YEAR (order_date) order_year
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY
    customer_id;

--SQL Server GROUP BY clause and aggregate functions
--For example, the following query returns the number of orders placed by the customer by year
SELECT
    customer_id,
    YEAR (order_date) order_year,
    COUNT (order_id) order_placed
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY
    customer_id;

--If you want to refer to any column or expression that is not listed in the GROUP BY clause, 
--you must use that column as the input of an aggregate function. 
--Otherwise, you will get an error because there is no guarantee that the column or expression will return a single value per group. 
--For example, the following query will fail:
SELECT
    customer_id,
    YEAR (order_date) order_year,
    order_status
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY
    customer_id;

--Using GROUP BY clause with the COUNT() function example
--The following query returns the number of customers in every city:
SELECT
    city,
    COUNT (customer_id) customer_count
FROM
    sales.customers
GROUP BY
    city
ORDER BY
    city;

--Similarly, the following query returns the number of customers by state and city.
SELECT
    city,
    state,
    COUNT (customer_id) customer_count
FROM
    sales.customers
GROUP BY
    state,
    city
ORDER BY
    city,
    state;

--Using GROUP BY clause with the MIN and MAX functions example
--The following statement returns the minimum and maximum list prices of all products with the model 2018 by brand:
SELECT
    brand_name,
    MIN (list_price) min_price,
    MAX (list_price) max_price
FROM
    production.products p
INNER JOIN production.brands b ON b.brand_id = p.brand_id
WHERE
    model_year = 2018
GROUP BY
    brand_name
ORDER BY
    brand_name;

--Using GROUP BY clause with the AVG() function example
--The following statement uses the AVG() function to return the average list price by brand for all products with the model year 2018:
SELECT
    brand_name,
    AVG (list_price) avg_price
FROM
    production.products p
INNER JOIN production.brands b ON b.brand_id = p.brand_id
WHERE
    model_year = 2018
GROUP BY
    brand_name
ORDER BY
    brand_name;

--SQL Server HAVING examples
--The following statement uses the HAVING clause to find the customers who placed at least two orders per year:
SELECT
    customer_id,
    YEAR (order_date),
    COUNT (order_id) order_count
FROM
    sales.orders
GROUP BY
    customer_id,
    YEAR (order_date)
HAVING
    COUNT (order_id) >= 2
ORDER BY
    customer_id;

--The following statement first finds the maximum and minimum list prices in each product category. Then, 
--it filters out the category which has the maximum list price greater than 4,000 or the minimum list price less than 500:
SELECT
    category_id,
    MAX (list_price) max_list_price,
    MIN (list_price) min_list_price
FROM
    production.products
GROUP BY
    category_id
HAVING
    MAX (list_price) > 4000 OR MIN (list_price) < 500;

--The following statement finds product categories whose average list prices are between 500 and 1,000
SELECT
    category_id,
    AVG (list_price) avg_list_price
FROM
    production.products
GROUP BY
    category_id
HAVING
    AVG (list_price) BETWEEN 500 AND 1000;

--SQL Server Subquery
--A subquery is a query nested inside another statement such as SELECT, INSERT, UPDATE, or DELETE.
--The following statement shows how to use a subquery in the WHERE clause of a SELECT statement to find the sales orders of the customers who locate in New York
SELECT
	customer_id
FROM
	sales.customers
WHERE
	city = 'New York';

SELECT
    order_id,
    order_date,
    customer_id
FROM
    sales.orders
WHERE
    customer_id IN (
        SELECT
            customer_id
        FROM
            sales.customers
        WHERE
            city = 'New York'
    )
ORDER BY
    order_date DESC;

--Nesting subquery
--A subquery can be nested within another subquery. SQL Server supports up to 32 levels of nesting. Consider the following example
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > (
        SELECT
            AVG (list_price)
        FROM
            production.products
        WHERE
            brand_id IN (
                SELECT
                    brand_id
                FROM
                    production.brands
                WHERE
                    brand_name = 'Strider'
                OR brand_name = 'Trek'
            )
    )
ORDER BY
    list_price;

--In the following example, a subquery is used as a column expression named max_list_price in a SELECT statement.
SELECT
    order_id,
    order_date,
    (
        SELECT
            MAX (list_price)
        FROM
            sales.order_items i
        WHERE
            i.order_id = o.order_id
    ) AS max_list_price
FROM
    sales.orders o
order by order_date desc;

--SQL Server subquery is used with IN operator
--The following query finds the names of all mountain bikes and road bikes products that the Bike Stores sell.
SELECT
    product_id,
    product_name
FROM
    production.products
WHERE
    category_id IN (
        SELECT
            category_id
        FROM
            production.categories
        WHERE
            category_name = 'Mountain Bikes'
        OR category_name = 'Road Bikes'
    );

--SQL Server subquery is used with ANY operator
--the following query finds the products whose list prices are greater than or equal to the average list price of any product brand.
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price >= ANY (
        SELECT
            AVG (list_price)
        FROM
            production.products
        GROUP BY
            brand_id
    )

--SQL Server subquery is used with ALL operator
--The following query finds the products whose list price is greater than or equal to the average list price returned by the subquery:
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price >= ALL (
        SELECT
            AVG (list_price)
        FROM
            production.products
        GROUP BY
            brand_id
    )

--SQL Server subquery is used with EXISTS or NOT EXISTS
--The following query finds the customers who bought products in 2017:
SELECT
    customer_id,
    first_name,
    last_name,
    city
FROM
    sales.customers c
WHERE
    EXISTS (
        SELECT
            customer_id
        FROM
            sales.orders o
        WHERE
            o.customer_id = c.customer_id
        AND YEAR (order_date) = 2017
    )
ORDER BY
    first_name,
    last_name;

--If you use the NOT EXISTS instead of EXISTS, you can find the customers who did not buy any products in 2017.
SELECT
    customer_id,
    first_name,
    last_name,
    city
FROM
    sales.customers c
WHERE
    NOT EXISTS (
        SELECT
            customer_id
        FROM
            sales.orders o
        WHERE
            o.customer_id = c.customer_id
        AND YEAR (order_date) = 2017
    )
ORDER BY
    first_name,
    last_name;

--SQL Server Correlated Subquery
--A correlated subquery is a subquery that uses the values of the outer query. In other words, it depends on the outer query for its values. Because of this dependency, a correlated subquery cannot be executed independently as a simple subquery.

--Moreover, a correlated subquery is executed repeatedly, once for each row evaluated by the outer query. The correlated subquery is also known as a repeating subquery.
--The following example finds the products whose list price is equal to the highest list price of the products within the same category
SELECT
    product_name,
    list_price,
    category_id
FROM
    production.products p1
WHERE
    list_price IN (
        SELECT
            MAX (p2.list_price)
        FROM
            production.products p2
        WHERE
            p2.category_id = p1.category_id
        GROUP BY
            p2.category_id
    )
ORDER BY
    category_id,
    product_name;

--Section 8. Data definition
--The following statement creates a new database named TestDb:
CREATE DATABASE TestDb;

--This statement lists all databases in the SQL Server:
SELECT 
    name
FROM 
    master.sys.databases
ORDER BY 
    name;

--Or you can execute the stored procedure sp_databases:
EXEC sp_databases;

--SQL Server DROP DATABASE
--The following example uses the DROP DATABASE statement to delete the TestDb database
DROP DATABASE IF EXISTS TestDb;

--SQL Server CREATE SCHEMA
--The following example shows how to use the CREATE SCHEMA statement to create the customer_services schema:
CREATE SCHEMA customer_services;
GO

--If you want to list all schemas in the current database, you can query schemas from the sys.schemas as shown in the following query:
SELECT 
    s.name AS schema_name, 
    u.name AS schema_owner
FROM 
    sys.schemas s
INNER JOIN sys.sysusers u ON u.uid = s.principal_id
ORDER BY 
    s.name;

-- For example, the following statement creates a new table named jobs in the customer_services schema:
CREATE TABLE customer_services.jobs(
    job_id INT PRIMARY KEY IDENTITY,
    customer_id INT NOT NULL,
    description VARCHAR(200),
    created_at DATETIME2 NOT NULL
);

--SQL Server DROP SCHEMA
DROP SCHEMA customer_services;
DROP TABLE customer_services.jobs;

--SQL Server CREATE TABLE
--The following statement creates a new table named sales.visits to track the customer in-store visits:
CREATE TABLE sales.visits (
    visit_id INT PRIMARY KEY IDENTITY (1, 1),
    first_name VARCHAR (50) NOT NULL,
    last_name VARCHAR (50) NOT NULL,
    visited_at DATETIME,
    phone VARCHAR(20),
    store_id INT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
);

--SQL Server IDENTITY example
CREATE TABLE hr.person (
    person_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) NOT NULL
);

--First, insert a new row into the person table:
INSERT INTO hr.person(first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES('John','Doe', 'M');

INSERT INTO hr.person(first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES('Jane','Doe','F');

--Creating a simple sequence example
CREATE SEQUENCE item_counter
    AS INT
    START WITH 10
    INCREMENT BY 10;

SELECT NEXT VALUE FOR item_counter;

--Using a sequence object in a single table example

--First, create a new schema named procurement:
CREATE SCHEMA procurement;
GO

--Next, create a new table named orders:
CREATE TABLE procurement.purchase_orders(
    order_id INT PRIMARY KEY,
    vendor_id int NOT NULL,
    order_date date NOT NULL
);

--create a new sequence object named order_number that starts with 1 and is incremented by 1:
CREATE SEQUENCE procurement.order_number 
AS INT
START WITH 1
INCREMENT BY 1;

--insert three rows into the procurement.purchase_orders table and uses values generated by the procurement.order_number sequence:
INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    (NEXT VALUE FOR procurement.order_number,1,'2019-04-30');


INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    (NEXT VALUE FOR procurement.order_number,2,'2019-05-01');


INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    (NEXT VALUE FOR procurement.order_number,3,'2019-05-02');

--view the content of the procurement.purchase_orders table:
SELECT 
    order_id, 
    vendor_id, 
    order_date
FROM 
    procurement.purchase_orders;

--Getting sequences information
SELECT 
    * 
FROM 
    sys.sequences;

--SQL Server DROP TABLE
-- Drop a table that does not exist
DROP TABLE IF EXISTS procurement.purchase_orders;

--Introduction to SQL Server TRUNCATE TABLE statement
CREATE TABLE sales.customer_groups (
    group_id INT PRIMARY KEY IDENTITY,
    group_name VARCHAR (50) NOT NULL
);

INSERT INTO sales.customer_groups (group_name)
VALUES
    ('Intercompany'),
    ('Third Party'),
    ('One time');

TRUNCATE TABLE sales.customer_groups;

--TRUNCATE TABLE vs. DELETE
--The TRUNCATE TABLE has the following advantages over the DELETE statement:

--1) Use less transaction log
--The DELETE statement removes rows one at a time and inserts an entry in the transaction log for each removed row. On the other hand, the TRUNCATE TABLE statement deletes the data by deallocating the data pages used to store the table data and inserts only the page deallocations in the transaction logs.

--2) Use fewer locks
--When the DELETE statement is executed using a row lock, each row in the table is locked for removal. The TRUNCATE TABLE locks the table and pages, not each row.

--3) Identity reset
--If the table to be truncated has an identity column, the counter for that column is reset to the seed value when data is deleted by the TRUNCATE TABLE statement but not the DELETE statement.

--In this tutorial, you have learned how to use the TRUNCATE TABLE statement to delete all rows from a table faster and more efficiently.

--SQL Server Rename Table
--First, create a new table named sales.contr for storing sales contract’s data:
CREATE TABLE sales.contr (
    contract_no INT IDENTITY PRIMARY KEY,
    start_date DATE NOT NULL,
    expired_date DATE,
    customer_id INT,
    amount DECIMAL (10, 2)
);

--use the sp_rename stored procedure to rename the sales.contr table to contracts in the sales schema:
EXEC sp_rename 'sales.contr', 'contracts';

--SQL Server ALTER TABLE ADD Column
CREATE TABLE sales.quotations (
    quotation_no INT IDENTITY PRIMARY KEY,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL
);

--To add a new column named description to the sales.quotations table, you use the following statement:
ALTER TABLE sales.quotations 
ADD description VARCHAR (255) NOT NULL;

--The following statement adds two new columns named amount and customer_name to the sales.quotations table:
ALTER TABLE sales.quotations 
    ADD 
        amount DECIMAL (10, 2) NOT NULL,
        customer_name VARCHAR (50) NOT NULL;

--SQL Server ALTER TABLE ALTER COLUMN
--First, create a new table with one column whose data type is INT:
CREATE TABLE t1 (c INT);

 INSERT INTO t1
    VALUES
        (1),
        (2),
        (3);

--Second, modify the data type of the column from INT to VARCHAR:
ALTER TABLE t1 ALTER COLUMN c VARCHAR (2);

--Change the size of a column
ALTER TABLE t1 ALTER COLUMN c VARCHAR (50);

--SQL Server ALTER TABLE DROP COLUMN
--Let’s create a new table named sales.price_lists for the demonstration.
CREATE TABLE sales.price_lists(
    product_id int,
    valid_from DATE,
    price DEC(10,2) NOT NULL CONSTRAINT ck_positive_price CHECK(price >= 0),
    discount DEC(10,2) NOT NULL,
    surcharge DEC(10,2) NOT NULL,
    note VARCHAR(255),
    PRIMARY KEY(product_id, valid_from)
);

--The following statement drops the note column from the price_lists table:
ALTER TABLE sales.price_lists
DROP COLUMN note;

--The price column has a CHECK constraint, therefore, you cannot delete it. If you try to execute the following statement, you will get an error:
ALTER TABLE sales.price_lists
DROP COLUMN price;

--To drop the price column, first, delete its CHECK constraint:
ALTER TABLE sales.price_lists
DROP CONSTRAINT ck_positive_price;

--And then, delete the price column:
ALTER TABLE sales.price_lists
DROP COLUMN price;

--The following example deletes two columns discount and surcharge at once:
ALTER TABLE sales.price_lists
DROP COLUMN discount, surcharge;

--SQL Server Computed Columns
--Let’s create a new table named persons for the demonstrations:
CREATE TABLE persons
(
    person_id  INT PRIMARY KEY IDENTITY, 
    first_name NVARCHAR(100) NOT NULL, 
    last_name  NVARCHAR(100) NOT NULL, 
    dob        DATE
);

--And insert two rows into the the persons table:
INSERT INTO 
    persons(first_name, last_name, dob)
VALUES
    ('John','Doe','1990-05-01'),
    ('Jane','Doe','1995-03-01');

--To query the full names of people in the persons table, you normally use the CONCAT() function or the + operator as follows:
SELECT
    person_id,
    first_name + ' ' + last_name AS full_name,
    dob
FROM
    persons
ORDER BY
    full_name;

--For example, you can add the full_name column to the persons table by using the ALTER TABLE ADD column as follows:
ALTER TABLE persons
ADD full_name AS (first_name + ' ' + last_name);

--Here is the new query, which is more compact:
SELECT 
    person_id, 
    full_name, 
    dob
FROM 
    persons
ORDER BY 
    full_name;

-- the following statement creates a temporary table using the SELECT INTO statement:
SELECT
    product_name,
    list_price
INTO #trek_products --- temporary table
FROM
    production.products
WHERE
    brand_id = 9;

--Query data from temporary table
SELECT 
	*
FROM
	#trek_products


--Section 9. Constraints
--SQL Server PRIMARY KEY
CREATE TABLE sales.activities (
    activity_id INT PRIMARY KEY IDENTITY,
    activity_name VARCHAR (255) NOT NULL,
    activity_date DATE NOT NULL
);

--The following statement creates a new table named sales.participants whose primary key consists of two columns:
CREATE TABLE sales.participants(
    activity_id int,
    customer_id int,
    PRIMARY KEY(activity_id, customer_id)
);


--SQL Server FOREIGN KEY
--consider the following vendor_groups and vendors tables:
CREATE TABLE procurement.vendor_groups (
    group_id INT IDENTITY PRIMARY KEY,
    group_name VARCHAR (100) NOT NULL
);

CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
);

--The following statements drop the  vendors table and recreate it with a FOREIGN KEY constraint:
DROP TABLE procurement.vendors;

CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
        CONSTRAINT fk_group FOREIGN KEY (group_id) 
        REFERENCES procurement.vendor_groups(group_id)
);

--First, insert some rows into the vendor_groups table:
INSERT INTO procurement.vendor_groups(group_name)
VALUES('Third-Party Vendors'),
      ('Interco Vendors'),
      ('One-time Vendors');

--Second, insert a new vendor with a vendor group into the  vendors table:
INSERT INTO procurement.vendors(vendor_name, group_id)
VALUES('ABC Corp',1);

--Third, try to insert a new vendor whose vendor group does not exist in the vendor_groups table:
INSERT INTO procurement.vendors(vendor_name, group_id)
VALUES('XYZ Corp',4);

--SQL Server CHECK Constraint
--The CHECK constraint allows you to specify the values in a column that must satisfy a Boolean expression.
--For example, to require positive unit prices, you can use:
CREATE SCHEMA test;
GO

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price INT CHECK(unit_price > 0)
);

--You can also assign the constraint a separate name by using the CONSTRAINT keyword as follows:
DROP TABLE test.products;

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) CONSTRAINT positive_price CHECK(unit_price > 0)
);

--CHECK constraint referring to multiple columns
DROP TABLE test.products;

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) CHECK(unit_price > 0),
    discounted_price DEC(10,2) CHECK(discounted_price > 0),
    CHECK(discounted_price < unit_price)
);

-- you can rewrite the above statement as follows
DROP TABLE test.products;

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2),
    discounted_price DEC(10,2),
    CHECK(unit_price > 0),
    CHECK(discounted_price > 0),
    CHECK(discounted_price > unit_price)
);

--Add CHECK constraints to an existing table
--Suppose you have the following test.products table:
DROP TABLE test.products;
CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) NOT NULL
);

--To add a CHECK constraint to the test.products table, you use the following statement:
ALTER TABLE test.products
ADD CONSTRAINT positive_price CHECK(unit_price > 0);

--To remove a CHECK constraint, you use the ALTER TABLE DROP CONSTRAINT statement:
ALTER TABLE test.products
DROP CONSTRAINT positive_price;

EXEC sp_help 'test.products';




--SQL Server Date Functions
--SQL Server DAY() function examples
--This example uses the DAY() function to extract the day from the date '2030-12-01'
SELECT 
	DAY('2030-12-01') [DAY];

SELECT 
	MONTH('2030-12-01') [MONTH];

SELECT 
	YEAR('2030-12-01') [YEAR];

--Using DAY() function with table columns example
SELECT 
	*
FROM
[sales].[orders]

SELECT 
	DAY(order_date)
FROM
[sales].[orders];

SELECT 
	MONTH(order_date)
FROM
[sales].[orders];

SELECT 
	YEAR(order_date)
FROM
[sales].[orders];

--SQL Server CURRENT_TIMESTAMP Overview
--A ) Simple CURRENT_TIMESTAMP example
--The following example uses the CURRENT_TIMESTAMP function to return the current date and time:
SELECT 
    CURRENT_TIMESTAMP AS current_date_time;

--B) Using CURRENT_TIMESTAMP function as a default value for table columns example
--First, create a new table named current_timestamp_demos whose created_at column accepts a default value as the timestamp at which a row is inserted:
CREATE TABLE current_timestamp_demos
(
    id         INT IDENTITY, 
    msg        VARCHAR(255) NOT NULL, 
    created_at DATETIME NOT NULL
                DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY(id)
);


--Second, insert two rows into the table:
INSERT INTO current_timestamp_demos(msg)
VALUES('This is the first message.');

INSERT INTO current_timestamp_demos(msg)
VALUES('current_timestamp demo');

--Third, query data from the current_timestamp_demos table:
SELECT 
    id, 
    msg, 
    created_at
FROM 
    current_timestamp_demos;

--SQL Server DATEADD() function overview
--Let’s take some examples of using the DATEADD() function.
--Add 1 second to 2018-12-31 23:59:59
SELECT 
    DATEADD(second, 1, '2018-12-31 23:59:59') result;

--Adding 1 day to 2018-12-31 00:00:00:
SELECT 
    DATEADD(day, 1, '2018-12-31 23:59:59') result;

--Adding 1 month to 2018-12-31 00:00:00:
SELECT 
    DATEADD(MONTH, 1, '2018-12-31 23:59:59') result;

----Adding 1 year to 2018-12-31 00:00:00:
SELECT 
    DATEADD(YEAR, 1, '2018-12-31 23:59:59') result;

--SQL Server DATEDIFF() overview
--A) Using DATEDIFF() function to compare the differences between two date values\
--This example uses the DATEDIFF() function to compare the difference between two dates in various date parts:
DECLARE 
    @start_dt DATETIME2= '2019-12-31 23:59:59.9999999', 
    @end_dt DATETIME2= '2020-01-01 00:00:00.0000000';

SELECT 
    DATEDIFF(year, @start_dt, @end_dt) diff_in_year, 
    DATEDIFF(quarter, @start_dt, @end_dt) diff_in_quarter, 
    DATEDIFF(month, @start_dt, @end_dt) diff_in_month, 
    DATEDIFF(dayofyear, @start_dt, @end_dt) diff_in_dayofyear, 
    DATEDIFF(day, @start_dt, @end_dt) diff_in_day, 
    DATEDIFF(week, @start_dt, @end_dt) diff_in_week, 
    DATEDIFF(hour, @start_dt, @end_dt) diff_in_hour, 
    DATEDIFF(minute, @start_dt, @end_dt) diff_in_minute, 
    DATEDIFF(second, @start_dt, @end_dt) diff_in_second, 
    DATEDIFF(millisecond, @start_dt, @end_dt) diff_in_millisecond;

--B) Using DATEDIFF() function with table column example
--The following example uses the DATEDIFF() function to compare the requested delivery date with the ship date in days and return if the order is on-time or late:
SELECT
    order_id, 
    required_date, 
    shipped_date,
    CASE
        WHEN DATEDIFF(day, required_date, shipped_date) < 0
        THEN 'Late'
        ELSE 'OnTime'
    END shipment
FROM 
    sales.orders
WHERE 
    shipped_date IS NOT NULL
ORDER BY 
    required_date;

--SQL Server DATEPART() examples
DECLARE @d DATETIME = '2019-01-01 14:30:14';
SELECT 
   DATEPART(year, @d) year, 
   DATEPART(quarter, @d) quarter, 
   DATEPART(month, @d) month, 
   DATEPART(day, @d) day, 
   DATEPART(hour, @d) hour, 
   DATEPART(minute, @d) minute, 
   DATEPART(second, @d) second;

--B) Using DATEPART() function with table columns example
--The following example uses the DATEPART() function to query the gross sales by year, quarter, month and day.
SELECT DATEPART(year, shipped_date) [year], 
       DATEPART(quarter, shipped_date) [quarter], 
       DATEPART(month, shipped_date) [month], 
       DATEPART(day, shipped_date) [day], 
       SUM(quantity * list_price) gross_sales
FROM sales.orders o
     INNER JOIN sales.order_items i ON i.order_id = o.order_id
WHERE shipped_date IS NOT NULL
GROUP BY DATEPART(year, shipped_date), 
         DATEPART(quarter, shipped_date), 
         DATEPART(month, shipped_date), 
         DATEPART(day, shipped_date)
ORDER BY [year] DESC
       
--SQL Server GETDATE() examples
SELECT 
    GETDATE() current_date_time;

--SQL Server ASCII Function
--The following shows the syntax of the ASCII() function:
SELECT 
    ASCII('AB') A, 
    ASCII('Z') Z;

--SQL Server String Functions
--SQL Server CHARINDEX() function examples
SELECT 
    CHARINDEX('SQL', 'SQL Server CHARINDEX') position;

--B) Using CHARINDEX() function to perform a case-insensitive search
SELECT 
    CHARINDEX(
        'SERVER', 
        'SQL Server CHARINDEX'
    ) position;

SELECT ascii('A')
SELECT char(65)
SELECT charindex('E','HELLO')
SELECT difference('HELLO',hell)
SELECT left ('RICHARD',4)
SELECT len('sqlserver2008')
SELECT lower('SQLSERVER2008')
SELECT ltrim('sql     ');
--Create View
SELECT
	*
FROM
	production.products;

CREATE VIEW production.vi_products
AS
SELECT
	product_id,
	product_name,
	list_price
FROM
	production.products;


SELECT 
	*
FROM
	production.vi_products
WHERE
	list_price > 999.99

--Remove/Drop View
DROP VIEW IF EXISTS production.vi_products;

--Rename View
EXEC sp_rename 
	@objname = 'production.vi_products',
	@newname = 'vi_products_new_name';

SELECT 
	*
FROM
	production.vi_products_new_name
WHERE
	list_price > 999.99

--Listing View 
SELECT 
	*
FROM
	sys.views;

--Getting View Info
EXEC sp_helptext 'production.vi_products_new_name' ;


--Index
DROP TABLE employee_temp;

CREATE TABLE employee_temp(
	employee_id INT IDENTITY,
	name varchar(30),
	salary float
);

DECLARE @cnt INT = 0;
WHILE @cnt < 1000000
BEGIN
	INSERT INTO employee_temp(name ,salary ) VALUES ('Temp' + CAST(@cnt AS varchar) , 1000+@cnt);
	SET @cnt = @cnt + 1;
END;

PRINT 'All values are inserted';
GO

SELECT 
	* 
FROM 
	employee_temp
WHERE
	employee_id = 999999;

CREATE CLUSTERED INDEX ix_employee_id
ON employee_temp (employee_id);  

--Transactions
--Create Product table
CREATE TABLE Product
(
 ProductID INT PRIMARY KEY, 
 Name VARCHAR(40), 
 Price INT,
 Quantity INT
 )
 GO

 -- Populate Product Table with test data
 INSERT INTO Product VALUES(101, 'Product-1', 100, 10)
 INSERT INTO Product VALUES(102, 'Product-2', 200, 15)
 INSERT INTO Product VALUES(103, 'Product-3', 300, 20)
 INSERT INTO Product VALUES(104, 'Product-4', 400, 25)

BEGIN TRANSACTION
	INSERT INTO Product VALUES(105,'Product-5',500, 30)
	UPDATE Product SET Price =350 WHERE ProductID = 103
	DELETE FROM Product WHERE ProductID = 103
COMMIT TRANSACTION

BEGIN TRANSACTION
	INSERT INTO Product VALUES(106,'Product-6',600, 30)
	UPDATE Product SET Price =550 WHERE ProductID = 105
	DELETE FROM Product WHERE ProductID = 104

SELECT 
	*
FROM
	Product;

ROLLBACK TRANSACTION;


--A Basic Guide to SQL Server Stored Procedures
--Creating a simple stored procedure
--The following SELECT statement returns a list of products from the products table in the BikeStores sample database:
SELECT 
	product_name, 
	list_price
FROM 
	production.products
ORDER BY 
	product_name;

--To create a stored procedure that wraps this query, you use the CREATE PROCEDURE statement as follows:
CREATE PROCEDURE uspProductList
AS
BEGIN
    SELECT 
        product_name, 
        list_price
    FROM 
        production.products
    ORDER BY 
        product_name;
END;

--Executing a stored procedure
EXECUTE uspProductList;


--Modifying a stored procedure
 ALTER PROCEDURE uspProductList
    AS
    BEGIN
        SELECT 
            product_name, 
            list_price
        FROM 
            production.products
        ORDER BY 
            list_price 
    END;


--Deleting a stored procedure
DROP PROCEDURE uspProductList;


--Parameters – learn how to create stored procedures with parameters, including optional parameters.
--Creating a stored procedure with one parameter
--The following query returns a product list from the products table in the sample database:
SELECT
    product_name,
    list_price
FROM 
    production.products
ORDER BY
    list_price;

--You can create a stored procedure that wraps this query using the CREATE PROCEDURE statement:
CREATE PROCEDURE uspFindProducts
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    ORDER BY
        list_price;
END;

--However, this time we can add a parameter to the stored procedure to find the products whose list prices are greater than an input price:
ALTER PROCEDURE uspFindProducts(@min_list_price AS DECIMAL)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price
    ORDER BY
        list_price;
END;

--Executing a stored procedure with one parameter
EXEC uspFindProducts 7000;

--Creating a stored procedure with multiple parameters
--Stored procedures can take one or more parameters. The parameters are separated by commas.

--The following statement modifies the uspFindProducts stored procedure by adding one more parameter named @max_list_price to it:

ALTER PROCEDURE uspFindProducts(@min_list_price AS DECIMAL,@max_list_price AS DECIMAL)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price
    ORDER BY
        list_price;
END;

--Once the stored procedure is modified successfully, you can execute it by passing two arguments, one for @min_list_price and the other for @max_list_price:
EXECUTE uspFindProducts 900, 1000;


--Using named parameters
EXECUTE uspFindProducts @min_list_price = 900, @max_list_price = 1000;

--Creating text parameters
ALTER PROCEDURE uspFindProducts(@min_list_price AS DECIMAL,@max_list_price AS DECIMAL,@name AS VARCHAR(max))
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;

--Once the stored procedure is altered successfully, you can execute it as follows:
EXECUTE uspFindProducts @min_list_price = 900, @max_list_price = 1000,@name = 'Trek';

--Declaring a variabl
--Using variables in a query
DECLARE @model_year SMALLINT;
SET @model_year = 2018;
SELECT
    product_name,
    model_year,
    list_price 
FROM 
    production.products
WHERE 
    model_year = @model_year
ORDER BY
    product_name;

--Accumulating values into a variable
CREATE  PROC uspGetProductList(@model_year SMALLINT) 
AS 
BEGIN
    DECLARE @product_list VARCHAR(MAX);
	SET @product_list = '';
	SELECT @product_list = @product_list + product_name + CHAR(10)
    FROM 
        production.products
    WHERE
        model_year = @model_year
    ORDER BY 
        product_name;
    PRINT @product_list;
END;


EXEC uspGetProductList 2018


--Creating output parameters
CREATE PROCEDURE uspFindProductByModel (@model_year SMALLINT,@product_count INT OUTPUT) AS
BEGIN
    SELECT 
        product_name,
        list_price
    FROM
        production.products
    WHERE
        model_year = @model_year;

    SELECT @product_count = @@ROWCOUNT;
END;


--Calling stored procedures with output parameters
DECLARE @count INT;

EXEC uspFindProductByModel
    @model_year = 2018,
    @product_count = @count OUTPUT;

SELECT @count AS 'Number of products found';


--Overview of the BEGIN...END statement
--In this syntax, you place a set of SQL statements between the BEGIN and END keywords, for example:
BEGIN
    SELECT
        product_id,
        product_name
    FROM
        production.products
    WHERE
        list_price > 100000;

    IF @@ROWCOUNT = 0
        PRINT 'No product with price greater than 100000 found';
END

--Nesting BEGIN... END
--The statement block can be nested. It simply means that you can place a BEGIN...END statement within another BEGIN... END statement.
BEGIN
    DECLARE @name VARCHAR(MAX);

    SELECT TOP 1
        @name = product_name
    FROM
        production.products
    ORDER BY
        list_price DESC;
    
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'The most expensive product is ' + @name
    END
    ELSE
    BEGIN
        PRINT 'No product found';
    END;
END

--SQL Server IF ELSE

--The following example first gets the sales amount from the sales.order_items table in the sample database and then prints out a message if the sales amount is greater than 1 million.

BEGIN
    DECLARE @sales INT;

    SELECT 
        @sales = SUM(list_price * quantity)
    FROM
        sales.order_items i
        INNER JOIN sales.orders o ON o.order_id = i.order_id
    WHERE
        YEAR(order_date) = 2018;

    SELECT @sales;

    IF @sales > 1000000
    BEGIN
        PRINT 'Great! The sales amount in 2018 is greater than 1,000,000';
    END
END


--The IF ELSE statement
BEGIN
    DECLARE @sales INT;

    SELECT 
        @sales = SUM(list_price * quantity)
    FROM
        sales.order_items i
        INNER JOIN sales.orders o ON o.order_id = i.order_id
    WHERE
        YEAR(order_date) = 2017;

    SELECT @sales;

    IF @sales > 10000000
    BEGIN
        PRINT 'Great! The sales amount in 2018 is greater than 10,000,000';
    END
    ELSE
    BEGIN
        PRINT 'Sales amount in 2017 did not reach 10,000,000';
    END
END

--Nested IF...ELSE
BEGIN
    DECLARE @x INT = 10,
            @y INT = 20;

    IF (@x > 0)
    BEGIN
        IF (@x < @y)
            PRINT 'x > 0 and x < y';
        ELSE
            PRINT 'x > 0 and x >= y';
    END			
END


--SQL Server WHILE

--SQL Server WHILE example
DECLARE @counter INT = 1;

WHILE @counter <= 5
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END


--SQL Server BREAK statement example
DECLARE @counter INT = 0;

WHILE @counter <= 5
BEGIN
    SET @counter = @counter + 1;
    IF @counter = 4
        BREAK;
    PRINT @counter;
END

--SQL Server CONTINUE example
DECLARE @counter INT = 0;

WHILE @counter < 5
BEGIN
    SET @counter = @counter + 1;
    IF @counter = 3
        CONTINUE;	
    PRINT @counter;
END

--SQL Server Dynamic SQL
--SQL Server dynamic SQL and stored procedures

--This stored procedure accepts any table and returns the result set from a specified table by using the dynamic SQL:

CREATE PROC usp_query (
    @table NVARCHAR(128)
)
AS
BEGIN

    DECLARE @sql NVARCHAR(MAX);
    -- construct SQL
    SET @sql = N'SELECT * FROM ' + @table;
    -- execute the SQL
    EXEC sp_executesql @sql;
    
END;

--The following statement calls the usp_query stored procedure to return all rows from the production.brands table:
EXEC usp_query 'production.brands';


--This stored procedure returns the top 10 rows from a table by the values of a specified column:
CREATE OR ALTER PROC usp_query_topn(
    @table NVARCHAR(128),
    @topN INT,
    @byColumn NVARCHAR(128)
)
AS
BEGIN
    DECLARE 
        @sql NVARCHAR(MAX),
        @topNStr NVARCHAR(MAX);

    SET @topNStr  = CAST(@topN as nvarchar(max));

    -- construct SQL
    SET @sql = N'SELECT TOP ' +  @topNStr  + 
                ' * FROM ' + @table + 
                    ' ORDER BY ' + @byColumn + ' DESC';
    -- execute the SQL
    EXEC sp_executesql @sql;
    
END;

--For example, you can get the top 10 most expensive products from the production.products table:
EXEC usp_query_topn 
        'production.products',
        10, 
        'list_price';

--This statement returns the top 10 products with the highest quantity in stock:
EXEC usp_query_topn 
        'production.stocks',
        10, 
        'quantity';

--Stored Procedure Assingments
CREATE SCHEMA temp;

CREATE TABLE temp.employee
(
    id         INTEGER NOT NULL PRIMARY KEY IDENTITY,
    first_name VARCHAR(10),
    last_name  VARCHAR(10),
    salary     DECIMAL(10, 2),
    city       VARCHAR(20),
)

ALTER PROCEDURE sp_insert_employee(@first_name VARCHAR(10),@last_name VARCHAR(10),@salary DECIMAL(10, 2),@city VARCHAR(20))
AS
	BEGIN
		INSERT INTO temp.employee(first_name,last_name,salary,city) VALUES(@first_name,@last_name,@salary,@city)
	END

EXEC sp_insert_employee @first_name='Vivek' , @last_name='Gohil' ,  @salary=1000 , @city = 'Mumbai'

SELECT 
	*
FROM
	temp.employee;