IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1052]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Import Excel danh mục món ăn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Trà Giang on 31/08/2018
---- Modified by on 
-- <Example>
/* 
 EXEC NMP1052 @DivisionID, @UserID, @ImportTransTypeID, @XML
 */
 
CREATE PROCEDURE NMP1052
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
		X.Data.query('DishID').value('.', 'VARCHAR(50)') AS DishID,
		X.Data.query('DishName').value('.', 'NVARCHAR(250)') AS DishName, 
		X.Data.query('DishTypeID').value('.', 'VARCHAR(50)') AS DishTypeID, 
	    X.Data.query('MaterialsID').value('.', 'VARCHAR(50)') AS MaterialsID,
		X.Data.query('UnitID').value('.', 'VARCHAR(50)') AS UnitID, 
		(CASE WHEN X.Data.query('Mass').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('Mass').value('.', 'DECIMAL(28,8)') END) AS Mass,	
		(CASE WHEN X.Data.query('ConvertedMass').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('ConvertedMass').value('.', 'DECIMAL(28,8)') END) AS ConvertedMass,	
		X.Data.query('Description').value('.', 'VARCHAR(50)') AS Description, 
	(CASE WHEN X.Data.query('IsCommon').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsCommon').value('.', 'TINYINT') END) AS IsCommon,	
	IDENTITY(int, 1, 1) AS Orders			
INTO #NMT1050
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], DivisionID, DishID, DishName,DishTypeID, MaterialsID,UnitID,Mass,ConvertedMass,Description,IsCommon)
SELECT [Row], DivisionID, DishID, DishName,DishTypeID, MaterialsID,UnitID,Mass,ConvertedMass,Description,IsCommon
FROM #NMT1050

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra trùng mã mon ăn
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData', @ColID = 'DishID', @Param1 = 'Orders', @Param2 = 'NMT1050', 
@Param3 = 'DishID'

------ Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END

------ Sinh APK cho master 
SELECT DISTINCT NEWID() AS APK,DivisionID, DishID, DishName,DishTypeID,Description,IsCommon
INTO #APK_Data
FROM #Data
---- Đẩy dữ liệu vào master
INSERT INTO NMT1050 (APK, DivisionID, DishID, DishName,DishTypeID,Description,IsCommon,CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT NEWID(), CASE WHEN IsCommon = 1 THEN '@@@' ELSE DivisionID END AS DivisionID, DishID, DishName,DishTypeID,Description,IsCommon,
 @UserID AS CreateUserID, GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate				
FROM #APK_Data
GROUP BY APK, DivisionID, DishID, DishName,DishTypeID,Description,IsCommon

-- Đẩy dữ liệu vào bảng detail 
INSERT INTO NMT1051 (APK, DivisionID, APKMaster,  MaterialsID,UnitID,Mass,ConvertedMass, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT NEWID() AS APK, CASE WHEN T1.IsCommon = 1 THEN '@@@' ELSE T1.DivisionID END AS DivisionID, T2.APK AS APKMaster, T1.MaterialsID,T1.UnitID,T1.Mass,T1.ConvertedMass,  @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data T1 
INNER JOIN #APK_Data T2 ON T1.DivisionID = T2.DivisionID AND T1.IsCommon = T2.IsCommon

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
