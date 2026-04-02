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
select * from tblItemMaster
select * from Bell_ItemMaster 
--ALTER TABLE Bell_ItemMaster MODIFY COL DETAILS
ALTER TABLE Bell_ItemMaster ADD DETAILS NVARCHAR(250) NULL
ALTER TABLE Bell_ItemMaster ADD ImageUrl NVARCHAR(200) NULL
*/

select * from Bell_LS where area='Asifabad' and username='ORDERS' AND BILLDATE <= '2026-02-28'
select * from Bell_LS where username='ORDERS' AND BILLDATE <= '2026-02-28'  --CAN BE DELETED

ALTER TABLE BELL_LS ADD STATUS VARCHAR(10) DEFAULT ''
-- STATUS CAN BE 'LOADED', 'PENDING' 'COMPLETED'
'ECLAIRS 50 NP'
-- Bell_APP_GET_ALL_ITEMS '2026-03-31','Maripeda', 'UPDATE_DISCOUNT'

-- Bell_APP_GET_ALL_ITEMS '2026-03-31','Jangaon', 'ONLY_ORDERS'
-- Bell_APP_GET_ALL_ITEMS '2026-03-31','Jangaon', 'FORMOBILE_ALL'
-- Bell_APP_GET_ALL_ITEMS '2026-03-26','NARSAMPET', 'FORMOBILE_ALL'
-- Bell_APP_GET_ALL_ITEMS '2026-03-23','KHAMMAM', 'FORMOBILE_ALL'
-- Bell_APP_GET_ALL_ITEMS '2025-12-17','BAYYARAM', 'FORMOBILE_ALL'
-- Bell_APP_GET_ALL_ITEMS 'FORMOBILE_ALL'
-- Bell_APP_GET_ALL_ITEMS ''
alter Procedure Bell_APP_GET_ALL_ITEMS
@ORDERDATE DATE,
@LINE varchar(50) ,
@OPTION as varchar(30)  =''
AS             
BEGIN  
 --Select ItemName,Rate,PACKINGTYPE,TOTALITEMSINPACK,CATEGORY,STOCK,ImageUrl,Description FROM tblItemMaster  
 declare @ImageURL as varchar(50)  
 declare @RND as varchar(12)  
 select @RND = '?count=' + CONVERT(char,FLOOR(RAND()*(1000-5+1)+5)); -- will get random no. from 5 to 100. used to refresh images immediately  
 set @ImageURL = (Select top 1 FieldValue from tblAllMasterData where FieldType='Bell_ImageServerURL')  
  
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
	 trim(@ImageURL + replace(ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,ImageUrl as ImageName
	 FROM BELL_ItemMaster with (nolock)
	 --[Description]
	 Where status='Active' and CATEGORY<>'RAW MATERIALS'  order by ItemCode
  END
  ELSE IF @OPTION='FORMOBILE_ALL' --SHOW ALL ITEMS
  BEGIN
		PRINT 'SHOWING ALL ITEMS FOR MOBILE APP'
			--Select ITEMID as ID, ITEMCODE,ItemName, Itemname as Name,MRP,Rate1, Rate1 as Price,PACKINGTYPE,'' as Qty,   
			 --TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, DETAILS AS [Description] ,DiscountPercent,
			--OFFERAVAILABLE,isnull(OFFERITEMNAME,'') OFFERITEMNAME ,isnull(OFFERPAKS,0) MINORDERFOROFFER,isnull(OFFER_QTY_AVAIL,0) OFFER_QTY_AVAIL,
			--trim(@ImageURL + replace(ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,ImageUrl as ImageName
			--FROM BELL_ItemMaster Where status='Active' and CATEGORY<>'RAW MATERIALS' 
			--order by ItemCode
			Select A.ITEMID as ID, A.ITEMCODE,A.ItemName, A.Itemname as Name,A.MRP,A.Rate1, A.Rate1 as Price,A.PACKINGTYPE,'' as Qty,   
			 A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, 
			 DETAILS AS [Description] ,A.DiscountPercent,
			 A.OFFERAVAILABLE,isnull(A.OFFERITEMNAME,'') OFFERITEMNAME ,isnull(A.OFFERPAKS,0) MINORDERFOROFFER,
			 isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,
			 trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName,
			 isnull(B.T_B,0) as AVAILABLE_PAKS
			 FROM BELL_ItemMaster A with (nolock) LEFT JOIN Bell_LS B with (nolock) ON A.ITEMCODE=B.ITEMCODE AND A.ITEMNAME=B.ITEMNAME
			 and B.BILLDATE=@ORDERDATE and B.AREA=@LINE Where A.status='Active' and A.CATEGORY<>'RAW MATERIALS' 
			 order by A.ItemCode
  END
  ELSE IF @OPTION='ONLY_ORDERS' --SHOW ONLY ORDER ITEMS THAT HAVE AVAILABLE PAK>0
  BEGIN
		PRINT 'SHOWING ONLY ORDERED ITEMS FOR MOBILE APP'
			Select A.ITEMID as ID, A.ITEMCODE,A.ItemName, A.Itemname as Name,A.MRP,A.Rate1, A.Rate1 as Price,A.PACKINGTYPE,'' as Qty,   
			 A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, 
			 DETAILS AS [Description] ,A.DiscountPercent,
			 A.OFFERAVAILABLE,isnull(A.OFFERITEMNAME,'') OFFERITEMNAME ,isnull(A.OFFERPAKS,0) MINORDERFOROFFER,
			 isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,
			 trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName,
			 isnull(B.T_B,0) as AVAILABLE_PAKS
			 FROM BELL_ItemMaster A with (nolock) INNER JOIN Bell_LS B with (nolock) ON A.ITEMCODE=B.ITEMCODE AND A.ITEMNAME=B.ITEMNAME
			 and B.BILLDATE=@ORDERDATE and B.AREA=@LINE Where A.status='Active' and A.CATEGORY<>'RAW MATERIALS' 
			 order by A.ItemCode
  END
  ELSE IF @OPTION='FORMOBILE_MODIFIED' --SHOW ONLY MODIFIED ITEMS : TODO: TO BE IMPLEMENTED
  BEGIN
		PRINT 'SHOWING ONLY MODIFIED ITEMS FOR MOBILE APP'
  	 Select ITEMID as ID, ITEMCODE,ItemName, Itemname as Name,MRP,Rate1, Rate1 as Price,PACKINGTYPE,'' as Qty,   
	 TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, DETAILS AS [Description] ,
	 trim(@ImageURL + replace(ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,ImageUrl as ImageName
	 FROM BELL_ItemMaster with (nolock) Where status='Active' and CATEGORY<>'RAW MATERIALS'  AND ISMODIFIED='Y'
	 order by ItemCode
  END
   ELSE IF @OPTION = 'UPDATE_DISCOUNT' --TO UPDATE DISCOUNT TO ZERO FOR NON ELIGIBLE ITEMS.
  BEGIN
		PRINT 'UPDATING DISCOUNT TO ZERO FOR NON ELIGIBLE ITEMS.'
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
END  