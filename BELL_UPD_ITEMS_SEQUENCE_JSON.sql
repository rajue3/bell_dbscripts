ALTER PROCEDURE BELL_UPD_ITEMS_SEQUENCE_JSON
    @JsonData NVARCHAR(MAX),  
    @OPTION VARCHAR(50)
    --@LINE VARCHAR(50),   -- LINE  
    --@BILLDATE DATETIME2  
AS  
BEGIN  
    SET NOCOUNT ON;    
    -- Remove backslashes only if present (double-encoded JSON)  
    IF @JsonData LIKE '%\\%'  
    BEGIN  
        SET @JsonData = REPLACE(@JsonData,'\','');  
    END  
    -------------------------------------------------------------------  
    -- Build #Source from JSON + ItemMaster  
    -------------------------------------------------------------------  
    IF OBJECT_ID('tempdb..#Source') IS NOT NULL DROP TABLE #Source;  
  
    SELECT   
        j.ItemCode, j.ItemName, j.Rate1,j.Rate2, j.ITEM_SEQ  INTO #Source  FROM (  
        SELECT   
            ItemCode, ItemName, Rate1,Rate2, ITEM_SEQ FROM OPENJSON(@JsonData)  
        WITH (  
            ItemCode INT,  
            ItemName NVARCHAR(100),  
            Rate1 MONEY, 
            Rate2 MONEY, 
            ITEM_SEQ INT
        )  
    ) j  
    LEFT JOIN Bell_ItemMaster im   
        ON j.ITEMCODE = im.ITEMCODE AND j.ItemName = im.ItemName;  
    -------------------------------------------------------------------  
    -- MERGE into bhavani_ER_Bills  
    -------------------------------------------------------------------  
    MERGE Bell_ItemMaster AS target  
    USING #Source AS source  
        ON target.ItemCode = source.ItemCode  
       AND target.ItemName = source.ItemName         
       AND ISNULL(source.Rate1,0) > 0 and ISNULL(source.Rate2,0) >  0
    WHEN MATCHED THEN  
        UPDATE SET               
            target.ITEM_SEQ = source.ITEM_SEQ,  
            target.Rate1 = source.Rate1,  
            target.Rate2 = source.Rate2,  
            target.ActionDate = GETDATE();      
    
SELECT 1 AS RESULT;  
END  