  
-- BELL_SP_GET_All_LS_Customers 'Asifabad','MANDAMARRI','all' ,'' 
-- BELL_SP_GET_All_LS_Customers 'ALL','ALL','all'  
-- BELL_SP_GET_All_LS_Customers 'ETURNAGARAM','all','all'  
alter Procedure BELL_SP_GET_All_LS_Customers    
@LINE as varchar(30) = NULL,  
@AREA as varchar(30) = NULL,  
@SHOP as varchar(30) = NULL , 
@CATEGORY as varchar(30) = NULL  
AS               
BEGIN    
  
 Declare @strQuery as varchar(1500)              
 Declare @strWhereQuery as varchar(500)              
 Declare @strGroupByQuery as varchar(500)              
 set @strWhereQuery='where STATUS = ''Active''' --WHERE 1=1 '      
 set @strGroupByQuery = ''  
 if (@SHOP = '') set @SHOP = 'all'  

 IF (@LINE <>'' AND @LINE IS NOT NULL and lower(@LINE) <> 'all')  
BEGIN   
	 Set @strWhereQuery = @strWhereQuery + ' AND LINE = ' + ''''+ @LINE + ''''  
END  
IF (@AREA <>'' AND @AREA IS NOT NULL and lower(@AREA) <> 'all')  
BEGIN  
	Set @strWhereQuery = @strWhereQuery + ' AND AREA = ' + ''''+ @AREA + ''''  
END  
IF (@CATEGORY <>'' AND @CATEGORY IS NOT NULL and lower(@CATEGORY) <> 'all')  
BEGIN   
	Set @strWhereQuery = @strWhereQuery + ' AND GROUPNAME = ' + '''' + @CATEGORY + ''''  
END  
-- --IF (@FromDate <>'' and @FromDate is not null)  
----set @strWhereQuery=@strWhereQuery +  N' AND (CONVERT(varchar(10),BILLDATE,102) Between '''+ CONVERT(varchar(10),@FromDate,102) + ''' and  '''+ CONVERT(varchar(10),@ToDate,102) + ''')'   
-- IF (@SHOP <>'' AND @SHOP IS NOT NULL and lower(@SHOP) <> 'all')  
-- BEGIN                                    
--    Set @strWhereQuery = @strWhereQuery + ' AND ShopName = ' + ''''+ @SHOP + ''''  
-- END  
--with group  
--SET @strQuery = 'select sum(Amount) as TotalAmount,count(1) as TotalItems,Area,ShopName,CustomerName,SalesMan FROM bhavani_ER_Bills '  
--without group   
--SET @strQuery = 'select ID,Area,ShopName,CustomerName,Mobile,SalesMan FROM bhavani_ER_Bills '  
SET @strQuery = 'select row_number() over(order by ID) as SNO,LINE,Area,ShopName,CustomerName,Mobile,SalesMan,Isnull(LandMark,'''') as LandMark,Isnull(Lng,'''') Longitude,isnull(Lat,'''') as Latitude,isnull(CATEGORY,'''') CATEGORY , isnull(GROUPNAME,'''') GROUPNAME,ISNULL(AREA_SEQ,0) AS AREA_SEQ,ISNULL(SHOP_SEQ,0) AS SHOP_SEQ from Bell_Cust_Master M '  

--SET @strQuery = 'select row_number() over(order by ID) as SNO,LINE,Area,ShopName,CustomerName,Mobile,SalesMan,Isnull(LandMark,'''') as LandMark,Isnull--(Lng,'''') Longitude,isnull(Lat,'''') as Latitude,isnull(CATEGORY,'''') CATEGORY , isnull(GROUPNAME,'''') GROUPNAME from Bell_Cust_Master M '  

--M.CustomerName in (select distinct customername from bhavani_ER_Bills where Area=M.Area and ShopName = M.ShopName)    
Print (@strQuery + @strWhereQuery)  
-- + ' group by Area,ShopName,CustomerName,SalesMan order by Area desc'  
EXEC(@strQuery + @strWhereQuery + ' ORDER BY LINE')  
  
END    