select * from BELL_ITEMMASTER order by actiondate desc
select * from Bell_Cust_Master WHERE line='SAI Ram Warangal'
select * from Bell_Cust_Master WHERE status<>'DELETED'
select * from bhavani_ER_Bills  order by actiondate desc

-- select * FROM Bell_Cust_Master  where area in ('bazar','Nezar','Geat','Bhavani')
-- select * from bhavani_ER_Bills  where billdate = '2025-Jan-07' AND AREA='BAZAR' AND BILLNUMBER=1  
--update bhavani_ER_Bills  set PRATE=RATE-RATE*0.05 WHERE PRATE ISNULL  
  
ALTER  procedure BELL_INC_UPD_Bills_NEW      
@AREA as varchar(30),            
@SHOP AS VARCHAR(50),            
@BILLDATE as DATE,            
@ITEMCODE AS integer,            
@ITEMNAME AS VARCHAR(50),            
@PRICE AS VARCHAR(5),            
@QTY AS VARCHAR(10),            
@PACKETS AS integer,            
@BILLNUMBER AS INTeger,            
@AMOUNT AS integer,            
@USERNAME AS VARCHAR(30),            
@result int OUTPUT,      
@DAMAGES INT = 0 ,    
@DISCOUNTED INT=0  , 
@OFFER_ITEM AS VARCHAR(30) = '',
@OFFER_RATE AS money=0.00,            
@OFFER_QTY AS INTEGER=0,
@SALESMAN AS nvarchar(30)=''
            
AS                         
BEGIN            
 --IF NOT EXISTS(SELECT SHOPNAME FROM Bell_Cust_Master WHERE AREA=@AREA AND SHOPNAME=@SHOP)            
 --BEGIN            
 -- INSERT INTO Bell_Cust_Master (CUSTID,AREA,SHOPNAME,[STATUS]) VALUES(0,@AREA,@SHOP,'Active')            
 --END            
 --set @BILLDATE = FORMAT(@BILLDATE, 'dd-MMM-yyyy', 'en-US')            
  set @BILLDATE = CONVERT(varchar(10),@BILLDATE,101)            
  DECLARE @PRATE AS MONEY,@AREA_LINE AS VARCHAR(50)          
          
  SELECT @PRATE=ISNULL(PRATE,RATE1) FROM Bell_ItemMaster WHERE   ITEMCODE=@ITEMCODE AND ITEMNAME=@ITEMNAME          
  SELECT @AREA_LINE= AREA FROM Bell_Cust_Master WHERE LINE=@AREA AND SHOPNAME=@SHOP AND STATUS='ACTIVE'             
        
  iF (SELECT COUNT(1) FROM bhavani_ER_Bills WHERE ITEMCODE=@ITEMCODE AND ITEMNAME=@ITEMNAME AND AREA=@AREA AND SHOPNAME=@SHOP            
     AND BILLNUMBER=@BILLNUMBER AND CONVERT(varchar(10),BILLDATE,101) = @BILLDATE) = 0             
 BEGIN            
  insert into bhavani_ER_Bills (ITEMCODE,ITEMNAME,RATE,PACKETS,QTY,AMOUNT,BILLNUMBER,BILLDATE,AREA,SHOPNAME,USERNAME,PRATE,AREA_LINE,DAMAGES,
  DISCOUNT,OFFER_ITEM,OFFER_RATE,OFFER_QTY,SALESMAN)             
  values(@ITEMCODE,@ITEMNAME,@PRICE,@PACKETS,@QTY,@AMOUNT,@BILLNUMBER,@BILLDATE,@AREA,@SHOP,@USERNAME,@PRATE,ISNULL(@AREA_LINE,@AREA),@DAMAGES,@DISCOUNTED,@OFFER_ITEM,@OFFER_RATE,@OFFER_QTY,@SALESMAN)
          
	  if (select count(1) from Bell_Cust_Master  where line = @area  and IsForDirectSales='Y')  > 0         
	  begin        
	   UPDATE BELL_ITEMMASTER SET STOCK=STOCK-@PACKETS,USERNAME=@USERNAME,ACTIONDATE=GETDATE() WHERE ITEMCODE=@ITEMCODE AND ITEMNAME=@ITEMNAME              
	  end        
	  END            
 ELSE            
 BEGIN            
        UPDATE bhavani_ER_Bills SET RATE=@PRICE,PACKETS=@PACKETS,QTY=@QTY,AMOUNT=@AMOUNT,USERNAME=@USERNAME          
  ,AREA_LINE=ISNULL(@AREA_LINE,@AREA),DAMAGES=@DAMAGES,DISCOUNT=@DISCOUNTED,
  OFFER_ITEM=@OFFER_ITEM,OFFER_RATE=@OFFER_RATE,OFFER_QTY=@OFFER_QTY,SALESMAN=@SALESMAN
  WHERE ITEMCODE=@ITEMCODE AND ITEMNAME=@ITEMNAME AND AREA=@AREA AND SHOPNAME=@SHOP AND          
        BILLNUMBER=@BILLNUMBER AND CONVERT(varchar(10),BILLDATE,101) = @BILLDATE            
          
  DECLARE @PREVIOUS_PACKETS AS INTEGER        
  SELECT @PREVIOUS_PACKETS=packets FROM bhavani_ER_Bills WHERE ITEMCODE=@ITEMCODE AND ITEMNAME=@ITEMNAME AND AREA=@AREA         
  AND SHOPNAME=@SHOP  AND BILLNUMBER=@BILLNUMBER AND CONVERT(varchar(10),BILLDATE,101) = @BILLDATE                
        
  if (select count(1) from Bell_Cust_Master  where line = @area  and IsForDirectSales='Y')  > 0         
  begin        
    UPDATE BELL_ITEMMASTER SET STOCK=STOCK+@PREVIOUS_PACKETS-@PACKETS,USERNAME=@USERNAME,ACTIONDATE=GETDATE() WHERE ITEMCODE=@ITEMCODE AND ITEMNAME=@ITEMNAME              
  end        
  END            
    SET @result = 1            
   SELECT @result AS RESULT            
END 