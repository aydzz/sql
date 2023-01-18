
-- MODULE: Use scalar or multi-valued subqueries
-- https://learn.microsoft.com/en-us/training/modules/write-subqueries/3-scalar-multi-values-subqueries

-- QUERY 01:
SELECT MAX(SalesOrderID)
FROM Sales.SalesOrderHeader

-- Query 02:
SELECT SalesOrderID, ProductID, OrderQty
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 
   (SELECT MAX(SalesOrderID)
    FROM Sales.SalesOrderHeader);


-- Query 03:
-- di ko gets tong isang to
SELECT SalesOrderID, ProductID, OrderQty,
    (SELECT AVG(OrderQty)
     FROM SalesLT.SalesOrderDetail) AS AvgQty
FROM SalesLT.SalesOrderDetail
WHERE SalesOrderID = 
    (SELECT MAX(SalesOrderID)
     FROM SalesLT.SalesOrderHeader);

    --Test 1: 
    SELECT TOP 100 Region, Total_profit, (SELECT AVG(Total_profit) FROM TRN_Sales_Data_DS AS B WHERE B.Region = A.Region) AS Profit_Average FROM TRN_Sales_Data_DS AS A WHERE Region != 'Central America'
        -- Take note that it was actually possible to create a subquery for a separate column ( with the example I've given ( runnable )) 


-- TOPIC: Multi-valued subqueries
-- QUery 04
SELECT CustomerID, SalesOrderID
FROM Sales.SalesOrderHeader
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Sales.Customer
    WHERE CountryRegion = 'Canada');

-- Query 05
-- equivalent join query of the above:
SELECT c.CustomerID, o.SalesOrderID
FROM Sales.Customer AS c
JOIN Sales.SalesOrderHeader AS o
    ON c.CustomerID = o.CustomerID
WHERE c. CountryRegion = 'Canada';



-- TOPIC: Use self-contained or correlated subqueries
-- https://learn.microsoft.com/en-us/training/modules/write-subqueries/4-self-contained-correlated-subqueries
-- Query 06:
SELECT SalesOrderID, CustomerID, OrderDate
FROM SalesLT.SalesOrderHeader AS o1
WHERE SalesOrderID =
    (SELECT MAX(SalesOrderID)
     FROM SalesLT.SalesOrderHeader AS o2
     WHERE o2.CustomerID = o1.CustomerID)
ORDER BY CustomerID, OrderDate;


-- Query 07: Use of Comparator Values
SELECT CustomerID, CompanyName, EmailAddress 
FROM Sales.Customer AS c 
WHERE
(SELECT COUNT(*) 
  FROM Sales.SalesOrderHeader AS o
  WHERE o.CustomerID = c.CustomerID) > 0;

-- Query 08: Use of Exists instead of Longer Comparators ( like the query 07 )
    -- Take note of this:
       -- If you're converting a subquery using COUNT(*) to one using EXISTS, make sure the subquery uses a SELECT * and not SELECT COUNT(*).
       -- SELECT COUNT(*) always returns a row, so the EXISTS will always return TRUE.
SELECT CustomerID, CompanyName, EmailAddress 
FROM Sales.Customer AS c 
WHERE EXISTS
(SELECT * 
  FROM Sales.SalesOrderHeader AS o
  WHERE o.CustomerID = c.CustomerID);

-- QUERY 09:
SELECT CustomerID, CompanyName, EmailAddress 
FROM SalesLT.Customer AS c 
WHERE NOT EXISTS
  (SELECT * 
   FROM SalesLT.SalesOrderHeader AS o
   WHERE o.CustomerID = c.CustomerID);



-- EXERCISES:
-- QUERY 10:
SELECT MAX(UnitPrice)
FROM SalesLT.SalesOrderDetail;

-- QUERY 11:
SELECT Name, ListPrice
FROM SalesLT.Product
WHERE ListPrice >
    (SELECT MAX(UnitPrice)
     FROM SalesLT.SalesOrderDetail);


-- QUERY 12:
SELECT DISTINCT ProductID
FROM SalesLT.SalesOrderDetail
WHERE OrderQty >= 20;

-- QUERY 13:
SELECT Name FROM SalesLT.Product
WHERE ProductID IN
    (SELECT DISTINCT ProductID
     FROM SalesLT.SalesOrderDetail
     WHERE OrderQty >= 20);

-- QUERY 14:
SELECT DISTINCT Name
FROM SalesLT.Product AS p
JOIN SalesLT.SalesOrderDetail AS o
    ON p.ProductID = o.ProductID
WHERE OrderQty >= 20;

-- QUERY 15:
SELECT od.SalesOrderID, od.ProductID, od.OrderQty
FROM SalesLT.SalesOrderDetail AS od
ORDER BY od.ProductID;

-- QUERY 16:
SELECT od.SalesOrderID, od.ProductID, od.OrderQty
FROM SalesLT.SalesOrderDetail AS od
WHERE od.OrderQty =
    (SELECT MAX(OrderQty)
     FROM SalesLT.SalesOrderDetail AS d
     WHERE od.ProductID = d.ProductID)
ORDER BY od.ProductID;


SELECT o.SalesOrderID, o.OrderDate, o.CustomerID
FROM SalesLT.SalesOrderHeader AS o
ORDER BY o.SalesOrderID;


SELECT o.SalesOrderID, o.OrderDate,
      (SELECT CompanyName
      FROM SalesLT.Customer AS c
      WHERE c.CustomerID = o.CustomerID) AS CompanyName
FROM SalesLT.SalesOrderHeader AS o
ORDER BY o.SalesOrderID;







