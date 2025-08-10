
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'chartdatabymonth','all','all','all','2024-11-30','2025-08-30'  

-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'chartdata','all','all','all','2025-07-01','2025-08-30'  
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'chartdata','BHADRACHALAM','all','all','2025-07-01','2025-08-30'  
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'chartdata','[BHADRACHALAM]','all','all','2025-07-01','2025-08-30'  

-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'weekwisebyarea','all','all','all','2025-07-01','2025-08-30'  
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE  'weekwisebyarea','[BHADRACHALAM]','all','all','2025-07-01','2025-08-30'  
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE  'weekwisebyarea','BHADRACHALAM,HYDERABAD','all','all','2025-07-01','2025-08-30'  
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'weekwisebyarea','[BHADRACHALAM]','BHERU FANCY (BCM)','[khara 5 RS],[moong dal 5 RS]','2025-05-01','2025-08-30'  
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'weekwisebyarea','[BHADRACHALAM]','all','[khara 5 RS],[moong dal 5 RS]','2025-05-01','2025-08-30'  

-- New report created for Charts on 03-Aug-2025  

ALTER PROCEDURE BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE
@TYPE AS NVARCHAR(20),        
@AREA AS NVARCHAR(60),      --  Line  
@SHOP AS NVARCHAR(50),        
@ITEMNAME AS nVARCHAR(max),      
@BILLDATE1 AS DATE,        
@BILLDATE2 AS DATE        
AS        
BEGIN        
        
--DECLARE @Bell_TEMP_REPORT AS TABLE(BILLDATE VARCHAR(20), NAME VARCHAR(50),QTY INT)        
DECLARE @cols AS NVARCHAR(MAX), @query  AS NVARCHAR(MAX),@query2  AS NVARCHAR(MAX), @queryItemNames AS NVARCHAR(MAX)
        
--DECLARE @TEMP_REPORT AS TABLE(BILLDATE VARCHAR(20), NAME VARCHAR(100),QTY INT)        
--DELETE FROM Bell_TEMP_REPORT        
DELETE FROM Bell_REPORT_HEADER        
delete from Bell_REPORT_HEADER_BILLDATE      
        
IF @TYPE = 'weekwisebyarea'        
BEGIN        
  CREATE TABLE dbo.#TEMP_REPORT_ITEMWISE (BILLDATE VARCHAR(20),ITEMCODE INT, NAME VARCHAR(100),QTY decimal(12,2))        
  CREATE TABLE dbo.#TEMP_REPORT2 (BILLDATE VARCHAR(20), NAME VARCHAR(100),ITEMCODE INT,QTY INT)        
  --CREATE TABLE dbo.#TEMP_REPORT3 (BILLDATE VARCHAR(20), NAME VARCHAR(100),ITEMCODE INT,QTY INT)        
         
  delete from #TEMP_REPORT_ITEMWISE        
  --CREATE TABLE dbo.#TEMP_REPORT_ITEMWISE2 (BILLDATE VARCHAR(20),NAME VARCHAR(100),ITEMCODE INT,QTY INT)        
  --Delete from #TEMP_REPORT_ITEMWISE2                 
  --FORMAT(BILLDATE, 'dd-MMM-yy') as BILLDATE,        

set @queryItemNames = ''
set @query2 = ''
if lower(@ITEMNAME) <> 'all'  
 begin  
   set @queryItemNames = ' AND ITEMNAME in (' + REPLACE(REPLACE(@ITEMNAME,'[',''''),']','''') + N') '  
 end  

  if lower(@AREA) <> 'all'      
  begin      
		IF CHARINDEX('[', @AREA) > 0
				set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '      
		ELSE
			set @query2 = N' AND AREA in (''' + REPLACE(@AREA,',',''',''')  + ''') '    	    
  end      
  
  --select FORMAT(DATEADD(wk, DATEDIFF(wk, 6, '''1/1/''' + CAST(DATEPART(YY, BILLDATE) AS CHAR(4))) + (DatePart(week, BILLDATE)-1), 6),'''dd-MMM-yy''') AS StartOfWeek,        
  -- AREA=(case lower(@AREA) when ''all'' then AREA ELSE @AREA END)   
  --AND AREA_LINE = (case lower(@AREA) when ''all'' then AREA_LINE ELSE @AREA END)        
  --(BILLDATE BETWEEN CONVERT(nvarchar(10),'+@BILLDATE1+',101) AND CONVERT(nvarchar(10),'+@BILLDATE2+',101))  ' + @query2   + @queryItemNames

  set @query = N' Insert into #TEMP_REPORT_ITEMWISE        
  select CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk, 6,''1/1/'' + CAST(DATEPART(YY, BILLDATE) AS CHAR(4))) + (DatePart(week, BILLDATE)-1), 6),6) AS StartOfWeek,        
  ISNULL(ITEMCODE,0),ITEMNAME,ISNULL(SUM(PACKETS),0) PACKETS  from bhavani_ER_Bills        
  WHERE SHOPNAME = (case lower('''+ @SHOP +''') when ''all'' then SHOPNAME ELSE '''+ @SHOP +''' END) 
  and  (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' 
  + @query2   + @queryItemNames
  + ' AND ISNULL(ITEMCODE,0) > 0 GROUP BY BILLDATE,ITEMNAME,AREA,ITEMCODE order by ITEMCODE  ' 

  --SELECT * FROM #TEMP_REPORT_ITEMWISE order by BILLDATE ASC      
  PRINT @query 
  EXEC sp_executesql @query            

  set @query = N' INSERT INTO Bell_REPORT_HEADER_BILLDATE SELECT DISTINCT CONVERT(varchar,BILLDATE,6) AS BILLDATE FROM #TEMP_REPORT_ITEMWISE '         
  --PRINT @query 
  EXEC sp_executesql @query            
      
  --SELECT DISTINCT CONVERT(varchar,HEADER_NAME,6) as HEADER_NAME FROM Bell_REPORT_HEADER_BILLDATE order by HEADER_NAME ASC      
        
  select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(CONVERT(varchar,HEADER_NAME,6)) + ']'            
     from Bell_REPORT_HEADER_BILLDATE group by HEADER_NAME order by HEADER_NAME ASC FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')        
        
  --PRINT @cols      
  --select * from Bell_REPORT_HEADER        
  --select * from TEMP_DYNAMIC_REPORT2        
  
 set @query = 'SELECT * from (select * from #TEMP_REPORT_ITEMWISE  '          
   +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv2 ORDER BY ITEMCODE '
        
PRINT @query        
exec sp_executesql @query;        
      
--select * from TEMP_DYNAMIC_REPORT3  order by ITEMCODE      
--SELECT cONVERT(NVARCHAR(10),GETDATE(),101)        
   
 --delete from #TEMP_REPORT_ITEMWISE  
    
END        
IF @TYPE = 'chartdata'        --- chart data by week.
BEGIN        
  CREATE TABLE dbo.#TEMP_REPORT_ITEMWISE_4 (BILLDATE VARCHAR(20),NAME VARCHAR(100),QTY decimal(12,2))        
--  CREATE TABLE dbo.#TEMP_REPORT_4(BILLDATE VARCHAR(20), NAME VARCHAR(100),ITEMCODE INT,QTY INT)        
  --CREATE TABLE dbo.#TEMP_REPORT3 (BILLDATE VARCHAR(20), NAME VARCHAR(100),ITEMCODE INT,QTY INT)        
         
  delete from #TEMP_REPORT_ITEMWISE_4
set @queryItemNames = ''
set @query2 = ''
if lower(@ITEMNAME) <> 'all'  
 begin  
   set @queryItemNames = ' AND B.CATEGORY in (' + REPLACE(REPLACE(@ITEMNAME,'[',''''),']','''') + N') '  
 end  
 
  if lower(@AREA) <> 'all'      
  begin      
	IF CHARINDEX('[', @AREA) > 0
				set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '      
		ELSE
			set @query2 = N' AND AREA in (''' + REPLACE(@AREA,',',''',''')  + ''') '    	 	    
  end      

  set @query = N' Insert into #TEMP_REPORT_ITEMWISE_4        
  select CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk, 6,''1/1/'' + CAST(DATEPART(YY, A.BILLDATE) AS CHAR(4))) + (DatePart(week,A.BILLDATE)-1), 6),6) AS StartOfWeek,        
   B.CATEGORY
  ,ISNULL(SUM(A.PACKETS),0) PACKETS  from bhavani_ER_Bills A
  INNER JOIN BELL_ITEMMASTER B ON A.ITEMCODE=B.ITEMCODE 
  WHERE SHOPNAME = (case lower('''+ @SHOP +''') when ''all'' then SHOPNAME ELSE '''+ @SHOP +''' END) 
  and  (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' 
  + @query2   + @queryItemNames
  + ' AND ISNULL(A.ITEMCODE,0) > 0 GROUP BY A.BILLDATE,B.CATEGORY,A.AREA order by B.CATEGORY  ' 

  print @query2
  PRINT @query 
  EXEC sp_executesql @query            

  set @query = N' INSERT INTO Bell_REPORT_HEADER_BILLDATE SELECT DISTINCT CONVERT(varchar,BILLDATE,6) AS BILLDATE FROM #TEMP_REPORT_ITEMWISE_4 '         
  --PRINT @query 
  EXEC sp_executesql @query            
      
  select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(CONVERT(varchar,HEADER_NAME,6)) + ']'            
     from Bell_REPORT_HEADER_BILLDATE group by HEADER_NAME order by HEADER_NAME ASC FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')        
 set @query = 'SELECT * from (select * from #TEMP_REPORT_ITEMWISE_4  '          
   +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv2 ORDER BY NAME '
        
PRINT @query        
exec sp_executesql @query;        
END        

IF @TYPE = 'chartdatabymonth'        
BEGIN        
  CREATE TABLE dbo.#TEMP_REPORT_ITEMWISE_5 (BILLDATE VARCHAR(20),NAME VARCHAR(100),QTY decimal(12,2))        
         
  delete from #TEMP_REPORT_ITEMWISE_5
set @queryItemNames = ''
set @query2 = ''
if lower(@ITEMNAME) <> 'all'  
 begin  
   set @queryItemNames = ' AND B.CATEGORY in (' + REPLACE(REPLACE(@ITEMNAME,'[',''''),']','''') + N') '  
 end  
 
  if lower(@AREA) <> 'all'      
  begin      
	IF CHARINDEX('[', @AREA) > 0
				set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '      
		ELSE
			set @query2 = N' AND AREA in (''' + REPLACE(@AREA,',',''',''')  + ''') '    	 	    
  end      
  --select convert(varchar(20),'01-' + LEFT(DATENAME(MONTH, '2025-08-09'), 3)  + '-' + datename(year,getdate()) ) 
  --select LEFT(DATENAME(MONTH, '2025-08-09'), 3)
  --select datepart(MONTH, '2025-08-09')
  --SELECT RIGHT(YEAR(GETDATE()),2)
  --SELECT CAST(RIGHT(YEAR(GETDATE()),2) AS CHAR(2))

  --CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk, 6,''1/1/'' + CAST(DATEPART(YY, A.BILLDATE) AS CHAR(4))) + (DatePart(week,A.BILLDATE)-1), 6),6) AS StartOfWeek
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'chartdatabymonth','all','all','all','2024-11-30','2025-08-30'  
  
  set @query = N' Insert into #TEMP_REPORT_ITEMWISE_5
  select convert(varchar(20), + ''01 '' +LEFT(DATENAME(MONTH,A.BILLDATE), 3) + '' '' + CAST(RIGHT(YEAR(A.BILLDATE),2) AS CHAR(2)) ) MonthYear,        
   B.CATEGORY
  ,ISNULL(SUM(A.PACKETS),0) PACKETS  from bhavani_ER_Bills A
  INNER JOIN BELL_ITEMMASTER B ON A.ITEMCODE=B.ITEMCODE 
  WHERE SHOPNAME = (case lower('''+ @SHOP +''') when ''all'' then SHOPNAME ELSE '''+ @SHOP +''' END) 
  and  (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' 
  + @query2   + @queryItemNames
  + ' AND ISNULL(A.ITEMCODE,0) > 0 GROUP BY A.BILLDATE,B.CATEGORY,A.AREA order by B.CATEGORY  ' 

  print @query2
  PRINT @query 
  EXEC sp_executesql @query            

  --select * from #TEMP_REPORT_ITEMWISE_5

  set @query = N' INSERT INTO Bell_REPORT_HEADER_BILLDATE SELECT DISTINCT BILLDATE FROM #TEMP_REPORT_ITEMWISE_5 '         
  PRINT @query 
  EXEC sp_executesql @query            
      
  select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(CONVERT(varchar,HEADER_NAME,6)) + ']'            
     from Bell_REPORT_HEADER_BILLDATE group by HEADER_NAME order by HEADER_NAME ASC FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')  
	 
 set @query = 'SELECT * from (select * from #TEMP_REPORT_ITEMWISE_5  '          
   +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv2 ORDER BY NAME '
        
PRINT @query        
exec sp_executesql @query;        
END        

end 