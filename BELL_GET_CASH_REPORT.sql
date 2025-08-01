/*
select * from tblVANCASH_IN_DETAILS where received='Yes'
select * from tblVANCASH_IN_DETAILS 
select len('ddds') 

select * from tblvansalesbill_details WHERE BILLDATE='20250329' AND CASHID=688
UPDATE tblvansalesbill_details SET MILEAGE=6.9 WHERE BILLDATE='20250329' AND CASHID=688

*/


-- BELL_GET_SM_ONLINE_TRANSFERS  '28-Mar-2025','','','','30-Mar-2025',0,0,'SM_NAMES'
-- BELL_GET_SM_ONLINE_TRANSFERS  '28-Mar-2025','','BHASKAR','','',0,0,'DUES_GROUPBY_SM'
-- BELL_GET_SM_ONLINE_TRANSFERS  '','','','','',0,0,'DUES_BY_LINE'

-- BELL_GET_SM_ONLINE_TRANSFERS  '28-Mar-2025','','','','30-Mar-2025',0,0,'DUES_BY_LINE'
-- BELL_GET_SM_ONLINE_TRANSFERS  '','BELLAMPALLY','','','',0,0,'DUES_BY_LINE'

-- BELL_GET_SM_ONLINE_TRANSFERS  '28-Mar-2025','','','','30-Mar-2025',0,0,'LINE_SALES'
-- BELL_GET_SM_ONLINE_TRANSFERS  '28-Mar-2025','','','','All',0,1,'SM_ONLINE'
-- BELL_GET_SM_ONLINE_TRANSFERS  '22-Mar-2025','Bazar','ss','test','All',1,0,''
-- BELL_GET_SM_ONLINE_TRANSFERS  '30-Mar-2025','','','','All',1,0,''
-- BELL_GET_SM_ONLINE_TRANSFERS  '22-Mar-2025','','','','All',0,1,''
alter PROCEDURE BELL_GET_SM_ONLINE_TRANSFERS
@BILLDATE AS varchar(12),
@LINE AS VARCHAR(50),
@SALESMAN AS VARCHAR(30),
@PURPOSE AS VARCHAR(30),
@PAYMODE AS VARCHAR(12),  -- using it for date2 for other report AND is passing with correct date format like dd/MMM/yyyy
@STATUS AS int,
@ALLDATE AS int,
@REPORTTYPE AS VARCHAR(25)  -- EXTRA FOR DIFF REPORTS
AS
BEGIN
	DECLARE @STRSQLWHERE AS nVARCHAR(500),@SCRIPT AS nVARCHAR(MAX)

	if @REPORTTYPE='SM_ONLINE'  -- to view sales man line wise online transfers
	begin
				set @SCRIPT = 'select V.ID,V.CASHID,V.DENOMINATION,V.TOTAL,C.PAIDDATE,C.PURPOSE,C.PAIDTOPERSON,isnull(v.Received,''No'') as Received,C.USERNAME from tblVANCASH_IN_DETAILS V  inner join BELL_DAILYCASHFLOW C on	V.CASHID=C.ID WHERE V.total > 0 AND C.TRANSTYPE=''IN'' '
				set @STRSQLWHERE=''

				if @LINE <> '' 
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND PURPOSE='''+ @LINE +''''
				End

				If Len(@SALESMAN) > 0
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND PAIDTOPERSON=''' + @SALESMAN +''''
				End
	
				If @PAYMODE !='' And upper(@PAYMODE) != 'ALL'
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND V.denomination ='''+ @paymode +''''
				end
				Else
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND V.denomination in (''Bank'',''PhonePe'',''GPay'',''Scanner'') '
			   end
   
			   If @STATUS = 0 
			   begin
						set @STRSQLWHERE = @STRSQLWHERE + ' and isnull(Received,''No'')=''No'' '			
				end
			 --   Else 
				--begin
			 --          set @STRSQLWHERE = @STRSQLWHERE + ' and Received=''Yes'' '
				--end
	
				If @ALLDATE <> 1 
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND PAIDDATE=''' + @BILLDATE + ''''
				 end
	
				--print @STRSQLWHERE
				set @SCRIPT = @SCRIPT + @STRSQLWHERE + ' order by paiddate desc '
				print @SCRIPT
				exec sp_executesql @SCRIPT;
	end
	if @REPORTTYPE='LINE_SALES'
	begin
				--Declare @TOT_ONLINE AS money,@TOT_Expens AS money,@TOT_Dues AS money
				--set @TOT_ONLINE = (SELECT SUM(b.Total) from bell_dailycashflow A inner join tblVANCASH_in_DETAILS B on A.ID=B.CashID 
				--where a.paiddate=@BILLDATE and transtype='IN' and b.denomination in ('Bank','PhonePe','Gpay','Scanner') and b.Total>0 )
		
				--set @TOT_Expens=(SELECT sum(b.Total) from bell_dailycashflow A inner join tblVANCASH_OUT_DETAILS B on A.ID=B.CashID 
				--	where a.paiddate=@BILLDATE and transtype='IN' AND B.Total>0 )
				
				----ToDO: if any due payment made it should deduct from due amt.
				--set @TOT_Dues = (SELECT sum(b.Amount_Due) from bell_dailycashflow A inner join tblLineSalesManPendings B on A.ID=B.CashID 
				--where transtype='IN' AND Amount_Due>0 and a.paiddate=@BILLDATE )
				
				--select @TOT_ONLINE as TotOnline,@TOT_Expens as TotExpens,@TOT_Dues TotDues

			-- (select sum(amount) as commision from bell_dailycashflow b 	where b.paiddate=a.paiddate and (category='SALES COMMISSION' or purpose='COMMISSION') and a.paidtoperson=b.paidtoperson)
			-- commission can be separated
			set @SCRIPT = 'select cashid,line,salesman,billdate,totalamt,totcash_in,(totalamt-totcash_in) as tot_expense,totcash_out,grandtotal,total_km,diesel,mileage,total_due,username,vehicle_no,
					(select isnull(sum(amount),0) from BELL_LineSalesManPayments where due_cashid=a.cashid) as Amt_paid from tblvansalesbill_details a where GrandTotal>0  '			
			--select category,paiddate,purpose,paidtoperson,amount username,b. from bell_dailycashflow a inner join tblvansalesbill_details b on a.id=b.cashid where transtype='IN' 				
			
			set @STRSQLWHERE=''

				if @LINE <> '' 
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND Line='''+ @LINE +''''
				End

				If Len(@SALESMAN) > 0
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND SalesMan=''' + @SALESMAN +''''
				End
				If @BILLDATE <> '' 
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND Billdate>=''' + @BILLDATE + ''''
				 end
				If @PAYMODE <> '' 
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND Billdate<=''' + @PAYMODE + ''''   -- paymode is using for date2 
				 end
				--print @STRSQLWHERE
				set @SCRIPT = @SCRIPT + @STRSQLWHERE + ' order by Line,Billdate '
				print @SCRIPT
				exec sp_executesql @SCRIPT;
	end
	if @REPORTTYPE='DUES_GROUPBY_SM'
	Begin
		PRINT 'PAYMENT_DUES_BY_SM'
				set @SCRIPT = 'Select salesman,sum(amount_due) as Due, isnull((select sum(Amount) from BELL_LineSalesManPayments B where A.SalesMan=B.SalesMan),0) as Paid
				,(sum(amount_due) - isnull((select sum(Amount) from BELL_LineSalesManPayments B where A.SalesMan=B.SalesMan),0) ) as Balance 
				from tblLineSalesManPendings A WHERE 1=1 '
				set @STRSQLWHERE=''
				if @LINE <> '' 
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND Line='''+ @LINE +''''
				End
				If Len(@SALESMAN) > 0
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND SalesMan like ''%' + @SALESMAN + '%'''
				End
				set @SCRIPT = @SCRIPT + @STRSQLWHERE + '  Group by salesman order by salesman'
				print @SCRIPT
				exec sp_executesql @SCRIPT;

	End
	if @REPORTTYPE='DUES_BY_LINE'
	begin
			set @SCRIPT = 'Select ID, cashid as due_cashid,line,salesman,partyname,billdate,mobile,amount_due,
				isnull((select sum(Amount) from BELL_LineSalesManPayments B where A.Line=B.Line and A.SalesMan=B.SalesMan and A.PartyName=B.PartyName and a.billdate=b.billdate),0) as Amt_Paid,
				(amount_due - isnull((select sum(Amount) from BELL_LineSalesManPayments B where A.SalesMan=B.SalesMan and A.PartyName=B.PartyName and a.billdate=b.billdate),0) ) as Balance_Amt from tblLineSalesManPendings A where 1=1 '	
		
			set @STRSQLWHERE=''

				if @LINE <> '' 
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND Line='''+ @LINE +''''
				End
				If Len(@SALESMAN) > 0
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND SalesMan like ''%' + @SALESMAN + '%'''
				End
				If @BILLDATE <> '' 
				begin
					set @STRSQLWHERE = @STRSQLWHERE + ' AND Billdate=''' + @BILLDATE + ''''
				 end				
				--print @STRSQLWHERE
				set @SCRIPT = @SCRIPT + @STRSQLWHERE + ' order by Billdate desc'
				print @SCRIPT
				exec sp_executesql @SCRIPT;
	end
	if @REPORTTYPE='SM_NAMES'  -- List of distinct Sales mans from pendings table
	begin
		SELECT DISTINCT salesman FROM tblLineSalesManPendings  ORDER BY salesman
	end
end	
GO

