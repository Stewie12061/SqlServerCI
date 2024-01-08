IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2093]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2093]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
----
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 12/11/2019 by Khánh Đoan : Import nghiệp vụ lịch năm học


CREATE PROCEDURE [DBO].[EDMP2093]
( 
	@DivisionID AS VARCHAR(50),
	@UserID AS VARCHAR(50),
	@ImportTransTypeID AS VARCHAR(50),
	@XML AS XML
) 
AS

DECLARE @cCURSOR AS CURSOR,
		@sSQL AS NVARCHAR(MAX),
		@ColID AS VARCHAR(50), 
		@ColSQLDataType AS VARCHAR(50)

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
		X.Data.query('YearlyScheduleID').value('.', 'VARCHAR(50)') AS YearlyScheduleID,
		X.Data.query('DateSchedule').value('.', 'VARCHAR(50)') AS DateSchedule,
		X.Data.query('TermID').value('.', 'VARCHAR(50)') AS TermID,
		X.Data.query('Description').value('.', 'NVARCHAR(MAX)') AS [Description],
		X.Data.query('FromDate').value('.', 'VARCHAR(50)') AS FromDate,
		X.Data.query('ToDate').value('.', 'VARCHAR(50)') AS ToDate,
		X.Data.query('ActivityTypeID').value('.', 'VARCHAR(50)') AS ActivityTypeID,
		X.Data.query('ActivityID').value('.', 'VARCHAR(50)') AS ActivityID,
		X.Data.query('Contents').value('.', 'NVARCHAR(MAX)') AS Contents,
		IDENTITY(int, 1, 1) AS Orders
INTO #EDMP2093
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]


INSERT INTO #Data ([Row],Orders,DivisionID,YearlyScheduleID,DateSchedule,TermID,[Description],
FromDate,ToDate,ActivityTypeID,ActivityID,Contents)

SELECT [Row],Orders,DivisionID,YearlyScheduleID,CASE WHEN ISNULL(DateSchedule, '') = '' THEN NULL ELSE CONVERT(datetime, DateSchedule, 103) END AS DateSchedule
,TermID,[Description],
CASE WHEN ISNULL(FromDate, '') = '' THEN NULL ELSE CONVERT(datetime, FromDate, 103) END AS FromDate,
CASE WHEN ISNULL(ToDate, '') = '' THEN NULL ELSE CONVERT(datetime, ToDate, 103) END AS ToDate,
ActivityTypeID,ActivityID,Contents
FROM #EDMP2093

---- Kiểm tra check code mặc định 
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, 
@CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-EDM', @ColID = 'TermID', 
@Param1 = 'YearlyScheduleID,DateSchedule,TermID,Description'

---- Kiểm tra dữ liệu không đồng nhất tại phần detail 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-EDM', 
@ColID = 'TermID, ActivityTypeID', 
@Param1 = 'YearlyScheduleID,DateSchedule,TermID,Description,FromDate,ToDate,ActivityTypeID,ActivityID,Contents'
 
 ---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''


		GOTO LB_RESULT
END


DECLARE @Cur AS CURSOR,
		@ColumnName VARCHAR(50), 
		@ColName NVARCHAR(50),
		@YearlyScheduleID VARCHAR(50),
		@TermID VARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@DivisionIDCur VARCHAR(50),
		@ColumnName1 VARCHAR(50), 
		@ColName1 NVARCHAR(50),
		@ActivityID VARCHAR(50),
		@ColumnName2 VARCHAR(50),
		@ActivityTypeID VARCHAR(50),
		@ColumnName3 NVARCHAR(50),
		@ColName2 NVARCHAR(50),
		@ColName3 NVARCHAR(50),
		@ColName4 NVARCHAR(50),
		@ColumnName4 VARCHAR(50)


SELECT TOP 1 @ColumnName = DataCol, @ColName = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ActivityID'


SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'TermID'

SELECT TOP 1 @ColumnName2 = DataCol, @ColName2 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DivisionID'


SELECT TOP 1 @ColumnName3 = DataCol, @ColName3 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'YearlyScheduleID'



SELECT TOP 1 @ColumnName4 = DataCol, @ColName4 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ToDate'



SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT DivisionID,TermID ,FromDate, ToDate, ActivityID, ActivityTypeID, YearlyScheduleID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @DivisionIDCur, @TermID ,@FromDate, @ToDate,@ActivityID,@ActivityTypeID, @YearlyScheduleID

WHILE @@FETCH_STATUS = 0
BEGIN
		
		---- Kiểm tra Đến ngày > từ ngày
		IF EXISTS (SELECT TOP 1 1 FROM #Data  WITH (NOLOCK) WHERE DivisionID = @DivisionID AND CONVERT(datetime,ToDate, 103) < CONVERT(datetime,FromDate, 103))
		BEGIN
		UPDATE	#Data
		SET	ErrorMessage = @ColumnName4 + LTRIM(RTRIM(STR([Row]))) +'-AFML000100,',
			ErrorColumn = @ColName4+','
		END

			
	
		
		
		 ------Kiểm tra đơn vị  hiện tại
		IF EXISTS (SELECT TOP  1 1 FROM #Data WITH (NOLOCK) WHERE DivisionID <> @DivisionID )
		BEGIN
	
		UPDATE	#Data
		SET	ErrorMessage = @ColumnName2  +'-00ML000114,',
			ErrorColumn = @ColName2+','
		END


	---- Kiểm tra trong một năm học chỉ có một lịch học  ở 1 đơn vị
	IF EXISTS (SELECT TOP  1 1 FROM #data  WITH (NOLOCK) WHERE DivisionID = @DivisionIDCur AND YearlyScheduleID = @YearlyScheduleID
	AND TermID <> @TermID )
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName3 + LTRIM(RTRIM(STR([Row]))) +'-EDMFML000077,',
				ErrorColumn = @ColName3+','
	END 
	
	---- Kiểm tra trong một năm học chỉ có một lịch học  ở 1 đơn vị
	IF EXISTS (SELECT TOP  1 1 FROM #data  WITH (NOLOCK) WHERE DivisionID = @DivisionIDCur AND YearlyScheduleID <> @YearlyScheduleID
	AND TermID = @TermID )
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName3 + LTRIM(RTRIM(STR([Row]))) +'-EDMFML000077,',
				ErrorColumn = @ColName3+','
	END 

	---- Kiểm tra trong một năm học chỉ có một lịch học
	IF EXISTS (SELECT TOP  1 1 FROM EDMT2090 WITH (NOLOCK) WHERE DivisionID = @DivisionIDCur  AND TermID = @TermID AND DeleteFlg = 0)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-EDMFML000064,',
				ErrorColumn = @ColName1+','
	END 


	---- Kiểm tra trong một ngày chỉ có một hoạt động
	IF EXISTS (SELECT TOP  1 1 FROM #Data WITH (NOLOCK) 
	WHERE DivisionID = @DivisionIDCur
	  AND FromDate = @FromDate 
	  AND ToDate = @ToDate 
	  AND ActivityID = @ActivityID
	  HAVING COUNT(ActivityID) >=2 )
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-EDMFML000063,',
				ErrorColumn = @ColName+','
	END 


	---Kiểm tra hoạt động  thuộc Loại hoạt động trong danh mục
		IF NOT EXISTS (SELECT TOP 1 1  FROM EDMT1061 WITH (NOLOCK) 
		INNER JOIN EDMT1060 WITH (NOLOCK) ON EDMT1060.APK =EDMT1061.APKMaster
		WHERE EDMT1060.ActivityTypeID = @ActivityTypeID AND ActivityID = @ActivityID)  
		BEGIN
		SELECT * FROM #Data
		UPDATE	#Data
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-EDMFML000074,',
			ErrorColumn = @ColName+','
		END
	


	FETCH NEXT FROM @Cur INTO @DivisionIDCur, @TermID ,@FromDate, @ToDate,@ActivityID, @ActivityTypeID,  @YearlyScheduleID
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
INSERT INTO EDMT2090 ( DivisionID,YearlyScheduleID,DateSchedule,TermID,Description,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
SELECT DISTINCT    DivisionID,YearlyScheduleID,DateSchedule,TermID,Description , @UserID, GETDATE(),@UserID ,GETDATE()
FROM #Data

-- Đẩy dữ liệu vào bảng detail 
INSERT INTO EDMT2091(DivisionID,APKMaster,FromDate,ToDate,ActivityTypeID,ActivityID,Contents,CreateUserID,CreateDate,LastModifyUserID, LastModifyDate)
SELECT DISTINCT T1.DivisionID,T2.APK as APKMaster,T1.FromDate,T1.ToDate,T1.ActivityTypeID,T1.ActivityID,T1.Contents,@UserID,GETDATE(), @UserID , GETDATE()
FROM #Data T1 
INNER JOIN EDMT2090 T2 WITH (NOLOCK) ON T2.YearlyScheduleID = T1.YearlyScheduleID


LB_RESULT:

SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

