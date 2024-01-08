IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1062]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1062]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Import Excel danh mục loại hoạt động 
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
 
CREATE PROCEDURE EDMP1062
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
	X.Data.query('ActivityTypeID').value('.', 'VARCHAR(50)') AS ActivityTypeID,
	X.Data.query('ActivityTypeName').value('.', 'NVARCHAR(250)') AS ActivityTypeName, 
	(CASE WHEN X.Data.query('IsCommon').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsCommon').value('.', 'TINYINT') END) AS IsCommon,	 
	X.Data.query('ActivityID').value('.', 'VARCHAR(50)') AS ActivityID,
	X.Data.query('ActivityName').value('.', 'NVARCHAR(250)') AS ActivityName,
	IDENTITY(int, 1, 1) AS OrderID
INTO #EDMT1060
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], OrderID, DivisionID, ActivityTypeID, ActivityTypeName, IsCommon, ActivityID, ActivityName)
SELECT [Row], OrderID, DivisionID, ActivityTypeID, ActivityTypeName, IsCommon, ActivityID, ActivityName
FROM #EDMT1060
---- Kiểm tra check code mặc định 
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID



---- Kiểm tra dữ liệu không đồng nhất tại phần master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues', @ColID = 'ActivityTypeID', 
@Param1 = 'ActivityTypeID,ActivityTypeName, IsCommon'

---- Kiểm tra dữ liệu không đồng nhất tại phần detail 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues', @ColID = 'ActivityTypeID, ActivityID', 
@Param1 = 'ActivityTypeID,ActivityTypeName, IsCommon,ActivityID'



--- Kiểm tra dữ liệu detail 
DECLARE @ColumnName VARCHAR(50), 
		@ColName NVARCHAR(50), 
		@ColumnName1 VARCHAR(50), 
		@ColName1 NVARCHAR(50), 
		@Cur CURSOR, 
		@ActivityTypeID VARCHAR(50), 
		@ActivityID VARCHAR(50)

SELECT TOP 1 @ColumnName = DataCol, @ColName = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ActivityID'


SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT ActivityTypeID, ActivityID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @ActivityTypeID, @ActivityID

WHILE @@FETCH_STATUS = 0
BEGIN
	 ---- Kiểm tra trùng mã mã loại hoạt động và hoạt động trong danh mục
	IF EXISTS (SELECT TOP  1 1 FROM EDMT1060 WITH (NOLOCK) INNER JOIN EDMT1061 ON EDMT1060.APK = EDMT1061.APKMaster WHERE ActivityTypeID = @ActivityTypeID AND ActivityID = @ActivityID )
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-SFML000077,',
				ErrorColumn = @ColName+','
	END 
	
	
	
	---- Kiểm tra trùng mã hoạt động trong import 
	IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE ActivityTypeID = @ActivityTypeID AND ActivityID = @ActivityID HAVING COUNT(ActivityID) >=2)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-ASML000084,',
				ErrorColumn = @ColName+','
	END 



	FETCH NEXT FROM @Cur INTO @ActivityTypeID, @ActivityID
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
INSERT INTO EDMT1060 (DivisionID, ActivityTypeID, ActivityTypeName, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT CASE WHEN IsCommon = 1 THEN '@@@' ELSE DivisionID END AS DivisionID, ActivityTypeID, ActivityTypeName, IsCommon, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data
GROUP BY DivisionID, ActivityTypeID, ActivityTypeName, IsCommon

-- Đẩy dữ liệu vào bảng detail 
INSERT INTO EDMT1061 (APK, DivisionID, APKMaster, ActivityID, ActivityName)
SELECT NEWID() AS APK, CASE WHEN T1.IsCommon = 1 THEN '@@@' ELSE T1.DivisionID END AS DivisionID, T2.APK AS APKMaster, T1.ActivityID, T1.ActivityName
FROM #Data T1 
INNER JOIN EDMT1060 T2 ON T1.DivisionID = T2.DivisionID AND T1. ActivityTypeID = T2. ActivityTypeID
	

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
