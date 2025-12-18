-- BELL_GET_WEB2LOCAL_BY_DATE '02-Nov-2025','02-Nov-2025','DELETEALLBYDATE' ,0    
-- BELL_GET_WEB2LOCAL_BY_DATE '30-Oct-2025','03-Nov-2025','WEB2LOCAL' ,2    
-- BELL_GET_WEB2LOCAL_BY_DATE '30-Oct-2025','03-Nov-2025','WEB2LOCAL' ,0    
-- BELL_GET_WEB2LOCAL_BY_DATE '19-Aug-2025','30-Aug-2025','WEB2LOCAL' ,-1    
ALTER PROCEDURE [zionwellmark_rajue].[BELL_GET_WEB2LOCAL_BY_DATE]         
@BILLDATE1 AS DATE,          
@BILLDATE2 AS DATE,          
@TRANSTYPE AS VARCHAR(20),  
@CashID as int = 0    -- if CashID=-1 and TransType='WEB2LOCAL' then it will retrieve all records iresspective of BillDate      
AS          
BEGIN          
    
IF @TRANSTYPE='DELETEALLBYDATE'        
 BEGIN    
  PRINT 'DELETEALLBYDATE - ' 
  print @Billdate1
	 Delete from bell_dailycashflow  where CONVERT(nvarchar(10),PAIDDATE,101) = CONVERT(nvarchar(10),@BILLDATE1,101) 
	 Delete from tblvansalesbill_details  where CONVERT(nvarchar(10),BILLDATE,101) = CONVERT(nvarchar(10),@BILLDATE1,101) 
	Delete from tblVANCASH_IN_DETAILS where CONVERT(nvarchar(10),ACTIONDATE,101) = CONVERT(nvarchar(10),@BILLDATE1,101)  
	Delete from tblVANCASH_OUT_DETAILS where  CONVERT(nvarchar(10),ACTIONDATE,101) = CONVERT(nvarchar(10),@BILLDATE1,101)  
	Delete from tblLineSalesManPendings where CONVERT(nvarchar(10),BILLDATE,101) = CONVERT(nvarchar(10),@BILLDATE1,101)  
	Delete from BELL_LineSalesManPayments where CONVERT(nvarchar(10),BILLDATE,101) = CONVERT(nvarchar(10),@BILLDATE1,101)  
	Delete from bell_tblCashApproval where CONVERT(nvarchar(10),TRANSDATE,101) = CONVERT(nvarchar(10),@BILLDATE1,101) 
 END
  IF @TRANSTYPE='BYCASHID'        
BEGIN  
  select * from BELL_DAILYCASHFLOW  WHERE ID=@CASHID  
END  
IF @TRANSTYPE='WEB2LOCAL'        
 BEGIN     
IF @CashID = -1   -- TO RETRIEVE ALL RECORDS FOR BACKUP      
 BEGIN      
  PRINT 'CashID=-1 and fetching all records'      
  select a.ID,a.category,a.paiddate,a.purpose,a.paidtoperson,a.amount,a.payment_mode,a.transtype,isnull(a.moredetails,'') moredetails,a.actiondate,a.username,      
  isnull(a.fileinfo,'') FileInfo,a.SEQ_NO,isnull(a.due_date,'') due_date,a.status      
  ,isnull(b.id,0) as VID,isnull(TOTALAMT, 0) as TOTALAMT,isnull(TOTCASH_IN,0) as TOTCASH_IN,isnull(TOTCASH_OUT,0) as TOTCASH_OUT,isnull(GRANDTOTAL,0) as GRANDTOTAL,          
  isnull(TOTAL_DUE,0) as TOTAL_DUE,isnull(TOTAL_KM,0) as TOTAL_KM, isnull(DIESEL,0) as DIESEL,isnull(MILEAGE,0) as MILEAGE,isnull(Vehicle_No,'') as Vehicle_No        
  ,isnull(b.Driver,'') as Driver      
  from bell_dailycashflow a left join tblvansalesbill_details b on a.id=b.cashid order by paiddate desc    
    END      
 ELSE IF @CASHID=0      -- TO GET ALL RECORDS BETWEEN GIVEN DATES
 BEGIN      
   select a.ID,a.category,a.paiddate,a.purpose,a.paidtoperson,a.amount,a.payment_mode,a.transtype,isnull(a.moredetails,'') moredetails,a.actiondate,a.username,      
   isnull(a.fileinfo,'') FileInfo,a.SEQ_NO,isnull(a.due_date,'') due_date,a.status      
   ,isnull(b.id,0) as VID,isnull(TOTALAMT, 0) as TOTALAMT,isnull(TOTCASH_IN,0) as TOTCASH_IN,isnull(TOTCASH_OUT,0) as TOTCASH_OUT,isnull(GRANDTOTAL,0) as GRANDTOTAL,          
   isnull(TOTAL_DUE,0) as TOTAL_DUE,isnull(TOTAL_KM,0) as TOTAL_KM, isnull(DIESEL,0) as DIESEL,isnull(MILEAGE,0) as MILEAGE,isnull(Vehicle_No,'') as Vehicle_No        
   ,isnull(b.Driver,'') as Driver      
   from bell_dailycashflow a left join tblvansalesbill_details b on a.id=b.cashid where         
   CONVERT(nvarchar(10),PAIDDATE,101) >= CONVERT(nvarchar(10),@BILLDATE1,101)   AND CONVERT(nvarchar(10),PAIDDATE,101) <= CONVERT(nvarchar(10),@BILLDATE2,101)       
   order by paiddate desc     
   -- where paiddate>=@BILLDATE  and paiddate<='20250329' order by a.id           
   END      
 ELSE IF @CASHID=2 -- TO GET ONLY STATUS='COMPLETED' RECORDS AND BETWEEN GIVEN DATES
 BEGIN      
	print 'TO GET ONLY COMPLETED RECORDS AND BETWEEN GIVEN DATES'
   select a.ID,a.category,a.paiddate,a.purpose,a.paidtoperson,a.amount,a.payment_mode,a.transtype,isnull(a.moredetails,'') moredetails,a.actiondate,a.username,      
   isnull(a.fileinfo,'') FileInfo,a.SEQ_NO,isnull(a.due_date,'') due_date,a.status      
   ,isnull(b.id,0) as VID,isnull(TOTALAMT, 0) as TOTALAMT,isnull(TOTCASH_IN,0) as TOTCASH_IN,isnull(TOTCASH_OUT,0) as TOTCASH_OUT,isnull(GRANDTOTAL,0) as GRANDTOTAL,          
   isnull(TOTAL_DUE,0) as TOTAL_DUE,isnull(TOTAL_KM,0) as TOTAL_KM, isnull(DIESEL,0) as DIESEL,isnull(MILEAGE,0) as MILEAGE,isnull(Vehicle_No,'') as Vehicle_No        
   ,isnull(b.Driver,'') as Driver      
   from bell_dailycashflow a left join tblvansalesbill_details b on a.id=b.cashid where         
   CONVERT(nvarchar(12),PAIDDATE,101) >= CONVERT(nvarchar(12),@BILLDATE1,101)   AND CONVERT(nvarchar(12),PAIDDATE,101) <= CONVERT(nvarchar(12),@BILLDATE2,101)
   AND A.STATUS='COMPLETED'
   order by paiddate desc     
   END      
 END          
 END  