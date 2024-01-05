IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2106]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2106]
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
---- Create on 27/11/2019 by Khánh Đoan : Import nghiệp vụ Thời khóa biểu năm học
--- Trong 1 năm học, 1 lớp chỉ có 1 thời khóa biểu. Bạn vui lòng nhập lại!

CREATE PROCEDURE [DBO].[EDMP2106]
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
		X.Data.query('DailyScheduleID').value('.', 'VARCHAR(50)') AS DailyScheduleID,
		X.Data.query('DateSchedule').value('.', 'VARCHAR(50)') AS DateSchedule,
		X.Data.query('TermID').value('.', 'VARCHAR(50)') AS TermID,
		X.Data.query('GradeID').value('.', 'VARCHAR(50)') AS GradeID,
		X.Data.query('ClassID').value('.', 'VARCHAR(50)') AS ClassID,  
		X.Data.query('Description').value('.', 'NVARCHAR(250)') AS [Description],
		X.Data.query('FromHour').value('.', 'VARCHAR(50)') AS FromHour,  
		X.Data.query('ToHour').value('.', 'VARCHAR(50)') AS ToHour, 
		X.Data.query('Monday').value('.', 'NVARCHAR(MAX)') AS Monday, 
		X.Data.query('Tuesday').value('.', 'NVARCHAR(MAX)') AS Tuesday, 
		X.Data.query('Wednesday').value('.', 'NVARCHAR(MAX)') AS Wednesday, 
		X.Data.query('Thursday').value('.', 'NVARCHAR(MAX)') AS Thursday, 
		X.Data.query('Friday').value('.', 'NVARCHAR(MAX)') AS Friday,
		X.Data.query('Saturday').value('.', 'NVARCHAR(MAX)') AS Saturday,
		X.Data.query('Sunday').value('.', 'NVARCHAR(MAX)') AS Sunday,
		IDENTITY(int, 1, 1) AS Orders	

INTO #EDMP2106
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]


INSERT INTO #Data ([Row],DivisionID,DailyScheduleID,DateSchedule,TermID,GradeID,[Description],ClassID,
FromHour,ToHour,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday)

SELECT [Row],DivisionID,DailyScheduleID,CASE WHEN ISNULL(DateSchedule, '') = '' THEN NULL ELSE CONVERT(datetime, DateSchedule, 104) END AS DateSchedule,
TermID,GradeID
,[Description],ClassID,
(LEFT(FromHour, CHARINDEX(':', FromHour) - 1)  * 60 * 60)  + CAST(ROUND(DATEDIFF(MILLISECOND, 0, '00' + (SUBSTRING(FromHour, CHARINDEX(':', FromHour), LEN(FromHour)))) / 1000.0, 0) AS INT),
(LEFT(ToHour, CHARINDEX(':', ToHour) - 1)  * 60 * 60)  + CAST(ROUND(DATEDIFF(MILLISECOND, 0, '00' + (SUBSTRING(ToHour, CHARINDEX(':', ToHour), LEN(ToHour)))) / 1000.0, 0) AS INT)
,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday
FROM  #EDMP2106



---- Kiểm tra dữ liệu không đồng nhất tại phần master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, 
@CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-EDM', @ColID ='ClassID',
 @Param1 = 'DailyScheduleID,DateSchedule,TermID,GradeID,ClassID,Description'


---- Kiểm tra check code mặc định 
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID



---Mỗi năm học ở mỗi lớp chỉ có 1 Thời khóa biểu năm học

---- Kiểm tra dữ liệu detail 
DECLARE @ColumnName VARCHAR(50), 
		@ColName NVARCHAR(50), 
		@ColumnName1 VARCHAR(50), 
		@ColName1 NVARCHAR(50), 
		@Cur CURSOR, 
		@DivisionIDCur VARCHAR(50),
		@TermID VARCHAR(50), 
		@GradeID VARCHAR(50),
		@ClassID VARCHAR(50),
		@DailyScheduleID VARCHAR(50),
		@ColumnName2 VARCHAR(50),
		@ColumnName3 VARCHAR(50),
		@ToHour INT,
		@FromHour INT,
		@ColumnName4 VARCHAR(50),
		@ColName2 NVARCHAR(50), 
		@ColName3 NVARCHAR(50), 
		@ColName4 NVARCHAR(50)


SELECT TOP 1 @ColumnName1 = DataCol, @ColName = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DailyScheduleID'

SELECT TOP 1 @ColumnName2 = DataCol, @ColName2 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DivisionID' 

SELECT TOP 1 @ColumnName3 = DataCol, @ColName3 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ClassID'


SELECT TOP 1 @ColumnName4 = DataCol, @ColName4 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ToHour'


SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT DISTINCT DivisionID,DailyScheduleID,TermID, GradeID,ClassID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @DivisionIDCur,@DailyScheduleID,@TermID, @GradeID,@ClassID

WHILE @@FETCH_STATUS = 0
BEGIN


---- Kiểm tra Đến giờ > từ giờ

		IF EXISTS (SELECT TOP 1 1 FROM #Data  WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ToHour < FromHour)
		BEGIN
		
		UPDATE	#Data
		SET	ErrorMessage = @ColumnName4 + LTRIM(RTRIM(STR([Row]))) +'-00ML000192,',
			ErrorColumn = @ColName4+','
		END

	
-----Kiểm tra 1 lớp phải nằm trong danh mục khối

		IF NOT EXISTS (SELECT ClassID FROM EDMT1020  WITH (NOLOCK) WHERE DivisionID = @DivisionIDCur AND EDMT1020.GradeID = @GradeID AND EDMT1020.ClassID = @ClassID )
		BEGIN
		UPDATE	#Data
		SET	ErrorMessage = @ColumnName3 + LTRIM(RTRIM(STR([Row]))) +'-EDMFML000075	,',
			ErrorColumn = @ColName3+','
		END

	

------Kiểm tra đơn vị  hiện tại
		IF EXISTS (SELECT TOP  1 1 FROM #Data WITH (NOLOCK) WHERE DivisionID <> @DivisionID  )
		BEGIN
	
		UPDATE	#Data
		SET	ErrorMessage = @ColumnName2  +'-00ML000114,',
			ErrorColumn = @ColName2+','
		END

	---- Kiểm tra  mã lịch học 
		IF EXISTS (SELECT TOP  1 1 FROM #Data WITH (NOLOCK) WHERE  DivisionID = @DivisionIDCur AND DailyScheduleID <> @DailyScheduleID  
		AND TermID = @TermID AND GradeID = @GradeID AND ClassID = @ClassID)
		BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-EDMFML000076,',
				ErrorColumn = @ColName1+','
		END 
	
---- Kiểm tra trùng mã  thời  khóa biểu của năm học  trong 1 khối của  1 lớp  chỉ có 1 lịch học 
		IF EXISTS (SELECT TOP 1 1 FROM EDMT2100 WITH (NOLOCK) WHERE DivisionID = @DivisionIDCur  
		AND TermID = @TermID AND GradeID = @GradeID AND ClassID = @ClassID AND DeleteFlg = 0 )
		BEGIN
			UPDATE	#Data 
			SET	ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-EDMFML000065,',
					ErrorColumn = @ColName1+','
		END 




 /*
	---- Kiểm tra trùng mã năm học trong 1 lớp trong file excel 
	IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE DivisionID = @DivisionIDCur AND TermID = @TermID AND GradeID = @GradeID AND ClassID = @ClassID HAVING COUNT(TermID) >=2)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-ASML000084,',
				ErrorColumn = @ColName+','
	END 
 
 */
FETCH NEXT FROM @Cur INTO @DivisionIDCur,@DailyScheduleID,@TermID, @GradeID, @ClassID
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
INSERT INTO EDMT2100 ( DivisionID,DailyScheduleID, DateSchedule,TermID,GradeID, [Description],ClassID,
CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)

SELECT DISTINCT  DivisionID,DailyScheduleID,DateSchedule,TermID,GradeID,[Description],ClassID,@UserID, GETDATE(),@UserID ,GETDATE()
FROM #Data


-- Đẩy dữ liệu vào bảng detail 
INSERT INTO EDMT2101(DivisionID,APKMaster,FromHour,ToHour,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday,
CreateUserID,CreateDate,LastModifyUserID, LastModifyDate)

SELECT DISTINCT T1.DivisionID,T2.APK as APKMaster,
T1.FromHour,T1.ToHour,T1.Monday,T1.Tuesday,T1.Wednesday,T1.Thursday,T1.Friday, T1.Saturday,T1.Sunday,@UserID, GETDATE(),@UserID ,GETDATE()
FROM #Data T1 
INNER JOIN EDMT2100 T2 WITH (NOLOCK) ON T2.DailyScheduleID = T1.DailyScheduleID



LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

