/*  
DECLARE @TOT_BILLS INT,@TOT_SHOPS INT
WITH BILLS AS (
SELECT DISTINCT BILLNUMBER AS BILLS FROM bhavani_ER_Bills where AREA='KORUTLA' and billdate='2026-04-30'
        GROUP BY SHOPNAME,BILLNUMBER
)  
SELECT COUNT(BILLS) TOT_BILLS FROM TAB1
WITH SHOPS AS (
   SELECT COUNT(1) AS TOT_SHOPS FROM BELL_APP_SHOPS_VISIT_INFO where  LINE='KORUTLA' AND orderdate='2026-04-30'
)

BELL_INC_UPD_Bills_NEW_MOBILE_JSON 
'[{"ID":20,"ItemName":"Kajapuri 5 Rs","ItemCode":75,"Rate":"115","Qty":"6","packing_qty":"1C(6)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-03T00:00:00","MobileOrderDate":"2026-08-03T12:06:46","paymentmode":"Cash","BillDate":null,"Line":"NEZAR","Area":"NEZAR","Salesman":"","ShopName":"NEZAR","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":21,"ItemName":"Mysorepak 5 Rs","ItemCode":74,"Rate":"130","Qty":"6","packing_qty":"1C(6)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-03T00:00:00","MobileOrderDate":"2026-08-03T12:06:46","paymentmode":"Cash","BillDate":null,"Line":"NEZAR","Area":"NEZAR","Salesman":"","ShopName":"NEZAR","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":22,"ItemName":"Chikky 5 RS","ItemCode":62,"Rate":"180","Qty":"18","packing_qty":"3C(6)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-03T00:00:00","MobileOrderDate":"2026-08-03T12:06:46","paymentmode":"Cash","BillDate":null,"Line":"NEZAR","Area":"NEZAR","Salesman":"","ShopName":"NEZAR","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":23,"ItemName":"moong dal 5 RS","ItemCode":2,"Rate":"42","Qty":"72","packing_qty":"6C(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-03T00:00:00","MobileOrderDate":"2026-08-03T12:06:46","paymentmode":"Cash","BillDate":null,"Line":"NEZAR","Area":"NEZAR","Salesman":"","ShopName":"NEZAR","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":24,"ItemName":"khara 5 RS","ItemCode":1,"Rate":"42","Qty":"60","packing_qty":"5C(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-03T00:00:00","MobileOrderDate":"2026-08-03T12:06:46","paymentmode":"Cash","BillDate":null,"Line":"NEZAR","Area":"NEZAR","Salesman":"","ShopName":"NEZAR","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":25,"ItemName":"COFFE GOLD JAR 1/-","ItemCode":165,"Rate":"107","Qty":"16","packing_qty":"1C(16)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":2,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-03T00:00:00","MobileOrderDate":"2026-08-03T12:06:46","paymentmode":"Cash","BillDate":null,"Line":"NEZAR","Area":"NEZAR","Salesman":"","ShopName":"NEZAR","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":26,"ItemName":"12 pics Chikky","ItemCode":64,"Rate":"8.5","Qty":"372","packing_qty":"31D(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-03T00:00:00","MobileOrderDate":"2026-08-03T12:06:46","paymentmode":"Cash","BillDate":null,"Line":"NEZAR","Area":"NEZAR","Salesman":"","ShopName":"NEZAR","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":27,"ItemName":"CAKE 1RS","ItemCode":300,"Rate":"15","Qty":"40","packing_qty":"1C(40)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-03T00:00:00","MobileOrderDate":"2026-08-03T12:06:46","paymentmode":"Cash","BillDate":null,"Line":"NEZAR","Area":"NEZAR","Salesman":"","ShopName":"NEZAR","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":28,"ItemName":"ROUND CHIKKY","ItemCode":60,"Rate":"20","Qty":"20","packing_qty":"2K(10)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-03T00:00:00","MobileOrderDate":"2026-08-03T12:06:46","paymentmode":"Cash","BillDate":null,"Line":"NEZAR","Area":"NEZAR","Salesman":"","ShopName":"NEZAR","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null}]',
'NEZAR','2026-08-03'

BELL_INC_UPD_Bills_NEW_MOBILE_JSON 
'[{"ID":1,"ItemName":"CAKE 1RS","ItemCode":300,"Rate":"15","Qty":"40","packing_qty":"1C(40)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-03T00:00:00","MobileOrderDate":"2026-08-03T12:01:59","paymentmode":"Cash","BillDate":null,"Line":"GATE","Area":"GATE","Salesman":"","ShopName":"GATE","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":2,"ItemName":"ROUND CHIKKY","ItemCode":60,"Rate":"20","Qty":"20","packing_qty":"2K(10)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-03T00:00:00","MobileOrderDate":"2026-08-03T12:01:59","paymentmode":"Cash","BillDate":null,"Line":"GATE","Area":"GATE","Salesman":"","ShopName":"GATE","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":3,"ItemName":"OSMANIYA 3 RS","ItemCode":108,"Rate":"37","Qty":"30","packing_qty":"1C(30)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-03T00:00:00","MobileOrderDate":"2026-08-03T12:01:59","paymentmode":"Cash","BillDate":null,"Line":"GATE","Area":"GATE","Salesman":"","ShopName":"GATE","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null}]',
'GATE','2026-08-03'

BELL_INC_UPD_Bills_NEW_MOBILE_JSON 
'[{"ID":1,"ItemName":"Bhoondi 5 RS","ItemCode":4,"Rate":"42","Qty":"5","packing_qty":"5P","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-08-29T00:00:00","MobileOrderDate":"2026-08-29T19:09:05",
"paymentmode":"Online","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,
"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null}]','BHAVANI','2026-08-29'

*/

ALTER PROCEDURE BELL_INC_UPD_Bills_NEW_MOBILE_JSON
    @JsonData NVARCHAR(MAX),
    @LINE VARCHAR(50),   -- LINE
    @BILLDATE DATETIME2
AS
BEGIN
    SET NOCOUNT ON;

    -- Normalize BILLDATE if invalid
    IF ISNULL(@BILLDATE,'') = ''  OR @BILLDATE = '0001-01-01T00:00:00' OR DATEPART(year, @BILLDATE) < 1753
    BEGIN
        SELECT TOP 1 @BILLDATE = BILLDATE FROM BELL_LS WHERE AREA = @LINE ORDER BY BILLDATE DESC;
    END

    --SET @JsonData = REPLACE(@JsonData,'\','');
    -- Remove backslashes only if present (double-encoded JSON)
    IF @JsonData LIKE '%\\%'
    BEGIN
        SET @JsonData = REPLACE(@JsonData,'\','');
    END
    -------------------------------------------------------------------
    -- Build #Source from JSON + ItemMaster
    -------------------------------------------------------------------
    IF OBJECT_ID('tempdb..#Source') IS NOT NULL DROP TABLE #Source;

    SELECT 
        j.ItemCode, j.ItemName, j.Rate, j.Qty, j.packing_qty, j.Amount,
        j.BillNo, @BILLDATE AS BILLDATE, @LINE AS LINE, j.ShopName,
        ISNULL(j.Area,@LINE) AS Area, j.Ret_Qty,
        j.DiscountPercent, j.Offer_Item, j.Offer_Rate, j.Offer_Qty,
        j.Salesman, j.paymentmode, j.MobileOrderDate,
        ISNULL(im.PRATE, im.Rate1) AS PRATE
    INTO #Source
    FROM (
        SELECT 
            ItemCode, ItemName, Rate, Qty, packing_qty, Amount, BillNo, ShopName,
            Line, Area, Ret_Qty, DiscountPercent, Offer_Item, Offer_Rate, Offer_Qty,
            Salesman, paymentmode, MobileOrderDate
        FROM OPENJSON(@JsonData)
        WITH (
            ItemCode INT,
            ItemName NVARCHAR(100),
            Rate MONEY,
            Qty INT,
            packing_qty VARCHAR(20),
            Amount MONEY,
            BillNo NVARCHAR(50),
            ShopName NVARCHAR(100),
            Line NVARCHAR(50),
            Area NVARCHAR(50),
            Ret_Qty MONEY,
            DiscountPercent MONEY,
            Offer_Item NVARCHAR(100),
            Offer_Rate MONEY,
            Offer_Qty INT,
            Salesman NVARCHAR(50),
            paymentmode NVARCHAR(20),
            MobileOrderDate DATETIME2
        )
    ) j
    LEFT JOIN Bell_ItemMaster im 
        ON j.ItemCode = im.ItemCode AND j.ItemName = im.ItemName;

    -------------------------------------------------------------------
    -- Build #Previous for stock adjustment
    -------------------------------------------------------------------
    IF OBJECT_ID('tempdb..#Previous') IS NOT NULL DROP TABLE #Previous;

    SELECT s.ItemCode, s.ItemName, s.BillNo, s.ShopName,
           s.Qty AS NewPackets, b.Packets AS PreviousPackets
    INTO #Previous
    FROM #Source s
    INNER JOIN bhavani_ER_Bills b
        ON b.ItemCode = s.ItemCode
       AND b.ItemName = s.ItemName
       AND b.Area = @LINE
       AND b.ShopName = s.ShopName
       AND b.BillNumber = s.BillNo
       AND CAST(b.BillDate AS DATE) = CAST(@BILLDATE AS DATE);
    -------------------------------------------------------------------
    -- MERGE into bhavani_ER_Bills
    -------------------------------------------------------------------
    MERGE bhavani_ER_Bills AS target
    USING #Source AS source
        ON target.ItemCode = source.ItemCode
       AND target.ItemName = source.ItemName
       AND target.Area = source.Line
       AND target.ShopName = source.ShopName
       AND target.BillNumber = source.BillNo
       AND CAST(target.BillDate AS DATE) = CAST(source.BillDate AS DATE)
    WHEN MATCHED THEN
        UPDATE SET 
            target.Rate = source.Rate,
            target.Packets = source.Qty,
            target.Qty = source.packing_qty,
            target.Amount = source.Rate * source.Qty,
            target.Username = 'From_Mobile',
            target.Damages = isnull(source.Ret_Qty,0),
            target.Discount = source.DiscountPercent,
            target.Offer_Item = source.Offer_Item,
            target.Offer_Rate = isnull(source.Offer_Rate,0),
            target.Offer_Qty = source.Offer_Qty,
            target.Salesman = source.Salesman,
            target.BillDate = source.BillDate,
            target.MobileOrderDate = source.MobileOrderDate,
            target.Payment_Mode = source.paymentmode,
            target.PRATE = source.PRATE,
            target.ActionDate = GETDATE()
    WHEN NOT MATCHED THEN
        INSERT (ItemCode, ItemName, Rate, Packets, Qty, Amount, BillNumber, BillDate,
                Area, Area_Line, ShopName, Username, PRATE, Damages, Discount,
                Offer_Item, Offer_Rate, Offer_Qty, Salesman, Payment_Mode, MobileOrderDate, ActionDate)
        VALUES (source.ItemCode, source.ItemName, source.Rate, source.Qty, source.packing_qty,
                source.Rate * source.Qty, source.BillNo, source.BillDate, source.Line, source.Area, source.ShopName,
                'From_Mobile', source.PRATE, isnull(source.Ret_Qty,0), source.DiscountPercent,
                source.Offer_Item, isnull(source.Offer_Rate,0), source.Offer_Qty, source.Salesman,
                source.paymentmode, source.MobileOrderDate, GETDATE());

        --select * from #Source
       --select * from #Previous
    -------------------------------------------------------------------
    -- Stock adjustment for matched rows
    -------------------------------------------------------------------
    UPDATE im
    SET im.Stock = im.Stock + p.PreviousPackets - p.NewPackets,
        im.ActionDate = GETDATE()
    FROM Bell_ItemMaster im
    INNER JOIN #Previous p ON im.ItemCode = p.ItemCode AND im.ItemName = p.ItemName
    WHERE EXISTS (SELECT 1 FROM Bell_Cust_Master WHERE Line = @LINE AND IsForDirectSales = 'Y');
    -------------------------------------------------------------------
    -- Stock adjustment for newly inserted rows
    -------------------------------------------------------------------
    UPDATE im
    SET im.Stock = im.Stock - s.Qty,
       -- im.Username = s.Username,
        im.ActionDate = GETDATE()
    FROM Bell_ItemMaster im
    INNER JOIN #Source s ON im.ItemCode = s.ItemCode AND im.ItemName = s.ItemName
    WHERE NOT EXISTS (
        SELECT 1 FROM #Previous p WHERE p.ItemCode = s.ItemCode AND p.ItemName = s.ItemName
    )
    AND EXISTS (SELECT 1 FROM Bell_Cust_Master WHERE Line = @LINE AND IsForDirectSales = 'Y');
    -------------------------------------------------------------------
    -- update discount = 0 for non eligible items 
    UPDATE bhavani_ER_Bills SET DISCOUNT=0 where area=@LINE and billdate=@BILLDATE and discount > 0 
		and billnumber not in (
		select billnumber from bhavani_ER_Bills where area=@LINE and billdate=@BILLDATE and discount > 0 
		group by Billnumber,Area Having sum(amount) >=5000	)

-- this is for Adding Stock details to own Shops (Bazar, Bhavani, Nezar, Gate...)
--TODO: TESTING IS PENDING...
if @LINE = 'BHAVANI'  OR @LINE = 'BAZAR'  OR @LINE = 'GATE' OR  @LINE = 'NEZAR' 
BEGIN
         -------------------------------------------------------------------
        -- Stock adjustment for matched rows IN BAZAR SHOPS, This is to load items to separate Shops so stock should added in these shops.
        -- select * from BAZAR_ItemMaster
        -------------------------------------------------------------------
        --SELECT * FROM BAZAR_ItemMaster im  
        --INNER JOIN #Previous p ON im.ItemName = p.ItemName   
        ----and im.ItemCode = p.ItemCode
        --WHERE im.Shopname=@LINE AND EXISTS (SELECT 1 FROM Bell_Cust_Master WHERE Line = @LINE );

       UPDATE im  
        SET im.Stock = im.Stock - p.PreviousPackets + p.NewPackets,  
            im.ActionDate = GETDATE()  
        FROM BAZAR_ItemMaster im  
        INNER JOIN #Previous p ON im.ItemName = p.ItemName   
        --and im.ItemCode = p.ItemCode
        WHERE im.Shopname=@LINE AND
        EXISTS (SELECT 1 FROM Bell_Cust_Master WHERE Line = @LINE ); --AND IsForDirectSales = 'Y'  
        
        -------------------------------------------------------------------  
        -- Stock adjustment for newly inserted rows IN BAZAR SHOPS  
        -------------------------------------------------------------------  
        --SELECT * FROM BAZAR_ItemMaster im  
        --INNER JOIN #Source s ON im.ItemName = s.ItemName  
        ----and im.ItemCode = s.ItemCode 
        --WHERE im.Shopname=@LINE AND
        --NOT EXISTS (SELECT 1 FROM #Previous p WHERE p.ItemName = s.ItemName )  
        --AND EXISTS (SELECT 1 FROM Bell_Cust_Master WHERE Line = @LINE );  

        UPDATE im  
        SET im.Stock = im.Stock + s.Qty,  
           -- im.Username = s.Username,  
            im.ActionDate = GETDATE()  
        FROM BAZAR_ItemMaster im  
        INNER JOIN #Source s ON im.ItemName = s.ItemName  
        --and im.ItemCode = s.ItemCode 
        WHERE im.Shopname=@LINE AND
        NOT EXISTS (SELECT 1 FROM #Previous p WHERE p.ItemName = s.ItemName)  
        AND EXISTS (SELECT 1 FROM Bell_Cust_Master WHERE Line = @LINE ); --AND IsForDirectSales = 'Y'  
END

SELECT 1 AS RESULT;
END
GO
