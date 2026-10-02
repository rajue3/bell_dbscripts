/* 
USP_GET_AllItemsById
USP_Update_ItemDetails
ALTER TABLE BAZAR_ItemMaster ADD RATE1_CONDITION VARCHAR(10),RATE2_CONDITION VARCHAR(10),RATE3_CONDITION VARCHAR(10)
,DISCOUNT_CONDITION VARCHAR(10),STOCK_AVAILABLE INT
ALTER TABLE BAZAR_ItemMaster ADD SHOPNAME VARCHAR(50) DEFAULT '' NOT NULL;
SELECT * FROM BAZAR_ItemMaster
--UPDATE BAZAR_ItemMaster SET SHOPNAME='BAZAR' WHERE SHOPNAME IS NULL OR SHOPNAME=''
BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 'FORMOBILE','BAZAR','ALL'
BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 'FORMOBILE', 'BHAVANI','ACTIVE'
BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 'ITEMBYID','593',''  
BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 'LINE_ITEMBYID','LINE_ITEMS','593'
BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 'DELETEBYID','BHAVANI','99'

BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 'FORMOBILE_ALL','BHAVANI','ALL'
BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 'WEB','BHAVANI','Active'

BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 'LINE_ITEMS','LINE_WEB_ITEMS','ACTIVE'
https://bellbrand.in/bell_item_images/moong_dal_5_RS.jpg
https://api.bellbrand.in/bazar/GetAllMasterItemsAndShopNames_Bazar/FORMOBILE_ALL/BHAVANI/Active

BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 'GET_DAMAGED_ITEMS','BHAVANI','2026-09-12'
BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 'DELETE_DAMAGED_ITEMS','BHAVANI','2026-09-12',''
BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 'GET_ORDERED_ITEMS','BHAVANI','2026-09-11'


*/
alter Procedure BELL_GET_ALL_BAZAR_ITEMS_BY_SHOPNAME 
@OPTION as varchar(50) = NULL,  
@SHOPNAME AS VARCHAR(50) = null,
@STATUS AS VARCHAR(50) = 'Active',
@ITEMNAME AS VARCHAR(100) = ''
AS               
BEGIN     
declare @ImageURL as varchar(50)    
 declare @RND as varchar(12)    
 select @RND = '?count=' + CONVERT(char,FLOOR(RAND()*(1000-5+1)+5)); -- will get random no. from 5 to 100. used to refresh images immediately    
 set @ImageURL = (Select top 1 FieldValue from tblAllMasterData with (nolock) where FieldType='Bell_ImageServerURL')    

  -- for LINE items from factory.
  IF @SHOPNAME='LINE_ITEMS'
  BEGIN
      if @OPTION = 'LINE_WEB_ITEMS'    
      BEGIN    
        Select A.ITEMID as ID, A.ITEMCODE,A.ItemName,A.MRP,A.Rate1,A.Rate2,A.Rate3,A.PACKINGTYPE,'' as Qty,       
        A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl,     
         DETAILS AS [Description] ,A.DiscountPercent, A.STATUS,   
         A.OFFERAVAILABLE,isnull(A.OFFERITEMNAME,'') OFFERITEMNAME ,isnull(A.OFFERPAKS,0) MINORDERFOROFFER,    
         isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,ISNULL(STOCK,0) AVAILABLE_PAKS,   
         trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName  
         FROM BELL_ItemMaster A with (nolock) Where [STATUS]= (CASE WHEN @STATUS='ALL' THEN [STATUS] ELSE @STATUS END)   
         order by A.ItemCode    
      END  
      ELSE if @OPTION = 'LINE_ITEMBYID'    
      BEGIN    
          Select A.ITEMID as ID, A.ITEMCODE,A.ItemName,A.MRP,A.Rate1,A.Rate2,A.Rate3,A.PACKINGTYPE,'' as Qty,       
        A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl,     
         DETAILS AS [Description] ,A.DiscountPercent,A.STATUS,    
         A.OFFERAVAILABLE,isnull(A.OFFERITEMNAME,'') OFFERITEMNAME ,isnull(A.OFFERPAKS,0) MINORDERFOROFFER,    
         isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,ISNULL(STOCK,0) AVAILABLE_PAKS,   
         trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName  
         FROM BELL_ItemMaster A with (nolock) Where ITEMID=CAST(@STATUS AS INT)       
      END  
      ELSE if @OPTION = 'LINE_DELETEBYID'    
      BEGIN    
          UPDATE  BELL_ItemMaster SET STATUS='InActive',actiondate=getdate() Where ITEMID=CAST(@STATUS AS INT)   
          Select 'Success' as result  
      END  
    END

  ELSE   -- FOR SHOPNAMES
  BEGIN
  if @OPTION = 'FORMOBILE_ALL'  
  BEGIN
    Select A.ITEMID as ID, A.ITEMCODE,A.ItemName,A.MRP,A.Rate1,A.Rate2,A.Rate3,
    --RATE1_CONDITION,RATE2_CONDITION,RATE3_CONDITION,DISCOUNT_CONDITION,
    A.PACKINGTYPE,'' as Qty,A.STATUS,
    A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl,   
    --TODO: need to check if offer is available for this shop from below table and then only show.
        --IIF( EXISTS(SELECT ITEMNAME FROM BELL_LINE_WISE_OFFERS L WHERE (LINE=@LINE OR LINE='ALL') AND L.ITEMNAME=A.ITEMNAME),'Y','N' ) AS OFFERAVAILABLE
		--,IIF( EXISTS(SELECT ITEMNAME FROM BELL_LINE_WISE_OFFERS L WHERE (LINE=@LINE OR LINE='ALL') AND L.ITEMNAME=A.ITEMNAME),
     DETAILS AS [Description] ,A.DiscountPercent,A.OFFERAVAILABLE,
     OFFERITEMNAME=(CASE WHEN A.OFFERAVAILABLE='Y' THEN isnull(A.OFFERITEMNAME,'') ELSE '' END)
     --isnull(A.OFFERITEMNAME,'') OFFERITEMNAME      
     ,isnull(A.OFFERPAKS,0) MINORDERFOROFFER,
     isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,ISNULL(STOCK,0) AVAILABLE_PAKS, 
     trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName,SHOPNAME
     FROM BAZAR_ItemMaster A with (nolock) Where [STATUS]= (CASE WHEN @STATUS='ALL' THEN [STATUS] ELSE @STATUS END) 
     AND SHOPNAME=@SHOPNAME  --AND STOCK>0
     order by A.ItemCode  
     ----FOR CustomerNames and mobile
     --select distinct LINE,ShopName as CustomerName,Cust_Mobile as Mobile FROM Bazar_Mobile_Bills where ISNULL(SHOPNAME,'') <> '' AND LINE=@SHOPNAME
        SELECT distinct LINE,CustomerName,Mobile  FROM BAZAR_CUST_MASTER where Status='Active' and Isnull(CustomerName,'') <>'' and Line=@SHOPNAME

  END  
  else if @OPTION = 'FORMOBILE'  
  BEGIN
    Select A.ITEMID as ID, A.ITEMCODE,A.ItemName,A.MRP,A.Rate1,A.Rate2,A.Rate3,
    --RATE1_CONDITION,RATE2_CONDITION,RATE3_CONDITION,DISCOUNT_CONDITION,
    A.PACKINGTYPE,'' as Qty, A.STATUS,    
    A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl,   
     DETAILS AS [Description] ,A.DiscountPercent,A.OFFERAVAILABLE,
     OFFERITEMNAME=(CASE WHEN A.OFFERAVAILABLE='Y' THEN isnull(A.OFFERITEMNAME,'') ELSE '' END)
     --isnull(A.OFFERITEMNAME,'') OFFERITEMNAME      
     ,isnull(A.OFFERPAKS,0) MINORDERFOROFFER,
     isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,ISNULL(STOCK,0) AVAILABLE_PAKS, 
     trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName,SHOPNAME
     FROM BAZAR_ItemMaster A with (nolock) Where [STATUS]= (CASE WHEN @STATUS='ALL' THEN [STATUS] ELSE @STATUS END) 
     AND SHOPNAME=@SHOPNAME  --AND STOCK>0    
     order by A.ItemCode  
  END
  ELSE if @OPTION = 'WEB'  
  BEGIN  
  --Select ITEMID as ID, ITEMCODE,ItemName,MRP,Rate1,PACKINGTYPE,'' as Qty,     
  --TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl, DETAILS AS [Description] ,  
  --trim(@ImageURL + replace(ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,ImageUrl as ImageName  
  --FROM BAZAR_ItemMaster with (nolock)  
  --Where [STATUS]= (CASE WHEN @STATUS='ALL' THEN [STATUS] ELSE @STATUS END) 
  --AND SHOPNAME=@SHOPNAME ORDER BY ItemCode  

    Select A.ITEMID as ID, A.ITEMCODE,A.ItemName,A.MRP,A.Rate1,A.Rate2,A.Rate3,
    --RATE1_CONDITION,RATE2_CONDITION,RATE3_CONDITION,DISCOUNT_CONDITION,
    A.PACKINGTYPE,'' as Qty,A.STATUS,
    A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl,   
     DETAILS AS [Description] ,A.DiscountPercent,  
     A.OFFERAVAILABLE,isnull(A.OFFERITEMNAME,'') OFFERITEMNAME ,isnull(A.OFFERPAKS,0) MINORDERFOROFFER,  
     isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,ISNULL(STOCK,0) AVAILABLE_PAKS, 
     trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName,SHOPNAME
     FROM BAZAR_ItemMaster A with (nolock) Where [STATUS]= (CASE WHEN @STATUS='ALL' THEN [STATUS] ELSE @STATUS END) 
     AND SHOPNAME=@SHOPNAME  
     order by A.ItemCode  
  END
  ELSE if @OPTION = 'ITEMBYID'  
  BEGIN  
      Select A.ITEMID as ID, A.ITEMCODE,A.ItemName,A.MRP,A.Rate1,A.Rate2,A.Rate3,
      --RATE1_CONDITION,RATE2_CONDITION,RATE3_CONDITION,DISCOUNT_CONDITION,
      A.PACKINGTYPE,'' as Qty,A.STATUS,     
    A.TOTALITEMSINPACK,'' AS TOTALITEMSINCARTON,A.CATEGORY, 1 as CategorID, @ImageURL + replace(ImageUrl,' ','%20') as ImageUrl,   
     DETAILS AS [Description] ,A.DiscountPercent,  
     A.OFFERAVAILABLE,isnull(A.OFFERITEMNAME,'') OFFERITEMNAME ,isnull(A.OFFERPAKS,0) MINORDERFOROFFER,  
     isnull(A.OFFER_QTY_AVAIL,0) AS OFFER_QTY_AVAIL,ISNULL(STOCK,0) AVAILABLE_PAKS, 
     trim(@ImageURL + replace(A.ImageUrl,' ','%20' )+ @RND) as ImageUrlNew,A.ImageUrl as ImageName,SHOPNAME
     FROM BAZAR_ItemMaster A with (nolock) Where ITEMID=CAST(@SHOPNAME AS INT)     
  END
  ELSE if @OPTION = 'DELETEBYID'  
  BEGIN  
      UPDATE  BAZAR_ItemMaster SET STATUS='InActive',actiondate=getdate() Where ITEMID=CAST(@STATUS AS INT) AND SHOPNAME=@SHOPNAME
      Select 'Success' as result
  END
  ELSE if @OPTION = 'GET_DAMAGED_ITEMS'    
  BEGIN    
        select * from DBO.BAZAR_DAMAGE_ITEMS WHERE LINE=@SHOPNAME AND
        CAST(REQUESTED_DATE AS DATE)=CAST(@STATUS AS DATE) ORDER BY ITEMCODE
  END
  ELSE if @OPTION = 'GET_ORDERED_ITEMS'    
  BEGIN    
        select ITEMCODE,ITEMNAME,RATE,PACKETS,QTY,BILLDATE,AREA,ACTIONDATE,IS_DISCOUNTED,DISCOUNT,OFFER_ITEM,OFFER_QTY from bhavani_ER_Bills where 
        area=@SHOPNAME AND CAST(BILLDATE AS DATE)=CAST(@STATUS AS DATE) order by ITEMCODE
  END
  ELSE if @OPTION = 'DELETE_DAMAGED_ITEMS'    
  BEGIN    
        DELETE FROM BAZAR_DAMAGE_ITEMS where LINE=@SHOPNAME AND CAST(REQUESTED_DATE AS DATE)=CAST(@STATUS AS DATE) 
        AND ITEMNAME=@ITEMNAME
        SELECT 'ITEM DELETED SUCCESSFULLY'
  END
END -- END OF  IF @SHOPNAME='LINE_ITEMS'
END    