IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2019]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2019]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO















-- <Summary>
----Đẩy mã học sinh vào danh mục đối tượng, CRM, người dùng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 6/4/2019
-- <Example>
---- 
/*-- <Example>
	EDMP2019 @DivisionID = 'BE', @UserID = '', @APK = 'A565A93E-588A-48DD-AF4D-38F966C70F68'

	EDMP2019 @DivisionID, @UserID, @APK
----*/
CREATE PROCEDURE EDMP2019
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @FatherName NVARCHAR(250),
	 @MotherName NVARCHAR(250),
	 @APK  VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@FatherID VARCHAR(50),
		@MotherID VARCHAR(50),
		@StudentID VARCHAR(50)

SELECT @StudentID = StudentID,
@FatherID = ISNULL(FatherID,''),
@MotherID = ISNULL(MotherID,'')
FROM EDMT2010 WHERE APK = @APK 


IF NOT EXISTS (SELECT TOP 1 1 FROM AT1201 WITH (NOLOCK) WHERE ObjectTypeID = 'PH' )
BEGIN 
INSERT INTO AT1201 (APK,DivisionID,ObjectTypeID,ObjectTypeName,[Disabled],CreateDate,CreateUserID,LastModifyDate,LastModifyUserID,IsCommon)
VALUES (NEWID(),'@@@','PH',N'Phụ huynh',0,GETDATE(),@UserID,GETDATE(),@UserID,1) 

END 


-------------Cập nhật tất cả phụ huynh trở về không kế thừa

DECLARE @InheritConsultantID VARCHAR(50),
		@Prefix VARCHAR(50) 

SELECT @InheritConsultantID = APK,@Prefix = Prefix FROM EDMT2000 WHERE DivisionID = @DivisionID AND StudentID = @StudentID AND DeleteFlg = 0
 
 UPDATE AT1202
 SET InheritConsultantID = NULL
 WHERE InheritConsultantID = @InheritConsultantID AND ISNULL(IsParents,0) = 1


--****************************************************************************************************************************************

---------Cập nhật tên phụ huynh vào phiếu thông tin tư vấn (học sinh) 

UPDATE EDMT2000 
SET EDMT2000.ParentID = CASE WHEN @Prefix = 1 THEN @FatherID ELSE @MotherID END,
	EDMT2000.ParentName = CASE WHEN @Prefix = 1 THEN @FatherName ELSE @MotherName END,
	EDMT2000.ParentDateBirth = CASE WHEN @Prefix = 1 THEN EDMT2010.FatherDateOfBirth ELSE EDMT2010.MotherDateOfBirth END,
	EDMT2000.Telephone = CASE WHEN @Prefix = 1 THEN EDMT2010.FatherMobiphone ELSE EDMT2010.MotherMobiphone END,
	EDMT2000.[Address] =   EDMT2010.[Address],
	EDMT2000.Email = CASE WHEN @Prefix = 1 THEN EDMT2010.FatherEmail ELSE EDMT2010.MotherEmail END,
	EDMT2000.StudentName = EDMT2010.StudentName
FROM EDMT2000 WITH (NOLOCK)
LEFT JOIN EDMT2010 WITH (NOLOCK) ON EDMT2000.DivisionID = EDMT2010.DivisionID AND EDMT2010.StudentID = EDMT2000.StudentID AND EDMT2000.DeleteFlg = EDMT2010.DeleteFlg
WHERE EDMT2000.DivisionID = @DivisionID AND EDMT2000.StudentID = @StudentID AND EDMT2000.DeleteFlg = 0  

-----Cập nhật dối tượng học sinh có phụ huynh nào 

UPDATE AT1202 
SET AT1202.FatherObjectID = CASE WHEN ISNULL(@FatherID,'') != '' THEN @FatherID ELSE AT1202.FatherObjectID END,
AT1202.MotherObjectID = CASE WHEN ISNULL(@MotherID,'') != '' THEN @MotherID ELSE AT1202.MotherObjectID END,
AT1202.InheritConsultantID = @InheritConsultantID,
AT1202.Contactor = CASE WHEN @Prefix = 1  THEN @FatherName ELSE @MotherName END,
AT1202.[Address] =   EDMT2010.[Address],
AT1202.Email = CASE WHEN @Prefix = 1 THEN EDMT2010.FatherEmail ELSE EDMT2010.MotherEmail END,
AT1202.ObjectName = EDMT2010.StudentName
FROM AT1202 WITH (NOLOCK) 
LEFT JOIN EDMT2010 WITH (NOLOCK) ON AT1202.ObjectID = EDMT2010.StudentID AND EDMT2010.DeleteFlg = 0
WHERE AT1202.ObjectID = @StudentID AND EDMT2010.APK = @APK  






----Cập nhật đối tượng phụ huynh có học sinh (bố)
IF EXISTS (SELECT TOP 1 1 FROM AT1202 WITH (NOLOCK) WHERE  ObjectID = @FatherID)
BEGIN 
	UPDATE AT1202 
	SET AT1202.IsParents = 1,
	AT1202.ObjectName = CASE WHEN ISNULL(@FatherName,'') != '' THEN @FatherName ELSE AT1202.ObjectName END,
	AT1202.InheritConsultantID = @InheritConsultantID,
	AT1202.IsCustomer = 1,
	AT1202.[Address]  = EDMT2010.[Address],
	AT1202.CountryID = EDMT2010.FatherNationalityID,
	AT1202.Tel = EDMT2010.FatherMobiphone,
	AT1202.Email = EDMT2010.FatherEmail 
	FROM AT1202 WITH (NOLOCK)
	LEFT JOIN EDMT2010 WITH (NOLOCK) ON AT1202.ObjectID = EDMT2010.FatherID AND EDMT2010.DeleteFlg = 0 
	WHERE AT1202.ObjectID = @FatherID AND EDMT2010.APK = @APK 
END
---Lưu thông tin phụ huynh vào CRM (bố)
IF NOT EXISTS (SELECT TOP 1 1 FROM POST0011 WITH (NOLOCK) WHERE  MemberID = @FatherID)
BEGIN 
	
INSERT INTO POST0011 (DivisionID,MemberID,MemberName,[Address],Tel,Email,[Disabled],CreateDate,CreateUserID,LastModifyDate,LastModifyUserID,IsCommon,Identify)
SELECT EDMT2010.DivisionID,EDMT2010.FatherID,AT1202.ObjectName,EDMT2010.[Address],EDMT2010.FatherMobiphone,EDMT2010.FatherEmail,0,GETDATE(),'ASOFTADMIN',GETDATE(),'ASOFTADMIN',0,0
FROM EDMT2010 WITH (NOLOCK) 
INNER JOIN AT1202 WITH (NOLOCK) ON EDMT2010.FatherID = AT1202.ObjectID 
WHERE EDMT2010.FatherID = @FatherID AND EDMT2010.DeleteFlg = 0 AND EDMT2010.APK = @APK  

END 


---Cập nhật thông tin phụ huynh vào CRM (bố)
IF EXISTS (SELECT TOP 1 1 FROM POST0011 WITH (NOLOCK) WHERE  MemberID = @FatherID)
BEGIN 
	
UPDATE  POST0011 
SET MemberName = CASE WHEN ISNULL(@FatherName,'') != '' THEN @FatherName ELSE POST0011.MemberName END,
POST0011.[Address] = EDMT2010.[Address],
POST0011.Tel = EDMT2010.FatherMobiphone,
POST0011.Email = EDMT2010.FatherEmail
FROM POST0011  WITH (NOLOCK)  
LEFT JOIN  EDMT2010 WITH (NOLOCK) ON POST0011.MemberID = EDMT2010.FatherID AND EDMT2010.DeleteFlg = 0
WHERE MemberID = @FatherID AND EDMT2010.APK = @APK 

END 

 
----Cập nhật đối tượng phụ huynh có học sinh(mẹ)
IF EXISTS (SELECT TOP 1 1 FROM AT1202 WITH (NOLOCK) WHERE  ObjectID = @MotherID)
BEGIN 
	UPDATE AT1202 
	SET AT1202.IsParents = 1,
	AT1202.ObjectName = CASE WHEN ISNULL(@MotherName,'') != '' THEN @MotherName ELSE AT1202.ObjectName END,
	AT1202.InheritConsultantID = @InheritConsultantID,
	AT1202.IsCustomer = 1,
	AT1202.[Address]  = EDMT2010.[Address],
	AT1202.CountryID = EDMT2010.MotherNationalityID,
	AT1202.Tel = EDMT2010.MotherMobiphone,
	AT1202.Email = EDMT2010.MotherEmail 
	FROM AT1202 WITH (NOLOCK)
	LEFT JOIN EDMT2010 WITH (NOLOCK) ON AT1202.ObjectID = EDMT2010.MotherID AND EDMT2010.DeleteFlg = 0 
	WHERE AT1202.ObjectID = @MotherID AND EDMT2010.APK = @APK 
END


	-------Lưu thông tin phụ huynh vào CRM 
	IF NOT EXISTS (SELECT TOP 1 1 FROM POST0011 WITH (NOLOCK) WHERE  MemberID = @MotherID)
	BEGIN 
	
	INSERT INTO POST0011 (DivisionID,MemberID,MemberName,[Address],Tel,Email,[Disabled],CreateDate,CreateUserID,LastModifyDate,LastModifyUserID,IsCommon,Identify)
	SELECT EDMT2010.DivisionID,EDMT2010.MotherID,AT1202.ObjectName,EDMT2010.[Address],EDMT2010.MotherMobiphone,EDMT2010.MotherEmail,0,GETDATE(),'ASOFTADMIN',GETDATE(),'ASOFTADMIN',0,0
	FROM EDMT2010 WITH (NOLOCK) 
	INNER JOIN AT1202 WITH (NOLOCK) ON EDMT2010.MotherID = AT1202.ObjectID 
	WHERE EDMT2010.MotherID = @MotherID AND EDMT2010.DeleteFlg = 0 AND EDMT2010.APK = @APK 

	END


	---Cập nhật thông tin phụ huynh vào CRM (mẹ)
	IF EXISTS (SELECT TOP 1 1 FROM POST0011 WITH (NOLOCK) WHERE  MemberID = @MotherID)
	BEGIN 
	
	UPDATE  POST0011 
	SET MemberName = CASE WHEN ISNULL(@MotherName,'') != '' THEN @MotherName ELSE POST0011.MemberName END,
	POST0011.[Address] = EDMT2010.[Address],
	POST0011.Tel = EDMT2010.MotherMobiphone,
	POST0011.Email = EDMT2010.MotherEmail
	FROM POST0011  WITH (NOLOCK)  
	LEFT JOIN  EDMT2010 WITH (NOLOCK) ON POST0011.MemberID = EDMT2010.MotherID AND EDMT2010.DeleteFlg = 0  
	WHERE MemberID = @MotherID AND EDMT2010.APK = @APK 

	END 


















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
