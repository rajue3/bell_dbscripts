select * from tblAllMasterData
--update tblAllMasterData set FIELDVALUE='https://myorders.zionwellmark.in/Bell_Image/' where fieldtype='Bell_ImageServerURL'
--INSERT INTO tblAllMasterData(FIELDTYPE, FIELDVALUE,Description) VALUES('Bell_ImageServerURL','https://myorders.zionwellmark.in/Bell_Image/','for Bell Brand')
select * from tblItemMaster
select * from Bell_ItemMaster 
--ALTER TABLE Bell_ItemMaster MODIFY COL DETAILS
ALTER TABLE Bell_ItemMaster ADD DETAILS NVARCHAR(250) NULL
ALTER TABLE Bell_ItemMaster ADD ImageUrl NVARCHAR(200) NULL

update BELL_ItemMaster set ImageURl = 'https://myorders.zionwellmark.in/Bell_Image/item1.jpg', DETAILS='khara 5 RS' where ItemCode=1
update BELL_ItemMaster set ImageURl = 'https://myorders.zionwellmark.in/Bell_Image/item2.jpg', DETAILS='moong dal 5 RS' where ItemCode=2
update BELL_ItemMaster set ImageURl = 'https://myorders.zionwellmark.in/Bell_Image/item3.jpg', DETAILS='Alubujiya 5 RS' where ItemCode=3
update BELL_ItemMaster set ImageURl = 'https://myorders.zionwellmark.in/Bell_Image/item4.jpg', DETAILS='Bhoondi 5 RS' where ItemCode=4
update BELL_ItemMaster set ImageURl = 'https://myorders.zionwellmark.in/Bell_Image/item5.jpg', DETAILS='ABCD 5 RS' where ItemCode=5

Bell_APP_GET_ALL_ITEMS
alter Procedure Bell_APP_GET_ALL_ITEMS
AS             
BEGIN  
 --Select ItemName,Rate,PACKINGTYPE,TOTALITEMSINPACK,CATEGORY,STOCK,ImageUrl,Description FROM tblItemMaster  
 declare @ImageURL as varchar(50)  
 declare @RND as varchar(12)  
 select @RND = '?count=' + CONVERT(char,FLOOR(RAND()*(100-5+1)+5)); -- will get random no. from 5 to 100. used to refresh images immediately  
 set @ImageURL = (Select top 1 FieldValue from tblAllMasterData where FieldType='Bell_ImageServerURL')  
  
 --Select ITEMID as ProductID, ItemName as Name,Rate Price,PACKINGTYPE,  
 --TOTALITEMSINPACK Rating,CATEGORY as RatingDetail, 1 as CategorID, @ImageURL + ImageUrl as ImageUrl,Description FROM tblItemMaster  
 --where DisplayOrder > 0 order by DisplayOrder asc  
  
 --Select ITEMID as ProductID, ItemName as Name,MRP,Rate Price,PACKINGTYPE,  
 --TOTALITEMSINPACK,TOTALITEMSINCARTON,CATEGORY, 1 as CategorID, @ImageURL + ImageUrl as ImageUrl,Description FROM tblItemMaster  
 --where DisplayOrder > 0 order by DisplayOrder asc  
  
 --working script:  
 Select ITEMID as ID, ITEMCODE,ItemName, Itemname as Name,MRP,Rate1, Rate1 as Price,PACKINGTYPE,'' as Qty,   
 TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,CATEGORY, 1 as CategorID, trim(@ImageURL + ImageUrl  + @RND) as ImageUrl, DETAILS AS [Description] FROM BELL_ItemMaster   
 --[Description]
 Where status='Active' and CATEGORY<>'RAW MATERIALS'  order by ItemCode
 --where DisplayOrder > 0 order by DisplayOrder asc  
  
 --Just to test angular app  
 --Select id, CustomerName Firstname, 'Test Lname' LastName,'raju@gmail' as email,mobile Address,AreaName City, 'Male' Gender, 100 OrderCount  from tblCustomers  
END  