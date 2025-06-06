USE [zionwellmark_onlineorders]
GO

Update Bell_Cust_Master set USERNAME='RAJU', LINE='BAZAR',AREA='BAZAR', CUSTOMERNAME='TEST',SHOPNAME='AYYAPPAK/M',MOBILE='7386391384',SALESMAN='',STATUS='Active',ACTIONDATE='2025-Feb-15' 

SELECT * FROM Bell_Cust_Master Where LINE='BAZAR' AND AREA='BAZAR' AND SHOPNAME='AYYAPPAK/M'  
SELECT * FROM Bell_Cust_Master Where LINE='BAZAR' AND AREA='BAZAR' AND SHOPNAME LIKE 'TEST%'  

SELECT LINE,AREA,SHOPNAME FROM Bell_Cust_Master WHERE LINE='KOUTALA' ORDER BY SHOPNAME
--AND SHOPNAME LIKE '%NIT%'

 select AREA,AREA_LINE,SHOPNAME,USERNAME,ACTIONDATE from bhavani_ER_Bills  ORDER BY ACTIONDATE DESC
 AND AREA='KOUTALA' ORDER BY SHOPNAME

select DISTINCT AREA_LINE  from bhavani_ER_Bills  -- 445
select DISTINCT AREA  from bhavani_ER_Bills  -- 445 

SELECT AREA FROM Bell_Cust_Master WHERE LINE=A.AREA_LINE AND SHOPNAME=A.SHOPNAME 

--update bhavani_ER_Bills  set AREA_LINE =''

select * from Bell_ItemMaster where itemname like '%SEV MURMURA 5 RS%'

select * from Bell_ItemMaster where itemcode=0
select * from bhavani_ER_Bills where itemcode=0

select * from bhavani_ER_Bills where username='TEJASWINI' AND ACTIONDATE > '2025-01-15'
select * from bhavani_ER_Bills where AREA_LINE is null order by actiondate desc
select * from Bell_Cust_Master order by actiondate desc

-- update bhavani_ER_Bills  set PRATE=RATE-RATE*0.05 WHERE ISNULL(PRATE,0)=0
-- update bhavani_ER_Bills  set PRATE=RATE-RATE*0.10 WHERE itemcode < 5

	SELECT NULL, ITEMNAME,ITEMCODE ,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT ,	 
	 (CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) - CAST(ISNULL(SUM(PRATE * PACKETS)/100.0,0) AS DECIMAL(12,2))) PROFIT_AMOUNT
	-- CAST((CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) - CAST(ISNULL(SUM(PRATE * PACKETS)/100.0,0) AS DECIMAL(12,2)))/CAST(ISNULL(SUM(PRATE * A.PACKETS)/100.0,0) AS DECIMAL(12,2)) AS DECIMAL(12,2 ) ) * 100 AS Profit_Percent 	 
	,sum(PRATE),sum(PACKETS)
	 FROM bhavani_ER_Bills A   WHERE 	 
	 --AREA=(case lower(@AREA) when 'all' then AREA ELSE @AREA END) and SHOPNAME = (case lower(@SHOP) when 'all' then SHOPNAME ELSE @SHOP END)      
	--and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))   	
	 A.AREA = (case lower('all') when 'all' then A.AREA ELSE 'all' END)     
	and (BILLDATE BETWEEN CONVERT(nvarchar(10),CAST('2025-01-01' AS DATE),101) AND CONVERT(nvarchar(10),CAST('2025-01-15' AS DATE),101))      
	GROUP BY ITEMCODE,ITEMNAME ORDER BY ITEMCODE

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--SELECT CAST(9900/100.0 AS DECIMAL(12,2))
--SELECT CAST(20669/100.00 AS DECIMAL(10,2))
--SELECT FORMAT(2.3382232,'N2')

-- USP_SHOP_WISE_SALES_COUNT_BY_BILLDATE_26JAN25  'ITEMWISE','all','all','all','2025-01-01','2025-01-30'
-- USP_SHOP_WISE_SALES_COUNT_BY_BILLDATE_26JAN25  'ITEMWISE','BHADRACHALAM','all','all','2025-01-15','2025-01-30'
-- USP_SHOP_WISE_SALES_COUNT_BY_BILLDATE_26JAN25  'ITEMWISE','BHADRACHALAM','ASHWAPUR','all','2025-01-15','2025-01-30'

-- USP_SHOP_WISE_SALES_COUNT_BY_BILLDATE 'ITEMWISE','BAYYARAM','all','2024-11-01','2024-11-30'
-- USP_SHOP_WISE_SALES_COUNT_BY_BILLDATE 'ITEMWISE','ALL','all','2024-11-01','2024-11-30'
-- USP_SHOP_WISE_SALES_COUNT_BY_BILLDATE 'ITEMWISE','BELLAMPALLY','all','2024-10-10','2024-11-10'
-- USP_SHOP_WISE_SALES_COUNT_BY_BILLDATE 'SHOPWISE','BELLAMPALLY','all','2024-10-04','2024-11-05'
-- USP_SHOP_WISE_SALES_COUNT_BY_BILLDATE 'ITEMWISE','BAYYARAM','all','2024-10-01','2024-11-30'      
-- USP_SHOP_WISE_SALES_COUNT_BY_BILLDATE 'ITEMWISE','BAYYARAM','all','2024-10-01','2024-11-30'      
ALTER PROCEDURE USP_SHOP_WISE_SALES_COUNT_BY_BILLDATE_26JAN25  
@HEADER AS NVARCHAR(20),      
@AREA AS NVARCHAR(60),      --  Line
@AREA_LINE AS NVARCHAR(60),      --  AREA
@SHOP AS NVARCHAR(100),   -- Area   
@BILLDATE1 AS DATE,      
@BILLDATE2 AS DATE      
AS      
BEGIN      
      
--DECLARE @Bell_TEMP_REPORT AS TABLE(BILLDATE VARCHAR(20), NAME VARCHAR(50),QTY INT)      
DECLARE @cols AS NVARCHAR(MAX), @query  AS NVARCHAR(MAX)      
      
--DECLARE @TEMP_REPORT AS TABLE(BILLDATE VARCHAR(20), NAME VARCHAR(100),QTY INT)      
--DELETE FROM Bell_TEMP_REPORT      
DELETE FROM Bell_REPORT_HEADER      
delete from Bell_REPORT_HEADER_BILLDATE    
      
IF @HEADER = 'SHOPWISE'      
BEGIN      
 CREATE TABLE dbo.#TEMP_REPORT (BILLDATE VARCHAR(20), NAME VARCHAR(100),QTY DECIMAL(12,2))      
       
  Insert into #TEMP_REPORT      
  select FORMAT(BILLDATE, 'dd-MMM-yy') as BILLDATE,SHOPNAME      
  --,ISNULL(SUM(AMOUNT),0) AMOUNT       
  ,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT      
  from bhavani_ER_Bills      
  WHERE AREA=@AREA 
  AND SHOPNAME = (case lower(@SHOP) when 'all' then SHOPNAME ELSE @SHOP END)      
  AND AREA_LINE = (case lower(@AREA_LINE) when 'all' then AREA_LINE ELSE @AREA_LINE END)      
  and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))      
  GROUP BY BILLDATE,SHOPNAME,AREA order by SHOPNAME      
      
   --Select * from #TEMP_REPORT --order by shopname desc      
 INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT BILLDATE FROM #TEMP_REPORT   --(STORING BILLDATE INTO SHOPNAME COL)      
      
 select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']'      
       from Bell_REPORT_HEADER group by HEADER_NAME FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')      
      
 set @query = 'SELECT * from (select * from #TEMP_REPORT '        
    +' ) x pivot (AVG(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') )  p'      
  PRINT @query      
  exec sp_executesql @query;      
END      
IF @HEADER = 'SHOPWISEWITHBILL'      
BEGIN      
 CREATE TABLE dbo.#TEMP_REPORT1 (BILLDATE VARCHAR(20), NAME VARCHAR(100),QTY DECIMAL(12,2))      
      
  Insert into #TEMP_REPORT1      
  select FORMAT(BILLDATE, 'dd-MMM-yy') as BILLDATE      
  ,(convert(nvarchar(5),BILLNUMBER) + ' - ' + SHOPNAME) as SHOPNAME      
  --,ISNULL(SUM(AMOUNT),0) AMOUNT       
  ,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT      
  from bhavani_ER_Bills WHERE AREA=@AREA 
  and SHOPNAME = (case lower(@SHOP) when 'all' then SHOPNAME ELSE @SHOP END)      
  AND AREA_LINE = (case lower(@AREA_LINE) when 'all' then AREA_LINE ELSE @AREA_LINE END)      
  and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))        
  GROUP BY BILLDATE,BILLNUMBER,SHOPNAME,AREA order by convert(int,BILLNUMBER)      
      
   --Select * from #TEMP_REPORT1 --order by shopname desc      
 INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT BILLDATE FROM #TEMP_REPORT1   --(STORING BILLDATE INTO SHOPNAME COL)      
      
 select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']'      
       from Bell_REPORT_HEADER group by HEADER_NAME FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')      
      
 set @query = 'SELECT * from (select * from #TEMP_REPORT1'        
    +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) p'      
      
  PRINT @query      
  exec sp_executesql @query;      
END      
IF @HEADER = 'SHOPWISEWITHOUTBILL'      
BEGIN      
 CREATE TABLE dbo.#TEMP_SHOPWISEWITHOUTBILL (BILLDATE VARCHAR(20), NAME VARCHAR(100),QTY DECIMAL(12,2))      
 
 IF Lower(@AREA_LINE) = 'all'
  BEGIN
  Insert into #TEMP_SHOPWISEWITHOUTBILL      
  select FORMAT(BILLDATE, 'dd-MMM-yy') as BILLDATE,SHOPNAME   ,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT      
  from bhavani_ER_Bills   WHERE AREA=@AREA 
  and SHOPNAME = (case lower(@SHOP) when 'all' then SHOPNAME ELSE @SHOP END)        
  and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))      
  GROUP BY BILLDATE,SHOPNAME,AREA order by SHOPNAME       
 END
 ELSE
 BEGIN
		Insert into #TEMP_SHOPWISEWITHOUTBILL      
	  select FORMAT(BILLDATE, 'dd-MMM-yy') as BILLDATE,SHOPNAME   ,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT      
	  from bhavani_ER_Bills   WHERE AREA=@AREA 
	  and SHOPNAME = (case lower(@SHOP) when 'all' then SHOPNAME ELSE @SHOP END)      
	  AND AREA_LINE = (case lower(@AREA_LINE) when 'all' then AREA_LINE ELSE @AREA_LINE END)      
	  and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))      
	  GROUP BY BILLDATE,SHOPNAME,AREA order by SHOPNAME       
  END
   --Select * from #TEMP_SHOPWISEWITHOUTBILL --order by shopname desc      
 INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT BILLDATE FROM #TEMP_SHOPWISEWITHOUTBILL   --(STORING BILLDATE INTO SHOPNAME COL)      
      
 select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']'      
       from Bell_REPORT_HEADER group by HEADER_NAME FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')      
      
 set @query = 'SELECT * from (select * from #TEMP_SHOPWISEWITHOUTBILL'        
    +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) p'      
      
  PRINT @query      
  exec sp_executesql @query;      
END      
      
IF @HEADER = 'ITEMWISE'      
BEGIN      
  CREATE TABLE dbo.#TEMP_REPORT_ITEMWISE (BILLDATE VARCHAR(20), NAME VARCHAR(100),ITEMCODE INT,QTY decimal(12,2),PROFIT_AMT decimal(12,2),PROFIT_PERCENT decimal(12,2))      
  CREATE TABLE dbo.#TEMP_REPORT2 (BILLDATE VARCHAR(20), NAME VARCHAR(100),ITEMCODE INT,QTY INT)      
  CREATE TABLE dbo.#TEMP_REPORT3 (BILLDATE VARCHAR(20), NAME VARCHAR(100),ITEMCODE INT,QTY INT)      
      
  --IF OBJECT_ID (N'TEMP_DYNAMIC_REPORT2', N'U') IS NOT NULL      
  --BEGIN      
  --  DROP TABLE TEMP_DYNAMIC_REPORT2      
  --  DROP TABLE TEMP_DYNAMIC_REPORT3      
  --END      
  --DECLARE @datecol datetime = GETDATE();      
  --DECLARE @WeekNum INT, @YearNum char(4);            
  --SELECT @WeekNum = DATEPART(WK, @datecol), @YearNum = CAST(DATEPART(YY, @datecol) AS CHAR(4));      
  
  --* TODO: to avoid Divide by zero error, this is due to PRATE is zero, hence update to some default value.
  -- select * from bhavani_ER_Bills where ISNULL(PRATE,0)=0
  update bhavani_ER_Bills  set PRATE=RATE-RATE*0.05 WHERE ISNULL(PRATE,0)=0
  
  --FORMAT(BILLDATE, 'dd-MMM-yy') as BILLDATE,      
  IF Lower(@AREA_LINE) = 'all'
  BEGIN
		Insert into #TEMP_REPORT_ITEMWISE      
	  select CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk, 6, '1/1/' + CAST(DATEPART(YY, BILLDATE) AS CHAR(4))) + (DatePart(week, BILLDATE)-1), 6),6) AS StartOfWeek,      
	  --select FORMAT(DATEADD(wk, DATEDIFF(wk, 6, '1/1/' + CAST(DATEPART(YY, BILLDATE) AS CHAR(4))) + (DatePart(week, BILLDATE)-1), 6),'dd-MMM-yy') AS StartOfWeek,	 
	  ITEMNAME,ISNULL(ITEMCODE,0), CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT 
	  ,0 AS PROFIT_AMOUNT,0 AS PROFIT_PERCENT   from bhavani_ER_Bills      
	  WHERE AREA=(case lower(@AREA) when 'all' then AREA ELSE @AREA END) 
	  AND SHOPNAME = (case lower(@SHOP) when 'all' then SHOPNAME ELSE @SHOP END)      	  
	  and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))      
	  GROUP BY BILLDATE,ITEMNAME,AREA,ITEMCODE order by ITEMCODE      
  END
  ELSE
  BEGIN
	  Insert into #TEMP_REPORT_ITEMWISE      
	  select CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk, 6, '1/1/' + CAST(DATEPART(YY, BILLDATE) AS CHAR(4))) + (DatePart(week, BILLDATE)-1), 6),6) AS StartOfWeek,      
	  --select FORMAT(DATEADD(wk, DATEDIFF(wk, 6, '1/1/' + CAST(DATEPART(YY, BILLDATE) AS CHAR(4))) + (DatePart(week, BILLDATE)-1), 6),'dd-MMM-yy') AS StartOfWeek,	 
	  ITEMNAME,ISNULL(ITEMCODE,0), CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT 
	  ,0 AS PROFIT_AMOUNT,0 AS PROFIT_PERCENT   from bhavani_ER_Bills      
	  WHERE AREA=(case lower(@AREA) when 'all' then AREA ELSE @AREA END) 
	  AND SHOPNAME = (case lower(@SHOP) when 'all' then SHOPNAME ELSE @SHOP END)      
	  AND AREA_LINE = (case lower(@AREA_LINE) when 'all' then AREA_LINE ELSE @AREA_LINE END)      
	  and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))      
	  GROUP BY BILLDATE,ITEMNAME,AREA,ITEMCODE order by ITEMCODE      
 END    
  --SELECT * FROM #TEMP_REPORT_ITEMWISE order by BILLDATE ASC    
      
  set @query = N' INSERT INTO Bell_REPORT_HEADER_BILLDATE SELECT DISTINCT CONVERT(varchar,BILLDATE,6) AS BILLDATE FROM #TEMP_REPORT_ITEMWISE '       
  PRINT @query    
  EXEC sp_executesql @query          
    
  --SELECT DISTINCT CONVERT(varchar,HEADER_NAME,6) as HEADER_NAME FROM Bell_REPORT_HEADER_BILLDATE order by HEADER_NAME ASC    
      
  select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(CONVERT(varchar,HEADER_NAME,6)) + ']'          
     from Bell_REPORT_HEADER_BILLDATE group by HEADER_NAME order by HEADER_NAME ASC FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')      
      
  PRINT @cols      
      
 --INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT BILLDATE FROM #TEMP_REPORT_ITEMWISE      
 --select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']'      
 --from Bell_REPORT_HEADER group by HEADER_NAME FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')          
      
 set @query = 'SELECT * INTO TEMP_DYNAMIC_REPORT2 from (select * from #TEMP_REPORT_ITEMWISE '        
            +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv1 '      
      
   PRINT @query      
   exec sp_executesql @query;      
      
  --select * from Bell_REPORT_HEADER      
  --select * from TEMP_DYNAMIC_REPORT2      
      
  delete from #TEMP_REPORT_ITEMWISE      
  --CREATE TABLE dbo.#TEMP_REPORT_ITEMWISE2 (BILLDATE VARCHAR(20),NAME VARCHAR(100),ITEMCODE INT,QTY INT)      
  --Delete from #TEMP_REPORT_ITEMWISE2       
      
  --FORMAT(BILLDATE, 'dd-MMM-yy') as BILLDATE,      
  Insert into #TEMP_REPORT_ITEMWISE      
  select CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk, 6, '1/1/' + CAST(DATEPART(YY, BILLDATE) AS CHAR(4))) + (DatePart(week, BILLDATE)-1), 6),6) AS StartOfWeek,      
  --select FORMAT(DATEADD(wk, DATEDIFF(wk, 6, '1/1/' + CAST(DATEPART(YY, BILLDATE) AS CHAR(4))) + (DatePart(week, BILLDATE)-1), 6),'dd-MMM-yy') AS StartOfWeek,      
  ITEMNAME,ISNULL(ITEMCODE,0),ISNULL(SUM(PACKETS),0) PACKETS   
  ,0 AS PROFIT_AMOUNT,0 AS PROFIT_PERCENT 
  from bhavani_ER_Bills      
  WHERE AREA=(case lower(@AREA) when 'all' then AREA ELSE @AREA END) 
  and SHOPNAME = (case lower(@SHOP) when 'all' then SHOPNAME ELSE @SHOP END)      
  AND AREA_LINE = (case lower(@AREA_LINE) when 'all' then AREA_LINE ELSE @AREA_LINE END)      
  and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))      
  GROUP BY BILLDATE,ITEMNAME,AREA,ITEMCODE order by ITEMCODE      
       
 set @query = 'SELECT * INTO TEMP_DYNAMIC_REPORT3 from (select * from #TEMP_REPORT_ITEMWISE '        
   +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv2 '                  
      
       
PRINT @query      
exec sp_executesql @query;      
    
--select * from TEMP_DYNAMIC_REPORT3      
--SELECT cONVERT(NVARCHAR(10),GETDATE(),101)      
	
	delete from #TEMP_REPORT_ITEMWISE

	Insert into #TEMP_REPORT_ITEMWISE   
	SELECT NULL, ITEMNAME,ITEMCODE ,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2))  Amount,	 
	 (CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) - CAST(ISNULL(SUM(PRATE * PACKETS)/100.0,0) AS DECIMAL(12,2))) PROFIT_AMOUNT,
	 CAST((CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) - CAST(ISNULL(SUM(PRATE * PACKETS)/100.0,0) AS DECIMAL(12,2)))/CAST(ISNULL(SUM(PRATE * A.PACKETS)/100.0,0) AS DECIMAL(12,2)) AS DECIMAL(12,2 ) ) * 100 AS Profit_Percent 	 
	 FROM bhavani_ER_Bills A   WHERE 	 
	 AREA=(case lower(@AREA) when 'all' then AREA ELSE @AREA END) 
	 and SHOPNAME = (case lower(@SHOP) when 'all' then SHOPNAME ELSE @SHOP END)      
	 AND AREA_LINE = (case lower(@AREA_LINE) when 'all' then AREA_LINE ELSE @AREA_LINE END)      
	and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))   	
	-- A.AREA = (case lower('all') when 'all' then A.AREA ELSE 'all' END)     
	--and (BILLDATE BETWEEN CONVERT(nvarchar(10),CAST('2025-01-01' AS DATE),101) AND CONVERT(nvarchar(10),CAST('2025-01-15' AS DATE),101))      
	GROUP BY ITEMCODE,ITEMNAME ORDER BY ITEMCODE
   	 
set @query = 'SELECT A.NAME,C.QTY as Sales_Amt, C.Profit_Amt,C.Profit_Percent,' + REPLACE(REPLACE(@cols,'[[','A.['),']]',']') + ',' + REPLACE(REPLACE(@cols,'[[','B.['),']]','] AS QTY') + ' FROM TEMP_DYNAMIC_REPORT2 A '      
   +' INNER JOIN TEMP_DYNAMIC_REPORT3 B ON A.NAME=B.NAME AND A.ITEMCODE=B.ITEMCODE '
   + ' INNER JOIN #TEMP_REPORT_ITEMWISE C ON C.NAME=A.NAME AND C.ITEMCODE=A.ITEMCODE '
   + ' ORDER BY A.ITEMCODE'      
PRINT @query      
exec sp_executesql @query;      

--select * from TEMP_DYNAMIC_REPORT2 ORDER BY ITEMCODE
--select * from TEMP_DYNAMIC_REPORT3 ORDER BY ITEMCODE
--select * from #TEMP_REPORT_ITEMWISE ORDER BY ITEMCODE


	IF OBJECT_ID (N'TEMP_DYNAMIC_REPORT2', N'U') IS NOT NULL      
	BEGIN      
	  DROP TABLE TEMP_DYNAMIC_REPORT2      
  END      
  IF OBJECT_ID (N'TEMP_DYNAMIC_REPORT3', N'U') IS NOT NULL      
	BEGIN      
	  DROP TABLE TEMP_DYNAMIC_REPORT3      
  END      
  
END      
      
end 