IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP8161]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8161]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Xử lý Import dữ liệu Số dư tài khoản Có đầu kỳ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 31/07/2020 by Phạm Lê Hoàng
---- Modified on 27/02/2023 by Kiều Nga : Bổ sung import cột DepartmentID
-- <Example>
---- 
CREATE PROCEDURE [DBO].[AP8161]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000)
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50),
		@ExchangeRate AS DECIMAL(28,8),
		@i int, @n int,
		@InvoiceDate Datetime, -- @InvoiceNo NVarchar(50),
		@CurrencyID NVarchar(50), 
		@Method Tinyint

DECLARE @Operator AS INT, @ERDecimal AS INT
		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,	
	ImportMessage NVARCHAR(500) DEFAULT (''),
	Orders INT, -- Số thứ tự dòng
	VoucherID NVARCHAR(50) NULL,
	TransactionID NVARCHAR(50) NULL,
	BatchID NVARCHAR(50) NULL	
)

CREATE TABLE #Keys
(
	Row INT NOT NULL,
	Orders INT,
	VoucherID NVARCHAR(50),
	BatchID NVARCHAR(50),
	TransactionID NVARCHAR(50)
)

-- Tạo khóa chính cho table #Data và #Keys
DECLARE @Keys_PK VARCHAR(50), @Data_PK VARCHAR(50),
		@SQL NVARCHAR(MAX);
SET @Data_PK='PK_#Data_' + LTRIM(@@SPID);
SET @Keys_PK='PK_#Keys_' + LTRIM(@@SPID);

--add constraint 
SET @SQL = 'ALTER TABLE #Data ADD CONSTRAINT ' + @Data_PK+ ' PRIMARY KEY(Row)
			ALTER TABLE #Keys ADD CONSTRAINT ' + @Keys_PK+ ' PRIMARY KEY(Row)'

EXEC(@SQL)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT		TLD.ColID,
				BTL.ColSQLDataType
	FROM		A01065 TL WITH (NOLOCK)
	INNER JOIN	A01066 TLD WITH (NOLOCK)
			ON	TL.ImportTemplateID = TLD.ImportTemplateID
	INNER JOIN	A00065 BTL WITH (NOLOCK)
			ON	BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
	WHERE		TL.ImportTemplateID = @ImportTemplateID
	ORDER BY	TLD.OrderNum

OPEN @cCURSOR									
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + ' NULL'
	--PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END

ALTER TABLE #Data ADD Method Tinyint NULL

	
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,--DivisionID
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,--Period
		X.Data.query('VoucherTypeID').value('.', 'VARCHAR(50)') AS VoucherTypeID,--VoucherTypeID
		X.Data.query('VoucherNo').value('.', 'VARCHAR(50)') AS VoucherNo,--VoucherNo
		X.Data.query('VoucherDate').value('.', 'DATETIME') AS VoucherDate,--VoucherDate
		X.Data.query('EmployeeID').value('.', 'VARCHAR(50)') AS EmployeeID,--EmployeeID
		X.Data.query('CurrencyID').value('.', 'VARCHAR(50)') AS CurrencyID,--CurrencyID
		(CASE WHEN X.Data.query('ExchangeRate').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28,8), NULL)
			  ELSE X.Data.query('ExchangeRate').value('.', 'DECIMAL(28,8)') END) AS ExchangeRate,--ExchangeRate
		(CASE WHEN X.Data.query('VDescription').value('.', 'NVARCHAR(250)') = '' THEN CONVERT(NVARCHAR(250), NULL)
			  ELSE X.Data.query('VDescription').value('.', 'NVARCHAR(250)') END) AS VDescription,--VDescription
		(CASE WHEN X.Data.query('Serial').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Serial').value('.', 'VARCHAR(50)') END) AS Serial,--Serial
		(CASE WHEN X.Data.query('InvoiceNo').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('InvoiceNo').value('.', 'VARCHAR(50)') END) AS InvoiceNo,--InvoiceNo
		(CASE WHEN X.Data.query('InvoiceDate').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DATETIME, NULL)
			  ELSE X.Data.query('InvoiceDate').value('.', 'DATETIME') END) AS InvoiceDate,--InvoiceDate
		(CASE WHEN X.Data.query('DueDate').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DATETIME, NULL)
			  ELSE X.Data.query('DueDate').value('.', 'DATETIME') END) AS DueDate,--DueDate
		X.Data.query('CreditAccountID').value('.', 'NVARCHAR(50)') AS CreditAccountID,--CreditAccountID
		X.Data.query('ObjectID').value('.', 'VARCHAR(50)') AS ObjectID,--ObjectID
		(CASE WHEN X.Data.query('OriginalAmount').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28,8), NULL)
			  ELSE X.Data.query('OriginalAmount').value('.', 'DECIMAL(28,8)') END) AS OriginalAmount,--OriginalAmount
		(CASE WHEN X.Data.query('ConvertedAmount').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28,8), NULL)
			  ELSE X.Data.query('ConvertedAmount').value('.', 'DECIMAL(28,8)') END) AS ConvertedAmount,--ConvertedAmount
		(CASE WHEN X.Data.query('TDescription').value('.', 'NVARCHAR(250)') = '' THEN CONVERT(NVARCHAR(250), NULL)
			  ELSE X.Data.query('TDescription').value('.', 'NVARCHAR(250)') END) AS TDescription,--TDescription
		(CASE WHEN X.Data.query('Ana01ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana01ID').value('.', 'VARCHAR(50)') END) AS Ana01ID,--Ana01ID
		(CASE WHEN X.Data.query('Ana02ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana02ID').value('.', 'VARCHAR(50)') END) AS Ana02ID,--Ana02ID
		(CASE WHEN X.Data.query('Ana03ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana03ID').value('.', 'VARCHAR(50)') END) AS Ana03ID,--Ana03ID
		(CASE WHEN X.Data.query('Ana04ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana04ID').value('.', 'VARCHAR(50)') END) AS Ana04ID,--Ana04ID
		(CASE WHEN X.Data.query('Ana05ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana05ID').value('.', 'VARCHAR(50)') END) AS Ana05ID,--Ana05ID
		(CASE WHEN X.Data.query('Ana06ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana06ID').value('.', 'VARCHAR(50)') END) AS Ana06ID,--Ana06ID
		(CASE WHEN X.Data.query('Ana07ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana07ID').value('.', 'VARCHAR(50)') END) AS Ana07ID,--Ana07ID
		(CASE WHEN X.Data.query('Ana08ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana08ID').value('.', 'VARCHAR(50)') END) AS Ana08ID,--Ana08ID
		(CASE WHEN X.Data.query('Ana09ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana09ID').value('.', 'VARCHAR(50)') END) AS Ana09ID,--Ana09ID
		(CASE WHEN X.Data.query('Ana10ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana10ID').value('.', 'VARCHAR(50)') END) AS Ana10ID,--Ana10ID
		(CASE WHEN X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') END) AS DepartmentID,
		IDENTITY(int, 1, 1) AS OrderNo
INTO	#AP8161
FROM	@XML.nodes('//Data') AS X (Data)


INSERT INTO #Data (
		Row,Orders,DivisionID,Period,VoucherTypeID,VoucherNo,VoucherDate,EmployeeID,CurrencyID,		
		ExchangeRate,VDescription,Serial,InvoiceNo,InvoiceDate,DueDate,
		CreditAccountID,ObjectID,OriginalAmount,ConvertedAmount,TDescription,
		Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,DepartmentID)	
SELECT	Row,OrderNo,DivisionID,Period,VoucherTypeID,VoucherNo,VoucherDate,EmployeeID,CurrencyID,
		ExchangeRate,VDescription,Serial,InvoiceNo,InvoiceDate,DueDate,
		CreditAccountID,ObjectID,OriginalAmount,ConvertedAmount,TDescription,	
		Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,DepartmentID
FROM	#AP8161

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID
--EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidObject', @ColID = 'ObjectID', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 0, @SQLWhere = ''

---- Kiểm tra dữ liệu không đồng nhất tại phần phiếu
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'VoucherNo', @Param1 = 'VoucherNo,VoucherTypeID,VoucherDate,CurrencyID,ExchangeRate,EmployeeID,VDescription'

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT


--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			ConvertedAmount = ROUND(ConvertedAmount, CUR.ConvertedDecimals),
			OriginalAmount = ROUND(OriginalAmount, CUR.OriginalDecimal),
			ExchangeRate = ROUND(DT.ExchangeRate, CUR.ExchangeRateDecimal),
			VoucherDate = CONVERT(DATE, VoucherDate),
			InvoiceDate = CONVERT(DATE, CASE WHEN InvoiceDate = '1900-01-01' THEN NULL ELSE InvoiceDate END)
FROM		#Data DT
INNER JOIN	AV1004 CUR 
		ON	CUR.CurrencyID = DT.CurrencyID AND CUR.DivisionID in (DT.CurrencyID,'@@@')


-- Sinh khóa
DECLARE @cKey AS CURSOR
DECLARE @Row AS INT,
		@Orders AS INT,
		@VoucherNo AS NVARCHAR(50),
		@InvoiceNo AS NVARCHAR(50),
		@Serial AS NVARCHAR(50),
		@Period AS NVARCHAR(50),
		@ObjectID AS NVARCHAR(50), 
		@OVoucherGroup AS NVARCHAR(50),
		@OInvoiceGroup AS NVARCHAR(250)

DECLARE	@VoucherID AS NVARCHAR(50),
		@BatchID AS NVARCHAR(50),
		@TransID AS NVARCHAR(50)			

SET @cKey = CURSOR FOR
	SELECT	Row, VoucherNo, InvoiceNo, Serial, ObjectID, Period
	FROM	#Data
		
OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row, @VoucherNo, @InvoiceNo, @Serial, @ObjectID, @Period
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Period = RIGHT(@Period, 4)
	IF @OVoucherGroup IS NULL OR @OVoucherGroup <> (@VoucherNo + '#' + @Period) 
	BEGIN
		SET @Orders = 0
		SET @VoucherID = CONCAT('VB', NEWID())
		SET @OVoucherGroup = (@VoucherNo + '#' + @Period)
	END

	SET @Orders = @Orders + 1
	
	SET @TransID = CONCAT('TB', NEWID())
	SET @BatchID = @TransID  ----- BatchID = TransactionID

	INSERT INTO #Keys (Row, Orders, VoucherID, BatchID, TransactionID) VALUES (@Row, @Orders, @VoucherID, @BatchID, @TransID)				
	FETCH NEXT FROM @cKey INTO @Row, @VoucherNo, @InvoiceNo, @Serial, @ObjectID, @Period
END	
CLOSE @cKey

-- Cập nhật khóa
UPDATE		DT
SET			Orders = K.Orders,
			VoucherID = K.VoucherID,
			BatchID = K.BatchID,
			DT.TransactionID = K.TransactionID			
FROM		#Data DT
INNER JOIN	#Keys K
		ON	K.Row = DT.Row

--drop constraint 
SET @SQL = 'IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Keys'' AND xtype = ''U'')
			BEGIN
				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Keys_PK+''' AND xtype = ''PK'')
					ALTER TABLE #Keys DROP CONSTRAINT ' + @Keys_PK +'
			END
			IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Data'' AND xtype = ''U'')
			BEGIN
				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Data_PK+''' AND xtype = ''PK'')
					ALTER TABLE #Keys DROP CONSTRAINT ' + @Data_PK +'
			END
			'
EXEC(@SQL)


-- Kiểm tra trùng số chứng từ
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateVoucherNo', @ColID = 'VoucherNo', @Param1 = 'VoucherID'

-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT
	
--BEGIN TRAN

-- Đẩy dữ liệu vào bảng
INSERT INTO AT9000
(
APK,
VoucherID,BatchID,TransactionID,TableID,DivisionID,TranMonth,TranYear,TransactionTypeID,
CurrencyID,ObjectID,VoucherTypeID,VoucherNo,VoucherDate,EmployeeID,CreditAccountID,
ExchangeRate,OriginalAmount,ConvertedAmount,Orders,OriginalAmountCN,ExchangeRateCN,CurrencyIDCN,
VDescription,BDescription,TDescription,InvoiceNo,Serial,InvoiceDate,DueDate,
IsStock,IsCost,IsAudit,Status,
Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,DepartmentID,
CreateUserID,CreateDate,LastModifyUserID,LastModifyDate
)
SELECT	APK,
		VoucherID,BatchID,TransactionID,'AT9000',DivisionID,LEFT(Period, 2),RIGHT(Period, 4),'T00',
		CurrencyID,ObjectID,VoucherTypeID,VoucherNo,VoucherDate,EmployeeID,CreditAccountID,
		ExchangeRate,OriginalAmount,ConvertedAmount,Orders,OriginalAmount,ExchangeRate,CurrencyID,
		VDescription,TDescription,TDescription,InvoiceNo,Serial,InvoiceDate,DueDate,
		0,0,0,'0',
		Ana01ID, Ana02ID, Ana03ID, Ana04ID,	Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,DepartmentID,
		@UserID, GETDATE(),	@UserID, GETDATE()
FROM	#Data

---- Cập nhật mã tăng tự động: trên code Table đang là AT9000, 
DECLARE @VoucherTypeID VARCHAR(50),
		@TranMonth INT,
		@TranYear INT
-- Sinh khóa
DECLARE @cAT4444 AS CURSOR
SET @cAT4444 = CURSOR FOR
	SELECT	DISTINCT VoucherNo, VoucherTypeID, Period
	FROM	#Data
		
OPEN @cAT4444
FETCH NEXT FROM @cAT4444 INTO @VoucherNo, @VoucherTypeID, @Period
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @TranMonth = CONVERT(INT, LEFT(@Period,2))
	SET @TranYear = CONVERT(INT, RIGHT(@Period,4))		

	EXEC AP8102 @DivisionID, @VoucherTypeID, @VoucherNo, 'AT9000', @TranMonth, @TranYear

	FETCH NEXT FROM @cAT4444 INTO @VoucherNo, @VoucherTypeID, @Period
END	
CLOSE @cAT4444

--ROLLBACK TRAN

LB_RESULT:
SELECT * FROM #Data


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

