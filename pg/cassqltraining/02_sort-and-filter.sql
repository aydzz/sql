-- LECTURE

-- Sort results using the ORDER BY clause
    -- QUERY 01: 
    SELECT Name, ListPrice FROM SalesLT.Product;
    -- QUERY 02: 
    SELECT Name, ListPrice FROM SalesLT.Product ORDER BY Name;
    --QUERY 03:
    SELECT Name, ListPrice FROM SalesLT.Product ORDER BY ListPrice;
    -- QUERY 04:
    SELECT Name, ListPrice FROM SalesLT.Product ORDER BY ListPrice DESC;
    -- QUERY 05:
    SELECT Name, ListPrice FROM SalesLT.Product ORDER BY ListPrice DESC, Name ASC; -- you can sort the result by multiple columns


-- Restrict results using TOP
    -- QUERY 06:
    SELECT TOP (20) Name, ListPrice FROM SalesLT.Product ORDER BY ListPrice DESC;
    -- QUERY 07:
    SELECT TOP (20) WITH TIES Name, ListPrice FROM SalesLT.Product ORDER BY ListPrice DESC; 
        -- take note that TIES are relative to the one we defined in the ORDER BY
        -- ref: https://stackoverflow.com/a/57974314/9765927
    -- QUERY 08:
    SELECT TOP (20) PERCENT WITH TIES Name, ListPrice FROM SalesLT.Product ORDER BY ListPrice DESC;

-- Retrieve pages of results with OFFSET and FETCH
    -- QUERY 09:
    SELECT Name, ListPrice FROM SalesLT.Product ORDER BY Name OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
    -- QUERY 10:
    SELECT Name, ListPrice FROM SalesLT.Product ORDER BY Name OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- Use the ALL and DISTINCT options
    -- QUERY 11:
    SELECT Color FROM SalesLT.Product;
    -- QUERY 12:
    SELECT ALL Color FROM SalesLT.Product; -- take note that the ALL parameter is in the SELECT clause as DEFAULT
    -- QUERY 13:
    SELECT DISTINCT Color FROM SalesLT.Product;
    -- QUERY 14:
    SELECT DISTINCT Color, Size FROM SalesLT.Product; -- will return set that have a distinct Color AND Size
    
-- Filter results with the WHERE clause
    -- QUERY 15:
    SELECT Name, Color, Size FROM SalesLT.Product WHERE ProductModelID = 6 ORDER BY Name;
    -- QUERY 16:
    SELECT Name, Color, Size FROM SalesLT.Product WHERE ProductModelID <> 6 ORDER BY Name;
    -- QUERY 17:
    SELECT Name, ListPrice FROM SalesLT.Product WHERE ListPrice > 1000.00 ORDER BY ListPrice;
    -- QUERY 18:
    SELECT Name, ListPrice FROM SalesLT.Product WHERE Name LIKE 'HL Road Frame %';
    -- QUERY 19:
    SELECT Name, ListPrice FROM SalesLT.Product WHERE ProductNumber LIKE 'FR-_[0-9][0-9]_-[0-9][0-9]'; -- LIKE clauses accepts regular expressions for a more powerful matching feature.
    -- QUERY 20:
    SELECT Name, ListPrice FROM SalesLT.Product WHERE SellEndDate IS NOT NULL;
        -- Note that to filter based on NULL values you must use IS NULL (or IS NOT NULL) you cannot compare a NULL value using the = operator.
    -- QUERY 21:
    SELECT Name FROM SalesLT.Product WHERE SellEndDate BETWEEN '2006/1/1' AND '2006/12/31';
    -- QUERY 22:
    SELECT ProductCategoryID, Name, ListPrice FROM SalesLT.Product WHERE ProductCategoryID IN (5,6,7);
    -- QUERY 23:
    SELECT ProductCategoryID, Name, ListPrice, SellEndDate FROM SalesLT.Product WHERE ProductCategoryID IN (5,6,7) AND SellEndDate IS NULL;
    -- QUERY 24:
    SELECT Name, ProductCategoryID, ProductNumber FROM SalesLT.Product WHERE ProductNumber LIKE 'FR%' OR ProductCategoryID IN (5,6,7);


-- CHALLENGE QUERIES:

    -- CHALLENGE 1:
        -- QUERY 1:
        SELECT DISTINCT City, StateProvince
        FROM SalesLT.Address
        ORDER BY City
        -- QUERY 2:
        SELECT TOP (10) PERCENT WITH TIES Name
        FROM SalesLT.Product
        ORDER BY Weight DESC;

    -- CHALLENGE 2:
        -- QUERY 1:
        SELECT Name, Color, Size FROM SalesLT.Product WHERE ProductModelID = 1;
        -- QUERY 2:
        SELECT ProductNumber, Name FROM SalesLT.Product WHERE Color IN ('Black','Red','White') AND Size IN ('S','M');
        -- QUERY 3:
        SELECT ProductNumber, Name, ListPrice FROM SalesLT.Product WHERE ProductNumber LIKE 'BK-%';
        -- QUERY 4:
        SELECT ProductNumber, Name, ListPrice FROM SalesLT.Product WHERE ProductNumber LIKE 'BK-[^R]%-[0-9][0-9]';






    


