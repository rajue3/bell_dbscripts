
CREATE Procedure BELL_GET_TOTAL_SALES_BY_AREA_NEW  
@AREA as varchar(30) = null,  
@FROMDATE AS DATE = null,  
@SEARCHBY AS VARCHAR(15)  
AS               
BEGIN    
 --SELECT FORMAT(GetDate(), 'dd/MM/yyyy', 'en-US' ) AS 'Date' ,FORMAT(123456789,'###-##-####') AS 'Custom Number';  
 --,FORMAT(ActionDate, 'dd/MM/yyyy', 'en-US') as ActionDate   
 Declare @strQuery as varchar(1500)              
 Declare @strWhereQuery as varchar(500)  
 --PRINT @FromDate  
 IF (ISNULL(@FromDate,'') <> '' )  
 BEGIN  
  IF @SEARCHBY='BILLDATE'  
  BEGIN  
   select A.AREA  
      --,SUM(A.AMOUNT) AMOUNT  
      ,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT  
      ,count(distinct billnumber) as TotalBills,USERNAME,  
   FORMAT(A.BILLDATE, 'dd-MMM-yyyy', 'en-US') as BILLDATE FROM bhavani_ER_Bills A   
   WHERE A.AREA = (case lower(@AREA) when 'all' then A.AREA ELSE @AREA END)  
   AND CONVERT(varchar(10),BILLDATE,102) = CONVERT(varchar(10),@FROMDATE,102)  
   GROUP BY A.AREA,CAST(BILLDATE AS DATE),USERNAME  
   ORDER BY A.AREA  
  END  
  ELSE  
  BEGIN  
   select A.AREA  
      --,SUM(A.AMOUNT) AMOUNT  
      ,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT  
      ,count(distinct billnumber) as TotalBills,USERNAME,  
   FORMAT(A.BILLDATE, 'dd-MMM-yyyy', 'en-US') as BILLDATE FROM bhavani_ER_Bills A   
   WHERE A.AREA = (case lower(@AREA) when 'all' then A.AREA ELSE @AREA END)  
   AND CONVERT(varchar(10),ActionDate,102) = CONVERT(varchar(10),@FROMDATE,102)  
   GROUP BY A.AREA,CAST(BILLDATE AS DATE),USERNAME  
   ORDER BY A.AREA  
  END  
 END  
END    