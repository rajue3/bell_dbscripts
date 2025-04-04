-- select * from tbllinesalesmanpendings  where id=308
--** UPDATE THIS SP to get details with ID, it may fail in local app if using old version. 30-Mar-2025

ALTER PROCEDURE BELL_INS_UPD_CASH_TRANS
@CASHID INT,
@PAIDDATE AS DATE,
@CATEGORY AS VARCHAR(50),
@PURPOSE AS VARCHAR(50),
@PAIDTOPERSON AS VARCHAR(50),
@AMOUNT MONEY,
@PAYMENT_MODE AS VARCHAR(10),
@MOREDETAILS  AS VARCHAR(50),
@FILEINFO AS VARCHAR(50),
@TRANSTYPE AS VARCHAR(10),
@STATUS  AS VARCHAR(10),
@seq_no INT,
@USERNAME AS VARCHAR(50),
@result int OUTPUT    

AS
BEGIN
 --set @BILLDATE = CONVERT(varchar(10),@BILLDATE,101)    
-- iF (SELECT COUNT(1) FROM BELL_DAILYCASHFLOW WHERE CONVERT(varchar(10),PAIDDATE,101) = @PAIDDATE and CATEGORY=@CATEGORY  ) = 0     
 IF @CASHID = 0 
 BEGIN    
  	if @STATUS = 'DUE'   -- FOR cash-in entry from sales man due payments.
	BEGIN
			declare @old_cashid as int, @due_billdate as date,@partyname as varchar(50)			
			select @old_cashid=cashid,@due_billdate=billdate,@partyname=partyname from tbllinesalesmanpendings where id=@seq_no
			
			set @seq_no = (select count(1) from BELL_DAILYCASHFLOW where PAIDDATE=@PAIDDATE and TransType='IN') 
			Insert into BELL_DAILYCASHFLOW(PAIDDATE,CATEGORY,PURPOSE,PAIDTOPERSON,AMOUNT,PAYMENT_MODE,MOREDETAILS,TRANSTYPE,[STATUS],USERNAME,FILEINFO,seq_no) 
			 VALUES(@PAIDDATE,@CATEGORY,@PURPOSE + ' - Due' ,@PAIDTOPERSON,@AMOUNT,@PAYMENT_MODE,@MOREDETAILS,'IN','PENDING',@USERNAME,'',@seq_no+1)			
			set @result = (SELECT @@IDENTITY)
			
			Insert into BELL_LineSalesManPayments(CashID,due_cashid,Line,Salesman,PartyName,BillDate,PaidDate,Amount,Username) values 
			(@result,@old_cashid, @PURPOSE, @PAIDTOPERSON,@partyname,@due_billdate,@PAIDDATE ,@AMOUNT ,@username) 

			 SELECT @result AS RESULT    
	END
	ELSE 
	BEGIN
			Insert into BELL_DAILYCASHFLOW(PAIDDATE,CATEGORY,PURPOSE,PAIDTOPERSON,AMOUNT,PAYMENT_MODE,MOREDETAILS,TRANSTYPE,[STATUS],USERNAME,FILEINFO,seq_no) 
			VALUES(@PAIDDATE,@CATEGORY,@PURPOSE,@PAIDTOPERSON,@AMOUNT,@PAYMENT_MODE,@MOREDETAILS,@TRANSTYPE,@STATUS,@USERNAME,@FILEINFO,@seq_no)
			--set @result = (SELECT SCOPE_IDENTITY())
			set @result = (SELECT @@IDENTITY)
			--if (@GRANDTOTAL > 0 )
			--begin
			--	Insert into tblVANSALESBILL_DETAILS(CASHID,LINE,SALESMAN,BILLDATE,TOTALAMT,TOTCASH_IN,TOTCASH_OUT,GRANDTOTAL,TOTAL_DUE,TOTAL_KM, DIESEL,MILEAGE,USERNAME) 
			--	VALUES(@result,@line )
			--end 
			 SELECT @result AS RESULT    
		END
END
else
begin
	--TODO updated all values and actiondate
	UPDATE BELL_DAILYCASHFLOW SET AMOUNT=@AMOUNT WHERE ID=@CASHID
end
End
go
