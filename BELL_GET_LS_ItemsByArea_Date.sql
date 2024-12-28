-- BELL_GET_LS_ItemsByArea_Date 'ETURNAGARAM','02-Nov-2024'  
-- BELL_GET_LS_ItemsByArea_Date 'MULUGU','14-JUN-2024'  
-- BELL_GET_LS_ItemsByArea_Date 'KARIMNAGAR','13-JUN-2024'  
CREATE Procedure BELL_GET_LS_ItemsByArea_Date  
@AREA as varchar(30) = null,  
@BILLDATE AS DATE = null  
AS               
BEGIN    
 IF (ISNULL(@BILLDATE,'') <> '' )  
 BEGIN  
  --select A.CUSTID, ITEMNAME,RATE,PACKETS,QTY,AMOUNT,BILLNUMBER, C.SHOPNAME, ISNULL(C.SALESMAN,'') SALESMAN,C.AREA,  
  --BILLDATE FROM bhavani_ER_Bills A INNER JOIN Bell_Cust_Master C ON C.CUSTID = A.CUSTID   
  --where C.AREA=@AREA  
  --AND CONVERT(varchar(10),BILLDATE,102) = CONVERT(varchar(10),@BILLDATE,102)  
    --INNER JOIN Bell_Cust_Master C ON C.CUSTID = A.CUSTID  
  
    select A.ITEMNAME,SUM(PACKETS) AS QTY,B.R_B AS RET_QTY,A.AREA  
    --,SUM(A.AMOUNT) AS AMOUNT,  
    ,CAST(ISNULL(SUM(AMOUNT)/100.0,0) AS DECIMAL(12,2)) AMOUNT      
   --,(select R_B AS RET_QTY2 FROM BELL_LS LS WHERE LS.AREA=@AREA AND CONVERT(varchar(10),LS.BILLDATE,102) = CONVERT(varchar(10),@BILLDATE,102)  
    --AND LS.ITEMCODE=A.ITEMCODE AND LS.ITEMNAME=A.ITEMNAME)  
  FROM bhavani_ER_Bills A INNER JOIN BELL_LS B ON A.AREA=B.AREA AND A.ITEMCODE=B.ITEMCODE AND A.BILLDATE=B.BILLDATE AND A.ITEMNAME=B.ItemName  
  where A.AREA=@AREA AND CONVERT(varchar(10),A.BILLDATE,102) = CONVERT(varchar(10),@BILLDATE,102)  
  GROUP BY A.ITEMCODE,A.ITEMNAME,A.AREA,B.R_B ORDER BY A.ITEMCODE  
 END  
END    