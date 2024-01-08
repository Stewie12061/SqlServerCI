IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2027]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2027]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













-- <Summary>
---- Import Excel nghiệp vụ hồ sơ học sinh 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Hồng Thảo on 23/8/2019
---- Modified by on  
-- <Example>
/* 
 EXEC EDMP2027 @DivisionID, @UserID, @ImportTransTypeID, @XML
 */
 
CREATE PROCEDURE EDMP2027
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),	
	@ImportTransTypeID VARCHAR(50),
	@XML XML
) 
AS
DECLARE @cCURSOR CURSOR,
		@sSQL NVARCHAR(MAX),
		@ColID VARCHAR(50), 
		@ColSQLDataType VARCHAR(50)
		
CREATE TABLE #Data
(
	[Row] INT,
	Orders INT,
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
	ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT A00065.ColID, A00065.ColSQLDataType
	FROM A01065 WITH (NOLOCK) 
	INNER JOIN A00065 WITH (NOLOCK) ON A01065.ImportTemplateID = A00065.ImportTransTypeID
	WHERE A01065.ImportTemplateID = @ImportTransTypeID
	ORDER BY A00065.OrderNum
			
OPEN @cCURSOR									
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END 
CLOSE @cCURSOR


SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('StudentID').value('.', 'VARCHAR(50)') AS StudentID,
		X.Data.query('StudentName').value('.', 'NVARCHAR(250)') AS StudentName,
		X.Data.query('PlaceOfBirth').value('.', 'NVARCHAR(250)') AS PlaceOfBirth,
		X.Data.query('NationalityID').value('.', 'VARCHAR(50)') AS NationalityID,
		X.Data.query('NationID').value('.', 'VARCHAR(50)') AS NationID,
		X.Data.query('FatherID').value('.', 'VARCHAR(50)') AS FatherID,
		X.Data.query('FatherName').value('.', 'NVARCHAR(250)') AS FatherName,
		X.Data.query('FatherDateOfBirth').value('.', 'VARCHAR(50)') AS FatherDateOfBirth,
		X.Data.query('FatherPlaceOfBirth').value('.', 'NVARCHAR(250)') AS FatherPlaceOfBirth, 
		X.Data.query('FatherNationalityID').value('.', 'VARCHAR(50)') AS FatherNationalityID,
		X.Data.query('FatherNationID').value('.', 'VARCHAR(50)') AS FatherNationID,
		X.Data.query('FatherJob').value('.', 'NVARCHAR(250)') AS FatherJob,
		X.Data.query('FatherOffice').value('.', 'NVARCHAR(250)') AS FatherOffice,
		X.Data.query('FatherPhone').value('.', 'VARCHAR(50)') AS FatherPhone,
		X.Data.query('FatherMobiphone').value('.', 'VARCHAR(50)') AS FatherMobiphone,
		X.Data.query('FatherEmail').value('.', 'VARCHAR(50)') AS FatherEmail,
		X.Data.query('MotherID').value('.', 'VARCHAR(50)') AS MotherID,
		X.Data.query('MotherName').value('.', 'NVARCHAR(250)') AS MotherName,
		X.Data.query('MotherDateOfBirth').value('.', 'VARCHAR(50)') AS MotherDateOfBirth,
		X.Data.query('MotherPlaceOfBirth').value('.', 'NVARCHAR(250)') AS MotherPlaceOfBirth, 
		X.Data.query('MotherNationalityID').value('.', 'VARCHAR(50)') AS MotherNationalityID,
		X.Data.query('MotherNationID').value('.', 'VARCHAR(50)') AS MotherNationID,
		X.Data.query('MotherJob').value('.', 'NVARCHAR(250)') AS MotherJob,
		X.Data.query('MotherOffice').value('.', 'NVARCHAR(250)') AS MotherOffice,
		X.Data.query('MotherPhone').value('.', 'VARCHAR(50)') AS MotherPhone,
		X.Data.query('MotherMobiphone').value('.', 'VARCHAR(50)') AS MotherMobiphone,
		X.Data.query('MotherEmail').value('.', 'VARCHAR(50)') AS MotherEmail,
		IDENTITY(int, 1, 1) AS Orders			
INTO #EDMT2010
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]


INSERT INTO #Data ([Row], Orders, DivisionID,StudentID,StudentName,
    	PlaceOfBirth,
		NationalityID,
		NationID,
		FatherID,
		FatherName,
		FatherDateOfBirth,
		FatherPlaceOfBirth,FatherNationalityID,FatherNationID,FatherJob,FatherOffice,FatherPhone,FatherMobiphone,FatherEmail,
		MotherID,MotherName,MotherDateOfBirth,
		MotherPlaceOfBirth,MotherNationalityID,MotherNationID,MotherJob,MotherOffice,MotherPhone,MotherMobiphone,MotherEmail)

SELECT [Row], Orders, DivisionID,StudentID,StudentName,
		PlaceOfBirth,
		NationalityID,
		NationID,
		FatherID,
		FatherName,
		CASE WHEN ISNULL(FatherDateOfBirth, '') = '' THEN NULL ELSE CONVERT(datetime, FatherDateOfBirth, 104) END AS FatherDateOfBirth,
		FatherPlaceOfBirth,FatherNationalityID,FatherNationID,FatherJob,FatherOffice,FatherPhone,FatherMobiphone,FatherEmail,
		MotherID,MotherName,CASE WHEN ISNULL(MotherDateOfBirth, '') = '' THEN NULL ELSE CONVERT(datetime, MotherDateOfBirth, 104) END AS MotherDateOfBirth,
		MotherPlaceOfBirth,MotherNationalityID,MotherNationID,MotherJob,MotherOffice,MotherPhone,MotherMobiphone,MotherEmail
FROM #EDMT2010

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

 

------ Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END

------UPDATE phụ huynh vào hồ sơ học sinh 

DECLARE @cCURSOR_std AS CURSOR,
		@DivisionIDCur AS NVARCHAR(250), 
		@StudentID AS VARCHAR(50),
		@FatherID AS VARCHAR(50),
		@MotherID AS VARCHAR(50),
		@APKCur AS VARCHAR(50),
		@Prefix AS VARCHAR(50),
		@FatherName NVARCHAR(250),
		@MotherName  NVARCHAR(250),
		@APK VARCHAR(50),
		@FatherIDOld AS VARCHAR(50),
		@MotherIDOld AS VARCHAR(50)

SET @cCURSOR_std = CURSOR STATIC FOR
	SELECT		DivisionID,StudentID,FatherID,MotherID,FatherName,MotherName
	FROM	#Data
OPEN @cCURSOR_std	
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR_std INTO @DivisionIDCur,@StudentID,@FatherID,@MotherID,@FatherName,@MotherName
WHILE @@FETCH_STATUS = 0
BEGIN

SELECT @APKCur = APK,@Prefix = Prefix FROM EDMT2000 WITH (NOLOCK) WHERE DivisionID = @DivisionIDCur AND StudentID = @StudentID  AND DeleteFlg = 0

SELECT @FatherIDOld = FatherID,@MotherIDOld = MotherID FROM EDMT2010 WITH(NOLOCK) WHERE DivisionID = @DivisionIDCur AND StudentID = @StudentID AND DeleteFlg = 0 

EXECUTE EDMP2049 @DivisionIDCur,  @UserID , @StudentID ,@FatherID ,@MotherID ,@FatherIDOld ,@MotherIDOld


-----Cập nhật thông tin hồ sơ học sinh  
 UPDATE EDMT2010
 SET
	 StudentName = T2.StudentName,
	 PlaceOfBirth = T2.PlaceOfBirth,
	 NationalityID = T2.NationalityID,
	 NationID = T2.NationID,
	 FatherID = T2.FatherID ,
	 FatherDateOfBirth = T2.FatherDateOfBirth,
	 FatherPlaceOfBirth = T2.FatherPlaceOfBirth,
	 FatherNationalityID = T2.FatherNationalityID,
	 FatherNationID = T2.FatherNationID,
	 FatherJob = T2.FatherJob,
	 FatherOffice = T2.FatherOffice,
	 FatherPhone = T2.FatherPhone,
	 FatherMobiphone = T2.FatherMobiphone,
	 FatherEmail = T2.FatherEmail,
	 MotherID =  T2.MotherID,
	 MotherDateOfBirth = T2.MotherDateOfBirth,
	 MotherPlaceOfBirth = T2.MotherPlaceOfBirth,
	 MotherNationalityID = T2.MotherNationalityID,
	 MotherNationID = T2.MotherNationID,
	 MotherJob = T2.MotherJob,
	 MotherOffice = T2.MotherOffice,
	 MotherPhone = T2.MotherPhone,
	 MotherMobiphone = T2.MotherMobiphone,
	 MotherEmail = T2.MotherEmail

 FROM EDMT2010 T1 WITH (NOLOCK)
 INNER JOIN #Data T2 ON T1.StudentID = T2.StudentID AND T1.DeleteFlg = 0 
	  
 WHERE T1.DivisionID = @DivisionIDCur AND T1.StudentID = @StudentID AND T1.DeleteFlg = 0 


 -----Cập nhật thông tin phụ huynhh 
 SELECT @APK = APK FROM EDMT2010 WHERE StudentID = @StudentID AND DeleteFlg = 0

 EXECUTE EDMP2019 @DivisionID,@UserID,@FatherName,@MotherName,@APK


	
	FETCH NEXT FROM @cCURSOR_std INTO  @DivisionIDCur,@StudentID,@FatherID,@MotherID,@FatherName,@MotherName
	 
END





LB_RESULT:

SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]

 













GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
