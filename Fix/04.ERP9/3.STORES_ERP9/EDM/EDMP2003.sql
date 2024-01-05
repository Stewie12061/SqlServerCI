IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
----Đẩy mã phụ huynh và học sinh vào danh mục đối tượng, CRM, người dùng 
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
	EDMP2003 @DivisionID = 'BE', @UserID = '', @LanguageID = '', @APK = 'A565A93E-588A-48DD-AF4D-38F966C70F68'
	SELECT * FROM EDMT2000 
	EDMP2003 @DivisionID, @UserID, @LanguageID, @APK
----*/
CREATE PROCEDURE EDMP2003
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK  VARCHAR(50) 
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@ParentID VARCHAR(50),
		@StudentID VARCHAR(50),
		@ParentName NVARCHAR(250),
		@Prefix VARCHAR(250),
		@MotherObjectID VARCHAR(50),
		@FatherObjectID VARCHAR(50),
		@FatherDateOfBirth DATETIME,
		@MotherDateOfBirth DATETIME,
		@ParentDateBirth DATETIME,
		@Telephone VARCHAR(50),
		@Address NVARCHAR(250),
		@FatherMobiphone VARCHAR(50),
		@MotherMobiphone VARCHAR(50),
		@FatherEmail VARCHAR(50),
		@MotherEmail VARCHAR(50),
		@Email VARCHAR(50),
		@ResultID VARCHAR(50)

		
		

SELECT @ParentID = ISNULL(ParentID,''),
@StudentID = ISNULL(StudentID,''), 
@ParentName = ParentName,
@Prefix = Prefix,
@ParentDateBirth = ParentDateBirth,
@Telephone = Telephone,
@Address = Address,
@Email = Email,
@ResultID = ResultID
FROM EDMT2000 WHERE APK = @APK


IF @ResultID = 0 
BEGIN 

------Sinh số tự động mã đầu mối

DECLARE
	@IsAutomatic NVARCHAR(100),
	@OutputOrder TINYINT, 
	@OutputLen TINYINT,
	@IsS1 NVARCHAR(50),		@IsS2 NVARCHAR(50),		@IsS3 NVARCHAR(50), 
	@IsSeparator TINYINT,
	@Separator NVARCHAR(10),
	@LeadID NVARCHAR(250) 
	
-- Lấy thiết lập mặc định có sinh số đối tượng tự động hay không
SELECT @IsAutomatic = IsAutomatic,
@OutputOrder = OutputOrder,
@OutputLen = Length,
@IsS1 = ISNULL(S1,''),
@IsS2 = ISNULL(S2,''),
@IsS3 = ISNULL(S3,''),
@IsSeparator = IsSeparator,
@Separator = ISNULL(Separator,'')
 FROM AT0002 WHERE DivisionID = @DivisionID AND  TableID = 'CRMT20301'

 IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT20301 WITH (NOLOCK) WHERE CRMT20301.InheritConsultantID = @APK )
	BEGIN
  ------Tạo mã tăng tự động 
	EXEC AP0000 '@@@', @LeadID  Output, 'CRMT20301', @IsS1, @IsS2, @IsS3, @OutputLen, @OutputOrder, @IsSeparator, @Separator
	


 ------Insert vào thông tin đầu mối 

 IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT20301 WITH (NOLOCK) WHERE LeadID = @LeadID )
 BEGIN

	------Insert vào thông tin đầu mối 
	INSERT INTO CRMT20301 (APK,DivisionID,LeadID,LeadName,Prefix,LeadMobile,[Address],Email,BirthDate,AssignedToUserID,InheritConsultantID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
	SELECT NEWID(),DivisionID,@LeadID,ParentName,Prefix,Telephone,[Address],Email,ParentDateBirth,@UserID,APK,@UserID,GETDATE(),@UserID,GETDATE()
	FROM	EDMT2000 WITH (NOLOCK) 
	WHERE ResultID = 0 AND APK = @APK  AND NOT EXISTS (SELECT TOP 1 1 FROM CRMT20301 WHERE EDMT2000.APK = CRMT20301.InheritConsultantID AND EDMT2000.DeleteFlg = 0)
  END

  END 

 -------Update thông tin đầu mối 

  IF EXISTS (SELECT TOP 1 1 FROM CRMT20301 WITH (NOLOCK) WHERE InheritConsultantID = @APK )
 BEGIN 
	UPDATE CRMT20301
	SET CRMT20301.LeadName = EDMT2000.ParentName,
	CRMT20301.LeadMobile = EDMT2000.Telephone,
	CRMT20301.[Address] = EDMT2000.[Address],
	CRMT20301.Email = EDMT2000.Email,
	CRMT20301.LastModifyUserID = @UserID ,
	CRMT20301.LastModifyDate = GETDATE()
	FROM CRMT20301 WITH (NOLOCK)  
	LEFT JOIN EDMT2000 WITH (NOLOCK) ON EDMT2000.APK = CRMT20301.InheritConsultantID AND EDMT2000.DeleteFlg = 0
	WHERE EDMT2000.ResultID = 0 AND CRMT20301.InheritConsultantID = @APK



  END





END 


 ------Không phản hồi thì không xử lý sinh đối tượng và học sinh
--IF(@ResultID = '0')
--	RETURN

IF @ResultID != 0  
BEGIN 
IF(@Prefix = '1')
	SET @FatherObjectID = @ParentID
ELSE
	SET @MotherObjectID = @ParentID

IF(@Prefix = '1')
	SET @FatherDateOfBirth = @ParentDateBirth
ELSE
	SET @MotherDateOfBirth = @ParentDateBirth

IF(@Prefix = '1')
	SET @FatherMobiphone = @Telephone
ELSE
	SET @MotherMobiphone = @Telephone


IF(@Prefix = '1')
	SET @FatherEmail = @Email
ELSE
	SET @MotherEmail = @Email


	/*
-- Biến để tạo mã tăng tự động
DECLARE
	@IsAutomatic NVARCHAR(100),
	@OutputOrder TINYINT, 
	@OutputLen TINYINT,
	@IsS1 TINYINT,		@IsS2 TINYINT,		@IsS3 TINYINT, 
	@IsSeparator TINYINT,
	@Separator NVARCHAR(10),
	@SType01ID NVARCHAR(100), @SType02ID NVARCHAR(100), @SType03ID NVARCHAR(100),
	@SType01IDS NVARCHAR(100), @SType02IDS NVARCHAR(100), @SType03IDS NVARCHAR(100),
	@ObjectVoucherNo NVARCHAR(250),
	@StudentVoucherNo NVARCHAR(250)

-- Lấy thiết lập mặc định có sinh số đối tượng tự động hay không
SELECT @IsAutomatic = IsAutomatic,
@OutputOrder = OutputOrder,
@OutputLen = Length,
@IsS1 = IsS1,
@IsS2 = IsS2,
@IsS3 = IsS3,
@IsSeparator = IsSeparator,
@Separator = ISNULL(Separator,'')
 FROM AT0002 WHERE DivisionID = @DivisionID AND TableID = 'AT1202'
 
--- Lấy thiết lập phân loại 1,2,3 theo đối tượng
SELECT 
@SType01ID = ISNULL(SType01ID,''),
@SType02ID = ISNULL(SType02ID,''),
@SType03ID = ISNULL(SType03ID,''),
@SType01IDS = ISNULL(SType01IDS,''),
@SType02IDS = ISNULL(SType02IDS,''),
@SType03IDS = ISNULL(SType03IDS,'')
FROM EDMT0000 WHERE DivisionID = @DivisionID

 ---Mã phụ huynh
EXEC AP0000 @DivisionID, @ObjectVoucherNo Output, 'AT1202', 
@SType01ID, @SType02ID, @SType03ID, @OutputLen, @OutputOrder, @IsSeparator, @Separator
---Mã học sinh
EXEC AP0000 @DivisionID, @StudentVoucherNo Output, 'AT1202', 
@SType01ID, @SType02IDS, @SType03IDS, @OutputLen, @OutputOrder, @IsSeparator, @Separator
-- TEST
print @ObjectVoucherNo
print @StudentVoucherNo
*/

IF NOT EXISTS (SELECT TOP 1 1 FROM AT1201 WITH (NOLOCK) WHERE ObjectTypeID = 'PH' )
BEGIN 
INSERT INTO AT1201 (APK,DivisionID,ObjectTypeID,ObjectTypeName,[Disabled],CreateDate,CreateUserID,LastModifyDate,LastModifyUserID,IsCommon)
VALUES (NEWID(),'@@@','PH',N'Phụ huynh',0,GETDATE(),@UserID,GETDATE(),@UserID,1) 

END 



-----Lưu thông tin hồ sơ học sinh 
 IF NOT EXISTS (SELECT TOP 1 1 FROM EDMT2010 WITH (NOLOCK) WHERE StudentID = @StudentID AND DeleteFlg = 0 )
	BEGIN 
	INSERT INTO EDMT2010 (DivisionID,SType01IDS,SType02IDS,SType03IDS, StudentID, StudentName, StatusID, 
						  DateOfBirth, SexID, Address,IsInheritConsultant,APKConsultant,FatherID,MotherID,
						  FatherDateOfBirth,MotherDateOfBirth,FatherMobiphone,MotherMobiphone,FatherEmail, MotherEmail,
						  CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	SELECT               DivisionID,SType01IDS,SType02IDS,SType03IDS,@StudentID, StudentName,CASE WHEN ResultID = 1 THEN 0
															WHEN ResultID = 2 THEN 1
															WHEN ResultID = 3 THEN 2
															END, 
						StudentDateBirth, Sex, [Address],1,APK,@FatherObjectID, @MotherObjectID,@FatherDateOfBirth,@MotherDateOfBirth,@FatherMobiphone,@MotherMobiphone,@FatherEmail,@MotherEmail, 
						@UserID, GETDATE(), @UserID, GETDATE()
		FROM EDMT2000
		WHERE APK = @APK
	END 

	
----Lưu học sinh vào đối tượng 
IF NOT EXISTS (SELECT TOP 1 1 FROM AT1202 WITH (NOLOCK) WHERE  ObjectID = @StudentID)
	BEGIN 
		Insert into AT1202 (DivisionID,S1,S2,S3, ObjectTypeID, ObjectID, ObjectName, [Address], 
		Tel, Email, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, 
		IsParents, FatherObjectID, MotherObjectID,InheritConsultantID, Contactor,IsCustomer,IsUsedEInvoice)
		SELECT DivisionID,SType01IDS,SType02IDS,SType03IDS, N'KH', @StudentID, StudentName, [Address], 
		NULL, Email,  @UserID, GETDATE() , @UserID, 
		GETDATE(), 0, @FatherObjectID, @MotherObjectID,APK, @ParentName,1,1
		FROM EDMT2000 
		WHERE APK = @APK

	END


----Lưu thông tin phụ huynh vào danh mục đối tượng 
IF NOT EXISTS (SELECT TOP 1 1 FROM AT1202 WITH (NOLOCK) WHERE  ObjectID = @ParentID)
	BEGIN 

		INSERT INTO  AT1202 (DivisionID, ObjectTypeID,S1,S2,S3, ObjectID, ObjectName, [Address], Tel, Email, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsParents,InheritConsultantID,IsCustomer,IsCommon)
		SELECT '@@@', N'PH',SType01ID,SType02ID,SType03ID, ParentID, ParentName, [Address], Telephone, Email,  @UserID, GETDATE() , @UserID, GETDATE(), 1,APK,1,1
		FROM EDMT2000 
		WHERE APK = @APK
	END
	

---Lưu thông tin phụ huynh vào CRM 

 IF NOT EXISTS (SELECT TOP 1 1 FROM POST0011 WITH (NOLOCK) WHERE  MemberID = @ParentID)
	BEGIN 
	
	INSERT INTO POST0011 (DivisionID,MemberID,MemberName,[Address],Tel,Email,[Disabled],CreateDate,CreateUserID,LastModifyDate,LastModifyUserID,IsCommon,Identify)
	SELECT DivisionID,ParentID,ParentName,[Address],Telephone,Email,0,GETDATE(),'ASOFTADMIN',GETDATE(),'ASOFTADMIN',0,0
	FROM EDMT2000 
	WHERE APK = @APK

	END 
	



END 



















	


--PRINT @sSQL
EXEC (@sSQL)











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
