IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8164]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8164]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Import Chỉ Tiêu Doanh Số Nhân Viên.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Nhựt Trường, Date: 28/08/2021
----MODIFY by:  Thanh Lượng, Date: 17/11/2023 - [2023/11/IS/0079]: Bổ sung check tồn tại đối tượng trong chỉ tiêu.
/*-- <Example>

----*/

CREATE PROCEDURE AP8164
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
	TransactionID NVARCHAR(50),
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
	TransactionID NVARCHAR(50)
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
		X.Data.query('FromDate').value('.', 'DATETIME') AS FromDate,
		(CASE WHEN X.Data.query('ToDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ToDate').value('.', 'DATETIME') END) AS ToDate,
		(CASE WHEN X.Data.query('TargetsID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('TargetsID').value('.', 'NVARCHAR(50)') END) AS TargetsID,
		(CASE WHEN X.Data.query('Description').value('.', 'VARCHAR(250)') = '' THEN NULL ELSE X.Data.query('Description').value('.', 'NVARCHAR(250)') END) AS Description,
		(CASE WHEN X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') END) AS EmployeeID,	
		(CASE WHEN X.Data.query('EmployeeLevel').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('EmployeeLevel').value('.', 'NVARCHAR(50)') END) AS EmployeeLevel,
		(CASE WHEN X.Data.query('ObjectID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ObjectID').value('.', 'VARCHAR(50)') END) AS ObjectID,
		(CASE WHEN X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') END) AS DepartmentID,
		(CASE WHEN X.Data.query('TeamID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('TeamID').value('.', 'NVARCHAR(50)') END) AS TeamID,
		(CASE WHEN X.Data.query('InventoryTypeID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('InventoryTypeID').value('.', 'NVARCHAR(50)') END) AS InventoryTypeID,
		(CASE WHEN X.Data.query('InventoryTypeID2').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('InventoryTypeID2').value('.', 'NVARCHAR(50)') END) AS InventoryTypeID2,
		CASE WHEN ISNULL(X.Data.query('SalesMonth').value('.', 'NVARCHAR(50)'),'') = '' THEN 0 ELSE X.Data.query('SalesMonth').value('.', 'DECIMAL(28,8)') END AS SalesMonth,
		CASE WHEN ISNULL(X.Data.query('SalesQuarter').value('.', 'NVARCHAR(50)'),'') = '' THEN 0 ELSE X.Data.query('SalesQuarter').value('.', 'DECIMAL(28,8)') END AS SalesQuarter,
		CASE WHEN ISNULL(X.Data.query('SalesYear').value('.', 'NVARCHAR(50)'),'') = '' THEN 0 ELSE X.Data.query('SalesYear').value('.', 'DECIMAL(28,8)') END AS SalesYear,
		(CASE WHEN X.Data.query('SOAna01ID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('SOAna01ID').value('.', 'NVARCHAR(50)') END) AS SOAna01ID,
		(CASE WHEN X.Data.query('SOAna02ID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('SOAna02ID').value('.', 'NVARCHAR(50)') END) AS SOAna02ID,
		(CASE WHEN X.Data.query('SOAna03ID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('SOAna03ID').value('.', 'NVARCHAR(50)') END) AS SOAna03ID,
		(CASE WHEN X.Data.query('SOAna04ID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('SOAna04ID').value('.', 'NVARCHAR(50)') END) AS SOAna04ID,
		(CASE WHEN X.Data.query('SOAna05ID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('SOAna05ID').value('.', 'NVARCHAR(50)') END) AS SOAna05ID
INTO	#AP8164
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (		
		Row,
		DivisionID,		
		FromDate,
		ToDate,
		TargetsID,
		TransactionID,
		Description,
		EmployeeID,
		EmployeeLevel,
		ObjectID,
		DepartmentID,
		TeamID,
		InventoryTypeID,
		InventoryTypeID2,
		SalesMonth,
		SalesQuarter,
		SalesYear,
		SOAna01ID,
		SOAna02ID,
		SOAna03ID,
		SOAna04ID,
		SOAna05ID)
SELECT Row,
		DivisionID,		
		FromDate,
		ToDate,
		TargetsID,
		NULL AS TransactionID,
		Description,
		EmployeeID,
		EmployeeLevel,
		ObjectID,
		DepartmentID,
		TeamID,
		InventoryTypeID,
		InventoryTypeID2,
		SalesMonth,
		SalesQuarter,
		SalesYear,
		SOAna01ID,
		SOAna02ID,
		SOAna03ID,
		SOAna04ID,
		SOAna05ID
FROM #AP8164

-- Sinh khóa
DECLARE @cKey AS CURSOR
DECLARE @Row AS INT,
		@Orders AS INT = 0,
		@TargetsID AS NVARCHAR(50),
		@ObjectID AS NVARCHAR(50),
		@TransID AS NVARCHAR(50)

SET @cKey = CURSOR FOR
	SELECT	Row, TargetsID, ObjectID
	FROM	#Data
		
OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row, @TargetsID, @ObjectID
WHILE @@FETCH_STATUS = 0
BEGIN	
	SET @Orders = @Orders + 1
	SET @TransID = NEWID()

	INSERT INTO #Keys (Row, Orders, TransactionID) 
	VALUES (@Row, @Orders, @TransID)				
	FETCH NEXT FROM @cKey INTO @Row, @TargetsID, @ObjectID

END	
CLOSE @cKey

-- Cập nhật khóa
UPDATE		DT
SET			Orders = K.Orders,
			DT.TransactionID = K.TransactionID		
FROM		#Data DT
INNER JOIN	#Keys K
		ON	K.Row = DT.Row

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Check Đối tượng đã tồn tại trong chỉ tiêu
UPDATE #Data
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'OFML000305 {0}='''+@ObjectID+''''
WHERE Exists (SELECT  ObjectID FROM AT0161 WITH (NOLOCK)
				   WHERE TargetsID = #Data.TargetsID and ObjectID = #Data.ObjectID
				   and DivisionID =  #Data.DivisionID) 

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT	

--- Insert dữ liệu mới từ import
-- Master
	INSERT INTO	dbo.AT0161
	(
		APK,
		DivisionID,	
		FromDate,
		ToDate,
		TargetsID,
		TransactonID,
		Description,
		EmployeeLevel,
		DepartmentID,
		TeamID,
		SalesMonth,
		SalesQuarter,
		SalesYear,
		CreateDate,
		CreateUserID,
		LastModifyDate,
		LastModifyUserID,
		EmployeeID,
		ObjectID,
		InventoryTypeID,
		Orders,
		InventoryTypeID2,
		SOAna01ID,
		SOAna02ID,
		SOAna03ID,
		SOAna04ID,
		SOAna05ID
	)
	SELECT
	NEWID(),
	@DivisionID,	
	FromDate,
	ToDate,
	TargetsID,
	TransactionID,
	Description,
	EmployeeLevel,
	DepartmentID,
	TeamID,
	SalesMonth,
	SalesQuarter,
	SalesYear,
	GETDATE(),
	@UserID,
	GETDATE(),
	@UserID,
	EmployeeID,
	ObjectID,
	InventoryTypeID,
	Orders,
	InventoryTypeID2,
	SOAna01ID,
	SOAna02ID,
	SOAna03ID,
	SOAna04ID,
	SOAna05ID
	FROM #Data

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT		

LB_RESULT:
SELECT * FROM #Data

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
