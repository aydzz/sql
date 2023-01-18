-- Combine multiple tables with JOINs in T-SQL
-- LECTURE QUERIES

-- QUERY 01:
SELECT p.ProductID, m.Name AS Model, p.Name AS Product FROM SalesLT.Product AS p JOIN SalesLT.ProductModel AS m ON p.ProductModelID = m.ProductModelID;

-- QUERY 02: Using CROSS JOIN
SELECT Column FROM Table1 CROSS JOIN Table2; -- will return Cartesian product without getting an error ( missing ON )

-- QUERY 03: INNER JOIN ( implicit )
SELECT emp.FirstName, ord.Amount FROM HR.Employee AS emp  JOIN Sales.SalesOrder AS ord ON emp.EmployeeID = ord.EmployeeID; 
    -- take note that JOIN ON clauses is a default INNER JOIN form
    -- meaning it will have the same effect as the explicit INNER JOIN ON clause

-- QUERY 04: INNER JOIN ( explicit )
SELECT emp.FirstName, ord.Amount FROM HR.Employee AS emp  INNER JOIN Sales.SalesOrder AS ord ON emp.EmployeeID = ord.EmployeeID;
    -- You can use INNER JOIN with Single or multiple columns for JOINING by using AND

-- QUERY 05:
SELECT p.ProductID, m.Name AS Model, p.Name AS Product 
    FROM Production.Product AS p 
    INNER JOIN Production.ProductModel AS m 
    ON p.ProductModelID = m.ProductModelID 
    ORDER BY p.ProductID;

-- QUERY 06: Joining more than 2 Tables
SELECT od.SalesOrderID, m.Name AS Model, p.Name AS ProductName, od.OrderQty
FROM Production.Product AS p
INNER JOIN Production.ProductModel AS m
    ON p.ProductModelID = m.ProductModelID
INNER JOIN Sales.SalesOrderDetail AS od
    ON p.ProductID = od.ProductID
ORDER BY od.SalesOrderID;

-- QUERY 07: 

SELECT emp.FirstName, ord.Amount
FROM HR.Employee AS emp
INNER JOIN Sales.SalesOrder AS ord
    ON emp.EmployeeID = ord.EmployeeID;


-- QUERY 08: LEFT OUTER JOIN
SELECT emp.FirstName, ord.Amount
FROM HR.Employee AS emp
LEFT OUTER JOIN Sales.SalesOrder AS ord
    ON emp.EmployeeID = ord.EmployeeID;

-- QUERY 09:
SELECT emp.FirstName, ord.Amount
FROM HR.Employee AS emp
LEFT JOIN Sales.SalesOrder AS ord -- we can ommit the 'OUTER' in the JOIN clause
    ON emp.EmployeeID = ord.EmployeeID;

-- QUERY 10: Example of SELF JOIN
SELECT emp.FirstName AS Employee, 
       mgr.FirstName AS Manager
FROM HR.Employee AS emp
LEFT OUTER JOIN HR.Employee AS mgr
  ON emp.ManagerID = mgr.EmployeeID;



-- EXERCISE

-- Use inner joins
-- QUERY 01: 
SELECT SalesLT.Product.Name As ProductName, SalesLT.ProductCategory.Name AS Category
FROM SalesLT.Product
INNER JOIN SalesLT.ProductCategory
ON SalesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID;

-- QUERY 02: INNER JOIN and JOIN ( the same )
SELECT SalesLT.Product.Name As ProductName, SalesLT.ProductCategory.Name AS Category
FROM SalesLT.Product
JOIN SalesLT.ProductCategory -- this is without the INNER ( inner join is the default type JOIN )
    ON SalesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID;

-- QUERY 03: Usee of alias
SELECT p.Name As ProductName, c.Name AS Category
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory As c
    ON p.ProductCategoryID = c.ProductCategoryID;

-- QUERY 04: Joining 3 tables
SELECT oh.OrderDate, oh.SalesOrderNumber, p.Name As ProductName, od.OrderQty, od.UnitPrice, od.LineTotal
FROM SalesLT.SalesOrderHeader AS oh
JOIN SalesLT.SalesOrderDetail AS od
    ON od.SalesOrderID = oh.SalesOrderID
JOIN SalesLT.Product AS p
    ON od.ProductID = p.ProductID
ORDER BY oh.OrderDate, oh.SalesOrderID, od.SalesOrderDetailID;

-- Use outer joins
-- QUERY 05: LEFT OUTER JOIN
SELECT c.FirstName, c.LastName, oh.SalesOrderNumber
FROM SalesLT.Customer AS c
LEFT OUTER JOIN SalesLT.SalesOrderHeader AS oh
    ON c.CustomerID = oh.CustomerID
ORDER BY c.CustomerID;

-- QUERY 06: LEFT JOIN
SELECT c.FirstName, c.LastName, oh.SalesOrderNumber
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS oh -- is equal to LEFT OUTER JOIN ( OUTER can be ommited )
    ON c.CustomerID = oh.CustomerID
ORDER BY c.CustomerID;

-- QUERY 07: Retrun the UNMATCHED sets 
SELECT c.FirstName, c.LastName, oh.SalesOrderNumber
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS oh
    ON c.CustomerID = oh.CustomerID
WHERE oh.SalesOrderNumber IS NULL 
ORDER BY c.CustomerID;


-- QUERY 08: Joining 3 Tables
SELECT p.Name As ProductName, oh.SalesOrderNumber
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.SalesOrderDetail AS od
    ON p.ProductID = od.ProductID
LEFT JOIN SalesLT.SalesOrderHeader AS oh
    ON od.SalesOrderID = oh.SalesOrderID
ORDER BY p.ProductID;

-- QUERY 09: Combining INNER and OUTER JOINS
SELECT p.Name As ProductName, c.Name AS Category, oh.SalesOrderNumber
FROM SalesLT.Product AS p
LEFT OUTER JOIN SalesLT.SalesOrderDetail AS od
    ON p.ProductID = od.ProductID
LEFT OUTER JOIN SalesLT.SalesOrderHeader AS oh
    ON od.SalesOrderID = oh.SalesOrderID
INNER JOIN SalesLT.ProductCategory AS c
    ON p.ProductCategoryID = c.ProductCategoryID
ORDER BY p.ProductID;
    -- it is prefered to define ( add ) the type of join if you are going to use BOTH type of JOINS for readability

-- Use a cross join
-- QUERY 10: 
SELECT p.Name, c.FirstName, c.LastName, c.EmailAddress
FROM SalesLT.Product as p
CROSS JOIN SalesLT.Customer as c;
     -- only one use case for CROSS JOIN

-- Use a self join
SELECT pcat.Name AS ParentCategory, cat.Name AS SubCategory
FROM SalesLT.ProductCategory as cat
JOIN SalesLT.ProductCategory pcat
    ON cat.ParentProductCategoryID = pcat.ProductCategoryID
ORDER BY ParentCategory, SubCategory;
    -- Take note that this is really useful for recursive relationships


--- CHALLENGES
-- CHALLENGE 1:

--QUERY 01: Retrieve customer orders:
SELECT c.CompanyName, oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS oh
    ON oh.CustomerID = c.CustomerID;
--QUERY 02:  Retrieve customer orders with addresses:
SELECT c.CompanyName,
       a.AddressLine1,
       ISNULL(a.AddressLine2, '') AS AddressLine2,
       a.City,
       a.StateProvince,
       a.PostalCode,
       a.CountryRegion,
       oh.SalesOrderID,
       oh.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS oh
    ON oh.CustomerID = c.CustomerID
JOIN SalesLT.CustomerAddress AS ca
    ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
    ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office';

-- CHALLENGE 2:

--QUERY 01: Retrieve a list of all customers and their orders:
SELECT c.CompanyName, c.FirstName, c.LastName,
       oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS oh
    ON c.CustomerID = oh.CustomerID
ORDER BY oh.SalesOrderID DESC;
--QUERY 02: Retrieve a list of customers with no address:
SELECT c.CompanyName, c.FirstName, c.LastName, c.Phone
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.CustomerAddress AS ca
    ON c.CustomerID = ca.CustomerID
WHERE ca.AddressID IS NULL;

-- CHALLENGE 3: 
-- QUERY 01: Retrieve product information by category:
SELECT pcat.Name AS ParentCategory, cat.Name AS SubCategory, prd.Name AS ProductName
FROM SalesLT.ProductCategory pcat
JOIN SalesLT.ProductCategory as cat
    ON pcat.ProductCategoryID = cat.ParentProductCategoryID
JOIN SalesLT.Product as prd
    ON prd.ProductCategoryID = cat.ProductCategoryID
ORDER BY ParentCategory, SubCategory, ProductName;







