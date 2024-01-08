IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2126]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2126]
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
---- Create on 27/11/2019 by Khánh Đoan : Import nghiệp vụ Chương trình học tháng


CREATE PROCEDURE [DBO].[EDMP2126]
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
		X.Data.query('ProgrammonthID').value('.', 'VARCHAR(50)') AS ProgrammonthID,
		X.Data.query('TermID').value('.', 'VARCHAR(50)') AS TermID,
		X.Data.query('TranMonth').value('.', 'VARCHAR(50)') AS TranMonth,
		X.Data.query('VoucherDate').value('.', 'VARCHAR(50)') AS VoucherDate,
		X.Data.query('GradeID').value('.', 'VARCHAR(50)') AS GradeID,
		X.Data.query('ClassID').value('.', 'VARCHAR(50)') AS ClassID,
		X.Data.query('Notes').value('.', 'NVARCHAR(MAX)') AS Notes,
		X.Data.query('Week').value('.', 'VARCHAR(50)') AS [Week],
		X.Data.query('FromDate').value('.', 'VARCHAR(50)') AS FromDate,
		X.Data.query('ToDate').value('.', 'VARCHAR(50)') AS ToDate,
		X.Data.query('Topic').value('.', 'NVARCHAR(MAX)') AS Topic,
		X.Data.query('Description').value('.', 'NVARCHAR(MAX)') AS [Description],
		IDENTITY(int, 1, 1) AS Orders
		
INTO #EDMP2126
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]


 
INSERT INTO #Data ([Row],Orders,DivisionID,ProgrammonthID,TermID,TranMonth,VoucherDate,GradeID,ClassID,Notes,[Week],FromDate, ToDate,
Topic,[Description])

SELECT[Row],Orders,DivisionID,ProgrammonthID,TermID,  TranMonth,
CASE WHEN ISNULL(VoucherDate, '') = '' THEN NULL ELSE CONVERT(datetime, VoucherDate, 103) END AS VoucherDate,
GradeID,ClassID,Notes,[Week],
CASE WHEN ISNULL(FromDate, '') = '' THEN NULL ELSE CONVERT(datetime, FromDate, 103) END AS FromDate,
CASE WHEN ISNULL(ToDate, '') = '' THEN NULL ELSE CONVERT(datetime, ToDate, 103) END AS ToDate,
Topic,[Description]
FROM  #EDMP2126


---- Kiểm tra dữ liệu không đồng nhất tại phần master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID,
 @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-EDM', @ColID = 'ProgrammonthID', 
@Param1 = 'ProgrammonthID,TermID,TranMonth,VoucherDate,GradeID,ClassID'


IF OBJECT_ID('tempdb..#TT') IS NOT NULL 
DROP TABLE #TT

CREATE TABLE #TT(
	[Row] INT , 
	Orders INT,
	DivisionID VARCHAR(50),
	ProgrammonthID VARCHAR(50),
	TermID  VARCHAR(50),
	TranMonth VARCHAR(50),
	TranYear VARCHAR(50),
	VoucherDate DATETIME,
	GradeID VARCHAR(50),
	ClassID VARCHAR(50),
	Notes  NVARCHAR(MAX),
	[Week] NVARCHAR(50),
	FromDate DATETIME,
	ToDate DATETIME,
	Topic NVARCHAR(250),
	[Description] NVARCHAR(MAX),
	)



INSERT INTO #TT ([Row],Orders,DivisionID,ProgrammonthID,TermID,TranMonth, TranYear,VoucherDate,GradeID,ClassID,Notes,[Week],FromDate, ToDate,
Topic,[Description])

SELECT [Row],Orders,DivisionID,ProgrammonthID,TermID,LEFT(TranMonth,2) AS TranMonth , RIGHT(TranMonth,4) AS TranYear, VoucherDate,GradeID,ClassID,Notes,[Week],FromDate, ToDate,
Topic,[Description]
FROM #Data 


---- Kiểm tra check code mặc định 
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID


---- Kiểm tra đơn

DECLARE @Cur AS CURSOR,
		@ColumnName VARCHAR(50), 
		@ColName NVARCHAR(50), 
		@TranMonth INT,
		@TranYear INT,
		@GradeID VARCHAR(50),
		@ClassID VARCHAR(50),
		@TermID VARCHAR(50),
		@ProgrammonthID VARCHAR(50),
		@Week INT,
		@ColumnName1 VARCHAR(50), 
		@ColName1 NVARCHAR(50),
		@ColumnName2 VARCHAR(50), 
		@ColName2 NVARCHAR(50), 
		@DivisionIDCur VARCHAR(50)



SELECT TOP 1 @ColumnName = DataCol, @ColName = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ProgrammonthID'


SELECT TOP 1 @ColumnName2 = DataCol, @ColName2 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DivisionID'



SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT DISTINCT  DivisionID, ProgrammonthID ,GradeID, ClassID, TermID ,TranMonth , TranYear  FROM #TT
OPEN @Cur
FETCH NEXT FROM @Cur INTO @DivisionIDCur, @ProgrammonthID ,@GradeID, @ClassID,@TermID,@TranMonth, @TranYear

WHILE @@FETCH_STATUS = 0
BEGIN
	
	------Kiểm tra đơn vị  hiện tại
		IF EXISTS (SELECT TOP  1 1 FROM #TT WITH (NOLOCK) WHERE DivisionID <> @DivisionID )
		BEGIN
	
		UPDATE	#Data
		SET	ErrorMessage = @ColumnName2  +'-00ML000114,',
			ErrorColumn = @ColName2+','
		END

	---- Kiểm tra một tháng  chỉ có 1 chương trình học tháng của một khối 
	IF EXISTS (SELECT TOP  1 1 FROM EDMT2120 WITH (NOLOCK) 
				WHERE  DivisionID = @DivisionIDCur AND TranMonth = @TranMonth AND 
				TranYear = @TranYear AND GradeID = @GradeID AND TermID = @TermID AND ISNULL(ClassID, '') = ISNULL(@ClassID,'') AND DeleteFlg = 0)
	BEGIN
		UPDATE	#Data
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-EDMFML000062,',
				ErrorColumn = @ColName+','
	END 



-----Kiểm tra trùng 1 năm học trùng khối 
	IF EXISTS (SELECT COUNT(ClassID) AS B FROM
				(
					SELECT DISTINCT ProgrammonthID, TranYear,TranMonth,GradeID,ClassID FROM #TT WITH (NOLOCK) 
					WHERE DivisionID = @DivisionID  AND TranMonth = @TranMonth AND TranYear = @TranYear AND GradeID = @GradeID AND TermID = @TermID  AND ISNULL(ClassID, '') = ISNULL(@ClassID,'')  
					GROUP BY ProgrammonthID,TranYear,TranMonth,GradeID,ClassID
				) AS A
					HAVING COUNT(ClassID) >= 2
				)
	BEGIN
		UPDATE	#Data
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-EDMFML000062,',
				ErrorColumn = @ColName+','
	END 


-----kiểm tra trùng mã lịch học 


	IF EXISTS (SELECT TOP  1 1 FROM EDMT2120 WITH (NOLOCK) WHERE DivisionID = @DivisionIDCur AND ProgrammonthID = @ProgrammonthID  AND DeleteFlg = 0)
	BEGIN
		UPDATE	#Data
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-00ML000157,',
				ErrorColumn = @ColName+','
	END 


	
	FETCH NEXT FROM @Cur INTO @DivisionIDCur,  @ProgrammonthID ,@GradeID, @ClassID,@TermID,@TranMonth, @TranYear
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
INSERT INTO EDMT2120 (DivisionID,ProgrammonthID,VoucherDate,GradeID,[Description] ,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,TranMonth,TranYear, TermID, ClassID)

SELECT DISTINCT DivisionID,ProgrammonthID,VoucherDate,GradeID,Notes,@UserID, GETDATE(),@UserID ,GETDATE(),TranMonth,TranYear,TermID,ClassID
FROM #TT

-- Đẩy dữ liệu vào bảng detail 
INSERT INTO EDMT2121(DivisionID,APKMaster,[Week],FromDate, ToDate,Topic,[Description],CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)

SELECT	DISTINCT T1.DivisionID,T2.APK as APKMaster,T1.[Week], T1.FromDate, T1.ToDate,T1.Topic,T1.[Description],@UserID, GETDATE(),@UserID ,GETDATE()
FROM #TT T1
INNER JOIN EDMT2120 T2 WITH (NOLOCK) ON T2.ProgrammonthID = T1.ProgrammonthID


LB_RESULT:

SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]

SELECT * FROM #Data



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
