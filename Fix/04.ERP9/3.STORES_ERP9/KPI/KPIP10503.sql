IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP10503]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP10503]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Import Excel danh mục Chỉ tiêu KPI
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Vĩnh Tâm on 17/01/2020
---- Modified by on
-- <Example>

CREATE PROCEDURE KPIP10503
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
		X.Data.query('TargetsID').value('.','VARCHAR(50)') AS TargetsID,
		X.Data.query('TargetsName').value('.','NVARCHAR(250)') AS TargetsName,
		X.Data.query('UnitKpiID').value('.','VARCHAR(50)') AS UnitKpiID,
		X.Data.query('FrequencyID').value('.','VARCHAR(50)') AS FrequencyID,
		X.Data.query('SourceID').value('.','VARCHAR(50)') AS SourceID,
		X.Data.query('Categorize').value('.','INT') AS Categorize,
		X.Data.query('FormulaName').value('.','NVARCHAR(MAX)') AS FormulaName,
		X.Data.query('OrderTarget').value('.','INT') AS [OrderTarget],
		X.Data.query('IsCommon').value('.','TINYINT') AS IsCommon,
		X.Data.query('DivisionIDDetail').value('.','VARCHAR(50)') AS DivisionIDDetail,
		X.Data.query('DepartmentID').value('.','VARCHAR(50)') AS DepartmentID,
		X.Data.query('TargetsGroupID').value('.','VARCHAR(50)') AS TargetsGroupID,
		X.Data.query('Percentage').value('.','DECIMAL(28,8)') AS Percentage,
		X.Data.query('Revenue').value('.','DECIMAL(28,8)') AS Revenue,
		X.Data.query('GoalLimit').value('.','DECIMAL(28,8)') AS GoalLimit,
		IDENTITY(INT, 1, 1) AS Orders
INTO #KPIT1050
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], Orders, DivisionID, TargetsID, TargetsName, UnitKpiID, FrequencyID, SourceID, Categorize, FormulaName, [OrderTarget], IsCommon, DivisionIDDetail, DepartmentID, TargetsGroupID, Percentage, Revenue, GoalLimit)
SELECT [Row], Orders, DivisionID, TargetsID, TargetsName, UnitKpiID, FrequencyID, SourceID, Categorize, FormulaName, [OrderTarget], IsCommon, DivisionIDDetail, DepartmentID, TargetsGroupID, Percentage, Revenue, GoalLimit
FROM #KPIT1050

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-KPI', @ColID = 'TargetsID',
@Param1 = 'TargetsID, TargetsName, UnitKpiID, FrequencyID, SourceID, Categorize, FormulaName, OrderTarget, IsCommon'

---- Kiểm tra dữ liệu không đồng nhất tại phần detail
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-KPI', @ColID = 'TargetsID, DivisionIDDetail, DepartmentID, TargetsGroupID',
@Param1 = 'TargetsID, TargetsName, UnitKpiID, FrequencyID, SourceID, Categorize, FormulaName, OrderTarget, IsCommon, DivisionIDDetail, DepartmentID, TargetsGroupID, Percentage, Revenue, GoalLimit'

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
		@ColName1 NVARCHAR(50),
		@ColumnName2 VARCHAR(50),
		@ColName2 NVARCHAR(50),
		@ColumnName3 VARCHAR(50),
		@ColName3 NVARCHAR(50),
		@ColumnName4 VARCHAR(50),
		@ColName4 NVARCHAR(50),
		@Cur CURSOR,
		@TargetsID VARCHAR(50),
		@DivisionIDDetail VARCHAR(50),
		@DepartmentID VARCHAR(50),
		@TargetsGroupID VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'TargetsID'

SELECT TOP 1 @ColumnName2 = DataCol, @ColName2 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DivisionIDDetail'

SELECT TOP 1 @ColumnName3 = DataCol, @ColName3 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DepartmentID'

SELECT TOP 1 @ColumnName4 = DataCol, @ColName4 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'TargetsGroupID'


SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT TargetsID, DivisionIDDetail, DepartmentID, TargetsGroupID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @TargetsID, @DivisionIDDetail, @DepartmentID, @TargetsGroupID

WHILE @@FETCH_STATUS = 0
BEGIN

	---- Kiểm tra trùng mã Chỉ tiêu KPI trong danh mục
	IF EXISTS (SELECT TOP  1 1 FROM KPIT10501 WITH (NOLOCK) WHERE TargetsID = @TargetsID)
	BEGIN
		UPDATE #Data 
		SET	ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-SFML000077,',
				ErrorColumn = @ColName1 + ','
	END

	---- Kiểm tra trùng mã Chi tiết chỉ tiêu KPI
	IF EXISTS(SELECT TOP 1 1 FROM #Data
				WHERE TargetsID = @TargetsID AND DivisionIDDetail = @DivisionIDDetail
					AND DepartmentID = @DepartmentID AND TargetsGroupID = @TargetsGroupID
				HAVING COUNT(*) >= 2)
	BEGIN
		UPDATE #Data 
		SET	ErrorMessage = @ColumnName2 + LTRIM(RTRIM(STR([Row]))) +'-ASML000084,',
				ErrorColumn = @ColName2 + ','
	END 

	FETCH NEXT FROM @Cur INTO @TargetsID, @DivisionIDDetail, @DepartmentID, @TargetsGroupID
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


-- Insert dữ liệu vào bảng master
INSERT INTO KPIT10501(TargetsID, TargetsName, FrequencyID, SourceID, Categorize, FormulaName, UnitKpiID, OrderNo
					, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT TargetsID, TargetsName, FrequencyID, SourceID, Categorize, FormulaName, UnitKpiID, OrderTarget
				, IsCommon, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data

-- Insert dữ liệu vào bảng detail 
INSERT INTO KPIT10502(APK, APKMaster, DivisionID, DepartmentID, TargetsGroupID, Percentage, Revenue, GoalLimit
					, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT NEWID() AS APK, T2.APK AS APKMaster, T1.DivisionIDDetail, T1.DepartmentID, T1.TargetsGroupID, T1.Percentage, T1.Revenue, T1.GoalLimit
					, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data T1
	INNER JOIN KPIT10501 T2 WITH (NOLOCK) ON T2.TargetsID = T1.TargetsID


LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
