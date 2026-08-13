/*    
--Update Bell_Cust_Master set CUSTOMERNAME='Bhavani_Test',SHOPNAME='Bell Brand',MOBILE='7981146053' Where ID=6      
--  select * from Bell_Cust_Master where Line='Ghanpur' and status='Active' order by Area asc  
select * from Bell_Cust_Master where LINE in ('BAZAR','BHAVANI','GATE','NEZAR')
select * from Bell_Cust_Master where isfordirectsales='yes' AND Status='Active'
--UPDATE Bell_Cust_Master SET ISFORDIRECTSALES='NO' where line in ('MEDAK','PALVANCHA','NEKKONDA')
--UPDATE Bell_Cust_Master SET ISFORDIRECTSALES='NO',ACTIONDATE=GETDATE() WHERE ISNULL(ISFORDIRECTSALES,'')='' AND LINE NOT IN ('ITEM SALE IN FACTORY','BAZAR')
SELECT * FROM Bell_Cust_Master WHERE ISNULL(ISFORDIRECTSALES,'')=''  AND LINE NOT IN ('ITEM SALE IN FACTORY','BAZAR')
UPDATE Bell_Cust_Master SET ISFORDIRECTSALES='YES',ACTIONDATE=GETDATE() WHERE ISNULL(ISFORDIRECTSALES,'')='' 
  
-- USP_GET_AREALIST_New not using    
    
USP_GET_LINE_AREA_SHOP_LIST 'users'    
    USP_GET_AREALIST 'LINEAREASHOPS'
 USP_GET_AREALIST 'category'    
 USP_GET_AREALIST 'lines'    
 USP_GET_AREALIST 'area'    
 USP_GET_AREALIST 'BHADRACHALAM'    
 USP_GET_AREALIST 'PARKAL'    
 USP_GET_AREALIST 'GAFERGADH'    
 USP_GET_AREALIST 'LINE_SALESMAN'
*/
ALTER procedure USP_GET_AREALIST  
@Type as varchar(20) = null,    
@FROMDATE AS DATE = null,        
@TODATE AS DATE = null        
AS    
Begin
IF (lower(@Type) = 'LINE_SALESMAN')      
 Begin      
       print 'LINE AND SALES MAN LIST'      
      Select Distinct LINE,MAX(isnull(Salesman, '')) AS Salesman from Bell_Cust_Master WITH (NOLOCK) where Status='Active'  AND ISFORDIRECTSALES<>'YES'  
      group by Line  order by Line
  end      
 ELSE IF (lower(@Type) = 'LINEAREASHOPS')      
 Begin      
   -- Select distinct line, salesman from Bell_Cust_Master where isnull(salesman,'')='' and Status='Active' AND ISFORDIRECTSALES<>'YES' 
    --Select Distinct LINE,AREA,ShopName,SALESMAN,CustomerName,MOBILE,ISFORDIRECTSALES from Bell_Cust_Master WITH (NOLOCK) where Status='Active'  
    
  --Select Distinct LINE,'' AREA,'' ShopName,'' SALESMAN,'' CustomerName,'' MOBILE,
  --ISNULL(ISFORDIRECTSALES,'NO') ISFORDIRECTSALES from Bell_Cust_Master WITH (NOLOCK) where Status='Active'  AND ISFORDIRECTSALES<>'YES'  
  Select Distinct LINE,'' AREA,'' ShopName,MAX(isnull(Salesman, '')) AS SALESMAN,'' CustomerName,'' MOBILE,
  ISNULL(ISFORDIRECTSALES,'NO') ISFORDIRECTSALES,ISNULL(IsShopPhotoRequired,'N') AS IsShopPhotoRequired from Bell_Cust_Master WITH (NOLOCK) where Status='Active'  AND ISFORDIRECTSALES<>'YES'  
  GROUP by Line,ISFORDIRECTSALES,IsShopPhotoRequired
  UNION
  SELECT LINE,ISNULL(AREA,'') AREA,ISNULL(SHOPNAME,'') SHOPNAME,'' SALESMAN,CustomerName,ISNULL(MOBILE,'') MOBILE,
  ISNULL(ISFORDIRECTSALES,'NO') ISFORDIRECTSALES,ISNULL(IsShopPhotoRequired,'N') AS IsShopPhotoRequired from Bell_Cust_Master WITH (NOLOCK) where Status='Active' AND ISFORDIRECTSALES='YES'     
  -- AND LINE in ('BAZAR','BHAVANI','GATE','NEZAR','ITEM SALE IN FACTORY')
 end      
 ELSE IF (lower(@Type) = 'users')    
 Begin    
    print 'its Item Categories'    
  Select Distinct USERNAME as LINE,'' as Area,'' as ShopName,'' as CustomerName from Bell_USERS WITH (NOLOCK) where Status='display'    
 end    
 else IF (lower(@Type) = 'groupname')    --NOT USING, maintenaing with static values for now.
 Begin    
    print 'its Group names like Cutmet, Kiranam....'    
  Select Distinct GROUPNAME  as LINE,'' as Area,'' as ShopName,'' as CustomerName  from Bell_Cust_Master WITH (NOLOCK) --where Status='Active'    
  --Select * from Bell_Cust_Master where CATEGORY LIKE 'CUTMET%'
 end    
  else IF (lower(@Type) = 'category')    
 Begin    
    print 'its Item Categories'    
  Select Distinct CATEGORY as LINE,'' as Area,'' as ShopName,'' as CustomerName  from Bell_ItemMaster WITH (NOLOCK) --where Status='Active'    
 end    
 else IF (lower(@Type) = 'lines')    
 Begin    
    print 'its line'    
  Select Distinct Line,'' as Area,'' as ShopName,'' as CustomerName  from Bell_Cust_Master WITH (NOLOCK) where Status='Active' and isnull(Line,'') <> '' order by Line    
 end    
 else    
 IF (@Type = 'area')    
 Begin    
    print 'its area'    
 select Distinct Area,Line,'' as ShopName,'' as CustomerName  from Bell_Cust_Master WITH (NOLOCK) where Status='Active' and isnull(Area,'')<>'' order by Area    
 end    
else    
 begin    
      print 'its shops'    
   if (select count(1) from Bell_Cust_Master WITH (NOLOCK) where Status='Active' and Line=@Type) > 0  
   begin  
   Select Distinct ShopName,CustomerName,'' as Area,'' as Line from Bell_Cust_Master WITH (NOLOCK) where Status='Active' and Line=@Type  order by ShopName    
  end  
  else  
  begin  
   Select Distinct ShopName,CustomerName,'' as Area,'' as Line from Bell_Cust_Master WITH (NOLOCK) where Status='Active' and Area=@Type  order by ShopName    
  end  
    --select distinct ShopName, '' as Area,'' as CustomerName,'' as Line FROM bhavani_ER_Bills A        
    --WHERE Area=@Type AND (CONVERT(varchar(10),BILLDATE,102) Between CONVERT(varchar(10),@FROMDATE,102) and CONVERT(varchar(10),@TODATE,102))        
    --order by ShopName       
 end    
End 