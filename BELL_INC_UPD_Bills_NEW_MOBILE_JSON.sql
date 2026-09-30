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

BELL_INC_UPD_Bills_NEW_MOBILE_JSON 
'[{"ID":11,"ItemName":"PARTY ROLLS 5RS","ItemCode":207,"Rate":"90","Qty":"24","packing_qty":"1C(24)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":2,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:17","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":12,"ItemName":"ROUND CHIKKY","ItemCode":60,"Rate":"20","Qty":"140","packing_qty":"14K(10)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:17","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":13,"ItemName":"ROUND TILL CHIKKY","ItemCode":61,"Rate":"20","Qty":"60","packing_qty":"6K(10)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:17","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":14,"ItemName":"KHARA 500 GM","ItemCode":43,"Rate":"85","Qty":"20","packing_qty":"1C(20)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:17","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":15,"ItemName":"CAKE 1RS","ItemCode":300,"Rate":"15","Qty":"120","packing_qty":"3C(40)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:17","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":16,"ItemName":"Till Chikky 5 RS","ItemCode":63,"Rate":"180","Qty":"6","packing_qty":"1C(6)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:17","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":17,"ItemName":"Dry Jamun 1 Rs","ItemCode":69,"Rate":"70","Qty":"6","packing_qty":"6P","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:17","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":18,"ItemName":"BUTTER FUN 50NP","ItemCode":160,"Rate":"46","Qty":"34","packing_qty":"1C(34)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":2,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:17","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":19,"ItemName":"CHEKODI 250GM","ItemCode":40,"Rate":"40","Qty":"20","packing_qty":"1C(20)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:17","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":20,"ItemName":"Animal 5 RS","ItemCode":6,"Rate":"43","Qty":"12","packing_qty":"1C(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:18","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":21,"ItemName":"MARIE SUMO 5 RS","ItemCode":103,"Rate":"41.66","Qty":"36","packing_qty":"3C(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:18","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":22,"ItemName":"BELL RUSK 10RS","ItemCode":131,"Rate":"7.3","Qty":"150","packing_qty":"3C(50)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:18","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":23,"ItemName":"WAFIX 5RS","ItemCode":218,"Rate":"135","Qty":"12","packing_qty":"1C(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":2,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:18","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":24,"ItemName":"FUN CONES 5RS","ItemCode":204,"Rate":"200","Qty":"9","packing_qty":"1C(9)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":2,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:18","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":25,"ItemName":"TAMATO KETCHUP 1RS","ItemCode":608,"Rate":"47.5","Qty":"12","packing_qty":"1C(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:18","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":26,"ItemName":"KHARA 400 GM","ItemCode":34,"Rate":"48","Qty":"20","packing_qty":"1C(20)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:18","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":27,"ItemName":"FUNBON JAR 1RS","ItemCode":184,"Rate":"80","Qty":"16","packing_qty":"1C(16)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":2,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:18","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":28,"ItemName":"MILKY STAR 5RS","ItemCode":215,"Rate":"135","Qty":"18","packing_qty":"1C(18)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":2,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:18","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},{"ID":29,"ItemName":"FRUITO POP JAR 5RS","ItemCode":169,"Rate":"135","Qty":"6","packing_qty":"6P","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":2,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-10T00:00:00","MobileOrderDate":"2026-09-10T12:20:18","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null}]'
,'BHAVANI','2026-09-10'

BELL_INC_UPD_Bills_NEW_MOBILE_JSON 
'[{"ID":23,"ItemName":"Khara 700 GM","ItemCode":13,"Rate":"110","Qty":"10","packing_qty":"1C(10)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:40","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null}
,{"ID":24,"ItemName":"ROUND TILL CHIKKY","ItemCode":61,"Rate":"20","Qty":"60","packing_qty":"6K(10)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:40","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null}
,{"ID":25,"ItemName":"Mysorepak 5 Rs","ItemCode":74,"Rate":"130","Qty":"6","packing_qty":"1C(6)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:40","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},
{"ID":26,"ItemName":"CAKE 1RS","ItemCode":300,"Rate":"15","Qty":"160","packing_qty":"4C(40)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:40","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},
{"ID":27,"ItemName":"khara 5 RS","ItemCode":1,"Rate":"42","Qty":"48","packing_qty":"4C(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:41","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},
{"ID":28,"ItemName":"moong dal 5 RS","ItemCode":2,"Rate":"42","Qty":"72","packing_qty":"6C(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"Soya sticks 5 RS","Offer_Rate":"42","Offer_Qty":3,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:41","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},
{"ID":29,"ItemName":"Soya sticks 5 RS","ItemCode":9,"Rate":"42","Qty":"48","packing_qty":"4C(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"Soya sticks 5 RS","Offer_Rate":"42","Offer_Qty":2,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:41","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},
{"ID":30,"ItemName":"Alubujiya 5 RS","ItemCode":3,"Rate":"42","Qty":"48","packing_qty":"4C(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:41","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},
{"ID":31,"ItemName":"FRUITO POP JAR 2RS","ItemCode":168,"Rate":"97","Qty":"12","packing_qty":"1C(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":2,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:41","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},
{"ID":32,"ItemName":"TAMATO KETCHUP 1RS","ItemCode":608,"Rate":"47.5","Qty":"24","packing_qty":"2C(12)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:41","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},
{"ID":33,"ItemName":"Kcr Kova 2 Rs","ItemCode":77,"Rate":"100","Qty":"4","packing_qty":"4P","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:41","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},
{"ID":34,"ItemName":"Kcr Kova 1 Rs","ItemCode":76,"Rate":"50","Qty":"10","packing_qty":"10P","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:41","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null},
{"ID":35,"ItemName":"Bhoondhi 325 GM","ItemCode":15,"Rate":"55","Qty":"20","packing_qty":"1C(20)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:41","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null}]'
,'BHAVANI','2026-09-15'

BELL_INC_UPD_Bills_NEW_MOBILE_JSON 
'[{"ID":35,"ItemName":"Bhoondhi 325 GM","ItemCode":15,"Rate":"55","Qty":"20","packing_qty":"1C(20)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-15T00:00:00","MobileOrderDate":"2026-09-15T12:30:41","paymentmode":"Cash","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"bellbrand","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null}]'
,'BHAVANI','2026-09-16'

BELL_INC_UPD_Bills_NEW_MOBILE_JSON 
'[{"ID":354,"ItemName":"TRUFFELLO (24P) 5RS","ItemCode":174,"Rate":"66","Qty":"24","packing_qty":"1C(24)","Packets":0,"Ret_Qty":null,"BillNo":1,"DiscountPercent":0,"Offer_Item":"","Offer_Rate":null,"Offer_Qty":0,"BillDateTime":"2026-09-16T00:00:00","MobileOrderDate":"2026-09-16T12:30:41","paymentmode":"Online","BillDate":null,"Line":"BHAVANI","Area":"BHAVANI","Salesman":"admin","ShopName":"BHAVANI","Customer":null,"Mobile":null,"TotalAmount":null,"Status":null,"TotalItems":null,"Amount":null}]'
,'BHAVANI','2026-09-16'

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
            Line NVARCHAR(100),
            Area NVARCHAR(100),
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
        ON j.ItemCode = im.ItemCode AND j.ItemName = im.ItemName
        WHERE im.Status='Active' and im.category <> 'RAW MATERIALS';

    -------------------------------------------------------------------
    -- Build #Previous for stock adjustment
    -------------------------------------------------------------------
    IF OBJECT_ID('tempdb..#Previous') IS NOT NULL DROP TABLE #Previous;

    SELECT s.ItemCode, s.ItemName, s.BillNo, s.ShopName,
           s.Qty AS NewPackets, b.Packets AS PreviousPackets,s.Offer_Qty AS NewOfferQty, b.Offer_Qty AS PreviousOfferQty
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
    -- Stock adjustment for matched rows  + p.PreviousOfferQty - p.NewOfferQty
    -------------------------------------------------------------------
    UPDATE im
    SET im.Stock = im.Stock + p.PreviousPackets - p.NewPackets ,
        im.ActionDate = GETDATE()
    FROM Bell_ItemMaster im 
    INNER JOIN #Previous p ON im.ItemCode = p.ItemCode AND im.ItemName = p.ItemName
    WHERE EXISTS (SELECT 1 FROM Bell_Cust_Master WHERE Line = @LINE AND IsForDirectSales = 'YES')
     and im.Status='Active' and im.category <> 'RAW MATERIALS';
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
    AND EXISTS (SELECT 1 FROM Bell_Cust_Master WHERE Line = @LINE AND IsForDirectSales = 'YES')
     and im.Status='Active' and im.category <> 'RAW MATERIALS';
    -------------------------------------------------------------------
    -- update discount = 0 for non eligible items 
    UPDATE bhavani_ER_Bills SET DISCOUNT=0 where area=@LINE and billdate=@BILLDATE and discount > 0 
		and billnumber not in (
		select billnumber from bhavani_ER_Bills where area=@LINE and billdate=@BILLDATE and discount > 0 
		group by Billnumber,Area Having sum(amount) >=5000	)

-- this is for Adding Stock details to own Shops (Bazar, Bhavani, Nezar, Gate...)

if @LINE = 'BHAVANI'  OR @LINE = 'BAZAR'  OR @LINE = 'GATE' OR  @LINE = 'NEZAR' 
BEGIN
          BEGIN TRY
            BEGIN TRAN;
            DECLARE 
                @BillNumber  INT,@ItemCode INT,
                @ItemName NVARCHAR(100),
                @Qty INT,@OfferItemName nvarchar(100),@Offer_Qty INT,@Ret_Qty INT,
                @ExistingQty INT,@ExistingOfferQty INT,@ExistingRetQty INT;
            
            ---this will update negative stock with zero. TODO: need to delete this once the stock is stable.
            --update BAZAR_ItemMaster set stock=0 where stock<0 AND SHOPNAME=@LINE;

            DECLARE src_cur CURSOR LOCAL FAST_FORWARD FOR
            SELECT BillNo, ItemCode, ItemName, Qty,Offer_Item,Offer_Qty, Ret_Qty FROM #Source;
            
            OPEN src_cur;
            FETCH NEXT FROM src_cur INTO @BillNumber, @ItemCode, @ItemName, @Qty,@OfferItemName,@Offer_Qty, @Ret_Qty;
            
            WHILE @@FETCH_STATUS = 0
            BEGIN
                -- Find an existing matching bill row (match on billnumber, billdate, itemcode, itemname)
                SELECT TOP (1) @ExistingQty = ISNULL(PreviousPackets, 0),@ExistingOfferQty=ISNULL(PreviousOfferQty,0)
                FROM #Previous WHERE BillNo = @BillNumber AND ItemCode = @ItemCode AND ItemName = @ItemName;
                  --AND CONVERT(date, BillDate) = CONVERT(date, @BillDate) and LINE=@LINE 

                IF @ExistingQty IS NOT NULL
                BEGIN
                        print 'Existing Item found...'
                    -- Revert previous effect and apply new values:
                    -- stock = stock + previous_sold - new_sold - previous_return + new_return -- + @ExistingRetQty - isnull(@Ret_Qty,0)
                    UPDATE im SET Stock = isnull(im.Stock,0) - @ExistingQty + isnull(@Qty,0),
                    ActionDate = GETDATE(),USERNAME='FROM SP1'  FROM dbo.BAZAR_ItemMaster im
                    WHERE im.ItemName = @ItemName AND SHOPNAME=@LINE;
                    
                    UPDATE im SET Stock = isnull(im.Stock,0) - @ExistingOfferQty + isnull(@Offer_Qty,0),
                     ActionDate = GETDATE(),USERNAME='FROM SP1'  FROM dbo.BAZAR_ItemMaster im
                     WHERE im.Status='Active' and im.ItemName = @OfferItemName AND SHOPNAME=@LINE;                                       
                END
                ELSE
                BEGIN
                        print 'Existing Item NOT found...'
                    -- New bill row: apply new sale/return  --- isnull(@Ret_Qty,0)
                    UPDATE im SET Stock = ISNULL(im.Stock,0) + isnull(@Qty,0) ,ActionDate = GETDATE(),USERNAME='FROM SP1'
                    FROM dbo.BAZAR_ItemMaster im
                    WHERE im.ItemName = @ItemName  AND SHOPNAME=@LINE;

                    UPDATE im SET Stock = isnull(im.Stock,0)  + isnull(@Offer_Qty,0),
                     ActionDate = GETDATE() ,USERNAME='FROM SP1' FROM dbo.BAZAR_ItemMaster im
                     WHERE im.Status='Active' and im.ItemName = @OfferItemName AND SHOPNAME=@LINE;       
                END
                -- reset and fetch next
                SET @ExistingQty = NULL; set @ExistingOfferQty=null; SET @ExistingRetQty = NULL; set @Offer_Qty=null;set @Ret_Qty=null;set @Qty=null;
                set @OfferItemName=''
                FETCH NEXT FROM src_cur INTO @BillNumber, @ItemCode, @ItemName, @Qty,@OfferItemName,@Offer_Qty, @Ret_Qty;
            END

            CLOSE src_cur;
            DEALLOCATE src_cur;

            COMMIT TRAN;
        END TRY
        BEGIN CATCH
            IF XACT_STATE() <> 0 ROLLBACK TRAN;
            DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
            RAISERROR('%s',16,1,@ErrMsg);
        END CATCH;
END

SELECT 1 AS RESULT;
END
GO
