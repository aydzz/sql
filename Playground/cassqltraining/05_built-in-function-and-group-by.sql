-- TEST QUERIES: --
SELECT TOP(10) * FROM TRN_Sales_Data_DS;

-- Q01

SELECT TOP(3) 
    YEAR(SD.Order_Date) AS OD_Year,
    DAY(SD.Order_Date) AS OD_DAY,
    DATENAME(dw,SD.Order_Date) AS OD_DATE_NAME,
    MONTH(SD.Order_Date) AS OD_MONTH
    FROM dbo.TRN_Sales_Data_DS as SD
    LEFT OUTER JOIN dbo.TRN_Sales_Data_DS as SDB ON SD.Country = SDB.Country
WHERE YEAR(SD.Order_Date) > 2016

-- Q02: TAKE NOTE that when you have an aggregate function in the select statement, it is important to note that all column should be aggregated as well.

SELECT TOP(100)
    PK_ID as ID,
    AVG(A.Day_Change_Recommendation) AS Average, 
    MIN(A.Day_Change_Recommendation) AS Min_1, 
    MAX(A.Day_Change_Recommendation) AS Max_1
    FROM TRN_Cramer_Picks_DS AS A
    GROUP BY PK_ID
HAVING A.PK_ID != 1; -- ALSO, instead of where, we use HAVING in aggregated queries

-- Q03:

SELECT DISTINCT A.Country FROM TRN_Sales_Data_DS as A;

-- 04: Combination OF DISTINCT and COUNT
SELECT 
    DISTINCT A.Region, 
    (SELECT COUNT( DISTINCT B.Country) 
        FROM TRN_Sales_Data_DS AS B
        WHERE B.Region = A.Region
    ) AS Country_Count 
FROM TRN_Sales_Data_DS as A;

-- 05: SELECTING MAX from Q05 

SELECT MAX(
    C.Country_Count
) FROM (
    SELECT 
        DISTINCT A.Region, 
        (SELECT COUNT( DISTINCT B.Country) 
            FROM TRN_Sales_Data_DS AS B
            WHERE B.Region = A.Region
        ) AS Country_Count 
    FROM TRN_Sales_Data_DS as A
) AS C

-- Q05: Sample Ranking ( based on region, country and unit sold)

SELECT DISTINCT A.Region
    , (
        SELECT COUNT(DISTINCT B.Country) FROM TRN_Sales_Data_DS AS B WHERE B.Region = A.Region
    ) AS Country_Count
 FROM TRN_Sales_Data_DS AS A

-- Q06: 

 SELECT DISTINCT A.Region
    , (
        SELECT SUM(DISTINCT B.Units_Sold) FROM TRN_Sales_Data_DS AS B WHERE B.Region = A.Region
    ) AS Total_Units_Sold
 FROM TRN_Sales_Data_DS AS A

 -- Q07: Combination of Q05 and Q06 to  be able to get the Total Units Sold in Each Region
    -- Q05
    SELECT DISTINCT A.Region
        , (
            SELECT COUNT(DISTINCT B.Country) FROM TRN_Sales_Data_DS AS B WHERE B.Region = A.Region
        ) AS Country_Count
        ,  SDB.Total_Units_Sold
    FROM TRN_Sales_Data_DS AS A 
    INNER JOIN 
    (
        -- Q06
        SELECT DISTINCT A.Region
        , (
            SELECT SUM(DISTINCT B.Units_Sold) FROM TRN_Sales_Data_DS AS B WHERE B.Region = A.Region
        ) AS Total_Units_Sold
        FROM TRN_Sales_Data_DS AS A
    ) AS SDB ON A.Region = SDB.Region


--Q08: Adding rank in Q07

SELECT *
, RANK() OVER(ORDER BY A.Total_Units_Sold ASC) AS Rank_per_Units_Sold
 FROM (
    SELECT DISTINCT A.Region
        , (
            SELECT COUNT(DISTINCT B.Country) FROM TRN_Sales_Data_DS AS B WHERE B.Region = A.Region
        ) AS Country_Count
        ,  SDB.Total_Units_Sold
    FROM TRN_Sales_Data_DS AS A 
    INNER JOIN 
    (
        -- Q06
        SELECT DISTINCT A.Region
        , (
            SELECT SUM(B.Units_Sold) FROM TRN_Sales_Data_DS AS B WHERE B.Region = A.Region
        ) AS Total_Units_Sold
        FROM TRN_Sales_Data_DS AS A
    ) AS SDB ON A.Region = SDB.Region
) AS A

-- GROUP BY TOPIC --

-- Q09: Grouping with Aggregate
SELECT A.Region
    , A.Country
    , SUM(A.Units_Sold) AS Unit_Sold
    , SUM(A.Unit_SellingPrice) as Unit_Selling_Price -- Seems like Aggregates also calculates the results based on the grouping set in the query.
    FROM TRN_Sales_Data_DS AS A 
    WHERE  
        A.Sales_Channel = 'Online' AND
        A.Country = 'Afghanistan'
    GROUP BY Region, Country

-- Q10: Just checking values in Q09

SELECT A.Region
, A.Country
, A.Units_Sold AS Unit_Sold
, A.Unit_SellingPrice AS Unit_Selling_Price
, (SELECT SUM(B.Unit_SellingPrice) FROM TRN_Sales_Data_DS AS B WHERE B.Country = A.Country AND B.Sales_Channel = 'Online') AS TOTAL
FROM TRN_Sales_Data_DS AS A 
WHERE  
    A.Sales_Channel = 'Online' AND
    A.Country = 'Afghanistan'

--


















