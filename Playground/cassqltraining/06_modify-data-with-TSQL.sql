SELECT * FROM PS_Test_Table;


SELECT *, 'Get Framed' as Sample FROM PS_Log_Table;


-- @Comment
    -- Take note that insertion with DEFAULT is not working ( seems like the ID  ( Autonumber should be inserted manually ))
        -- Take note that I've added a new RID and this is still the case ( needs to be inserted manually)
INSERT INTO PS_Log_Table (PK_ID, ID, Integer_1, Integer_2, Text_1 ) 
VALUES(
    (SELECT TOP(1) (MAX(PK_ID) + 1) AS Val FROM PS_Log_Table), -- @CLARIFY This is still requied to the inserted for now.
    (SELECT TOP(1) (MAX(PK_ID) + 1) AS Val FROM PS_Log_Table), -- @CLARIFY
    1,2,3
)

SELECT *,'Get Framed' as Column_1 INTO PS_Log_Table_1 FROM PS_Log_Table; -- creates a new table ( PS_Log_Table_1 
SELECT  * FROM PS_Log_Table_1

SELECT IDENT_CURRENT('PS_Log_Table.ID');

SELECT (MAX(LT2.PK_ID) + 1) AS Value FROM PS_Log_Table AS LT2

-- THIS IS NOT WORKING
 -- @update: It now works, SEQ has been created but SEQUENCE is DB Level Entity so we can refer to it without creating it again.
CREATE SEQUENCE SEQ AS INT
START WITH 9 INCREMENT BY 1; -- we cant use subqueries for the values of this ( even if it returns a scalar value )

DECLARE @NUM [int] = (NEXT VALUE FOR SEQ);

SELECT  * FROM TRN_Log_Table
INSERT INTO TRN_Log_Table (PK_ID, Int_1) SELECT ((SELECT MAX(PK_ID) + 1 FROM TRN_Log_Table), B.Int_1) FROM TRN_Log_Table AS B;


INSERT INTO TRN_Log_Table  (PK_ID, Int_1) SELECT (SELECT MAX(B.PK_ID) + 1 FROM TRN_Log_Table AS B), A.Int_1 FROM TRN_Log_Table AS A;


-- UPDATES ( NO NOTES )


TRUNCATE TABLE TRN_Log_Table


---

SELECT IDENT_CURRENT('TRN_Cramer_Picks_DS')
SELECT SCOPE_IDENTITY('TRN_Cramer_Picks_DS.PK_ID')





