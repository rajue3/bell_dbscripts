/*  TO GET LAST 4 ORDERS LIKE TOTAL PACKETS LOADED AND UNLOADED PACKETS
--SELECT   LEFT(PACKINGTYPE, 1) + ' (' + CAST(TOTALITEMSINPACK AS VARCHAR(10)) + ')' AS ItemType FROM Bell_ItemMaster;
SELECT * FROM BELL_LS_ORDERS WHERE Area = 'ADILABAD'
SELECT * FROM bell_ItemMaster

-- BELL_GET_PREVIOUS4_ORDERS 'NEKKONDA','2025-Dec-16'
-- BELL_GET_PREVIOUS4_ORDERS 'ADILABAD','2025-Dec-16'
*/
ALTER procedure Bell_Get_Previous4_Orders
@AREA as varchar(50),
@BILLDATE AS DATE
AS
BEGIN

WITH LastDates AS (
    SELECT BillDate,
           ROW_NUMBER() OVER (ORDER BY BillDate DESC) AS rn
    FROM (SELECT DISTINCT BillDate FROM Bell_LS WHERE Area = @AREA AND BILLDATE<@BILLDATE) d
)
, Filtered AS (
    SELECT ItemCode,ItemName, BillDate, T_B, R_B
    FROM Bell_LS
    WHERE Area = @AREA
      AND BillDate IN (SELECT BillDate FROM LastDates WHERE rn <= 4)
)  
--select * from Filtered order by Itemname
SELECT 
    im.ItemCode,im.ItemName,max(im.Rate1) as Rate,LEFT(PACKINGTYPE, 1) + ' (' + CAST(TOTALITEMSINPACK AS VARCHAR(10)) + ')' AS PackType,
	ISNULL(MAX(TOTALITEMSINPACK),1) as TOTALITEMSINPACK,	isnull(MAX(LS.QTY),'') AS QTY, isnull(MAX(LS.T_B),'') AS T_B,isnull(max(LS.ID),'') AS ID,	
    ISNULL(MAX(CASE WHEN ld.rn = 4 THEN f.T_B END),0) AS T_B_Date4,
    ISNULL(MAX(CASE WHEN ld.rn = 4 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS R_B_Date4,
    ISNULL(MAX(CASE WHEN ld.rn = 3 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS T_B_Date3,
    ISNULL(MAX(CASE WHEN ld.rn = 3 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS R_B_Date3,
    ISNULL(MAX(CASE WHEN ld.rn = 2 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS T_B_Date2,
    ISNULL(MAX(CASE WHEN ld.rn = 2 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS R_B_Date2,
    ISNULL(MAX(CASE WHEN ld.rn = 1 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS T_B_Date1,
    ISNULL(MAX(CASE WHEN ld.rn = 1 THEN (f.T_B-isnull(f.R_B,0)) END),0) AS R_B_Date1
FROM Bell_ItemMaster im
LEFT JOIN Filtered f ON im.ItemName = f.ItemName
LEFT JOIN LastDates ld ON f.BillDate = ld.BillDate
LEFT JOIN (SELECT ITEMNAME, QTY, ID, T_B FROM BELL_LS_ORDERS WHERE Area=@AREA AND BILLDATE=@BILLDATE) AS LS  ON im.ITEMNAME=LS.ITEMNAME 
Where im.STATUS='Active' and im.CATEGORY<>'RAW MATERIALS'
GROUP BY im.ItemName,im.ItemCode,PACKINGTYPE,TOTALITEMSINPACK
ORDER BY im.ItemCode;

END