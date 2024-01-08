IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP8114_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8114_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xử lý Import dữ liệu bút toán tổng hợp
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 05/10/2011 by Nguyễn Bình Minh
---- 
---- Modified on 05/10/2011 by
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK) 
---- Modified by Bảo Thy on 15/06/2016: Bổ sung Ana06ID->Ana10ID
---- Modified by Phương Thảo on 25/08/2016: Bổ sung kiểm tra bắt buộc nhập đối tượng nếu TK quản lý theo đối tượng
---- Modified by Kim Thư on 14/02/2019: Bổ sung import thêm cột PaymentTermID 
---- Modified by Huỳnh Thử on 13/07/2020: Tách Store AP2222_MK
---- Modified by Xuân Nguyên on 27/04/2021: Đẩy dữ liệu vào bảng AT9000 từ bảng #data dùng hàm LEFT JOIN
---- Modified on 28/06/2021 by Huỳnh Thử: Bổ sung trường InvoiceCode, InvoiceSign, OrderID
---- Modified on 27/02/2023 by Kiều Nga : Bổ sung import cột DepartmentID
-- <Example>
---- 
CREATE PROCEDURE [DBO].[AP8114_MK]
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
		@ColSQLDataType AS NVARCHAR(50)
		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT,	
	ImportMessage NVARCHAR(500) DEFAULT (''),
	Orders INT, -- Số thứ tự dòng
	VoucherID NVARCHAR(50) NULL,
	TransactionID NVARCHAR(50) NULL,
	BatchID NVARCHAR(50) NULL,
	IsDObject TINYINT default (0),
	IsCObject TINYINT default (0),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT,
	Orders INT,
	VoucherID NVARCHAR(50),
	BatchID NVARCHAR(50),
	TransactionID NVARCHAR(50),	
	CONSTRAINT [PK_#Keys] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

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
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	--PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END


SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,
		X.Data.query('VoucherTypeID').value('.', 'NVARCHAR(50)') AS VoucherTypeID,
		X.Data.query('VoucherNo').value('.', 'NVARCHAR(50)') AS VoucherNo,
		X.Data.query('VoucherDate').value('.', 'DATETIME') AS VoucherDate,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('InvoiceCode').value('.', 'NVARCHAR(50)') AS InvoiceCode,
		X.Data.query('InvoiceSign').value('.', 'NVARCHAR(50)') AS InvoiceSign,
		X.Data.query('Serial').value('.', 'NVARCHAR(50)') AS Serial,
		X.Data.query('InvoiceNo').value('.', 'NVARCHAR(50)') AS InvoiceNo,
		X.Data.query('InvoiceDate').value('.', 'DATETIME') AS InvoiceDate,
		x.Data.query('PaymentTermID').value('.','NVARCHAR(50)') AS PaymentTermID,
		--X.Data.query('DueDate').value('.', 'DATETIME') AS DueDate,
		X.Data.query('VDescription').value('.', 'NVARCHAR(250)') AS VDescription,
		X.Data.query('BDescription').value('.', 'NVARCHAR(250)') AS BDescription,
		X.Data.query('CurrencyID').value('.', 'NVARCHAR(50)') AS CurrencyID,
		X.Data.query('ExchangeRate').value('.', 'DECIMAL(28,8)') AS ExchangeRate,
		X.Data.query('OriginalAmount').value('.', 'DECIMAL(28,8)') AS OriginalAmount,
		X.Data.query('ConvertedAmount').value('.', 'DECIMAL(28,8)') AS ConvertedAmount,
		X.Data.query('DebitAccountID').value('.', 'NVARCHAR(50)') AS DebitAccountID,
		X.Data.query('CreditAccountID').value('.', 'NVARCHAR(50)') AS CreditAccountID,
		X.Data.query('VATTypeID').value('.', 'NVARCHAR(50)') AS VATTypeID,
		X.Data.query('VATGroupID').value('.', 'NVARCHAR(50)') AS VATGroupID,
		X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID,
		X.Data.query('CreditObjectID').value('.', 'NVARCHAR(50)') AS CreditObjectID,		
		X.Data.query('TDescription').value('.', 'NVARCHAR(250)') AS TDescription,
		X.Data.query('Ana01ID').value('.', 'NVARCHAR(50)') AS Ana01ID,
		X.Data.query('Ana02ID').value('.', 'NVARCHAR(50)') AS Ana02ID,
		X.Data.query('Ana03ID').value('.', 'NVARCHAR(50)') AS Ana03ID,
		X.Data.query('Ana04ID').value('.', 'NVARCHAR(50)') AS Ana04ID,
		X.Data.query('Ana05ID').value('.', 'NVARCHAR(50)') AS Ana05ID,
		X.Data.query('Ana06ID').value('.', 'NVARCHAR(50)') AS Ana06ID,
		X.Data.query('Ana07ID').value('.', 'NVARCHAR(50)') AS Ana07ID,
		X.Data.query('Ana08ID').value('.', 'NVARCHAR(50)') AS Ana08ID,
		X.Data.query('Ana09ID').value('.', 'NVARCHAR(50)') AS Ana09ID,
		X.Data.query('Ana10ID').value('.', 'NVARCHAR(50)') AS Ana10ID,
		Convert(Tinyint,0) As IsDObject,
		Convert(Tinyint,0) As IsCObject,
		X.Data.query('OrderID').value('.', 'NVARCHAR(250)') AS OrderID,
		X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') AS DepartmentID
INTO	#AP8114		
FROM	@XML.nodes('//Data') AS X (Data)



UPDATE T1
SET		T1.IsDObject = IsObject
FROM	#AP8114 T1
INNER JOIN AT1005 T2 ON T1.DebitAccountID = T2.AccountID and T1.DivisionID = T2.DivisionID 

UPDATE T1
SET		T1.IsCObject = IsObject
FROM	#AP8114 T1
INNER JOIN AT1005 T2 ON T1.CreditAccountID = T2.AccountID and T1.DivisionID = T2.DivisionID 


INSERT INTO #Data (
		Row,				DivisionID,			Period,				VoucherTypeID,		VoucherNo,			VoucherDate,		EmployeeID,		
		InvoiceCode,		InvoiceSign,				
		Serial,				InvoiceNo,			InvoiceDate,		PaymentTermID,		--DueDate,		
		VDescription,		BDescription,		CurrencyID,			ExchangeRate, 		OriginalAmount, 	ConvertedAmount, 	
		DebitAccountID, 	CreditAccountID,	VATTypeID, 			VATGroupID, 		ObjectID,			CreditObjectID,			
		TDescription,		Ana01ID, 			Ana02ID, 			Ana03ID, 			Ana04ID,			Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
		IsDObject,		IsCObject,
		OrderID,		DepartmentID
)		
SELECT * 
FROM #AP8114


---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần phiếu
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'VoucherNo', @Param1 = 'VoucherNo,VoucherTypeID,VoucherDate,EmployeeID,VDescription'


-- Kiem tra bat buoc nhap thong tin doi tuong neu TK là TK cong no
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @Module = 'ASOFT-T', @ColID = 'ObjectID', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'IsDObject = 1'

EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @Module = 'ASOFT-T', @ColID = 'CreditObjectID', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'IsCObject = 1'

--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			ConvertedAmount = ROUND(ConvertedAmount, CUR.ConvertedDecimals),
			OriginalAmount = ROUND(OriginalAmount, CUR.OriginalDecimal),
			ExchangeRate = ROUND(DT.ExchangeRate, CUR.ExchangeRateDecimal),
			VoucherDate = CONVERT(datetime, CONVERT(varchar(10), VoucherDate, 101)),
			InvoiceDate = CASE WHEN InvoiceDate = '1900-01-01' THEN NULL ELSE CONVERT(datetime, CONVERT(varchar(10), InvoiceDate, 101)) END
FROM		#Data DT
INNER JOIN	AV1004 CUR 
		ON	CUR.CurrencyID = DT.CurrencyID AND CUR.DivisionID = DT.DivisionID

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

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
		EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @VoucherID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AV', @StringKey2 = @Period, @OutputLen = 16
		SET @OVoucherGroup = (@VoucherNo + '#' + @Period)
	END
	-- Mỗi hóa đơn sinh 1 BatchID
	IF @OInvoiceGroup IS NULL OR @OInvoiceGroup <> (@VoucherNo + '#' + @InvoiceNo + '#' + @Serial + '#' + @ObjectID + '#' + @Period)
	BEGIN
		EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @BatchID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AB', @StringKey2 = @Period, @OutputLen = 16
		SET @OInvoiceGroup = (@VoucherNo + '#' + @InvoiceNo + '#' + @Serial + '#' + @ObjectID + '#' + @Period)	
	END
	SET @Orders = @Orders + 1
	EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @TransID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AT', @StringKey2 = @Period, @OutputLen = 16
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

-- Kiểm tra trùng số chứng từ
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateVoucherNo', @ColID = 'VoucherNo', @Param1 = 'VoucherID'

-- Tính ngày đáo hạn
-- Tạo bảng tạm chứa ngày đáo hạn
CREATE TABLE #ReturnDate (ObjectID VARCHAR(50), VoucherDate DATETIME, InvoiceDate DATETIME, PaymentTermID VARCHAR(50), DivisionID VARCHAR(50), DueDate DATETIME)
INSERT INTO #ReturnDate (ObjectID, VoucherDate, InvoiceDate, PaymentTermID, DivisionID)
SELECT DISTINCT ObjectID, VoucherDate, InvoiceDate, PaymentTermID, DivisionID FROM #Data

DECLARE @Cur cursor,
		@DueDate DATETIME,
		@VoucherDate DATETIME, @InvoiceDate DATETIME, @PaymentTermID VARCHAR(50)

SET @Cur  = Cursor Scroll KeySet FOR 
			SELECT * FROM #ReturnDate
OPEN @Cur
FETCH NEXT FROM @Cur INTO @ObjectID, @VoucherDate, @InvoiceDate, @PaymentTermID, @DivisionID, @DueDate
WHILE @@Fetch_Status = 0
BEGIN
	exec AP2222_MK @ObjectID,@VoucherDate,@InvoiceDate,NULL,@PaymentTermID,@DivisionID, @DueDate OUTPUT
	UPDATE #ReturnDate
	SET DueDate = @DueDate
	WHERE ObjectID = @ObjectID AND VoucherDate = @VoucherDate AND InvoiceDate = @InvoiceDate AND PaymentTermID = @PaymentTermID AND DivisionID = @DivisionID
	--select @DueDate
	FETCH NEXT FROM @Cur INTO  @ObjectID, @VoucherDate, @InvoiceDate, @PaymentTermID, @DivisionID, @DueDate
END            
CLOSE @Cur
DEALLOCATE @Cur
-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

-- Đẩy dữ liệu vào bảng
INSERT INTO AT9000
(
	APK,				Orders,
	VoucherID,			BatchID,			TransactionID,
	DivisionID,			TranMonth,			TranYear,
	VoucherTypeID,		VoucherNo,
	VoucherDate,		EmployeeID,
	InvoiceCode,		InvoiceSign,
	Serial,				InvoiceNo,			InvoiceDate,		PaymentTermID,	DueDate,
	VDescription,		BDescription,		CurrencyID,
	ExchangeRate,		ExchangeRateCN,		CurrencyIDCN,
	OriginalAmount,		OriginalAmountCN,	ConvertedAmount,
	DebitAccountID,		CreditAccountID,
	VATTypeID,			VATGroupID,
	ObjectID,			CreditObjectID,		TDescription,
	Ana01ID,			Ana02ID,			Ana03ID,			Ana04ID,			Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
	CreateDate,			CreateUserID,		LastModifyDate,		LastModifyUserID,
	TableID,			TransactionTypeID,
	OrderID,			DepartmentID
)
SELECT	DT.APK,				DT.Orders,
		DT.VoucherID,		DT.BatchID,				DT.TransactionID,
		DT.DivisionID,		LEFT(DT.Period, 2),		RIGHT(DT.Period, 4),
		DT.VoucherTypeID,	DT.VoucherNo,
		DT.VoucherDate,		DT.EmployeeID,
		DT.InvoiceCode,		DT.InvoiceSign,
		DT.Serial,			DT.InvoiceNo,			DT.InvoiceDate,		DT.PaymentTermID,	RD.DueDate,
		DT.VDescription,	DT.BDescription,		DT.CurrencyID,
		DT.ExchangeRate,	DT.ExchangeRate,		DT.CurrencyID,
		DT.OriginalAmount,	DT.OriginalAmount,		DT.ConvertedAmount,
		DT.DebitAccountID,	DT.CreditAccountID,
		DT.VATTypeID,		DT.VATGroupID,
		DT.ObjectID,		DT.CreditObjectID,		DT.TDescription,
		DT.Ana01ID,			DT.Ana02ID,				DT.Ana03ID,			DT.Ana04ID,		DT.Ana05ID,
		DT.Ana06ID,			DT.Ana07ID,				DT.Ana08ID,			DT.Ana09ID,		DT.Ana10ID,
		GETDATE(),			@UserID,				GETDATE(),			@UserID,
		'AT9000',			'T99'		,
		DT.OrderID,			DepartmentID
FROM	#Data DT LEFT JOIN #ReturnDate RD 
					ON DT.ObjectID=RD.ObjectID
					AND DT.VoucherDate = RD.VoucherDate 
					AND DT.InvoiceDate = RD.InvoiceDate 
					AND DT.PaymentTermID = RD.PaymentTermID 
					AND DT.DivisionID = RD.DivisionID

LB_RESULT:
SELECT * FROM #Data