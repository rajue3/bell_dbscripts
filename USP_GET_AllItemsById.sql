-- USP_GET_AllItemsById     593

alter  Procedure USP_GET_AllItemsById    
@ID as varchar(30)    
AS               
BEGIN    
 declare @ImageURL as varchar(50)    
 --set @ImageURL = (Select top 1 FieldValue from tblAllMasterData where FieldType='ImageServerURL')    
 declare @RND as varchar(12)    
 select @RND = '?count=' + CONVERT(char,FLOOR(RAND()*(100-5+1)+5)); -- will get random no. from 5 to 100. used to refresh images immediately    
 set @ImageURL = (Select top 1 FieldValue from tblAllMasterData where FieldType='Bell_ImageServerURL')    
     
 --Select ITEMID as ID, ITEMID,ItemName, Itemname as Name,MRP,Rate, Rate as Price,PACKINGTYPE,'' as Qty,     
 --TOTALITEMSINPACK,CATEGORY, 1 as CategorID, trim(@ImageURL + ImageUrl  + @RND) as ImageUrl,[Description] FROM BELL_ItemMaster     
 --Where status='Active' and ITEMID=@ID  order by ItemName     
 Select ITEMID as ID, ITEMCODE,ItemName, Itemname as Name,MRP,Rate1,Rate1 as Rate, Rate1 as Price,PACKINGTYPE,'' as Qty,       
 TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,CATEGORY, 1 as CategorID, trim(@ImageURL + ImageUrl ) as ImageUrl, 
 trim(@ImageURL + ImageUrl  + @RND) as ImageUrlNew, DETAILS AS [Description] FROM BELL_ItemMaster       
 --[Description]    
 Where status='Active' and CATEGORY<>'RAW MATERIALS'  and ITEMID=@ID  order by ItemCode    
END 