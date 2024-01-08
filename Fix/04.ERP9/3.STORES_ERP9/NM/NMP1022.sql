IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Import Excel danh mục nhóm thực đơn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Trà Giang on 04/09/2018
-- <Example>
---- 
/*-- <Example>
	NMP1022 @DivisionID, @UserID, @ImportTransTypeID, @XML
----*/

CREATE PROCEDURE NMP1022
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),	
	@ImportTransTypeID VARCHAR(50),
	@XML XML
	
)
AS 
DECLARE @cCURSOR CURSOR,
		@sSQL NVARCHAR(MAX),
		@ColID AS NVARCHAR(50), 
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
		X.Data.query('MenuTypeID').value('.', 'VARCHAR(50)') AS MenuTypeID,
		X.Data.query('MenuTypeName').value('.', 'NVARCHAR(250)') AS MenuTypeName,
		X.Data.query('Description').value('.', 'NVARCHAR(250)') AS Description,
		X.Data.query('GradeLevelID').value('.', 'VARCHAR(50)') AS GradeLevelID,
	    (CASE WHEN X.Data.query('IsCommon').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsCommon').value('.', 'TINYINT') END) AS IsCommon,	
		IDENTITY(int, 1, 1) AS Orders			
	
INTO #NMT1022
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], Orders, DivisionID, MenuTypeID, MenuTypeName,Description,GradeLevelID, IsCommon)
SELECT [Row], Orders, DivisionID, MenuTypeID, MenuTypeName,Description,GradeLevelID, IsCommon
FROM #NMT1022

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID


-- Kiểm tra dữ liệu không đồng nhất tại phần master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues', @ColID = 'MenuTypeID', 
@Param1 = 'MenuTypeID,MenuTypeName, IsCommon'

---- Kiểm tra dữ liệu không đồng nhất tại phần detail 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues', @ColID = 'ActivityTypeID, ActivityID', 
@Param1 = 'MenuTypeID,MenuTypeName, IsCommon,GradeLevelID'

--- Kiểm tra dữ liệu detail 
DECLARE @ColumnName VARCHAR(50), 
		@ColName NVARCHAR(50), 
		@ColumnName1 VARCHAR(50), 
		@ColName1 NVARCHAR(50), 
		@Cur CURSOR, 
		@MenuTypeID VARCHAR(50)

SELECT TOP 1 @ColumnName = DataCol, @ColName = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'MenuTypeID'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT MenuTypeID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @MenuTypeID

WHILE @@FETCH_STATUS = 0
BEGIN

	---- Kiểm tra trùng mã trong import 
	IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE MenuTypeID = @MenuTypeID HAVING COUNT(MenuTypeID) >=2)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-ASML000084,',
				ErrorColumn = @ColName+','
	END 
	
	FETCH NEXT FROM @Cur INTO @MenuTypeID
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
INSERT INTO NMT1020( DivisionID, MenuTypeID, MenuTypeName, Description, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT CASE WHEN IsCommon = 1 THEN '@@@' ELSE DivisionID END AS DivisionID, MenuTypeID, MenuTypeName, Description,IsCommon, @UserID AS CreateUserID, GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate					
FROM #Data
GROUP BY DivisionID,MenuTypeID, MenuTypeName, IsCommon,Description


-- Đẩy dữ liệu vào bảng detail 
INSERT INTO NMT1022(DivisionID,APKMaster, MenuTypeID, GradeLevelID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT CASE WHEN T1.IsCommon = 1 THEN '@@@' ELSE T1.DivisionID END AS DivisionID, T2.APK AS APKMaster, T1.MenuTypeID, T1.GradeLevelID, @UserID AS CreateUserID, GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate					
FROM #Data T1 
INNER JOIN NMT1022 T2 ON T1.DivisionID = T2.DivisionID AND T1. MenuTypeID = T2. MenuTypeID

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
