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


-- 









