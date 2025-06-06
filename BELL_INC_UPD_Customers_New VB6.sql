/*
SELECT * FROM Bell_Cust_Master WHERE STATUS='DELETED' ORDER BY ACTIONDATE DESC
SELECT * FROM Bell_Cust_Master WHERE MOBILE ='6302895850'
SELECT * FROM Bell_Cust_Master WHERE line ='ASIFABAD'  and status='Active' order by area,shopname,mobile 
9705951962
and shopname like 'laxman%'

SHIVA KESAVA(SHIVASAIBAKERY[KHMM][THALL]

7780285221
9963177730

2025-02-24 10:07:10.880
2025-02-24 10:09:10.523
*/

-- BELL_INC_UPD_Customers_New  0,'KOTHAGUDA','GIRNIBAVI','RANJITH K/M (KTDA)(GIRINBAVI)','','E','9471204112','RAJU',0 ,'DELETE' 
-- BELL_INC_UPD_Customers_New  0,'TEST_LINE','TEST','SHOP','SALESMAN','CUST NAME','9581666602','RAJU',0 ,'DELETE' 
-- BELL_INC_UPD_Customers_New  0,'TEST LINE','TEST','SHOP','SALESMAN','CUST NAME','9581666602','RAJU',0  
ALTER procedure BELL_INC_UPD_Customers_New  
@CUSTID AS integer,  
@LINE as varchar(50),  
@AREA as varchar(50),  
@SHOP AS VARCHAR(50),  
@SALESMAN AS VARCHAR(30),  
@CUSTOMERNAME AS VARCHAR(100),  
@MOBILE AS VARCHAR(25),  
@USERNAME AS VARCHAR(20),  
@result int OUTPUT ,
@OPERATION AS VARCHAR(10) = ''  
  
AS               
BEGIN  
  --INSERT INTO Bell_Cust_Master (CUSTID,LINE,AREA,SHOPNAME,SALESMAN,CUSTOMERNAME,MOBILE,USERNAME,[STATUS]) VALUES(@CUSTID,@LINE,@AREA,@SHOP,@SALESMAN,@CUSTOMERNAME,@MOBILE,@USERNAME,'Active')  
  
IF @OPERATION = 'DELETE_DUPLICATE'  
BEGIN
	PRINT 'DELETE_DUPLICATE...'
	DECLARE @CUSTID_DEL AS INT
	IF (SELECT ID FROM  Bell_Cust_Master  WHERE LINE=@LINE AND AREA=@AREA AND  SHOPNAME=@SHOP AND MOBILE=@MOBILE) > 1
	BEGIN
		--SELECT @LINE_DEL,@AREA_DEL,@SHOP_DEL,@MOBILE_DEL
		--DELETE FROM Bell_Cust_Master WHERE ID=(SELECT TOP 1 ID FROM  Bell_Cust_Master  WHERE LINE=@LINE AND AREA=@AREA AND  SHOPNAME=@SHOP AND MOBILE=@MOBILE)
	    SELECT TOP 1 @CUSTID_DEL=ID FROM  Bell_Cust_Master  WHERE LINE=@LINE AND AREA=@AREA AND  SHOPNAME=@SHOP AND MOBILE=@MOBILE
		UPDATE Bell_Cust_Master SET STATUS='DELETE_DUPLICATE',ActionDate=GETDATE()  WHERE ID=(SELECT TOP 1 ID FROM  Bell_Cust_Master  WHERE LINE=@LINE AND AREA=@AREA AND  SHOPNAME=@SHOP AND MOBILE=@MOBILE)
	END
END
IF @OPERATION = 'DELETE'  
BEGIN
	PRINT 'DELETING...'
	--DECLARE @CUSTID_DEL AS INT
	--SELECT TOP 1 @CUSTID_DEL=ID FROM  Bell_Cust_Master  WHERE LINE=@LINE AND AREA=@AREA AND  SHOPNAME=@SHOP AND MOBILE=@MOBILE
	--SELECT @LINE_DEL,@AREA_DEL,@SHOP_DEL,@MOBILE_DEL
	--DELETE FROM Bell_Cust_Master WHERE ID=(SELECT TOP 1 ID FROM  Bell_Cust_Master  WHERE LINE=@LINE AND AREA=@AREA AND  SHOPNAME=@SHOP AND MOBILE=@MOBILE)
	UPDATE Bell_Cust_Master SET STATUS='DELETED',ActionDate=GETDATE()  WHERE ID=(SELECT TOP 1 ID FROM  Bell_Cust_Master  WHERE LINE=@LINE AND AREA=@AREA AND  SHOPNAME=@SHOP AND MOBILE=@MOBILE)
END
IF (@OPERATION='UPDATE')
 BEGIN
	PRINT 'UPDATING...'
	 IF NOT EXISTS(SELECT ID FROM Bell_Cust_Master WHERE LINE=@LINE AND AREA=@AREA AND  SHOPNAME=@SHOP AND STATUS='ACTIVE')  
	 BEGIN  
	  INSERT INTO Bell_Cust_Master (CUSTID,LINE,AREA,SHOPNAME,SALESMAN,CUSTOMERNAME,MOBILE,USERNAME,[STATUS]) VALUES(@CUSTID,@LINE,@AREA,@SHOP,@SALESMAN,@CUSTOMERNAME,@MOBILE,@USERNAME,'Active')  
	 END  
	  ELSE  
	  BEGIN  
		  UPDATE Bell_Cust_Master SET LINE=@LINE,AREA=@AREA,ShopName=@SHOP,SALESMAN=@SALESMAN,CustomerName=@CUSTOMERNAME,MOBILE=@MOBILE,  
		  USERNAME=@USERNAME,ACTIONDATE=GETDATE(),STATUS='Active'  WHERE LINE=@LINE AND AREA=@AREA AND  SHOPNAME=@SHOP
	  END	   
 END  
	SET @result = 1  
	SELECT @result AS RESULT  
END