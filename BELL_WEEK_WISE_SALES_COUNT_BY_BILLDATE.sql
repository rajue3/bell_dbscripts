/*   
BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'Itemwisesales','all','all',  
'[moong dal 5 RS],[Alubujiya 5 RS],[WHEELS 5 RS],[Soya sticks 5 RS],[SEV MURMURA 5 RS],[WHEELS 20 RS],[SEW MURMURA 100GM],[Khara 700 GM],[Khara 350 GM],[Bhoondhi 350 GM],[Chekodi 300 GM],[KARARE 5RS],[SOYA STICK 100GM],[Khara 1 RS],[Khara 10 RS],[MOONGDAL
L 100 GM],[CHAT PAT 5RS],[BESTO 5 RS],[BESTO ROLLS 5RS],[CHIPS 5RS],[MASALA PALLY 20 RS],[BHOONDI 100GM],[BHOONDI 450 GM],[KHARA 450 GM],[ROUND CHIKKY],[ROUND TILL CHIKKY],[Chikky 5 RS],[Till Chikky 5 RS],[12 pics Chikky],[SOANPAPIDI 2RS],[BELL SOAN PAPID
I 5 Rs],[KRUPA PAPIDI(BANARAS)],[Dry Jamun 1 Rs],[RAVA LADDU 5RS],[MILK KOVA 5 RS],[Mysorepak 5 Rs],[Kajapuri 5 Rs],[Kcr Kova 1 Rs],[Kcr Kova 2 Rs],[Kcr Kova 5 Rs],[SWEET MURUKU 1RS],[BHADUSHA 5 RS],[DILPASAD 5RS],[MURUKULU BELLAM LADDU 5RS],[COVA 5 RS],[
BELL GULAB JAMUN 5RS],[PUFFS 5RS],[ROUND CHIKKY 5RS],[KHARA PURI 5RS],[KRAZY KRAZY(CRAKER) 5 RS],[KRAZY KRAZY(CRAKER) 3RS],[MARIE SUMO 5 RS],[MILKVITA 5 RS],[EVERDAY BUTTER 5 RS],[HI-FUN(CREAM)5 RS],[BOURBON5 RS],[OSMANIYA 3 RS],[SUN RICE MARIE5 RS],[SUN 
RICE BUTTER 5 RS],[SUN RICE CREAM 5 RS],[RUSK 10 Rs],[BAKERY BISCUIT 5 RS],[OSMANIYA BIS 5RS],[TEA BISCUIT 5RS],[DRY FRUIT BIS JAR 5RS],[BUTTER FUN 50NP],[COFFEE STAR 50NP],[FRUITY 50NP],[ORANGE 50NP],[COCOUNTMAGIC- 50NP],[COFFE GOLD JAR 1/-],[FRUITO JELL
Y JAR],[FRUITO POP BAG 1RS],[FRUITO POP JAR 2RS],[FRUITO POP JAR 5RS],[CHACO DAIRY BLITZ 5RS],[CHACO DARK 1RS],[CHACO WHITE 1RS],[TRUFFELLO JAR (12P) 5RS],[TRUFFELLO (24P) 5RS],[BELGIO 2RS],[FRUTO BEARZ 1 RS],[FUN BON PKT 1RS],[FUNBON JAR 1RS],[WAFIX 5RS]
,[CREMONA 5RS],[KIDDY MUNCH 2RS],[PARTY STICKS 5RS],[FUN CONES 5RS],[CRAZY CUPS 5RS],[DURBAN 5RS],[JUST CRUNCH 2 RS],[2RS MILKY STAR],[5RS COOKIE FILLS],[NOU STAR JAR 5RS],[MILK ECLAIRS JAR 1/-],[ELACHI ECLAIRS JAR 1/-],[ECLACHI ECLAIRS PKT 1/-],[MILK ECL
AIRS PKT 1/-],[ECLAIRS 50 NP],[CAKE 1RS],[CAKE TIME 5RS],[TWERK 5RS],[CAKE 2RS JAR],[SLICE CAKE 5RS],[135 GMS DISH WASH 10/-],[THUMUS -UP 250 ML],[MANGO TETRA],[SPRITE 250ML],[MIXED FRUIT JAM 20 RS],[TAMATO KETCHUP 1RS],[THUMS UP 2.2 LT],[SPRITE 2.2 LT],[
250ML MAAZA] '  
,'2025-05-01','2025-08-30'    
*/  
  
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'weeklyItemwisesales','all','all','[khara 5 RS],[moong dal 5 RS]','2025-07-01','2025-08-30'    
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'monthlyItemwisesales','[BHADRACHALAM]','all','[khara 5 RS],[moong dal 5 RS]','2025-05-01','2025-08-30'    
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'Itemwisesales','all','all','[khara 5 RS],[moong dal 5 RS]','2025-05-01','2025-08-30'    
  
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'chartdatabymonth','all','all','all','2024-11-30','2025-08-30'    
  
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'chartdata','all','all','all','2025-07-01','2025-08-30'    
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'chartdata','BHADRACHALAM','all','all','2025-07-01','2025-08-30'    
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'chartdata','[BHADRACHALAM]','all','all','2025-07-01','2025-08-30'    
  
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'weekwisebyarea','all','all','all','2025-07-01','2025-08-30'    
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE  'weekwisebyarea','[BHADRACHALAM]','all','all','2025-07-01','2025-08-30'    
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE  'weekwisebyarea','BHADRACHALAM,HYDERABAD','all','all','2025-07-01','2025-08-30'    
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'weekwisebyarea','[BHADRACHALAM]','BHERU FANCY (BCM)','[khara 5 RS],[moong dal 5 RS]','2025-05-01','2025-08-30'    
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'weekwisebyarea','[BHADRACHALAM]','all','[khara 5 RS],[moong dal 5 RS]','2025-05-01','2025-08-30'    
-- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'monthlyitemwisesale','all','all','all','2025-07-01','2025-11-30'    
  
-- New report created for Charts on 03-Aug-2025    
  
alter PROCEDURE BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE  
@TYPE AS NVARCHAR(20),          
@AREA AS NVARCHAR(max),      --  Line    
@SHOP AS NVARCHAR(50),          
@ITEMNAME AS nVARCHAR(max),        
@BILLDATE1 AS DATE,          
@BILLDATE2 AS DATE          
AS          
BEGIN       
  CREATE TABLE #TEMP_REPORT_ITEMWISE (BILLDATE VARCHAR(20),ITEMCODE INT, NAME VARCHAR(100),QTY decimal(12,2))          
--DECLARE @Bell_TEMP_REPORT AS TABLE(BILLDATE VARCHAR(20), NAME VARCHAR(50),QTY INT)          
DECLARE @cols AS NVARCHAR(MAX), @query  AS NVARCHAR(MAX),@query2  AS NVARCHAR(MAX), @queryItemNames AS NVARCHAR(MAX)  
          
--DECLARE @TEMP_REPORT AS TABLE(BILLDATE VARCHAR(20), NAME VARCHAR(100),QTY INT)          
--DELETE FROM Bell_TEMP_REPORT          
DELETE FROM Bell_REPORT_HEADER          
delete from Bell_REPORT_HEADER_BILLDATE        
   
IF @TYPE = 'weekwisebyarea'          
BEGIN          
	TRUNCATE TABLE #TEMP_REPORT_ITEMWISE;
	
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
IF @TYPE = 'monthlyitemwisesales'    -- month wise chart  for Item wise sales     added on 18-Nov-25 for chart
BEGIN          
	TRUNCATE TABLE #TEMP_REPORT_ITEMWISE;
	--IF OBJECT_ID('tempdb..#TEMP_REPORT_ITEMWISE') IS NOT NULL
	--begin
	--	DROP TABLE #TEMP_REPORT_ITEMWISE;
	--	CREATE TABLE #TEMP_REPORT_ITEMWISE (BILLDATE VARCHAR(20),ITEMCODE INT, NAME VARCHAR(100),QTY decimal(12,2))          
	--end         
  --delete from #TEMP_REPORT_ITEMWISE      
  
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
  
  --select CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk, 6,''1/1/'' + CAST(DATEPART(YY, BILLDATE) AS CHAR(4))) + (DatePart(week, BILLDATE)-1), 6),6) AS StartOfWeek,    
  set @query = N' Insert into #TEMP_REPORT_ITEMWISE          
  select convert(varchar(20), + ''01 '' +LEFT(DATENAME(MONTH,BILLDATE), 3) + '' '' + CAST(RIGHT(YEAR(BILLDATE),2) AS CHAR(2)) ) MonthYear,  
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
   B.CATEGORY, CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT from bhavani_ER_Bills A  
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
  -- ,ISNULL(SUM(A.PACKETS),0) PACKETS  
  set @query = N' Insert into #TEMP_REPORT_ITEMWISE_5  
  select convert(varchar(20), + ''01 '' +LEFT(DATENAME(MONTH,A.BILLDATE), 3) + '' '' + CAST(RIGHT(YEAR(A.BILLDATE),2) AS CHAR(2)) ) MonthYear,          
   B.CATEGORY, CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT from bhavani_ER_Bills A  
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
  
  
IF @TYPE = 'weeklyItemwisesales'  or @TYPE='monthlyItemwisesales'  or @TYPE='Itemwisesales'    
BEGIN          
  CREATE TABLE dbo.#TEMP_REPORT_ITEMWISE_6 (BILLDATE VARCHAR(50),ITEMCODE INT, NAME VARCHAR(100),QTY decimal(12,2))          
  --CREATE TABLE dbo.#TEMP_REPORT6 (BILLDATE VARCHAR(20), NAME VARCHAR(100),ITEMCODE INT,QTY INT)          
  --CREATE TABLE dbo.#TEMP_REPORT3 (BILLDATE VARCHAR(20), NAME VARCHAR(100),ITEMCODE INT,QTY INT)          
           
  delete from #TEMP_REPORT_ITEMWISE_6          
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
  
  if @TYPE='weeklyItemwisesales'    
  BEGIN  
  set @query = N' Insert into #TEMP_REPORT_ITEMWISE_6          
 select CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk, 6,''1/1/'' + CAST(DATEPART(YY, BILLDATE) AS CHAR(4))) + (DatePart(week, BILLDATE)-1), 6),6) AS StartOfWeek,          
 ISNULL(ITEMCODE,0),ITEMNAME,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT  from bhavani_ER_Bills          
 WHERE   
 (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) '   
 + @query2   + @queryItemNames  
 + ' AND ISNULL(ITEMCODE,0) > 0 GROUP BY BILLDATE,ITEMNAME,AREA,ITEMCODE order by ITEMCODE  '    
  
  EXEC sp_executesql @query              
      
  set @query = N' INSERT INTO Bell_REPORT_HEADER_BILLDATE SELECT DISTINCT CONVERT(varchar,BILLDATE,6) AS BILLDATE FROM #TEMP_REPORT_ITEMWISE_6 '           
  EXEC sp_executesql @query              
        
  select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(CONVERT(varchar,HEADER_NAME,6)) + ']'              
   from Bell_REPORT_HEADER_BILLDATE group by HEADER_NAME order by HEADER_NAME ASC FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')          
  set @query = 'SELECT * from (select * from #TEMP_REPORT_ITEMWISE_6  '            
  +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv2 ORDER BY ITEMCODE '  
  exec sp_executesql @query;       
  END  
 ELSE IF @TYPE='monthlyItemwisesales'    
 BEGIN  
  set @query = N' Insert into #TEMP_REPORT_ITEMWISE_6          
  select convert(varchar(20), + ''01 '' +LEFT(DATENAME(MONTH,BILLDATE), 3) + '' '' + CAST(RIGHT(YEAR(BILLDATE),2) AS CHAR(2)) ) MonthYear,          
  ISNULL(ITEMCODE,0),ITEMNAME,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT  from bhavani_ER_Bills          
  WHERE   
  (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) '   
  + @query2   + @queryItemNames  
  + ' AND ISNULL(ITEMCODE,0) > 0 GROUP BY BILLDATE,ITEMNAME,AREA,ITEMCODE order by ITEMCODE  '    
  
    EXEC sp_executesql @query              
      
    set @query = N' INSERT INTO Bell_REPORT_HEADER_BILLDATE SELECT DISTINCT CONVERT(varchar,BILLDATE,6) AS BILLDATE FROM #TEMP_REPORT_ITEMWISE_6 '           
    EXEC sp_executesql @query              
        
    select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(CONVERT(varchar,HEADER_NAME,6)) + ']'              
    from Bell_REPORT_HEADER_BILLDATE group by HEADER_NAME order by HEADER_NAME ASC FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')          
   set @query = 'SELECT * from (select * from #TEMP_REPORT_ITEMWISE_6  '            
     +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv2 ORDER BY ITEMCODE '  
    print @cols  
  exec sp_executesql @query;          
 END  
 ELSE  -- 'Itemwisesales'  
BEGIN  
--select  convert(varchar(20),format(GETDATE(),'dd-MMM-yy')) AS TillDate  
-- convert(varchar(20),format(GETDATE(),''dd-MMM-yy'')) AS TillDate  
--select convert(varchar(20),DATENAME(DAY,getdate() ) + ' ' + LEFT(DATENAME(MONTH,getdate()), 3) + CAST(RIGHT(YEAR(getdate()),2) AS CHAR(2)) ) as TillDate  
 -- convert(varchar(20), + DATENAME(DAY,'''+cast(@BILLDATE2 as varchar(15))+''') + '' '' + LEFT(DATENAME(MONTH,'''+cast(@BILLDATE2 as varchar(15))+'''), 3) + '' '' + CAST(RIGHT(YEAR('''+cast(@BILLDATE2 as varchar(15))+'''),2) AS CHAR(2)) ) TillDate  
  declare @DateRange as varchar(50)  
  set @DateRange = cast(FORMAT(@BILLDATE1,'dd-MM-yy') as varchar(15)) + ' To ' + cast(format(@BILLDATE2,'dd-MM-yy') as varchar(15))  
  print @DateRange  
  
 set @query = N' Insert into #TEMP_REPORT_ITEMWISE_6  Select ''' + @DateRange + '''   TillDate,  
  ISNULL(ITEMCODE,0),ITEMNAME,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT  from bhavani_ER_Bills          
  WHERE   
   (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) '   
  + @query2   + @queryItemNames  
  + ' AND ISNULL(ITEMCODE,0) > 0 GROUP BY BILLDATE,ITEMNAME,AREA,ITEMCODE order by ITEMCODE  '   
  
   PRINT @query   
   EXEC sp_executesql @query              
   --SELECT BILLDATE,ITEMCODE,[NAME],SUM(QTY) QTY FROM #TEMP_REPORT_ITEMWISE_6 GROUP BY BILLDATE,ITEMCODE,[NAME]   order by BILLDATE ASC        
  
  INSERT INTO Bell_REPORT_HEADER VALUES(@DateRange)  
  -- PRINT @query   
  --EXEC sp_executesql @query              
        
   --SELECT DISTINCT CONVERT(varchar,HEADER_NAME,6) as HEADER_NAME FROM Bell_REPORT_HEADER_BILLDATE order by HEADER_NAME ASC        
      
   select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(CONVERT(varchar,HEADER_NAME,6)) + ']'              
    from Bell_REPORT_HEADER group by HEADER_NAME order by HEADER_NAME ASC FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')          
  
   set @query = 'SELECT * from (select * from #TEMP_REPORT_ITEMWISE_6  '            
     +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv2 ORDER BY ITEMCODE '  
     PRINT @cols  
   --select * from Bell_REPORT_HEADER          
   --select * from TEMP_DYNAMIC_REPORT2          
    
  --set @query = 'SELECT * from (select * from #TEMP_REPORT_ITEMWISE_6  '  +' ) x pivot (SUM(QTY) for BILLDATE in (''' + @DateRange + ''') ) pv2 ORDER BY ITEMCODE '  
  PRINT @query          
 exec sp_executesql @query;          
 -- BELL_WEEK_WISE_SALES_COUNT_BY_BILLDATE 'Itemwisesales','all','all','[khara 5 RS],[moong dal 5 RS]','2025-05-01','2025-08-30'    
END  
    
END          
   ---====== temp code not using this....  
 -- --SELECT * FROM #TEMP_REPORT_ITEMWISE_6 order by BILLDATE ASC        
 -- PRINT @query   
 -- EXEC sp_executesql @query              
  
 -- set @query = N' INSERT INTO Bell_REPORT_HEADER_BILLDATE SELECT DISTINCT CONVERT(varchar,BILLDATE,6) AS BILLDATE FROM #TEMP_REPORT_ITEMWISE_6 '           
 -- --PRINT @query   
 -- EXEC sp_executesql @query              
        
 -- --SELECT DISTINCT CONVERT(varchar,HEADER_NAME,6) as HEADER_NAME FROM Bell_REPORT_HEADER_BILLDATE order by HEADER_NAME ASC        
          
 -- select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(CONVERT(varchar,HEADER_NAME,6)) + ']'              
 --    from Bell_REPORT_HEADER_BILLDATE group by HEADER_NAME order by HEADER_NAME ASC FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')          
          
 -- --PRINT @cols        
 -- --select * from Bell_REPORT_HEADER          
 -- --select * from TEMP_DYNAMIC_REPORT2          
    
 --set @query = 'SELECT * from (select * from #TEMP_REPORT_ITEMWISE_6  '            
 --  +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv2 ORDER BY ITEMCODE '  
         
  
end   