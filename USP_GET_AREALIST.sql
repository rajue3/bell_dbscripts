    
--Update Bell_Cust_Master set CUSTOMERNAME='Bhavani_Test',SHOPNAME='Bell Brand',MOBILE='7981146053' Where ID=6      
--  select * from Bell_Cust_Master where Line='Ghanpur' and status='Active' order by Area asc  
-- USP_GET_AREALIST_New not using    
    
-- USP_GET_LINE_AREA_SHOP_LIST 'users'    
-- USP_GET_AREALIST 'category'    
-- USP_GET_AREALIST 'lines'    
-- USP_GET_AREALIST 'area'    
-- USP_GET_AREALIST 'BHADRACHALAM'    
-- USP_GET_AREALIST 'ETURNAGARAM'    
-- USP_GET_AREALIST 'GAFERGADH'    
CREATE procedure USP_GET_AREALIST  
@Type as varchar(20) = null,    
@FROMDATE AS DATE = null,        
@TODATE AS DATE = null        
AS    
Begin    
  IF (lower(@Type) = 'users')    
 Begin    
    print 'its Item Categories'    
  Select Distinct USERNAME as LINE,'' as Area,'' as ShopName,'' as CustomerName from Bell_USERS where Status='display'    
 end    
  else IF (lower(@Type) = 'category')    
 Begin    
    print 'its Item Categories'    
  Select Distinct CATEGORY as LINE,'' as Area,'' as ShopName,'' as CustomerName  from Bell_ItemMaster --where Status='Active'    
 end    
 else IF (lower(@Type) = 'lines')    
 Begin    
    print 'its line'    
  Select Distinct Line,'' as Area,'' as ShopName,'' as CustomerName  from Bell_Cust_Master where Status='Active' and isnull(Line,'') <> '' order by Line    
 end    
 else    
 IF (@Type = 'area')    
 Begin    
    print 'its area'    
 select Distinct Area,Line,'' as ShopName,'' as CustomerName  from Bell_Cust_Master where Status='Active' and isnull(Area,'')<>'' order by Area    
 end    
else    
 begin    
      print 'its shops'    
   if (select count(1) from Bell_Cust_Master where Status='Active' and Line=@Type) > 0  
   begin  
   Select Distinct ShopName,CustomerName,'' as Area,'' as Line from Bell_Cust_Master where Status='Active' and Line=@Type  order by ShopName    
  end  
  else  
  begin  
   Select Distinct ShopName,CustomerName,'' as Area,'' as Line from Bell_Cust_Master where Status='Active' and Area=@Type  order by ShopName    
  end  
    --select distinct ShopName, '' as Area,'' as CustomerName,'' as Line FROM bhavani_ER_Bills A        
    --WHERE Area=@Type AND (CONVERT(varchar(10),BILLDATE,102) Between CONVERT(varchar(10),@FROMDATE,102) and CONVERT(varchar(10),@TODATE,102))        
    --order by ShopName       
 end    
End 