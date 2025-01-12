
-- BELL_GET_STOCK_TRANSACTIONS 'ALL','LINE','2024-12-22','2024-12-31','ALL'
-- BELL_GET_STOCK_TRANSACTIONS '[SWEETS],[BISCUITES]','ALL','2024-12-01','2024-12-30','SUGUNA'
-- BELL_GET_STOCK_TRANSACTIONS '[SWEETS],[BISCUITES]','ALL','2024-12-01','2024-12-30','ALL'
-- BELL_GET_STOCK_TRANSACTIONS '[Raw Materials]','IN','2024-12-01','2024-12-30','ALL'
-- BELL_GET_STOCK_TRANSACTIONS 'SWEETS','OUT','2024-12-01','2024-12-30','ALL'
-- BELL_GET_STOCK_TRANSACTIONS 'ALL','ALL','2024-12-01','2024-12-30','ALL'
alter procedure BELL_GET_STOCK_TRANSACTIONS
@CATEGORY as nvarchar(max),
@TRANS_TYPE AS VARCHAR(10),
@FROMDATE AS DATE,
@TODATE AS DATE,
@USERNAME AS VARCHAR(20)

AS
DECLARE @QUERY AS NVARCHAR(200)
BEGIN

DECLARE @script AS NVARCHAR(max), @query2 AS NVARCHAR(max)
set @query2 = ''
if lower(@CATEGORY) <> 'all'    
begin    
  set @query2 = ' AND B.CATEGORY in (' + REPLACE(REPLACE(@CATEGORY,'[',''''),']','''') + N') '    
end
-- AND B.CATEGORY = (case lower(@CATEGORY) when 'all' then B.CATEGORY ELSE @CATEGORY END)
--(CASE LOWER(A.TRANS_TYPE) WHEN 'C' THEN 'IN' ELSE 'OUT' END) AS [IN/OUT]  

--** USERNAME<>''ORDERS'' is requried as these are just quotations and not went out.
  IF UPPER(@TRANS_TYPE)='ALL'
  BEGIN
    set @script = N' SELECT A.ItemName,B.CATEGORY,A.TRANS_TYPE AS [IN/OUT],A.Qty,A.STOCK PAK,    
	FORMAT(A.BILLDate,''dd-MMM-yyyy'',''en-US'') as BILLDATE,FORMAT(A.ActionDate, ''dd-MMM-yyyy'', ''en-US'') as ACTION_DATE
	,A.PARTYNAME,A.USERNAME  
     FROM Bell_STOCK_ENTRY A INNER JOIN Bell_ItemMaster B ON A.ITEMCODE=B.ITEMCODE AND A.ITEMNAME=B.ITEMNAME
    WHERE A.USERNAME = (case lower('''+ @USERNAME +''') when ''all'' then A.USERNAME ELSE '''+ @USERNAME +''' END) AND
    (A.BILLDATE BETWEEN '''+CONVERT(nvarchar(10),@FROMDATE,101)+''' AND '''+CONVERT(nvarchar(10),dateadd(d,1,@TODATE),101) +''')    
     ' + @query2 + '
    UNION ALL
    SELECT LS.ITEMNAME,B.CATEGORY,''OUT'' AS [IN/OUT],LS.QTY,(T_B-R_B-D_B) AS PAK,
    FORMAT(LS.BILLDATE,''dd-MMM-yyyy'',''en-US'') as BILLDATE,FORMAT(LS.ActionDate,''dd-MMM-yyyy'',''en-US'') as ACTION_DATE
	,''AREA -'' + AREA AS PARTYNAME,LS.USERNAME
    FROM BELL_LS LS
    INNER JOIN BELL_ITEMMASTER B ON B.ITEMCODE=LS.ITEMCODE AND B.ITEMNAME=LS.ITEMNAME 
    WHERE LS.USERNAME = (case lower('''+@USERNAME+''') when ''all'' then LS.USERNAME ELSE '''+@USERNAME +''' END) AND LS.USERNAME<>''ORDERS'' AND
    (LS.BILLDATE BETWEEN '''+CONVERT(nvarchar(10),@FROMDATE,101)+''' AND '''+CONVERT(nvarchar(10),dateadd(d,1,@TODATE),101)+''')
    ' + @query2      
  END
  ELSE IF UPPER(@TRANS_TYPE)='IN' OR UPPER(@TRANS_TYPE)='OUT' -- OR UPPER(@TRANS_TYPE)='C'
  BEGIN
    set @script = N' SELECT A.ItemCode,A.ItemName,B.CATEGORY,A.TRANS_TYPE AS [IN/OUT],A.Qty,A.STOCK PAK,    
    FORMAT(A.BILLDATE,''dd-MMM-yyyy'',''en-US'') as BILLDATE,FORMAT(A.ActionDate, ''dd-MMM-yyyy'', ''en-US'') as ACTION_DATE
	,A.PARTYNAME,A.USERNAME  
     FROM Bell_STOCK_ENTRY A INNER JOIN Bell_ItemMaster B ON A.ITEMCODE=B.ITEMCODE AND A.ITEMNAME=B.ITEMNAME
    WHERE A.USERNAME = (case lower('''+@USERNAME+''') when ''all'' then A.USERNAME ELSE '''+@USERNAME +''' END) AND
    (A.BILLDATE BETWEEN '''+CONVERT(nvarchar(10),@FROMDATE,101)+''' AND '''+CONVERT(nvarchar(10),dateadd(d,1,@TODATE),101)+''') 
	AND TRANS_TYPE = '''+@TRANS_TYPE+''' ' + @query2    
    --AND TRANS_TYPE = ''IN'' ' + @query2    
  END
  --ELSE IF UPPER(@TRANS_TYPE)='OUT' OR UPPER(@TRANS_TYPE)='D'
  --BEGIN
  --  set @script = N' SELECT A.ItemName,B.CATEGORY,A.TRANS_TYPE AS [IN/OUT],A.Qty,A.STOCK PAK,    
  --  FORMAT(A.BILLDATE,''dd-MMM-yyyy'',''en-US'') as BILLDATE,FORMAT(A.ActionDate, ''dd-MMM-yyyy'', ''en-US'') as ACTION_DATE,A.PARTYNAME,A.USERNAME  
  --   FROM Bell_STOCK_ENTRY A INNER JOIN Bell_ItemMaster B ON A.ITEMCODE=B.ITEMCODE AND A.ITEMNAME=B.ITEMNAME
  --  WHERE A.USERNAME = (case lower('''+@USERNAME+''') when ''all'' then A.USERNAME ELSE '''+@USERNAME +''' END) AND
  --  (A.BILLDATE BETWEEN '''+CONVERT(nvarchar(10),@FROMDATE,101)+''' AND '''+CONVERT(nvarchar(10),dateadd(d,1,@TODATE),101)+''')     
  --  AND TRANS_TYPE = ''OUT'' ' + @query2  + '  
  --  UNION ALL
  --  SELECT LS.ITEMNAME,B.CATEGORY,''OUT'' AS [IN/OUT],LS.QTY,(T_B-R_B-D_B) AS PAK,
  --  FORMAT(LS.BILLDATE,''dd-MMM-yyyy'',''en-US'') as BILLDATE,FORMAT(LS.ACTIONDATE, ''dd-MMM-yyyy'', ''en-US'') as ACTION_DATE,''AREA -'' + AREA AS PARTYNAME,LS.USERNAME
  --  FROM BELL_LS LS
  --  INNER JOIN BELL_ITEMMASTER B ON B.ITEMCODE=LS.ITEMCODE AND B.ITEMNAME=LS.ITEMNAME 
  --  WHERE LS.USERNAME = (case lower('''+@USERNAME+''') when ''all'' then LS.USERNAME ELSE '''+@USERNAME +''' END) AND
  --  (LS.BILLDATE BETWEEN '''+CONVERT(nvarchar(10),@FROMDATE,101)+''' AND '''+CONVERT(nvarchar(10),dateadd(d,1,@TODATE),101)+''') ' + @query2       
  --END
  ELSE IF UPPER(@TRANS_TYPE)='LINE'
  BEGIN
    set @script = N' SELECT LS.ITEMNAME,B.CATEGORY,''OUT'' AS [IN/OUT],LS.QTY,(T_B-R_B-D_B) AS PAK,
    FORMAT(LS.BILLDATE,''dd-MMM-yyyy'',''en-US'') as BILLDATE,FORMAT(LS.ACTIONDATE, ''dd-MMM-yyyy'', ''en-US'') as ACTION_DATE,
	''AREA -'' + AREA AS PARTYNAME,LS.USERNAME FROM BELL_LS LS
    INNER JOIN BELL_ITEMMASTER B ON B.ITEMCODE=LS.ITEMCODE AND B.ITEMNAME=LS.ITEMNAME 
    WHERE LS.USERNAME = (case lower('''+@USERNAME+''') when ''all'' then LS.USERNAME ELSE '''+@USERNAME +''' END) AND LS.USERNAME<>''ORDERS'' AND
    (LS.BILLDATE BETWEEN '''+CONVERT(nvarchar(10),@FROMDATE,101)+''' AND '''+CONVERT(nvarchar(10),dateadd(d,1,@TODATE),101)+''') ' + @query2       
  END

  print @query2 
  print @script    
  EXEC sp_executesql @script
END 
GO