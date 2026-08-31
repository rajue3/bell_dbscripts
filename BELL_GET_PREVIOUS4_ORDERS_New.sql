/*  TO GET LAST 4 ORDERS LIKE TOTAL PACKETS LOADED AND UNLOADED PACKETS
--SELECT   LEFT(PACKINGTYPE, 1) + ' (' + CAST(TOTALITEMSINPACK AS VARCHAR(10)) + ')' AS ItemType FROM Bell_ItemMaster;
SELECT * FROM BELL_LS WHERE Area = 'BAZAR' order by billdate desc
SELECT itemcode,itemname,billdate,sum(packets) FROM bhavani_ER_Bills WHERE Area = 'bhavani' and billdate>'2026-04-30'
group by itemname,area,itemcode,billdate 
order by itemcode,billdate desc
SELECT distinct top 4 Billdate FROM bhavani_ER_Bills where Area = 'bhavani' and billdate<'2026-05-06' order by Billdate desc

SELECT BillDate, ROW_NUMBER() OVER (ORDER BY BillDate DESC) AS rn
			FROM (SELECT DISTINCT BillDate FROM Bhavani_ER_Bills WHERE Area='ETURNAGARAM' AND BILLDATE<'2026-Jan-02') D

	SELECT DISTINCT TOP 4 BILLDATE,AREA FROM BELL_LS WHERE AREA='JAMMIKUNTA' and BillDate<'2025-Dec-19' ORDER BY BILLDATE DESC
	SELECT BillDate,   ROW_NUMBER() OVER (ORDER BY BillDate DESC) AS rn
			FROM (SELECT DISTINCT BillDate FROM Bhavani_ER_Bills WITH (NOLOCK) WHERE Area='JANGAON' AND BILLDATE<'2026-Feb-28' ) d

 BELL_GET_PREVIOUS4_ORDERS_NEW 'KORUTLA','2026-Apr-30'  -- using in VB6
 BELL_GET_PREVIOUS4_ORDERS_NEW 'KORUTLA','2026-Apr-30' ,'DIRECT_BILLING'

BELL_GET_PREVIOUS4_ORDERS_NEW 'JAMMIKUNTA','2026-Sep-01'
-- BELL_GET_PREVIOUS4_ORDERS_NEW 'NEKKONDA','2025-Dec-20','BILLS'

	BELL_GET_PREVIOUS4_ORDERS_NEW 'mARIPEDA','2026-05-18','GET ORDER ITEMS'
	BELL_GET_PREVIOUS4_ORDERS_NEW 'mARIPEDA','2026-05-04','GET ORDER ITEMS'

	--* creatd index on 09-Jun-26 to improve previous orders SP performance.
	CREATE INDEX IX_Bills_Area_BillDate ON Bhavani_ER_Bills (Area, BillDate) INCLUDE (ItemCode, ItemName, Packets);

*/
alter procedure DBO.Bell_Get_Previous4_Orders_New
@AREA as varchar(50),
@BILLDATE AS DATE,
@REPORTTYPE VARCHAR(20) = '',
@SHOPNAME VARCHAR(100)=''
AS
BEGIN

IF @REPORTTYPE='GET ORDER ITEMS'
BEGIN
		SELECT ID,BILLDATE,AREA,ITEMNAME,ITEMCODE,RATE,T_B,QTY  FROM Bell_LS_ORDERS WHERE AREA=@AREA AND BILLDATE=@BILLDATE ORDER BY ITEMCODE
END
-- THIS IS TO SHOW LAST WEEKS TRANSACTIONS MADE BY INDIVIDUAL SHOPS.  FIRST WILL GET BY LINE AND THEN FILTER BY SHOP IN MOBILE APP.
ELSE IF @REPORTTYPE='BILLS'
BEGIN
		WITH LastDates AS (
			SELECT BillDate,
				   ROW_NUMBER() OVER (ORDER BY BillDate DESC) AS rn
			FROM (SELECT DISTINCT BillDate FROM Bhavani_ER_Bills WITH (NOLOCK) WHERE Area=@AREA AND BILLDATE<@BILLDATE ) d
		)
		, Filtered AS (
			SELECT ItemCode,ItemName, RATE,BillDate, PACKETS,SALESMAN,AREA,AREA_LINE,SHOPNAME	FROM Bhavani_ER_Bills WITH (NOLOCK)
			WHERE Area=@AREA
			  AND BillDate IN (SELECT BillDate FROM LastDates WHERE rn <= 4)
		)  		
		SELECT ItemCode,ItemName, MAX(RATE) RATE, AREA,SHOPNAME,AREA_LINE,
			ISNULL(sum(CASE WHEN ld.rn = 1 THEN f.PACKETS END),0) AS PACKETS_Date4,
			ISNULL(sum(CASE WHEN ld.rn = 2 THEN f.PACKETS END),0) AS PACKETS_Date3,
			ISNULL(sum(CASE WHEN ld.rn = 3 THEN f.PACKETS END),0) AS PACKETS_Date2,
			ISNULL(sum(CASE WHEN ld.rn = 4 THEN f.PACKETS END),0) AS PACKETS_Date1    
			FROM Filtered f LEFT JOIN LastDates ld ON f.BillDate = ld.BillDate						
			GROUP BY SHOPNAME,ItemCode,ItemName,AREA,AREA_LINE
			ORDER BY SHOPNAME,ItemCode,AREA_LINE;
END
ELSE IF @REPORTTYPE='BILLS2'  -- using for Direct Billing Lines. Bazar, Gate...
BEGIN
		;WITH LastDates AS (
			SELECT TOP 4 BillDate,
				   ROW_NUMBER() OVER (ORDER BY BillDate DESC) AS rn
			FROM Bhavani_ER_Bills WITH (NOLOCK)
			WHERE Area = @AREA AND BillDate < @BILLDATE 
			and SHOPNAME=(CASE WHEN @SHOPNAME = '' THEN SHOPNAME  ELSE @SHOPNAME END)
			GROUP BY BillDate ORDER BY BillDate DESC
		)
		--select * from LastDates
		SELECT f.ItemCode,f.ItemName,f.Area,f.Shopname,AREA_LINE,MAX(RATE) RATE,
			   ISNULL(SUM(CASE WHEN ld.rn = 1 THEN f.PACKETS END),0) AS PACKETS_Date1,
			   ISNULL(SUM(CASE WHEN ld.rn = 2 THEN f.PACKETS END),0) AS PACKETS_Date2,
			   ISNULL(SUM(CASE WHEN ld.rn = 3 THEN f.PACKETS END),0) AS PACKETS_Date3,
			   ISNULL(SUM(CASE WHEN ld.rn = 4 THEN f.PACKETS END),0) AS PACKETS_Date4
		FROM Bhavani_ER_Bills f WITH (NOLOCK)
		JOIN LastDates ld ON f.BillDate = ld.BillDate AND f.Area = @AREA --AND SHOPNAME = @SHOPNAME
		and f.SHOPNAME=(CASE WHEN @SHOPNAME = '' THEN SHOPNAME  ELSE @SHOPNAME END)
		GROUP BY f.ItemCode, f.ItemName, f.Area,f.Shopname,AREA_LINE
		ORDER BY f.ItemCode;

		--for billdates2
		--SELECT DISTINCT TOP 4 BillDate FROM Bhavani_ER_Bills WITH (NOLOCK) WHERE Area=@AREA AND BILLDATE<@BILLDATE ORDER BY BILLDATE DESC
		;WITH LastDates AS (
			SELECT DISTINCT BillDate FROM Bhavani_ER_Bills with (nolock) WHERE Area = @AREA   AND BillDate < @BILLDATE
			and SHOPNAME=(CASE WHEN @SHOPNAME = '' THEN SHOPNAME  ELSE @SHOPNAME END)
		),
		Ranked AS (
			SELECT BillDate, ROW_NUMBER() OVER (ORDER BY BillDate DESC) AS rn FROM LastDates
		),
		Numbers AS (
			SELECT 1 AS rn UNION ALL
			SELECT 2 UNION ALL
			SELECT 3 UNION ALL
			SELECT 4
		)
		SELECT 
		  n.rn, isnull(r.BillDate,'') BILLDATE,	@AREA AS LINE FROM Numbers n
		  LEFT JOIN Ranked r ON r.rn = n.rn 	ORDER BY n.rn;
END
ELSE if @REPORTTYPE='BILLDATES' 
begin
		--SELECT DISTINCT TOP 4 BILLDATE,AREA FROM BELL_LS WHERE AREA=@AREA and BillDate<@BILLDATE ORDER BY BILLDATE DESC
		;WITH LastDates AS (
			SELECT DISTINCT BillDate FROM Bell_LS with (nolock) WHERE Area = @AREA   AND BillDate < @BILLDATE
		),
		Ranked AS (
			SELECT BillDate, ROW_NUMBER() OVER (ORDER BY BillDate DESC) AS rn FROM LastDates
		),
		Numbers AS (
			SELECT 1 AS rn UNION ALL
			SELECT 2 UNION ALL
			SELECT 3 UNION ALL
			SELECT 4
		)
		SELECT 
		  n.rn, isnull(r.BillDate,'') BILLDATE,	@AREA AS LINE FROM Numbers n
		  LEFT JOIN Ranked r ON r.rn = n.rn 	ORDER BY n.rn;
end
ELSE if @REPORTTYPE='BILLDATES2'  -- using for Lines with Direct Billing from office. ex: Bazar, Gate...
begin
		--SELECT DISTINCT TOP 4 BILLDATE,AREA FROM BELL_LS WHERE AREA=@AREA and BillDate<@BILLDATE ORDER BY BILLDATE DESC
		;WITH LastDates AS (
			SELECT DISTINCT BillDate FROM Bhavani_ER_Bills with (nolock) WHERE Area = @AREA   AND BillDate < @BILLDATE
		),
		Ranked AS (
			SELECT BillDate, ROW_NUMBER() OVER (ORDER BY BillDate DESC) AS rn FROM LastDates
		),
		Numbers AS (
			SELECT 1 AS rn UNION ALL
			SELECT 2 UNION ALL
			SELECT 3 UNION ALL
			SELECT 4
		)
		SELECT 
		  n.rn, isnull(r.BillDate,'') BILLDATE,	@AREA AS LINE FROM Numbers n
		  LEFT JOIN Ranked r ON r.rn = n.rn 	ORDER BY n.rn;
end
ELSE if @REPORTTYPE='WITH_BILLDATE'  --not using for now, using separate table for column names with dates
BEGIN
		 SET NOCOUNT ON;

;WITH LastDates AS (
        SELECT BillDate,
               ROW_NUMBER() OVER (ORDER BY BillDate DESC) AS rn
        FROM (
            SELECT DISTINCT BillDate
            FROM Bell_LS WITH (NOLOCK)
            WHERE Area = @AREA
              AND BillDate < @BILLDATE
              AND USERNAME <> 'ORDERS'
        ) d
    )
    SELECT BillDate, rn
    INTO #Last4
    FROM LastDates
    WHERE rn <= 4;   -- only last 4 dates

    DECLARE @cols NVARCHAR(MAX) = '';
    DECLARE @sql NVARCHAR(MAX);

    -- Build column list with actual date suffix
    SELECT @cols = STRING_AGG(
        CAST(
            'MAX(CASE WHEN BillDate = ''' 
            + CONVERT(VARCHAR(10), BillDate, 120) 
            + ''' THEN T_B END) AS T_B_' 
            + FORMAT(BillDate, 'ddMMMyy') + ', ' +
            'MAX(CASE WHEN BillDate = ''' 
            + CONVERT(VARCHAR(10), BillDate, 120) 
            + ''' THEN R_B END) AS R_B_' 
            + FORMAT(BillDate, 'ddMMMyy')
        AS NVARCHAR(MAX))
    , ', ')
    FROM #Last4;

    -- Build final SQL
    SET @sql = '
    SELECT ItemCode, ItemName, Rate, ' + @cols + '
    FROM Bell_LS WITH (NOLOCK)
    WHERE Area = ''' + @AREA + '''
      AND BillDate IN (SELECT BillDate FROM #Last4)
      AND USERNAME <> ''ORDERS''
    GROUP BY ItemCode, ItemName, Rate
    ORDER BY ItemCode, ItemName;';

    print @sql
    EXEC sp_executesql @sql;
END
ELSE  -- using in VB6
BEGIN
		print  'else part using in VB6';
		WITH LastDates AS (
			SELECT BillDate,
				   ROW_NUMBER() OVER (ORDER BY BillDate DESC) AS rn
			FROM (SELECT DISTINCT BillDate FROM Bell_LS WITH (NOLOCK) WHERE Area=@AREA AND BILLDATE<@BILLDATE and USERNAME<>'ORDERS') d
		)
		, Filtered AS (
			SELECT ItemCode,ItemName, BillDate, T_B, R_B
			FROM Bell_LS WITH (NOLOCK)
			WHERE Area = @AREA
			  AND BillDate IN (SELECT BillDate FROM LastDates WHERE rn <= 4)
		)  
		--select * from Filtered order by Itemname
		SELECT 
			im.ItemCode,im.ItemName,max(im.Rate1) as Rate,LEFT(PACKINGTYPE, 1) + ' (' + CAST(TOTALITEMSINPACK AS VARCHAR(10)) + ')' AS PackType,
			ISNULL(MAX(TOTALITEMSINPACK),1) as TOTALITEMSINPACK,
			--isnull(MAX(LS.QTY),'') AS QTY, isnull(MAX(LS.T_B),'') AS T_B,isnull(max(LS.ID),'') AS ID,	

			--ISNULL(MAX(CASE WHEN ld.rn = 4 THEN f.T_B END),0) AS T_B_Date4,
			--ISNULL(MAX(CASE WHEN ld.rn = 4 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS R_B_Date4,
			--ISNULL(MAX(CASE WHEN ld.rn = 3 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS T_B_Date3,
			--ISNULL(MAX(CASE WHEN ld.rn = 3 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS R_B_Date3,
			--ISNULL(MAX(CASE WHEN ld.rn = 2 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS T_B_Date2,
			--ISNULL(MAX(CASE WHEN ld.rn = 2 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS R_B_Date2,
			--ISNULL(MAX(CASE WHEN ld.rn = 1 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS T_B_Date1,
			--ISNULL(MAX(CASE WHEN ld.rn = 1 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS R_B_Date1
			
			-- * here R_B_Date are Saled paks
			ISNULL(MAX(CASE WHEN ld.rn = 4 THEN f.T_B END),0) AS T_B_Date4,
			ISNULL(MAX(CASE WHEN ld.rn = 4 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS R_B_Date4,
			ISNULL(MAX(CASE WHEN ld.rn = 3 THEN f.T_B END),0) AS T_B_Date3,
			ISNULL(MAX(CASE WHEN ld.rn = 3 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS R_B_Date3,
			ISNULL(MAX(CASE WHEN ld.rn = 2 THEN f.T_B END),0) AS T_B_Date2,
			ISNULL(MAX(CASE WHEN ld.rn = 2 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS R_B_Date2,
			ISNULL(MAX(CASE WHEN ld.rn = 1 THEN f.T_B END),0) AS T_B_Date1,
			ISNULL(MAX(CASE WHEN ld.rn = 1 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS R_B_Date1
			FROM Bell_ItemMaster im WITH (NOLOCK)
			LEFT JOIN Filtered f ON im.ItemName = f.ItemName
			LEFT JOIN LastDates ld ON f.BillDate = ld.BillDate
			--LEFT JOIN (SELECT ITEMNAME, QTY, ID, T_B FROM BELL_LS_ORDERS WHERE Area=@AREA AND BILLDATE=@BILLDATE) AS LS  ON im.ITEMNAME=LS.ITEMNAME 
			Where im.STATUS='Active' and im.CATEGORY<>'RAW MATERIALS' --and f.BillDate is not null
			GROUP BY im.ItemName,im.ItemCode,PACKINGTYPE,TOTALITEMSINPACK
			ORDER BY im.ItemCode;
	END

END