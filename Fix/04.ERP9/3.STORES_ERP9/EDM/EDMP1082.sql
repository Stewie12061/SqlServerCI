IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1082]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1082]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Import Excel danh mục Feeling
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Hồng Thảo on 25/08/2018
---- Modified by on
-- <Example>
 
CREATE PROCEDURE EDMP1082
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
	X.Data.query('FeelingID').value('.', 'VARCHAR(50)') AS FeelingID,
	X.Data.query('FeelingName').value('.', 'NVARCHAR(250)') AS FeelingName,  
	(CASE WHEN X.Data.query('IsCommon').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsCommon').value('.', 'TINYINT') END) AS IsCommon,	
	IDENTITY(int, 1, 1) AS OrderID
INTO #EDMT1080
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], OrderID, DivisionID,  FeelingID,FeelingName, IsCommon)
SELECT [Row], OrderID, DivisionID, FeelingID, FeelingName, IsCommon
FROM #EDMT1080
---- Kiểm tra check code mặc định 
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID


-- Kiểm tra trùng ID 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData', @ColID = 'FeelingID', @Param1 = '', @Param2 = 'EDMT1080', 
@Param3 = 'FeelingID'



---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END

-- Đẩy dữ liệu vào bảng master
INSERT INTO EDMT1080(APK, DivisionID, FeelingID, FeelingName, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT NEWID(), CASE WHEN IsCommon = 1 THEN '@@@' ELSE DivisionID END AS DivisionID, FeelingID, FeelingName, IsCommon, @UserID, GETDATE(), @UserID, GETDATE()
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
