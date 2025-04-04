-- BELL_GET_CASH_TRANS_BY_DATE '20250402','TOT_OB'  
-- BELL_GET_CASH_TRANS_BY_DATE '20250401','TOT_OB'  

-- BELL_GET_CASH_TRANS_BY_DATE '28-Mar-2025','TOTALS'  
-- BELL_GET_CASH_TRANS_BY_DATE '14-Mar-2025','WEB2LOCAL'  
-- BELL_GET_CASH_TRANS_BY_DATE '22-Mar-2025','dues'  
-- BELL_GET_CASH_TRANS_BY_DATE '22-Mar-2025','TOT_OB'  
-- BELL_GET_CASH_TRANS_BY_DATE '22-Mar-2025','EXPENS'  
-- BELL_GET_CASH_TRANS_BY_DATE '17-Mar-2025','ONLINE'  
-- BELL_GET_CASH_TRANS_BY_DATE '01-Apr-2025','OUT'  
-- BELL_GET_CASH_TRANS_BY_DATE '02-Apr-2025','IN'  
alter PROCEDURE BELL_GET_CASH_TRANS_BY_DATE_NEW 
@BILLDATE AS DATE,  
@TRANSTYPE AS VARCHAR(10),  
@CashID as int = 0  
AS  
BEGIN  
 IF @TRANSTYPE = 'IN' OR @TRANSTYPE = 'OUT'   
 BEGIN  
	SELECT A.ID,A.CATEGORY,A.PURPOSE,A.PAIDTOPERSON,A.AMOUNT,A.SEQ_NO,A.payment_mode,isnull(fileinfo,'') as fileinfo, (select  GRANDTOTAL from tblVANSALESBILL_DETAILS B where A.ID=B.CASHID ) as		GRANDTOTAL,due_date FROM BELL_DAILYCASHFLOW A   WHERE 
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
		SELECT a.paiddate,a.purpose,b.salesman,b.partyname,b.Amount_Due from bell_dailycashflow A inner join tblLineSalesManPendings B on A.ID=B.CashID   
        where transtype='IN' AND Amount_Due>0 and 
		--a.paiddate=@BILLDATE 
		CONVERT(nvarchar(10),A.PAIDDATE,101) = CONVERT(nvarchar(10),@BILLDATE,101)
		order by Line, Salesman,partyname  
 END  
 ELSE IF @TRANSTYPE='TOT_OB'  
 BEGIN  
  --select sum(amount) AS AMOUNT,TRANSTYPE from BELL_DAILYCASHFLOW where PAIDDATE< @BILLDATE GROUP BY TRANSTYPE    
  --select sum(amount) AS AMOUNT,TRANSTYPE from BELL_DAILYCASHFLOW where UPPER(ISNULL(PAYMENT_MODE,'CASH')) ='CASH'	AND
	--		CONVERT(date,PAIDDATE,101) < CONVERT(date,@BILLDATE,101) GROUP BY TRANSTYPE  

	--TODO: after updating latest code we can enable below code.
    if (select count(1) from bell_tblCashApproval where CONVERT(date,TransDate,101) = CONVERT(date,@BILLDATE,101)  ) > 0 
	begin
			select OpenBal,TotCashInHand,totCashIn,totCashOut from bell_tblCashApproval where CONVERT(date,TransDate,101) = CONVERT(date,@BILLDATE,101) 
	end
	else
	begin
			declare @InitialOB as money,@CashIN as money,@OpenBal as money
			set @InitialOB=(select ItemValue from Bell_MasterData where Itemtype='OPEN_BALANCE')
			select @CashIN=sum(amount) from BELL_DAILYCASHFLOW where UPPER(ISNULL(PAYMENT_MODE,'CASH')) ='CASH'	AND upper(TRANSTYPE)='IN' and 
			CONVERT(date,PAIDDATE,101) < CONVERT(date,@BILLDATE,101) GROUP BY TRANSTYPE  
			set @OpenBal = @InitialOB+@CashIN - (select sum(amount) from BELL_DAILYCASHFLOW where UPPER(ISNULL(PAYMENT_MODE,'CASH')) ='CASH'	AND upper(TRANSTYPE)='OUT' and 
			CONVERT(date,PAIDDATE,101) < CONVERT(date,@BILLDATE,101) GROUP BY TRANSTYPE )
			select @OpenBal as OpenBal
	end
 END  
 ELSE IF @TRANSTYPE='SMANLIST'  
 BEGIN  
  SELECT DISTINCT salesman FROM tblLineSalesManPendings  ORDER BY salesman  
 END  
 ELSE IF @TRANSTYPE='WEB2LOCAL'  
 BEGIN  
  select a.*,b.id as VID,isnull(TOTALAMT, 0) as TOTALAMT,isnull(TOTCASH_IN,0) as TOTCASH_IN,isnull(TOTCASH_OUT,0) as TOTCASH_OUT,isnull(GRANDTOTAL,0) as GRANDTOTAL,  
  isnull(TOTAL_DUE,0) as TOTAL_DUE,isnull(TOTAL_KM,0) as TOTAL_KM, isnull(DIESEL,0) as DIESEL,isnull(MILEAGE,0) as MILEAGE,isnull(Vehicle_No,'') as Vehicle_No  
  from bell_dailycashflow a left join tblvansalesbill_details b on a.id=b.cashid where 
  -- paiddate=@BILLDATE 
  CONVERT(nvarchar(10),PAIDDATE,101) = CONVERT(nvarchar(10),@BILLDATE,101)
  order by a.id   
  -- where paiddate>=@BILLDATE  and paiddate<='20250329' order by a.id   
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
GO

---- BELL_GET_CASH_TRANS_BY_DATE '28-Mar-2025','TOTALS'
---- BELL_GET_CASH_TRANS_BY_DATE '14-Mar-2025','WEB2LOCAL'
---- BELL_GET_CASH_TRANS_BY_DATE '22-Mar-2025','dues'
---- BELL_GET_CASH_TRANS_BY_DATE '22-Mar-2025','TOT_OB'
---- BELL_GET_CASH_TRANS_BY_DATE '22-Mar-2025','EXPENS'
---- BELL_GET_CASH_TRANS_BY_DATE '17-Mar-2025','ONLINE'
---- BELL_GET_CASH_TRANS_BY_DATE '29-Mar-2025','OUT'
---- BELL_GET_CASH_TRANS_BY_DATE '22-Mar-2025','IN'
--ALTER PROCEDURE BELL_GET_CASH_TRANS_BY_DATE
--@BILLDATE AS DATE,
--@TRANSTYPE AS VARCHAR(10),
--@CashID as int = 0
--AS
--BEGIN
--	IF @TRANSTYPE = 'IN' OR @TRANSTYPE = 'OUT' 
--	BEGIN
--  SELECT A.ID,A.CATEGORY,A.PURPOSE,A.PAIDTOPERSON,A.AMOUNT,A.SEQ_NO,A.payment_mode,isnull(fileinfo,'') as fileinfo, (select  GRANDTOTAL from tblVANSALESBILL_DETAILS B where A.ID=B.CASHID ) as GRANDTOTAL FROM BELL_DAILYCASHFLOW A 
--  WHERE PAIDDATE=@BILLDATE  AND A.TRANSTYPE=@TRANSTYPE ORDER BY SEQ_NO
--  END 
--  ELSE IF @TRANSTYPE = 'ONLINE'
--  BEGIN
--		--SELECT a.paiddate,a.category,a.purpose,a.paidtoperson,b.Denomination,b.Total from bell_dailycashflow A inner join tblVANCASH_in_DETAILS B on A.ID=B.CashID 
--		SELECT a.paiddate,a.category,a.purpose,a.paidtoperson,b.Denomination,b.Total from bell_dailycashflow A inner join tblVANCASH_in_DETAILS B on A.ID=B.CashID 
--        where a.paiddate=@BILLDATE and transtype='IN' and b.denomination in ('Bank','PhonePe','Gpay','Scanner') and b.Total>0 order by a.purpose 
--	END
--	ELSE IF @TRANSTYPE='EXPENS'
--	BEGIN
--			if @CashID > 0
--					SELECT a.paiddate,a.category,a.purpose,a.paidtoperson,b.expens,b.Total from bell_dailycashflow A inner join tblVANCASH_OUT_DETAILS B on A.ID=B.CashID 
--					where a.paiddate=@BILLDATE and transtype='IN' AND B.Total>0 and A.ID=@CashID order by a.purpose 
--			else
--			begin
--				SELECT a.paiddate,a.category,a.purpose,a.paidtoperson,b.expens,b.Total from bell_dailycashflow A inner join tblVANCASH_OUT_DETAILS B on A.ID=B.CashID 
--				where a.paiddate=@BILLDATE and transtype='IN' AND B.Total>0 order by a.purpose 
--			end
--	END
--	ELSE IF @TRANSTYPE='DUES'
--	BEGIN	
--		SELECT a.paiddate,a.purpose,b.salesman,b.partyname,b.Amount_Due from bell_dailycashflow A inner join tblLineSalesManPendings B on A.ID=B.CashID 
--        where transtype='IN' AND Amount_Due>0 and a.paiddate=@BILLDATE order by Line, Salesman,partyname
--	END
--	ELSE IF @TRANSTYPE='TOT_OB'
--	BEGIN
--		select sum(amount) AS AMOUNT,TRANSTYPE from BELL_DAILYCASHFLOW where PAIDDATE< @BILLDATE GROUP BY TRANSTYPE		
--	END
--	ELSE IF @TRANSTYPE='SMANLIST'
--	BEGIN
--		SELECT DISTINCT salesman FROM tblLineSalesManPendings  ORDER BY salesman
--	END
--	ELSE IF @TRANSTYPE='WEB2LOCAL'
--	BEGIN
--		select a.*,b.id as VID,isnull(TOTALAMT, 0) as TOTALAMT,isnull(TOTCASH_IN,0) as TOTCASH_IN,isnull(TOTCASH_OUT,0) as TOTCASH_OUT,isnull(GRANDTOTAL,0) as GRANDTOTAL,
--		isnull(TOTAL_DUE,0) as TOTAL_DUE,isnull(TOTAL_KM,0) as TOTAL_KM, isnull(DIESEL,0) as DIESEL,isnull(MILEAGE,0) as MILEAGE,isnull(Vehicle_No,'') as Vehicle_No
--		from bell_dailycashflow a left join tblvansalesbill_details b on a.id=b.cashid where paiddate=@BILLDATE order by a.id 
--		-- where paiddate>=@BILLDATE  and paiddate<='20250329' order by a.id 
--	END
--	ELSE IF @TRANSTYPE='TOTALS'
--	BEGIN
--		Declare @TOT_ONLINE AS money,@TOT_Expens AS money,@TOT_Dues AS money
--		set @TOT_ONLINE = (SELECT SUM(b.Total) from bell_dailycashflow A inner join tblVANCASH_in_DETAILS B on A.ID=B.CashID 
--        where a.paiddate=@BILLDATE and transtype='IN' and b.denomination in ('Bank','PhonePe','Gpay','Scanner') and b.Total>0 )
		
--		set @TOT_Expens=(SELECT sum(b.Total) from bell_dailycashflow A inner join tblVANCASH_OUT_DETAILS B on A.ID=B.CashID 
--			where a.paiddate=@BILLDATE and transtype='IN' AND B.Total>0 )
--		set @TOT_Dues = (SELECT sum(b.Amount_Due) from bell_dailycashflow A inner join tblLineSalesManPendings B on A.ID=B.CashID 
--        where transtype='IN' AND Amount_Due>0 and a.paiddate=@BILLDATE )
		
--		select @TOT_ONLINE as TotOnline,@TOT_Expens as TotExpens,@TOT_Dues TotDues
--	END
--END
--GO

