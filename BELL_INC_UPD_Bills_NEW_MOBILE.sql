-- Bell_APP_GET_ALL_ITEMS 'FORMOBILE_ALL'  
select * from bhavani_ER_Bills where username like 'From_Mobile'
--DELETE FROM bhavani_ER_Bills where username like 'From_Mobile'
select * FROM BELL_ItemMaster Where status='Active' and CATEGORY<>'RAW MATERIALS'   order by itemname
select * from BELL_ITEMMASTER where OFFERAVAILABLE='Y' and isnull(offeritemname,'') <> ''
select * from bhavani_ER_Bills where itemcode in (1,2,3,4)
select * from bhavani_ER_Bills where offer_item<>'' and itemcode in (1,2,3,4)
select itemcode, itemname,packets,qty,offer_qty,offer_item from bhavani_ER_Bills where offer_item<>'' and itemcode=1 order by actiondate desc
UPDATE BELL_ITEMMASTER SET OFFER_QTY_AVAIL = 1 where itemcode=2
UPDATE BELL_ITEMMASTER SET OFFER_QTY_AVAIL = 1 where itemcode=1
UPDATE BELL_ITEMMASTER SET OFFER_QTY_AVAIL = 3 where itemcode=3
UPDATE BELL_ITEMMASTER SET OFFER_QTY_AVAIL = 3 where itemcode=4
SELECT DESCRIPTION='OFFER : ' + OFFERITEMNAME + ' (' + CAST(OFFER_QTY_AVAIL AS VARCHAR) + ')  for ' + CAST(OFFERPAKS AS VARCHAR) + 'p'
FROM BELL_ITEMMASTER WHERE OFFERAVAILABLE='Y' and isnull(offeritemname,'') <> ''

--UPDATE BELL_ITEMMASTER SET DETAILS=''
UPDATE BELL_ITEMMASTER SET 
DETAILS='OFFER : ' + OFFERITEMNAME + ' (' + CAST(OFFER_QTY_AVAIL AS VARCHAR)  + ')  for ' + CAST(OFFERPAKS AS VARCHAR) + 'p'
WHERE OFFERAVAILABLE='Y' and isnull(offeritemname,'') <> ''

--for moong dal, each 24packets one SEV MURMURA 5 RS offer
--add new col 'MinOrderForOffer' , OfferPacks
--alter table BELL_ITEMMASTER add  OFFER_QTY_AVAIL int DEFAULT 0
--UPDATE BELL_ITEMMASTER SET OFFER_QTY_AVAIL = 1 where OFFERAVAILABLE='Y' and isnull(offeritemname,'') <> ''
select * from BELL_ITEMMASTER where status='Active' and isnull(offeritemname,'') <> ''
select * from bhavani_ER_Bills where username like '%From_Mobile%'
UPDATE bhavani_ER_Bills SET BILLDATE='3/4/2026 11:39:49 PM' WHERE BILLID=876984
-- created for Mobile app, but this has to merge with actual SP being used in VB6. 28-Feb-26  
BELL_INC_UPD_Bills_NEW_MOBILE 'Asifabad','KERAMERI','H.K.G.N (A.BAD)K.MRI)','3/4/2026 11:39:49 AM',1,'khara 5 RS',42,'40',40,1,200,'From_Mobile',0,0,'',0,0,'king','Cash'

ALTER procedure BELL_INC_UPD_Bills_NEW_MOBILE
@AREA as varchar(50),
@AREA_LINE as varchar(50),
@SHOP AS VARCHAR(50),            
@BILLDATE as DATETIME,
@ITEMCODE AS integer,            
@ITEMNAME AS VARCHAR(50),            
@PRICE AS VARCHAR(5),            
@QTY AS VARCHAR(10),            
@PACKETS AS integer,            
@BILLNUMBER AS INTeger,            
@AMOUNT AS integer,            
@USERNAME AS VARCHAR(30),            
@DAMAGES INT = 0 ,    
@DISCOUNTED INT=0  , 
@OFFER_ITEM AS VARCHAR(30) = '',
@OFFER_RATE AS money=0.00,            
@OFFER_QTY AS INTEGER=0,
@SALESMAN AS nvarchar(30)='',
@PAYMENT_MODE AS nvarchar(30)=''
AS                         
BEGIN            
    print 'billdate=' + cast(@billdate as varchar)
 --IF NOT EXISTS(SELECT SHOPNAME FROM Bell_Cust_Master WHERE AREA=@AREA AND SHOPNAME=@SHOP)            
 --BEGIN            
 -- INSERT INTO Bell_Cust_Master (CUSTID,AREA,SHOPNAME,[STATUS]) VALUES(0,@AREA,@SHOP,'Active')            
 --END            
 --set @BILLDATE = FORMAT(@BILLDATE, 'dd-MMM-yyyy', 'en-US')            
  
  --set @BILLDATE = CONVERT(varchar(10),@BILLDATE,101)            
  DECLARE @PRATE AS MONEY   --,@AREA_LINE AS VARCHAR(50)          
          
  SELECT @PRATE=ISNULL(PRATE,RATE1) FROM Bell_ItemMaster WHERE   ITEMCODE=@ITEMCODE AND ITEMNAME=@ITEMNAME          
  --SELECT @AREA_LINE= AREA FROM Bell_Cust_Master WHERE LINE=@AREA AND SHOPNAME=@SHOP AND STATUS='ACTIVE'          
        
  iF (SELECT COUNT(1) FROM bhavani_ER_Bills WHERE ITEMCODE=@ITEMCODE AND ITEMNAME=@ITEMNAME AND AREA=@AREA AND SHOPNAME=@SHOP            
     AND BILLNUMBER=@BILLNUMBER AND CONVERT(varchar(10),BILLDATE,101) = @BILLDATE) = 0             
 BEGIN            
  insert into bhavani_ER_Bills (ITEMCODE,ITEMNAME,RATE,PACKETS,QTY,AMOUNT,BILLNUMBER,BILLDATE,AREA,SHOPNAME,USERNAME,PRATE,AREA_LINE,DAMAGES,
  DISCOUNT,OFFER_ITEM,OFFER_RATE,OFFER_QTY,SALESMAN,PAYMENT_MODE) 
  values(@ITEMCODE,@ITEMNAME,@PRICE,@PACKETS,@QTY,@AMOUNT,@BILLNUMBER,@BILLDATE,@AREA,@SHOP,@USERNAME,@PRATE,ISNULL(@AREA_LINE,@AREA),@DAMAGES,@DISCOUNTED,@OFFER_ITEM,@OFFER_RATE,@OFFER_QTY,@SALESMAN,@PAYMENT_MODE)
          
	  if (select count(1) from Bell_Cust_Master  where line = @area  and IsForDirectSales='Y')  > 0         
	  begin        
	   UPDATE BELL_ITEMMASTER SET STOCK=STOCK-@PACKETS,USERNAME=@USERNAME,
       ACTIONDATE=GETDATE() WHERE ITEMCODE=@ITEMCODE AND ITEMNAME=@ITEMNAME              
	  end        
	  END            
 ELSE            
 BEGIN            
        UPDATE bhavani_ER_Bills SET RATE=@PRICE,PACKETS=@PACKETS,QTY=@QTY,AMOUNT=@AMOUNT,USERNAME=@USERNAME          
      ,AREA_LINE=ISNULL(@AREA_LINE,@AREA),DAMAGES=@DAMAGES,DISCOUNT=@DISCOUNTED,
      OFFER_ITEM=@OFFER_ITEM,OFFER_RATE=@OFFER_RATE,OFFER_QTY=@OFFER_QTY,SALESMAN=@SALESMAN,
      BILLDATE=@BILLDATE,PAYMENT_MODE=@PAYMENT_MODE,ACTIONDATE=GETDATE()
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
   SELECT 1 AS RESULT            
END 