IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP8126_BS]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8126_BS]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Import Hóa đơn mua hàng có phần nhập kho tự động - Tách phiếu mua hàng và nhập kho nếu khác kho nhập - Bason
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 16/05/2019 by Kim Thư
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
														
CREATE PROCEDURE AP8126_BS
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
		@IsWareHouse AS TINYINT,
		@ExchangeRate AS DECIMAL(28,8),
		@i int, @n int,
		@PaymentDate Datetime, 
		@CurrencyID NVarchar(50), @Method Tinyint

DECLARE @Operator AS INT, @ERDecimal AS INT

CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,
	Orders INT,
	VoucherID NVARCHAR(50) NULL,
	BatchID NVARCHAR(50),
	TransactionID NVARCHAR(50),
	VATTransactionID NVARCHAR(50),
	WHTransactionID NVARCHAR(50),
	IsMultiExR TINYINT,
	Method Tinyint,
	ImportMessage NVARCHAR(500) DEFAULT ('')--,
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT NOT NULL,
	Orders INT,
	VoucherID NVARCHAR(50),
	BatchID NVARCHAR(50),
	TransactionID NVARCHAR(50),
	VATTransactionID NVARCHAR(50),	
	WHTransactionID NVARCHAR(50)--,	
	--CONSTRAINT [PK_#Keys] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
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
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	--PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
--select X.Data.query ('*')  FROM	@XML.nodes('//Data') AS X (Data)
--return
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,
		X.Data.query('VoucherTypeID').value('.', 'NVARCHAR(50)') AS VoucherTypeID,
		X.Data.query('IsWareHouse').value('.', 'TINYINT') AS IsWareHouse,
		X.Data.query('WareHouseVoucherTypeID').value('.', 'NVARCHAR(50)') AS WareHouseVoucherTypeID,		
		X.Data.query('VoucherNo').value('.', 'NVARCHAR(50)') AS VoucherNo,
		X.Data.query('VoucherDate').value('.', 'DATETIME') AS VoucherDate,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,		
		X.Data.query('VDescription').value('.', 'NVARCHAR(250)') AS VDescription,	
		X.Data.query('Serial').value('.', 'NVARCHAR(50)') AS Serial,
		X.Data.query('InvoiceNo').value('.', 'NVARCHAR(50)') AS InvoiceNo,
		X.Data.query('InvoiceDate').value('.', 'NVARCHAR(50)') AS InvoiceDate,
		X.Data.query('VATTypeID').value('.', 'NVARCHAR(50)') AS VATTypeID,
		X.Data.query('DueDate').value('.', 'NVARCHAR(50)') AS DueDate,		
		X.Data.query('CurrencyID').value('.', 'NVARCHAR(50)') AS CurrencyID,
		X.Data.query('ExchangeRate').value('.', 'NVARCHAR(50)') AS ExchangeRate,
		X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID,
		X.Data.query('VATObjectID').value('.', 'NVARCHAR(50)') AS VATObjectID,
		X.Data.query('PaymentTermID').value('.', 'NVARCHAR(50)') AS PaymentTermID,
		X.Data.query('BDescription').value('.', 'NVARCHAR(250)') AS BDescription,
		X.Data.query('GTGTObjectID').value('.', 'NVARCHAR(50)') AS GTGTObjectID,
		X.Data.query('GTGTDebitAccountID').value('.', 'NVARCHAR(50)') AS GTGTDebitAccountID,
		X.Data.query('GTGTCreditAccountID').value('.', 'NVARCHAR(50)') AS GTGTCreditAccountID,
		X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') AS InventoryID,
		X.Data.query('UnitID').value('.', 'NVARCHAR(50)') AS UnitID,
		X.Data.query('Quantity').value('.', 'DECIMAL(28,8)') AS Quantity,
		X.Data.query('UnitPrice').value('.', 'DECIMAL(28,8)') AS UnitPrice,
		X.Data.query('DiscountRate').value('.', 'NVARCHAR(50)') AS DiscountRate,
		X.Data.query('DiscountAmount').value('.', 'NVARCHAR(50)') AS DiscountAmount,
		X.Data.query('OriginalAmount').value('.', 'DECIMAL(28,8)') AS OriginalAmount,
		X.Data.query('ConvertedAmount').value('.', 'NVARCHAR(50)') AS ConvertedAmount,
		X.Data.query('VATGroupID').value('.', 'NVARCHAR(50)') AS VATGroupID,
		X.Data.query('DebitAccountID').value('.', 'NVARCHAR(50)') AS DebitAccountID,
		X.Data.query('CreditAccountID').value('.', 'NVARCHAR(50)') AS CreditAccountID,
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
		X.Data.query('WareHouseImVoucherNo').value('.', 'NVARCHAR(50)') AS WareHouseImVoucherNo,
		X.Data.query('WareHouseImVoucherDate').value('.', 'NVARCHAR(50)') AS WareHouseImVoucherDate,	
		X.Data.query('WareHouseIm').value('.', 'NVARCHAR(50)') AS WareHouseIm,
		X.Data.query('SourceNo').value('.', 'NVARCHAR(50)') AS SourceNo,
		X.Data.query('WHDescription').value('.', 'NVARCHAR(250)') AS WHDescription,
		X.Data.query('WHDebitAccountID').value('.', 'NVARCHAR(50)') AS WHDebitAccountID,
		X.Data.query('WHCreditAccountID').value('.', 'NVARCHAR(50)') AS WHCreditAccountID,
		X.Data.query('PaymentDate').value('.', 'NVARCHAR(50)') AS PaymentDate,
		X.Data.query('IsWithhodingTax').value('.', 'NVARCHAR(10)') AS IsWithhodingTax,
		IDENTITY(int, 1, 1) AS OrderNo
INTO	#AP8126	
FROM	@XML.nodes('//Data') AS X (Data)


INSERT INTO #Data (
		Row,
		Orders,
		DivisionID,
		Period,
		VoucherTypeID,
		IsWareHouse,
		WareHouseVoucherTypeID,
		VoucherNo,
		VoucherDate,
		EmployeeID,
		VDescription,
		Serial,
		InvoiceNo,
		InvoiceDate,
		VATTypeID,
		DueDate,
		CurrencyID,
		ExchangeRate,
		ObjectID,
		VATObjectID,
		PaymentTermID,
		BDescription,
		GTGTObjectID,
		GTGTDebitAccountID,
		GTGTCreditAccountID,
		InventoryID,
		UnitID,
		Quantity,
		UnitPrice,
		DiscountRate,
		DiscountAmount,
		OriginalAmount,
		ConvertedAmount,
		VATGroupID,
		DebitAccountID,
		CreditAccountID,
		TDescription,
		Ana01ID,
		Ana02ID,
		Ana03ID,
		Ana04ID,
		Ana05ID,
		Ana06ID,
		Ana07ID,
		Ana08ID,
		Ana09ID,
		Ana10ID,
		WareHouseImVoucherNo,
		WareHouseImVoucherDate,
		WareHouseIm,
		SourceNo,
		WHDescription,
		WHDebitAccountID,
		WHCreditAccountID,
		PaymentDate,
		IsWithhodingTax
		)
SELECT	Row,
		OrderNo, 
		DivisionID,
		Period,
		VoucherTypeID,
		IsWareHouse,
		WareHouseVoucherTypeID,
		VoucherNo,
		VoucherDate,
		EmployeeID,
		VDescription,
		Serial,
		InvoiceNo,
		--InvoiceDate,
		CASE WHEN ISNULL(InvoiceDate,'') = '' THEN NULL ELSE CAST(InvoiceDate AS DATETIME) END InvoiceDate,
		VATTypeID,
		--DueDate,
		CASE WHEN ISNULL(DueDate,'') = '' THEN NULL ELSE CAST(DueDate AS DATETIME) END DueDate,
		CurrencyID,
		CASE WHEN ISNULL(ExchangeRate,'') = '' THEN NULL ELSE CAST(ExchangeRate AS DECIMAL(28,8)) END ExchangeRate,	
		ObjectID,
		VATObjectID,
		PaymentTermID,
		BDescription,
		GTGTObjectID,
		GTGTDebitAccountID,
		GTGTCreditAccountID,
		InventoryID,
		UnitID,
		Quantity,
		UnitPrice,
		--DiscountRate,
		CASE WHEN ISNULL(DiscountRate,'') = '' THEN NULL ELSE CAST(DiscountRate AS DECIMAL(28,8)) END DiscountRate,	
		--DiscountAmount,
		CASE WHEN ISNULL(DiscountAmount,'') = '' THEN NULL ELSE CAST(DiscountAmount AS DECIMAL(28,8)) END DiscountAmount,	
		OriginalAmount,
		CASE WHEN ISNULL(ConvertedAmount,'') = '' THEN NULL ELSE CAST(ConvertedAmount AS DECIMAL(28,8)) END ConvertedAmount, 
		VATGroupID,
		DebitAccountID,
		CreditAccountID,
		TDescription,
		Ana01ID,
		Ana02ID,
		Ana03ID,
		Ana04ID,
		Ana05ID,
		Ana06ID,
		Ana07ID,
		Ana08ID,
		Ana09ID,
		Ana10ID,
		WareHouseImVoucherNo,
		CASE WHEN ISNULL(WareHouseImVoucherDate,'') = '' THEN NULL ELSE CAST(WareHouseImVoucherDate AS DATETIME) END WareHouseImVoucherDate,
		WareHouseIm,
		SourceNo,
		WHDescription,
		WHDebitAccountID,
		WHCreditAccountID,
		CASE WHEN ISNULL(PaymentDate,'') ='' THEN NULL ELSE CAST(PaymentDate AS DATETIME) END PaymentDate,		
		CASE WHEN ISNULL(IsWithhodingTax,'') ='' THEN NULL ELSE CAST(IsWithhodingTax AS TINYINT) END IsWithhodingTax
FROM #AP8126

UPDATE #Data
SET		#Data.Method = ISNULL(AT1004.Method,0)
FROM #Data INNER JOIN  AT1004 WITH (NOLOCK) ON #Data.CurrencyID = AT1004.CurrencyID

---- Kiểm tra bắt buộc nhập tỷ giá, thành tiền quy đổi nếu loại tiền ko sử dụng pp BQGQ di động
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @ColID = 'ExchangeRate', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 0, @SQLWhere = 'Method = 0'
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @ColID = 'ConvertedAmount', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 0, @SQLWhere = 'Method = 0'


---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidObject', @ColID = 'ObjectID', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 1, @SQLWhere = ''

---- Kiểm tra dữ liệu không đồng nhất tại phần master
IF (SELECT TOP 1 IsWareHouse FROM #Data) = 1
BEGIN
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidAccount', @ColID = 'WHDebitAccountID', @ObligeCheck = 1, @SQLFilter = 'A.GroupID <> ''G00'''
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidAccount', @ColID = 'WHCreditAccountID', @ObligeCheck = 1, @SQLFilter = 'A.GroupID <> ''G00'''
END

EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-T', @ColID = 'VoucherNo', @Param1 = 'VoucherNo,VoucherDate,EmployeeID,VDescription,Serial,InvoiceNo,InvoiceDate,VATTypeID,DueDate,CurrencyID,ObjectID,VATObjectID,PaymentTermID,BDescription,GTGTObjectID,GTGTDebitAccountID,GTGTCreditAccountID,IsWithhodingTax'


---- Xử lý lấy tỷ giá Bán
select @i = 0
select @n = max(Orders) from #Data

while (@i<= @n)
begin
	select	@CurrencyID = CurrencyID,		
			@PaymentDate = CASE WHEN Isnull(PaymentDate,'') = '' THEN VoucherDate ELSE PaymentDate END,
			@Method = Method
	from #Data
	where Orders = @i

	
	SELECT TOP 1 @Operator=Operator, 
				@ERDecimal = ExchangeRateDecimal
	FROM 	AT1004  WITH (NOLOCK)
	WHERE 	CurrencyID = @CurrencyID 				
	AND DivisionID IN (@DivisionID,'@@@')
				

	IF EXISTS (SELECT TOP 1 1 FROM  AT1012 WITH(NOLOCK) WHERE	CurrencyID = @CurrencyID AND DATEDIFF(dd, ExchangeDate, @PaymentDate) >= 0 AND IsDefault = 1)
	BEGIN
			SELECT		TOP 1 @ExchangeRate =  SellingExchangeRate 
			FROM		AT1012 WITH (NOLOCK)
			WHERE		CurrencyID = @CurrencyID
						AND DATEDIFF(dd, ExchangeDate, @PaymentDate) >= 0
						AND DivisionID = @DivisionID
						AND IsDefault = 1
			ORDER BY	DATEDIFF(dd, ExchangeDate, @PaymentDate)

				
	END
	ELSE
	BEGIN
		SELECT		TOP 1 @ExchangeRate = ExchangeRate
		FROM		AT1012 WITH (NOLOCK)
		WHERE		CurrencyID = @CurrencyID
					AND DATEDIFF(dd, ExchangeDate, @PaymentDate) >= 0
					AND DivisionID = @DivisionID
		ORDER BY	DATEDIFF(dd, ExchangeDate, @PaymentDate)

		SET @ExchangeRate = COALESCE(@ExchangeRate, (SELECT ExchangeRate FROM AT1004 WITH (NOLOCK) WHERE CurrencyID = @CurrencyID AND DivisionID IN (@DivisionID,'@@@')), 0)
			
	END

	Update #Data
	set		ExchangeRate = @ExchangeRate,
			ConvertedAmount = CASE WHEN @Operator = 0 THEN OriginalAmount * @ExchangeRate ELSE CASE WHEN @ExchangeRate = 0 THEN 0 ELSE OriginalAmount /@ExchangeRate END END
	where Orders = @i 	and Isnull(ExchangeRate,0) = 0
	
	Set @i = @i + 1
end

--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			Quantity = ROUND(DT.Quantity, A.QuantityDecimals),
			ExchangeRate = ROUND(DT.ExchangeRate, A1.ExchangeRateDecimal),
			OriginalAmount = ROUND(OriginalAmount, A1.ExchangeRateDecimal),
			ConvertedAmount = ROUND(ConvertedAmount, A.ConvertedDecimals),
			UnitPrice = ROUND(DT.UnitPrice, UnitCostDecimals),	
			DiscountRate = ROUND(DiscountRate, 2),
			DiscountAmount = ROUND(DiscountAmount, A1.ExchangeRateDecimal),		
			VoucherDate = CASE WHEN VoucherDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), VoucherDate, 101)) END,
			InvoiceDate = CASE WHEN InvoiceDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), InvoiceDate, 101)) END,
			DueDate = CASE WHEN DueDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), DueDate, 101)) END,
			WareHouseImVoucherDate = CASE WHEN WareHouseImVoucherDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), WareHouseImVoucherDate, 101)) END
FROM		#Data DT
LEFT JOIN	AT1101 A WITH (NOLOCK) ON A.DivisionID = DT.DivisionID
LEFT JOIN	AT1004 A1 WITH (NOLOCK) ON A1.CurrencyID = DT.CurrencyID

			
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT
	
---------->>> Xuất kho
SET @IsWareHouse = (SELECT TOP 1 IsWareHouse FROM #Data WHERE DivisionID = @DivisionID)

-- Sinh khóa
DECLARE @cKeyVoucher AS CURSOR
DECLARE @Row AS INT,
		@Orders AS INT,
		@VoucherNo AS NVARCHAR(50),
		@Period AS NVARCHAR(50),
		@VoucherGroup AS NVARCHAR(50),
		@VATGroupID AS NVARCHAR(50),
		@WareHouseIm AS NVARCHAR(50)
		

DECLARE	@TransID AS NVARCHAR(50),
		@VATTransID AS NVARCHAR(50),
		@WHTransID AS NVARCHAR(50),
		@VoucherID AS NVARCHAR(50),
		@BatchID AS NVARCHAR(50),
		--@CurrencyID AS NVARCHAR(50),
		@ReVoucherID AS NVARCHAR(50),
		@ReTransactionID AS NVARCHAR(50)	

SET @cKeyVoucher = CURSOR FOR
	SELECT	Row, VoucherNo, Period, VATGroupID, WareHouseIm
	FROM	#Data
		
OPEN @cKeyVoucher
FETCH NEXT FROM @cKeyVoucher INTO @Row, @VoucherNo, @Period, @VATGroupID, @WareHouseIm
WHILE @@FETCH_STATUS = 0
BEGIN
	
	SET @Period = RIGHT(@Period, 4)
	IF @VoucherGroup IS NULL OR @VoucherGroup <> (@VoucherNo + '#' + @Period + '#' + @WareHouseIm)
	BEGIN
		---------->> Hóa đơn bán hàng VoucherID
		SET @Orders = 0
		--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @VoucherID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AV', @StringKey2 = @Period, @OutputLen = 16
		SET @VoucherID = NEWID()
		
		------------>> Xuất kho VoucherID
		--IF ISNULL(@IsWareHouse,0) <> 0
		--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @WHVoucherID OUTPUT, @TableName = 'AT2006', @StringKey1 = 'AD', @StringKey2 = @Period, @OutputLen = 16
		
		SET @VoucherGroup = (@VoucherNo + '#' + @Period + '#' + @WareHouseIm)
	END
	SET @Orders = @Orders + 1
	--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @TransID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AT', @StringKey2 = @Period, @OutputLen = 16
	SET @TransID = NEWID()
	IF ISNULL(@IsWareHouse,0) <> 0
	--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @WHTransID OUTPUT, @TableName = 'AT2007', @StringKey1 = 'BD', @StringKey2 = @Period, @OutputLen = 16
	SET @WHTransID = NEWID()
	IF ISNULL(@VATGroupID,'') <> ''
	--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @VATTransID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AT', @StringKey2 = @Period, @OutputLen = 16
	SET @VATTransID = NEWID()
	
	--IF @VoucherWHGroup IS NULL OR @VoucherWHGroup <> (@WareHouseImVoucherNo+'#'+@WareHouseIm)
	--BEGIN
	--	SET @VoucherWHID = NEWID()
	--	SET @WareHouseImVoucherNo = @WareHouseImVoucherNo+'#'+@WareHouseIm
	--	SET @VoucherWHGroup = (@WareHouseImVoucherNo+'#'+@WareHouseIm)
	--END

	INSERT INTO #Keys (Row, Orders, VoucherID, TransactionID, VATTransactionID, WHTransactionID) 
	VALUES (@Row, @Orders, @VoucherID, @TransID, @VATTransID, @WHTransID)				
	FETCH NEXT FROM @cKeyVoucher INTO @Row, @VoucherNo, @Period, @VATGroupID, @WareHouseIm

END	
CLOSE @cKeyVoucher

-- Cập nhật khóa
UPDATE		DT
SET			Orders = K.Orders,
			DT.VoucherID = K.VoucherID ,
			--DT.BatchID = K.VoucherID ,
			DT.TransactionID = K.TransactionID,
			DT.VATTransactionID = K.VATTransactionID,
			DT.WHTransactionID =  K.WHTransactionID		
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


DECLARE	@cKeyBatchID AS CURSOR	
--- Sinh BatchID
Select @VoucherID = '', @ExchangeRate = 1,  @BatchID = ''

SET @cKeyBatchID = CURSOR FOR
	SELECT	distinct VoucherID, ExchangeRate
	FROM	#Data
		
OPEN @cKeyBatchID
FETCH NEXT FROM @cKeyBatchID INTO  @VoucherID, @ExchangeRate
WHILE @@FETCH_STATUS = 0
BEGIN
	--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @BatchID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'TB', @StringKey2 = @Period, @OutputLen = 16
	SET @BatchID = NEWID()
	Update #Data
	set		BatchID = @BatchID
	Where	VoucherID = @VoucherID AND ExchangeRate = @ExchangeRate
FETCH NEXT FROM @cKeyBatchID INTO @VoucherID, @ExchangeRate

END	
CLOSE @cKeyBatchID
				
-- Kiểm tra trùng số chứng từ
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateOtherVoucherNo', @ColID = 'VoucherNo', @Param2 = 'AT9000', @Param3 = 'VoucherNo'

-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

--- Cập nhật giá trị trường IsMultiExR (nhiều tỷ giá)
UPDATE #Data
SET		#Data.IsMultiExR = 1
WHERE #Data.VoucherID in (Select VoucherID from (select distinct VoucherID, ExchangeRate from #Data ) T group by VoucherID having Count(1) >= 2 )

-------->>> Phần Hóa đơn mua hàng đẩy vào bảng AT9000
INSERT INTO AT9000
(
	DivisionID,	VoucherID,		BatchID,		TransactionID,	TableID,
	TranMonth,	TranYear,		TransactionTypeID,
	CurrencyID,	ObjectID,		CreditObjectID,
	VATNo,		VATObjectID,	VATObjectName,	VATObjectAddress,
	DebitAccountID,		CreditAccountID,	
	ExchangeRate,		UnitPrice,
	OriginalAmount,		ConvertedAmount,	
	IsMultiTax,
	VATOriginalAmount,	VATConvertedAmount,
	IsStock,		VoucherDate,	InvoiceDate,	VoucherTypeID,	VATTypeID,	VATGroupID,
	VoucherNo,		Serial,			InvoiceNo,	
	Orders,			EmployeeID,		SenderReceiver,	SRDivisionName,	SRAddress,
	VDescription,	BDescription,	TDescription,
	Quantity,		InventoryID,	UnitID,	
	[Status],		IsAudit,		IsCost,	
	Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
	CreateDate,		CreateUserID,			LastModifyDate,		LastModifyUserID,
	OriginalAmountCN,						ExchangeRateCN,		CurrencyIDCN,
	DueDays,		PaymentID,				DueDate,	
	DiscountRate,	DiscountAmount,
	OrderID,		CreditBankAccountID,	DebitBankAccountID,
	PaymentTermID,	ConvertedQuantity,		ConvertedPrice,		ConvertedUnitID, 
	InventoryName1,		ExchangeRateDate,	IsMultiExR,	 IsWithhodingTax, WOrderID
)
SELECT	D.DivisionID,		D.VoucherID,		D.BatchID,		D.TransactionID,	'AT9000',
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),	'T03',
		D.CurrencyID,		D.ObjectID,			D.ObjectID,
		A.VATNo,			D.VATObjectID,		A.ObjectName,	A.[Address],
		D.DebitAccountID,	D.CreditAccountID,	D.ExchangeRate,	D.UnitPrice,
		D.OriginalAmount,	D.ConvertedAmount,
		1,
		A1.VATRate/100*D.OriginalAmount,
		ROUND((A1.VATRate/100*D.ConvertedAmount ),ISNULL(A2.ConvertedDecimals,0)) ,
		0,		D.VoucherDate,	D.InvoiceDate,	D.VoucherTypeID,	D.VATTypeID,	D.VATGroupID,
		D.VoucherNo,	D.Serial,		D.InvoiceNo,	
		D.Orders,		D.EmployeeID,	A.ObjectName,	A.ObjectName,	A.Address,
		D.VDescription,	D.BDescription,	D.TDescription,
		D.Quantity,		D.InventoryID,	D.UnitID,		
		0,		0,		0,	
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,D.Ana06ID,D.Ana07ID,D.Ana08ID,D.Ana09ID,D.Ana10ID,
		GETDATE(),	@UserID,	GETDATE(),	@UserID,
		D.OriginalAmount,	D.ExchangeRate,	D.CurrencyID,
		NULL,				NULL,			D.DueDate,	
		D.DiscountRate,		D.DiscountAmount,
		NULL,				NULL,			NULL,
		D.PaymentTermID,	D.Quantity,		D.UnitPrice,	D.UnitID,
		InventoryName, ISNULL(D.PaymentDate,D.VoucherDate),	D.IsMultiExR,	 D.IsWithhodingTax, D.VoucherID
		
FROM	#Data D
LEFT JOIN AT1202 A WITH (NOLOCK) ON A.DivisionID IN (@DivisionID, '@@@') AND A.ObjectID = D.VATObjectID
LEFT JOIN AT1010 A1 WITH (NOLOCK) ON A1.VATGroupID = D.VATGroupID
LEFT JOIN AT1101 A2 WITH (NOLOCK) ON A2.DivisionID = D.DivisionID 
LEFT JOIN AT1302 A1302 WITH (NOLOCK) ON A1302.DivisionID IN (D.DivisionID,'@@@') AND A1302.InventoryID = D.InventoryID

---------->>> Bút toán thuế
IF ISNULL(@VATGroupID, '') <> ''
INSERT INTO AT9000
(
	DivisionID,	VoucherID,		BatchID,		TransactionID,	TableID,
	TranMonth,	TranYear,		TransactionTypeID,
	CurrencyID,	ObjectID,		CreditObjectID,
	VATNo,		VATObjectID,	VATObjectName,	VATObjectAddress,
	DebitAccountID,		CreditAccountID,	
	ExchangeRate,		UnitPrice,
	OriginalAmount,		ConvertedAmount,	
	VATOriginalAmount,	VATConvertedAmount,
	IsStock,		VoucherDate,	InvoiceDate,	VoucherTypeID,	VATTypeID,	VATGroupID,
	VoucherNo,		Serial,			InvoiceNo,	
	Orders,			EmployeeID,		SenderReceiver,	SRDivisionName,	SRAddress,
	VDescription,	BDescription,	TDescription,
	Quantity,		InventoryID,	UnitID,	
	[Status],		IsAudit,		IsCost,	
	Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
	CreateDate,		CreateUserID,			LastModifyDate,		LastModifyUserID,
	OriginalAmountCN,						ExchangeRateCN,		CurrencyIDCN,
	DueDays,		PaymentID,				DueDate,	
	DiscountRate,	DiscountAmount,
	OrderID,		CreditBankAccountID,	DebitBankAccountID,
	PaymentTermID,	ConvertedQuantity,		ConvertedPrice,		ConvertedUnitID,
	ExchangeRateDate,	IsMultiExR,	 IsWithhodingTax, WOrderID
)
SELECT	D.DivisionID,		D.VoucherID,		D.BatchID,		D.VATTransactionID,	'AT9000',
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),	'T13',
		D.CurrencyID,		ISNULL(D.GTGTObjectID,D.ObjectID),	ISNULL(D.GTGTObjectID,D.ObjectID),
		A.VATNo,			D.VATObjectID,		A.ObjectName,	A.[Address],
		D.GTGTDebitAccountID,	D.GTGTCreditAccountID,	D.ExchangeRate,	NULL,
		A1.VATRate/100*D.OriginalAmount,
		ROUND((A1.VATRate/100*D.ConvertedAmount ),ISNULL(A2.ConvertedDecimals,0)) ,
		NULL, NULL,
		0,		D.VoucherDate,	D.InvoiceDate,	D.VoucherTypeID,	D.VATTypeID,	D.VATGroupID,
		D.VoucherNo,	D.Serial,		D.InvoiceNo,	
		D.Orders,		D.EmployeeID,	A.ObjectName,	A.ObjectName,	A.Address,
		D.VDescription,	D.BDescription,	D.TDescription,
		NULL,			NULL,			NULL,		
		0,		0,		0,	
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
		GETDATE(),	@UserID,	GETDATE(),	@UserID,
		A1.VATRate*(D.OriginalAmount - ISNULL(D.DiscountAmount, 0))/100,	
		D.ExchangeRate,		D.CurrencyID,
		NULL,				NULL,			D.DueDate,	
		NULL,				NULL,
		NULL,				NULL,			NULL,
		D.PaymentTermID,	NULL,			NULL,	NULL,
		ISNULL(D.PaymentDate,D.VoucherDate),	D.IsMultiExR,	 D.IsWithhodingTax, D.VoucherID
		
FROM	#Data D
LEFT JOIN AT1202 A WITH (NOLOCK) ON A.DivisionID IN (@DivisionID, '@@@') AND A.ObjectID = D.VATObjectID
LEFT JOIN AT1010 A1 WITH (NOLOCK) ON A1.VATGroupID = D.VATGroupID
LEFT JOIN AT1101 A2 WITH (NOLOCK) ON A2.DivisionID = D.DivisionID -- AND A2.BaseCurrencyID = D.CurrencyID


--------->>>> Nhập kho

IF ISNULL(@IsWareHouse, 0) <> 0
BEGIN
	
-- Đẩy dữ liệu vào bảng master
INSERT INTO AT2006
(
	DivisionID,		VoucherID,		TableID,	TranMonth,	TranYear,
	VoucherTypeID,	VoucherDate,	
	VoucherNo,		ObjectID,		InventoryTypeID,
	WareHouseID,	KindVoucherID,	[Status],	EmployeeID,	[Description],
	RefNo01,		RefNo02,		
	CreateDate,		CreateUserID,	LastModifyUserID,	LastModifyDate
	
)
SELECT	DISTINCT
		DivisionID,		VoucherID,		'AT2006',	LEFT(Period, 2),RIGHT(Period, 4),
		WareHouseVoucherTypeID,		WareHouseImVoucherDate,	
		WareHouseImVoucherNo,		ObjectID,			'%'	,		
		WareHouseIm,	5,			0,				EmployeeID,		WHDescription,
		VoucherNo,		InvoiceNo+'/'+Serial,		
		GETDATE(),		@UserID,		@UserID,	GETDATE()
FROM	#Data


INSERT INTO AT2007
(
	Orders,
	DivisionID,		TransactionID,	VoucherID,	
	TranMonth,		TranYear,		CurrencyID,		ExchangeRate,
	InventoryID,	UnitID,			SourceNo,
	ConvertedQuantity,				ConvertedPrice,
	ActualQuantity,	UnitPrice,		
	OriginalAmount,	ConvertedAmount,
	DebitAccountID,	CreditAccountID,						
	Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
	ConversionFactor

)
SELECT	D.Orders,
		D.DivisionID,		D.WHTransactionID,		D.VoucherID,	
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),		D.CurrencyID,		D.ExchangeRate,
		D.InventoryID,		D.UnitID,				D.SourceNo,
		D.Quantity,			D.UnitPrice,
		D.Quantity,			D.UnitPrice,			
		D.OriginalAmount,	D.ConvertedAmount,
		D.WHDebitAccountID,	D.WHCreditAccountID,		
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,
		1

FROM	#Data D

--- Cập nhật trạng thái nhập kho
UPDATE T1
SET IsStock = 1
FROM AT9000 T1 INNER JOIN #Data T2 ON T1.VoucherID = T2.VoucherID
WHERE T1.DivisionID = @DivisionID
      
END


LB_RESULT:
SELECT * FROM #Data


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
