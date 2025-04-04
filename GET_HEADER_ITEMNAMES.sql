DECLARE @script NVARCHAR(MAX);
--DECLARE @Result VARCHAR(MAX);
DECLARE @ItemNames VARCHAR(MAX);
DECLARE @ParmDefinition nvarchar(500);

set @script = N' 		
		SELECT @Result = STUFF((
		SELECT '','' + ''[['' + ISNULL(ItemName, '''') + '']]''   FROM Bell_ItemMaster WHERE STATUS=''Active''  ORDER BY ITEMCODE 
		FOR XML PATH('''')  ), 1, 2, '''') ; 	'		
	
	SET @ParmDefinition = N'@Result VARCHAR(MAX) OUTPUT';

	EXEC sp_executesql @script, @ParmDefinition, @Result=@ItemNames OUTPUT;

	--EXEC sp_executesql @script, N' @Result VARCHAR(MAX) OUTPUT', @Result OUTPUT;
	SELECT @ItemNames AS ItemNames;
	
	----
	DECLARE @ItemNamesQuery NVARCHAR(MAX);
DECLARE @Result VARCHAR(MAX);

-- Construct the query string
SET @ItemNamesQuery = N'
  SELECT @Result = 
    STUFF((
      SELECT '', '' + ''['' + ISNULL(ItemName, '''') + '']''
      FROM TableName
      FOR XML PATH('''')
    ), 1, 2, '''');
';

-- Execute the query and capture the output into @Result
EXEC sp_executesql @ItemNamesQuery, N'@Result VARCHAR(MAX) OUTPUT', @Result

	-- [[khara 5 RS]],[[moong dal 5 RS]]
 -- [[khara 5 RS]],[[moong dal 5 RS]]
 DECLARE @ItemNames VARCHAR(MAX);
SELECT @ItemNames =   STUFF((
    SELECT ',' + '[[' + ISNULL(ItemName, '') + ']]'   FROM Bell_ItemMaster WHERE STATUS='Active' ORDER BY ITEMCODE
	FOR XML PATH('')   ), 1, 2, '');


-- select dbo.GET_HEADER_ITEMNAMES(2)      
-- GET_HEADER_ITEMNAMES '[moong dal 5 RS]'
ALTER FUNCTION dbo.GET_HEADER_ITEMNAMES(@input int)  
RETURNS VARCHAR(MAX)  
AS  
BEGIN  
DECLARE @Query as nvarchar(300),  @queryItemNames AS NVARCHAR(MAX)
set @Query = ''
 set @queryItemNames = ''
--select @cols = STUFF((SELECT ',' + '['+ QUOTENAME(HEADER_NAME) + ']'    
  --     from #TEMP_HEADER    
  --     group by HEADER_NAME   
  --   FOR XML PATH(''), TYPE    
  --   ).value('.', 'NVARCHAR(MAX)')     
  --  ,1,1,'')      
 
DECLARE db_cursor CURSOR FOR 
SELECT ITEMNAME FROM Bell_ItemMaster WHERE STATUS='Active' order by itemcode 

DECLARE @itemname VARCHAR(50)  
DECLARE @cols AS NVARCHAR(MAX)  
DECLARE @CNT AS INT  
OPEN db_cursor    
FETCH NEXT FROM db_cursor INTO @itemname  
set @cols = ''  
SET @CNT = 0  
WHILE @@FETCH_STATUS = 0    
BEGIN    
 IF @CNT = 0    
 BEGIN  
  set @cols = '[[' + @itemname + ']]'  
 END  
 ELSE  
 BEGIN  
  set @cols = @cols + ',' + '[[' + @itemname + ']]'  
 END  
 SET @CNT  = @CNT +1  
   
    FETCH NEXT FROM db_cursor INTO @itemname   
END   
CLOSE db_cursor    
DEALLOCATE db_cursor  
RETURN @cols  
END  