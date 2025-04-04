select * from Bell_ItemMaster where itemcode in (16,17)

--TO UPDATE PURCHASE RATE AND MINIMUM ORDER ALERT VALUE FROM WEB APP.
ALTER PROCEDURE  BELL_UPD_ITEMS_PRATE_MINORDER  
@ITEMCODE AS INTEGER,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
@PRATE AS MONEY,  
@MINORDERALERT AS INTEGER,  
@STOCK AS INTEGER,
@USERNAME AS VARCHAR(30)      
AS                   
BEGIN          
  
    UPDATE Bell_ItemMaster SET PRATE=@PRATE, MINORDERALERT=@MINORDERALERT,USERNAME=@USERNAME,ActionDate=GETDATE()      
	,STOCK=@STOCK
    WHERE ITEMCODE=@ITEMCODE    -- AND ITEMNAME=@ITEMNAME

	UPDATE BELL_masterdata SET ItemValue=Convert(nvarchar(10),getdate(),120) WHERE ItemType='STOCK_COUNT_DATE'
END   