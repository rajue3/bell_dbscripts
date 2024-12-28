  
-- BELL_STOCK_DETAILS 'All','RAW MATERIALS'   
-- BELL_STOCK_DETAILS 'ALL','all'    
-- BELL_STOCK_DETAILS 'ALL','[SWEETS],[BISCUITES]'    
-- BELL_STOCK_DETAILS 'MINORDER','RAW MATERIALS'    
-- BELL_STOCK_DETAILS 'MINORDER','NAMKEEN'    
CREATE PROCEDURE BELL_STOCK_DETAILS  
@TYPE as Varchar(10) ,  
@CATEGORY as nvarchar(max)  
AS      
BEGIN  
DECLARE @script AS NVARCHAR(max), @query2 AS NVARCHAR(max)  
set @query2 = ''  
 --CAST(LEFT(PACKINGTYPE, 1) AS CHAR(1)) + '(' + CAST(TOTALITEMSINPACK AS NVARCHAR(4))+ ')' AS QTY,     
if lower(@CATEGORY) <> 'all'      
begin      
  set @query2 = ' AND CATEGORY in (' + REPLACE(REPLACE(@CATEGORY,'[',''''),']','''') + N') '      
end  
  
if lower(@TYPE) = 'all'    
BEGIN     
 set @script = N' SELECT ITEMCODE,ITEMNAME,ISNULL(RATE1,0) AS RATE, ISNULL(MRP,0) MRP, ISNULL(CATEGORY,'''') CATEGORY,    
 ISNULL(MinOrderAlert,0) MinOrderAlert,    
 CAST(ISNULL(MinOrderAlert,0) AS NVARCHAR(5)) + '' '' + PACKINGTYPE as [Description],    
 ISNULL(CAST((ROUND(STOCK/TOTALITEMSINPACK,0)) AS NVARCHAR(5) ) + '' '' + CAST(LEFT(PACKINGTYPE, 1) AS CHAR(1)) + ''('' + CAST(TOTALITEMSINPACK AS NVARCHAR(4))+ '')'','''') AS QTY,     
 ISNULL(STOCK,0) AS STOCK FROM BELL_ITEMMASTER where Status=''Active'' ' + @query2  
  
--AND CATEGORY = (case lower(@CATEGORY) when 'all' then CATEGORY ELSE @CATEGORY END)  
END    
ELSE    
BEGIN    
 set @script = N' SELECT ITEMCODE,ITEMNAME,ISNULL(RATE1,0) AS RATE, ISNULL(MRP,0) MRP, ISNULL(CATEGORY,'''') CATEGORY,    
 ISNULL(MinOrderAlert,0) MinOrderAlert,    
 CAST(ISNULL(MinOrderAlert,0) AS NVARCHAR(5)) + '' '' + PACKINGTYPE as [Description],    
 ISNULL(CAST((ROUND(STOCK/TOTALITEMSINPACK,0)) AS NVARCHAR(5) ) + '' '' + CAST(LEFT(PACKINGTYPE, 1) AS CHAR(1)) + ''('' + CAST(TOTALITEMSINPACK AS NVARCHAR(4))+ '')'','''') AS QTY,     
 ISNULL(STOCK,0) AS STOCK FROM BELL_ITEMMASTER where Status=''Active''     
 AND (STOCK/TOTALITEMSINPACK) <= MINORDERALERT ' + @query2   
END  
  
print @query2   
print @script      
EXEC sp_executesql @script  
  
END  