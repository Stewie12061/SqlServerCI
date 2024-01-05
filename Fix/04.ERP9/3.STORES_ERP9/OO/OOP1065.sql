IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1065]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1065]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Import Excel nghiệp vụ Mẫu công việc module OO
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Trọng Kiên on 25/08/2020
---- Modified by on
-- <Example>

CREATE PROCEDURE OOP1065
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
		X.Data.query('TaskSampleID').value('.','VARCHAR(50)') AS TaskSampleID,
		X.Data.query('TaskSampleName').value('.','NVARCHAR(250)') AS TaskSampleName,
		X.Data.query('TaskTypeID').value('.','VARCHAR(50)') AS TaskTypeID,
		X.Data.query('TargetTypeID').value('.','VARCHAR(50)') AS TargetTypeID,
		X.Data.query('PriorityID').value('.','VARCHAR(50)') AS PriorityID,
		X.Data.query('ExecutionTime').value('.','DECIMAL(5,2)') AS ExecutionTime,
		X.Data.query('Description').value('.','NVARCHAR(MAX)') AS Description,
		X.Data.query('IsCommon').value('.','INT') AS IsCommon
INTO #OOP1065
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], DivisionID, TaskSampleID, TaskSampleName, TaskTypeID, TargetTypeID, PriorityID, ExecutionTime, Description, IsCommon)
SELECT [Row], DivisionID, TaskSampleID, TaskSampleName, TaskTypeID, TargetTypeID, PriorityID, ExecutionTime, Description, IsCommon
FROM #OOP1065

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
		@ColName1 NVARCHAR(50),
		@Cur CURSOR,
		@TaskSampleID VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'TaskSampleID'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT TaskSampleID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @TaskSampleID

WHILE @@FETCH_STATUS = 0
BEGIN

	---- Kiểm tra trùng mã Mẫu công việc
	IF EXISTS (SELECT TOP  1 1 FROM OOT1060 WITH (NOLOCK) WHERE TaskSampleID = @TaskSampleID)
	BEGIN
		UPDATE #Data 
		SET	ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-SFML000077,',
				ErrorColumn = @ColName1 + ','
	END

	FETCH NEXT FROM @Cur INTO @TaskSampleID
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

-- Insert dữ liệu vào bảng Mẫu công việc (OOT1060)
INSERT INTO OOT1060( DivisionID, TaskSampleID, TaskSampleName, TaskTypeID, TargetTypeID, PriorityID, ExecutionTime, Description, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT  DivisionID, TaskSampleID, TaskSampleName, TaskTypeID, TargetTypeID, PriorityID, ExecutionTime, Description, IsCommon, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data

UPDATE AT4444 
SET LastKey = (SELECT SUBSTRING(MAX(TaskSampleID), 4, 8) FROM OOT1060)
WHERE TableName = 'OOT1060' AND KEYSTRING = 'MCV' 	

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
