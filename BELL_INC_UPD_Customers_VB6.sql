  
-- BELL_INC_UPD_Customers 204,'TEST_LINE','TEST','SHOP','SALESMAN','CUST NAME','9581666602','RAJU',0  
-- BELL_INC_UPD_Customers 0,'TEST LINE','TEST','SHOP','SALESMAN','CUST NAME','9581666602','RAJU',0  
CREATE procedure BELL_INC_UPD_Customers  
@CUSTID AS integer,  
@LINE as varchar(50),  
@AREA as varchar(50),  
@SHOP AS VARCHAR(50),  
@SALESMAN AS VARCHAR(30),  
@CUSTOMERNAME AS VARCHAR(100),  
@MOBILE AS VARCHAR(20),  
@USERNAME AS VARCHAR(20),  
@result int OUTPUT  
  
AS               
BEGIN  
  INSERT INTO Bell_Cust_Master (CUSTID,LINE,AREA,SHOPNAME,SALESMAN,CUSTOMERNAME,MOBILE,USERNAME,[STATUS]) VALUES(@CUSTID,@LINE,@AREA,@SHOP,@SALESMAN,@CUSTOMERNAME,@MOBILE,@USERNAME,'Active')  
  /*  
 IF NOT EXISTS(SELECT CUSTID FROM Bell_Cust_Master WHERE LINE=@LINE AND AREA=@AREA AND  CustID=@CUSTID AND STATUS='ACTIVE')  
 BEGIN  
  INSERT INTO Bell_Cust_Master (CUSTID,LINE,AREA,SHOPNAME,SALESMAN,CUSTOMERNAME,MOBILE,USERNAME,[STATUS]) VALUES(@CUSTID,@LINE,@AREA,@SHOP,@SALESMAN,@CUSTOMERNAME,@MOBILE,@USERNAME,'Active')  
 END  
  ELSE  
  BEGIN  
      UPDATE Bell_Cust_Master SET LINE=@LINE,AREA=@AREA,ShopName=@SHOP,SALESMAN=@SALESMAN,CustomerName=@CUSTOMERNAME,MOBILE=@MOBILE,  
      USERNAME=@USERNAME,ACTIONDATE=GETDATE(),STATUS='Active'  WHERE CUSTID=@CUSTID  
  END  
  */  
   SET @result = 1  
  SELECT @result AS RESULT  
END  