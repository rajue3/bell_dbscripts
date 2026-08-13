use onlineorders
go
--use bellbrand_dailycash
--use zionwellmark_bellbrand  -- (hosting home)
--use zionwellmark_onlineorders -- (hosting home)
go
select ID,LINE,AREA,SHOPNAME,CUSTOMERNAME,MOBILE,IsForDirectSales,GroupName,Category,ISNULL(AREA_SEQ,0) AREA_SEQ,ISNULL(SHOP_SEQ,0) SHOP_SEQ from Bell_Cust_Master Where Status='Active' and Line='ADILABAD' 

SELECT * FROM BELL_APP_SHOPS_VISIT_INFO with (nolock) where  line='BAZAR DIRECT SALES' AND orderdate='2026-05-08'
select * from BELL_CUST_MASTER where IsShopPhotoRequired='Y'
--update BELL_CUST_MASTER set ISSHOPPHOTOREQUIRED='Y' where Line='GATE' 
--alter TABLE BELL_APP_SHOPS_VISIT_INFO add SHOP_VISIT_PHOTO_NAME VARCHAR(100)

--SELECT TRANSLATE(testString, ': ', '__') FROM your_table;
--System.Text.RegularExpressions.Regex.Replace(testString, @"[:\s]", "_")

select * from BELL_CUST_MASTER where LINE LIKE 'BAZAR DIRECT SALES%'
select * from BELL_CUST_MASTER where line LIKE 'PEDDAPALLY%'  
select * from BELL_CUST_MASTER where line ='SULTHANABAD'  AND AREA='BHOJANNAPET'
--update BELL_CUST_MASTER set ACTIONDATE=GETDATE(),AREA_SEQ=7,AREA='PEDDAPALLY' WHERE  line ='SULTHANABAD'  AND AREA='SULTHANABAD'
--update BELL_CUST_MASTER set ACTIONDATE=GETDATE(),AREA_SEQ=8,AREA='PEDDAPALLY' WHERE  line ='SULTHANABAD'  AND AREA='BHOJANNAPET'
--update BELL_CUST_MASTER set ACTIONDATE=GETDATE(),LINE='PEDDAPALLY',AREA='SULTHANABAD' WHERE  line ='SULTHANABAD' AND AREA_SEQ=7
--update BELL_CUST_MASTER set ACTIONDATE=GETDATE(),LINE='PEDDAPALLY',AREA='BHOJANNAPET' WHERE  line ='SULTHANABAD'  AND AREA_SEQ=8

select * from BELL_CUST_MASTER where area like '%jul%'
select * from BELL_CUST_MASTER where Line='Bazar direct sales' order by actiondate desc
--update BELL_CUST_MASTER set AREA='BAZAR' WHERE AREA LIKE '0%'
--delete from BELL_CUST_MASTER where Status='DELETED'
--delete from BELL_CUST_MASTER where Status='DELETE_DUPLICATE'
--select * INTO BELL_CUST_MASTER_23Jul26 from BELL_CUST_MASTER 

--alter table BELL_CUST_MASTER alter column IsForDirectSales Varchar(15)
--alter table BELL_CUST_MASTER add IsShopPhotoRequired Varchar(10)
--update BELL_CUST_MASTER set IsShopPhotoRequired='N' where Line='ASIFABAD' 

select * from bhavani_ER_Bills where area='BHADRACHALAM' AND BILLDATE='2026-08-06' order by actiondate desc


select * from bhavani_ER_Bills where area='BHAVANI' order by actiondate desc
select * from bhavani_ER_Bills where area='GATE' AND BILLDATE='2026-08-03' order by actiondate desc
select * from bhavani_ER_Bills where area='NEZAR' AND BILLDATE='2026-08-03' order by actiondate desc

select * from bhavani_ER_Bills where area='BHAVANI' AND BILLDATE='2026-08-01' order by actiondate desc
select * from bhavani_ER_Bills where area LIKE 'BAZAR DIRECT SALES%' AND BILLDATE='2026-08-06' order by actiondate desc

SELECT ITEMNAME,LINE FROM BELL_LINE_WISE_OFFERS
SELECT * FROM BELL_ITEMMASTER where ITEMCODE IN (2009) AND STATUS='ACTIVE'
SELECT * FROM BELL_ITEMMASTER where STATUS='ACTIVE' AND 
ITEMNAME IN ('50GM KHARA BAG','ROSE WAFFER 5RS','NICE COVA PKT','NICE COVA JAR','DARK FILLS 5RS','MONSTER BITZ 5RS','WAFIX 5RS')

SELECT * FROM BELL_ITEMMASTER WHERE ITEMcode=2013
--update BELL_ITEMMASTER set itemname='SOANPAPIDI 5RS',Status='Active',actiondate=getdate(),rate1=175,rate2=175,totalitemsinpack=8,mrp=250,prate=200 where itemid=844
SELECT * FROM BELL_ITEMMASTER WHERE ITEMNAME like '%soanp%'
--SELECT * into BELL_ITEMMASTER_27Jul FROM BELL_ITEMMASTER
SELECT * FROM bazar_ITEMMASTER WHERE ITEMNAME like '%milk%'

SELECT * FROM BELL_ITEMMASTER WHERE rate1 is null
Bell_APP_GET_ALL_ITEMS_TEST '2026-07-13','SIDDIPET', 'ALL_ITEM_ORDERS_SHOPS'
Bell_APP_GET_ALL_ITEMS_TEST '2026-06-12','BHUPALPALLY', 'ALL_ITEM_ORDERS_SHOPS'

BELL_UPD_ITEMS_SEQUENCE_JSON
BELL_INC_UPD_MASTER_ITEMS
BELL_STOCK_DETAILS

select * from bhavani_ER_Bills WITH (NOLOCK) where area='BAZAR' and billdate='2026-08-01' order by billnumber DESC
select billnumber,sum(amount) from bhavani_ER_Bills WITH (NOLOCK) where area='venkatapuram' and billdate='2026-07-17' 
group by billnumber

select sum(amount) from bhavani_ER_Bills WITH (NOLOCK) where area='venkatapuram' and billdate='2026-07-17' 

SELECT * FROM BELL_LINE_WISE_OFFERS

--INSERT INTO BELL_LINE_WISE_OFFERS (LINE,ITEMNAME) VALUES('SIDDIPET','KOPIKO')

CREATE TABLE BELL_LINE_WISE_OFFERS
(ID INT IDENTITY(1,1) NOT NULL,LINE VARCHAR(50), ITEMNAME VARCHAR(50),ACTIONDATE DATETIME DEFAULT SYSDATETIME() )

-- ALTER TABLE BELL_ItemMaster ADD ITEM_SEQ INT DEFAULT 0
--UPDATE BELL_ItemMaster SET ITEM_SEQ=ITEMCODE 

-- to rename a column
--EXEC sp_rename 'bhavani_ER_Bills.Column_Old', 'bhavani_ER_Bills.Column_New', 'COLUMN'

-- to rename table.
-- EXEC SP_RENAME 'table_source' ,'table_destination'

---to get list of all tables
SELECT table_name FROM information_schema.tables WHERE table_type = 'BASE TABLE';

--to get list of all SP names
SELECT name AS ProcedureName FROM sys.objects WHERE type = 'P' ORDER BY name;

  SELECT DISTINCT   sp.name AS ProcedureName
    --, sm.definition AS ProcedureDefinition
    FROM sys.sql_modules sm INNER JOIN sys.objects sp  ON sm.object_id = sp.object_id WHERE sp.type = 'P'  -- P = SQL Stored Procedure
  --AND sm.definition = 'Bell_TEMP_REPORT';
  AND sm.definition LIKE '%zion_%';
  
--* creatd index on 09-Jun-26 to improve previous orders SP performance.
--	CREATE INDEX IX_Bills_Area_BillDate ON Bhavani_ER_Bills (Area, BillDate) INCLUDE (ItemCode, ItemName, Packets);
--select * INTO BELL_ITEMMASTER_04JUL26  FROM BELL_ITEMMASTER WHERE STATUS='ACTIVE'
select * into BELL_ITEMMASTER24Jul FROM BELL_ITEMMASTER 
select * FROM BELL_ITEMMASTER_04JUL26
select * FROM BELL_ITEMMASTER where rate1 is null or rate1 = 0.00
select * FROM BELL_ITEMMASTER WHERE  itemname  like '%ROSE MILK%'
select * FROM BELL_ITEMMASTER WHERE  itemname  IN ('SALTINO 5RS','TAMATO KETCHUP 1RS','CAKE TIME 5RS','TWERK 5RS','ROUND CHIKKY')
select * FROM BELL_ITEMMASTER WHERE  itemname  IN ('CRUNCHY ECLAIR 1RS','BLUE ECLAIR 1RS')
select * FROM BELL_ITEMMASTER WHERE  itemname  like 'round c%'
--delete from BELL_ITEMMASTER where itemid=2999
select * FROM BELL_ITEMMASTER WHERE  item_seq =0

select * FROM BELL_ITEMMASTER WHERE  status<>'Active' 
--delete FROM BELL_ITEMMASTER WHERE  status<>'Active' and itemcode is null
select * from Bell_LS_ORDERS WHERE BILLDATE='2026-07-27' AND AREA='KAMAREDDY' ORDER BY ITEMNAME
select * from Bell_LS WHERE  BILLDATE='2026-07-27'  AND AREA='KAMAREDDY' ORDER BY ITEMNAME
select * from Bell_LS WHERE  USERNAME='ORDERS' ORDER BY BILLDATE DESC
--delete from Bell_LS WHERE  BILLDATE='2026-07-27'  AND AREA='KAMAREDDY' and itemname='SALTINO 5RS'

SALTINO 5RS
TAMATO KETCHUP 1RS
CAKE TIME 5RS
TWERK 5RS

--update BELL_ITEMMASTER  set Rate1=135,rate2=135 where itemid=2998

select * from BAZAR_ItemMaster where SHOPNAME='BHAVANI' AND STATUS='Active' 
select * from BAZAR_ItemMaster where SHOPNAME='BHAVANI' and itemname like '%cova%'
update BAZAR_ItemMaster set ItemName='5RS Pala Cova',PACKINGTYPE='BOX',username='ADMIN',TotalItemsInPack=12,stock=312,
RATE1=3.5,RATE2=4,RATE3=5,stock_available=312,sTATUS='Active' where SHOPNAME='BHAVANI' and itemid=3107

select * FROM BELL_ITEMMASTER WHERE STATUS='Active' and category <> 'RAW MATERIALS'
SELECT * FROM BELL_ITEMMASTER WHERE itemname like '%cova%'
--DELETE FROM BELL_ITEMMASTER WHERE ITEMCODE=2013
SELECT * FROM Bazar_Mobile_Bills ORDER BY ACTIONDATE DESC
--update BELL_ITEMMASTER set Rate1=Rate3 where rate1 is null
select * from BELL_CUST_MASTER ORDER BY ACTIONDATE DESC
MERGE BELL_ITEMMASTER AS T
USING (select ITEMCODE,ITEMNAME,RATE1,RATE2,RATE3 from BAZAR_ItemMaster where SHOPNAME='BHAVANI' AND STATUS='Active' ) AS S
ON T.ITEMCODE=S.ITEMCODE AND T.ITEMNAME=S.ITEMNAME
WHEN MATCHED THEN
UPDATE SET T.RATE1=S.RATE1,T.RATE2=S.RATE2,T.RATE3=S.RATE3;

--UPDATE BELL_ITEMMASTER SET ITEMCODE=(SELECT ITEMCODE FROM BELL_ITEMMASTER_04JUL26 WHERE 
--itemcode > 159 AND ITEMCODE<303  AND BELL_ITEMMASTER.ITEMID=BELL_ITEMMASTER_04JUL26.ITEMID )
--WHERE itemcode > 159 AND ITEMCODE<303 

select * from bhavani_ER_Bills where area IN ('BAZAR','NEZAR','GATE','BHAVANI') and billdate='2026-07-31' 
select * from BELL_LS where AREA LIKE 'BAZAR%'  and billdate='2026-07-31' 
select * from BELL_LS where AREA LIKE 'BAZAR%'  
select * from bhavani_ER_Bills where AREA LIKE 'BELLAMPALLY%'  and billdate='2026-07-29' 
select area_line,shopname,billnumber from bhavani_ER_Bills where AREA LIKE 'BELLAMPALLY%'  and billdate='2026-07-29' 
group by area_line,shopname,billnumber

SELECT ID,ISNULL(AREA_SEQ,0) AS AREA_SEQ,ISNULL(SHOP_SEQ,0) AS SHOP_SEQ,LINE,AREA,SHOPNAME,CUSTOMERNAME,SALESMAN,MOBILE,STATUS,IsForDirectSales,GROUPNAME,CATEGORY FROM Bell_Cust_Master WHERE 1=1  AND STATUS='DELETED'  

select * from BELL_CUST_MASTER where line='MARIPEDA' order by customername
--update BELL_CUST_MASTER set status='Deleted' where shopname in ('RAMESH SM(MRPD)','PANDI[MRPD]') and  line='MARIPEDA'
select * from BELL_CUST_MASTER where shopname not in (
select shopname from bhavani_ER_Bills where AREA ='BELLAMPALLY'  and billdate='2026-07-29' 
group by area_line,shopname,billnumber )
and line ='BELLAMPALLY'  

VIJAYA DURGA(BPL)THNDUR)
VARALAXMI K/M(BPL)TANDUR)
VARALAXMI (BPL)TANDUR)
OM SRI SHARADHA K/M(BPL)TANDUR)
SRI SHARADHA K/M(BPL)TANDUR)
VINAYAKA TRADERS (BPL)(TDR)

select * from bhavani_ER_Bills where AREA LIKE 'BELLAMPALLY%'  and billdate='2026-07-21' 
select * from bhavani_ER_Bills where AREA = 'BHADRACHALAM'  and billdate='2026-07-30' 
select * from BELL_CUST_MASTER where line='BELLAMPALLY' ORDER BY area_seq,shop_seq

select * from bhavani_ER_Bills where area='BAZAR' and billdate='2026-07-31' 
select * from Bell_LS where area='SIDDIPET' and billdate='2026-07-13'  ORDER BY ITEMCODE
select * from Bell_LS_ORDERS  where area='SIDDIPET' and billdate='2026-07-13'  ORDER BY ITEMCODE
select count(1) from Bell_LS_ORDERS  with (nolock) where billdate<'2026-05-01'
--delete from Bell_LS_ORDERS  where billdate<'2026-05-01'
select count(1) from Bell_LS_ORDERS  with (nolock) where billdate>='2026-05-01'

select * from bhavani_ER_Bills where salesman='gopal' and area='bazar'
--delete from bhavani_ER_Bills where salesman='gopal' and area='bazar'

select * FROM BELL_ITEMMASTER where status='Active' and category<>'raw materials' order by itemcode
select * from Bell_LS where AREA='GAJWEL' AND BILLDATE='2026-07-17' AND itemname  like 'N%'

select * FROM BELL_ITEMMASTER WHERE  itemname  IN ('CHIKKY BOX','PEANUT CHIIKI','TAMATO KETCHUP 1RS')

select * FROM BELL_ITEMMASTER WHERE  itemname  IN ('FUNCONE','CREMONA','RAZY CUP','KIDDY MUNCH','DURBUN','PARTY ROLLS','PARTY STIX')
select * FROM BELL_ITEMMASTER WHERE  itemcode > 159 AND ITEMCODE<303 AND STATUS='ACTIVE'
select * FROM BELL_ITEMMASTER WHERE  itemcode > 6000
select * FROM BELL_ITEMMASTER WHERE  STATUS='ACTIVE' order by itemcode

select * FROM BELL_ITEMMASTER WHERE  itemname like '12%'         -- OFFER ITEM 12 pics Chikky
select * FROM BELL_ITEMMASTER WHERE  itemname like '%soan%'  -- OFFER ITEM 12 pics Chikky
select * FROM BELL_ITEMMASTER WHERE  itemname = 'OFFER ITEM 12 pics Chikky' 
--UPDATE BELL_ITEMMASTER SET PACKINGTYPE='KATTA',TOTALITEMSINPACK=10,ACTIONDATE=GETDATE() WHERE ITEMID=618
--Prev values: TRAY / 140
select * FROM BELL_ITEMMASTER WHERE CATEGORY IN ('CHOCOLATES','WAFFERS','CAKES','ECLAIRS') AND STATUS='ACTIVE'
AND itemcode NOT in (125,140,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,178,181,183,184,186,188,189,
190,201,203,204,205,206,207,209,214,215,250,251,252,253,254,301,302)

select * FROM BELL_ITEMMASTER WHERE  itemcode in (125,140,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,178,181,183,184,186,188,189,
190,201,203,204,205,206,207,209,214,215,250,251,252,253,254,301,302) AND STATUS='ACTIVE' ORDER BY ITEMCODE

select * FROM BELL_ITEMMASTER WHERE category IN ('CHOCOLATES','WAFFERS') AND STATUS='ACTIVE' ORDER BY ITEMCODE
select * FROM BELL_ITEMMASTER WHERE itemname like  '12 %' AND STATUS='ACTIVE' ORDER BY ITEMCODE

SELECT * FROM Bell_LS WITH (NOLOCK) where AREA ='NEKKONDA' AND BILLDATE='2026-07-03'  order by itemNAME

--DELETE FROM Bell_LS  where AREA ='GODAVARI' AND BILLDATE='2026-06-18' AND USERNAME='ORDERS'   
SELECT * FROM Bell_LS where billdate>='2026-07-01' and itemname like '%12 pics Chikky%'
order by billdate

SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where AREA ='GODAVARI' AND BILLDATE='2026-06-18' order by itemcode
select * from bhavani_ER_Bills WITH (NOLOCK) where area='BAZAR DIRECT SALES' and billdate='2026-07-31' and actiondate >= '2026-08-07' order by billnumber DESC
--DELETE FROM bhavani_ER_Bills where area='BAZAR DIRECT SALES' and billdate='2026-07-31' and actiondate >= '2026-08-07'

SELECT * FROM Bell_Cust_Master Where status='Active' and line='CHENNURU' AND SHOPNAME LIKE 'RAJANNA%'
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO with (nolock) where  line='BAZAR DIRECT SALES' AND orderdate='2026-05-08'
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO with (nolock) order by orderdate desc

SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where AREA ='CHENNURU' AND BILLDATE='2026-07-07' order by itemNAME
SELECT * FROM Bell_LS WITH (NOLOCK) where AREA ='CHENNURU' AND BILLDATE='2026-07-07' order by ACTIONDATE DESC
SELECT * FROM Bell_LS WITH (NOLOCK) where AREA ='CHENNURU' AND BILLDATE='2026-07-07' AND USERNAME='ORDERS'

select * FROM BELL_ITEMMASTER order by itemNAME
--update BELL_ITEMMASTER set rate1=142.00, MRP=200.00,TOTALITEMSINPACK=6 WHERE ITEMCODE=217

SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where AREA ='NEKKONDA' AND BILLDATE='2026-06-19' order by itemNAME
SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where AREA ='gajwel' AND BILLDATE='2026-06-26'
SELECT * FROM Bell_LS WITH (NOLOCK) where AREA ='gajwel' AND BILLDATE='2026-06-26' ORDER BY ITEMCODE
select * FROM BELL_ITEMMASTER where ITEMCODE=217

SELECT * FROM Bell_LS WITH (NOLOCK) where AREA ='BAZAR DIRECT SALES' AND BILLDATE='2026-08-06'
SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where AREA ='BAZAR DIRECT SALES' AND BILLDATE='2026-08-06'
SELECT * FROM bhavani_ER_Bills WITH (NOLOCK) where AREA ='BAZAR' AND BILLDATE='2026-06-26' AND USERNAME<>'PRIYANKA'
--UPDATE bhavani_ER_Bills SET AREA='BAZAR DIRECT SALES' where AREA ='BAZAR' AND BILLDATE='2026-06-26' AND USERNAME='PRIYANKA'
SELECT * FROM Bell_Cust_Master Where status='Active' and line='BAZAR DIRECT SALES' AND SHOPNAME LIKE 'RAJANNA%'
--INSERT INTO Bell_Cust_Master (CUSTID,AREA,SHOPNAME,CUSTOMERNAME,MOBILE,SALESMAN,ACTIONDATE,LANDMARK,LAT,LNG,STATUS,LINE,USERNAME,IsForDirectSales,GROUPNAME,CATEGORY,AREA_SEQ,SHOP_SEQ)
--VALUES(-1,'ENAMAMULA MARKET','BALAJI K/M (ENUMAMULA)','BALAJI','111111111','PRIYANKA',GETDATE(),'RAJANNA BAZAR','','','ACTIVE','BAZAR DIRECT SALES','PRIYANKA','YES','','',0,0)
SELECT * FROM Bell_Cust_Master Where Line='Medak' and area='DUBBAKA'
SELECT * FROM Bell_Cust_Master Where Line='SIDDIPET' and area='DUBBAKA'
--Update Bell_Cust_Master set LINE='SIDDIPET',aCTIONdATE=GETDATE() Where Line='Medak' and area='DUBBAKA'


SELECT COUNT(1) FROM Bell_LS WITH (NOLOCK)  --354802

SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where AREA ='NEKKONDA' AND BILLDATE='2026-06-19'
and itemname in ('NOU STAR JAR 5RS','COCOUNTMAGIC- 50NP','DURBAN 5RS','ELACHI ECLAIRS JAR 1/-','FRUITO POP JAR 5RS','RUSK 5RS','WHITE RABIT 
1RS') order by itemname

select * FROM BELL_ITEMMASTER where itemname in ('NOU STAR JAR 5RS','COCOUNTMAGIC- 50NP','DURBAN 5RS','ELACHI ECLAIRS JAR 1/-','FRUITO POP JAR 5RS','RUSK 5RS','WHITE RABIT 
1RS') order by itemname
select * FROM BELL_ITEMMASTER where itemname like '%rusk%'
--update BELL_ITEMMASTER set itemname='RUSK JAR 5RS' where itemcode=138

SELECT *  FROM Bell_Cust_Master _24JUL26
SELECT *  FROM Bell_Cust_Master Where line='ETURNAGARAM' AND AREA IN ('PASRA','ATHMAKUR','MALAMPALLY')
select * FROM Bell_Cust_Master Where STATUS='DELETED'
--DELETE FROM Bell_Cust_Master Where STATUS='DELETED'  -- need to delete.
SELECT * FROM Bell_Cust_Master Where line='MULUGU' AND AREA LIKE '%MAL%'
--UPDATE Bell_Cust_Master SET LINE='MULUGU' WHERE line='ETURNAGARAM' AND AREA IN ('PASRA','ATHMAKUR','MALAMPALLY')
SELECT *  FROM Bell_Cust_Master Where line='BHADRACHALAM' AND AREA IN ('MALLUR','RAJUPETA','JANAMPETA','ILAPURAM','EDULA BAYYARAM','SETAMPETA','KARKAGUDA')
AND STATUS='ACTIVE' ORDER BY AREA
SELECT * FROM Bell_Cust_Master Where line='BHADRACHALAM' AND AREA LIKE '%SET%'
-- UPDATE Bell_Cust_Master SET LINE='ETURNAGARAM' WHERE line='BHADRACHALAM' AND AREA IN ('MALLUR','RAJUPETA','JANAMPETA','ILAPURAM','EDULA BAYYARAM','SETAMPETA','KARKAGUDA') AND STATUS='ACTIVE'

SELECT * FROM Bell_Cust_Master Where line='bazar' order by actiondate desc 
SELECT * FROM Bell_Cust_Master Where line='bazar' and shopname like 'soma%'

SELECT BILLDATE,AREA,WEBSYNCED,USERNAME  FROM Bell_LS_ORDERS WITH (NOLOCK) WHERE WEBSYNCED IS NOT NULL 
GROUP BY BILLDATE,AREA,WEBSYNCED,USERNAME ORDER BY BILLDATE DESC
SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) WHERE WEBSYNCED LIKE '%From_Mobile%' AND BILLDATE='2026-06-04' AND AREA=''
--DELETE FROM Bell_LS_ORDERS WHERE  AREA=''
SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) WHERE AREA=''
--UPDATE bhavani_ER_Bills SET billdate='2026-06-09' where area='KOTHAGUDEM' and billdate='2026-06-08'
SELECT BILLDATE,AREA,WEBSYNCED,USERNAME  FROM Bell_LS_ORDERS WITH (NOLOCK) 
WHERE WEBSYNCED LIKE '%Mobile%'
GROUP BY BILLDATE,AREA,WEBSYNCED,USERNAME ORDER BY BILLDATE DESC

Bell_Get_Previous4_Orders_New
Bell_APP_GET_ALL_ITEMS
sp_helptext BELL_GET_All_Items
BELL_UPDATE_LS_RETURN_ITEMS_MOBILE_JSON
USP_VALIDATE_USER
SELECT * FROM BELL_USERS  

SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where area='MARIPEDA' AND billdate='2026-05-04' ORDER BY ITEMCODE
SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where area='MARIPEDA' AND billdate='2026-05-18' ORDER BY ITEMCODE
SELECT * FROM Bell_LS WITH (NOLOCK) where area='MARIPEDA' AND billdate='2026-05-18' ORDER BY ITEMCODE

SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where area='KAMAREDDY' AND billdate='2026-06-04' ORDER BY ITEMCODE
SELECT * FROM Bell_LS WITH (NOLOCK) where area='KAMAREDDY' AND billdate='2026-06-04' ORDER BY ITEMCODE
SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where WEBSYNCED LIKE '%MOBILE%' ORDER BY BILLDATE DESC

SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where area='HANAMKONDA' AND billdate='2026-06-07' ORDER BY ITEMCODE
SELECT * FROM Bell_LS WITH (NOLOCK) where area='HANAMKONDA' AND billdate='2026-06-07' ORDER BY ITEMCODE
--UPDATE Bell_LS_ORDERS SET WEBSYNCED='PENDING' where area='HANAMKONDA' AND billdate='2026-06-07' 
--delete from Bell_LS_ORDERS where id in (94664,94665)

SELECT * FROM Bell_Cust_Master Where status='Active' and line='KAMAREDDY'
SELECT * FROM Bell_Cust_Master Where LIne like 'Item %'
--update Bell_Cust_Master set IsForDirectSales='YES' where Line='ITEM SALE IN FACTORY'

--UPDATE Bell_Cust_Master SET line='BHAVANI',AREA='BHAVANI' Where status='Active' and line='BHAVANI '

select * from Bell_ItemMaster where itemcode=68
--** using WEBSYNCED for storing Status of the Order... like uploaded / pending / approved /
-- Once approved, it should move order details to LS table 

--DELETE FROM Bell_LS_ORDERS where area='MARIPEDA' AND billdate='2026-05-18' AND WEBSYNCED='From_Mobile'
--SELECT * into Bell_LS_ORDERS_18May_Maripeda FROM Bell_LS_ORDERS where area='MARIPEDA' AND billdate='2026-05-18'

--ALTER TABLE Bell_LS_ORDERS ALTER COLUMN WEBSYNCED VARCHAR(15)

--USE CUSTID AS SHOP SEQUENCE NO. AND NEW COL AREA_SEQ FOR AREA SEQUENCE.
ALTER TABLE Bell_Cust_Master ADD AREA_SEQ INT DEFAULT 0
ALTER TABLE Bell_Cust_Master ADD SHOP_SEQ INT DEFAULT 0

SELECT distinct Line FROM Bell_Cust_Master Where status='Active' and isnull(area_seq,0) = 0
SELECT * FROM Bell_Cust_Master Where status='Active' and isnull(area_seq,0) = 0
SELECT * FROM Bell_Cust_Master Where status='Active' and isnull(shop_seq,0) = 0

SELECT * FROM Bell_Cust_Master Where status='Active' and LINE='HANAMKONDA' AND AREA='BHEEMARAM'
and orderdate='2026-05-28' 
SELECT * FROM Bell_Cust_Master Where status='Active' and LINE='KHAGAZNAGAR' and area='KHAGAZNAGAR' order by shop_seq
shopname='MUKESH SURESH(SKZR)'
--update Bell_Cust_Master set area_seq=2,shop_seq=52 Where status='Active' and LINE='KHAGAZNAGAR' and shopname='MUKESH SURESH(SKZR)'

--UPDATE Bell_Cust_Master SET AREA_SEQ=9,SHOP_SEQ=1 WHERE status='Active' and LINE='MAHABUBABAD' AND AREA='KAMBALAPALLY' AND SHOPNAME='VENKANNA S/M(MHBD)(KBPY)'
--UPDATE T1
--SET T1.AREA_SEQ = T2.AREA_SEQ,,T1.SHOP_SEQ = T2.SHOP_SEQ
--FROM Bell_Cust_Master T1
--INNER JOIN (SELECT * FROM Bell_Cust_Master Where status='Active' and LINE='BAYYARAM' ) T2
--    ON T1.AREA = T2.AREA AND T1.SHOPNAME=T2.SHOPNAME
--WHERE T1.status='Active'  AND T1.LINE='MAHABUBABAD';

SELECT * FROM Bell_Cust_Master Where status='Active' and LINE='BAYYARAM' ORDER BY AREA
--SELECT * INTO Bell_Cust_Master28May26 FROM Bell_Cust_Master Where status='Active' 

              select  isnull(CONVERT(varchar,ORDERDATE,6),'01 Jan 01') as BILLDATE, A.AREA,A.SHOPNAME, 
              dbo.GetTimeDiff(BILLING_START_DATE,BILLING_END_DATE,SHOP_VISIT_STATUS) AS TIME_TAKEN,A.AREA_SEQ,A.SHOP_SEQ           
              from  Bell_Cust_Master A WITH (NOLOCK)  
              LEFT JOIN BELL_APP_SHOPS_VISIT_INFO B WITH (NOLOCK) ON A.LINE=B.LINE AND A.AREA=B.AREA AND A.SHOPNAME=B.SHOPNAME
            and (B.ORDERDATE BETWEEN CONVERT(nvarchar(10),'2026-05-14',101) AND CONVERT(nvarchar(10),'2026-05-14' ,101))   
              WHERE A.LINE='BAYYARAM' and A.STATUS='Active'
             
                      select CONVERT(varchar,ORDERDATE,6) as BILLDATE, A.AREA,A.SHOPNAME, 
                  dbo.GetTimeDiff(BILLING_START_DATE,BILLING_END_DATE,SHOP_VISIT_STATUS) AS TIME_TAKEN,A.AREA_SEQ,A.SHOP_SEQ           
                  from  Bell_Cust_Master A WITH (NOLOCK)  
                  LEFT JOIN BELL_APP_SHOPS_VISIT_INFO B WITH (NOLOCK) ON A.LINE=B.LINE AND A.AREA=B.AREA AND A.SHOPNAME=B.SHOPNAME
                  and (B.ORDERDATE BETWEEN CONVERT(nvarchar(10),'2026-05-14',101) AND CONVERT(nvarchar(10),'2026-05-14' ,101))  
                  and B.SHOP_VISIT_STATUS<>'BILLED' 
                  WHERE A.LINE='BAYYARAM' and A.STATUS='Active'

SELECT LEFT(ShopName, 30) AS ShopName FROM Bell_Cust_Master Where status='Active' and LINE='ETURNAGARAM' order by area_seq,area,shop_seq

SELECT   Area, COUNT(DISTINCT ShopName) AS ShopCount FROM Bell_Cust_Master
GROUP BY Area ORDER BY Area;
SELECT COUNT(DISTINCT Area)     AS TotalAreas, COUNT(DISTINCT ShopName) AS TotalShops FROM Bell_Cust_Master where Line='BELLAMPALLY';


SELECT * FROM Bell_Cust_Master Where status='Active' and LINE='KOTHAGUDA' order by area
SELECT * FROM Bell_Cust_Master Where LINE='KHAMMAM (LOCAL)' order by area
--and area='ZAFFARGADH'
SELECT * FROM Bell_Cust_Master Where line='BELLAMPALLY' and area='TANDUR' and shopname like 'Raviteja%'

select ID,LINE,AREA,SHOPNAME,CUSTOMERNAME,MOBILE,IsForDirectSales,GroupName,Category,ISNULL(AREA_SEQ,0) AREA_SEQ,ISNULL(SHOP_SEQ,0) SHOP_SEQ  FROM Bell_Cust_Master Where mobile='7396646862'

 & RS("ID") & ",'" & RS("LINE") & "','" & RS("Area") & "','" & RS("ShopName") & "','" & RS("CustomerName") & "','" & RS("Mobile") & "','Active','" & RS("IsForDirectSales") & "','" & RS("GroupName") & "','" & RS("Category") & "'," & RS("Area_Seq") & "," & RS("Shop_Seq") & ")"

SELECT * FROM Bell_Cust_Master Where mobile='7396646862'

SELECT * FROM Bell_Cust_Master Where LINE = 'GODAVARIKHANI AND MANTHINI'
GAFERGADH  Z
GOLLAPALL
ALERU

use zionwellmark_temp
go
BELL_INC_UPD_Bills_NEW_MOBILE_JSON
BELL_INC_UPD_Bills_NEW_MOBILE_working

select * from Bell_ItemMaster 
SELECT DESCRIPTION='OFFER : ' + OFFERITEMNAME + ' (' + CAST(OFFER_QTY_AVAIL AS VARCHAR) + ')  for ' + CAST(OFFERPAKS AS VARCHAR) + 'p'
FROM BELL_ITEMMASTER WHERE OFFERAVAILABLE='Y' and isnull(offeritemname,'') <> ''

SELECT  DISTINCT LINE,ORDERDATE FROM BELL_APP_SHOPS_VISIT_INFO with (nolock) ORDER BY line,ORDERDATE DESC
SELECT  DISTINCT LINE FROM BELL_APP_SHOPS_VISIT_INFO with (nolock) ORDER BY ORDERDATE DESC

select * FROM BELL_ITEMMASTER WHERE  itemname like 'Fruito%'
--DELETE FROM BELL_ITEMMASTER  WHERE ITEMID=2978
--update BELL_ITEMMASTER set status='Active' where itemname='FRUITO POP BAG 1RS'

select * FROM BELL_ITEMMASTER WHERE OFFERAVAILABLE='N' and details<>''
select * FROM BELL_ITEMMASTER WHERE OFFERAVAILABLE='N' and OFFERITEMNAME<>''
--update BELL_ITEMMASTER set OFFERITEMNAME='', offerPaks=0,Details='', offer_qty_avail=0 where OFFERAVAILABLE='N' and details<>''

select * from Bell_Cust_Master where line LIKE '%laxetpeta%' and status='Active' --36
--UPDATE Bell_Cust_Master SET USERNAME='FROM MAHABUBABAD' where line LIKE '%BAYYARAM%' and status='Active' AND USERNAME='FROM BAYYARAM'
select * from Bell_Cust_Master where line LIKE '%MAHABUBABAD%' and status='active' --34
--select * into Bell_Cust_Master_12May26 from Bell_Cust_Master
/*
insert into  Bell_Cust_Master(CustID,Line,Area,ShopName,CustomerName,Mobile,SalesMan,Status,UserName,IsForDirectSales,GroupName,Category,ActionDate)
select  CustID,'BAYYARAM',Area,ShopName,CustomerName,Mobile,SalesMan,Status,'KING',IsForDirectSales,GroupName,Category,getdate() from Bell_Cust_Master where line='MAHABUBABAD' and status='Active'

insert into  Bell_Cust_Master(CustID,Line,Area,ShopName,CustomerName,Mobile,SalesMan,Status,UserName,IsForDirectSales,GroupName,Category,ActionDate)
select  CustID,'MAHABUBABAD',Area,ShopName,CustomerName,Mobile,SalesMan,Status,'FROM BAYYARAM',IsForDirectSales,GroupName,Category,getdate() from Bell_Cust_Master where line='BAYYARAM' and status='Active' AND USERNAME<>'KING'
*/
select * from Bell_Cust_Master where isfordirectsales not in ('YES','NO' )
select * from Bell_Cust_Master where isfordirectsales='YES'
select distinct LINE, isfordirectsales,STATUS from Bell_Cust_Master where isfordirectsales = 'YES'
select * from Bell_Cust_Master where isfordirectsales = 'YES' and line='bazar'

--select * into Bell_Cust_Master_19May26 from Bell_Cust_Master where status='Active'
update Bell_Cust_Master set AREA_SEQ=1, SHOP_SEQ=1,ACTIONDATE=GETDATE() WHERE LINE='' AND AREA='' AND SHOPNAME=''

----
SELECT distinct line FROM Bell_Cust_Master order by LINE
SELECT * FROM Bell_Cust_Master WHERE STATUS='Active' and LINE='Asifabad' order by area_seq,area,shop_seq
--delete FROM Bell_Cust_Master WHERE STATUS='Active' and LINE='Asifabad' and mobile='8008013207'
select * FROM Bell_Cust_Master WHERE STATUS='Active' and LINE='Asifabad' and mobile='8008013207'

SELECT distinct mobile  FROM Bell_Cust_Master WHERE STATUS='Active' and LINE='Asifabad' 

AND CUSTOMERNAME LIKE 'SATHISH%'
SELECT * FROM Bell_Cust_Master WHERE LINE='DHARMAPURI' AND AREA in ('CHOPPADANDI','RAGAMPET' ,'DHARMARAM')
AND MOBILE='8341111524'

=CONCAT("update Bell_Cust_Master set ACTIONDATE=GETDATE() ,AREA_SEQ=",E3,", SHOP_SEQ=",A3," WHERE LINE='BELLAMPALLY' AND AREA='",D3,"' AND (SHOPNAME  LIKE '",B3,"%' OR CUSTOMERNAME='",C3,"' ) AND MOBILE='",F3,"' ")

=CONCAT("update Bell_Cust_Master set ACTIONDATE=GETDATE() ,AREA_SEQ=",E3,", SHOP_SEQ=",A3," WHERE LINE='DHARMAPURI' AND AREA='",D3,"' AND (SHOPNAME  LIKE '",B3,"%' OR CUSTOMERNAME='",C3,"' ) AND MOBILE='",F3,"' ")

=CONCAT("update Bell_Cust_Master set ACTIONDATE=GETDATE() ,AREA_SEQ=",E3," WHERE LINE='DHARMAPURI' AND AREA='",D3,"' ")

=CONCAT("update Bell_Cust_Master set ACTIONDATE=GETDATE() ,AREA_SEQ=",E3,", SHOP_SEQ=",A3," WHERE LINE='CHENNURU' AND AREA='",D3,"' AND (SHOPNAME  LIKE '",B3,"%' OR CUSTOMERNAME='",C3,"' ) AND MOBILE like '",F3,"%' ")
=CONCAT("update Bell_Cust_Master set ACTIONDATE=GETDATE() ,AREA_SEQ=",E3," WHERE LINE='CHENNURU' AND AREA='",D3,"' ")


=CONCAT("update Bell_Cust_Master set ACTIONDATE=GETDATE() ,AREA_SEQ=",E3,", SHOP_SEQ=",A3," WHERE LINE='ASIFABAD' AND AREA='",D3,"' AND (SHOPNAME  LIKE '",B3,"%' OR CUSTOMERNAME='",C3,"' ) AND MOBILE like '",F3,"%' ")

=CONCAT("update Bell_Cust_Master set ACTIONDATE=GETDATE() ,AREA_SEQ=",E3,", SHOP_SEQ=",A3," WHERE LINE='BAYYARAM' AND AREA='",D3,"' AND (SHOPNAME  LIKE '",B3,"%' OR CUSTOMERNAME='",C3,"' ) AND MOBILE like '",F3,"%' ")

=CONCAT("update Bell_Cust_Master set ACTIONDATE=GETDATE() ,AREA_SEQ=",E3,", SHOP_SEQ=",A3," WHERE LINE='BHADRACHALAM' AND AREA='",D3,"' AND (SHOPNAME  LIKE '",B3,"%' OR CUSTOMERNAME='",C3,"' ) AND MOBILE like '",F3,"%' ")

=CONCAT("update Bell_Cust_Master set ACTIONDATE=GETDATE() ,AREA_SEQ=",E3,", SHOP_SEQ=",A3," WHERE LINE='BELLAMPALLY' AND AREA='",D3,"' AND (SHOPNAME  LIKE '",B3,"%' OR CUSTOMERNAME='",C3,"' ) AND MOBILE like '",F3,"%' ")

=CONCAT("update Bell_Cust_Master set ACTIONDATE=GETDATE() ,AREA_SEQ=",E3,", SHOP_SEQ=",A3," WHERE LINE='BHUPALPALLY' AND AREA='",D3,"' AND (SHOPNAME  LIKE '",B3,"%' OR CUSTOMERNAME='",C3,"' ) AND MOBILE like '",F3,"%' ")

=CONCAT("update Bell_Cust_Master set ACTIONDATE=GETDATE() ,AREA_SEQ=",E3,", SHOP_SEQ=",A3," WHERE LINE='CHASTHISGARH' AND AREA='",D3,"' AND (SHOPNAME  LIKE '",B3,"%' OR CUSTOMERNAME='",C3,"' ) AND MOBILE like '",F3,"%' ")

=CONCAT("update Bell_Cust_Master set ACTIONDATE=GETDATE() ,AREA_SEQ=",E3,", SHOP_SEQ=",A3," WHERE LINE='ETURNAGARAM' AND AREA='",D3,"' AND (SHOPNAME  LIKE '",B3,"%' OR CUSTOMERNAME='",C3,"' ) AND MOBILE like '",F3,"%' ")

--update Bell_Cust_Master set  isfordirectsales='NO' where line='YELLANDU' and isfordirectsales='N'

 select * from Bell_ItemMaster where isnull(offeritemname,'') <> ''
 select * from Bell_ItemMaster order by itemcode
 select * from Bell_ItemMaster where discountpercent =1
 select * from Bell_ItemMaster where itemname like 'APPLE POP 10/-%'
 --update Bell_ItemMaster set discountpercent=0 where discountpercent =1
 -- SUN RICE MARIE5 RS

-- DROP TABLE  BELL_APP_SHOPS_VISIT_INFO
--CREATE TABLE BELL_APP_SHOPS_VISIT_INFO
--(ID INT IDENTITY(1,1) NOT NULL,SALESMAN VARCHAR(30),LINE varchar(50),AREA varchar(50),
--SHOPNAME varchar(100),SHOP_VISIT_STATUS VARCHAR(50),ORDERDATE DATETIME,
--BILLING_START_DATE  DATETIME2 DEFAULT GETDATE(),
--BILLING_END_DATE  DATETIME2 DEFAULT GETDATE(),ACTIONDATE DATETIME DEFAULT SYSDATETIME() )

-- BELL_UPSERT_MOBILE_SHOP_VISITING_INFO

BELL_UPDATE_LS_RETURN_ITEMS_MOBILE_JSON

 Bell_APP_GET_ALL_ITEMS '2026-04-28','janagam', 'FORMOBILE_ALL'
 Bell_APP_GET_ALL_ITEMS '2026-03-31','GHANPUR', 'FORMOBILE_ALL'
 BELL_INC_UPD_MASTER_ITEMS
 USP_GET_AREALIST

 select * from Bell_ItemMaster where isnull(offeritemname,'') <> ''
 select * from Bell_ItemMaster where  discountpercent=1
 select * from Bell_ItemMaster   where itemname like 'FRUITO POP BAG 1RS'
 --update Bell_ItemMaster  set status='Active'  where itemname like 'FRUITO POP BAG 1RS'

select * from bhavani_ER_Bills where BILLDATE='2026-05-23' and area='Bellampally'  
select * from bhavani_ER_Bills where  area='Bellampally'   order by billdate desc

SELECT * FROM BELL_APP_SHOPS_VISIT_INFO with (nolock) where  line='KOTHAGUDA' AND orderdate='2026-05-04'

select * from bhavani_ER_Bills where area='laxepeta'
BELL_UPDATE_LS_RETURN_ITEMS_MOBILE_JSON
SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where area='MARIPEDA' AND billdate='2026-05-25' ORDER BY ITEMCODE
--UPDATE Bell_LS_ORDERS SET BILLDATE='2026-05-25',ACTIONDATE=GETDATE() where area='MARIPEDA' AND billdate='2026-05-19' 

--UPDATE Bell_LS_ORDERS SET BILLDATE='2026-05-21',ACTIONDATE=GETDATE() where area='GODAVARI' AND billdate='2026-05-18' 
order by billdate desc
SELECT * FROM Bell_LS WITH (NOLOCK) where Area='laxepeta' and billdate='2026-05-12'

--UPDATE LS_ORDERS SET USERNAME='ORDERS', QTY='0.555555555555556C (18)', T_B=10 WHERE ID=186 AND AREA ='MADIKONDA' AND BILLDATE=#20-May-2026# 

SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where WEBSYNCED='FROM_MOBILE' AND AREA ='MADIKONDA' AND BILLDATE='20-May-2026'
order by actiondate desc
SELECT distinct area,billdate FROM Bell_LS_ORDERS WITH (NOLOCK) where WEBSYNCED='FROM_MOBILE'  order by billdate desc

SELECT * FROM Bell_LS where area='KORUTLA' and billdate='2026-Apr-30' order by actiondate

SELECT * FROM Bell_LS WITH (NOLOCK) where AREA ='KOTHAGUDEM' AND BILLDATE='2026-06-09' order by itemcode
SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where AREA ='KOTHAGUDEM' AND BILLDATE='2026-06-09' order by itemcode
select * from bhavani_ER_Bills WITH (NOLOCK) where area='KOTHAGUDEM' and billdate='2026-06-09'
--UPDATE bhavani_ER_Bills SET billdate='2026-06-09' where area='KOTHAGUDEM' and billdate='2026-06-08'

 select * from bhavani_ER_Bills where area='KORUTLA' and billdate='2026-04-30' and discount = 0 
		and billnumber not in (select billnumber from bhavani_ER_Bills where area='KORUTLA' and billdate='2026-04-30' and discount > 0 
		group by Billnumber,Area Having sum(amount) >=5000	)

 --UPDATE bhavani_ER_Bills SET DISCOUNT=0 where area='KORUTLA' and billdate='2026-04-30' and discount > 0 
	--	and billnumber not in (
	--	select billnumber from bhavani_ER_Bills where area='KORUTLA' and billdate='2026-04-30' and discount > 0 
	--	group by Billnumber,Area Having sum(amount) >=5000	)

select * from bhavani_ER_Bills where isnull(payment_mode,'') <> ''
--select * INTO  bhavani_ER_Bills_13APR26 from bhavani_ER_Bills where username like 'From_Mobile' and area='HUZURABAD'
ALTER TABLE TBLCUSTOMERS ADD AREA_SEQ NUMBER, SHOP_SEQ NUMBER
select * from bhavani_ER_Bills where BILLDATE='2026-06-04' and area='GODAVARI' 
update bhavani_ER_Bills set BILLDATE='2026-06-04' where BILLDATE='2026-06-05' and area='GODAVARI'  
select * from bhavani_ER_Bills where area='HUZURABAD' AND BILLDATE='2026-05-02' AND SHOPNAME='P.K.S (HZ.BAD)' ORDER BY ITEMNAME
select * from bELL_LS where area='HUZURABAD' AND BILLDATE='2026-05-02'
select SUM(RATE* (T_B-R_B-D_B)) from bELL_LS where area='HUZURABAD' AND BILLDATE='2026-05-02'

SELECT ITEMNAME,SUM(PACKETS*RATE) AS AMOUNT1 FROM bhavani_ER_Bills
WHERE BILLDATE='2026-05-02' AND AREA='HUZURABAD'  GROUP BY ITEMNAME,ITEMCODE,RATE ORDER BY ITEMCODE
SELECT SUM(PACKETS) AS QTY,SUM(PACKETS*RATE) AS AMOUNT1 FROM  bhavani_ER_Bills
WHERE BILLDATE='2026-05-02' AND AREA='HUZURABAD'



SELECT  RATE, (T_B-R_B-D_B) as SAL_PACKS,(T_B-R_B-D_B)*RATE as SAL_VALUE from BELL_LS WHERE 
BILLDATE = '2026-05-02' AND AREA='HUZURABAD'

SELECT  sum ((T_B-R_B-D_B)*RATE) as Amount from BELL_LS WHERE 
BILLDATE = '2026-05-02' AND AREA='HUZURABAD'
69265-470 = 68795
68778
17

select SUM(RATE*PACKETS) from bhavani_ER_Bills where area='HUZURABAD' AND BILLDATE='2026-05-02'

select * from bhavani_ER_Bills with (nolock) where area='Suryapeta' AND BILLDATE='2026-05-09'  order by itemname

select * from bhavani_ER_Bills where area='Mulugu' AND BILLDATE='2026-04-30' order by billnumber,itemname
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO where  line='Mulugu' AND orderdate='2026-04-30'

select * from bhavani_ER_Bills where area='Madikonda' AND BILLDATE='2026-04-29'  --error

select * from bhavani_ER_Bills where area='Yellandu' AND BILLDATE='2026-05-02'  --it uploaded succesfully from View My Orders  
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO where  line='Yellandu' AND orderdate='2026-05-02'

select * from bhavani_ER_Bills where area='Siricilla' AND BILLDATE='2026-05-09'  -- not copied but if did directly from sql 
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO where  line='Siricilla' AND orderdate='2026-05-01' -- copied

select * from bhavani_ER_Bills where area='HUZURABAD' AND BILLDATE='2026-05-02'  -- not copied but if did directly from sql
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO where  line='HUZURABAD' AND orderdate='2026-05-02' --  done from view my orders
SELECT * FROM Bell_LS where area='Madikonda' and billdate='2026-Apr-29' order by actiondate

select * from bhavani_ER_Bills with (nolock) where area='Sulthanabad' AND BILLDATE='2026-04-28'
--update bhavani_ER_Bills set BILLDATE='2026-04-28' where area='Sulthanabad' AND BILLDATE='2026-04-29'
select * from bhavani_ER_Bills where area='Husnabad' order by actiondate desc
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO where  line='Husnabad' AND orderdate='2026-04-27'
select * from bhavani_ER_Bills where area='Yellareddypeta' AND BILLDATE='2026-04-21'
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO order by actiondate desc, line

--DELETE FROM bhavani_ER_Bills where username like 'From_Mobile' and area='HUZURABAD' AND SHOPNAME='P.K.S (HZ.BAD)'  AND BILLID IN ()


select * from bhavani_ER_Bills where area='PARKAL' and billdate='2026-Apr-08'  and offer_item='OFFER ITEM THUMUS- UP 250 ML'
select * from bhavani_ER_Bills where area='PARKAL' and billdate='2026-Apr-08'  and itemname='THUMUS- UP 250 ML'
select * from bhavani_ER_Bills where area='PARKAL' and billdate='2026-Apr-08'  and itemname like '%thum%'
SELECT * FROM Bell_LS where area='PARKAL' and billdate='2026-Apr-08' order by actiondate
SELECT * FROM Bell_LS_ORDERS where area='PARKAL' and billdate='2026-Apr-08' order by actiondate
SELECT * FROM Bell_LS_ORDERS WITH (NOLOCK) where WEBSYNCED='FROM_MOBILE' order by actiondate desc

select itemname, sum(packets) packets,billdate from bhavani_ER_Bills WITH (NOLOCK) where area='Jangaon' and billdate>'2026-Apr-06' and billdate<='2026-Apr-30'
and itemname like 'moon%'
group by itemname,billdate
and shopname like 'Narend%'

SELECT * FROM bhavani_ER_Bills where area='eturnagaram'  and billdate='2026-Apr-17'  order by actiondate desc
SELECT * FROM bhavani_ER_Bills where area='SIRICILLA'  order by actiondate desc
SELECT * FROM bhavani_ER_Bills where area='HUZURABAD' and billdate='2026-Apr-17' order by actiondate
--DELETE FROM bhavani_ER_Bills where area='HUZURABAD' and billdate='2026-Apr-17' 
SELECT * FROM bhavani_ER_Bills where area='SIRICILLA' and billdate='2026-Apr-19' order by billnumber
--update bhavani_ER_Bills set billdate='2026-Apr-17' where area='SIRICILLA' and billdate='2026-Apr-19' 

SELECT * FROM bhavani_ER_Bills where area='HUZURABAD' and username='From_Mobile' and billdate='2026-Apr-19' order by actiondate
SELECT * FROM bhavani_ER_Bills where area='HUZURABAD' and username='From_Mobile'  and payment_mode='Online' and billdate='2026-Apr-17' 
SELECT * FROM bhavani_ER_Bills where area='HUZURABAD' and username='From_Mobile' and cast(actiondate as Date)='2026-Apr-23'
--delete from bhavani_ER_Bills where area='HUZURABAD' and username='From_Mobile' and billdate='2026-Apr-30' and cast(actiondate as Date)='2026-Apr-23'
select * from Bell_LS where BILLDATE='' AND AREA=''
SELECT * FROM bhavani_ER_Bills where area='HUZURABAD' and billdate='2026-Apr-30' order by actiondate  --test

SELECT * FROM bhavani_ER_Bills where area='HUZURABAD' and billdate='2026-Apr-25' order by BILLNUMBER
SELECT DISTINCT BILLNUMBER FROM bhavani_ER_Bills where area='HUZURABAD' and billdate='2026-Apr-25' order by BILLNUMBER
-- DELETE FROM bhavani_ER_Bills where area='HUZURABAD' and billdate='2026-Apr-30'  AND PAYMENT_MODE='Online'

SELECT * FROM bhavani_ER_Bills where area='Ghanpur' and billdate='2026-05-01' order by actiondate
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO where Line='Ghanpur' and orderdate='2026-May-01' order by actiondate
SELECT * FROM Bell_LS_ORDERS where area='HUZURABAD' and billdate='2026-04-30' order by actiondate
SELECT * FROM Bell_LS where area='HUZURABAD' and billdate='2026-Apr-25' order by actiondate

SELECT * FROM bhavani_ER_Bills where area='Nekkonda' and billdate='2026-May-01' order by actiondate
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO  where line='Nekkonda' and cast(orderdate as date)='2026-05-01' ORDER BY SHOPNAME

--delete from bhavani_ER_Bills where area='Ghanpur' and billdate='2026-Apr-30'

SELECT * FROM BELL_APP_SHOPS_VISIT_INFO  where line='HANAMKONDA' and cast(orderdate as date)='2026-04-18' ORDER BY SHOPNAME
SELECT * FROM Bell_LS_ORDERS where area='HUZURABAD' and billdate='2026-Apr-30' order by actiondate
-- delete FROM Bell_LS_ORDERS where area='HUZURABAD' and billdate='2026-Apr-30'
--ALTER TABLE Bell_LS_ORDERS ALTER COLUMN ACTIONDATE DATETIME  -- NOT UPDATED

SELECT * FROM Bell_LS_ORDERS where area='thorrur' and billdate='2026-Apr-30' order by actiondate
delete from Bell_LS_ORDERS where area='thorrur' and billdate='2026-Apr-30' 
SELECT * FROM Bell_LS_ORDERS where area='KOTHAGUDA' and billdate='2026-Apr-21' order by actiondate
SELECT * FROM Bell_LS where area='KOTHAGUDA' and billdate='2026-Apr-21' order by actiondate
SELECT * FROM Bell_LS where area='HUSNABAD' and billdate='2026-Apr-21' order by actiondate
--UPDATE Bell_LS SET billdate='2026-Apr-20' Where area='HUSNABAD' and billdate='2026-Apr-21'
--UPDATE Bell_LS SET billdate='2026-Apr-20' Where area='KOTHAGUDA' and billdate='2026-Apr-21'

-- UPDATE Bell_LS_ORDERS SET billdate='2026-Apr-20' Where area='HUSNABAD' and billdate='2026-Apr-21'
-- UPDATE Bell_LS_ORDERS SET billdate='2026-Apr-20' Where area='KOTHAGUDA' and billdate='2026-Apr-21'

husnabad
kotaguda
21 to 20
SELECT * FROM Bell_LS_ORDERS where area='siricilla' and billdate='2026-Apr-17' order by actiondate
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO  where line='siricilla' and cast(orderdate as date)='2026-04-17' ORDER BY SHOPNAME
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO  where line='PARKAL' and cast(orderdate as date)='2026-04-08' ORDER BY SHOPNAME
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO  order by actiondate desc
--DELETE FROM BELL_APP_SHOPS_VISIT_INFO  

SELECT * FROM Bell_LS where area='KARIMNAGAR' and billdate='2026-MAR-30'
 Bell_APP_GET_ALL_ITEMS '2026-03-30','KARIMNAGAR', 'FORMOBILE_ALL'

select * from bhavani_ER_Bills where area='HANAMKONDA' and billdate='2026-Apr-25'
select * from bhavani_ER_Bills_Temp where area='THORRUR' and billdate='2026-Mar-27'
select * from bhavani_ER_Bills where area='THORRUR' and billdate='2026-Mar-21'
SELECT * FROM Bell_LS_TEMP where area='THORRUR' and billdate='2026-Mar-21'
select * from bhavani_ER_Bills where area='THORRUR' and billdate='2026-Mar-23'

select * from bhavani_ER_Bills where area='NARSAMPET' and billdate='2026-Mar-26' order by shopname 
select * from bhavani_ER_Bills where area='NARSAMPET' and billdate='2026-Mar-26' and discount > 0 
and billnumber not in (
select billnumber from bhavani_ER_Bills where area='NARSAMPET' and billdate='2026-Mar-26' and discount > 0 
group by Billnumber,Area Having sum(amount) >=5000

--UPDATE bhavani_ER_Bills SET DISCOUNT=0 
--where area='Ghanpur' and billdate='2026-Mar-27' and discount > 0 
--and billnumber not in (
--select billnumber from bhavani_ER_Bills where area='Ghanpur' and billdate='2026-Mar-27' and discount > 0 
--group by Billnumber,Area Having sum(amount) >=5000)

select * from bhavani_ER_Bills with (nolock) where area='Jangaon' and billdate='2026-Mar-31'

select * from bhavani_ER_Bills with (nolock) where area='Kothaguda' and billdate='2026-Mar-30'
select * from Bell_LS with (nolock) where area='Kothaguda' and billdate='2026-Mar-30'
--update Bell_LS set R_B=0 where area='Kothaguda' and billdate='2026-Mar-30' 

select * from bhavani_ER_Bills with (nolock) where area='Maripeda' and billdate='2026-Mar-30'

select * from Bell_LS with (nolock) where area='Maripeda' and billdate='2026-Mar-30'
select *  FROM Bell_LS_TEMP1  with (nolock) where area='Maripeda' and billdate='2026-Mar-30'

--update A SET A.STATUS= B.R_B  FROM Bell_LS A INNER JOIN Bell_LS_TEMP1 B ON 
--A.AREA=B.AREA AND A.BILLDATE=B.BILLDATE where A.area='Maripeda' and A.billdate='2026-Mar-30'
--AND  B.area='Maripeda' and B.billdate='2026-Mar-30' AND B.R_B <> 0;


SELECT DISTINCT B.* FROM Bell_LS A INNER JOIN Bell_LS_TEMP1 B ON 
A.AREA=B.AREA AND A.BILLDATE=B.BILLDATE where A.area='Maripeda' and A.billdate='2026-Mar-30'
AND  B.area='Maripeda' and B.billdate='2026-Mar-30'

select * from Bell_ItemMaster where offeritemname like 'Offer%'
select * from Bell_LS where area='Ghanpur' and billdate='2026-Mar-27'

--for testing use _Temp tables
drop table  Bell_LS_TEMP 
drop table bhavani_ER_Bills_Temp
select * INTO  Bell_LS_TEMP from Bell_LS where area='NARSAMPET' and billdate='2026-Mar-26'
select * into bhavani_ER_Bills_Temp from bhavani_ER_Bills where area='NARSAMPET' and billdate='2026-Mar-25'
--UPDATE Bell_LS_TEMP SET R_B = 0 where area='NARSAMPET' and billdate='2026-Mar-26'
SELECT * FROM Bell_LS_temp where area='NARSAMPET' and billdate='2026-Mar-26'
select * from bhavani_ER_Bills_temp where area='NARSAMPET' and billdate='2026-Mar-26' order by shopname 

SELECT name, type_desc FROM sys.indexes WHERE object_id = OBJECT_ID('Bell_ItemMaster');

CREATE NONCLUSTERED INDEX IX_Customers_LastName ON dbo.Customers (LastName);
CREATE NONCLUSTERED INDEX IX_Orders_CustomerID_OrderDate ON dbo.Orders (CustomerID, OrderDate);

--drop table Bell_LS_TEMP
BELL_INC_UPD_LS_ITEMS_NEW -- FROM VB6
------------mobile app changes -22-Feb-26
SELECT * FROM BELL_APP_SHOPS_VISIT_INFO  where line='MAHABUBABAD' and cast(orderdate as date)='2026-04-01' ORDER BY SHOPNAME
select * from bhavani_ER_Bills with (nolock) where area='MAHABUBABAD' and billdate='2026-Mar-31' ORDER BY SHOPNAME

--TODO: add col=billing_startdate, billing_enddate, GEO_Location, Is_Network_Available
select * from bhavani_ER_Bills where username like 'From_Mobile' and area='THORRUR' and actiondate >= '2026-03-26'
order by mobileorderdate desc
--delete from bhavani_ER_Bills where username like 'From_Mobile' and area='THORRUR' and actiondate >= '2026-03-26'

USP_GET_AllItemsById
USP_Update_ItemDetails

SELECT * FROM Bell_LS WHERE BILLDATE='2026-03-21' and area='THORRUR'
select * from Bell_ItemMaster where discountpercent > 0
select * from Bell_ItemMaster where itemname like 'Mons%'
select * from Bell_ItemMaster where Rate1 is null
select * from Bell_ItemMaster where item_seq=231
--update Bell_ItemMaster set Rate1=135,Rate2=135,rate3=135 where itemid=2994 -- 2997
--update Bell_ItemMaster set Rate1=80,Rate2=80,rate3=80 where itemid=2995

select * from Bell_ItemMaster where offeritemname like 'Offer%'
select * from Bell_ItemMaster where itemname='HI-FUN(CREAM)5 RS'

select * from Bell_ItemMaster where status='InActive'  order by actiondate desc
select * from Bell_ItemMaster where status='Active' and Category = 'Cool drinks' order by actiondate desc

select * from Bell_ItemMaster where status='Active' and Category<> 'Raw materials' order by actiondate desc
select distinct category from Bell_ItemMaster 
--select * from Bell_ItemMaster where imageurl like '%/%' 
--update Bell_ItemMaster set ImageURL = replace(imageurl,'/','') where imageurl like '%/%' 
--update Bell_ItemMaster set ImageURL = trim(ItemName)+'.jpg' where status='Active' and Category<> 'Raw materials' AND ITEMCODE<6

select * from tblAllMasterData
https://bellbrandbhavanikhara.in/bell_item_images/SUNNUNDALU_5RS.jpg
https://bellbrand.in/bell_item_images/besto_5_rs.jpg
----update tblAllMasterData set FIELDVALUE='https://myorders.zionwellmark.in/Bell_Images/' where fieldtype='Bell_ImageServerURL'
--update tblAllMasterData set FIELDVALUE='https://bellbrand.in/bell_item_images/' where fieldtype='Bell_ImageServerURL'
--INSERT INTO tblAllMasterData(FIELDTYPE, FIELDVALUE,Description) VALUES('Bell_ImageServerURL','https://bellbrandbhavanikhara.in/bell_item_images/','for Bell Brand OLD site')
select * from tblItemMaster
select * from Bell_ItemMaster where itemcode in (99,100,197,198,207,218)
update Bell_ItemMaster set ImageUrl='DARK FILLS 5RS.jpeg' where itemcode=197
update Bell_ItemMaster set ImageUrl='MONSTER BITZ 5RS.jpeg' where itemcode=198
update Bell_ItemMaster set ImageUrl='WAFIX_5RS.jpg' where itemcode=218
update Bell_ItemMaster set ImageUrl='PARTY_ROLLS_5RS.jpeg' where itemcode=207
update Bell_ItemMaster set ImageUrl='COVA_5RS.jpeg' where itemcode=100



SELECT DESCRIPTION='OFFER : ' + OFFERITEMNAME + ' (' + CAST(OFFER_QTY_AVAIL AS VARCHAR) + ')  for ' + CAST(OFFERPAKS AS VARCHAR) + 'p'
FROM BELL_ITEMMASTER WHERE OFFERAVAILABLE='Y' and isnull(offeritemname,'') <> ''

/* //TODO - update this directly from VB app.
-- first we need to clear details for all items and then update
select * from BELL_ITEMMASTER WHERE OFFERAVAILABLE='Y' and isnull(offeritemname,'') <> ''
--UPDATE BELL_ITEMMASTER SET DETAILS=''
UPDATE BELL_ITEMMASTER SET 
DETAILS='OFFER : ' + OFFERITEMNAME + ' (' + CAST(OFFER_QTY_AVAIL AS VARCHAR)  + ')  for ' + CAST(OFFERPAKS AS VARCHAR) + 'p'
WHERE OFFERAVAILABLE='Y' and isnull(offeritemname,'') <> ''
*/
select LINE,AREA,SHOPNAME,CUSTOMERNAME,MOBILE from Bell_Cust_Master where LINE = 'KHAMMAM'

select * from Bell_Cust_Master where SHOPNAME LIKE '%KIRNAM%'
select * from Bell_Cust_Master where (shopname like '%bakery%' OR shopname like '%bekary%' OR SHOPNAME LIKE '%B/K%') AND isnull(Category,'')='' 

SELECT * FROM BELL_ItemMaster order by ItemCode
--ALTER TABLE BELL_ItemMaster ADD ISMODIFIED VARCHAR(3)
--UPDATE BELL_ItemMaster SET ISMODIFIED='N' 
Bell_APP_GET_ALL_ITEMS 'FORMOBILE_ALL'
USP_GET_AREALIST
Bell_Get_Previous4_Orders_New
BELL_SP_GET_All_LS_Customers

BELL_INC_UPD_Bills_NEW_MOBILE
BELL_INC_UPD_Bills_NEW_MOBILE 'NARSAMPET','KERAMERI','HIMA BINDHU K/M (NRSP)(MLPY)','3/16/2026 11:39:49 AM',300,'CAKE 1RS',14.5,'120',120,2,1740.0,'From_Mobile',0,0,'',0,0,'king','Cash'

BELL_INC_UPD_LS_ITEMS_NEW

BELL_INC_UPD_Bills_NEW
USP_VALIDATE_USER
USP_SAVE_USER_DETAILS
USP_GET_ALL_USERS
 SELECT * FROM BELL_USERS WHERE USERTYPE IN ('OFFICE','VAN LOADING','VAN LOADING APPROVER')
 --UPDATE BELL_USERS SET firstname='BellBrand',lastname='Bhavani', USERNAME='bellbrand',password='BellBrand',ActionDate=getdate() where id=3
 --UPDATE BELL_USERS SET password='654321',ActionDate=getdate() where id=7
 
 --delete from BELL_USERS where id in (15,16)

 --UPDATE BELL_USERS SET firstname='BellBrand',lastname='Bhavani', USERNAME='bellbrand',password='BellBrand',ActionDate=getdate() where id=3
 update BELL_USERS set username='bellbrand',password='bellbrand',FIRSTNAME='bell brand',LASTNAME='' where id=4

 --ALTER TABLE BELL_USERS ALTER COLUMN USERTYPE VARCHAR(30)
 -- insert into BELL_USERS (username,password,usertype,firstname,lastname,status,actiondate) values('VANLOADING1','bellbrand','VAN LOADING','USER1','USER LASTNAME','Active',getdate())
 --insert into BELL_USERS (username,password,usertype,firstname,lastname,status,actiondate) values('VANLOADING2','bellbrand','VAN LOADING APPROVER','USER2','USER LASTNAME','Active',getdate())

 --insert into BELL_USERS (username,password,usertype,firstname,lastname,status,actiondate) values('tejaswini','apple123','user','Tejaswini','Tejaswini','Active',getdate())
 --insert into BELL_USERS (username,password,usertype,firstname,lastname,status,actiondate) values('sathvik','123456','user','Sathvik','Sathvik','Active',getdate())--
 --insert into BELL_USERS (username,password,usertype,firstname,lastname,status,actiondate) values('priyanka','123456','user','priyanka','priyanka','Active',getdate())
--UPDATE BELL_USERS SET password='SuperUser@2312' where username='king'
 --UPDATE BELL_USERS SET USERTYPE='admin' where username='raja'
 --UPDATE BELL_USERS SET username='sanath' where id = 13
 
 --UPDATE BELL_USERS SET username='subhash' where id = 14

 --UPDATE BELL_USERS SET usertype='OFFICE' where id IN (7,3)
 --UPDATE BELL_USERS SET username='tejaswini',password='apple123',usertype='user',firstname='Tejaswini',lastname='',status='Active' where id=4

--ALTER TABLE BELL_LS ADD STATUS VARCHAR(10) DEFAULT ''
-- STATUS CAN BE 'LOADED', 'PENDING' 'COMPLETED'

------------------------------------------------------------------