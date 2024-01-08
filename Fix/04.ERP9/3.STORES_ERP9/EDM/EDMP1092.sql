IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1092]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1092]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Import Excel danh mục biểu phí 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Hồng Thảo on 07/09/2019
---- Modified by on
-- <Example>
 
CREATE PROCEDURE EDMP1092
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
		X.Data.query('FeeID').value('.', 'VARCHAR(50)') AS FeeID,
		X.Data.query('FeeName').value('.', 'NVARCHAR(250)') AS FeeName,
		X.Data.query('SchoolYearID').value('.', 'VARCHAR(50)') AS SchoolYearID,
		X.Data.query('GradeID').value('.', 'VARCHAR(50)') AS GradeID,
		(CASE WHEN X.Data.query('IsCommon').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsCommon').value('.', 'TINYINT') END) AS IsCommon,	
		X.Data.query('ReceiptTypeID').value('.', 'VARCHAR(50)') AS ReceiptTypeID, 
		(CASE WHEN X.Data.query('Amount').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('Amount').value('.', 'DECIMAL(28,8)') END ) AS Amount,	
		X.Data.query('UnitID').value('.', 'VARCHAR(50)') AS UnitID, 
		(CASE WHEN X.Data.query('AmountOfDay').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('AmountOfDay').value('.', 'DECIMAL(28,8)')  END ) AS AmountOfDay,	
		(CASE WHEN X.Data.query('AmountOfOneMonth').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('AmountOfOneMonth').value('.', 'DECIMAL(28,8)') END ) AS AmountOfOneMonth,	
		(CASE WHEN X.Data.query('AmountOfSixMonth').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('AmountOfSixMonth ').value('.', 'DECIMAL(28,8)') END ) AS AmountOfSixMonth ,	
		(CASE WHEN X.Data.query('AmountOfNineMonth').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('AmountOfNineMonth ').value('.', 'DECIMAL(28,8)') END ) AS AmountOfNineMonth ,	
		(CASE WHEN X.Data.query('AmountOfYear').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('AmountOfYear ').value('.', 'DECIMAL(28,8)') END ) AS AmountOfYear ,	
		(CASE WHEN X.Data.query('AmountsOfOneWay').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('AmountsOfOneWay ').value('.', 'DECIMAL(28,8)')  END )AS  AmountsOfOneWay ,	
		(CASE WHEN X.Data.query('AmountsOfTwoWay').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('AmountsOfTwoWay ').value('.', 'DECIMAL(28,8)')END )  AS AmountsOfTwoWay ,	
		IDENTITY(int, 1, 1) AS Orders			
INTO #EDMT1090
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]
 
 
INSERT INTO #Data ([Row], Orders, DivisionID, FeeID, FeeName,SchoolYearID,GradeID,IsCommon, 
ReceiptTypeID,  Amount, UnitID,AmountOfDay,AmountOfOneMonth,AmountOfSixMonth ,AmountOfNineMonth,AmountOfYear,AmountsOfOneWay,AmountsOfTwoWay)

SELECT [Row], Orders, DivisionID, FeeID, FeeName,SchoolYearID,GradeID,IsCommon, ReceiptTypeID,  Amount, UnitID
,AmountOfDay,AmountOfOneMonth,AmountOfSixMonth ,AmountOfNineMonth,AmountOfYear,AmountsOfOneWay,AmountsOfTwoWay
FROM #EDMT1090



---- Kiểm tra check code mặc định 
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID


---- Kiểm tra dữ liệu không đồng nhất tại phần master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-EDM', @ColID = 'FeeID', 
@Param1 = 'FeeID, FeeName,SchoolYearID,GradeID,IsCommon'


---- Kiểm tra dữ liệu không đồng nhất tại phần detail 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-EDM', @ColID = 'FeeID, ReceiptTypeID', 
@Param1 = 'FeeID, FeeName,SchoolYearID,GradeID, IsCommon, ReceiptTypeID, Amount, UnitID,AmountOfDay,AmountOfOneMonth,AmountOfSixMonth ,AmountOfNineMonth,AmountOfYear,AmountsOfOneWay,AmountsOfTwoWay'


---- Kiểm tra dữ liệu detail 
DECLARE @ColumnName VARCHAR(50), 
		@ColName NVARCHAR(50), 
		@ColumnName1 VARCHAR(50), 
		@ColName1 NVARCHAR(50), 
		@Cur CURSOR, 
		@FeeID VARCHAR(50), 
		@ReceiptTypeID VARCHAR(50)

SELECT TOP 1 @ColumnName = DataCol, @ColName = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'FeeID'

SELECT TOP 1 @ColumnName = DataCol, @ColName = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ReceiptTypeID'


SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT FeeID, ReceiptTypeID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @FeeID, @ReceiptTypeID

WHILE @@FETCH_STATUS = 0
BEGIN

	---- Kiểm tra trùng mã biểu phí trong danh mục
	IF EXISTS (SELECT TOP  1 1 FROM EDMT1090 WITH (NOLOCK) WHERE FeeID = @FeeID)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-SFML000077,',
				ErrorColumn = @ColName+','
	END 
	-- Kiểm tra trùng mã loại hình thu 
	IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE FeeID = @FeeID AND ReceiptTypeID = @ReceiptTypeID HAVING COUNT(ReceiptTypeID) >=2)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-ASML000084,',
				ErrorColumn = @ColName+','
	END 

	FETCH NEXT FROM @Cur INTO @FeeID, @ReceiptTypeID
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
INSERT INTO EDMT1090 ( DivisionID, FeeID, FeeName,SchoolYearID,GradeID, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT  CASE WHEN IsCommon = 1 THEN '@@@' ELSE DivisionID END AS DivisionID, FeeID, FeeName,SchoolYearID,GradeID, IsCommon, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data 

-- Đẩy dữ liệu vào bảng detail 
INSERT INTO EDMT1091 ( DivisionID, APKMaster, ReceiptTypeID, Amount, UnitID,AmountOfDay,AmountOfOneMonth,AmountOfSixMonth ,
AmountOfNineMonth,AmountOfYear,AmountsOfOneWay,AmountsOfTwoWay)
SELECT DISTINCT CASE WHEN T1.IsCommon = 1 THEN '@@@' ELSE T1.DivisionID END AS DivisionID, T2.APK AS APKMaster, T1.ReceiptTypeID, 
T1.Amount, T1.UnitID,T1.AmountOfDay,T1.AmountOfOneMonth,T1.AmountOfSixMonth ,
T1.AmountOfNineMonth,T1.AmountOfYear,T1.AmountsOfOneWay,T1.AmountsOfTwoWay
FROM #Data T1 
INNER JOIN EDMT1090 T2 WITH (NOLOCK) ON T2.FeeID = T1.FeeID


LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]


 
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


