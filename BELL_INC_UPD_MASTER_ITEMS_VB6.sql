 Select Itemcode,itemname,packingtype,MRP,Category,TotalItemsInPack,Rate1,Rate2,Rate3,ISNULL(Stock,0) STOCK,ISNULL(MinOrderAlert,0) MinOrderAlert,Manufacture,OfferAvailable,Isnull(OfferItemname,'') OfferItemname,Isnull(OfferPaks,0) OfferPaks,DiscountPercent from Bell_ItemMaster Where status='Active' 
 
ALTER procedure BELL_INC_UPD_MASTER_ITEMS        
@ITEMCODE AS INTEGER,            
@ITEMNAME as varchar(50),            
@CATEGORY AS VARCHAR(30),        
@PACKINGTYPE AS VARCHAR(20),        
@TOTALITEMSINPACK AS INTEGER,        
@RATE1 AS VARCHAR(5),        
@RATE2 AS VARCHAR(5),        
@RATE3 AS VARCHAR(5),        
@MRP AS VARCHAR(5),        
@MINORDERALERT AS INTEGER,        
@STOCK as INTEGER,     
@USERNAME AS VARCHAR(30),            
@OFFERAVAILABLE as varchar(1) = 'N', --new params added on 25-sep-25    
@OFFERITEMNAME as varchar(50) = '', --new params added on 08-Dec-25    
@OFFERPAKS as integer = 0 ,  --new params added on 08-Dec-25    
@DISCOUNTPERCENT as integer = 0 ,  
@result int OUTPUT   
AS                         
BEGIN            
          
  IF NOT EXISTS(SELECT 'X' FROM Bell_ItemMaster WHERE ITEMNAME=@ITEMNAME AND ITEMCODE=@ITEMCODE)            
  BEGIN            
 --SELECT * FROM Bell_ItemMaster         
 INSERT INTO Bell_ItemMaster (ITEMCODE,ITEMNAME,PACKINGTYPE,MRP,TOTALITEMSINPACK,CATEGORY,RATE1,RATE2,RATE3,STOCK,MINORDERALERT,OFFERAVAILABLE,    
 OFFERITEMNAME,OFFERPAKS,DISCOUNTPERCENT,[STATUS],USERNAME )         
 VALUES(@ITEMCODE,@ITEMNAME,@PACKINGTYPE,@MRP,@TOTALITEMSINPACK,@CATEGORY,@RATE1,@RATE2,@RATE3,@STOCK,@MINORDERALERT,@OFFERAVAILABLE,    
 @OFFERITEMNAME,@OFFERPAKS,@DISCOUNTPERCENT ,'Active',@USERNAME)            
  END            
  ELSE            
  BEGIN            
    UPDATE Bell_ItemMaster SET PACKINGTYPE=@PACKINGTYPE,MRP=@MRP,TOTALITEMSINPACK=@TOTALITEMSINPACK,CATEGORY=@CATEGORY,        
 RATE1=@RATE1,RATE2=@RATE2,RATE3=@RATE3,STOCK=@STOCK, OFFERAVAILABLE=@OFFERAVAILABLE,OFFERITEMNAME=@OFFERITEMNAME,OFFERPAKS=@OFFERPAKS,
 DISCOUNTPERCENT=@DISCOUNTPERCENT,MINORDERALERT=@MINORDERALERT,[STATUS]='Active',USERNAME=@USERNAME,ActionDate=GETDATE()            
    WHERE ITEMNAME=@ITEMNAME AND ITEMCODE=@ITEMCODE          
  END                          
   SET @result = 1            
  SELECT @result AS RESULT            
END 