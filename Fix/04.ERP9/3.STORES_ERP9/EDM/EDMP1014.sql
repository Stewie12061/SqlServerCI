IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1014]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1014]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Import Excel danh mục định mức
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Văn Tình on 08/09/2018
---- Modified by on 
-- <Example>
/* 
 EXEC EDMP1014 'dv', 'UserID', 'vi-VN', 'QuotaList', ''
 */
 
CREATE PROCEDURE EDMP1014
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
	[APKMaster] UNIQUEIDENTIFIER NULL,
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
	--PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END 
CLOSE @cCURSOR

--select * from #Data return

SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('QuotaID').value('.', 'VARCHAR(50)') AS QuotaID,
		X.Data.query('Description').value('.', 'NVARCHAR(250)') AS [Description], 
		X.Data.query('IsCommon').value('.', 'TINYINT') AS IsCommon,	
		X.Data.query('LevelID').value('.', 'VARCHAR(50)') AS LevelID,
		X.Data.query('Quantity').value('.', 'INT') AS Quantity,
		IDENTITY(int, 1, 1) AS Orders			
INTO #EDMT1010
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data (APKMaster, [Row], Orders, DivisionID, QuotaID, [Description], IsCommon, LevelID, Quantity)
SELECT NEWID() AS APKMaster, [Row], Orders, DivisionID, QuotaID, [Description], IsCommon, LevelID, Quantity
FROM #EDMT1010

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra trùng mã định mức
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData', @ColID = 'QuotaID', @Param1 = 'Orders', @Param2 = 'EDMT1010', 
@Param3 = 'QuotaID'

------ Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END

UPDATE #Data SET DivisionID = '@@@' WHERE IsCommon = 1

-- Đẩy dữ liệu vào danh mục 
INSERT INTO EDMT1010(
	[APK], [DivisionID], [QuotaID], [Description], [IsCommon], [Disabled]
	, [CreateUserID], [CreateDate], [LastModifyUserID], [LastModifyDate]
	)
SELECT APKMaster, DivisionID, QuotaID, MAX(Description) AS Description, IsCommon, 0 AS Disabled
		, @UserID AS [CreateUserID], GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate
	FROM #Data 
	GROUP BY APKMaster, DivisionID, QuotaID, IsCommon

INSERT INTO EDMT1011([APK], DivisionID, LevelID, Quantity, APKMaster)
SELECT NEWID() AS APK, DivisionID, LevelID, Quantity, APKMaster
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
