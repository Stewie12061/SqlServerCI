IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Import Excel nghiệp vụ phiếu thông tin tư vấn 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Hồng Thảo on 23/8/2019
---- Modified by on Đình hòa on 06/04/2021 : Kiêm tra và thêm dữ liệu khi insert 
-- <Example>
/* 
 EXEC EDMP2005 @DivisionID, @UserID, @ImportTransTypeID, @XML
 */
 
CREATE PROCEDURE EDMP2005
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

SET @sSQL = ' ALTER TABLE #Data ADD Password VARCHAR(Max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL;
				ALTER TABLE #Data ADD [APK] [uniqueidentifier] DEFAULT NEWID();'
PRINT @sSQL
EXEC (@sSQL)

SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('VoucherNo').value('.', 'VARCHAR(50)') AS VoucherNo,
		X.Data.query('VoucherDate').value('.', 'VARCHAR(50)') AS VoucherDate,
		X.Data.query('ResultID').value('.', 'VARCHAR(50)') AS ResultID,
		X.Data.query('AdmissionDate').value('.', 'VARCHAR(50)') AS AdmissionDate,
		--X.Data.query('FeeID').value('.', 'VARCHAR(50)') AS FeeID,
		(CASE WHEN X.Data.query('Amount').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('Amount').value('.', 'DECIMAL(28,8)') END) AS Amount,	
		X.Data.query('DateFrom').value('.', 'VARCHAR(50)') AS DateFrom, 
		X.Data.query('DateTo').value('.', 'VARCHAR(50)') AS DateTo,	
		(CASE WHEN X.Data.query('OldCustomer').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('OldCustomer').value('.', 'TINYINT') END) AS OldCustomer,
		X.Data.query('SType01ID').value('.', 'VARCHAR(50)') AS SType01ID,
		X.Data.query('SType02ID').value('.', 'VARCHAR(50)') AS SType02ID,
		X.Data.query('SType03ID').value('.', 'VARCHAR(50)') AS SType03ID,	
		X.Data.query('ParentID').value('.', 'VARCHAR(50)') AS ParentID,
		X.Data.query('ParentName').value('.', 'NVARCHAR(250)') AS ParentName,
		X.Data.query('Prefix').value('.', 'VARCHAR(50)') AS Prefix, 
		X.Data.query('ParentDateBirth').value('.', 'VARCHAR(50)') AS ParentDateBirth, 
		X.Data.query('Telephone').value('.', 'VARCHAR(50)') AS Telephone,			
		X.Data.query('Address').value('.', 'NVARCHAR(250)') AS [Address],
		X.Data.query('Email').value('.', 'VARCHAR(50)') AS Email,
		X.Data.query('SType01IDS').value('.', 'VARCHAR(50)') AS SType01IDS,
		X.Data.query('SType02IDS').value('.', 'VARCHAR(50)') AS SType02IDS,
		X.Data.query('SType03IDS').value('.', 'VARCHAR(50)') AS SType03IDS,
		X.Data.query('StudentID').value('.', 'VARCHAR(50)') AS StudentID,
		X.Data.query('StudentName').value('.', 'NVARCHAR(250)') AS StudentName, 
		X.Data.query('StudentDateBirth').value('.', 'VARCHAR(50)') AS StudentDateBirth, 
		(CASE WHEN X.Data.query('Sex').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('Sex').value('.', 'TINYINT') END) AS Sex,	
		X.Data.query('Information').value('.', 'NVARCHAR(250)') AS Information,
		X.Data.query('Password').value('.', 'NVARCHAR(Max)') AS [Password],
		IDENTITY(int, 1, 1) AS Orders			
INTO #EDMT2000
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], Orders, DivisionID,VoucherNo,VoucherDate, ResultID, Amount, AdmissionDate, --FeeID,  
					DateFrom, DateTo, OldCustomer,SType01ID, SType02ID, SType03ID,ParentID, 
					ParentName,Prefix,ParentDateBirth,Telephone,[Address],Email,
					SType01IDS, SType02IDS, SType03IDS, StudentID,StudentName,StudentDateBirth,Sex,Information, [Password] )
SELECT [Row], Orders, DivisionID, VoucherNo,
CASE WHEN ISNULL(VoucherDate, '') = '' THEN NULL ELSE CONVERT(datetime, VoucherDate, 104) END AS VoucherDate,
ResultID, Amount,
CASE WHEN ISNULL(AdmissionDate, '') = '' THEN NULL ELSE CONVERT(datetime, AdmissionDate, 104) END AS AdmissionDate,
--FeeID,
CASE WHEN ISNULL(DateFrom, '') = '' THEN NULL ELSE CONVERT(datetime, DateFrom, 104) END AS DateFrom,
CASE WHEN ISNULL(DateTo, '') = '' THEN NULL ELSE CONVERT(datetime, DateTo, 104) END AS DateTo,
OldCustomer, SType01ID, SType02ID, SType03ID, ParentID, ParentName, Prefix,
CASE WHEN ISNULL(ParentDateBirth, '') = '' THEN NULL ELSE CONVERT(datetime, ParentDateBirth, 104) END AS ParentDateBirth,
Telephone, [Address], Email, SType01IDS, SType02IDS, SType03IDS, StudentID, StudentName,
CASE WHEN ISNULL(StudentDateBirth, '') = '' THEN NULL ELSE CONVERT(datetime, StudentDateBirth, 104) END AS StudentDateBirth,		
Sex,Information, [Password]
FROM #EDMT2000

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra trùng mã thông tin tư vấn
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData1', @ColID = 'VoucherNo', @Param1 = 'Orders', @Param2 = 'EDMT2000', 
@Param3 = 'VoucherNo', @SQLFilter = 'DeleteFlg = 0'


---- Kiểm tra trùng mã học sinh 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData1', @ColID = 'StudentID', @Param1 = 'Orders', @Param2 = 'EDMT2000', 
@Param3 = 'StudentID', @SQLFilter = 'DeleteFlg = 0'

--Đình Hòa - [02/04/2021] - START ADD
----Bổ sung kiểm tra trùng mã phụ huynh
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData1', @ColID = 'ParentID', @Param1 = 'Orders', @Param2 = 'EDMT2000', 
@Param3 = 'ParentID', @SQLFilter = 'DeleteFlg = 0'
--Đình Hòa - [02/04/2021] - END ADD

------Kiểm tra trùng số điện thoại 
DECLARE @cCURSOR_Tel AS CURSOR,
		@Tel AS NVARCHAR(250), 
		@ObjectID_Tel AS VARCHAR(250)

SET @cCURSOR_Tel = CURSOR STATIC FOR
	SELECT	ParentID,Telephone FROM #Data  
OPEN @cCURSOR_Tel	
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR_Tel INTO @ObjectID_Tel, @Tel
WHILE @@FETCH_STATUS = 0
BEGIN
	 
	 
	---- Kiểm tra trùng số điện thoại trong nghiệp vụ PTTTV
	IF EXISTS (SELECT TOP 1 1  FROM EDMT2000 WITH (NOLOCK) WHERE Telephone = LTRIM(RTRIM(@Tel)) AND DeleteFlg = 0 AND ParentID != @ObjectID_Tel)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @Tel +'-00ML000202,',
			ErrorColumn = @Tel+','
	END 



	---- Kiểm tra trùng số điện thoại trong đối tượng 
	IF EXISTS (SELECT TOP 1 1  FROM AT1202 WITH (NOLOCK) WHERE Tel = LTRIM(RTRIM(@Tel)) AND ObjectID != @ObjectID_Tel)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @Tel +'-00ML000202,',
			ErrorColumn = @Tel+','
	END 


	
	FETCH NEXT FROM @cCURSOR_Tel INTO @ObjectID_Tel, @Tel
END

Close  @cCURSOR_Tel

--Đình Hòa - [06/04/2021] - START ADD
------Kiểm tra mã phân loại
DECLARE @cCURSOR_Type AS CURSOR,
		@sSType01S VARCHAR(50), 
		@sSType02S VARCHAR(50), 
		@sSType03S VARCHAR(50), 
		@sSType01P VARCHAR(50), 
		@sSType02P VARCHAR(50), 
		@sSType03P VARCHAR(50)
			

SET @cCURSOR_Type = CURSOR STATIC FOR
	SELECT	SType01ID, SType02ID, SType03ID, SType01IDS, SType02IDS, SType03IDS FROM #Data  
OPEN @cCURSOR_Type	
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR_Type INTO @sSType01P, @sSType02P, @sSType03P, @sSType01S, @sSType02S, @sSType03S
WHILE @@FETCH_STATUS = 0
BEGIN	  
	---- Kiểm tra Mã phân loại 1
	IF NOT EXISTS (SELECT TOP 1 1  FROM AT1207 WITH (NOLOCK) WHERE S = LTRIM(RTRIM(@sSType01P)) AND STypeID = 'O01')
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = N'Mã phân loại 1 (Phụ huynh) : ' + @sSType01P +' -00ML000070,',
			ErrorColumn = @sSType01P+','
	END
	
	IF NOT EXISTS (SELECT TOP 1 1  FROM AT1207 WITH (NOLOCK) WHERE S = LTRIM(RTRIM(@sSType01S)) AND STypeID = 'O01')
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = N'Mã phân loại 1 (Học sinh) : ' + @sSType01S +' -00ML000070,',
			ErrorColumn = @sSType01S+','
	END 


	---- Kiểm tra Mã phân loại 2
	IF NOT EXISTS (SELECT TOP 1 1  FROM AT1207 WITH (NOLOCK) WHERE S = LTRIM(RTRIM(@sSType02P)) AND STypeID = 'O02')
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = N'Mã phân loại 2 (Phụ huynh) : ' + @sSType02P +' -00ML000070,',
			ErrorColumn = @sSType02P+','
	END
	
	IF NOT EXISTS (SELECT TOP 1 1  FROM AT1207 WITH (NOLOCK) WHERE S = LTRIM(RTRIM(@sSType02S)) AND STypeID = 'O02')
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = N'Mã phân loại 2 (Học sinh) : ' + @sSType02S +' -00ML000070,',
			ErrorColumn = @sSType02S+','
	END 

	---- Kiểm tra Mã phân loại 3
	IF NOT EXISTS (SELECT TOP 1 1  FROM AT1207 WITH (NOLOCK) WHERE S = LTRIM(RTRIM(@sSType03P)) AND STypeID = 'O03')
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = N'Mã phân loại 3 (Phụ huynh) : ' + @sSType03P +' -00ML000070,',
			ErrorColumn = @sSType03P+','
	END
	
	IF NOT EXISTS (SELECT TOP 1 1  FROM AT1207 WITH (NOLOCK) WHERE S = LTRIM(RTRIM(@sSType03S)) AND STypeID = 'O03')
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = N'Mã phân loại 3 (Học sinh) : ' + @sSType03S +' -00ML000070,',
			ErrorColumn = @sSType03S+','
	END 
	FETCH NEXT FROM @cCURSOR_Type INTO @sSType01P, @sSType02P, @sSType03P, @sSType01S, @sSType02S, @sSType03S
END
Close  @cCURSOR_Type
--Đình Hòa - [06/04/2021] - END ADD


------ Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END

---- Đẩy dữ liệu vào phiếu thông tin tư vấn 

INSERT INTO EDMT2000 (APK, DivisionID,VoucherNo,VoucherDate, [Status],ResultID,AdmissionDate, --FeeID, 
Amount, DateFrom, DateTo, OldCustomer,
		SType01ID, SType02ID, SType03ID,ParentID, ParentName,Prefix,ParentDateBirth,Telephone,[Address],Email,
		SType01IDS, SType02IDS, SType03IDS, StudentID,StudentName,StudentDateBirth,Sex,Information,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
SELECT APK,  DivisionID,VoucherNo,VoucherDate, '0',ResultID,AdmissionDate, --FeeID, 
Amount, DateFrom, DateTo, OldCustomer,
		SType01ID, SType02ID, SType03ID,ParentID, ParentName,Prefix,ParentDateBirth,Telephone,[Address],Email,
		SType01IDS, SType02IDS, SType03IDS, StudentID,StudentName,StudentDateBirth,Sex,Information,
		@UserID AS CreateUserID, GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate				
FROM #Data 

-- Thêm dữ liệu học sinh vào table học sinh với thông tin kế thừa từ tư vấn
DECLARE @cCURSOR_std AS CURSOR,
		@APK AS NVARCHAR(250), 
		@ObjectID AS NVARCHAR(250)

SET @cCURSOR_std = CURSOR STATIC FOR
	SELECT	APK,ParentID  FROM #Data  
OPEN @cCURSOR_std	
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR_std INTO @APK,@ObjectID 
WHILE @@FETCH_STATUS = 0
BEGIN
	 
	-- Đẩy mã phụ huynh và học sinh vào danh mục đối tượng, CRM, người dùng 
	EXECUTE EDMP2003 @DivisionID,@UserID,@APK
	 
	FETCH NEXT FROM @cCURSOR_std INTO @APK,@ObjectID 
END

Close  @cCURSOR_std


LB_RESULT:

SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
