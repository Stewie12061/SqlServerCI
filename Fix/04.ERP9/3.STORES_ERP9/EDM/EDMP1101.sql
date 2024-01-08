IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Import Excel danh mục khuyến mãi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Khánh Đoan on 05/02/2020

-- <Example>
/* 
 EXEC EDMP1101 @DivisionID, @UserID, @ImportTransTypeID, @XML
 */
 
CREATE PROCEDURE EDMP1101
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
PRINT('A') 
SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('FromDate').value('.', 'VARCHAR(50)') AS FromDate,
		X.Data.query('ToDate').value('.', 'VARCHAR(50)') AS ToDate,
		X.Data.query('PromotionID').value('.', 'VARCHAR(50)') AS PromotionID,
		X.Data.query('PromotionName').value('.', 'NVARCHAR(250)') AS PromotionName,
		X.Data.query('PromotionType').value('.', 'VARCHAR(50)') AS PromotionType, 
		X.Data.query('Value').value('.', 'DECIMAL(28)') AS [Value],	
		X.Data.query('ReceiptTypeID').value('.', 'VARCHAR(50)') AS ReceiptTypeID,	
		X.Data.query('Quantity').value('.', 'DECIMAL(28)') AS Quantity,	
		X.Data.query('Description').value('.', 'NVARCHAR(250)') AS Description,	
		IDENTITY(int, 1, 1) AS Orders			
INTO #EDMT1100
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], Orders, DivisionID, FromDate, ToDate,
PromotionID, PromotionName, PromotionType, Value,ReceiptTypeID,Quantity,Description)
SELECT [Row], Orders, DivisionID,
CASE WHEN ISNULL(FromDate, '') = '' THEN NULL ELSE CONVERT(DATETIME, FromDate, 103) END AS FromDate,
CASE WHEN ISNULL(ToDate, '') = '' THEN NULL ELSE CONVERT(DATETIME, ToDate, 103) END AS ToDate,
 PromotionID, PromotionName, PromotionType, Value,ReceiptTypeID,Quantity,Description
FROM #EDMT1100
 


---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID


---- Kiểm tra trùng mã khuyến mãi
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData', @ColID = 'PromotionID', @Param1 = 'Orders', @Param2 = 'EDMT1100', 
@Param3 = 'PromotionID'

------ Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END
 
---- Đẩy dữ liệu vào danh mục khuyến mãi
INSERT INTO EDMT1100 (DivisionID,FromDate,ToDate,PromotionID,PromotionName,PromotionType,[Value],ReceiptTypeID,
Quantity,[Description],CreateUserID,CreateDate,LastModifyUserID,LastModifyDate	)
SELECT  DISTINCT DivisionID,FromDate,ToDate,PromotionID,PromotionName,PromotionType,[Value],ReceiptTypeID,
Quantity,[Description],@UserID, GETDATE(),  @UserID, GETDATE()
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



 
 