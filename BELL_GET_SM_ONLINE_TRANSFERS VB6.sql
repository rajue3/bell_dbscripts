--  Select *,amount as Amt_Paid, (-1*amount) as Balance_Amt from BELL_LineSalesManPayments where  
  --line=(case when @LINE='' then line else @LINE end)  and salesman=(case when @SALESMAN='' then salesman else @SALESMAN end)  and   
  --Billdate is null and due_cashid is null  
  
  
--Select LINE,salesman,sum(amount_due) as Due, isnull((select sum(Amount) from BELL_LineSalesManPayments B where A.SalesMan=B.SalesMan and a.line=b.line),0) as Paid      
--    ,(sum(amount_due) - isnull((select sum(Amount) from BELL_LineSalesManPayments B where A.SalesMan=B.SalesMan and a.line=b.line),0) ) as Balance       
--    from tblLineSalesManPendings A WHERE 1=1  AND SalesMan = 'PRASAD'  and line='NARAYANAKED' Group by salesman,line order by salesman  
  
--select convert(varchar(10),b.due_date,101) due_date ,* from bell_dailycashflow b where transtype='OUT'   
--and (category like '%COMMISSION%' or purpose like '%COMMISSION%')   
--and CATEGORY='KHAMMAM (LOCAL)' and paidtoperson='KALYAN' and paiddate<'23-Apr-2025'  
  
-- BELL_GET_SM_ONLINE_TRANSFERS  '28-Mar-2025','','BHASKAR','','',0,0,'DUES_GROUPBY_SM'      
-- BELL_GET_SM_ONLINE_TRANSFERS  '','','MAHESH.CH','','',0,0,'DUES_GROUPBY_SM'      
-- BELL_GET_SM_ONLINE_TRANSFERS  '','','MAHESH.CH','','',0,0,'DUES_BY_LINE'      
-- BELL_GET_SM_ONLINE_TRANSFERS  '28-Mar-2025','','','','30-Mar-2025',0,0,'DUES_BY_LINE'      
-- BELL_GET_SM_ONLINE_TRANSFERS  '','BELLAMPALLY','','','',0,0,'DUES_BY_LINE'      
  
-- BELL_GET_SM_ONLINE_TRANSFERS  '23-Apr-2025','LAXETPETA','KALYAN ','','06-Apr-2025',0,0,'PENDING_COMM_DATES'      
-- BELL_GET_SM_ONLINE_TRANSFERS  '28-Mar-2025','','','','06-Apr-2025',0,0,'SALARY_REPORT'      
-- BELL_GET_SM_ONLINE_TRANSFERS  '28-Mar-2025','adva','','','06-Apr-2025',0,0,'SALARY_ADVANCE'        
-- BELL_GET_SM_ONLINE_TRANSFERS  '28-Mar-2025','','','','06-Apr-2025',0,0,'SALES_COMM_PAID'      
-- BELL_GET_SM_ONLINE_TRANSFERS  '28-Mar-2025','','','','06-Apr-2025',0,0,'LINE_SALES_COMMISSION'        
-- BELL_GET_SM_ONLINE_TRANSFERS  '28-Mar-2025','','','','30-Mar-2025',0,0,'SM_NAMES'            
-- BELL_GET_SM_ONLINE_TRANSFERS  '01-Apr-2025','BAZAR','','','16-Apr-2025',0,0,'LINE_SALES2'      
-- BELL_GET_SM_ONLINE_TRANSFERS  '01-Apr-2025','','','','30-Jul-2025',0,0,'LINE_SALES'      
  
-- BELL_GET_SM_ONLINE_TRANSFERS  '05-Apr-2025','','','','All',0,1,'SM_ONLINE'      
-- BELL_GET_SM_ONLINE_TRANSFERS  '22-Mar-2025','Bazar','ss','test','All',1,0,''      
-- BELL_GET_SM_ONLINE_TRANSFERS  '30-Mar-2025','','','','All',1,0,''      
-- BELL_GET_SM_ONLINE_TRANSFERS  '22-Mar-2025','','','','All',0,1,''      
ALTER PROCEDURE BELL_GET_SM_ONLINE_TRANSFERS      
@BILLDATE AS varchar(12),      
@LINE AS VARCHAR(50),      
@SALESMAN AS VARCHAR(30),      
@PURPOSE AS VARCHAR(30),      
@PAYMODE AS VARCHAR(12),  -- using it for date2 for other report AND is passing with correct date format like dd/MMM/yyyy      
@STATUS AS int,      
@ALLDATE AS int,      
@REPORTTYPE AS VARCHAR(25),  -- EXTRA FOR DIFF REPORTS  
@DRIVER AS VARCHAR(50) = ''
AS      
BEGIN      
 DECLARE @STRSQLWHERE AS nVARCHAR(500),@SCRIPT AS nVARCHAR(MAX)      
      
 if @REPORTTYPE='SM_ONLINE'  -- to view sales man line wise online transfers      
 begin      
    set @SCRIPT = 'select V.ID,V.CASHID,V.DENOMINATION,V.TOTAL,C.PAIDDATE,C.PURPOSE,C.PAIDTOPERSON,isnull(v.Received,''No'') as Received,C.USERNAME from tblVANCASH_IN_DETAILS V   
  inner join BELL_DAILYCASHFLOW C on V.CASHID=C.ID WHERE V.total > 0 AND C.TRANSTYPE=''IN'' '      
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
    -- where a.paiddate=@BILLDATE and transtype='IN' AND B.Total>0 )      
          
    ----ToDO: if any due payment made it should deduct from due amt.      
    --set @TOT_Dues = (SELECT sum(b.Amount_Due) from bell_dailycashflow A inner join tblLineSalesManPendings B on A.ID=B.CashID       
    --where transtype='IN' AND Amount_Due>0 and a.paiddate=@BILLDATE )      
          
    --select @TOT_ONLINE as TotOnline,@TOT_Expens as TotExpens,@TOT_Dues TotDues      
      
   -- (select sum(amount) as commision from bell_dailycashflow b  where b.paiddate=a.paiddate and (category='SALES COMMISSION' or purpose='COMMISSION') and a.paidtoperson=b.paidtoperson)      
   -- commission can be separated      
   set @SCRIPT = 'select cashid,line,salesman,billdate,totalamt,totcash_in,(totalamt-totcash_in) as tot_expense,totcash_out,grandtotal,total_km,diesel,mileage,total_due,username,vehicle_no,      
    (select isnull(sum(amount),0) from BELL_LineSalesManPayments where due_cashid=a.cashid) as Amt_paid from tblvansalesbill_details a where GrandTotal>0  '            
   --select category,paiddate,purpose,paidtoperson,amount username,b. from bell_dailycashflow a inner join tblvansalesbill_details b on a.id=b.cashid where transtype='IN'             
   
 select a.id as cashid,a.paiddate as billdate,a.purpose as line,a.paidtoperson as salesman,isnull(totalamt,amount) as totalamt,isnull(b.grandtotal,a.amount) as grandtotal   
 ,isnull(totcash_in,amount) as totcash_in, isnull((totalamt-totcash_in),0) as tot_expense,isnull(totcash_out,0) as totcash_out, isnull(total_km,0) total_km,isnull(diesel,0) diesel, isnull(mileage,0) mileage  
 ,isnull(total_due,0) as total_due,a.username,vehicle_no,b.Driver  
 ,(select isnull(sum(amount),0) from BELL_LineSalesManPayments where due_cashid=a.id) as Amt_paid  
 from BELL_DAILYCASHFLOW a left join tblvansalesbill_details b on a.id=b.cashid where category='line_sales' and TRANSTYPE='IN'  
 and purpose in (select distinct line from bell_lines where status='Active' and line is not null)    
 and a.paiddate>=@BILLDATE and a.paiddate <=@PAYMODE  
 and a.purpose=(case when @LINE='' then a.purpose else @LINE end)  
 and a.paidtoperson=(case when @SALESMAN='' then a.paidtoperson else @SALESMAN end)    
  and b.vehicle_no=(case when @PURPOSE='' then isnull(b.vehicle_no,'') else @PURPOSE end)    -- using @Purpose as Vehicle_no from VanSales_Bill report)  
 and b.Driver=(case when @DRIVER='' then isnull(b.Driver,'') else @DRIVER end) 
 order by a.paiddate   
  
   --set @STRSQLWHERE=''      
      
   -- if @LINE <> ''       
   -- begin      
   --  set @STRSQLWHERE = @STRSQLWHERE + ' AND Line='''+ @LINE +''''      
   -- End      
      
   -- If Len(@SALESMAN) > 0      
   -- begin      
   --  set @STRSQLWHERE = @STRSQLWHERE + ' AND SalesMan=''' + @SALESMAN +''''      
   -- End      
   -- If @BILLDATE <> ''       
   -- begin      
--  set @STRSQLWHERE = @STRSQLWHERE + ' AND Billdate>=''' + @BILLDATE + ''''      
   --  end      
   -- If @PAYMODE <> ''       
   -- begin      
   --  set @STRSQLWHERE = @STRSQLWHERE + ' AND Billdate<=''' + @PAYMODE + ''''   -- paymode is using for date2       
   --  end      
   -- --print @STRSQLWHERE      
   -- set @SCRIPT = @SCRIPT + @STRSQLWHERE + ' order by BILLDATE '    --Line,Billdate     
   -- print @SCRIPT      
   -- exec sp_executesql @SCRIPT;      
 end      
 if @REPORTTYPE='LINE_SALES2'      
 begin  
    select a.id,a.paiddate as billdate,a.purpose as line,a.paidtoperson as salesman,isnull(b.grandtotal,a.amount) as grandtotal from BELL_DAILYCASHFLOW a left join tblvansalesbill_details b on a.id=b.cashid where category='line_sales' and TRANSTYPE='IN'  
    and purpose in (select distinct line from bell_lines where status='Active' and line is not null)    
    and a.paiddate>=@BILLDATE and a.paiddate <=@PAYMODE  
    and a.purpose=(case when @LINE='' then a.purpose else @LINE end)  
    and a.paidtoperson=(case when @SALESMAN='' then a.paidtoperson else @SALESMAN end)   
    order by a.paiddate  
      
 end  
 if @REPORTTYPE='LINE_SALES_COMM'      
 begin              
 --select id,paiddate,category,purpose,paidtoperson,amount as Comm_Amt,isnull(due_date,'') as SalesDate    
 --,(select amount from bell_dailycashflow b  where transtype='IN' and b.paiddate = a.due_date and a.paidtoperson=b.paidtoperson and a.purpose=b.purpose) as SalesAmount    
 --from bell_dailycashflow a  where transtype='OUT' and (a.category like '%COMMISSION%' or purpose like '%COMMISSION%')     
   set @SCRIPT = 'select id,paiddate,category,purpose,paidtoperson,amount as Comm_Amt,isnull(due_date,'''') as SalesDate    
 ,(select amount from bell_dailycashflow b  where transtype=''IN'' and b.paiddate = a.due_date and a.paidtoperson=b.paidtoperson and a.category=b.purpose) as SalesAmount    
 from bell_dailycashflow a  where transtype=''OUT'' and (a.category like ''%COMMISSION%'' or purpose like ''%COMMISSION%'')   '        
         
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
     set @STRSQLWHERE = @STRSQLWHERE + ' AND Paiddate>=''' + @BILLDATE + ''''      
     end      
    If @PAYMODE <> ''       
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND Paiddate<=''' + @PAYMODE + ''''   -- paymode is using for date2       
     end      
    --print @STRSQLWHERE      
    set @SCRIPT = @SCRIPT + @STRSQLWHERE + ' order by Paiddate '    
    print @SCRIPT      
    exec sp_executesql @SCRIPT;      
 end      
 if @REPORTTYPE='SALARY_ADVANCE'      
 begin           
     
 --select id,category,paiddate,purpose,paidtoperson,amount,moredetails from BELL_DAILYCASHFLOW  where Transtype='out' and purpose='ADVANCE' and Category ='SALARY'     
    
   set @SCRIPT = 'select id,category,paiddate,purpose,paidtoperson,amount,moredetails from BELL_DAILYCASHFLOW  where Transtype=''out'' and Category =''SALARY''  '        
         
   set @STRSQLWHERE=''      
      
    if @LINE <> ''       
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND purpose like'''+ @LINE +'%'''      
    End      
      
    If Len(@SALESMAN) > 0      
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND paidtoperson=''' + @SALESMAN +''''      
    End      
    If @BILLDATE <> ''       
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND Paiddate>=''' + @BILLDATE + ''''      
     end      
    If @PAYMODE <> ''       
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND Paiddate<=''' + @PAYMODE + ''''   -- paymode is using for date2       
     end      
    --print @STRSQLWHERE      
    set @SCRIPT = @SCRIPT + @STRSQLWHERE + ' order by Paiddate '    
    print @SCRIPT      
    exec sp_executesql @SCRIPT;      
 end      
 if @REPORTTYPE='SALARY_REPORT'      
 begin            
  declare @SCRIPT2 as nvarchar(200)    
 --select person,isnull(Amount,0) as Salary,    
 --(select isnull(sum(amount),0) from BELL_DAILYCASHFLOW  b where Transtype='out' and Category ='SALARY' and purpose='Advance' and b.PAIDTOPERSON=a.PERSON) as Advance    
 --from BELL_CATEGORY_MASTER a where category='Salary' and fieldtype='out' and isnull(person,'') <> '' and purpose like 'Monthly%'    
    
   set @SCRIPT = 'select id,person,isnull(Amount,0) as Salary,isnull(purpose,'''') as purpose,    
 (select isnull(sum(amount),0) from BELL_DAILYCASHFLOW  b where Transtype=''out''and Category =''SALARY'' and purpose=''Advance'' and b.PAIDTOPERSON=a.PERSON '    
    
set @SCRIPT2 =' ) as Advance  from BELL_CATEGORY_MASTER a where category=''Salary'' and fieldtype=''out'' and isnull(person,'''') <> ''''  '        
    
   set @STRSQLWHERE=''      
   If @BILLDATE <> ''       
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND Paiddate>=''' + @BILLDATE + ''''      
     end      
    If @PAYMODE <> ''       
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND Paiddate<=''' + @PAYMODE + ''''   -- paymode is using for date2       
     end      
    --print @STRSQLWHERE      
    set @SCRIPT = @SCRIPT + @STRSQLWHERE + @SCRIPT2    
    
 set @STRSQLWHERE=''      
    if @LINE = ''       
 begin    
   set @STRSQLWHERE = @STRSQLWHERE + ' AND purpose like ''Monthly%'''    
 end    
 else    
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND purpose like'''+ @LINE +'%'''      
    End      
      
    If Len(@SALESMAN) > 0      
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND person=''' + @SALESMAN +''''      
    End      
    
 set @SCRIPT = @SCRIPT + @STRSQLWHERE + ' order by person'        
    print @SCRIPT      
    exec sp_executesql @SCRIPT;      
 end      
 if @REPORTTYPE='SALES_COMM_PAID'      
 begin           
     
 --select id,paiddate,category,purpose,paidtoperson,amount as Comm_Amt,isnull(due_date,'') as SalesDate    
 --,(select amount from bell_dailycashflow b  where transtype='IN' and b.paiddate = a.due_date and a.paidtoperson=b.paidtoperson and a.purpose=b.purpose) as SalesAmount    
 --from bell_dailycashflow a  where transtype='OUT' and (a.category like '%COMMISSION%' or purpose like '%COMMISSION%')      
     
 -- select id,paiddate,category,purpose,paidtoperson,amount as Comm_Amt,isnull(due_date,'') as SalesDate from bell_dailycashflow where transtype='OUT'     
   --and (category like '%COMM%' or purpose like '%COMM%')   order by due_date    
    
 --update  bell_dailycashflow set purpose='COMMISSION' where transtype='OUT' and purpose in ('COMMOSSION', 'COMIISSION', 'COMMISSINO', 'COMMMISSION')    
 set @SCRIPT = 'select * from bell_dailycashflow where transtype=''OUT'' and (category like ''%COMMISSION%'' or purpose like ''%COMMISSION%'')   '        
         
   set @STRSQLWHERE=''      
      
    if @LINE <> ''       
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND CATEGORY='''+ @LINE +''''      
    End      
      
    If Len(@SALESMAN) > 0      
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND paidtoperson=''' + @SALESMAN +''''      
    End      
    If @BILLDATE <> ''       
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND Paiddate>=''' + @BILLDATE + ''''      
     end      
    If @PAYMODE <> ''       
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND Paiddate<=''' + @PAYMODE + ''''   -- paymode is using for date2       
     end      
    --print @STRSQLWHERE      
    set @SCRIPT = @SCRIPT + @STRSQLWHERE + ' order by Paiddate  '    
    print @SCRIPT      
    exec sp_executesql @SCRIPT;      
 end      
 if @REPORTTYPE='DUES_GROUPBY_SM'      
 Begin      
  PRINT 'DUES_GROUPBY_SM'      
    set @SCRIPT = 'Select line,salesman,sum(amount_due) as Due, isnull((select sum(Amount) from BELL_LineSalesManPayments B where A.SalesMan=B.SalesMan and a.line=b.line),0) as Paid      
    ,(sum(amount_due) - isnull((select sum(Amount) from BELL_LineSalesManPayments B where A.SalesMan=B.SalesMan and a.line=b.line),0) ) as Balance       
    from tblLineSalesManPendings A WHERE 1=1 '      
    set @STRSQLWHERE=''      
    if @LINE <> ''       
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND Line='''+ @LINE +''''      
    End      
    If Len(@SALESMAN) > 0      
    begin      
     --set @STRSQLWHERE = @STRSQLWHERE + ' AND SalesMan like ''%' + @SALESMAN + '%'''      
  set @STRSQLWHERE = @STRSQLWHERE + ' AND SalesMan = ''' + @SALESMAN + ''''      
    End      
    set @SCRIPT = @SCRIPT + @STRSQLWHERE + '  Group by salesman,line order by salesman'      
    print @SCRIPT      
    exec sp_executesql @SCRIPT;      
      
 End      
 if @REPORTTYPE='DUES_BY_LINE'      
 begin      
  Select a.ID, a.cashid as due_cashid,a.line,a.salesman,a.partyname,a.billdate,a.mobile,a.amount_due,    
   isnull((select sum(Amount) from BELL_LineSalesManPayments B where a.cashid=b.due_cashid and a.line=b.line and a.salesman=b.salesman and a.partyname=b.partyname   
   and b.due_cashid is not null),0) as Amt_Paid,      
  (a.amount_due - isnull((select sum(Amount) from BELL_LineSalesManPayments B where a.cashid=b.due_cashid and a.line=b.line and a.salesman=b.salesman and   
  a.partyname=b.partyname  and b.due_cashid is not null),0) ) as Balance_Amt from tblLineSalesManPendings A where    
  line=(case when @LINE='' then line else @LINE end)  
  and salesman=(case when @SALESMAN='' then salesman else @SALESMAN end)  
  and Billdate=(case when @BILLDATE='' then Billdate else @BILLDATE end)  
 UNION  
  Select 0 as ID, 0 as due_cashid,line,salesman,partyname,billdate,'' mobile,'' as amount_due,amount as Amt_Paid, (-1*amount) as Balance_Amt from BELL_LineSalesManPayments where  
  --line=(case when @LINE='' then line else @LINE end)  and salesman=(case when @SALESMAN='' then salesman else @SALESMAN end)  and   
  Billdate is null and due_cashid is null  
    
  --Select 0 as ID, 0 as due_cashid,line,salesman,partyname,billdate,'' mobile,'' as amount_due,A.amount as Amt_Paid, (-1*A.amount) as Balance_Amt,B.PAYMENT_MODE from BELL_LineSalesManPayments A   
  --inner join BELL_DAILYCASHFLOW B on A.cashid=B.id where   
  ----line=(case when @LINE='' then line else @LINE end)   and salesman=(case when @SALESMAN='' then salesman else @SALESMAN end)  and   
  --Billdate is null and due_cashid is null    
    
   set @SCRIPT = 'Select a.ID, a.cashid as due_cashid,a.line,a.salesman,a.partyname,a.billdate,a.mobile,a.amount_due,    
     isnull((select sum(Amount) from BELL_LineSalesManPayments B where a.cashid=b.due_cashid and a.line=b.line and a.salesman=b.salesman and a.partyname=b.partyname),0) as Amt_Paid,      
    (a.amount_due - isnull((select sum(Amount) from BELL_LineSalesManPayments B where a.cashid=b.due_cashid and a.line=b.line and a.salesman=b.salesman and a.partyname=b.partyname),0) ) as Balance_Amt from tblLineSalesManPendings A where 1=1 '        
      
 --set @SCRIPT = 'Select a.ID, a.cashid as due_cashid,a.line,a.salesman,a.partyname,a.billdate,a.mobile,a.amount_due,    
 --isnull((select sum(Amount) from BELL_LineSalesManPayments B where A.Line=B.Line and A.SalesMan=B.SalesMan and a.billdate=b.billdate),0) as Amt_Paid,      
    --(amount_due - isnull((select sum(Amount) from BELL_LineSalesManPayments B where A.SalesMan=B.SalesMan and A.PartyName=B.PartyName and a.billdate=b.billdate),0) ) as Balance_Amt from tblLineSalesManPendings A where 1=1 '       
        
   set @STRSQLWHERE=''      
      
    if @LINE <> ''       
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND Line='''+ @LINE +''''      
    End      
    If Len(@SALESMAN) > 0      
    begin      
  set @STRSQLWHERE = @STRSQLWHERE + ' AND SalesMan= ''' + @SALESMAN + ''''         
    End      
    If @BILLDATE <> ''       
    begin      
     set @STRSQLWHERE = @STRSQLWHERE + ' AND Billdate=''' + @BILLDATE + ''''      
     end          
    --print @STRSQLWHERE      
    set @SCRIPT = @SCRIPT + @STRSQLWHERE + ' order by Billdate desc'      
   
 set @SCRIPT = @SCRIPT + 'union all '  
  
    --print @SCRIPT      
    --exec sp_executesql @SCRIPT;      
 end       
 if @REPORTTYPE='DUE_PAYMENTS1'      
 begin      
 if (@STATUS > 0)    
 begin    
   select a.id,a.cashid,a.line,a.salesman,c.partyname,a.billdate,a.paiddate,a.amount,a.actiondate,a.username,b.PAYMENT_MODE from BELL_LineSalesManPayments a     
   INNER JOIN BELL_DAILYCASHFLOW b ON a.cashid=b.id     
   INNER JOIN tblLineSalesManPendings C ON c.cashid=a.due_cashid  where a.due_cashid=@STATUS  --USING @STATUS for due_cashid here.    
   end    
   else    
   begin    
  select a.id,a.cashid,a.line,a.salesman,a.partyname,a.billdate,a.paiddate,a.amount,a.actiondate,a.username,b.PAYMENT_MODE from BELL_LineSalesManPayments a     
  INNER JOIN BELL_DAILYCASHFLOW b ON a.cashid=b.id where a.paiddate=@BILLDATE    --'Convert(date,@BILLDATE, 101)    
 end    
 end      
 if @REPORTTYPE='DUE_PAYMENTS2'      
 begin      
   select a.id,a.cashid,a.line,a.salesman,a.partyname,a.billdate,a.paiddate,a.amount,a.actiondate,a.username,b.PAYMENT_MODE from BELL_LineSalesManPayments a INNER JOIN BELL_DAILYCASHFLOW b ON a.cashid=b.id where a.salesman=@SALESMAN    
       
 end      
 if @REPORTTYPE='SM_NAMES'  -- List of distinct Sales mans from pendings table      
 begin      
  SELECT DISTINCT salesman FROM tblLineSalesManPendings  ORDER BY salesman      
  --SELECT DISTINCT salesman FROM SALESMAN_MASTER   
 end      
  if @REPORTTYPE='PENDING_COMM_DATES'  -- List of Sales man commission pending dates  
 begin        
  select distinct paiddate from BELL_DAILYCASHFLOW where Transtype='IN' and purpose=@line and paidtoperson=@salesman and paiddate<@BILLDATE  
  and convert(varchar(10),paiddate,101) not in   
  (  
   select convert(varchar(10),b.due_date,101) due_date from bell_dailycashflow b where transtype='OUT' and (category like '%COMMISSION%' or purpose like '%COMMISSION%') and 
   due_date is not null and category=@line and paidtoperson=@salesman and paiddate<@BILLDATE  
  )  
  select convert(varchar(10),b.due_date,101) due_date from bell_dailycashflow b where transtype='OUT' and (category like '%COMMISSION%' or purpose like '%COMMISSION%') and 
  due_date is not null and category=@line and paidtoperson=@salesman and paiddate<@BILLDATE  
 
 end    
  
end 