IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Import Excel danh mục thực phẩm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Tra Giang on 01/09/2018
---- Modified by on
-- <Example>
 
CREATE PROCEDURE NMP1012
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
	OrderID INT,
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
	ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	DivisionID VARCHAR(50),
	MaterialsID VARCHAR(50),
	MaterialsTypeID VARCHAR(50),
	[Description] NVARCHAR(250),
	SystemID VARCHAR(50),
	ActualQuantity NVARCHAR(50),
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
	X.Data.query('MaterialsID').value('.', 'VARCHAR(50)') AS MaterialsID,
	X.Data.query('MaterialsTypeID').value('.', 'VARCHAR(50)') AS MaterialsTypeID, 
	X.Data.query('Description').value('.', 'NVARCHAR(250)') AS [Description],
	X.Data.query('SystemID').value('.', 'VARCHAR(50)') AS SystemID,
	X.Data.query('ActualQuantity').value('.', 'NVARCHAR(50)') AS ActualQuantity,
	IDENTITY(int, 1, 1) AS OrderID

INTO #NMT1010
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], 
                 OrderID,
				 DivisionID, 
				 MaterialsID,
				 MaterialsTypeID,
				 [Description],
				 SystemID,
				 ActualQuantity)
SELECT	[Row], 
                 OrderID,
				 DivisionID, 
				 MaterialsID,
				 MaterialsTypeID,
				 [Description],
				 SystemID,
				CASE WHEN ISNULL(ActualQuantity,'') = '' THEN 0 ELSE CAST(ActualQuantity AS DECIMAL(28,8)) END ActualQuantity
FROM #NMT1010
---- Kiểm tra check code mặc định 
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

-- Kiểm tra trùng ID trên master
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData', @ColID = 'MaterialsID', @Param1 = '', @Param2 = 'NMT1010', 
@Param3 = 'MaterialsID'

-- Kiểm tra dữ liệu không đồng nhất tại phần master
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-NM', 
@ColID = 'MaterialsID', @Param1 = 'MaterialsID,MaterialsTypeID,Description'

-- Kiểm tra dữ liệu không đồng nhất tại phần detail
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID,  @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-NM', 
@ColID = 'MaterialsID, SystemID', @Param1 = 'MaterialsID,MaterialsTypeID,Description,SystemID,ActualQuantity'

--- Kiểm tra dữ liệu 
DECLARE @ColumnName VARCHAR(50), 
		@ColName NVARCHAR(50), 
		@ColumnName1 VARCHAR(50), 
		@ColName1 NVARCHAR(50), 
		@ColumnName2 VARCHAR(50), 
		@ColName2 NVARCHAR(50),
		@Cur CURSOR,  
		@SystemID VARCHAR(50),
		@MaterialsTypeID VARCHAR(50),
		@MaterialsID VARCHAR(50)

SELECT TOP 1 @ColumnName = DataCol, @ColName = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'MaterialsTypeID'

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SystemID'

SELECT TOP 1 @ColumnName2 = DataCol, @ColName2 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'MaterialsID'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT MaterialsTypeID,SystemID, MaterialsID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @MaterialsTypeID, @SystemID, @MaterialsID

WHILE @@FETCH_STATUS = 0
BEGIN
---- Kiểm tra trùng mã trong danh mục
	IF EXISTS (SELECT TOP 1 1 FROM NMT1010 WITH (NOLOCK) WHERE MaterialsID = @MaterialsID)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName2 + LTRIM(RTRIM(STR([Row]))) +'-00ML000157,',
				ErrorColumn = @ColName2+','
	END 

---- Kiểm tra mã loại thực phẩm không có trong danh sách
	IF NOT EXISTS (SELECT TOP 1 1 FROM NMT1000 WHERE MaterialsTypeID = @MaterialsTypeID)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-00ML000130,',
				ErrorColumn = @ColName+','
	END 
	---- Kiểm tra thành phần dinh dưỡng không có check sử dụng trong thiết lập hệ thống
	IF EXISTS (SELECT TOP 1 1 FROM NMT0001 WHERE SystemID = @SystemID AND IsUse = 0)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-00ML000130,',
				ErrorColumn = @ColName1+','
	END 

	FETCH NEXT FROM @Cur INTO @MaterialsTypeID, @SystemID, @MaterialsID
END
Close @Cur

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END

-- Đẩy dữ liệu vào bảng master
INSERT INTO NMT1010 (APK, DivisionID, MaterialsID, MaterialsTypeID, [Description], CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT NEWID() AS APK, DivisionID, MaterialsID, MaterialsTypeID, [Description],  @UserID AS CreateUserID, GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate
FROM #Data

-- Đẩy dữ liệu vào bảng detail 
INSERT INTO NMT1011 (APK, DivisionID, APKMaster, SystemID, ActualQuantity, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT NEWID() AS APK, T1.DivisionID, T2.APK AS APKMaster, T1.SystemID , T1.ActualQuantity ,  @UserID AS CreateUserID, GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate
FROM #Data T1 
INNER JOIN NMT1010 T2 ON T1.DivisionID = T2.DivisionID AND T1.MaterialsID = T2.MaterialsID AND T1.MaterialsTypeID = T2.MaterialsTypeID 

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
