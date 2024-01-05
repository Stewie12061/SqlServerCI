IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2049]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2049]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
----	Đổi mã phụ huynh nên phải thay đổi mã phụ huynh ở các nghiệp vụ liên quan 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo 
-- <Example>
---- 
---- exec EDMP2049 @DivisionID = 'BE',  @UserID = 'ASOFTADMIN' , @StudentID = '',@FatherID = '',@MotherID = '',@FatherIDOld = '',@MotherIDOld = ''


CREATE PROCEDURE [dbo].[EDMP2049]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @StudentID VARCHAR(50),
	 @FatherID VARCHAR(50),
	 @MotherID VARCHAR(50),
	 @FatherIDOld VARCHAR(50),
	 @MotherIDOld VARCHAR(50)
)
AS 


BEGIN 


	  ------*****Đơn xin phép trên APP****
	  --------Phụ huynh bố đổi mã 
	IF EXISTS (SELECT TOP 1 1 FROM APT0008 WITH (NOLOCK) WHERE  StudentID = @StudentID AND CreateUserID = @FatherIDOld AND DeleteFlg = 0 )
	BEGIN 
	
	UPDATE  APT0008
	SET CreateUserID  = @FatherID,
	LastModifyUserID = @FatherID
	FROM APT0008  WITH (NOLOCK)   
	WHERE StudentID = @StudentID AND CreateUserID = @FatherIDOld AND DeleteFlg = 0 

	END 

	--------Phụ huynh mẹ đổi mã 

	IF EXISTS (SELECT TOP 1 1 FROM APT0008 WITH (NOLOCK) WHERE  StudentID = @StudentID AND CreateUserID = @MotherIDOld AND DeleteFlg = 0 )
	BEGIN 
	
	UPDATE  APT0008
	SET CreateUserID  = @MotherID,
	LastModifyUserID = @MotherID
	FROM APT0008  WITH (NOLOCK)   
	WHERE StudentID = @StudentID AND CreateUserID = @MotherIDOld AND DeleteFlg = 0 

	END 

	-----****Đăng ký dịch vụ (đăng ký giữ ngoại giờ, đưa đón, đăng ký xe bus) 

	  --------Phụ huynh bố đổi mã 
	IF EXISTS (SELECT TOP 1 1 FROM EDMT2131 WITH (NOLOCK) WHERE  StudentID = @StudentID AND CreateUserID = @FatherIDOld AND DeleteFlg = 0 )
	BEGIN 
	
	UPDATE  EDMT2131
	SET CreateUserID  = @FatherID,
	LastModifyUserID = @FatherID
	FROM EDMT2131  WITH (NOLOCK)   
	WHERE StudentID = @StudentID AND CreateUserID = @FatherIDOld AND DeleteFlg = 0 

	END 

	  --------Phụ huynh bố đổi mã 
	IF EXISTS (SELECT TOP 1 1 FROM EDMT2130 WITH (NOLOCK) 
				LEFT JOIN EDMT2131 WITH (NOLOCK) ON EDMT2130.APK = EDMT2131.APKMaster AND EDMT2130.DeleteFlg = EDMT2131.DeleteFlg 
				WHERE  EDMT2131.StudentID = @StudentID AND EDMT2130.CreateUserID = @FatherIDOld AND EDMT2130.DeleteFlg = 0 )
	BEGIN 
	
	UPDATE  EDMT2130
	SET EDMT2130.CreateUserID  = @FatherID,
	    EDMT2130.LastModifyUserID = @FatherID
	FROM EDMT2130  WITH (NOLOCK)   
	LEFT JOIN EDMT2131 WITH (NOLOCK) ON EDMT2130.APK = EDMT2131.APKMaster AND EDMT2130.DeleteFlg = EDMT2131.DeleteFlg 
	WHERE  EDMT2131.StudentID = @StudentID AND EDMT2130.CreateUserID = @FatherIDOld AND EDMT2130.DeleteFlg = 0 

	END 


	--------Phụ huynh mẹ đổi mã 

	IF EXISTS (SELECT TOP 1 1 FROM EDMT2131 WITH (NOLOCK) WHERE  StudentID = @StudentID AND CreateUserID = @MotherIDOld AND DeleteFlg = 0 )
	BEGIN 
	
	UPDATE  EDMT2131
	SET CreateUserID  = @MotherID,
	LastModifyUserID = @MotherID
	FROM EDMT2131  WITH (NOLOCK)   
	WHERE StudentID = @StudentID AND CreateUserID = @MotherIDOld AND DeleteFlg = 0 

	END 

		  --------Phụ huynh mẹ đổi mã 
	IF EXISTS (SELECT TOP 1 1 FROM EDMT2130 WITH (NOLOCK) 
				LEFT JOIN EDMT2131 WITH (NOLOCK) ON EDMT2130.APK = EDMT2131.APKMaster AND EDMT2130.DeleteFlg = EDMT2131.DeleteFlg 
				WHERE  EDMT2131.StudentID = @StudentID AND EDMT2130.CreateUserID = @MotherIDOld AND EDMT2130.DeleteFlg = 0 )
	BEGIN 
	
	UPDATE  EDMT2130
	SET EDMT2130.CreateUserID  = @MotherID,
	    EDMT2130.LastModifyUserID = @MotherID
	FROM EDMT2130  WITH (NOLOCK)   
	LEFT JOIN EDMT2131 WITH (NOLOCK) ON EDMT2130.APK = EDMT2131.APKMaster AND EDMT2130.DeleteFlg = EDMT2131.DeleteFlg 
	WHERE  EDMT2131.StudentID = @StudentID AND EDMT2130.CreateUserID = @MotherIDOld AND EDMT2130.DeleteFlg = 0 

	END 



-----Phản hồi ý kiến 
 
 IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0011' AND xtype = 'U') ----Do dự án không có bảng của app 
   BEGIN

-----phụ huynh bố 
IF EXISTS (SELECT TOP 1 1 FROM APT0011 WITH (NOLOCK)
				WHERE APT0011.CreateUserID = @FatherIDOld AND APT0011.DeleteFlg = 0 )
	BEGIN 
	
	UPDATE  APT0011
	SET APT0011.CreateUserID  = @FatherID,
	    APT0011.LastModifyUserID = @FatherID
	FROM APT0011  WITH (NOLOCK)   
	WHERE APT0011.CreateUserID = @FatherIDOld AND APT0011.DeleteFlg = 0 

	END

---phụ huynh mẹ 
IF EXISTS (SELECT TOP 1 1 FROM APT0011 WITH (NOLOCK)
				WHERE APT0011.CreateUserID = @MotherIDOld AND APT0011.DeleteFlg = 0 )
	BEGIN 
	
	UPDATE  APT0011
	SET APT0011.CreateUserID  = @MotherID,
	    APT0011.LastModifyUserID = @MotherID
	FROM APT0011  WITH (NOLOCK)   
	WHERE APT0011.CreateUserID = @MotherIDOld AND APT0011.DeleteFlg = 0 


	 END 

    END 

---Detail 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0012' AND xtype = 'U') ----Do dự án không có bảng của app 
   BEGIN

-----phụ huynh bố 
IF EXISTS (SELECT TOP 1 1 FROM APT0012 WITH (NOLOCK)
				WHERE APT0012.CreateUserID = @FatherIDOld AND APT0012.DeleteFlg = 0 )
	BEGIN 
	
	UPDATE  APT0012
	SET APT0012.CreateUserID  = @FatherID,
	    APT0012.LastModifyUserID = @FatherID
	FROM APT0012  WITH (NOLOCK)   
	WHERE APT0012.CreateUserID = @FatherIDOld AND APT0012.DeleteFlg = 0 

	END

---phụ huynh mẹ 
IF EXISTS (SELECT TOP 1 1 FROM APT0012 WITH (NOLOCK)
				WHERE APT0012.CreateUserID = @MotherIDOld AND APT0012.DeleteFlg = 0 )
	BEGIN 
	
	UPDATE  APT0012
	SET APT0012.CreateUserID  = @MotherID,
	    APT0012.LastModifyUserID = @MotherID
	FROM APT0012  WITH (NOLOCK)   
	WHERE APT0012.CreateUserID = @MotherIDOld AND APT0012.DeleteFlg = 0 


	 END 

    END 






------Dặn thuốc 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0009' AND xtype = 'U') ----Do dự án không có bảng của app 
BEGIN

-----phụ huynh bố 
IF EXISTS (SELECT TOP 1 1 FROM APT0009 WITH (NOLOCK)
				WHERE APT0009.CreateUserID = @FatherIDOld AND APT0009.DeleteFlg = 0 )
	BEGIN 
	
	UPDATE  APT0009
	SET APT0009.CreateUserID  = @FatherID,
	    APT0009.LastModifyUserID = @FatherID
	FROM APT0009  WITH (NOLOCK)   
	WHERE APT0009.CreateUserID = @FatherIDOld AND APT0009.DeleteFlg = 0 

	END 

---phụ huynh mẹ 
IF EXISTS (SELECT TOP 1 1 FROM APT0009 WITH (NOLOCK)
				WHERE APT0009.CreateUserID = @MotherIDOld AND APT0009.DeleteFlg = 0 )
	BEGIN 
	
	UPDATE  APT0009
	SET APT0009.CreateUserID  = @MotherID,
	    APT0009.LastModifyUserID = @MotherID
	FROM APT0009  WITH (NOLOCK)   
	WHERE APT0009.CreateUserID = @MotherIDOld AND APT0009.DeleteFlg = 0 




	END 

END 






END 






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
