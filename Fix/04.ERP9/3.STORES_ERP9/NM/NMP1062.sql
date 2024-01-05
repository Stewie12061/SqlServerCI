IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1062]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1062]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Import Excel danh mục bữa ăn
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Trà Giang on 04/09/2018
---- Modified by 
-- <Example>
/* 
 EXEC NMP1062 @DivisionID, @UserID, @ImportTransTypeID, @XML
 */
 
CREATE PROCEDURE NMP1062
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
	X.Data.query('MealID').value('.', 'VARCHAR(50)') AS MealID,
	X.Data.query('MealName').value('.', 'NVARCHAR(250)') AS MealName, 
	X.Data.query('Description').value('.', 'NVARCHAR(250)') AS Description,
	(CASE WHEN X.Data.query('IsCommon').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsCommon').value('.', 'TINYINT') END) AS IsCommon,	
	IDENTITY(int, 1, 1) AS Orders			
INTO #NMP1062
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row],  DivisionID,  MealID, MealName,Description, IsCommon)
SELECT [Row],  DivisionID,  MealID, MealName,Description, IsCommon
FROM #NMP1062

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra trùng mã điều tra tâm lý 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData', @ColID = 'MealID', @Param1 = 'Orders', @Param2 = 'NMT1060', 
@Param3 = 'MealID'

------ Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END

---- Đẩy dữ liệu vào danh mục bua an
INSERT INTO NMT1060 (APK, DivisionID,  MealID, MealName ,Description, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT NEWID(),   CASE WHEN IsCommon = 1 THEN '@@@' ELSE DivisionID END AS DivisionID, MealID, MealName,Description, IsCommon, @UserID AS CreateUserID, 
GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate					
FROM #Data 

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
