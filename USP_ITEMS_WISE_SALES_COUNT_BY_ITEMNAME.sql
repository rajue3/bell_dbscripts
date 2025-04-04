--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'byshop','All','ALL','all','2025-Feb-03','2025-Mar-05'    
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'byshop','All','ALL','[khara 5 RS],[moong dal 5 RS]','2025-Feb-01','2025-Mar-05'    

--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'returns','All','ALL','all','2025-Feb-03','2025-Mar-05'    
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'returns','All','ALL','[khara 5 RS],[moong dal 5 RS]','2025-Feb-01','2025-Mar-05'    

--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'byarea','[BELLAMPALLY],[BAYYARAM],[ETURNAGARAM]','ALL','ALL','2024-Nov-20','2024-Nov-30'    
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'returns','[BELLAMPALLY]','ALL','ALL','10/01/2024','11/30/2024'    
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'byshop','[BELLAMPALLY],[BAYYARAM]','ALL','ALL','2024-Aug-20','2024-Aug-30'    
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'bydate','All','ALL','moong dal 5 RS','2024-Sep-16','2024-Sep-22'    
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'showlineswithnosales','All','ALL','moong dal 5 RS','2024-Sep-16','2024-Sep-22'    
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'bydate','ALL','ALL','ALL','2024-Aug-20','2024-Aug-30'  
alter PROCEDURE USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME  
@TYPE AS NVARCHAR(20),        
@AREA AS NVARCHAR(max),        
@SHOP AS NVARCHAR(50),        
@ITEMNAME AS nVARCHAR(max),      
@BILLDATE1 AS DATE,        
@BILLDATE2 AS DATE        
AS        
BEGIN        
        
--DECLARE @TEMP_TABLE AS TABLE(SHOPNAME  VARCHAR(50), ITEMNAME  VARCHAR(50),QTY INT)        
DECLARE @cols AS NVARCHAR(MAX), @query  AS NVARCHAR(MAX)        
Declare @script as NVARCHAR(MAX)      
Declare @query2 as NVARCHAR(MAX)      
DECLARE @queryItemNames AS NVARCHAR(MAX)

set @queryItemNames = ''
if lower(@ITEMNAME) <> 'all'  
 begin  
   set @queryItemNames = ' AND ITEMNAME in (' + REPLACE(REPLACE(@ITEMNAME,'[',''''),']','''') + N') '  
 end  

--CREATE TABLE Bell_REPORT_HEADER (HEADER_NAME  VARCHAR(100))        
--DROP TABLE Bell_REPORT_HEADER      
DELETE FROM Bell_TEMP_REPORT        
DELETE FROM Bell_REPORT_HEADER        
set @query2 = ''      
IF lower(@TYPE) = 'byarea' -- AND lower(@SHOP) = 'all' AND lower(@ITEMNAME) = 'all'      
BEGIN      
      
 CREATE TABLE dbo.#TEMP_REPORT2 (AREA VARCHAR(50),ITEMCODE INT,ITEMNAME VARCHAR(50),QTY INT)      
       
 -- Insert into #TEMP_REPORT2       
 --select DISTINCT AREA,ITEMNAME,ISNULL(SUM(PACKETS),0) QTY from bhavani_ER_Bills         
 --WHERE AREA in (case lower(@AREA) when 'all' then AREA ELSE replace(@AREA,'[','''') END) and       
 --ITEMNAME in (case lower(@ITEMNAME) when 'all' then ITEMNAME ELSE replace(@ITEMNAME,'[','''') END)      
 --and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))      
 -- AND ISNULL(ITEMCODE,0) > 0      
 --GROUP BY AREA,ITEMNAME        
  if lower(@AREA) <> 'all'      
  begin      
   set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '      
  end      
  
   set @script = N' Insert into #TEMP_REPORT2      
  select DISTINCT AREA,ITEMCODE,ITEMNAME,ISNULL(SUM(PACKETS),0) QTY from bhavani_ER_Bills      
  WHERE   
  (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2   + @queryItemNames
  + ' AND ISNULL(ITEMCODE,0) > 0 GROUP BY AREA,ITEMCODE,ITEMNAME '      
  -- ITEMNAME = (case lower('''+ @ITEMNAME +''') when ''all'' then ITEMNAME ELSE ''' + @ITEMNAME +''' END)    AND   
  
  print @script      
  EXEC sp_executesql @script      
  --SELECT * FROM #TEMP_REPORT2 order by ITEMCODE      
      
  CREATE TABLE dbo.#TEMP_HEADER (HEADER_NAME VARCHAR(50))      
      
   if (select count(1) from #TEMP_REPORT2) > 0       
   BEGIN      
    --PRINT 'RECORDS EXISTS'      
    INSERT INTO #TEMP_HEADER SELECT DISTINCT AREA FROM #TEMP_REPORT2         
    --select * from #TEMP_HEADER      
  
    ----*FOR PIVOTE, FIRST GET DISTINCT COLUMN NAMES AND THEN USE PIVOTE      
    select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']' from #TEMP_HEADER group by HEADER_NAME   
 FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)') ,1,1,'')   
        
    --select @cols=dbo.GET_HEADER_ITEMNAMES(2)      
    --PRINT @cols      
    --set @query = N'SELECT * from (select distinct * from #TEMP_REPORT2 ) x         
      -- pivot (AVG(QTY) for ITEMNAME in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + N') ) P ORDER BY AREA'  
 --ITEMCODE,ITEMNAME,AREA,QTY  
   set @query = N'SELECT * from (select * from #TEMP_REPORT2 ) x         
       pivot (sum(QTY) for AREA in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + N') ) P ORDER BY ITEMCODE'  
   PRINT @query        
   exec sp_executesql @query;        
   END      
END      
else IF lower(@TYPE) = 'bydate'      
BEGIN      
      
 CREATE TABLE dbo.#TEMP_REPORT (BILLDATE VARCHAR(20), AREA VARCHAR(50),NAME VARCHAR(50),QTY INT)      
 if lower(@AREA) <> 'all'      
  begin      
   set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '      
  end      
      
 set @script = N' Insert into #TEMP_REPORT      
  select FORMAT(BILLDATE, ''dd-MMM-yy'') as BILLDATE,AREA,ITEMNAME,ISNULL(SUM(PACKETS),0) QTY from bhavani_ER_Bills      
  WHERE 
   (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2   + @queryItemNames   
  + ' AND ISNULL(ITEMCODE,0) > 0 GROUP BY BILLDATE,Area,ITEMNAME order by AREA'      
  -- ITEMNAME = '''+ @ITEMNAME +'''  and     
 print @script      
 EXEC sp_executesql @script      
      
 INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT BILLDATE FROM #TEMP_REPORT   --(STORING BILLDATE INTO SHOPNAME COL)      
      
 --*FOR PIVOTE, FIRST GET DISTINCT COLUMN NAMES AND THEN USE PIVOTE      
 select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']' from Bell_REPORT_HEADER      
      group by HEADER_NAME FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)') ,1,1,'')      
      
 set @query = 'SELECT * from (select * from #TEMP_REPORT '        
    +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) p '      
 --PRINT @query      
 exec sp_executesql @query;      
END      
else IF lower(@TYPE) = 'showlineswithnosales'      
BEGIN      
       
 if lower(@AREA) <> 'all'      
  begin      
   set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '      
  end      
         
 set @script = N' select distinct Line from Bell_Cust_Master where Line not in (      
  select AREA from bhavani_ER_Bills WHERE     
  (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2  + @queryItemNames       
  + ') and line <> '''' and area <> '''' and line <> ''ABCD-AREA'' order by Line'      
  -- ITEMNAME = '''+ @ITEMNAME +'''   AND    
 
 print @script      
 EXEC sp_executesql @script      
      
END      
      
else IF lower(@TYPE) = 'byshop'      
BEGIN      
 --Insert into Bell_TEMP_REPORT        
 --select ShopName,ITEMNAME,ISNULL(SUM(PACKETS),0) QTY from bhavani_ER_Bills A         
 ----INNER JOIN Bell_Cust_Master B ON A.CustID=B.CustID         
 --WHERE A.AREA=@AREA and A.SHOPNAME = (case lower(@SHOP) when 'all' then A.SHOPNAME ELSE @SHOP END)        
 --and ITEMNAME = (case lower(@ITEMNAME) when 'all' then ITEMNAME ELSE @ITEMNAME END)        
 --and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))        
 --GROUP BY A.ITEMNAME,A.ShopName        
      
 if lower(@AREA) <> 'all'      
  begin      
   set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '      
  end      
      
 set @script = N' Insert into Bell_TEMP_REPORT      
  select ShopName,ITEMNAME,ISNULL(SUM(PACKETS),0) QTY from bhavani_ER_Bills A       
  WHERE    
   (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2 + @queryItemNames   
  + ' AND ISNULL(ITEMCODE,0) > 0 GROUP BY ShopName,ITEMNAME '      
  -- ITEMNAME = (case lower('''+ @ITEMNAME +''') when ''all'' then ITEMNAME ELSE ''' + @ITEMNAME +''' END)   AND
  
 --print @script      
 EXEC sp_executesql @script      
      
 if (select count(1) from Bell_TEMP_REPORT) > 0       
 BEGIN        
  INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT ITEMNAME FROM Bell_TEMP_REPORT 
  
  --*FOR PIVOTE, FIRST GET DISTINCT COLUMN NAMES AND THEN USE PIVOTE        
  -- select @cols=dbo.GET_HEADER_ITEMNAMES(2)      
	--todo
	
	DECLARE @ParmDefinition nvarchar(500);
	set @script = N' 		
		SELECT @Result = STUFF((
		SELECT '','' + ''[['' + ISNULL(ItemName, '''') + '']]''   FROM Bell_ItemMaster WHERE STATUS=''Active'' ' + @queryItemNames + ' ORDER BY ITEMCODE 
		FOR XML PATH('''')  ), 1, 2, '''') ; '		
	
	SET @ParmDefinition = N'@Result VARCHAR(MAX) OUTPUT';
   EXEC sp_executesql @script, @ParmDefinition, @Result=@cols OUTPUT;
   
   --SET @cols = @ItemNames 
	PRINT 'COLUMNS ='
	print @script
	PRINT @cols
	
  --select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']'        
  --   from Bell_REPORT_HEADER  group by HEADER_NAME order by HEADER_NAME        
  --   FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)') ,1,1,'')        
        
  set @query = N'SELECT * from (select * from Bell_TEMP_REPORT ) x         
     pivot (AVG(QTY) for ITEMNAME in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + N') ) p '        
  --PRINT @query        
  exec sp_executesql @query;        
 END        
 ELSE      
 BEGIN      
  PRINT 'NO RECORDS'      
  --select * from Bell_TEMP_REPORT      
  select @SHOP AS SHOPNAME,'NO RECORDS FOUND' AS ITEMNAME      
 END      
END      
else IF lower(@TYPE) = 'returns' -- for items return %      
  BEGIN        
     
    --CREATE TABLE dbo.#TEMP_REPORT_RETURNS (AREA VARCHAR(50), BILLDATE VARCHAR(20),ITEMNAME VARCHAR(100),TOT_QTY INT,RET_QTY INT)    
    --CREATE TABLE dbo.#TEMP_REPORT_RETURNS2 (AREA VARCHAR(50), BILLDATE VARCHAR(20),ITEMNAME VARCHAR(100),TOT_QTY INT,RET_QTY INT,RET_PERCENT INT)    
 IF OBJECT_ID (N'TEMP_REPORT_RETURNS1', N'U') IS NOT NULL    
 BEGIN    
  DROP TABLE TEMP_REPORT_RETURNS1    
 END    
 IF OBJECT_ID (N'TEMP_REPORT_RETURNS2', N'U') IS NOT NULL    
 BEGIN    
  DROP TABLE TEMP_REPORT_RETURNS2    
 END    
    print 'Report Type= ' + @TYPE      
	print @queryItemNames

 if lower(@AREA) <> 'all'  
 begin  
   set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '  
 end  
 
 /* initial stage1 report  
 set @script = N' select AREA,FORMAT(BILLDATE, ''dd-MMM-yy'') as BILLDATE,ITEMNAME,T_B AS TOTAL_QTY, R_B AS RETURN_QTY,  
    CAST(ROUND((r_b/t_b)*100,2) as varchar(10))+''%'' as RETURN_PERCENTAGE from BELL_LS where R_B > 0 and (R_B/T_B)*100 >=50     
  and (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2  
  + ' order by AREA,ITEMCODE,BILLDATE '  
 print @script  
 EXEC sp_executesql @script  
 */   
      
 set @script = N' SELECT AREA,FORMAT(BILLDATE, ''dd-MMM-yy'') as BILLDATE,ITEMNAME,  
   CAST(ROUND((SUM(R_B)/SUM(T_B))*100,2) AS VARCHAR(10))+''%'' as RET_PERCENT into TEMP_REPORT_RETURNS1   
   from BELL_LS where         
   (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2 + @queryItemNames   
   + ' GROUP BY AREA,ITEMNAME,BILLDATE HAVING SUM(R_B)>0 --AND (SUM(R_B)/SUM(T_B))*100 >=50 '   

    -- ITEMNAME = (case lower('''+ @ITEMNAME +''') when ''all'' then ITEMNAME ELSE ''' + @ITEMNAME +''' END)  AND 

  print @script        
  EXEC sp_executesql @script      
    
  --CREATE TABLE dbo.#TEMP_REPORT_HEADER_NEW (HEADER_NAME DATE)  
  --INSERT INTO dbo.#TEMP_REPORT_HEADER_NEW SELECT DISTINCT BILLDATE FROM TEMP_REPORT_RETURNS1 ORDER BY BILLDATE DESC   
  set @script = N' INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT BILLDATE FROM TEMP_REPORT_RETURNS1 ORDER BY BILLDATE DESC'     
  EXEC sp_executesql @script    
   
  select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']'     
   from Bell_REPORT_HEADER group by HEADER_NAME FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')    
     
 set @query = 'SELECT * from (select * from TEMP_REPORT_RETURNS1 '      
   +' ) x pivot (MAX(RET_PERCENT) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv1 order by AREA,ITEMNAME '    
  
   PRINT @query    
  exec sp_executesql @query;     

   --SELECT * FROM dbo.#TEMP_REPORT_HEADER_NEW ORDER BY HEADER_NAME DESC  
   --SELECT * FROM TEMP_REPORT_RETURNS1    
   --SELECT * FROM TEMP_REPORT_RETURNS2    
  
    /* modified for weekwise report, but not using as it require with actual bill date.  
  
 --select AREA,FORMAT(BILLDATE, 'dd-MMM-yy') as BILLDATE,ITEMNAME,T_B AS TOTAL_QTY, R_B AS RETURN_QTY, ROUND((r_b/t_b)*100,2) as [Percentage]      
    --from BELL_LS where R_B > 0 and (R_B/T_B)*100 >=90      
    --and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))        
    --order by AREA,ITEMCODE,BILLDATE      
     
  --CAST(ROUND((r_b/t_b)*100,2) as varchar(10))+''%'' as RETURN_PERCENTAGE    
  -- SUM(R_B) > 0 and (SUM(R_B)/SUM(T_B))*100 >=50 and         
 set @script = N' select AREA,FORMAT(BILLDATE, ''dd-MMM-yy'') as BILLDATE,ITEMNAME,SUM(T_B) AS TOT_QTY, SUM(R_B) AS RET_QTY into TEMP_REPORT_RETURNS1    
 from BELL_LS where R_B>0 AND    
 (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2      
 + ' GROUP BY AREA,ITEMNAME,BILLDATE '   
     
 print @script      
 EXEC sp_executesql @script   
   set @script = N' SELECT AREA,CONVERT(varchar(50),DATEADD(wk, DATEDIFF(wk, 6, ''1/1/'' + CAST(DATEPART(YY, BILLDATE) AS CHAR(4))) + (DatePart(week, BILLDATE)-1), 6),6) AS StartOfWeek,  
   ITEMNAME,CAST(ROUND((RET_QTY/TOT_QTY)*100,2) AS VARCHAR(10))+''%'' as RET_PERCENT into     
   TEMP_REPORT_RETURNS2 FROM TEMP_REPORT_RETURNS1 WHERE RET_QTY > 0 AND (RET_QTY/TOT_QTY)*100 >= 50 '     
   
     DECLARE @datecol datetime = GETDATE();  
  DECLARE @WeekNum INT, @YearNum char(4);  
  
  SELECT @WeekNum = DATEPART(WK, @datecol), @YearNum = CAST(DATEPART(YY, @datecol) AS CHAR(4)); --46  
    
  
  print @script      
  EXEC sp_executesql @script      
  set @script = N' INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT StartOfWeek FROM TEMP_REPORT_RETURNS2 '   
  EXEC sp_executesql @script    
   
  select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']'     
   from Bell_REPORT_HEADER group by HEADER_NAME FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')    
     
 -- set @query = 'SELECT * from (select * from TEMP_REPORT_RETURNS2 '      
   --      +' ) x pivot (MAX(RET_PERCENT) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv1 order by AREA,ITEMNAME '    
     
 set @query = 'SELECT * from (select * from TEMP_REPORT_RETURNS2 '      
   +' ) x pivot (MAX(RET_PERCENT) for StartOfWeek in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv1 order by AREA,ITEMNAME '    
  
   PRINT @query    
   exec sp_executesql @query;     
   --SELECT * FROM TEMP_REPORT_RETURNS1    
   --SELECT * FROM TEMP_REPORT_RETURNS2    
  */  
  END      
end    

/*
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'byarea','[BELLAMPALLY],[BAYYARAM],[ETURNAGARAM]','ALL','ALL','2024-Nov-20','2024-Nov-30'    
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'returns','[BELLAMPALLY]','ALL','ALL','10/01/2024','11/30/2024'    
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'byshop','[BELLAMPALLY],[BAYYARAM]','ALL','ALL','2024-Aug-20','2024-Aug-30'    
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'bydate','All','ALL','moong dal 5 RS','2024-Sep-16','2024-Sep-22'    
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'showlineswithnosales','All','ALL','moong dal 5 RS','2024-Sep-16','2024-Sep-22'    
--  USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME 'bydate','ALL','ALL','ALL','2024-Aug-20','2024-Aug-30'  
CREATE PROCEDURE USP_ITEMS_WISE_SALES_COUNT_BY_ITEMNAME  
@TYPE AS NVARCHAR(20),        
@AREA AS NVARCHAR(max),        
@SHOP AS NVARCHAR(50),        
@ITEMNAME AS nVARCHAR(max),      
@BILLDATE1 AS DATE,        
@BILLDATE2 AS DATE        
AS        
BEGIN        
        
--DECLARE @TEMP_TABLE AS TABLE(SHOPNAME  VARCHAR(50), ITEMNAME  VARCHAR(50),QTY INT)        
DECLARE @cols AS NVARCHAR(MAX), @query  AS NVARCHAR(MAX)        
Declare @script as NVARCHAR(MAX)      
Declare @query2 as NVARCHAR(MAX)      
        
--CREATE TABLE Bell_REPORT_HEADER (HEADER_NAME  VARCHAR(100))        
--DROP TABLE Bell_REPORT_HEADER      
DELETE FROM Bell_TEMP_REPORT        
DELETE FROM Bell_REPORT_HEADER        
set @query2 = ''      
IF lower(@TYPE) = 'byarea' -- AND lower(@SHOP) = 'all' AND lower(@ITEMNAME) = 'all'      
BEGIN      
      
 CREATE TABLE dbo.#TEMP_REPORT2 (AREA VARCHAR(50),ITEMCODE INT,ITEMNAME VARCHAR(50),QTY INT)      
       
 -- Insert into #TEMP_REPORT2       
 --select DISTINCT AREA,ITEMNAME,ISNULL(SUM(PACKETS),0) QTY from bhavani_ER_Bills         
 --WHERE AREA in (case lower(@AREA) when 'all' then AREA ELSE replace(@AREA,'[','''') END) and       
 --ITEMNAME in (case lower(@ITEMNAME) when 'all' then ITEMNAME ELSE replace(@ITEMNAME,'[','''') END)      
 --and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))      
 -- AND ISNULL(ITEMCODE,0) > 0      
 --GROUP BY AREA,ITEMNAME        
  if lower(@AREA) <> 'all'      
  begin      
   set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '      
  end      
      
 set @script = N' Insert into #TEMP_REPORT2      
  select DISTINCT AREA,ITEMCODE,ITEMNAME,ISNULL(SUM(PACKETS),0) QTY from bhavani_ER_Bills      
  WHERE ITEMNAME = (case lower('''+ @ITEMNAME +''') when ''all'' then ITEMNAME ELSE ''' + @ITEMNAME +''' END)      
  and (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2      
  + ' AND ISNULL(ITEMCODE,0) > 0 GROUP BY AREA,ITEMCODE,ITEMNAME '      
      
  --print @script      
  EXEC sp_executesql @script      
  --SELECT * FROM #TEMP_REPORT2 order by ITEMCODE      
      
  CREATE TABLE dbo.#TEMP_HEADER (HEADER_NAME VARCHAR(50))      
      
   if (select count(1) from #TEMP_REPORT2) > 0       
   BEGIN      
    --PRINT 'RECORDS EXISTS'      
    INSERT INTO #TEMP_HEADER SELECT DISTINCT AREA FROM #TEMP_REPORT2         
    --select * from #TEMP_HEADER      
  
    ----*FOR PIVOTE, FIRST GET DISTINCT COLUMN NAMES AND THEN USE PIVOTE      
    select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']' from #TEMP_HEADER group by HEADER_NAME   
 FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)') ,1,1,'')   
        
    --select @cols=dbo.GET_HEADER_ITEMNAMES(2)      
    --PRINT @cols      
    --set @query = N'SELECT * from (select distinct * from #TEMP_REPORT2 ) x         
      -- pivot (AVG(QTY) for ITEMNAME in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + N') ) P ORDER BY AREA'  
 --ITEMCODE,ITEMNAME,AREA,QTY  
   set @query = N'SELECT * from (select * from #TEMP_REPORT2 ) x         
       pivot (sum(QTY) for AREA in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + N') ) P ORDER BY ITEMCODE'  
   PRINT @query        
   exec sp_executesql @query;        
   END      
END      
else IF lower(@TYPE) = 'bydate'      
BEGIN      
      
 CREATE TABLE dbo.#TEMP_REPORT (BILLDATE VARCHAR(20), AREA VARCHAR(50),NAME VARCHAR(50),QTY INT)      
 if lower(@AREA) <> 'all'      
  begin      
   set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '      
  end      
      
 set @script = N' Insert into #TEMP_REPORT      
  select FORMAT(BILLDATE, ''dd-MMM-yy'') as BILLDATE,AREA,ITEMNAME,ISNULL(SUM(PACKETS),0) QTY from bhavani_ER_Bills      
  WHERE ITEMNAME = '''+ @ITEMNAME +'''       
  and (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2      
  + ' AND ISNULL(ITEMCODE,0) > 0 GROUP BY BILLDATE,Area,ITEMNAME order by AREA'      
      
 print @script      
 EXEC sp_executesql @script      
      
 INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT BILLDATE FROM #TEMP_REPORT   --(STORING BILLDATE INTO SHOPNAME COL)      
      
 --*FOR PIVOTE, FIRST GET DISTINCT COLUMN NAMES AND THEN USE PIVOTE      
 select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']' from Bell_REPORT_HEADER      
      group by HEADER_NAME FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)') ,1,1,'')      
      
 set @query = 'SELECT * from (select * from #TEMP_REPORT '        
    +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) p '      
 --PRINT @query      
 exec sp_executesql @query;      
END      
else IF lower(@TYPE) = 'showlineswithnosales'      
BEGIN      
       
 if lower(@AREA) <> 'all'      
  begin      
   set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '      
  end      
         
 set @script = N' select distinct Line from Bell_Cust_Master where Line not in (      
  select AREA from bhavani_ER_Bills WHERE ITEMNAME = '''+ @ITEMNAME +'''       
  and (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2      
  + ') and line <> '''' and area <> '''' and line <> ''ABCD-AREA'' order by Line'      
      
 print @script      
 EXEC sp_executesql @script      
      
END      
      
else IF lower(@TYPE) = 'byshop'      
BEGIN      
 --Insert into Bell_TEMP_REPORT        
 --select ShopName,ITEMNAME,ISNULL(SUM(PACKETS),0) QTY from bhavani_ER_Bills A         
 ----INNER JOIN Bell_Cust_Master B ON A.CustID=B.CustID         
 --WHERE A.AREA=@AREA and A.SHOPNAME = (case lower(@SHOP) when 'all' then A.SHOPNAME ELSE @SHOP END)        
 --and ITEMNAME = (case lower(@ITEMNAME) when 'all' then ITEMNAME ELSE @ITEMNAME END)        
 --and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))        
 --GROUP BY A.ITEMNAME,A.ShopName        
      
 if lower(@AREA) <> 'all'      
  begin      
   set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '      
  end      
      
 set @script = N' Insert into Bell_TEMP_REPORT      
  select ShopName,ITEMNAME,ISNULL(SUM(PACKETS),0) QTY from bhavani_ER_Bills A       
  WHERE ITEMNAME = (case lower('''+ @ITEMNAME +''') when ''all'' then ITEMNAME ELSE ''' + @ITEMNAME +''' END)      
  and (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2      
  + ' AND ISNULL(ITEMCODE,0) > 0 GROUP BY ShopName,ITEMNAME '      
      
 --print @script      
 EXEC sp_executesql @script      
      
 if (select count(1) from Bell_TEMP_REPORT) > 0       
 BEGIN        
  INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT ITEMNAME FROM Bell_TEMP_REPORT        
        
  --*FOR PIVOTE, FIRST GET DISTINCT COLUMN NAMES AND THEN USE PIVOTE        
  select @cols=dbo.GET_HEADER_ITEMNAMES(2)      
  --select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']'        
  --   from Bell_REPORT_HEADER  group by HEADER_NAME order by HEADER_NAME        
  --   FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)') ,1,1,'')        
        
  set @query = N'SELECT * from (select * from Bell_TEMP_REPORT ) x         
     pivot (AVG(QTY) for ITEMNAME in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + N') ) p '        
  --PRINT @query        
  exec sp_executesql @query;        
 END        
 ELSE      
 BEGIN      
  PRINT 'NO RECORDS'      
  --select * from Bell_TEMP_REPORT      
  select @SHOP AS SHOPNAME,'NO RECORDS FOUND' AS ITEMNAME      
 END      
END      
else IF lower(@TYPE) = 'returns' -- for items return %      
  BEGIN        
     
    --CREATE TABLE dbo.#TEMP_REPORT_RETURNS (AREA VARCHAR(50), BILLDATE VARCHAR(20),ITEMNAME VARCHAR(100),TOT_QTY INT,RET_QTY INT)    
    --CREATE TABLE dbo.#TEMP_REPORT_RETURNS2 (AREA VARCHAR(50), BILLDATE VARCHAR(20),ITEMNAME VARCHAR(100),TOT_QTY INT,RET_QTY INT,RET_PERCENT INT)    
 IF OBJECT_ID (N'TEMP_REPORT_RETURNS1', N'U') IS NOT NULL    
 BEGIN    
  DROP TABLE TEMP_REPORT_RETURNS1    
 END    
 IF OBJECT_ID (N'TEMP_REPORT_RETURNS2', N'U') IS NOT NULL    
 BEGIN    
  DROP TABLE TEMP_REPORT_RETURNS2    
 END    
    print 'Report Type= ' + @TYPE      
 if lower(@AREA) <> 'all'  
 begin  
   set @query2 = ' AND AREA in (' + REPLACE(REPLACE(@AREA,'[',''''),']','''') + N') '  
 end  
 /* initial stage1 report  
 set @script = N' select AREA,FORMAT(BILLDATE, ''dd-MMM-yy'') as BILLDATE,ITEMNAME,T_B AS TOTAL_QTY, R_B AS RETURN_QTY,  
    CAST(ROUND((r_b/t_b)*100,2) as varchar(10))+''%'' as RETURN_PERCENTAGE from BELL_LS where R_B > 0 and (R_B/T_B)*100 >=50     
  and (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2  
  + ' order by AREA,ITEMCODE,BILLDATE '  
 print @script  
 EXEC sp_executesql @script  
 */   
      
 set @script = N' SELECT AREA,FORMAT(BILLDATE, ''dd-MMM-yy'') as BILLDATE,ITEMNAME,  
   CAST(ROUND((SUM(R_B)/SUM(T_B))*100,2) AS VARCHAR(10))+''%'' as RET_PERCENT into TEMP_REPORT_RETURNS1   
   from BELL_LS where   
   (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2      
   + ' GROUP BY AREA,ITEMNAME,BILLDATE HAVING SUM(R_B)>0 --AND (SUM(R_B)/SUM(T_B))*100 >=50 '   
     
  print @script      
  EXEC sp_executesql @script      
    
  --CREATE TABLE dbo.#TEMP_REPORT_HEADER_NEW (HEADER_NAME DATE)  
  --INSERT INTO dbo.#TEMP_REPORT_HEADER_NEW SELECT DISTINCT BILLDATE FROM TEMP_REPORT_RETURNS1 ORDER BY BILLDATE DESC   
  set @script = N' INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT BILLDATE FROM TEMP_REPORT_RETURNS1 ORDER BY BILLDATE DESC'     
  EXEC sp_executesql @script    
   
  select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']'     
   from Bell_REPORT_HEADER group by HEADER_NAME FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')    
     
 set @query = 'SELECT * from (select * from TEMP_REPORT_RETURNS1 '      
   +' ) x pivot (MAX(RET_PERCENT) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv1 order by AREA,ITEMNAME '    
  
   PRINT @query    
   exec sp_executesql @query;     
   --SELECT * FROM dbo.#TEMP_REPORT_HEADER_NEW ORDER BY HEADER_NAME DESC  
   --SELECT * FROM TEMP_REPORT_RETURNS1    
   --SELECT * FROM TEMP_REPORT_RETURNS2    
  
    /* modified for weekwise report, but not using as it require with actual bill date.  
  
 --select AREA,FORMAT(BILLDATE, 'dd-MMM-yy') as BILLDATE,ITEMNAME,T_B AS TOTAL_QTY, R_B AS RETURN_QTY, ROUND((r_b/t_b)*100,2) as [Percentage]      
    --from BELL_LS where R_B > 0 and (R_B/T_B)*100 >=90      
    --and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))        
    --order by AREA,ITEMCODE,BILLDATE      
     
  --CAST(ROUND((r_b/t_b)*100,2) as varchar(10))+''%'' as RETURN_PERCENTAGE    
  -- SUM(R_B) > 0 and (SUM(R_B)/SUM(T_B))*100 >=50 and         
 set @script = N' select AREA,FORMAT(BILLDATE, ''dd-MMM-yy'') as BILLDATE,ITEMNAME,SUM(T_B) AS TOT_QTY, SUM(R_B) AS RET_QTY into TEMP_REPORT_RETURNS1    
 from BELL_LS where R_B>0 AND    
 (BILLDATE BETWEEN CONVERT(nvarchar(10),'''+ Cast(@BILLDATE1 as varchar(15)) +''',101) AND CONVERT(nvarchar(10),'''+ cast(@BILLDATE2 as varchar(15)) + ''',101)) ' + @query2      
 + ' GROUP BY AREA,ITEMNAME,BILLDATE '   
     
 print @script      
 EXEC sp_executesql @script   
   set @script = N' SELECT AREA,CONVERT(varchar(50),DATEADD(wk, DATEDIFF(wk, 6, ''1/1/'' + CAST(DATEPART(YY, BILLDATE) AS CHAR(4))) + (DatePart(week, BILLDATE)-1), 6),6) AS StartOfWeek,  
   ITEMNAME,CAST(ROUND((RET_QTY/TOT_QTY)*100,2) AS VARCHAR(10))+''%'' as RET_PERCENT into     
   TEMP_REPORT_RETURNS2 FROM TEMP_REPORT_RETURNS1 WHERE RET_QTY > 0 AND (RET_QTY/TOT_QTY)*100 >= 50 '     
   
     DECLARE @datecol datetime = GETDATE();  
  DECLARE @WeekNum INT, @YearNum char(4);  
  
  SELECT @WeekNum = DATEPART(WK, @datecol), @YearNum = CAST(DATEPART(YY, @datecol) AS CHAR(4)); --46  
    
  
  print @script      
  EXEC sp_executesql @script      
  set @script = N' INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT StartOfWeek FROM TEMP_REPORT_RETURNS2 '   
  EXEC sp_executesql @script    
   
  select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']'     
   from Bell_REPORT_HEADER group by HEADER_NAME FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')    
     
 -- set @query = 'SELECT * from (select * from TEMP_REPORT_RETURNS2 '      
   --      +' ) x pivot (MAX(RET_PERCENT) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv1 order by AREA,ITEMNAME '    
     
 set @query = 'SELECT * from (select * from TEMP_REPORT_RETURNS2 '      
   +' ) x pivot (MAX(RET_PERCENT) for StartOfWeek in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) pv1 order by AREA,ITEMNAME '    
  
   PRINT @query    
   exec sp_executesql @query;     
   --SELECT * FROM TEMP_REPORT_RETURNS1    
   --SELECT * FROM TEMP_REPORT_RETURNS2    
  */  
  END      
end    

*/