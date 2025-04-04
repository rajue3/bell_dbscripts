-- delete duplicate records from Customers 
select * from Bell_Cust_Master WHERE LINE='siddipet' AND STATUS='Active' 

WITH CTE AS (
  SELECT  ID, ROW_NUMBER() OVER (PARTITION BY LINE,AREA,SHOPNAME,MOBILE ORDER BY id) AS row_num  FROM Bell_Cust_Master WHERE STATUS='Active' and LINE='siddipet'
)
DELETE FROM Bell_Cust_Master WHERE id IN (  SELECT id  FROM CTE  WHERE row_num > 1 );


WITH CTE AS (
  SELECT  ID, ROW_NUMBER() OVER (PARTITION BY LINE,AREA,SHOPNAME,MOBILE ORDER BY id) AS row_num  FROM Bell_Cust_Master WHERE STATUS='Active'
)
SELECT * FROM Bell_Cust_Master WHERE id IN (  SELECT id  FROM CTE  WHERE row_num > 1 ) ORDER BY SHOPNAME;

SELECT  *, ROW_NUMBER() OVER (PARTITION BY LINE,AREA,SHOPNAME,MOBILE ORDER BY id) AS row_num  FROM Bell_Cust_Master WHERE STATUS='Active' 