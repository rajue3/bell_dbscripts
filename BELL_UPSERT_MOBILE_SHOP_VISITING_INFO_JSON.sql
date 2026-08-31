/*
SELECT CONVERT(VARCHAR(10), GETDATE(), 23) AS FormattedDate;
source.SHOPNAME+'-'+CONVERT(VARCHAR(10), source.ORDERDATE, 23)+'.jpg'
--working with json data both Insert and Update working 06-Apr-26  
*/
ALTER procedure BELL_UPSERT_MOBILE_SHOP_VISITING_INFO_JSON  
    @JsonData NVARCHAR(MAX)  
AS                           
BEGIN              
SET @JsonData = REPLACE(@JsonData,'\','')  
  print '@JSONDATA=' + @JsonData  
  
    ;WITH JSON_DATA AS (  
        SELECT   
            LINE,  
            AREA,  
            SHOPNAME,  
            SHOP_VISIT_STATUS,  
            SALESMAN,  
            ORDERDATE,  
            BILLING_START_DATE,  
            BILLING_END_DATE,
            SHOP_PHOTO_PATH
        FROM OPENJSON(@JsonData)  
        WITH (  
            LINE  VARCHAR(50),  
            AREA VARCHAR(50),  
            SHOPNAME  VARCHAR(100),  
            SHOP_VISIT_STATUS  VARCHAR(30),  
            SALESMAN   VARCHAR(30),  
            ORDERDATE   DATETIME2,  
            BILLING_START_DATE DATETIME2,  
            BILLING_END_DATE DATETIME2,
            SHOP_PHOTO_PATH VARCHAR(100)
        )  
    )  
MERGE BELL_APP_SHOPS_VISIT_INFO AS target  
    USING JSON_DATA AS source  
        ON target.LINE = source.LINE  
       AND target.AREA = source.AREA  
       AND target.SHOPNAME     = source.SHOPNAME  
       AND target.SALESMAN     = source.SALESMAN  
       AND target.ORDERDATE = source.ORDERDATE   
    WHEN MATCHED THEN  
        UPDATE SET   
            target.SHOP_VISIT_STATUS   = source.SHOP_VISIT_STATUS,target.BILLING_START_DATE=source.BILLING_START_DATE,  
            target.BILLING_END_DATE=source.BILLING_END_DATE, target.ACTIONDATE = GETDATE()
            ,SHOP_VISIT_PHOTO_NAME=ISNULL(REPLACE(SHOP_PHOTO_PATH,'bell_images/',''),'')
            --target.BILLING_START_DATE=IIF(source.BILLING_START_DATE LIKE '0001-01-01%', GETDATE(),source.BILLING_START_DATE),  
            --target.BILLING_END_DATE=IIF(source.BILLING_END_DATE LIKE '0001-01-01%', GETDATE(),source.BILLING_END_DATE),  
    WHEN NOT MATCHED THEN  
        INSERT (LINE,AREA,SHOPNAME,SHOP_VISIT_STATUS,SALESMAN,ORDERDATE, ACTIONDATE,BILLING_START_DATE,BILLING_END_DATE,SHOP_VISIT_PHOTO_NAME)  
        VALUES (source.LINE, source.AREA, source.SHOPNAME, source.SHOP_VISIT_STATUS,source.SALESMAN  
        ,source.ORDERDATE, GETDATE(),source.BILLING_START_DATE,source.BILLING_END_DATE,ISNULL(REPLACE(SHOP_PHOTO_PATH,'bell_images/',''),''));  
  
        -- BELOW CODE IS WORKING BUT NOT USING HERE.  
        --IIF(source.BILLING_START_DATE LIKE '0001-01-01%', GETDATE(),source.BILLING_START_DATE),  
       --IIF(source.BILLING_END_DATE LIKE '0001-01-01%', GETDATE(),source.BILLING_END_DATE));  
  
   SELECT 1 AS RESULT              
END   