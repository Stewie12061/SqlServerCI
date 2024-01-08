﻿IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1043]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1043]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Import Excel danh mục năm học
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Minh Hòa on 17/09/2018
---- Modified by on Minh Hòa
-- <Example>
/* 
 EXEC EDMP1043 @DivisionID, @UserID, @ImportTransTypeID, @XML
 */
 
CREATE PROCEDURE EDMP1043
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
DEALLOCATE @cCURSOR


SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('SchoolYearID').value('.', 'VARCHAR(50)') AS SchoolYearID,
		X.Data.query('DateFrom').value('.', 'VARCHAR(50)') AS DateFrom, 
		X.Data.query('DateTo').value('.', 'VARCHAR(50)') AS DateTo, 
		X.Data.query('IsCommon').value('.', 'TINYINT') AS IsCommon,	
		IDENTITY(int, 1, 1) AS Orders			
INTO #EDMT1040
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], Orders, DivisionID, SchoolYearID, DateFrom, DateTo, IsCommon)
SELECT [Row], Orders, DivisionID, SchoolYearID,CASE WHEN ISNULL(DateFrom, '') = '' THEN NULL ELSE CONVERT(datetime, DateFrom, 104) END AS FromDate,
CASE WHEN ISNULL(DateTo, '') = '' THEN NULL ELSE CONVERT(datetime,DateTo, 104) END AS ToDate, IsCommon
FROM #EDMT1040

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra trùng mã khối  
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData', @ColID = 'SchoolYearID', @Param1 = 'Orders', @Param2 = 'EDMT1040', 
@Param3 = 'SchoolYearID'

------ Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END

---- Đẩy dữ liệu vào danh mục nhóm lỗi
INSERT INTO EDMT1040 (APK, DivisionID, SchoolYearID, DateFrom, DateTo, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT NEWID(), CASE WHEN IsCommon = 1 THEN '@@@' ELSE DivisionID END AS DivisionID, SchoolYearID, DateFrom, DateTo, IsCommon, @UserID AS CreateUserID, 
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
