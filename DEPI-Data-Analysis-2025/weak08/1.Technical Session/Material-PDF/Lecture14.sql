--- Table      Create Table Categories
--- View       Temporary table 
--- CTEs Common Table expressions  table to be used within the query 

SELECT * 
From Customers

Create View Test_view As 
select ContactName 
from Customers

Drop View Test_view

select lower(ContactName) As Name_lower
From Test_view

select upper(ContactName) As Name_lower
From Test_view

select * 
From 'Order Details'


With CTE_Name As (
SELECT * , (CASE
            when quantity < 10 then 'good'
            when quantity between 10 and 20 Then 'Very Good'
            when quantity > 20 Then 'excellent' 
            End )  As Quantity_check
from 'Order Details')
SELECT lower(Quantity_check) As lower 
From CTE_Name


with country_nulls as (
SELECT coalesce(country , 'unkown') As country_cleaned
from customers ) 
SELECT country_cleaned 
From country_nulls
where country_cleaned  = 'unkown'


----- Friday Session ---- 

-- Retrieve the first 5 characters of each product name?

SELECT ProductName, SUBSTR(ProductName, 1, 5) AS First5Chars
FROM Products;
 
-- Find the position of the first occurrence of 's' in the product names? 
SELECT ProductName, INSTR(ProductName, 's') AS PositionOfS
FROM Products;

-- Extract the domain name from the email addresses of customers. 
-- only example -- no data available
SELECT ContactName, 
       SUBSTR(Email, INSTR(Email, '@') + 1) AS Domain
FROM Customers
WHERE Email IS NOT NULL;

-- Replace 'Car' with 'Vehicle' in all product names.
SELECT ProductName, REPLACE(ProductName, 'Car', 'Vehicle') AS UpdatedProductName
FROM Products;


-- Concatenate customer first and company name ? 
SELECT CustomerID, ContactName || ' ' || CompanyName AS Name
FROM Customers;

Select orderid
, quantity
,(discount * 100) || '%' As DiscountPercent 
FROM "Order Details"
WHERE productid = 20
order by DiscountPercent DESC

SELECT orderid,
       quantity,
       printf('%.0f', discount * 100) || '%' AS DiscountPercent
FROM "Order Details"
WHERE productid = 20
ORDER BY DiscountPercent DESC;

-- Retrieve the first 3 characters of each product name? 
SELECT ProductName, SUBSTR(ProductName, 1, 3) AS First3Chars
FROM Products;

SELECT productname, SUBSTR(ProductName, 3, 2) AS string_substring
FROM Products;

-- Extracting the first part of a string (before a delimiter)
-- INSTR(ProductName, ','): returns the position of the first occurrence of the delimiter in the string.
-- SUBSTR(ProductName, 1, INSTR(ProductName, ',') - 1): extracts from the beginning of the ProductName
-- Up to (but not including) the position of the first comma.


SELECT productname, SUBSTR(ProductName, 1, INSTR(ProductName, ' ') - 1) AS FirstPart
FROM Products;

-- Extracting the second part (after a delimiter)

SELECT productname, SUBSTR(ProductName,  INSTR(ProductName, ' ') + 1) AS SecondPart
FROM Products;

-- using null if and if null

SELECT contactname, NULLIF(contactname, '') AS Name_final
FROM Customers

SELECT contactname,
           IFNULL(NULLIF(contactname, ''), 'NA') AS Name_final
FROM Customers
-------------------------------------------------------------------------------------------
------------Exercise from 7:8 pm ----------------------------------------------------------


----- Group By ------
--List number of orders per product from the most sold?
SELECT productid,
count (orderid) num_orders
FROM "Order Details"
GROUP by productid
order by num_orders --or groub by 2 -- 


-- 5 min Exercise -- Count number of orders each employess made for each ship country? -- 
SELECT employeeid
, shipcountry
, count(orderid) As num_orders
FROM Orders
GROUP by 1,2
order by 2,3

-- count number of orders each employess made for each ship country where no of orders is greater than 100? --
-- having filters on groups but where filters on database.
-- having come after group by but where comes before the group by

SELECT
employeeid,
shipcountry,
count(orderid) num_orders
FROM Orders
where shipcountry !=  'USA' 
group BY employeeid, shipcountry
having num_orders > 100
order by num_orders

----------------Sub queries -----------------
-- What is the company name and region every customer is from who has ordered with freight > 100 ?
-- sql start from the most inner query--
-- No limits of no of subqueries -- 

SELECT companyname, region
From Customers
WHERE customerid in (
  SELECT customerid 
  from Orders
  where freight > 180)

-- -- optional exercise (15 Minutes)
-- What is the company namw, contact name and phone number of the customers that have bought Tofu?

SELECT companyname, contactname , phone
from Customers
WHERE customerid in (
SELECT customerid
FROM Orders
WHERE orderid in ( 
  SELECT orderid
  FROM "Order Details"
  where productid in (
    SELECT productid
    from Products
    where productname = "Tofu"
  )
)
)
-- Note --
--Sub queries only retrieve one column   
-- use in  as filtering 


---------------------------------------------------------------------
------------------------------- Joins -------------------------------
--- Inner join -- 

-- List all suppliers company names along with the product names and prices that they provide -- 
SELECT companyname, productname, unitprice
from Suppliers As S
Inner JOIN Products As P
on S.SupplierID = P.SupplierID

--Exercise -- For each order made, list the customer company naem and the employee's last name --
SELECT orderid, companyname, lastname
FROM Orders
INNER Join Customers
On Orders.CustomerID = Customers.CustomerID
INNER JOIN Employees 
ON Orders.EmployeeID = Employees.EmployeeID

--List all customer's company name  with how many orders they made
SELECT Customers.CompanyName,
COUNT(orderid) as NoOfOrders 
FROM Customers 
LEFT JOIN Orders
on Customers.CustomerID = Orders.CustomerID
GROUP by 1
-- Group by should be always used with aggregation functions. -- 

--Show the supplier ID, ProductName, CompanyName from all product suppliedCategories
-- by "Exotic Liquids", "Specialty Biscuits, Ltd.", "Escargots Nouveax" sorted by the supplier IDCategories

SELECT
s.SupplierID, productname, companyname
FROM Products p -- from all products - -
LEFT JOIN Suppliers s 
on p.SupplierID = s.SupplierID
WHERE s.CompanyName In ("Exotic Liquids", "Specialty Biscuits, Ltd.", "Escargots Nouveax")













