IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP1005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP1005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Import Excel danh mục tiêu chuẩn module QC
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Thanh Thi on 01/12/2020
---- Modified by on
-- <Example>

CREATE PROCEDURE QCP1005
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
	DivisionID VARCHAR(50),
	StandardID VARCHAR(50),
	StandardName NVARCHAR(250),
	StandardNameE NVARCHAR(250),
	UnitID VARCHAR(50),
	Description NVARCHAR(max),
	TypeID VARCHAR(50),
	ParentID VARCHAR(50),
	DataType INT,
	Disabled INT,
	IsCommon INT,
	IsDefault INT,
	IsVisible INT,
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

--OPEN @cCURSOR

---- Tạo cấu trúc bảng tạm
--FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
--WHILE @@FETCH_STATUS = 0
--BEGIN
--	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
--	PRINT @sSQL
--	EXEC (@sSQL)
--	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
--END
--CLOSE @cCURSOR


SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('StandardID').value('.','VARCHAR(50)') AS StandardID,
		X.Data.query('StandardName').value('.','NVARCHAR(250)') AS StandardName,
		X.Data.query('StandardNameE').value('.','NVARCHAR(250)') AS StandardNameE,
		X.Data.query('UnitID').value('.','VARCHAR(50)') AS UnitID,
		X.Data.query('Description').value('.','NVARCHAR(max)') AS Description,
		X.Data.query('TypeID').value('.','VARCHAR(50)') AS TypeID,
		(CASE WHEN X.Data.query('ParentID').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('ParentID').value('.', 'VARCHAR(MAX)') END) AS ParentID,
		X.Data.query('DataType').value('.','INT') AS DataType,
		X.Data.query('Disabled').value('.','INT') AS Disabled,
		X.Data.query('IsCommon').value('.','INT') AS IsCommon,
		X.Data.query('IsDefault').value('.','INT') AS IsDefault,
		X.Data.query('IsVisible').value('.','INT') AS IsVisible
INTO #QCP1005
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], DivisionID, StandardID, StandardName, StandardNameE, UnitID, Description, TypeID, ParentID, DataType, Disabled, IsCommon, IsDefault, IsVisible)
SELECT [Row], DivisionID, StandardID, StandardName, StandardNameE, UnitID, Description, TypeID, REPLACE(LTRIM(RTRIM(ParentID)),' ',''), DataType, Disabled, IsCommon, IsDefault, IsVisible
FROM #QCP1005

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
		@ColName1 NVARCHAR(50),
		@ColumnName2 VARCHAR(50),
		@ColName2 NVARCHAR(50),
		@Cur CURSOR,
		@StandardID VARCHAR(50),
		@ParentID VARCHAR(MAX)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'StandardID'

SELECT TOP 1 @ColumnName2 = DataCol, @ColName2 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ParentID'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT StandardID, ParentID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @StandardID, @ParentID

WHILE @@FETCH_STATUS = 0
BEGIN

	---- Kiểm tra trùng mã mã tiêu chuẩn
	IF EXISTS (SELECT TOP  1 1 FROM QCT1000 WITH (NOLOCK) WHERE TRIM(StandardID) = TRIM(@StandardID))
	BEGIN
		UPDATE #Data 
		SET	ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-SFML000077,',
			ErrorColumn = @ColName1 + ','
	END

	

	---- Kiểm tra tồn tại mã cha
	IF EXISTS (SELECT TOP 1 1
				FROM Split(REPLACE(@ParentID,' ',''), ',') AS A
				LEFT JOIN QCT1000 Q10 WITH(NOLOCK) ON Q10.StandardID = A.Data
				WHERE ISNULL(A.Data, '') <> '' AND Q10.StandardID IS NULL)
	BEGIN
		DECLARE @NAMES NVARCHAR(MAX) = ''
		SELECT @NAMES = COALESCE(@NAMES + ',', '') + A.Data
		FROM Split(REPLACE(@ParentID,' ',''), ',') AS A
		LEFT JOIN QCT1000 Q10 WITH(NOLOCK) ON Q10.StandardID = A.Data
		WHERE ISNULL(A.Data, '') <> '' AND Q10.StandardID IS NULL

		UPDATE #Data 
		SET	ErrorMessage = @ColumnName2 + LTRIM(RTRIM(STR([Row]))) + ':' + REPLACE(REPLACE(@NAMES,CHAR(10),''),CHAR(13),'') +'-00ML000152,',
			ErrorColumn = @ColName2 + ','
	END

	FETCH NEXT FROM @Cur INTO @StandardID, @ParentID
END

CLOSE @Cur

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''
		GOTO LB_RESULT
END

DECLARE @OutputStandardAPK TABLE (APK NVARCHAR(250),StandardID NVARCHAR(50),UnitID NVARCHAR(50))

-- Insert dữ liệu vào bảng tiêu chuẩn (QCT1000)
INSERT INTO QCT1000(APK, DivisionID, StandardID, StandardName, StandardNameE, UnitID, Description, TypeID, ParentID, Disabled, IsCommon, IsDefault, IsVisible, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
OUTPUT INSERTED.APK, INSERTED.StandardID, INSERTED.UnitID INTO @OutputStandardAPK(APK, StandardID, UnitID)
SELECT DISTINCT NEWID() as APK, DivisionID, StandardID, StandardName, StandardNameE, UnitID, Description, TypeID, ParentID, Disabled, IsCommon, IsDefault, IsVisible, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data 
WHERE ErrorMessage = ''

-- Lưu lich su
INSERT INTO QCT00003(APK,DivisionID,HistoryID,Description,RelatedToID,RelatedToTypeID,CreateDate,CreateUserID,StatusID,ScreenID,TableID)
SELECT NEWID() AS APK, @DivisionID AS DivisionID, NULL AS HistoryID, 
'''A00.AddNew'' ''A00.QCT1000''</br>' AS Description, 
APK AS RelatedToID, 47 AS RelatedToTypeID, GETDATE() AS CreateDate, @UserID AS CreateUserID, 
1 AS StatusID, 'QCF1001' AS ScreenID, 'QCT1000' AS TableID
FROM @OutputStandardAPK

-- Lưu nguoi theo doi
INSERT INTO QCT9020(DivisionID,APKMaster,RelatedToID,TableID,FollowerID01,FollowerName01,TypeFollow,CreateDate,CreateUserID,RelatedToTypeID)
SELECT @DivisionID, A.APK, NULL, 'QCT1000', @UserID, (SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = @UserID), 0, GETDATE(), @UserID, 0
FROM @OutputStandardAPK A

--UPDATE AT4444 
--SET LastKey = (SELECT SUBSTRING(MAX(StandardID), 4, 8) FROM QCT1000)
--WHERE TableName = 'QCT1000' AND KEYSTRING = 'MCV' 	

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
