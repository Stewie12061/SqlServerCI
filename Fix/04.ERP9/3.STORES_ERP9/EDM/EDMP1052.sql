IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1052]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Import Excel danh mục loại hình thu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Hồng Thảo on 23/08/2018
---- Modified by on 
-- <Example>
/* 
 EXEC EDMP1052 @DivisionID, @UserID, @ImportTransTypeID, @XML
 */
 
CREATE PROCEDURE EDMP1052
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
	ReceiptTypeID VARCHAR(50),
	ReceiptTypeName NVARCHAR(MAX),
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
		X.Data.query('AnaRevenueID').value('.', 'VARCHAR(50)') AS AnaRevenueID,
		X.Data.query('TypeOfFee').value('.', 'VARCHAR(50)') AS TypeOfFee,
		X.Data.query('Business').value('.', 'VARCHAR(50)') AS Business, 
		X.Data.query('AccountID').value('.', 'VARCHAR(50)') AS AccountID, 
		X.Data.query('Note').value('.', 'NVARCHAR(MAX)') AS Note, 
		X.Data.query('StudentStatus').value('.', 'VARCHAR(50)') AS StudentStatus, 
		X.Data.query('IsObligatory').value('.', 'TINYINT') AS IsObligatory, 
		(CASE WHEN X.Data.query('IsCommon').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsCommon').value('.', 'TINYINT') END) AS IsCommon,	
		X.Data.query('IsReserve').value('.', 'TINYINT') AS IsReserve, 
		X.Data.query('IsTransfer').value('.', 'TINYINT') AS IsTransfer, 	   
		IDENTITY(int, 1, 1) AS Orders			
INTO #EDMT1050
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], Orders, DivisionID,AnaRevenueID,TypeOfFee,Business,AccountID,Note,StudentStatus,IsObligatory, IsCommon,IsReserve,IsTransfer)
SELECT [Row], Orders,  DivisionID,AnaRevenueID,TypeOfFee,Business,AccountID,Note,StudentStatus,IsObligatory, IsCommon,IsReserve,IsTransfer
FROM #EDMT1050

-- Cập nhật mã loại hình thu , tên loại hình thu
UPDATE		DT
SET			ReceiptTypeID = DT.AnaRevenueID,
			ReceiptTypeName =T.AnaName		
FROM		#Data DT
INNER JOIN	AT1011 T
		WITH (NOLOCK) ON T.AnaID = DT.AnaRevenueID  AND T.AnaTypeID ='A04'

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra trùng mã loại hình thu  
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData', @ColID = 'ReceiptTypeID', @Param1 = 'Orders', @Param2 = 'EDMT1050', 
@Param3 = 'ReceiptTypeID'

------ Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END

---- Đẩy dữ liệu vào danh mục loại hình thu 
INSERT INTO EDMT1050 (DivisionID,AnaRevenueID, ReceiptTypeID, ReceiptTypeName,TypeOfFee,AccountID,Note, IsCommon, 
CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT CASE WHEN IsCommon = 1 THEN '@@@' ELSE DivisionID END AS DivisionID,AnaRevenueID,ReceiptTypeID, ReceiptTypeName,TypeOfFee,AccountID, Note, IsCommon,
 @UserID AS CreateUserID, GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate				
FROM #Data 

INSERT INTO EDMT1051 (DivisionID,APKMaster,Business,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
SELECT DISTINCT T2.DivisionID,T2.APK AS APKMaster,T1.Business, 
@UserID AS CreateUserID, GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate		
FROM #Data T1
INNER JOIN EDMT1050 T2 WITH (NOLOCK) ON T2.ReceiptTypeID = T1.ReceiptTypeID

INSERT INTO EDMT1052 (DivisionID,APKMaster,StudentStatus,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
SELECT DISTINCT T4.DivisionID ,T4.APK AS APKMaster,T3.StudentStatus, 
@UserID AS CreateUserID, GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate		
FROM #Data T3
INNER JOIN EDMT1050 T4 WITH (NOLOCK) ON T4.ReceiptTypeID = T3.ReceiptTypeID
 

DECLARE @ColumnName VARCHAR(50), 
		@ColName NVARCHAR(50), 
		@CurInventory CURSOR, 
		@ReceiptTypeID VARCHAR(50),
		@Row INT

SET @CurInventory = CURSOR SCROLL KEYSET FOR
SELECT [Row], ReceiptTypeID
FROM #Data
OPEN @CurInventory
FETCH NEXT FROM @CurInventory INTO @Row, @ReceiptTypeID
WHILE @@FETCH_STATUS = 0
BEGIN

IF NOT EXISTS (SELECT TOP 1 1 FROM AT1302 WITH (NOLOCK) WHERE InventoryID = @ReceiptTypeID  AND DivisionID IN (@DivisionID,'@@@'))
BEGIN
	INSERT INTO AT1302 (DivisionID,InventoryID,InventoryName,UnitID,ProductTypeID,InventoryNameNoUnicode,IsStocked,SalesAccountID,PurchaseAccountID,PrimeCostAccountID,IsCommon,Disabled,CreateDate,CreateUserID,LastModifyDate,LastModifyUserID)
	SELECT CASE WHEN IsCommon = 1 THEN '@@@' ELSE DivisionID END,ReceiptTypeID,ReceiptTypeName,'LA',1,dbo.RemoveUnicode(ReceiptTypeName),0,NULL,NULL,NULL,IsCommon,0,GETDATE(),@UserID, GETDATE(),@UserID
	FROM #Data
	WHERE ReceiptTypeID = @ReceiptTypeID
END


FETCH NEXT FROM @CurInventory INTO @Row, @ReceiptTypeID
END



Close @CurInventory




LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
