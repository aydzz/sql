
SELECT  TOP(100) * FROM TRN_Cramer_Picks_DS A INNER JOIN TRN_Cramer_Picks_DS AS B ON A.ID = B.ID WHERE B.[Call] =  'Buy';
GO

BEGIN
    DECLARE @sample INT; -- default to NULL
    SELECT @sample = PK_ID FROM TRN_Cramer_Picks_DS WHERE PK_ID =  200 AND Ticker IS NOT NULL;
    SELECT  @sample AS Val;
END