/*
--ALTER TABLE Bell_LS_ORDERS ALTER COLUMN WEBSYNCED VARCHAR(15)
ALTER TABLE Bell_LS ALTER COLUMN STATUS VARCHAR(30)

select * from Bell_LS where area='kothaguda' and billdate='2026-Mar-30'
select * from Bell_LS where USERNAME='From_Mobile'
--UPDATE Bell_LS SET R_B=0 where area='kothaguda' and billdate='2026-Mar-30'

SELECT ISJSON('{"test":1}') AS IsJsonSupported;
SELECT * 
FROM OPENJSON('[{"BillDate":"2026-03-30","AREA":"kothaguda","ITEMCODE":1,"ITEMNAME":"khara 5 RS","RET_PAK":5,"DAM_PAK":0,"USERNAME":"From_Mobile","SALESMAN":"TEJASWINI"}]')
WITH (
    BillDate DATE,
    AREA VARCHAR(30),
    ITEMCODE INT,
    ITEMNAME VARCHAR(30),
    RET_PAK INT,
    DAM_PAK INT,
    USERNAME VARCHAR(30),
    SALESMAN VARCHAR(30)
);

SELECT REPLACE('CHECK','E','e')

BELL_UPDATE_LS_RETURN_ITEMS_MOBILE_JSON '[{"BillDate":"2026-03-30","AREA":"kothaguda","ITEMCODE":1,"ITEMNAME":"khara 5 RS","RET_PAK":5,"DAM_PAK":0,"USERNAME":"From_Mobile","SALESMAN":"TEJASWINI"}]'

BELL_UPDATE_LS_RETURN_ITEMS_MOBILE_JSON '[{"ITEMCODE":1,"ITEMNAME":"khara 5 RS","AVAILABLE_PAKS":156,"LINE":"KOTHAGUDA","SALESMAN":"GOPAL.P","BillDate":"2026-03-30"},
{"ITEMCODE":2,"ITEMNAME":"moong dal 5 RS","AVAILABLE_PAKS":264,"LINE":"KOTHAGUDA","SALESMAN":"GOPAL.P","BillDate":"2026-03-30"},
{"ITEMCODE":5,"ITEMNAME":"ABCD 5 RS","AVAILABLE_PAKS":48,"LINE":"KOTHAGUDA","SALESMAN":"GOPAL.P","BillDate":"2026-03-30"},
{"ITEMCODE":6,"ITEMNAME":"Animal 5 RS","AVAILABLE_PAKS":48,"LINE":"KOTHAGUDA","SALESMAN":"GOPAL.P","BillDate":"2026-03-30"},
{"ITEMCODE":7,"ITEMNAME":"Sticks 5 RS","AVAILABLE_PAKS":36,"LINE":"KOTHAGUDA","SALESMAN":"GOPAL.P","BillDate":"2026-03-30"},
{"ITEMCODE":8,"ITEMNAME":"WHEELS 5 RS","AVAILABLE_PAKS":48,"LINE":"KOTHAGUDA","SALESMAN":"GOPAL.P","BillDate":"2026-03-30"},
{"ITEMCODE":9,"ITEMNAME":"Soya sticks 5 RS","AVAILABLE_PAKS":84,"LINE":"KOTHAGUDA","SALESMAN":"GOPAL.P","BillDate":"2026-03-30"}]'

*/
ALTER PROCEDURE BELL_UPDATE_LS_RETURN_ITEMS_MOBILE_JSON
    @JsonData NVARCHAR(MAX),
    @OPERATION VARCHAR(30),
    @LINE VARCHAR(50),
    @ORDERDATE DATE
AS
BEGIN
    SET NOCOUNT ON;

    SET @JsonData = REPLACE(@JsonData,'\','')
    IF @OPERATION = 'LS'
    BEGIN
            -- Parse JSON into a table variable
            ;WITH Parsed AS (
                SELECT 
                    BillDate,
                    LINE,
                    ITEMCODE,
                    ITEMNAME,
                    AVAILABLE_PAKS,
                    DAM_PAK,
                    'From_Mobile' as USERNAME,
                    SALESMAN
                FROM OPENJSON(@JsonData)
                WITH (
                    BillDate   DATE,
                    LINE       VARCHAR(30),
                    ITEMCODE   INT,
                    ITEMNAME   VARCHAR(30),
                    AVAILABLE_PAKS    INT,
                    DAM_PAK    INT,
                    USERNAME   VARCHAR(30),
                    SALESMAN   VARCHAR(30)
                )
            )
            UPDATE Bell_LS
            SET USERNAME = p.USERNAME,
                [STATUS] = p.SALESMAN,
                R_B = p.AVAILABLE_PAKS,
                ACTIONDATE = GETDATE()
            FROM Bell_LS b
            INNER JOIN Parsed p
                ON b.ITEMCODE = p.ITEMCODE
               AND b.ITEMNAME = p.ITEMNAME
               AND b.AREA = p.LINE
               AND b.BILLDATE = p.BillDate;
        END
        ELSE IF @OPERATION = 'ORDERS'
        BEGIN        
            --** USING WEBSYNCED TO MAKE SURE IT IS INSERTED FROM MOBILE APP.  OTHERWISE IT WILL DELETE OTHER RECORDS.
            ;WITH JsonData AS (
                SELECT 
                    BillDate,
                    LINE,
                    ITEMCODE,
                    ITEMNAME,
                    RATE,
                    PACKING_QTY,
                    QTY,
                    'ORDERS' as USERNAME,
                    SALESMAN
                FROM OPENJSON(@JsonData)
                WITH (
                    BillDate  DATE,
                    LINE  VARCHAR(30),
                    ITEMCODE  INT,
                    ITEMNAME VARCHAR(30),
                    RATE VARCHAR(20),
                    PACKING_QTY  VARCHAR(20),
                    QTY  INT,
                    USERNAME  VARCHAR(30),
                    SALESMAN  VARCHAR(30)
                )
            )
            --INSERT INTO  Bell_LS_ORDERS (ITEMCODE,ITEMNAME,RATE,QTY,BILLDATE,AREA,USERNAME,T_B,WEBSYNCED) 
           --SELECT J.ITEMCODE,J.ITEMNAME,J.RATE,J.AVAILABLE_PAKS,J.BILLDATE,J.LINE,J.USERNAME,J.QTY,'From_Mobile' FROM JsonData J
           MERGE BELL_LS_ORDERS AS target
            USING JsonData AS source
               ON target.AREA = source.LINE
               AND target.BillDate = source.BillDate 
               AND target.ITEMNAME = source.ITEMNAME
               AND target.ITEMCODE = source.ITEMCODE
            WHEN MATCHED THEN
                UPDATE SET 
                    target.T_B = source.QTY, target.QTY=source.PACKING_QTY,WEBSYNCED='PENDING',
                    target.USERNAME=source.USERNAME,target.ACTIONDATE = GETDATE()
            WHEN NOT MATCHED AND source.QTY > 0 THEN
            INSERT (ITEMCODE,ITEMNAME,RATE,QTY,BILLDATE,AREA,USERNAME,T_B,WEBSYNCED) 
           VALUES(source.ITEMCODE,source.ITEMNAME,source.RATE,source.PACKING_QTY,source.BILLDATE,source.LINE,
           source.USERNAME,source.QTY,'PENDING');
        END

        ELSE IF @OPERATION = 'ORDERS APPROVED'  -- after Approval from VAN Loading Approver, it should also insert into LS table
        BEGIN        
            --** USING WEBSYNCED TO STORE STATUS AS PENDING/APPROVED...
            ;WITH JsonData AS (
                SELECT 
                BillDate,LINE,ITEMCODE,ITEMNAME,RATE,PACKING_QTY,QTY,'ORDERS' as USERNAME,SALESMAN
                FROM OPENJSON(@JsonData) WITH ( BillDate  DATE,LINE  VARCHAR(30),ITEMCODE  INT,ITEMNAME VARCHAR(30),
                    RATE VARCHAR(20),PACKING_QTY  VARCHAR(20),QTY  INT,USERNAME  VARCHAR(30),SALESMAN  VARCHAR(30)  )
                )
            --INSERT INTO  Bell_LS_ORDERS (ITEMCODE,ITEMNAME,RATE,QTY,BILLDATE,AREA,USERNAME,T_B,WEBSYNCED) 
           --SELECT J.ITEMCODE,J.ITEMNAME,J.RATE,J.AVAILABLE_PAKS,J.BILLDATE,J.LINE,J.USERNAME,J.QTY,'From_Mobile' FROM JsonData J
           MERGE BELL_LS_ORDERS AS target
            USING JsonData AS source
               ON target.AREA = source.LINE AND target.BillDate = source.BillDate AND target.ITEMNAME = source.ITEMNAME
               AND target.ITEMCODE = source.ITEMCODE 
               WHEN MATCHED THEN
                UPDATE SET 
                    target.T_B = source.QTY, target.QTY=source.PACKING_QTY,target.USERNAME=source.USERNAME,
                    WEBSYNCED='APPROVED',target.ACTIONDATE = GETDATE()
            WHEN NOT MATCHED AND source.QTY > 0 THEN
            INSERT (ITEMCODE,ITEMNAME,RATE,QTY,BILLDATE,AREA,USERNAME,T_B,WEBSYNCED) 
           VALUES(source.ITEMCODE,source.ITEMNAME,source.RATE,source.PACKING_QTY,source.BILLDATE,source.LINE,
           source.USERNAME,source.QTY,'APPROVED');

           -- TO INSERT/UPDATE INTO BELL_LS TABLE
           ;WITH JsonData AS (
                SELECT 
                BillDate,LINE,ITEMCODE,ITEMNAME,RATE,PACKING_QTY,QTY, USERNAME,SALESMAN
                FROM OPENJSON(@JsonData) WITH ( BillDate  DATE,LINE  VARCHAR(30),ITEMCODE  INT,ITEMNAME VARCHAR(30),
                    RATE VARCHAR(20),PACKING_QTY  VARCHAR(20),QTY  INT,USERNAME  VARCHAR(30),SALESMAN  VARCHAR(30)  )
                )
            --INSERT INTO  Bell_LS_ORDERS (ITEMCODE,ITEMNAME,RATE,QTY,BILLDATE,AREA,USERNAME,T_B,WEBSYNCED) 
           --SELECT J.ITEMCODE,J.ITEMNAME,J.RATE,J.AVAILABLE_PAKS,J.BILLDATE,J.LINE,J.USERNAME,J.QTY,'From_Mobile' FROM JsonData J
           MERGE BELL_LS AS target
            USING JsonData AS source
               ON target.AREA = source.LINE 
               AND target.BillDate = source.BillDate 
               AND target.ITEMNAME = source.ITEMNAME
               AND target.ITEMCODE = source.ITEMCODE 
               WHEN MATCHED THEN
                UPDATE SET 
                    target.T_B = source.QTY, target.QTY=source.PACKING_QTY,target.USERNAME=source.USERNAME,target.STATUS='From_Mobile'
                    ,target.ACTIONDATE = GETDATE()
                    WHEN NOT MATCHED AND source.QTY > 0 THEN
               INSERT (ITEMCODE,ITEMNAME,RATE,QTY,BILLDATE,AREA,USERNAME,T_B,STATUS) 
                   VALUES(source.ITEMCODE,source.ITEMNAME,source.RATE,source.PACKING_QTY,source.BILLDATE,source.LINE,
                   source.USERNAME,source.QTY,'From_Mobile');

        END
    SELECT 1 AS RESULT;
END

GO

--ALTER procedure BELL_UPDATE_LS_RETURN_ITEMS_MOBILE_NEW
--@BILLDATE as DATE,        
--@AREA as varchar(30),        
--@ITEMCODE AS integer,        
--@ITEMNAME AS VARCHAR(30),        
----@QTY AS VARCHAR(15),        
--@RET_PAK AS INTeger,        
--@DAM_PAK AS integer,        
--@USERNAME AS VARCHAR(30),        
--@SALESMAN AS VARCHAR(30)
--AS                     
--BEGIN        
-- set @BILLDATE = CONVERT(varchar(10),@BILLDATE,101)        
 
-- print 'Updating Return items for line=' + @AREA + ' BillDate=' + Cast(@BILLDATE AS VARCHAR(20))

-- UPDATE Bell_LS SET USERNAME=@USERNAME,[STATUS]=@SALESMAN,R_B=@RET_PAK,
-- ACTIONDATE=GETDATE() WHERE ITEMCODE=@ITEMCODE AND ITEMNAME=@ITEMNAME AND 
-- AREA=@AREA AND BILLDATE = @BILLDATE
 
-- /*-- UPDATE STOCK WITH RETURN ITEMS 
-- UPDATE BELL_ITEMMASTER SET STOCK=STOCK + @RET_PAK, USERNAME=@USERNAME,ACTIONDATE=GETDATE() 
--    WHERE ITEMCODE=@ITEMCODE AND ITEMNAME=@ITEMNAME      
--   */     
--   SELECT 1 AS RESULT            
--END 