IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1032]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1032]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Import Excel danh mục đinh mưc dinh dưỡng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Trà Giang on 30/08/2018
---- Modified by on
-- <Example>
 
CREATE PROCEDURE NMP1032
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
		@ColSQLDataType VARCHAR(50),
		@ImportTemplateID VARCHAR(50)
		
CREATE TABLE #Data
(
	RowsID INT,
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
SELECT  X.Data.query('OrderNo').value('.', 'INT') AS RowsID,
	X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
	X.Data.query('QuotaNutritionID').value('.', 'VARCHAR(50)') AS QuotaNutritionID,
	X.Data.query('QuotaNutritionName').value('.', 'NVARCHAR(250)') AS QuotaNutritionName, 
	X.Data.query('MenuTypeID').value('.', 'VARCHAR(50)') AS MenuTypeID, 
	X.Data.query('IsCommon').value('.', 'TINYINT') AS IsCommon, 
	X.Data.query('Description').value('.', 'VARCHAR(250)') AS Description,
	X.Data.query('SystemID').value('.', 'NVARCHAR(50)') AS SystemID,
	X.Data.query('QuotaStandard').value('.', 'NVARCHAR(50)') AS QuotaStandard, 
	X.Data.query('MinRatio').value('.', 'NVARCHAR(50)') AS MinRatio,
	X.Data.query('MaxRatio').value('.', 'NVARCHAR(50)') AS MaxRatio
	
INTO #NMP1032
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY RowsID

INSERT INTO #Data (RowsID, 
				 DivisionID, 
				 QuotaNutritionID,
				 QuotaNutritionName,
				 MenuTypeID, 
				 Description, 
				 IsCommon, 
				 SystemID, 
				 QuotaStandard,
				 MinRatio,
				 MaxRatio)
SELECT RowsID, 
		 DivisionID,
		QuotaNutritionID,
		QuotaNutritionName,
		MenuTypeID, 
		[Description], 
		IsCommon, 
		SystemID,
		CASE WHEN ISNULL(QuotaStandard,'') = '' THEN 0 ELSE CAST(QuotaStandard AS DECIMAL(28,8)) END QuotaStandard,
		CASE WHEN ISNULL(MinRatio,'') = '' THEN 0 ELSE CAST(MinRatio AS DECIMAL(28,8)) END MinRatio,
		CASE WHEN ISNULL(MaxRatio,'') = '' THEN 0 ELSE CAST(MaxRatio AS DECIMAL(28,8)) END MaxRatio
FROM #NMP1032
---- Kiểm tra check code mặc định 
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID


-- Kiểm tra trùng ID trên master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData', @ColID = 'QuotaNutritionID', @Param1 = '', @Param2 = 'NMT1030', 
@Param3 = 'QuotaNutritionID'



--- Kiểm tra dữ liệu detail 
DECLARE @ColumnName VARCHAR(50), 
		@ColName NVARCHAR(50), 
		@ColumnName1 VARCHAR(50), 
		@ColName1 NVARCHAR(50), 
		@Cur CURSOR, 
		@QuotaNutritionID VARCHAR(50),
		@Description VARCHAR(50)

SELECT TOP 1 @ColumnName = DataCol, @ColName = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'Description'


SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT QuotaNutritionID, Description FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @QuotaNutritionID, @Description

WHILE @@FETCH_STATUS = 0
BEGIN
	

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END

------ Sinh APK cho master 
SELECT DISTINCT NEWID() AS APK, DivisionID, QuotaNutritionID, QuotaNutritionName,MenuTypeID, IsCommon, Disable
INTO #APK_Data
FROM #Data

 --Đẩy dữ liệu vào bảng master
INSERT INTO NMT1030 (APK, DivisionID, QuotaNutritionID, QuotaNutritionName,MenuTypeID, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT APK, CASE WHEN IsCommon = 1 THEN '@@@' ELSE DivisionID END AS DivisionID, QuotaNutritionID, QuotaNutritionName,MenuTypeID, IsCommon, @UserID, GETDATE(), @UserID, GETDATE()
FROM #APK_Data
GROUP BY APK, DivisionID, QuotaNutritionID, QuotaNutritionName,MenuTypeID, IsCommon

-- Đẩy dữ liệu vào bảng detail 
INSERT INTO NMT1031 (APK, DivisionID, APKMaster,  SystemID,QuotaStandard,  MinRatio,  MaxRatio, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT NEWID() AS APK, CASE WHEN T1.IsCommon = 1 THEN '@@@' ELSE T1.DivisionID END AS DivisionID, T2.APK AS APKMaster, T1.SystemID,QuotaStandard,  MinRatio,  MaxRatio, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data T1 
INNER JOIN #APK_Data T2 ON T1.DivisionID = T2.DivisionID AND T1. QuotaNutritionID = T2. QuotaNutritionID AND T1.SystemID = T2.SystemID AND T1.MenuTypeID = T2.MenuTypeID
	AND T1.IsCommon = T2.IsCommon

END
LB_RESULT:

SELECT RowsID, 
ErrorColumn, ErrorMessage 
FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY RowsID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

