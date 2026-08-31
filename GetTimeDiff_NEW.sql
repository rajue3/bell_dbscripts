/*  
0001-01-01 00:00:00.0000000  
2026-04-27 16:25:07.0000000  
SELECT dbo.GetTimeDiff('2026-04-27 12:26:00', '2026-04-27 15:56:30','BILLED') AS TimeDifference;  
-- Output: 3h:30m:30s  
  
SELECT dbo.GetTimeDiff('2026-04-27 15:56:30', '2026-04-27 12:26:00','Billed') AS TimeDifference;  
-- Output: '' (empty string, since Date1 > Date2)  
  
SELECT dbo.GetTimeDiff('0001-01-01T00:00:00', '2026-04-27 15:56:30','NO CASH') AS TimeDifference;  
-- Output: '' (empty string, since Date1 is min date)  
--DROP FUNCTION GetTimeDiff  
*/  
ALTER FUNCTION dbo.GetTimeDiff_NEW
(  
    @date1 DATETIME2,  
    @date2 DATETIME2,  
    @SHOP_VISIT_STATUS VARCHAR(20)='BILLED',
    @ImageURL VARCHAR(200),
    @SHOPNAME VARCHAR(100)
)  
RETURNS VARCHAR(MAX)  
AS  
BEGIN  
    IF @SHOP_VISIT_STATUS<> 'BILLED'   
    BEGIN  
            RETURN @SHOP_VISIT_STATUS  
    END  
    -- Handle invalid cases  
    IF (@date1 > @date2)   
        OR (@date1 = '0001-01-01T00:00:00')   
        OR (@date2 = '0001-01-01T00:00:00')  
    BEGIN  
        RETURN '';  
    END  
  
    DECLARE @diffSeconds INT = DATEDIFF(SECOND, @date1, @date2);  
    DECLARE @hours INT = @diffSeconds / 3600;  
    DECLARE @minutes INT = (@diffSeconds % 3600) / 60;  
    DECLARE @seconds INT = @diffSeconds % 60;  
  
      RETURN ISNULL(CONCAT('Started: ',FORMAT(CAST(@date1 as DateTime),'hh:mm:ss'), '<br/>',  
    '   Ended:  ' , FORMAT(CAST(@date2 as DateTime),'hh:mm:ss'),  '<br/>',  
    ' (',@hours, 'h:', @minutes, 'm:', @seconds, 's',')','<br/>', ' <img src="',@ImageURL,@SHOPNAME,'" width=50 height=50 [preview]=true', ' />' )
     ,'');   

    -- <p-image src="' + @ImageURL + B.SHOP_VISIT_PHOTO_NAME + '"  alt="' +A.SHOPNAME+ '" width="50" height="50" [preview]="true" />'

    ----RETURN ISNULL(CONCAT(@hours, 'h:', @minutes, 'm:', @seconds, 's'),'');  
    --RETURN ISNULL(CONCAT('Started: ',FORMAT(CAST(@date1 as DateTime),'hh:mm:ss'), '<br/>',  
    --'   Ended:  ' , FORMAT(CAST(@date2 as DateTime),'hh:mm:ss'),  '<br/>',  
    --' (',@hours, 'h:', @minutes, 'm:', @seconds, 's',')'),'');   
  
    --RETURN ISNULL(CONCAT('Started: ',FORMAT(CAST(@date1 as DateTime),'dd-MMM-yyyy hh:mm:ss'), '<br/>',  
    --'   Ended:  ' , FORMAT(CAST(@date2 as DateTime),'dd-MMM-yyyy hh:mm:ss'),  '<br/>',  
    --' (',@hours, 'h:', @minutes, 'm:', @seconds, 's',')'),'');   
      
END;  