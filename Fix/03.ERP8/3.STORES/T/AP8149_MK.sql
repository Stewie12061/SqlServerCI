IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8149_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8149_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Import Danh sách người phụ thuộc
-- <History>
---- Created by Bảo Thy on 15/12/2016 
---- Modified on 23/02/2017 by Phương Thảo : Bổ sung kiểm tra dữ liệu kỳ từ, đến (không kiểm tra theo kỳ có trong hệ thống)
---- Modified on 01/09/2020 by Huỳnh Thử : Merge Code: MEKIO và MTE
---- 
-- <Example>
/* 
 AP8149 @DivisionID = 'VG', @UserID = 'ASOFTADMIN', @ImportTemplateID = 'SalesOrder', @XML = ''
 */
 
CREATE PROCEDURE AP8149_MK
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@CURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000)
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50),
		@EmployeeID VARCHAR(50),
		@RelationName NVARCHAR(100),
		@Order INT = 1
		

CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT,
	Orders INT,
	SOrderID NVARCHAR(50),
	TransactionID NVARCHAR(50),
	ImportMessage NVARCHAR(MAX) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT,	
	Orders INT,
	SOrderID NVARCHAR(50),
	TransactionID NVARCHAR(50),
	VoucherNo NVARCHAR(50),
	Period NVARCHAR(50),
	InventoryID NVARCHAR(50),
	UnitID NVARCHAR(50)
	CONSTRAINT [PK_#Keys] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT		TLD.ColID,
				BTL.ColSQLDataType
	FROM		A01065 TL
	INNER JOIN	A01066 TLD
			ON	TL.ImportTemplateID = TLD.ImportTemplateID
	INNER JOIN	A00065 BTL
			ON	BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
	WHERE		TL.ImportTemplateID = @ImportTemplateID
	ORDER BY	TLD.OrderNum

OPEN @cCURSOR									
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END 
-- Thêm dữ liệu vào bảng tạm
INSERT INTO #Data (Row, DivisionID, EmployeeID, RelationName, Description, Status, EndDate, RelationBirthday, RelationTaxID, NationalityID, CountryID, 
					CityID, DistrictID, WardID, FromPeriod, ToPeriod, RelationID, RelationIdentifyCardNo, CertificateNo, CertifiBook)

SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('RelationName').value('.', 'NVARCHAR(100)') AS RelationName,
		X.Data.query('Description').value('.', 'NVARCHAR(250)') AS Description,
		(CASE WHEN X.Data.query('Status').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('Status').value('.', 'TINYINT') END) AS Status,
		(CASE WHEN X.Data.query('EndDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('EndDate').value('.', 'DATETIME') END) AS EndDate,
		(CASE WHEN X.Data.query('RelationBirthday').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('RelationBirthday').value('.', 'DATETIME') END) AS RelationBirthday,
		X.Data.query('RelationTaxID').value('.', 'NVARCHAR(50)') AS RelationTaxID,
		X.Data.query('NationalityID').value('.', 'NVARCHAR(50)') AS NationalityID,
		X.Data.query('CountryID').value('.', 'NVARCHAR(50)') AS CountryID,
		X.Data.query('CityID').value('.', 'NVARCHAR(50)') AS CityID,
		X.Data.query('DistrictID').value('.', 'NVARCHAR(50)') AS DistrictID,
		X.Data.query('WardID').value('.', 'NVARCHAR(50)') AS WardID,
		X.Data.query('FromPeriod').value('.', 'NVARCHAR(50)') AS FromPeriod,
		X.Data.query('ToPeriod').value('.', 'NVARCHAR(50)') AS ToPeriod,
		X.Data.query('RelationID').value('.', 'NVARCHAR(50)') AS RelationID,
		X.Data.query('RelationIdentifyCardNo').value('.', 'NVARCHAR(100)') AS RelationIdentifyCardNo,
		X.Data.query('CertificateNo').value('.', 'NVARCHAR(100)') AS CertificateNo,
		X.Data.query('CertifiBook').value('.', 'NVARCHAR(100)') AS CertifiBook

FROM	@XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

----- Kiểm tra dữ liệu bắt buộc nhập
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @ColID = 'EmployeeID'
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @ColID = 'RelationName'
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @ColID = 'Status'

---- Kiểm tra tồn tại dữ liệu trong danh mục
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Kiểm tra tính hợp lệ của dữ liệu từ kỳ đến kỳ
DECLARE @ColumnNameFromPeriod NVarchar(50), @ColumnNameToPeriod NVarchar(50)
SELECT	TOP 1 @ColumnNameFromPeriod = DataCol
FROM	A01066 WITH (NOLOCK)
WHERE	ImportTemplateID = @ImportTemplateID AND ColID in ('FromPeriod')

SELECT	TOP 1 @ColumnNameToPeriod = DataCol
FROM	A01066 WITH (NOLOCK)
WHERE	ImportTemplateID = @ImportTemplateID AND ColID in ('ToPeriod')

SET DATEFORMAT dmy
UPDATE	#Data
SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'ASML000092 {0}='''+@ColumnNameFromPeriod+''''
WHERE	IsDate('01/'+ FromPeriod) = 0 AND Isnull(FromPeriod,'') <> '' 
		
UPDATE	#Data
SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'ASML000092 {0}='''+@ColumnNameToPeriod+''''
WHERE	IsDate('01/'+ ToPeriod) = 0 AND Isnull(ToPeriod,'') <> ''

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage != '')
	GOTO LB_RESULT

---- Nếu không có lỗi thì Insert dữ liệu vào bảng
SET @CURSOR = CURSOR STATIC FOR
	SELECT EmployeeID, RelationName
	FROM #Data

OPEN @CURSOR									
FETCH NEXT FROM @CURSOR INTO @EmployeeID,@RelationName
WHILE @@FETCH_STATUS = 0
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM HT0334 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID)
	SET @Order = 1
	ELSE SELECT @Order = MAX(Orders) + 1 FROM HT0334 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID

	INSERT INTO HT0334 (DivisionID, EmployeeID, RelationName, Description, Status, EndDate, RelationBirthday, RelationTaxID, NationalityID, CountryID, 
						CityID, DistrictID, WardID, FromPeriod, ToPeriod, RelationID, RelationIdentifyCardNo, CertificateNo, CertifiBook, Orders,
						TransactionID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)

	SELECT DivisionID, EmployeeID, RelationName, Description, Status, EndDate, RelationBirthday, RelationTaxID, NationalityID, CountryID, 
						CityID, DistrictID, WardID, FromPeriod, ToPeriod, RelationID, RelationIdentifyCardNo, CertificateNo, CertifiBook, @Order,
						NEWID(), @UserID, GETDATE(), @UserID, GETDATE()

	FROM #Data
	WHERE EmployeeID = @EmployeeID AND RelationName = @RelationName

	FETCH NEXT FROM @CURSOR INTO @EmployeeID, @RelationName
END 

-----------------------------------------------------------------------------------------
LB_RESULT:
SELECT * FROM #Data

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

