/*
select distinct a.ID,a.category,a.paiddate,a.purpose,a.paidtoperson,a.amount,a.payment_mode,a.transtype,isnull(a.moredetails,'') moredetails,a.actiondate,a.username,
		isnull(a.fileinfo,'') FileInfo,a.SEQ_NO,isnull(a.due_date,'') due_date,a.status 		from bell_dailycashflow a
	
		select 
		isnull(b.id,0) as VID,isnull(TOTALAMT, 0) as TOTALAMT,isnull(TOTCASH_IN,0) as TOTCASH_IN,isnull(TOTCASH_OUT,0) as TOTCASH_OUT,isnull(GRANDTOTAL,0) as GRANDTOTAL,    
		isnull(TOTAL_DUE,0) as TOTAL_DUE,isnull(TOTAL_KM,0) as TOTAL_KM, isnull(DIESEL,0) as DIESEL,isnull(MILEAGE,0) as MILEAGE,isnull(Vehicle_No,'') as Vehicle_No  
		,isnull(b.Driver,'') as Driver from tblvansalesbill_details b 
update tblLineSalesManPendings  set Received='N', Actiondate=getdate()  where ID=328   
  
SELECT b.id a.paiddate,a.purpose,b.salesman,b.partyname,b.Amount_Due from bell_dailycashflow A inner join tblLineSalesManPendings B on A.ID=B.CashID       
        where transtype='IN' AND Amount_Due>0 and     
  --a.paiddate=@BILLDATE     
  CONVERT(nvarchar(10),A.PAIDDATE,101) = CONVERT(nvarchar(10),'07/30/2025',101)    
  order by Line, Salesman,partyname      
  select CONVERT(nvarchar(10),'30-Jul-2025',101)   
  select   CONVERT(nvarchar(10),PAIDDATE,101)  from bell_dailycashflow  
  select * from tblLineSalesManPendings where ID=328   
  order by billdate desc  
  */  
  -- BELL_GET_CASH_TRANS_BY_DATE_new '20250312','LINES'      
  -- BELL_GET_CASH_TRANS_BY_DATE_new '20250312','SMANLIST'      
-- BELL_GET_CASH_TRANS_BY_DATE_new '20250313','TOT_OB'      
-- BELL_GET_CASH_TRANS_BY_DATE_new '20250404','TOT_OB'      
-- BELL_GET_CASH_TRANS_BY_DATE_new '20250407','TOT_OB'      
    
-- BELL_GET_CASH_TRANS_BY_DATE_new '20250407','TOT_OB_OLD'      
-- BELL_GET_CASH_TRANS_BY_DATE_new '20250405','TOT_OB_OLD'      
    
-- BELL_GET_CASH_TRANS_BY_DATE_new '20250404','TOT_OB_OLD'      
    
-- BELL_GET_CASH_TRANS_BY_DATE '28-Mar-2025','TOTALS'      
-- BELL_GET_CASH_TRANS_BY_DATE_NEW '14-Mar-2025','WEB2LOCAL' ,-1     
-- BELL_GET_CASH_TRANS_BY_DATE_NEW '14-Mar-2025','WEB2LOCAL'   
-- BELL_GET_CASH_TRANS_BY_DATE_NEW '11-Nov-2025','DUES'      
-- BELL_GET_CASH_TRANS_BY_DATE_NEW '22-Mar-2025','dues'      
-- BELL_GET_CASH_TRANS_BY_DATE_NEW '22-Mar-2025','TOT_OB'      
-- BELL_GET_CASH_TRANS_BY_DATE_NEW '22-Mar-2025','EXPENS'      
-- BELL_GET_CASH_TRANS_BY_DATE_NEW '17-Mar-2025','ONLINE'      
-- BELL_GET_CASH_TRANS_BY_DATE_NEW '01-Apr-2025','OUT'      
-- BELL_GET_CASH_TRANS_BY_DATE_NEW '02-Apr-2025','IN'      
alter PROCEDURE BELL_GET_CASH_TRANS_BY_DATE_NEW     
@BILLDATE AS DATE,      
@TRANSTYPE AS VARCHAR(10),      
@CashID as int = 0    -- if CashID=-1 and TransType='WEB2LOCAL' then it will retrieve all records iresspective of BillDate  
AS      
BEGIN      
 IF @TRANSTYPE = 'IN' OR @TRANSTYPE = 'OUT'       
 BEGIN      
 SELECT A.ID,A.CATEGORY,A.PURPOSE,A.PAIDTOPERSON,A.AMOUNT,A.SEQ_NO,A.payment_mode,isnull(fileinfo,'') as fileinfo, (select  GRANDTOTAL from tblVANSALESBILL_DETAILS B where A.ID=B.CASHID ) as  GRANDTOTAL,due_date FROM BELL_DAILYCASHFLOW A   WHERE     
 --PAIDDATE=@BILLDATE      
 CONVERT(nvarchar(10),PAIDDATE,101) = CONVERT(nvarchar(10),@BILLDATE,101)    
 AND A.TRANSTYPE=@TRANSTYPE ORDER BY SEQ_NO        
  END       
  ELSE IF @TRANSTYPE = 'ONLINE'      
  BEGIN      
  --SELECT a.paiddate,a.category,a.purpose,a.paidtoperson,b.Denomination,b.Total from bell_dailycashflow A inner join tblVANCASH_in_DETAILS B on A.ID=B.CashID       
  SELECT a.paiddate,a.category,a.purpose,a.paidtoperson,b.Denomination,b.Total from bell_dailycashflow A inner join tblVANCASH_in_DETAILS B on A.ID=B.CashID       
        where     
  -- a.paiddate=@BILLDATE     
  CONVERT(nvarchar(10),A.PAIDDATE,101) = CONVERT(nvarchar(10),@BILLDATE,101)    
  and transtype='IN' and b.denomination in ('Bank','PhonePe','Gpay','Scanner') and b.Total>0 order by a.purpose       
    
 END      
 ELSE IF @TRANSTYPE='EXPENS'      
 BEGIN      
   if @CashID > 0      
     SELECT a.paiddate,a.category,a.purpose,a.paidtoperson,b.expens,b.Total from bell_dailycashflow A inner join tblVANCASH_OUT_DETAILS B on A.ID=B.CashID       
      where     
   -- a.paiddate=@BILLDATE     
  CONVERT(nvarchar(10),A.PAIDDATE,101) = CONVERT(nvarchar(10),@BILLDATE,101)    
  and transtype='IN' AND B.Total>0 and A.ID=@CashID order by a.purpose       
   else      
   begin      
    SELECT a.paiddate,a.category,a.purpose,a.paidtoperson,b.expens,b.Total from bell_dailycashflow A inner join tblVANCASH_OUT_DETAILS B on A.ID=B.CashID       
    where     
  --a.paiddate=@BILLDATE     
  CONVERT(nvarchar(10),A.PAIDDATE,101) = CONVERT(nvarchar(10),@BILLDATE,101)    
  and transtype='IN' AND B.Total>0 order by a.purpose       
   end      
 END      
 ELSE IF @TRANSTYPE='DUES'      
 BEGIN       
  SELECT b.id, a.paiddate,a.purpose,b.salesman,b.partyname,b.Amount_Due,
--  ISNULL(Received,'No') Received 
  CASE WHEN LTRIM(RTRIM(ISNULL(Received, ''))) = '' THEN 'N'  ELSE Received 
  END AS Received
  from bell_dailycashflow A inner join tblLineSalesManPendings B on A.ID=B.CashID       
        where transtype='IN' AND Amount_Due>0 and     
  --a.paiddate=@BILLDATE     
  CONVERT(nvarchar(10),A.PAIDDATE,101) = CONVERT(nvarchar(10),@BILLDATE,101)    
  order by Line, Salesman,partyname      
 END      
 ELSE IF @TRANSTYPE='TOT_OB_OLD'      
 BEGIN      
   declare @InitialOB1 as money,@CashIN1 as money,@CashOUT1 as money,@OpenBal1 as money    
   set @InitialOB1=(select ItemValue from Bell_MasterData where Itemtype='OPEN_BALANCE')    
       
   select @CashIN1=sum(amount) from BELL_DAILYCASHFLOW where UPPER(ISNULL(PAYMENT_MODE,'CASH')) ='CASH' AND upper(TRANSTYPE)='IN' and     
   CONVERT(date,PAIDDATE,101) < CONVERT(date,@BILLDATE,101) GROUP BY TRANSTYPE      
       
   SELECT @CashOUT1 = sum(amount) from BELL_DAILYCASHFLOW where UPPER(ISNULL(PAYMENT_MODE,'CASH')) ='CASH' AND upper(TRANSTYPE)='OUT' and     
   CONVERT(date,PAIDDATE,101) < CONVERT(date,@BILLDATE,101) GROUP BY TRANSTYPE     
    
   set @OpenBal1 = @InitialOB1+@CashIN1 - @CashOUT1     
   select @OpenBal1 as OpenBal,@InitialOB1 as InitialOB,@CashIN1 as CashIN,@CashOUT1  AS CashOUT     
 end     
 ELSE IF @TRANSTYPE='TOT_OB'      
 BEGIN      
  --select sum(amount) AS AMOUNT,TRANSTYPE from BELL_DAILYCASHFLOW where PAIDDATE< @BILLDATE GROUP BY TRANSTYPE        
  --select sum(amount) AS AMOUNT,TRANSTYPE from BELL_DAILYCASHFLOW where UPPER(ISNULL(PAYMENT_MODE,'CASH')) ='CASH' AND    
 --  CONVERT(date,PAIDDATE,101) < CONVERT(date,@BILLDATE,101) GROUP BY TRANSTYPE        
 declare @PrevDate as date    
 set @PrevDate = CONVERT(date,dateadd(day,-1,@BILLDATE),101)      
 --SELECT DATENAME(weekday, CAST('2025-04-08' AS DATE)) AS Weekday;    
 if  DATENAME(weekday, CAST(@PrevDate AS DATE)) = 'Sunday'   set @PrevDate = CONVERT(date,dateadd(day,-2,@BILLDATE),101)         
		if (select count(1) from bell_tblCashApproval where CONVERT(date,TransDate,101) = CONVERT(date,@PrevDate,101)  ) > 0     
	 begin    
	   print 'data retrieved from bell_tblCashApproval '    
	   -- previous day cashinhand will become open balance for next day    
	   --select OpenBal,TotCashInHand,totCashIn,totCashOut from bell_tblCashApproval where CONVERT(date,TransDate,101) = CONVERT(date,dateadd(day,-1,@BILLDATE),101)    
	   select TotCashInHand as OpenBal,TRANSDATE from bell_tblCashApproval where CONVERT(date,TransDate,101) = CONVERT(date,@PrevDate,101)    
	 end    
	 else    
	 begin    
	   print 'data retrieved from InitialOpenbal + totalIN - totalOUT '    
	   declare @InitialOB as money,@CashIN as money,@OpenBal as money    
	   set @InitialOB=(select ItemValue from Bell_MasterData where Itemtype='OPEN_BALANCE')    
	   select @CashIN=sum(amount) from BELL_DAILYCASHFLOW where UPPER(ISNULL(PAYMENT_MODE,'CASH')) ='CASH' AND upper(TRANSTYPE)='IN' and     
	   CONVERT(date,PAIDDATE,101) < CONVERT(date,@BILLDATE,101) GROUP BY TRANSTYPE      
    
	   set @OpenBal = @InitialOB+@CashIN - (select sum(amount) from BELL_DAILYCASHFLOW where UPPER(ISNULL(PAYMENT_MODE,'CASH')) ='CASH' AND upper(TRANSTYPE)='OUT' and     
	   CONVERT(date,PAIDDATE,101) < CONVERT(date,@BILLDATE,101) GROUP BY TRANSTYPE )    
	   select @OpenBal as OpenBal,@InitialOB as InitialOB,@CashIN as CashIN    
	 end       
 END      
ELSE IF @TRANSTYPE='LINES'
BEGIN
	SELECT DISTINCT LINE,LINE AS FieldValue FROM bell_lines WHERE STATUS='Active' AND LINE IS NOT NULL ORDER BY LINE
END
 ELSE IF @TRANSTYPE='SMANLIST'      
 BEGIN      
  SELECT DISTINCT salesman,salesman AS FieldValue FROM tblLineSalesManPendings  ORDER BY salesman      
 END      
 ELSE IF @TRANSTYPE='WEB2LOCAL'      
 BEGIN      
	 IF @CashID = -1   -- TO RETRIEVE ALL RECORDS FOR BACKUP  
	 BEGIN  
		  PRINT 'CashID=-1 and fetching all records'  
		  select a.ID,a.category,a.paiddate,a.purpose,a.paidtoperson,a.amount,a.payment_mode,a.transtype,isnull(a.moredetails,'') moredetails,a.actiondate,a.username,  
		  isnull(a.fileinfo,'') FileInfo,a.SEQ_NO,isnull(a.due_date,'') due_date,a.status  
		  ,isnull(b.id,0) as VID,isnull(TOTALAMT, 0) as TOTALAMT,isnull(TOTCASH_IN,0) as TOTCASH_IN,isnull(TOTCASH_OUT,0) as TOTCASH_OUT,isnull(GRANDTOTAL,0) as GRANDTOTAL,      
		  isnull(TOTAL_DUE,0) as TOTAL_DUE,isnull(TOTAL_KM,0) as TOTAL_KM, isnull(DIESEL,0) as DIESEL,isnull(MILEAGE,0) as MILEAGE,isnull(Vehicle_No,'') as Vehicle_No    
		  ,isnull(b.Driver,'') as Driver  
		  from bell_dailycashflow a left join tblvansalesbill_details b on a.id=b.cashid order by a.id  
	 END  
	 ELSE  
	 BEGIN  
		   select a.ID,a.category,a.paiddate,a.purpose,a.paidtoperson,a.amount,a.payment_mode,a.transtype,isnull(a.moredetails,'') moredetails,a.actiondate,a.username,  
		   isnull(a.fileinfo,'') FileInfo,a.SEQ_NO,isnull(a.due_date,'') due_date,a.status  
		   ,isnull(b.id,0) as VID,isnull(TOTALAMT, 0) as TOTALAMT,isnull(TOTCASH_IN,0) as TOTCASH_IN,isnull(TOTCASH_OUT,0) as TOTCASH_OUT,isnull(GRANDTOTAL,0) as GRANDTOTAL,      
		   isnull(TOTAL_DUE,0) as TOTAL_DUE,isnull(TOTAL_KM,0) as TOTAL_KM, isnull(DIESEL,0) as DIESEL,isnull(MILEAGE,0) as MILEAGE,isnull(Vehicle_No,'') as Vehicle_No    
		   ,isnull(b.Driver,'') as Driver  
		   from bell_dailycashflow a left join tblvansalesbill_details b on a.id=b.cashid where     
		   CONVERT(nvarchar(10),PAIDDATE,101) = CONVERT(nvarchar(10),@BILLDATE,101)   order by a.id       
		   -- where paiddate>=@BILLDATE  and paiddate<='20250329' order by a.id       
	   END  
 END      
 ELSE IF @TRANSTYPE='TOTALS'      
 BEGIN      
  Declare @TOT_ONLINE AS money,@TOT_Expens AS money,@TOT_Dues AS money      
  set @TOT_ONLINE = (SELECT SUM(b.Total) from bell_dailycashflow A inner join tblVANCASH_in_DETAILS B on A.ID=B.CashID       
        where     
  --a.paiddate=@BILLDATE     
  CONVERT(nvarchar(10),A.PAIDDATE,101) = CONVERT(nvarchar(10),@BILLDATE,101)    
  and transtype='IN' and b.denomination in ('Bank','PhonePe','Gpay','Scanner') and b.Total>0 )      
        
  set @TOT_Expens=(SELECT sum(b.Total) from bell_dailycashflow A inner join tblVANCASH_OUT_DETAILS B on A.ID=B.CashID       
   where a.paiddate=@BILLDATE and transtype='IN' AND B.Total>0 )      
  set @TOT_Dues = (SELECT sum(b.Amount_Due) from bell_dailycashflow A inner join tblLineSalesManPendings B on A.ID=B.CashID       
        where transtype='IN' AND Amount_Due>0 and     
  --a.paiddate=@BILLDATE )      
  CONVERT(nvarchar(10),A.PAIDDATE,101) = CONVERT(nvarchar(10),@BILLDATE,101)    
  )    
        
 select @TOT_ONLINE as TotOnline,@TOT_Expens as TotExpens,@TOT_Dues TotDues      
 END      
END 