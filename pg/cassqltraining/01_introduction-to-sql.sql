-- Introduction to SQL

-- CHALLENGE 1: Retrieve customer data
SELECT TOP 10 * FROM SalesLT.Customer
SELECT TOP 10 Title, FirstName, MiddleName,LastName, Suffix FROM SalesLT.Customer-- SELECT TOP 10 ISNULL(Title,'') + ' ' + FirstName + ' ' + LastName AS CustomerName, Phone FROM SalesLT.Customer

--CHALLENGE 2: Retrieve customer order data
SELECT TOP 10 TRY_CAST(CustomerID AS varchar(4)) + ': ' + CompanyName AS Customer FROM SalesLT.Customer
SELECT TOP 10 * FROM SalesLT.SalesOrderHeader;
SELECT TOP 10 SalesOrderNumber + ' (' + TRY_CAST(RevisionNumber AS varchar(4)) + ') ', TRY_CONVERT(nvarchar(30), OrderDate,102) FROM SalesLT.SalesOrderHeader