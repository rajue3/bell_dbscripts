  
  --BELL_SHOP_WISE_SALES_BY_BILLNUMBER  
-- BELL_SHOP_WISE_SALES_BY_BILLNUMBER 'BILLWISE','BAYYARAM ','all','2024-11-01','2024-11-25'  
-- BELL_SHOP_WISE_SALES_BY_BILLNUMBER 'BILLWISE','ASIFABAD','all','2024-07-01','2024-07-16'  
-- BELL_SHOP_WISE_SALES_BY_BILLNUMBER 'BILLWISE','CHENNURU ','all','2024-07-04','2024-07-05'  
alter PROCEDURE BELL_SHOP_WISE_SALES_BY_BILLNUMBER  
@HEADER AS NVARCHAR(20),  
@AREA AS NVARCHAR(50),  
@AREA_LINE AS NVARCHAR(50),      --  AREA
@SHOP AS NVARCHAR(50),  
@BILLDATE1 AS DATE,  
@BILLDATE2 AS DATE  
AS  
BEGIN  
  
--DECLARE @Bell_TEMP_REPORT AS TABLE(BILLDATE VARCHAR(20), NAME VARCHAR(50),QTY INT)  
DECLARE @cols AS NVARCHAR(MAX), @query  AS NVARCHAR(MAX)  
--DECLARE @TEMP_REPORT AS TABLE (@BILLDATE VARCHAR(15),@ITEMNAME VARCHAR(50),@QTY INT)  
  
--DELETE FROM Bell_TEMP_REPORT  
DELETE FROM Bell_REPORT_HEADER  
  
CREATE TABLE dbo.#TEMP_REPORT (BILLDATE VARCHAR(20), BILLNUMBER INT,QTY DECIMAL(12,2))  
--CREATE TABLE dbo.#TEMP_REPORT (BILLDATE VARCHAR(20), BILLNUMBER INT, SHOPNAME VARCHAR(100),QTY INT)  
  
Insert into #TEMP_REPORT  
  select FORMAT(BILLDATE, 'dd-MMM-yy') as BILLDATE,BILLNUMBER  
  --,ISNULL(SUM(AMOUNT),0) AMOUNT  
  ,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT  
  from bhavani_ER_Bills  
  WHERE AREA=@AREA 
  and SHOPNAME = (case lower(@SHOP) when 'all' then SHOPNAME ELSE @SHOP END)  
  AND AREA_LINE = (case lower(@AREA_LINE) when 'all' then AREA_LINE ELSE @AREA_LINE END)      
  and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))  
  GROUP BY BILLDATE,BILLNUMBER,AREA order by BILLNUMBER  
  --select FORMAT(BILLDATE, 'dd-MMM-yy') as BILLDATE,BILLNUMBER,SHOPNAME,  
  --ISNULL(SUM(AMOUNT),0) AMOUNT from bhavani_ER_Bills  
  --WHERE AREA=@AREA and SHOPNAME = (case lower(@SHOP) when 'all' then SHOPNAME ELSE @SHOP END)  
  --and (BILLDATE BETWEEN CONVERT(nvarchar(10),@BILLDATE1,101) AND CONVERT(nvarchar(10),@BILLDATE2,101))  
  --GROUP BY BILLDATE,BILLNUMBER,SHOPNAME,AREA order by BILLNUMBER  
  
--Select * from #TEMP_REPORT --order by shopname desc  
  
INSERT INTO Bell_REPORT_HEADER SELECT DISTINCT BILLDATE FROM #TEMP_REPORT   
  
select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']'  
                    from Bell_REPORT_HEADER group by HEADER_NAME  
            FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')  
  
set @query = 'SELECT * from (select * from #TEMP_REPORT '    
 +' ) x pivot (SUM(QTY) for BILLDATE in (' + REPLACE(REPLACE(@cols,'[[','['),']]',']') + ') ) p '  
  
PRINT @query  
exec sp_executesql @query;  
end  