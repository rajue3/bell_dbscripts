/*
USP_GET_AllItemsById
USP_Update_ItemDetails

select * from Bell_ItemMaster where status='InActive'  order by actiondate desc
select Replace(ImageUrl,' ','_'),* from Bell_ItemMaster where status='Active' and Category<> 'Raw materials' order by actiondate desc
--to remove space char from all image file names
update Bell_ItemMaster set ImageUrl=Replace(ImageUrl,' ','_')

select distinct category from Bell_ItemMaster 
--select * from Bell_ItemMaster where imageurl like '%/%' 
--update Bell_ItemMaster set ImageURL = replace(imageurl,'/','') where imageurl like '%/%' 
--update Bell_ItemMaster set ImageURL = trim(ItemName)+'.jpg' where status='Active' and Category<> 'Raw materials' AND ITEMCODE<6

select * from tblAllMasterData
--update tblAllMasterData set FIELDVALUE='https://myorders.zionwellmark.in/Bell_Images/' where fieldtype='Bell_ImageServerURL'
update tblAllMasterData set FIELDVALUE='https://bellbrandbhavanikhara.in/bell_item_images/' where fieldtype='Bell_ImageServerURL'
--INSERT INTO tblAllMasterData(FIELDTYPE, FIELDVALUE,Description) VALUES('Bell_ImageServerURL','https://myorders.zionwellmark.in/Bell_Image/','for Bell Brand')

select * from Bell_ItemMaster where BILLDATE = '2026-05-08' and area='Siricilla'
select * FROM BELL_ItemMaster A with (nolock) 

			 and B.BILLDATE=@ORDERDATE and B.AREA=@LINE Where A.status='Active' and A.CATEGORY<>'RAW MATERIALS' 

--ALTER TABLE Bell_ItemMaster MODIFY COL DETAILS
ALTER TABLE Bell_ItemMaster ADD DETAILS NVARCHAR(250) NULL
ALTER TABLE Bell_ItemMaster ADD ImageUrl NVARCHAR(200) NULL

   Bell_APP_GET_ALL_ITEMS '2026-04-30','KORUTLA','BILLS_SHOPS_COUNT'
   Bell_APP_GET_ALL_ITEMS '2026-07-18','BHAVANI','BAZAR_BILLS_COUNT'


 select * from Bell_LS where area='Asifabad' and username='ORDERS' AND BILLDATE <= '2026-02-28'
select * from Bell_LS where  BILLDATE = '2026-05-08' and area='Siricilla'

select * from BELL_ItemMaster where Itemname in (select Itemname from Bell_LS where  BILLDATE = '2026-05-08' and area='Siricilla')
select * from BELL_ItemMaster where Itemname in (select Itemname from Bell_LS where  BILLDATE = '2026-05-09' and area='Yellandu')
select * from Bell_LS_ORDERS where  BILLDATE = '2026-05-08' and area='Siricilla'
129	BOURBUN 10RS
127	50-50 10RS
130	LITTILE HEARTS 5RS
97	JUMBO MYSOREPAK JAR 5RS
362	DETERGENT 3KG
68	KRUPA PAPIDI(BANARAS)

ALTER TABLE BELL_LS ADD STATUS VARCHAR(10) DEFAULT ''
-- STATUS CAN BE 'LOADED', 'PENDING' 'COMPLETED'
-- Bell_APP_GET_ALL_ITEMS '2026-03-31','Maripeda', 'UPDATE_DISCOUNT'

 Bell_APP_GET_ALL_ITEMS '2026-06-01','HANAMKONDA', 'FORMOBILE_ALL'

-- Bell_APP_GET_ALL_ITEMS '2026-05-11','PALAKURTHY', 'FORMOBILE_ALL'

Bell_APP_GET_ALL_ITEMS '2026-07-03','NEKKONDA', 'FORMOBILE_ALL'
-- Bell_APP_GET_ALL_ITEMS '2026-03-31','Jangaon', 'FORMOBILE_ALL'
-- Bell_APP_GET_ALL_ITEMS '2026-03-26','NARSAMPET', 'FORMOBILE_ALL'
-- Bell_APP_GET_ALL_ITEMS '2025-12-17','BAYYARAM', 'FORMOBILE_ALL'
 Bell_APP_GET_ALL_ITEMS '2026-05-18','MARIPEDA', 'FORMOBILE_LOADING'
 Bell_APP_GET_ALL_ITEMS '2026-06-01','HANAMKONDA', 'FORMOBILE_LOADING'
 Bell_APP_GET_ALL_ITEMS '2026-06-07','HANAMKONDA', 'FORMOBILE_LOADING'
 Bell_APP_GET_ALL_ITEMS '2026-06-04','MULUGU', 'FORMOBILE_LOADING'

 Bell_APP_GET_ALL_ITEMS '2026-07-17','GAJWEL', 'ALL_ITEM_ORDERS_SHOPS'
 Bell_APP_GET_ALL_ITEMS '2026-07-17','GAJWEL', 'ALL_ITEM_ORDERS_SHOPS'
 Bell_APP_GET_ALL_ITEMS '2026-06-04','HANAMKONDA', 'ALL_ITEM_ORDERS_SHOPS'
 Bell_APP_GET_ALL_ITEMS '2026-06-09','KOTHAGUDEM', 'ALL_ITEM_ORDERS_SHOPS'
 Bell_APP_GET_ALL_ITEMS '2026-07-27','BAZAR DIRECT SALES', 'ALL_ITEM_ORDERS_SHOPS'
 Bell_APP_GET_ALL_ITEMS '2026-07-27','KAMAREDDY', 'ALL_ITEM_ORDERS_SHOPS'
 Bell_APP_GET_ALL_ITEMS '2026-07-27','KAMAREDDY', 'FORMOBILE_ALL'
Bell_APP_GET_ALL_ITEMS '2026-07-30','KHAMMAM', 'ALL_ITEM_ORDERS_SHOPS'

*/
ALTER Procedure Bell_APP_GET_ALL_ITEMS
@ORDERDATE DATE,
@LINE varchar(50) ,
@OPTION as varchar(50)  =''
AS             
BEGIN  
 --Select ItemName,Rate,PACKINGTYPE,TOTALITEMSINPACK,CATEGORY,STOCK,ImageUrl,Description FROM tblItemMaster  
 declare @ImageURL as varchar(50) ,@IsForDirectSales as varchar(15) 
 declare @RND as varchar(12)   
 select @RND = '?count=' + CONVERT(char,FLOOR(RAND()*(1000-5+1)+5)); -- will get random no. from 5 to 100. used to refresh images immediately  
 set @ImageURL = (Select top 1 FieldValue from tblAllMasterData where FieldType='Bell_ImageServerURL')  
  select @IsForDirectSales = (select TOP 1 IsForDirectSales from BELL_CUST_MASTER where LINE=@LINE)
  
 --Select ITEMID as ProductID, ItemName as Name,Rate Price,PACKINGTYPE,  
 --TOTALITEMSINPACK Rating,CATEGORY as RatingDetail, 1 as CategorID, @ImageURL + ImageUrl as ImageUrl,Description FROM tblItemMaster  
 --where DisplayOrder > 0 order by DisplayOrder asc  
  
 --Select ITEMID as ProductID, ItemName as Name,MRP,Rate Price,PACKINGTYPE,  
 --TOTALITEMSINPACK,TOTALITEMSINCARTON,CATEGORY, 1 as CategorID, @ImageURL + ImageUrl as ImageUrl,Description FROM tblItemMaster  
 --where DisplayOrder > 0 order by DisplayOrder asc  
  
  if @OPTION = ''
  BEGIN
		PRINT 'SHOWING ALL ITEMS FOR WEB APP'
	 --working script:  
	 Select ITEMID as ID, ITEMCODE,ItemName, Itemname as Name,MRP,Rate1, Rate1 as Price,PACKINGTYPE,'' as Qty,   
	 TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, DETAILS AS [Description] ,
	 trim(@ImageURL + replace(ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,ImageUrl as ImageName,ITEM_SEQ
	 FROM BELL_ItemMaster with (nolock)
	 --[Description]
	 Where status='Active' and CATEGORY<>'RAW MATERIALS'  order by ItemCode
  END
  ELSE IF @OPTION='ALL_ITEM_ORDERS_SHOPS' --  TO GET ALL SHOPS, PREV ORDERS, ITEM DETAILS IN ONE CALL
  BEGIN
			PRINT 'ALL_ITEM_ORDERS_SHOPS FOR MOBILE APP'
			
			--CHECK IF ORDER ITEMS EXISTS IN Bell_LS TABLE, ELSE NO NEED TO FETCH OTHER DETAILS.
			IF EXISTS(SELECT ITEMCODE  FROM Bell_LS with (nolock) WHERE BILLDATE=@ORDERDATE and AREA=@LINE AND T_B > 0)
			BEGIN
				-- TABLE1  ALL ITEM DETAILS INCLUDING ORDER ITEMS WITH QTY
				--Select A.ITEM_SEQ as ID, A.ITEMCODE,A.ItemName, A.Itemname as Name,A.MRP,A.Rate1, A.Rate1 as Price,A.PACKINGTYPE,'' as Qty,   
				-- A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, 
				-- DETAILS AS [Description] ,A.DiscountPercent,
				-- A.OFFERAVAILABLE,isnull(A.OFFERITEMNAME,'') OFFERITEMNAME ,isnull(A.OFFERPAKS,0) MINORDERFOROFFER,
				-- isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,
				-- trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName,
				-- isnull(B.T_B,0) as AVAILABLE_PAKS,A.ITEM_SEQ
				-- FROM BELL_ItemMaster A with (nolock) LEFT JOIN Bell_LS B with (nolock) ON A.ITEMCODE=B.ITEMCODE AND A.ITEMNAME=B.ITEMNAME
				-- and B.BILLDATE=@ORDERDATE and B.AREA=@LINE Where A.status='Active' and A.CATEGORY<>'RAW MATERIALS' 
				-- order by A.ItemCode

				-- CHANGED FOR ADDING LINE WISE OFFERS 
				Select A.ITEMID AS ID, A.ITEMCODE,A.ItemName, A.Itemname as Name,A.MRP,A.PACKINGTYPE,'' as Qty,   
				--A.Rate1,A.Rate1 as Price,
				iif(@IsForDirectSales = 'LOCAL',A.RATE2,A.RATE1) AS Rate1,
				iif(@IsForDirectSales = 'LOCAL',A.RATE2,A.RATE1) AS Price,
				 A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl,A.DiscountPercent,
				 --DETAILS AS [Description] ,A.OFFERAVAILABLE
				  IIF( EXISTS(SELECT ITEMNAME FROM BELL_LINE_WISE_OFFERS L WHERE (LINE=@LINE OR LINE='ALL') AND L.ITEMNAME=A.ITEMNAME),'Y','N' ) AS OFFERAVAILABLE
				 ,IIF( EXISTS(SELECT ITEMNAME FROM BELL_LINE_WISE_OFFERS L WHERE (LINE=@LINE OR LINE='ALL') AND L.ITEMNAME=A.ITEMNAME),
				 'OFFER : ' + OFFERITEMNAME + ' (' + CAST(OFFER_QTY_AVAIL AS VARCHAR) + ')  for ' + CAST(OFFERPAKS AS VARCHAR) + 'P'
				 ,'' ) AS DESCRIPTION,
				 --,isnull(A.OFFERITEMNAME,'') OFFERITEMNAME
				 OFFERITEMNAME=(CASE WHEN A.OFFERAVAILABLE='Y' THEN isnull(A.OFFERITEMNAME,'') ELSE '' END)
				 ,isnull(A.OFFERPAKS,0) MINORDERFOROFFER, isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,
				 trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName,
				 isnull(B.T_B,0) as AVAILABLE_PAKS,A.ITEM_SEQ
				 FROM BELL_ItemMaster A with (nolock) LEFT JOIN Bell_LS B with (nolock) ON A.ITEMCODE=B.ITEMCODE AND A.ITEMNAME=B.ITEMNAME
				 and B.BILLDATE=@ORDERDATE and B.AREA=@LINE Where A.status='Active' and A.CATEGORY<>'RAW MATERIALS' 
				 order by A.ItemCode

				 --TABLE2 
					EXEC BELL_SP_GET_All_LS_Customers @LINE,'all','all'
					--TABLE3
					EXEC BELL_GET_PREVIOUS4_ORDERS_NEW @LINE,@ORDERDATE ,'BILLS'
					--TABLE4
					EXEC BELL_GET_PREVIOUS4_ORDERS_NEW @LINE,@ORDERDATE,'BILLDATES'
				END
				ELSE
				BEGIN
						SELECT 'NO DATA FOUND' 
				END
  END
  ELSE IF @OPTION='FORMOBILE_ALL' --TO SHOW ALL ITEMS FROM BELL_LS Table
  BEGIN
		PRINT 'SHOWING ALL ITEMS FOR MOBILE APP'
			--Select ITEMID as ID, ITEMCODE,ItemName, Itemname as Name,MRP,Rate1, Rate1 as Price,PACKINGTYPE,'' as Qty,   
			 --TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, DETAILS AS [Description] ,DiscountPercent,
			--OFFERAVAILABLE,isnull(OFFERITEMNAME,'') OFFERITEMNAME ,isnull(OFFERPAKS,0) MINORDERFOROFFER,isnull(OFFER_QTY_AVAIL,0) OFFER_QTY_AVAIL,
			--trim(@ImageURL + replace(ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,ImageUrl as ImageName
			--FROM BELL_ItemMaster Where status='Active' and CATEGORY<>'RAW MATERIALS' 
			--order by ItemCode
			Select A.ITEMID as ID, A.ITEMCODE,A.ItemName, A.Itemname as Name,A.MRP,A.PACKINGTYPE,'' as Qty,   
			--A.Rate1, A.Rate1 as Price,
			iif(@IsForDirectSales = 'LOCAL',A.RATE2,A.RATE1) AS Rate1,
			iif(@IsForDirectSales = 'LOCAL',A.RATE2,A.RATE1) AS Price,
			 A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, 
			 A.DiscountPercent,isnull(A.OFFERPAKS,0) MINORDERFOROFFER,
			 --DETAILS AS [Description],A.OFFERAVAILABLE,isnull(A.OFFERITEMNAME,'') OFFERITEMNAME ,
			 IIF( EXISTS(SELECT ITEMNAME FROM BELL_LINE_WISE_OFFERS L WHERE (LINE=@LINE OR LINE='ALL') AND L.ITEMNAME=A.ITEMNAME),'Y','N' ) AS OFFERAVAILABLE,
			 IIF( EXISTS(SELECT ITEMNAME FROM BELL_LINE_WISE_OFFERS L WHERE (LINE=@LINE OR LINE='ALL') AND L.ITEMNAME=A.ITEMNAME),
				 'OFFER : ' + OFFERITEMNAME + ' (' + CAST(OFFER_QTY_AVAIL AS VARCHAR) + ')  for ' + CAST(OFFERPAKS AS VARCHAR) + 'P'
				 ,'' ) AS [DESCRIPTION],
			OFFERITEMNAME=(CASE WHEN A.OFFERAVAILABLE='Y' THEN isnull(A.OFFERITEMNAME,'') ELSE '' END),
			 isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,
			 trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName,
			 isnull(B.T_B,0) as AVAILABLE_PAKS,A.ITEM_SEQ
			 FROM BELL_ItemMaster A with (nolock) LEFT JOIN Bell_LS B with (nolock) ON A.ITEMCODE=B.ITEMCODE AND A.ITEMNAME=B.ITEMNAME
			 and B.BILLDATE=@ORDERDATE and B.AREA=@LINE Where A.status='Active' and A.CATEGORY<>'RAW MATERIALS' 
			 order by A.ItemCode
  END
  ELSE IF @OPTION='FORMOBILE_LOADING'  -- TO SHOW ALL ITEMS from ORDERS TABLE for VAN Loading and approval. added on 30-May26.
  BEGIN
	--isnull(B.ID,0) as ID
			Select isnull(A.ITEM_SEQ,0) as ID , A.ITEMCODE,A.ItemName, A.Itemname as Name,A.MRP,A.PACKINGTYPE,'' as Qty,   
			--A.Rate1, A.Rate1 as Price,
			iif(@IsForDirectSales  = 'LOCAL',A.RATE2,A.RATE1) AS Rate1,
			iif(@IsForDirectSales  = 'LOCAL',A.RATE2,A.RATE1) AS Price,
			 A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, 
			 DETAILS AS [Description],A.DiscountPercent,A.OFFERAVAILABLE,isnull(A.OFFERPAKS,0) MINORDERFOROFFER,
			 --isnull(A.OFFERITEMNAME,'') OFFERITEMNAME 
			 OFFERITEMNAME=(CASE WHEN A.OFFERAVAILABLE='Y' THEN isnull(A.OFFERITEMNAME,'') ELSE '' END),
			 isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,
			 trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName,
			 isnull(B.T_B,0) as AVAILABLE_PAKS,isnull(B.Websynced,'') as Approval_Status,A.ITEM_SEQ
			 FROM BELL_ItemMaster A with (nolock) LEFT JOIN Bell_LS_ORDERS B with (nolock) ON A.ITEMCODE=B.ITEMCODE AND A.ITEMNAME=B.ITEMNAME
			 and B.BILLDATE=@ORDERDATE and B.AREA=@LINE Where A.status='Active' and A.CATEGORY<>'RAW MATERIALS'
			 order by A.ItemCode
  END
  ELSE IF @OPTION='ONLY_ORDERS' --SHOW ONLY ORDER ITEMS THAT HAVE AVAILABLE PAK>0
  BEGIN
		PRINT 'SHOWING ONLY ORDERED ITEMS FOR MOBILE APP'
			Select A.ITEM_SEQ as ID, A.ITEMCODE,A.ItemName, A.Itemname as Name,A.MRP,A.Rate1, A.Rate1 as Price,A.PACKINGTYPE,'' as Qty,   
			 A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, 
			 DETAILS AS [Description] ,A.DiscountPercent,
			 A.OFFERAVAILABLE,isnull(A.OFFERITEMNAME,'') OFFERITEMNAME ,isnull(A.OFFERPAKS,0) MINORDERFOROFFER,
			 isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,
			 trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName,
			 isnull(B.T_B,0) as AVAILABLE_PAKS,A.ITEM_SEQ
			 FROM BELL_ItemMaster A with (nolock) INNER JOIN Bell_LS B with (nolock) ON A.ITEMCODE=B.ITEMCODE AND A.ITEMNAME=B.ITEMNAME
			 and B.BILLDATE=@ORDERDATE and B.AREA=@LINE Where A.status='Active' and A.CATEGORY<>'RAW MATERIALS' 
			 order by A.ItemCode
  END
  ELSE IF @OPTION='FORMOBILE_MODIFIED' --SHOW ONLY MODIFIED ITEMS : TODO: TO BE IMPLEMENTED
  BEGIN
		PRINT 'SHOWING ONLY MODIFIED ITEMS FOR MOBILE APP'
  	 Select ITEM_SEQ as ID, ITEMCODE,ItemName, Itemname as Name,MRP,Rate1, Rate1 as Price,PACKINGTYPE,'' as Qty,   
	 TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, DETAILS AS [Description] ,
	 trim(@ImageURL + replace(ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,ImageUrl as ImageName,ITEM_SEQ
	 FROM BELL_ItemMaster with (nolock) Where status='Active' and CATEGORY<>'RAW MATERIALS'  AND ISMODIFIED='Y'
	 order by ItemCode
  END
   ELSE IF @OPTION = 'UPDATE_DISCOUNT' --TO UPDATE DISCOUNT TO ZERO FOR NON ELIGIBLE ITEMS.
  BEGIN
		PRINT 'UPDATING DISCOUNT TO ZERO FOR NON ELIGIBLE ITEMS.'
		  print 'ACTUAL BILLDATE=' + cast(@ORDERDATE as varchar)
		  if ISNULL(@ORDERDATE,'') = ''  OR DATEPART(year, @ORDERDATE) < 1753 
		  BEGIN
				SELECT TOP 1 @ORDERDATE=BILLDATE  FROM BELL_LS WHERE AREA=@LINE ORDER BY BILLDATE DESC
		  END
		Print 'BillDate=' + cast(@ORDERDATE AS VARCHAR(30)) + 'Line=' + @LINE
		/* select * from bhavani_ER_Bills where area=@LINE and billdate=@ORDERDATE and discount > 0 
		and billnumber not in (
		select billnumber from bhavani_ER_Bills where area=@LINE and billdate=@ORDERDATE and discount > 0 
		group by Billnumber,Area Having sum(amount) >=5000	) 
		*/
		UPDATE bhavani_ER_Bills SET DISCOUNT=0 where area=@LINE and billdate=@ORDERDATE and discount > 0 
		and billnumber not in (
		select billnumber from bhavani_ER_Bills where area=@LINE and billdate=@ORDERDATE and discount > 0 
		group by Billnumber,Area Having sum(amount) >=5000	)

	END
	ELSE IF @OPTION = 'BILLS_SHOPS_COUNT'
    BEGIN
            DECLARE @TOT_BILLS INT,@TOT_SHOPS INT
            WITH TAB1 AS (
            SELECT DISTINCT BILLNUMBER AS BILLS FROM bhavani_ER_Bills WITH (NOLOCK) where AREA=@LINE and billdate=@ORDERDATE
            GROUP BY SHOPNAME,BILLNUMBER  )  
            SELECT @TOT_BILLS=(SELECT COUNT(BILLS) FROM TAB1)

            SELECT @TOT_SHOPS=COUNT(1) FROM BELL_APP_SHOPS_VISIT_INFO WITH (NOLOCK) where  LINE=@LINE AND orderdate=@ORDERDATE
            SELECT @TOT_BILLS AS TOT_BILLS,@TOT_SHOPS AS TOT_SHOPS 
    END
	ELSE IF @OPTION = 'BAZAR_BILLS_COUNT'
    BEGIN
            WITH TAB1 AS (
            SELECT DISTINCT BILLNUMBER AS BILLS FROM Bazar_Mobile_Bills WITH (NOLOCK) where LINE=@LINE and billdate=@ORDERDATE
            GROUP BY SHOPNAME,BILLNUMBER )  
            
			--SELECT @TOT_SHOPS=COUNT(1) FROM Bazar_Mobile_Bills  WITH (NOLOCK) where  LINE=@LINE AND orderdate=@ORDERDATE

            SELECT COUNT(BILLS) AS TOT_BILLS, 0 TOT_SHOPS FROM TAB1
    END
END  