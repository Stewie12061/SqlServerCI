IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP9023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP9023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Import Danh mục phân bổ hệ số
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Huỳnh Thử, Date: 07/06/2021
----Updated by: Nhật Thanh, Date: 01/10/2021 - Cập nhật vùng nhớ của biến khớp với cấp phát
/*-- <Example>

----*/

CREATE PROCEDURE AP9023
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
)

AS

DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000),
		@FieldName1 AS NVARCHAR(4000) = '',
		@FieldName2 AS NVARCHAR(4000) = ''
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50)
		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT,
	Orders INT,
	EmpFileID NVARCHAR(50) NULL,
	ImportMessage NVARCHAR(500) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT,
	Orders INT,
	EmpFileID NVARCHAR(50),
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
---	PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END

SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		(CASE WHEN X.Data.query('CoefficientID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('CoefficientID').value('.', 'NVARCHAR(50)') END) AS CoefficientID,	
		(CASE WHEN X.Data.query('CoefficientName').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('CoefficientName').value('.', 'NVARCHAR(50)') END) AS CoefficientName,
		(CASE WHEN X.Data.query('InventoryTypeID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('InventoryTypeID').value('.', 'NVARCHAR(50)') END) AS InventoryTypeID,
		(CASE WHEN X.Data.query('CoType').value('.', 'TINYINT') = 0 THEN 0 ELSE X.Data.query('CoType').value('.', 'TINYINT') END) AS CoType,
		(CASE WHEN X.Data.query('Description').value('.', 'VARCHAR(250)') = '' THEN NULL ELSE X.Data.query('Description').value('.', 'NVARCHAR(250)') END) AS Description,
		(CASE WHEN X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') END) AS InventoryID,	
		(CASE WHEN X.Data.query('InventoryName').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('InventoryName').value('.', 'NVARCHAR(50)') END) AS InventoryName,
		(CASE WHEN X.Data.query('CoValue').value('.', 'DECIMAL(28,8)') = 0 THEN 0 ELSE X.Data.query('CoValue').value('.', 'DECIMAL(28,8)') END) AS CoValue,
		(CASE WHEN X.Data.query('Notes').value('.', 'NVARCHAR(250)') = '' THEN NULL ELSE X.Data.query('Notes').value('.', 'NVARCHAR(250)') END) AS Notes
INTO	#AP9023
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (		
		Row,
		DivisionID,		
		CoefficientID,
		CoefficientName,
		InventoryTypeID,
		CoType,
		Description,
		InventoryID,
		InventoryName,
		CoValue,
		Notes)
SELECT Row,
		DivisionID,		
		CoefficientID,
		CoefficientName,
		InventoryTypeID,
		CoType,
		Description,
		InventoryID,
		InventoryName,
		CoValue,
		Notes
FROM #AP9023 H548

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT	


--- Insert dữ liệu mới từ import
-- Master
	INSERT INTO	dbo.MT1604
	(
		APK,
		DivisionID,
		CoefficientID,
		CoefficientName,
		Description,
		InventoryTypeID,
		EmployeeID,
		CoType,
		CreateUserID,
		CreateDate,
		LastModifyUserID,
		LastModifyDate,
		Disabled,
		RefNo
	)
	SELECT TOP 1 
	NEWID(),
	@DivisionID ,
    CoefficientID,
    CoefficientName,
    Description,
    InventoryTypeID,
    @UserID,
    CoType,
    @UserID,
    GETDATE(),
    @UserID,
    GETDATE(),
    CoType,
    '' FROM #Data

-- Detail
	INSERT INTO dbo.MT1605
	(
		APK,
		DivisionID,
		DeCoefficientID,
		CoefficientID,
		InventoryID,
		CoValue,
		Notes
	)
	SELECT NEWID(),
	DivisionID,
	NEWID(),
	CoefficientID,
	InventoryID,
	CoValue,
Notes 
FROM #Data
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT		

LB_RESULT:
SELECT * FROM #Data WHERE ImportMessage <> ''

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
