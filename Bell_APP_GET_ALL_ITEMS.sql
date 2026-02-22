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

-- Bell_APP_GET_ALL_ITEMS ''
-- Bell_APP_GET_ALL_ITEMS 'FORMOBILE_ALL'
alter Procedure Bell_APP_GET_ALL_ITEMS
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
	 FROM BELL_ItemMaster   
	 --[Description]
	 Where status='Active' and CATEGORY<>'RAW MATERIALS'  order by ItemCode
  END
  ELSE IF @OPTION='FORMOBILE_ALL' --SHOW ALL ITEMS
  BEGIN
	PRINT 'SHOWING ALL ITEMS FOR MOBILE APP'
  	 Select ITEMID as ID, ITEMCODE,ItemName, Itemname as Name,MRP,Rate1, Rate1 as Price,PACKINGTYPE,'' as Qty,   
	 TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, DETAILS AS [Description] ,
	 trim(@ImageURL + replace(ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,ImageUrl as ImageName
	 FROM BELL_ItemMaster Where status='Active' and CATEGORY<>'RAW MATERIALS' 
	 order by ItemCode
  END
  ELSE IF @OPTION='FORMOBILE_MODIFIED' --SHOW ONLY MODIFIED ITEMS : TODO: TO BE IMPLEMENTED
  BEGIN
	PRINT 'SHOWING ONLY MODIFIED ITEMS FOR MOBILE APP'
  	 Select ITEMID as ID, ITEMCODE,ItemName, Itemname as Name,MRP,Rate1, Rate1 as Price,PACKINGTYPE,'' as Qty,   
	 TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, DETAILS AS [Description] ,
	 trim(@ImageURL + replace(ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,ImageUrl as ImageName
	 FROM BELL_ItemMaster Where status='Active' and CATEGORY<>'RAW MATERIALS'  AND ISMODIFIED='Y'
	 order by ItemCode
  END
END  