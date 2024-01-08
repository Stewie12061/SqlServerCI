IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Lưu hồ sơ sinh khi được chuyển trường
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 27/9/2019
-- <Example>
---- 
/*-- <Example>
	EDMP2008 @DivisionID = 'CG', @UserID = 'HONGTHAO', @Mode = '' ,@StudentID = '',@APK = ''
	
	EDMP2008 @DivisionID, @UserID, @Mode,@StudentID,@APK
----*/
CREATE PROCEDURE EDMP2008
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @Mode NVARCHAR(50),
	 @StudentID VARCHAR(50),  -----StudentID của trường cũ 
	 @APK VARCHAR(50) -----APK của mã học sinh trường mới 
)

AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = ''


DECLARE 
		@ParentID VARCHAR(50),
		@StudentNewID VARCHAR(50),
		@ParentName NVARCHAR(250),
		@MotherObjectID VARCHAR(50),
		@FatherObjectID VARCHAR(50),
		@ResultID VARCHAR(50)

		
		
-----Phiếu thông tin vấn của học sinh mới 
SELECT @ParentID = ISNULL(ParentID,''),
@StudentNewID = ISNULL(StudentID,''), 
@ParentName =  ParentName,
@ResultID = ResultID
FROM EDMT2000 WHERE APK = @APK





 
IF @Mode = 0 ----------cập nhật trạng thái hồ sơ học sinh là đang học khi đã có hồ sơ 
BEGIN 

UPDATE EDMT2010 
SET StatusID = 0,
    LastModifyUserID = @UserID,
	LastModifyDate = GETDATE()
WHERE StudentID = @StudentNewID AND DeleteFlg = 0 


END 




IF @Mode = 1 ------Lưu thông tin học sinh mới 
BEGIN 



-----Lấy mã phụ huynh từ hồ sơ cũ 
SELECT @FatherObjectID = FatherID,
	   @MotherObjectID = MotherID
FROM EDMT2010 WITH (NOLOCK) 
WHERE StudentID = @StudentID AND DeleteFlg = 0




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
	WHERE ResultID = 0 AND APK = @APK  AND NOT EXISTS (SELECT TOP 1 1 FROM CRMT20301 WITH (NOLOCK) WHERE EDMT2000.APK = CRMT20301.InheritConsultantID AND EDMT2000.DeleteFlg = 0)
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

IF NOT EXISTS (SELECT TOP 1 1 FROM AT1201 WITH (NOLOCK) WHERE ObjectTypeID = 'PH' )
BEGIN 
INSERT INTO AT1201 (APK,DivisionID,ObjectTypeID,ObjectTypeName,[Disabled],CreateDate,CreateUserID,LastModifyDate,LastModifyUserID,IsCommon)
VALUES (NEWID(),'@@@','PH',N'Phụ huynh',0,GETDATE(),@UserID,GETDATE(),@UserID,1) 

END 

print @StudentNewID
SELECT * FROM EDMT2010 WITH (NOLOCK) WHERE StudentID = @StudentNewID AND DeleteFlg = 0

-----Lưu thông tin hồ sơ học sinh 
 IF NOT EXISTS (SELECT TOP 1 1 FROM EDMT2010 WITH (NOLOCK) WHERE StudentID = @StudentNewID AND DeleteFlg = 0 )
	BEGIN
	 
	INSERT INTO EDMT2010 (DivisionID,SType01IDS,SType02IDS,SType03IDS, StudentID, StudentName, StatusID, 
						  DateOfBirth,PlaceOfBirth,NationalityID,NationID,SexID,[Address],[Description],
						  IsInheritConsultant,APKConsultant,
						  FatherID,FatherDateOfBirth,FatherPlaceOfBirth,FatherNationalityID,FatherNationID,
						  FatherJob,FatherOffice,FatherPhone,FatherMobiphone,FatherEmail,
						  MotherID,MotherDateOfBirth,MotherPlaceOfBirth,MotherNationalityID,MotherNationID,
						  MotherJob,MotherOffice,MotherPhone,MotherMobiphone,MotherEmail,
						  CreateUserID,CreateDate,LastModifyUserID,LastModifyDate
						  )


	SELECT  @DivisionID,SType01IDS,SType02IDS,SType03IDS, @StudentNewID, StudentName,
			CASE WHEN @ResultID = 1 THEN 0
				 WHEN @ResultID = 2 THEN 1
				 WHEN @ResultID = 3 THEN 2
			END,  
			DateOfBirth,PlaceOfBirth,NationalityID,NationID,SexID,[Address],[Description],
			1,@APK,
			FatherID,FatherDateOfBirth,FatherPlaceOfBirth,FatherNationalityID,FatherNationID,
			FatherJob,FatherOffice,FatherPhone,FatherMobiphone,FatherEmail,
			MotherID,MotherDateOfBirth,MotherPlaceOfBirth,MotherNationalityID,MotherNationID,
			MotherJob,MotherOffice,MotherPhone,MotherMobiphone,MotherEmail,
			@UserID,GETDATE(),@UserID,GETDATE()           
	FROM EDMT2010 WITH (NOLOCK)
	WHERE StudentID = @StudentID AND DeleteFlg = 0


		SELECT  @DivisionID,SType01IDS,SType02IDS,SType03IDS, @StudentNewID, StudentName,
			CASE WHEN @ResultID = 1 THEN 0
				 WHEN @ResultID = 2 THEN 1
				 WHEN @ResultID = 3 THEN 2
			END,  
			DateOfBirth,PlaceOfBirth,NationalityID,NationID,SexID,[Address],[Description],
			1,@APK,
			FatherID,FatherDateOfBirth,FatherPlaceOfBirth,FatherNationalityID,FatherNationID,
			FatherJob,FatherOffice,FatherPhone,FatherMobiphone,FatherEmail,
			MotherID,MotherDateOfBirth,MotherPlaceOfBirth,MotherNationalityID,MotherNationID,
			MotherJob,MotherOffice,MotherPhone,MotherMobiphone,MotherEmail,
			@UserID,GETDATE(),@UserID,GETDATE()           
	FROM EDMT2010 WITH (NOLOCK)
	WHERE StudentID = @StudentID AND DeleteFlg = 0

	END 

	
----Lưu học sinh vào đối tượng 
IF NOT EXISTS (SELECT TOP 1 1 FROM AT1202 WITH (NOLOCK) WHERE  ObjectID = @StudentNewID)
	BEGIN 
		INSERT INTO AT1202 (DivisionID,S1,S2,S3, ObjectTypeID, ObjectID, ObjectName, [Address], 
		Tel, Email, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, 
		IsParents, FatherObjectID, MotherObjectID,InheritConsultantID, Contactor,IsCustomer)
		SELECT DivisionID,SType01IDS,SType02IDS,SType03IDS, N'KH', @StudentNewID, StudentName, [Address], 
		NULL, Email,  @UserID, GETDATE() , @UserID, 
		GETDATE(), 0, @FatherObjectID, @MotherObjectID,APK, @ParentName,1
		FROM EDMT2000 WITH (NOLOCK)
		WHERE APK = @APK

	END


 

---Lưu thông tin phụ huynh vào CRM 


 IF  EXISTS (SELECT TOP 1 1 FROM POST0011 WITH (NOLOCK) WHERE  MemberID = @FatherObjectID)
	BEGIN 
	
	UPDATE POST0011
	SET DivisionID = '@@@',
	    IsCommon = 1
	WHERE MemberID = @FatherObjectID

	END 

 IF  EXISTS (SELECT TOP 1 1 FROM POST0011 WITH (NOLOCK) WHERE  MemberID = @MotherObjectID)
	BEGIN 
	
	UPDATE POST0011
	SET DivisionID = '@@@',
		IsCommon = 1
	WHERE MemberID = @MotherObjectID

	END 


END 




END 





 --PRINT @sSQL
 EXEC (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
