-- USE BELLBRAND_ONLINEORDERS --not using.
USE ONLINEORDERS
SELECT 
    referencing_schema_name AS [Schema],
    referencing_entity_name AS [Dependent_Object],
    referencing_class_desc  AS [Object_Type]
FROM 
    sys.dm_sql_referencing_entities('dbo.BAZAR_ItemMaster', 'OBJECT');


SELECT * from BAZAR_ItemMaster ORDER BY SHOPNAME
SELECT * FROM BAZAR_ItemMaster WHERE SHOPNAME = 'BHAVANI' 
select * from BAZAR_ItemMaster where SHOPNAME='BHAVANI' AND STATUS='Active' order by itemcode
--select * into BAZAR_ItemMaster_16Sep from BAZAR_ItemMaster where SHOPNAME='BHAVANI' 
--UPDATE BAZAR_ItemMaster  SET stock_available=STOCK WHERE SHOPNAME = 'BHAVANI'  -- updated on 22-Sep @10:45PM

select * into BAZAR_ItemMaster_22Sep from BAZAR_ItemMaster WHERE SHOPNAME='BHAVANI' AND STATUS='Active' order by itemcode
select * into bazar_mobile_Bills_22Sep from bazar_mobile_Bills where area='Bhavani'

select a.itemcode,a.itemname,stock_available,a.stock stock,PAKS_IN=ISNULL((select sum(b.packets) from bhavani_ER_Bills B where A.Itemname=B.Itemname
AND B.BILLDATE='2026-09-23' and b.area='Bhavani' group by b.itemname,b.itemcode),0)
,PAKS_OUT=ISNULL((select sum(C.packets) from bazar_mobile_Bills C where A.Itemname=C.Itemname
AND C.BILLDATE='2026-09-23' and C.area='Bhavani' group by C.itemname,C.itemcode),0)
from BAZAR_ItemMaster A where a.shopname='Bhavani' order by a.itemcode

;with CTE as (
select a.itemcode,a.itemname, stock_available as INITIAL_STOCK, (a.stock - ISNULL((select sum(b.packets) from bhavani_ER_Bills B where A.Itemname=B.Itemname
AND B.BILLDATE>='2026-09-23' and b.area='Bhavani' group by b.itemname),0)
- ISNULL((select sum(b.OFFER_QTY) from bhavani_ER_Bills B where A.Itemname=B.OFFER_ITEM
AND B.BILLDATE>='2026-09-23' and b.area='Bhavani' group by b.OFFER_ITEM),0)
+ ISNULL((select ISNULL(sum(C.packets),0) from bazar_mobile_Bills C where A.Itemname=C.Itemname
AND C.BILLDATE>='2026-09-23' and C.area='Bhavani' group by C.itemname,C.itemcode),0) 
+ ISNULL((select ISNULL(sum(D.OFFER_QTY),0) from bazar_mobile_Bills D where A.Itemname=D.OFFER_ITEM
AND D.BILLDATE>='2026-09-23' and D.area='Bhavani' group by D.OFFER_ITEM),0) 
) AS CALCULATED_STOCK, A.stock AS ACTUAL_STOCK
from BAZAR_ItemMaster A where a.shopname='Bhavani' 
)  select * from CTE where INITIAL_STOCK <> CALCULATED_STOCK order by itemcode

;with CTE as (
select a.itemcode,a.itemname, stock_available as INITIAL_STOCK, (a.stock - ISNULL((select sum(b.packets) from bhavani_ER_Bills B where A.Itemname=B.Itemname
AND B.BILLDATE>='2026-09-23' and b.area='Bhavani' group by b.itemname),0)
- ISNULL((select sum(b.OFFER_QTY) from bhavani_ER_Bills B where A.Itemname=B.OFFER_ITEM
AND B.BILLDATE>='2026-09-23' and b.area='Bhavani' group by b.OFFER_ITEM),0)
+ ISNULL((select ISNULL(sum(C.packets),0) from bazar_mobile_Bills C where A.Itemname=C.Itemname
AND C.BILLDATE>='2026-09-23' and C.area='Bhavani' group by C.itemname,C.itemcode),0) 
+ ISNULL((select ISNULL(sum(D.OFFER_QTY),0) from bazar_mobile_Bills D where A.Itemname=D.OFFER_ITEM
AND D.BILLDATE>='2026-09-23' and D.area='Bhavani' group by D.OFFER_ITEM),0) 
) AS CALCULATED_STOCK, A.stock AS ACTUAL_STOCK
from BAZAR_ItemMaster A where a.shopname='Bhavani' 
)  select * from CTE where INITIAL_STOCK <> CALCULATED_STOCK order by itemcode
--OR
;with CTE as (
select a.itemcode,a.itemname, stock_available as INITIAL_STOCK, (a.stock_available + ISNULL((select sum(b.packets) from bhavani_ER_Bills B where A.Itemname=B.Itemname
AND B.BILLDATE>='2026-09-23' and b.area='Bhavani' group by b.itemname),0)
+ ISNULL((select sum(b.OFFER_QTY) from bhavani_ER_Bills B where A.Itemname=B.OFFER_ITEM
AND B.BILLDATE>='2026-09-23' and b.area='Bhavani' group by b.OFFER_ITEM),0)
- ISNULL((select ISNULL(sum(C.packets),0) from bazar_mobile_Bills C where A.Itemname=C.Itemname
AND C.BILLDATE>='2026-09-23' and C.area='Bhavani' group by C.itemname,C.itemcode),0) 
- ISNULL((select ISNULL(sum(D.OFFER_QTY),0) from bazar_mobile_Bills D where A.Itemname=D.OFFER_ITEM
AND D.BILLDATE>='2026-09-23' and D.area='Bhavani' group by D.OFFER_ITEM),0) 
) AS CALCULATED_STOCK, A.stock AS ACTUAL_STOCK
from BAZAR_ItemMaster A where a.shopname='Bhavani' 
)  select * from CTE where ACTUAL_STOCK <> CALCULATED_STOCK order by itemcode

Soya sticks 5 RS	    (57-65 = 8)
SEV MURMURA 5 RS	42 - 44 = 2
12 pics Chikky	224	- 256 = 32

5RS PARLE G	23	0
10RS GOOD DAY	87	53
10RS 5 STAR	0	40
5RS 5 STAR	0	54
--update BAZAR_ItemMaster set status='Active' where status='ACTIVE' 

SELECT * FROM BAZAR_ItemMaster WHERE SHOPNAME='BHAVANI' and offeravailable='Y'
SELECT * from bazar_mobile_Bills where area='Bhavani' AND BILLDATE>='2026-09-23' AND ITEMNAME in ('Soya sticks 5 RS','SEV MURMURA 5 RS','ROUND CHIKKY','12 pics Chikky','KRAZY KRAZY(CRAKER) 5 RS')
ORDER BY ITEMNAME
24 = 1 soya -> 3 offer
24= 1 sev mur -> 1 offer
10=1p 12pics chikky -> 12p offer
144=12p  12pics chikky -> 24p offer
28=1p Soya sticks -> 1 offer

SELECT * FROM BAZAR_ItemMaster WHERE SHOPNAME='BHAVANI' AND STOCK<0
select itemname, sum(packets) from bazar_mobile_Bills where area='Bhavani' AND BILLDATE='2026-09-23' 
group by itemname,itemcode order by itemcode

38

--bazar_mobile_Bills_21Sep26  
--delete from bazar_mobile_Bills where area='bhavani' AND BILLDATE='2026-09-23' and BILLID IN (4520,4519)

select * from bazar_mobile_Bills where area='bhavani' order by mobileorderdate desc
select * from bazar_mobile_Bills where area='bhavani' AND BILLDATE='2026-09-23' order by itemcode
select * from bhavani_ER_Bills where area='bhavani' AND itemname='TRUFFELLO (24P) 5RS'
select * from bhavani_ER_Bills where area='bhavani' AND itemname='Bhoondhi 325 GM' order by billdate desc

select * from BAZAR_ItemMaster_03Sep26 where stock <0 and shopname='Bhavani' 
--update BAZAR_ItemMaster set status='InActive' where itemname='FRUIT COOKIES 5RS'

--select * into BAZAR_ItemMaster_10Sep26 from BAZAR_ItemMaster  where SHOPNAME='BHAVANI' AND STATUS='Active'  -- till 6th Aug data after updating Stock again.
SELECT * FROM BAZAR_ItemMaster WHERE SHOPNAME='BHAVANI' and offeravailable='Y'
select * from BELL_LINE_WISE_OFFERS

select * from BAZAR_ItemMaster  where itemcode=2
SELECT * FROM BELL_ITEMMASTER where ITEMNAME LIKE '%rose %'
--select * from BELL_ITEMMASTER_11Sep26  
--update BELL_ITEMMASTER set status='InActive' where itemcode=2008

select * from BELL_ItemMaster where ITEMNAME='Bhoondhi 325 GM'
select * from BAZAR_ItemMaster where SHOPNAME ='bhavani' AND ITEMNAME='Bhoondhi 325 GM'
SELECT Stock,Stock_Available,* FROM BAZAR_ItemMaster where SHOPNAME='BHAVANI' order by itemcode
select * from BELL_ITEMMASTER where itemname='137'
select * from BELL_ITEMMASTER A 
where  CATEGORY<>'RAW MATERIALS' and category<>'SOAPS' and a.itemname not in (select itemname from BAZAR_ItemMaster where status='Active' and Shopname='Bhavani')
order by itemname;  -- a.status='Active' and

select * from BAZAR_ItemMaster A 
where Shopname='Bhavani' and a.itemname not in (select itemname from  BELL_ITEMMASTER where status='Active' and  category<>'RAW MATERIALS')
order by itemname

--update bhavani_ER_Bills set itemname='TRUFFELLO (24P) 5RS XX' where BILLDATE='2026-09-16' and billid=1160747
-- update bhavani_ER_Bills set itemname='Bhoondhi 325 GM' where billid=1158345
--delete from  bhavani_ER_Bills where itemname='Bhoondhi 325 GM' and BILLDATE='2026-09-16' and billid=1161291

select Stock,Stock_Available, * from BAZAR_ItemMaster where SHOPNAME='BHAVANI' and status='Active' order by itemcode

--update BAZAR_ItemMaster set Stock_Available=stock where shopname='Bhavani'
select * from bazar_mobile_Bills where area='bhavani' AND itemname='Bhoondhi 325 GM' order by billdate desc
select * from bazar_mobile_Bills where area='bhavani' AND itemname='TRUFFELLO (24P) 5RS' order by billdate desc
select * from BAZAR_ItemMaster  where shopname='bhavani' and stock <0

SELECT * FROM Bazar_Mobile_Bills where area='Bhavani'  and  itemname like '%gold%' order by billdate desc
SELECT * FROM Bazar_Mobile_Bills where area='Bhavani'  and billdate= '2026-09-15' and itemname like '%gold%' order by billnumber,itemname
--delete from Bazar_Mobile_Bills where area='Bhavani'  and billdate= '2026-09-10'and billnumber=1 and itemname='moong dal 5 RS'
SELECT * FROM Bazar_Mobile_Bills where area='Bhavani'  and billdate= '2026-09-08' order by itemname 
SELECT * FROM Bazar_Mobile_Bills where area='Bhavani' and billdate= '2026-09-07' ORDER BY ITEMNAME
SELECT sum(amount) FROM Bazar_Mobile_Bills where area='Bhavani' and billdate= '2026-09-10'
SELECT itemcode, itemname ,sum(packets) FROM Bazar_Mobile_Bills where area='Bhavani' and billdate= '2026-09-08'
group by itemname,itemcode ORDER BY itemname

SELECT * FROM BAZAR_ItemMaster where shopname='BHAVANI' --AND offeritemname='Bhoondi 5 RS'
and stock<0

SELECT * FROM BAZAR_ItemMaster where shopname='BHAVANI' and itemname like 'Round%'

SELECT * FROM BAZAR_ItemMaster  where stock<0  and shopname='BHAVANI'
select * from BAZAR_ItemMaster_18Sep26  -- (created at 10:30pm on 17th Sep)
select * from BAZAR_ItemMaster_17Sep order by itemcode
select * from BAZAR_ItemMaster_17Sep where stock<0

SELECT * FROM BAZAR_ItemMaster where SHOPNAME='BHAVANI' order by itemcode
SELECT * FROM BAZAR_CUST_MASTER 
--SELECT * INTO BAZAR_ItemMaster_24JUL26 FROM BAZAR_ItemMaster 

select * from Bazar_Mobile_Bills  order by actiondate desc
select * from Bazar_Mobile_Bills  order by billnumber,shopname

select * from DBO.BAZAR_DAMAGE_ITEMS;

SELECT itemcode, itemname ,sum(packets) FROM Bazar_Mobile_Bills where area='Bhavani' and billdate= '2026-09-07' 
group by itemname,itemcode ORDER BY itemname

--SELECT * into Bazar_Mobile_Bills_08Sep26 FROM Bazar_Mobile_Bills where area='Bhavani' 
SELECT * FROM Bazar_Mobile_Bills_08Sep26 where area='Bhavani' and billdate= '2026-09-05' ORDER BY itemcode
SELECT * FROM Bazar_Mobile_Bills where area='Bhavani' and billdate= '2026-09-05' ORDER BY itemcode

/*
UPDATE BAZAR_ItemMaster set offeravailable='Y', offeritemname='Soya sticks 5 RS',OfferPaks=24,Offer_Qty_Avail=1,details='OFFER:Soya sticks 5 RS (1) for 24P' where shopname='BHAVANI' AND itemcode=2 
UPDATE BAZAR_ItemMaster set offeravailable='Y', offeritemname='Soya sticks 5 RS',OfferPaks=24,Offer_Qty_Avail=1,details='OFFER:Soya sticks 5 RS (1) for 24P' where shopname='BHAVANI' AND itemname='Soya sticks 5 RS'
UPDATE BAZAR_ItemMaster set offeravailable='Y', offeritemname='SEV MURMURA 5 RS',OfferPaks=24,Offer_Qty_Avail=1,details='OFFER:SEV MURMURA 5 RS (1) for 24P' where shopname='BHAVANI' AND itemname='SEV MURMURA 5 RS'
UPDATE BAZAR_ItemMaster set offeravailable='Y', offeritemname='12 pics Chikky',OfferPaks=144,Offer_Qty_Avail=12,details='OFFER:12 pics Chikky (12) for 144P' where shopname='BHAVANI' AND itemname='12 pics Chikky'
UPDATE BAZAR_ItemMaster set offeravailable='Y', offeritemname='Soya sticks 5 RS',OfferPaks=28,Offer_Qty_Avail=1,details='OFFER : Soya sticks 5 RS (1)  for 28p' where shopname='BHAVANI' AND itemname='KRAZY KRAZY(CRAKER) 5 RS'
*/
/*
declare @ItemCode Int,@ITEM_SEQ Int
select @ItemCode=max(itemcode) from BELL_ITEMMASTER 
select @ITEM_SEQ=max(ITEM_SEQ) from BELL_ITEMMASTER 

insert into BELL_ITEMMASTER (
ITEMCODE,ItemName,Rate1,RATE2,RATE3,PACKINGTYPE,MRP,CATEGORY,TOTALITEMSINPACK,STATUS,STOCK,USERNAME,
MinOrderAlert,PRATE,Manufacture,OfferAvailable,DiscountPercent,OfferItemname,OfferPaks,DETAILS,ImageUrl	,ISMODIFIED,OFFER_QTY_AVAIL,ITEM_SEQ)

select @ItemCode+1,ItemName,Rate1,RATE2,RATE3,PACKINGTYPE,MRP,CATEGORY,TOTALITEMSINPACK,STATUS,1000,'Admin',
MinOrderAlert,PRATE,Manufacture,OfferAvailable,DiscountPercent,OfferItemname,OfferPaks,DETAILS,ImageUrl	,ISMODIFIED,OFFER_QTY_AVAIL,@ITEM_SEQ+1
from BAZAR_ItemMaster A
where Shopname='Bhavani' and a.itemname not in (select itemname from  BELL_ITEMMASTER where status='Active' and  category<>'RAW MATERIALS')
order by Itemcode

select * from BELL_ITEMMASTER where itemcode>=2013

;WITH ToUpdate AS (
  SELECT ItemID, ItemCode, Item_Seq,
         ROW_NUMBER() OVER (PARTITION BY ItemCode ORDER BY ItemID) AS rn
  FROM dbo.BELL_ITEMMASTER WHERE ItemCode = 2014
)
UPDATE t
SET ItemCode = ItemCode + (rn - 1), Item_Seq = Item_Seq + (rn - 1)
FROM ToUpdate t;
*/
--UPDATE BAZAR_ItemMaster SET Stock_Available=STOCK WHERE SHOPNAME='BHAVANI'   --UPDATED ON 10SEP26 @ 10:39pm
--*-- UPDATE BAZAR_ItemMaster SET STOCK=Stock_Available WHERE SHOPNAME='BHAVANI' AND ITEMCODE < 7

/*

SELECT o.salesman, o.line, o.mobile, o.shopname, o.billdate, o.BillAmount, o.totalamount, o.total_return_amount, o.billno, 
IFNULL(d.discountamount,0) as discountamount, o.paymentmode FROM 
(SELECT salesman, line, mobile, shopname, Date(billdate) as billdate, billno,SUM(sellingprice * IFNULL(qty,0)) as BillAmount,     
SUM(sellingprice * IFNULL(qty,0)) as totalamount,     SUM(IFNULL(ret_qty,0) * sellingprice) as total_return_amount,     paymentmode   FROM Orders   
WHERE 1=1  AND line = ?  AND DATE(billdate) = DATE(?)  GROUP BY salesman, shopname, billno, line, mobile, Date(billdate) ) o 
LEFT JOIN (   SELECT billno, line, shopname, Date(billdate) as billdate,discountamount   FROM Orders_Discounted  WHERE  line = ?  AND DATE(billdate) = DATE(?)  
GROUP BY billno, line, shopname,discountamount, Date(billdate) ) d ON o.billno = d.billno AND o.line = d.line AND o.shopname = d.shopname 
AND o.billdate = d.billdate ORDER BY o.billno

UPDATE BAZAR_ItemMaster SET RATE2_CONDITION=STOCK WHERE SHOPNAME='BHAVANI'   --FOR TESTING USING RATE2_CONDITION AS CURRENT STOCK on 6th Aug 26.

UPDATE A SET A.Stock = A.Stock - B.TotalPackets FROM BAZAR_ItemMaster A
INNER JOIN ( SELECT ITEMCODE,ITEMNAME, SUM(PACKETS) AS TotalPackets FROM Bazar_Mobile_Bills WHERE LINE='Bhavani' AND  BILLDATE >='2026-08-01'
    GROUP BY ITEMCODE,ITEMNAME ) B 
ON A.ItemCode = B.ITEMCODE and A.ITEMNAME=B.ITEMNAME WHERE A.SHOPNAME='BHAVANI';

UPDATE A SET A.Stock = A.Stock + B.TotalPackets FROM BAZAR_ItemMaster A
INNER JOIN ( SELECT ITEMCODE,ITEMNAME, SUM(PACKETS) AS TotalPackets FROM bhavani_ER_Bills WHERE AREA='Bhavani' AND  BILLDATE >='2026-08-01'
    GROUP BY ITEMCODE,ITEMNAME ) B 
ON A.ItemCode = B.ITEMCODE and A.ITEMNAME=B.ITEMNAME WHERE A.SHOPNAME='BHAVANI';
*/
-------
SELECT * FROM BAZAR_CUST_MASTER 
SELECT * FROM BAZAR_ItemMaster where ITEMCODE IN (2008,217,218,197,198,82,83)
SELECT * FROM BAZAR_ItemMaster  where STATUS='ACTIVE' AND shopname='BHAVANI' AND
ITEMNAME IN ('50GM KHARA BAG','ROSE WAFFER 5RS','NICE COVA PKT','NICE COVA JAR','DARK FILLS 5RS','MONSTER BITZ 5RS','WAFIX 5RS')

--ITEMS TO INSERT IN BHAVANI SHOP
--BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME
SELECT * FROM BAZAR_ItemMaster  WHERE shopname='BHAVANI' ORDER BY ITEMCODE
--SELECT * INTO BAZAR_ItemMaster_03Aug26 FROM BAZAR_ItemMaster WHERE shopname='BHAVANI'

--UPDATE BAZAR_ItemMaster SET DISCOUNTPERCENT=0 where DISCOUNTPERCENT is null
--UPDATE BAZAR_ItemMaster SET STOCK_AVAILABLE=STOCK WHERE shopname='BHAVANI'
--UPDATE BAZAR_ItemMaster   SET STATUS='INACTIVE' WHERE ITEMCODE=1000
SELECT * FROM BAZAR_ItemMaster WHERE shopname='BHAVANI' and ITEMNAME LIKE '%BOURBON%'
SELECT * FROM BAZAR_ItemMaster  where shopname='BHAVANI' and 
ITEMNAME IN ('50GM KHARA BAG',
'5RS PARLE G','5RS 5-STAR','ELACHI ÉCLAIR JAR','ROSE BOURBON') 

--'BELL FRUIT COOKIES 5RS' == 'FRUIT COOKIES 5RS'  --BELL MILK COOKIES 5RS = MILK COOKIES 5RS
--'5 RS MARIE GOLD' == '5 RS MARIE SUMO'
--'5RS MOMS MAGIC','10RS MOMS MAGIC'
DECLARE @ITEMCODE AS INT,@ITEMNAME AS VARCHAR(100)
SET @ITEMCODE = (SELECT MAX(ITEMCODE)+1 FROM BAZAR_ItemMaster  )
SELECT @ITEMCODE
SET @ITEMNAME='10 RS GOOD DAY'
--INSERT INTO BAZAR_ItemMaster (ITEMCODE,ITEMNAME,RATE1,RATE2,RATE3,PACKINGTYPE,MRP,CATEGORY,TOTALITEMSINPACK,STATUS,STOCK,USERNAME,SHOPNAME) 
--VALUES(@ITEMCODE,@ITEMNAME,10,10,10,'CARTON',100,'BISCUITES',96,'ACTIVE',12,'ADMIN','BHAVANI')


---EXISTING TO BE UPDATED
--'20RS DAIRY MILK','5RS MUNCH','5RS LAYS'
--,'5RS GOOD DAY','10RS MARIE GOLD','10RS GOOD DAY'
/*
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=29 WHERE ITEMNAME='5RS LAYS' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=19 WHERE ITEMNAME='5RS MUNCH' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=19 WHERE ITEMNAME='20RS DAIRY MILK' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=135 WHERE ITEMNAME='SPRITE 250ML' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=22 WHERE ITEMNAME='10RS MARIE GOLD' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=103 WHERE ITEMNAME='10RS GOOD DAY' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=22 WHERE ITEMNAME='MARIE SUMO 5 RS' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=1 WHERE ITEMNAME='5RS GOOD DAY' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=35 WHERE ITEMNAME='10RS MOMS MAGIC' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=3 WHERE ITEMNAME='5RS MOMS MAGIC' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=33 WHERE ITEMNAME='ROSE WAFER 1RS' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=3 WHERE ITEMNAME='ROSE WAFER 5RS' AND SHOPNAME='BHAVANI'

UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=9 WHERE ITEMNAME='FRUIT COOKIES 5RS' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=13 WHERE ITEMNAME='MILK COOKIES 5RS' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=288 WHERE ITEMNAME='RUSK 10RS' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=2 WHERE ITEMNAME='5RS HAPPY HAPPY' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=3 WHERE ITEMNAME='5RS PARLE G' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=10 WHERE ITEMNAME='10RS PARLE G' AND SHOPNAME='BHAVANI'

UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=2 WHERE ITEMNAME='MILKY STAR 5RS' AND SHOPNAME='BHAVANI'
UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=34 WHERE ITEMNAME='ELACHI ECLAIRS JAR 1/-' AND SHOPNAME='BHAVANI'

UPDATE BAZAR_ItemMaster SET ACTIONDATE=GETDATE(),STOCK=5 WHERE ITEMNAME='BOURBON5 RS' AND SHOPNAME='BHAVANI'
*/
--------------END OF NEW ITEMS TO INSERT
--UPDATE BAZAR_ItemMaster SET STOCK=0 WHERE shopname='BHAVANI' and stock<0
--UPDATE BAZAR_ItemMaster SET STOCK=13 WHERE ITEMCODE=125 AND SHOPNAME='BHAVANI'

--DELETE FROM Bazar_Mobile_Bills where billid < 194
 --DELETE FROM Bazar_Mobile_Bills where actiondate>'2026-07-15'
select distinct LINE,ShopName as CustomerName,Cust_Mobile as Mobile FROM Bazar_Mobile_Bills where ISNULL(SHOPNAME,'') <> '' AND LINE=@SHOPNAME
--inserting dummy values to Bazar_Mobile_Bills for getting Customer names and mobile in Bazar Mobile App

 -- UPDATE BAZAR_ItemMaster SET STOCK=1000 
 --update BAZAR_ItemMaster set offeravailable='N',Details='' where offeravailable='Y'
 --DELETE FROM BAZAR_ItemMaster where ITEMID=3558

select distinct shopname,cust_mobile from Bazar_Mobile_Bills  where Line='Bhavani'
 --SELECT * into Bazar_Mobile_Bills FROM bhavani_ER_Bills where 1=2

 /*
Below can be deleted 
USP_DELETE_ITEM


 --TO RESET AUTO INCREMENT COLUMN TO 0
 --DBCC CHECKIDENT ('Bazar_Mobile_Bills', RESEED, 1);


 /*
 insert into BAZAR_ItemMaster(ITEMCODE	,ItemName,Rate1	,RATE2,RATE3,PACKINGTYPE,MRP	,CATEGORY,TOTALITEMSINPACK,STATUS,ActionDate	,STOCK,USERNAME,MinOrderAlert,PRATE,Manufacture,
OfferAvailable,DiscountPercent	,OfferItemname,OfferPaks,DETAILS,ImageUrl,ISMODIFIED	,OFFER_QTY_AVAIL,	SHOPNAME,	RATE1_CONDITION,	RATE2_CONDITION,	RATE3_CONDITION,
DISCOUNT_CONDITION,	STOCK_AVAILABLE) 
 SELECT
ITEMCODE	,ItemName,Rate1	,RATE2,RATE3,PACKINGTYPE,MRP	,CATEGORY,TOTALITEMSINPACK,STATUS,ActionDate	,STOCK,USERNAME,MinOrderAlert,PRATE,Manufacture,
OfferAvailable,DiscountPercent	,OfferItemname,OfferPaks,DETAILS,ImageUrl,ISMODIFIED	,OFFER_QTY_AVAIL,	'GATE',	RATE1_CONDITION,	RATE2_CONDITION,	RATE3_CONDITION,
DISCOUNT_CONDITION,	STOCK_AVAILABLE
FROM BAZAR_ItemMaster where shopname='BAZAR'

insert into BAZAR_ItemMaster(ITEMCODE	,ItemName,Rate1	,RATE2,RATE3,PACKINGTYPE,MRP	,CATEGORY,TOTALITEMSINPACK,STATUS,ActionDate	,STOCK,USERNAME,MinOrderAlert,PRATE,Manufacture,
OfferAvailable,DiscountPercent	,OfferItemname,OfferPaks,DETAILS,ImageUrl,ISMODIFIED	,OFFER_QTY_AVAIL,	SHOPNAME,	RATE1_CONDITION,	RATE2_CONDITION,	RATE3_CONDITION,
DISCOUNT_CONDITION,	STOCK_AVAILABLE) 
 SELECT
ITEMCODE	,ItemName,Rate1	,RATE2,RATE3,PACKINGTYPE,MRP	,CATEGORY,TOTALITEMSINPACK,STATUS,ActionDate	,STOCK,USERNAME,MinOrderAlert,PRATE,Manufacture,
OfferAvailable,DiscountPercent	,OfferItemname,OfferPaks,DETAILS,ImageUrl,ISMODIFIED	,OFFER_QTY_AVAIL,	'BHAVANI',	RATE1_CONDITION,	RATE2_CONDITION,	RATE3_CONDITION,
DISCOUNT_CONDITION,	STOCK_AVAILABLE
FROM BAZAR_ItemMaster where shopname='BAZAR' AND STOCK>0 AND ACTIONDATE IS NULL ORDER BY ITEMNAME 
*/
 SELECT distinct Category FROM BAZAR_ItemMaster 
 SELECT * FROM BAZAR_ItemMaster where SHOPNAME='BHAVANI' and imageUrl='FUN_HERTZ_50NP.jpg'
 https://bellbrandbhavanikhara.in/bell_item_images/FUN_HERTZ_50NP.jpg
 --update BAZAR_ItemMaster set stock=1000,ActionDate=getdate(),username='admin',Manufacture='Trade',OfferAvailable='N' where stock is null
 SELECT * FROM BAZAR_ItemMaster where category='CHOCOLATES' 
 --UPDATE BAZAR_ItemMaster SET CATEGORY='CHOCOLATES' WHERE category='CHOCOLATE'

-- update BAZAR_ItemMaster set status='Active' where SHOPNAME='BHAVANI' AND status='Inactive'

 --RENAME COLUMN NAME
 --EXEC sp_rename 'Bazar_Mobile_Bills.AREA_LINE', 'LINE', 'COLUMN';
 --ALTER TABLE Bazar_Mobile_Bills ADD CUST_MOBILE VARCHAR(10)
 
 --REQUIRED THIS TABLE
CREATE TABLE BAZAR_CUST_MASTER
(ID INT IDENTITY(1,1) NOT NULL,LINE VARCHAR(50), AREA VARCHAR(50),CUSTOMERNAME VARCHAR(50),MOBILE VARCHAR(10),[STATUS] VARCHAR(10),ACTIONDATE DATETIME DEFAULT SYSDATETIME() )
SELECT * FROM BAZAR_CUST_MASTER 
--DELETE FROM  BAZAR_CUST_MASTER 

SELECT DESCRIPTION='OFFER : ' + OFFERITEMNAME + ' (' + CAST(OFFER_QTY_AVAIL AS VARCHAR) + ')  for ' + CAST(OFFERPAKS AS VARCHAR) + 'p'
FROM BAZAR_ItemMaster  WHERE OFFERAVAILABLE='Y' and isnull(offeritemname,'') <> ''
--update BAZAR_ItemMaster  set details='OFFER : ' + OFFERITEMNAME + ' (' + CAST(OFFER_QTY_AVAIL AS VARCHAR) + ')  for ' + CAST(OFFERPAKS AS VARCHAR) + 'p' WHERE 
--OFFERAVAILABLE='Y' and isnull(offeritemname,'') <> ''

SELECT distinct  shopname FROM BAZAR_ItemMaster  

BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 'FORMOBILE','BAZAR','ALL'
 USP_Update_ItemDetails_BAZAR
 
 SELECT * FROM BELL_USERS  where usertype='DIRECT SALES' 
 USP_VALIDATE_USER

 SELECT * FROM BELL_USERS WHERE USERTYPE IN ('OFFICE','VAN LOADING','VAN LOADING APPROVER','DIRECT SALES')
 SELECT DISTINCT FIRSTNAME,LASTNAME FROM BELL_USERS WHERE USERTYPE = 'DIRECT SALES'
 
 /*
 
 CREATE Procedure BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 
@OPTION1 as varchar(50) = NULL,  
@OPTION2 as varchar(50) = NULL  
AS               
BEGIN     
declare @ImageURL as varchar(50)    
 declare @RND as varchar(12)    
 select @RND = '?count=' + CONVERT(char,FLOOR(RAND()*(1000-5+1)+5)); -- will get random no. from 5 to 100. used to refresh images immediately    
 set @ImageURL = (Select top 1 FieldValue from tblAllMasterData with (nolock) where FieldType='Bell_ImageServerURL')    
    
  if @OPTION = 'FORMOBILE'  OR @OPTION = 'WEB'  
  BEGIN  
  END

END
insert into BELL_USERS (username,password,usertype,firstname,lastname,status,actiondate) 
 values('bellbrand','bellbrand','DIRECT SALES','BHAVANI','Test User','Active',getdate())

 insert into BELL_USERS (username,password,usertype,firstname,lastname,status,actiondate) 
 values('chander','bellbrand','DIRECT SALES','BAZAR','ADDRESS11','Active',getdate())
 
 insert into BELL_USERS (username,password,usertype,firstname,lastname,status,actiondate) 
 values('user1','bellbrand','DIRECT SALES','BHAVANI','ADDRESS11','Active',getdate())

 insert into BELL_USERS (username,password,usertype,firstname,lastname,status,actiondate) 
 values('gopal','bellbrand','DIRECT SALES','NEZAR','ADDRESS22','Active',getdate())
 */
