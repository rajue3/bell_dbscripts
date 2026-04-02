alter procedure USP_SAVE_USER_DETAILS  
@ID AS INT,  
@USERNAME as varchar(20),  
@PASSWORD as varchar(20),  
@FIRSTNAME as varchar(20),  
@LASTNAME as varchar(20)  
AS  
Begin   
 IF (@ID > 0 )  
 BEGIN  
	if @PASSWORD = '' set @PASSWORD=null

  UPDATE BELL_USERS SET FIRSTNAME=@FIRSTNAME,lastname=@LASTNAME,USERNAME=@USERNAME,
  [password]=isnull(@PASSWORD,[password]) WHERE ID=@ID  
 END   
 ELSE  
 BEGIN  
  INSERT INTO BELL_USERS(firstname,lastname,USERNAME,PASSWORD,USERTYPE) VALUES(@FIRSTNAME,@LASTNAME,@USERNAME,@PASSWORD,'user')  
 END  
End  