/*
BELL_UPD_ITEMS_SEQUENCE_JSON
'[{"ID":0,"ItemCode":"256","ItemName":"BLUE ECLAIR 1RS","MRP":"200.00","PRate":"0.00","Rate":"115.00","Rate1":"115.00","Rate2":"115.00","Qty":"","Amount":null,"ImageUrl":null,"Description":"2 Carton","TOTALITEMSINPACK":"16","TOTALITEMSINCARTON":null,"CATEGORY":"ECLAIRS","Manufacture":"Trade","PACKINGTYPE":"Carton","STOCK":0,"Cartons":0,"Packets":0,"USERNAME":null,"MinOrderAlert":2,"ActionDate":null,"TOTAL_PACKS":0,"RETURN_PACKS":0,"DAMAGE_PACKS":0,"LINE":null,"ITEM_SEQ":2013},
{"ID":0,"ItemCode":"255","ItemName":"CRUNCHY ECLAIR 1RS","MRP":"200.00","PRate":"0.00","Rate":"115.00","Rate1":"115.00","Rate2":"115.00","Qty":"","Amount":null,"ImageUrl":null,"Description":"2 Carton","TOTALITEMSINPACK":"16","TOTALITEMSINCARTON":null,"CATEGORY":"ECLAIRS","Manufacture":"Trade","PACKINGTYPE":"Carton","STOCK":0,"Cartons":0,"Packets":0,"USERNAME":null,"MinOrderAlert":2,"ActionDate":null,"TOTAL_PACKS":0,"RETURN_PACKS":0,"DAMAGE_PACKS":0,"LINE":null,"ITEM_SEQ":2014}]'
,'UPDATE_SEQ'

*/
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

    if @OPTION = 'UPSERT_DAMAGES'
    BEGIN
        ;WITH JsonData AS (  
                SELECT   
                    LINE,  
                    ItemCode,  
                    ItemName,  
                    Qty                     
                FROM OPENJSON(@JsonData)  
                WITH (  
                    LINE  VARCHAR(100),  
                    ITEMCODE   INT,  
                    ITEMNAME  VARCHAR(100),  
                    QTY INT
                )  
            )  
            MERGE BAZAR_DAMAGE_ITEMS AS target  
             USING JsonData AS source  
               ON target.LINE = source.LINE  
               AND CAST(target.REQUESTED_DATE AS DATE) = CAST(GETDATE() as Date)
              AND target.ITEMNAME = source.ItemName  
            WHEN MATCHED THEN  
                UPDATE SET   
                    target.DAM_PAK = source.Qty,STATUS='SUBMITTED',target.USERNAME='Mobile App',target.ACTIONDATE = GETDATE()  
            WHEN NOT MATCHED THEN  
            INSERT (ITEMCODE,ITEMNAME,DAM_PAK,REQUESTED_DATE,LINE,USERNAME,[STATUS])   
           VALUES(source.ItemCode,source.ItemName,source.Qty,GETDATE(),source.LINE,'Mobile App','SUBMITTED');  
      END  
    ELSE   -- @OPTION=UPDATE_SEQ
    BEGIN
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
    END  
    SELECT 1 AS RESULT;  
END  