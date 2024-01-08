IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8170]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8170]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Import Hàng bán trả lại có phần nhập kho.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 16/08/2023 by Đình Định
-- <Example>																			  


CREATE PROCEDURE AP8170
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS 

DECLARE @cCURSOR CURSOR,
		@sSQL VARCHAR(1000),
		@ColID NVARCHAR(50), 
		@ColSQLDataType NVARCHAR(50),
		@IsWareHouse TINYINT	,
		@ExchangeRate DECIMAL(28,8),
		@i INT, @n INT,
		@PaymentDate Datetime, 
		@CurrencyID NVARCHAR(50), @Method TINYINT,
		@SQL NVARCHAR(1000),
		@Operator AS INT,
		@PK_#Data NVARCHAR(500),		
	    @PK_#Keys NVARCHAR(500)		

SET @PK_#Data = 'PK_#Data_'+Ltrim(@@SPID)
SET @PK_#Keys = 'PK_#Keys_'+Ltrim(@@SPID)

CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,
	Orders INT,
	VoucherID NVARCHAR(50) NULL,
	BatchID NVARCHAR(50),
	TransactionID NVARCHAR(50),
	VATTransactionID NVARCHAR(50),
	WHVoucherID NVARCHAR(50),
	WHTransactionID NVARCHAR(50),
	IsMultiExR TINYINT,
	Method TINYINT,
	ImportMessage NVARCHAR(500) DEFAULT ('')
)

CREATE TABLE #Keys
(
	[Row] INT NOT NULL,
	Orders INT,
	VoucherID NVARCHAR(50),
	BatchID NVARCHAR(50),
	TransactionID NVARCHAR(50),
	VATTransactionID NVARCHAR(50),	
	WHVoucherID NVARCHAR(50),
	WHTransactionID NVARCHAR(50)	
)

--add constraint 
SET @SQL = 'ALTER TABLE #Data ADD CONSTRAINT ' + @PK_#Data+ ' PRIMARY KEY(Row)
			ALTER TABLE #Keys ADD CONSTRAINT ' + @PK_#Keys+ ' PRIMARY KEY(Row)'

EXEC(@SQL)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT TLD.ColID, BTL.ColSQLDataType
	  FROM A01065 TL WITH (NOLOCK)
	 INNER JOIN	A01066 TLD WITH (NOLOCK) ON	TL.ImportTemplateID = TLD.ImportTemplateID
	 INNER JOIN	A00065 BTL WITH (NOLOCK) ON	BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
	 WHERE TL.ImportTemplateID = @ImportTemplateID
     ORDER BY TLD.OrderNum
	 print ('111111111111111111111111111111111111111')

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
		X.Data.query('IsWareHouse').value('.', 'TINYINT') AS IsWareHouse,
		X.Data.query('WareHouseVoucherTypeID').value('.', 'NVARCHAR(50)') AS WareHouseVoucherTypeID,		
		X.Data.query('VoucherNo').value('.', 'NVARCHAR(50)') AS VoucherNo,
		X.Data.query('VoucherDate').value('.', 'DATETIME') AS VoucherDate,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,		
		X.Data.query('VDescription').value('.', 'NVARCHAR(250)') AS VDescription,	
		X.Data.query('InvoiceCode').value('.', 'NVARCHAR(50)') AS InvoiceCode,
		X.Data.query('InvoiceSign').value('.', 'NVARCHAR(50)') AS InvoiceSign,
		X.Data.query('Serial').value('.', 'NVARCHAR(50)') AS Serial,
		X.Data.query('InvoiceNo').value('.', 'NVARCHAR(50)') AS InvoiceNo,
		X.Data.query('InvoiceDate').value('.', 'NVARCHAR(50)') AS InvoiceDate,
		X.Data.query('VATTypeID').value('.', 'NVARCHAR(50)') AS VATTypeID,
		X.Data.query('DueDate').value('.', 'NVARCHAR(50)') AS DueDate,		
		X.Data.query('CurrencyID').value('.', 'NVARCHAR(50)') AS CurrencyID,
		X.Data.query('ExchangeRate').value('.', 'NVARCHAR(50)') AS ExchangeRate,
		X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID,
		X.Data.query('IsMultiTax').value('.', 'TINYINT') AS IsMultiTax,
		X.Data.query('VATObjectID').value('.', 'NVARCHAR(50)') AS VATObjectID,
		X.Data.query('PaymentTermID').value('.', 'NVARCHAR(50)') AS PaymentTermID,
		X.Data.query('PaymentID').value('.', 'NVARCHAR(50)') AS PaymentID,
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
		X.Data.query('WareHouseEx').value('.', 'NVARCHAR(50)') AS WareHouseEx,
		X.Data.query('SourceNo').value('.', 'NVARCHAR(50)') AS SourceNo,
		X.Data.query('InventoryTypeID').value('.', 'NVARCHAR(250)') AS InventoryTypeID,
		X.Data.query('WHDescription').value('.', 'NVARCHAR(250)') AS WHDescription,
		X.Data.query('WHDebitAccountID').value('.', 'NVARCHAR(50)') AS WHDebitAccountID,
		X.Data.query('WHCreditAccountID').value('.', 'NVARCHAR(50)') AS WHCreditAccountID,
		X.Data.query('PaymentDate').value('.', 'NVARCHAR(50)') AS PaymentDate,
		IDENTITY(int, 1, 1) AS OrderNo,
		(CASE WHEN X.Data.query('S01ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S01ID').value('.', 'NVARCHAR(50)') END) AS S01ID,
		(CASE WHEN X.Data.query('S02ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S02ID').value('.', 'NVARCHAR(50)') END) AS S02ID,
		(CASE WHEN X.Data.query('S03ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S03ID').value('.', 'NVARCHAR(50)') END) AS S03ID,
		(CASE WHEN X.Data.query('S04ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S04ID').value('.', 'NVARCHAR(50)') END) AS S04ID,
		(CASE WHEN X.Data.query('S05ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S05ID').value('.', 'NVARCHAR(50)') END) AS S05ID,
		(CASE WHEN X.Data.query('S06ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S06ID').value('.', 'NVARCHAR(50)') END) AS S06ID,
		(CASE WHEN X.Data.query('S07ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S07ID').value('.', 'NVARCHAR(50)') END) AS S07ID,
		(CASE WHEN X.Data.query('S08ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S08ID').value('.', 'NVARCHAR(50)') END) AS S08ID,
		(CASE WHEN X.Data.query('S09ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S09ID').value('.', 'NVARCHAR(50)') END) AS S09ID,
		(CASE WHEN X.Data.query('S10ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S10ID').value('.', 'NVARCHAR(50)') END) AS S10ID,
		(CASE WHEN X.Data.query('S11ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S11ID').value('.', 'NVARCHAR(50)') END) AS S11ID,
		(CASE WHEN X.Data.query('S12ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S12ID').value('.', 'NVARCHAR(50)') END) AS S12ID,
		(CASE WHEN X.Data.query('S13ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S13ID').value('.', 'NVARCHAR(50)') END) AS S13ID,
		(CASE WHEN X.Data.query('S14ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S14ID').value('.', 'NVARCHAR(50)') END) AS S14ID,
		(CASE WHEN X.Data.query('S15ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S15ID').value('.', 'NVARCHAR(50)') END) AS S15ID,
		(CASE WHEN X.Data.query('S16ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S16ID').value('.', 'NVARCHAR(50)') END) AS S16ID,
		(CASE WHEN X.Data.query('S17ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S17ID').value('.', 'NVARCHAR(50)') END) AS S17ID,
		(CASE WHEN X.Data.query('S18ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S18ID').value('.', 'NVARCHAR(50)') END) AS S18ID,
		(CASE WHEN X.Data.query('S19ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S19ID').value('.', 'NVARCHAR(50)') END) AS S19ID,
		(CASE WHEN X.Data.query('S20ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('S20ID').value('.', 'NVARCHAR(50)') END) AS S20ID
INTO	#AP8170	
FROM	@XML.nodes('//Data') AS X (Data)
	 print ('222222222222222222222222222')

INSERT INTO #Data (
		[Row], Orders, DivisionID,
		[Period],VoucherTypeID,
		IsWareHouse,WareHouseVoucherTypeID,
		VoucherNo,VoucherDate,
		EmployeeID,	VDescription,
		InvoiceCode,InvoiceSign,
		Serial,InvoiceNo,
		InvoiceDate,VATTypeID,
		DueDate,CurrencyID,
		ExchangeRate,ObjectID,
		IsMultiTax,VATObjectID,
		PaymentTermID,PaymentID,
		BDescription,GTGTObjectID,
		GTGTDebitAccountID,
		GTGTCreditAccountID,
		InventoryID,
		UnitID,Quantity,
		UnitPrice,DiscountRate,
		DiscountAmount,
		OriginalAmount,
		ConvertedAmount,
		VATGroupID,
		DebitAccountID,
		CreditAccountID,
		TDescription,
		Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,
		Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
		WareHouseImVoucherNo,
		WareHouseImVoucherDate,
		WareHouseEx,SourceNo,
		InventoryTypeID,
		WHDescription,WHDebitAccountID,
		WHCreditAccountID,PaymentDate,
		S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,S10ID,
		S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID
		)
SELECT [Row],OrderNo,
		DivisionID,[Period],
		VoucherTypeID,IsWareHouse,
		WareHouseVoucherTypeID,
		VoucherNo,VoucherDate,
		EmployeeID,VDescription,
		InvoiceCode,InvoiceSign,
		Serial,InvoiceNo,
		CASE WHEN ISNULL(InvoiceDate,'') = '' THEN NULL ELSE CAST(InvoiceDate AS DATETIME) END InvoiceDate,
		VATTypeID,
		CASE WHEN ISNULL(DueDate,'') = '' THEN NULL ELSE CAST(DueDate AS DATETIME) END DueDate,
		CurrencyID,
		CASE WHEN ISNULL(ExchangeRate,'') = '' THEN NULL ELSE CAST(ExchangeRate AS DECIMAL(28,8)) END ExchangeRate,
		ObjectID,IsMultiTax,
		VATObjectID,PaymentTermID,
		PaymentID,BDescription,
		GTGTObjectID,GTGTDebitAccountID,
		GTGTCreditAccountID,
		InventoryID,UnitID,
		Quantity,UnitPrice,
		CASE WHEN ISNULL(DiscountRate,'') = '' THEN NULL ELSE CAST(DiscountRate AS DECIMAL(28,8)) END DiscountRate,	
		CASE WHEN ISNULL(DiscountAmount,'') = '' THEN NULL ELSE CAST(DiscountAmount AS DECIMAL(28,8)) END DiscountAmount,	
		OriginalAmount,
		CASE WHEN ISNULL(ConvertedAmount,'') = '' THEN NULL ELSE CAST(ConvertedAmount AS DECIMAL(28,8)) END ConvertedAmount, 
		VATGroupID,
		DebitAccountID,
		CreditAccountID,
		TDescription,
		Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,
		Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
		WareHouseImVoucherNo,
		CASE WHEN ISNULL(WareHouseImVoucherDate,'') = '' THEN NULL ELSE CAST(WareHouseImVoucherDate AS DATETIME) END WareHouseImVoucherDate,
		WareHouseEx,SourceNo,
		InventoryTypeID,WHDescription,
		WHDebitAccountID,WHCreditAccountID,
		CASE WHEN ISNULL(PaymentDate,'') ='' THEN NULL ELSE CAST(PaymentDate AS DATETIME) END PaymentDate,
		S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,S10ID,S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID
   FROM #AP8170

UPDATE #Data
   SET #Data.Method = ISNULL(AT1004.Method,0)
  FROM #Data INNER JOIN AT1004 WITH (NOLOCK) ON #Data.CurrencyID = AT1004.CurrencyID

  select * from #Data

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidObject', @ColID = 'ObjectID', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 1, @SQLWhere = ''
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidObject', @ColID = 'VATObjectID', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 1, @SQLWhere = ' ISNULL(DT.VATObjectID,'''')<>'''' '
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidObject', @ColID = 'GTGTObjectID', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 1, @SQLWhere = ' ISNULL(DT.GTGTObjectID,'''')<>'''' '

---- Kiểm tra bắt buộc nhập tỷ giá, thành tiền quy đổi nếu loại tiền ko sử dụng pp BQGQ di động
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @ColID = 'ExchangeRate', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 0, @SQLWhere = 'Method = 0'
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @ColID = 'ConvertedAmount', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 0, @SQLWhere = 'Method = 0'


---- Kiểm tra dữ liệu không đồng nhất tại phần master
IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE IsWareHouse = 1) 
BEGIN
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidAccount', @ColID = 'WHDebitAccountID', @ObligeCheck = 1, @SQLFilter = 'A.GroupID <> ''G00'''
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidAccount', @ColID = 'WHCreditAccountID', @ObligeCheck = 1, @SQLFilter = 'A.GroupID <> ''G00'''
END
ELSE 
BEGIN
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidAccount', @ColID = 'WHDebitAccountID', @ObligeCheck = 0, @SQLFilter = 'A.GroupID <> ''G00'''
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidAccount', @ColID = 'WHCreditAccountID', @ObligeCheck = 0, @SQLFilter = 'A.GroupID <> ''G00'''
END
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-T', @ColID = 'VoucherNo', @Param1 = 'VoucherNo,VoucherDate,EmployeeID,VDescription,InvoiceCode,InvoiceSign,Serial,InvoiceNo,InvoiceDate,VATTypeID,DueDate,CurrencyID,ObjectID,IsMultiTax,VATObjectID,PaymentTermID,PaymentID,BDescription,GTGTObjectID,GTGTDebitAccountID,GTGTCreditAccountID,WareHouseImVoucherNo,WareHouseImVoucherDate,WareHouseEx,InventoryTypeID,WHDescription'

---- Xử lý lấy tỷ giá Mua
SELECT @i = 0
SELECT @n = MAX(Orders) FROM #Data

WHILE (@i<= @n)
BEGIN
	SELECT @CurrencyID = CurrencyID,		
		   @PaymentDate = CASE WHEN ISNULL(PaymentDate,'') = '' THEN VoucherDate ELSE PaymentDate END,
		   @Method = Method
	  FROM #Data
	 WHERE Orders = @i

	SELECT TOP 1 @Operator=Operator
	  FROM AT1004 WITH(NOLOCK)
	 WHERE CurrencyID = @CurrencyID 				

	IF EXISTS (SELECT TOP 1 1 FROM  AT1012 WITH(NOLOCK) WHERE CurrencyID = @CurrencyID AND DATEDIFF(dd, ExchangeDate, @PaymentDate) >= 0 AND IsDefault = 1)
	BEGIN
		SELECT TOP 1 @ExchangeRate =  BuyingExchangeRate 
		  FROM AT1012 WITH (NOLOCK)
		 WHERE CurrencyID = @CurrencyID
		   AND DATEDIFF(dd, ExchangeDate, @PaymentDate) >= 0
		   AND DivisionID = @DivisionID
		   AND IsDefault = 1
		 ORDER BY	DATEDIFF(dd, ExchangeDate, @PaymentDate)
	END
	ELSE
	BEGIN
		SELECT TOP 1 @ExchangeRate = ExchangeRate
		  FROM AT1012 WITH (NOLOCK)
		 WHERE CurrencyID = @CurrencyID
		   AND DATEDIFF(dd, ExchangeDate, @PaymentDate) >= 0
		   AND DivisionID = @DivisionID
		 ORDER BY DATEDIFF(dd, ExchangeDate, @PaymentDate)

	SET @ExchangeRate = COALESCE(@ExchangeRate, (SELECT ExchangeRate FROM AT1004 WITH (NOLOCK) WHERE CurrencyID = @CurrencyID AND DivisionID IN (@DivisionID, '@@@')), 0)
			
	END

	UPDATE #Data
	   SET ExchangeRate = @ExchangeRate,
		   ConvertedAmount = CASE WHEN @Operator = 0 THEN OriginalAmount * @ExchangeRate ELSE CASE WHEN @ExchangeRate = 0 THEN 0 ELSE OriginalAmount /@ExchangeRate END END
	 WHERE Orders = @i AND Isnull(ExchangeRate,0) = 0
	
	SET @i = @i + 1
END


BEGIN
--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			Quantity = ROUND(DT.Quantity, A.QuantityDecimals),
			ExchangeRate = ROUND(DT.ExchangeRate, A1.ExchangeRateDecimal),
			OriginalAmount = ROUND(OriginalAmount, A1.ExchangeRateDecimal),
			ConvertedAmount = ROUND(ConvertedAmount, A.ConvertedDecimals),
			UnitPrice = ROUND(DT.UnitPrice, A.UnitCostDecimals),	
			DiscountRate = ROUND(DiscountRate, 2),
			DiscountAmount = ROUND(DiscountAmount, A1.ExchangeRateDecimal),
			VoucherDate = CASE WHEN VoucherDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), VoucherDate, 101)) END,
			InvoiceDate = CASE WHEN InvoiceDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), InvoiceDate, 101)) END,
			DueDate = CASE WHEN DueDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), DueDate, 101)) END,
			WareHouseImVoucherDate = CASE WHEN WareHouseImVoucherDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), WareHouseImVoucherDate, 101)) END
FROM		#Data DT
LEFT JOIN	AT1101 A WITH (NOLOCK) ON A.DivisionID = DT.DivisionID
LEFT JOIN	AT1004 A1 WITH (NOLOCK) ON A1.CurrencyID = DT.CurrencyID
END

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT
	
---------->>> Xuất kho
SET @IsWareHouse = (SELECT TOP 1 IsWareHouse FROM #Data WHERE DivisionID = @DivisionID)

-- Sinh khóa
DECLARE @cKey AS CURSOR,
		@Row AS INT,
		@Orders AS INT,
		@VoucherNo AS NVARCHAR(50),
		@Period AS NVARCHAR(50),
		@VoucherGroup AS NVARCHAR(50),
		@VATGroupID AS NVARCHAR(50),
		@TransID AS NVARCHAR(50),
		@VATTransID AS NVARCHAR(50),
		@WHTransID AS NVARCHAR(50),
		@VoucherID AS NVARCHAR(50),
		@WHVoucherID AS NVARCHAR(50),
		@BatchID AS NVARCHAR(50),
		@ReVoucherID AS NVARCHAR(50)	

SET @cKey = CURSOR FOR
	SELECT [Row], VoucherNo, [Period], VATGroupID
	  FROM #Data
		
OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row, @VoucherNo, @Period, @VATGroupID
WHILE @@FETCH_STATUS = 0
BEGIN
	
	SET @Period = RIGHT(@Period, 4)
	IF @VoucherGroup IS NULL OR @VoucherGroup <> (@VoucherNo + '#' + @Period)
	BEGIN
		---------->> Hóa đơn bán hàng VoucherID
		SET @Orders = 0
		EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @VoucherID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AV', @StringKey2 = @Period, @OutputLen = 16
		
		---------->> Xuất kho VoucherID
		IF ISNULL(@IsWareHouse,0) <> 0
			SET @WHVoucherID = @VoucherID
		SET @VoucherGroup = (@VoucherNo + '#' + @Period)
	END
	SET @Orders = @Orders + 1
	SET @TransID = NEWID()
	IF ISNULL(@IsWareHouse,0) <> 0
		SET @WHTransID = @TransID
	
	IF ISNULL(@VATGroupID,'') <> ''
		SET @VATTransID = NEWID()
	ELSE
		SET @VATTransID = NULL

	INSERT INTO #Keys ([Row], Orders, VoucherID, TransactionID, VATTransactionID, WHVoucherID, WHTransactionID) 
	VALUES (@Row, @Orders, @VoucherID, @TransID, @VATTransID, @WHVoucherID, @WHTransID)				
	FETCH NEXT FROM @cKey INTO @Row, @VoucherNo, @Period, @VATGroupID

END	
CLOSE @cKey

-- Cập nhật khóa
UPDATE		DT
SET			Orders = K.Orders,
			DT.VoucherID = K.VoucherID ,
			--DT.BatchID = K.VoucherID ,
			DT.TransactionID = K.TransactionID,
			DT.VATTransactionID = K.VATTransactionID,
			DT.WHVoucherID =  K.WHVoucherID,
			DT.WHTransactionID =  K.WHTransactionID		
FROM		#Data DT
INNER JOIN	#Keys K	ON	K.Row = DT.Row

DECLARE	@cKeyBatchID AS CURSOR	
--- Sinh BatchID
SELECT @VoucherID = '', @ExchangeRate = 1,  @BatchID = ''

	SET @cKeyBatchID = CURSOR FOR

SELECT DISTINCT VoucherID, ExchangeRate
  FROM #Data
		
OPEN @cKeyBatchID
FETCH NEXT FROM @cKeyBatchID INTO  @VoucherID, @ExchangeRate
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @BatchID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AB', @StringKey2 = @Period, @OutputLen = 16
	
	UPDATE #Data
	   SET BatchID = @BatchID
	 WHERE VoucherID = @VoucherID AND ExchangeRate = @ExchangeRate
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
   SET #Data.IsMultiExR = 1
 WHERE #Data.VoucherID in (SELECT VoucherID FROM (SELECT DISTINCT VoucherID, ExchangeRate FROM #Data ) T GROUP BY VoucherID HAVING Count(1) >= 2 )
				
-- Kiểm tra trùng số chứng từ
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateOtherVoucherNo', @ColID = 'VoucherNo', @Param2 = 'AT9000', @Param3 = 'VoucherNo'

------Kiểm tra check 1 nhóm thuế nhưng nhóm thuế không đồng nhất

DECLARE @VAT VARCHAR(250),
		@DifObject VARCHAR(250)
 
   SELECT TOP 1 @VAT = VoucherNo
     FROM #Data
    WHERE DivisionID = @DivisionID AND IsMultiTax = 0 
    GROUP BY VoucherNo
   HAVING COUNT(DISTINCT VATGroupID) != 1

   PRINT (@VAT)


   UPDATE A
   SET ImportMessage = ImportMessage + CASE WHEN ImportMessage != '' THEN '\n' ELSE '' END + 'AFML000543 {0}='''+CONVERT(VARCHAR,Row)+''''
   FROM #Data A
   WHERE A.DivisionID = @DivisionID AND A.VoucherNo = @VAT


-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

-------->>> Phần Hàng bán trả lại đẩy vào bảng AT9000
INSERT INTO AT9000
(
	DivisionID,	 VoucherID,		BatchID,		TransactionID,	TableID,
	TranMonth,	TranYear,		TransactionTypeID,
	CurrencyID,	ObjectID,		CreditObjectID,
	VATNo,		VATObjectID,	VATObjectName,	VATObjectAddress,
	DebitAccountID,		CreditAccountID,	
	ExchangeRate,		UnitPrice,
	OriginalAmount,		ConvertedAmount,	
	IsMultiTax,
	VATOriginalAmount,	VATConvertedAmount,
	IsStock,		VoucherDate,	InvoiceDate,	VoucherTypeID,	VATTypeID,	VATGroupID,
	VoucherNo,		InvoiceCode,	InvoiceSign,	Serial,			InvoiceNo,	
	Orders,			EmployeeID,		SenderReceiver,	SRDivisionName,	SRAddress,
	VDescription,	BDescription,	TDescription,
	Quantity,		InventoryID,	UnitID,	
	[Status],		IsAudit,		IsCost,	
	Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
	Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,		Ana10ID,
	CreateDate,		CreateUserID,			LastModifyDate,		LastModifyUserID,
	OriginalAmountCN,						ExchangeRateCN,		CurrencyIDCN,
	DueDays,		PaymentID,				DueDate,	
	DiscountRate,	DiscountAmount,
	OrderID,		CreditBankAccountID,	DebitBankAccountID,
	PaymentTermID,  ConvertedQuantity,		ConvertedPrice,		ConvertedUnitID,
	ExchangeRateDate,	IsMultiExR,IsEInvoice
)

SELECT	D.DivisionID,		D.VoucherID,		D.BatchID,		D.TransactionID, 'AT9000',
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),	'T34',
		D.CurrencyID,		D.ObjectID,			D.ObjectID,
		A.VATNo,			D.VATObjectID,		A.ObjectName,	A.[Address],
		D.DebitAccountID,	D.CreditAccountID,	D.ExchangeRate,	NULL,
		0,					0,			
		NULL,
		--CASE WHEN ISNULL(D.IsMultiTax,1) = 1 THEN ROUND (A1.VATRate/100*(D.OriginalAmount), ISNULL(A2.ConvertedDecimals,0)) ELSE NULL END,
	 --   CASE WHEN ISNULL(D.IsMultiTax,1) = 1 THEN ROUND(A1.VATRate/100*(D.ConvertedAmount), ISNULL(A2.ConvertedDecimals,0)) ELSE NULL END ,
		0, 0,
		@IsWareHouse ,		D.VoucherDate,	D.InvoiceDate,	D.VoucherTypeID,	D.VATTypeID,	D.VATGroupID,
		D.VoucherNo,	D.InvoiceCode,		D.InvoiceSign,	D.Serial,		D.InvoiceNo,	
		D.Orders,		D.EmployeeID,	A.ObjectName,	A.ObjectName,	A.Address,
		D.VDescription,	D.BDescription,	D.TDescription,
		NULL,		NULL,		NULL,		
		0,		0,		0,	
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,
		D.Ana06ID,	D.Ana07ID,	D.Ana08ID,	D.Ana09ID,	D.Ana10ID,
		GETDATE(),	@UserID,	GETDATE(),	@UserID,
		D.OriginalAmount,	D.ExchangeRate,	D.CurrencyID,
		NULL,				D.PaymentID,			D.DueDate,	
		D.DiscountRate,		D.DiscountAmount,
		NULL,				NULL,			NULL,
		D.PaymentTermID,   D.Quantity,		D.UnitPrice,	D.UnitID,	
		ISNULL(D.PaymentDate,D.VoucherDate),	D.IsMultiExR, CASE WHEN ISNULL(A3.IsUsedEInvoice,0) = 1 THEN 1 ELSE NULL END 
FROM	#Data D
LEFT JOIN AT1202 A WITH (NOLOCK) ON A.ObjectID = D.VATObjectID
LEFT JOIN AT1010 A1 WITH (NOLOCK) ON A1.VATGroupID = D.VATGroupID
LEFT JOIN AT1101 A2 WITH (NOLOCK) ON A2.DivisionID = D.DivisionID 
LEFT JOIN AT1202 A3 WITH (NOLOCK) ON A3.ObjectID = D.ObjectID

	-- Insert quy cách 
	INSERT AT8899 ( DivisionID, VoucherID, TransactionID, TableID, S01ID, S02ID, S03ID, S04ID, S05ID,
				 S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)

	SELECT DivisionID, D.VoucherID, D.TransactionID, 'AT9000', S01ID, S02ID, S03ID, S04ID, S05ID,
		   S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID,S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
      FROM #Data D

	  print (@VATGroupID)
IF ISNULL(@VATGroupID, '') <> '' 
BEGIN 
INSERT INTO AT9000
(
	DivisionID, 	VoucherID,		BatchID,	TransactionID,	TableID,
	TranMonth,	TranYear,		TransactionTypeID,
	CurrencyID,	ObjectID,		CreditObjectID,
	VATNo,		VATObjectID,	VATObjectName,	VATObjectAddress,
	DebitAccountID,		CreditAccountID,	
	ExchangeRate,		UnitPrice,
	OriginalAmount,		ConvertedAmount,	
	VATOriginalAmount,	VATConvertedAmount,
	IsStock,		VoucherDate,	InvoiceDate,	VoucherTypeID,	VATTypeID,	VATGroupID,
	VoucherNo,		InvoiceCode,	InvoiceSign,	Serial,			InvoiceNo,	
	Orders,			EmployeeID,		SenderReceiver,	SRDivisionName,	SRAddress,
	VDescription,	BDescription,	TDescription,
	Quantity,		InventoryID,	UnitID,	
	[Status],		IsAudit,		IsCost,	IsMultiTax,
	Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
	Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,	Ana10ID,
	CreateDate,		CreateUserID,			LastModifyDate,		LastModifyUserID,
	OriginalAmountCN,						ExchangeRateCN,		CurrencyIDCN,
	DueDays,		PaymentID,				DueDate,	
	DiscountRate,	DiscountAmount,
	OrderID,		CreditBankAccountID,	DebitBankAccountID,
	PaymentTermID,  ConvertedQuantity,		ConvertedPrice,		ConvertedUnitID,
	ExchangeRateDate,	IsMultiExR,IsEInvoice
)

 SELECT	D.DivisionID,  D.VoucherID, D.BatchID,		(SELECT TOP 1 #Data.VATTransactionID FROM #Data WHERE #Data.VoucherID = D.VoucherID),	'AT9000',
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),	'T24'  ,
		D.CurrencyID,	
		CASE WHEN ISNULL(D.GTGTObjectID,'') != '' THEN D.GTGTObjectID ELSE D.ObjectID END,
		CASE WHEN ISNULL(D.GTGTObjectID,'') != '' THEN D.GTGTObjectID ELSE D.ObjectID END,
		A.VATNo,			D.VATObjectID,		A.ObjectName,	A.[Address],
		D.GTGTDebitAccountID,	D.GTGTCreditAccountID,	D.ExchangeRate,	D.UnitPrice,
		D.OriginalAmount,		D.ConvertedAmount,
		--SUM(ROUND (A1.VATRate*(D.OriginalAmount)/100,ISNULL(A2.ConvertedDecimals,0))) ,
		--SUM(ROUND (A1.VATRate/100*(D.ConvertedAmount),ISNULL(A2.ConvertedDecimals,0))),
		0,	0,
		D.IsWareHouse,	D.VoucherDate,	D.InvoiceDate,	D.VoucherTypeID,	D.VATTypeID,	D.VATGroupID,
		D.VoucherNo,	D.InvoiceCode,	D.InvoiceSign,	D.Serial,			D.InvoiceNo,	
		NULL,		D.EmployeeID,	A.ObjectName,	A.ObjectName,	A.Address,
		D.VDescription,	D.BDescription,	N'',
		D.Quantity,		D.InventoryID,	D.UnitID,	
		0,				0,		0,		1,
		MAX(D.Ana01ID),	MAX(D.Ana02ID),	MAX(D.Ana03ID),	MAX(D.Ana04ID),	MAX(D.Ana05ID),
		MAX(D.Ana06ID),	MAX(D.Ana07ID),	MAX(D.Ana08ID),	MAX(D.Ana09ID),		MAX(D.Ana10ID),
		GETDATE(),	@UserID,	GETDATE(),	@UserID,
		SUM(ROUND (A1.VATRate*(D.OriginalAmount)/100,ISNULL(A2.ConvertedDecimals,0))) ,	
		D.ExchangeRate,		D.CurrencyID,
		NULL,				D.PaymentID,			D.DueDate,	
		NULL,				NULL,
		NULL,				NULL,			NULL,
		D.PaymentTermID,	NULL,			NULL,	NULL,
		ISNULL(D.PaymentDate,D.VoucherDate),	D.IsMultiExR, CASE WHEN ISNULL(A3.IsUsedEInvoice,0) = 1 THEN 1 ELSE NULL END 
   FROM	#Data D
   LEFT JOIN AT1202 A WITH (NOLOCK) ON A.ObjectID = D.VATObjectID
   LEFT JOIN AT1010 A1 WITH (NOLOCK) ON A1.VATGroupID = D.VATGroupID
   LEFT JOIN AT1101 A2 WITH (NOLOCK) ON A2.DivisionID = D.DivisionID 
   LEFT JOIN AT1202 A3 WITH (NOLOCK) ON A3.ObjectID = D.ObjectID
  WHERE D.VATTransactionID Is Not Null AND ISNULL(IsMultiTax,1) = 0 
  GROUP BY D.DivisionID,		D.VoucherID,		D.BatchID,	
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),	
		D.CurrencyID,
		CASE WHEN ISNULL(D.GTGTObjectID,'') != '' THEN D.GTGTObjectID ELSE D.ObjectID END,
		CASE WHEN ISNULL(D.GTGTObjectID,'') != '' THEN D.GTGTObjectID ELSE D.ObjectID END,
		A.VATNo,			D.VATObjectID,		A.ObjectName,	A.[Address],
		D.GTGTDebitAccountID,	D.GTGTCreditAccountID,	D.ExchangeRate, 	D.UnitPrice,
		D.OriginalAmount,		D.ConvertedAmount,
		D.IsWareHouse,		D.VoucherDate,	D.InvoiceDate,	D.VoucherTypeID,	D.VATTypeID,	D.VATGroupID,
		D.VoucherNo,	D.InvoiceCode,D.InvoiceSign, D.Serial,		D.InvoiceNo,	
		D.EmployeeID,	A.ObjectName,	A.ObjectName,	A.Address,
		D.VDescription,	D.BDescription,
		D.Quantity,		D.InventoryID,	D.UnitID,	
		D.ExchangeRate,		D.CurrencyID,
		D.PaymentID,		D.DueDate,	
		D.PaymentTermID,	ISNULL(D.PaymentDate,D.VoucherDate),	D.IsMultiExR, 
		CASE WHEN ISNULL(A3.IsUsedEInvoice,0) = 1 THEN 1 ELSE NULL END

--- Nhiều nhóm thuế 
INSERT INTO AT9000
(
	DivisionID,	VoucherID,	BatchID,	TransactionID,	TableID,
	TranMonth,	TranYear,		TransactionTypeID,
	CurrencyID,	ObjectID,		CreditObjectID,
	VATNo,		VATObjectID,	VATObjectName,	VATObjectAddress,
	DebitAccountID,		CreditAccountID,	
	ExchangeRate,		UnitPrice,
	OriginalAmount,		ConvertedAmount,	
	VATOriginalAmount,	VATConvertedAmount,
	IsStock,		VoucherDate,	InvoiceDate,	VoucherTypeID,	VATTypeID,	VATGroupID,
	VoucherNo,		InvoiceCode,InvoiceSign, Serial,			InvoiceNo,	
	Orders,			EmployeeID,		SenderReceiver,	SRDivisionName,	SRAddress,
	VDescription,	BDescription,	TDescription,
	Quantity,		InventoryID,	UnitID,	
	[Status],		IsAudit,		IsCost,	IsMultiTax,
	Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
	Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,		Ana10ID,
	CreateDate,		CreateUserID,			LastModifyDate,		LastModifyUserID,
	OriginalAmountCN,						ExchangeRateCN,		CurrencyIDCN,
	DueDays,		PaymentID,				DueDate,	
	DiscountRate,	DiscountAmount,
	OrderID,		CreditBankAccountID,	DebitBankAccountID,
	PaymentTermID,  ConvertedQuantity,		ConvertedPrice,		ConvertedUnitID,
	ExchangeRateDate,	IsMultiExR, IsEInvoice
)

SELECT	D.DivisionID,		D.VoucherID,		D.BatchID,		D.VATTransactionID,	'AT9000',
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),	'T24',
		D.CurrencyID,		
		CASE WHEN ISNULL(D.GTGTObjectID,'') != '' THEN D.GTGTObjectID ELSE D.ObjectID END,
		CASE WHEN ISNULL(D.GTGTObjectID,'') != '' THEN D.GTGTObjectID ELSE D.ObjectID END,
		A.VATNo,			D.VATObjectID,		A.ObjectName,	A.[Address],
		D.GTGTDebitAccountID,	D.GTGTCreditAccountID,	D.ExchangeRate,		D.UnitPrice,
		D.OriginalAmount,		D.ConvertedAmount,
		--SUM(ROUND (A1.VATRate*(D.OriginalAmount)/100,ISNULL(A2.ConvertedDecimals,0))) ,
		--SUM(ROUND (A1.VATRate/100*(D.ConvertedAmount),ISNULL(A2.ConvertedDecimals,0))),
		0, 0,
		D.IsWareHouse,		D.VoucherDate,	D.InvoiceDate,	D.VoucherTypeID,	D.VATTypeID,	D.VATGroupID,
		D.VoucherNo,	D.InvoiceCode,D.InvoiceSign, D.Serial,		D.InvoiceNo,	
		NULL,		D.EmployeeID,	A.ObjectName,	A.ObjectName,	A.Address,
		D.VDescription,	D.BDescription,	NULL,
		D.Quantity,		D.InventoryID,	D.UnitID,	
		0,		0,		0,	1,
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,
		D.Ana06ID,	D.Ana07ID,	D.Ana08ID,	D.Ana09ID,		D.Ana10ID,
		GETDATE(),	@UserID,	GETDATE(),	@UserID,
		SUM(ROUND (A1.VATRate*(D.OriginalAmount)/100,ISNULL(A2.ConvertedDecimals,0))) ,	
		D.ExchangeRate,		D.CurrencyID,
		NULL,				D.PaymentID,			D.DueDate,	
		NULL,				NULL,
		NULL,				NULL,			NULL,
		D.PaymentTermID,	NULL,			NULL,	NULL,
		ISNULL(D.PaymentDate,D.VoucherDate),	D.IsMultiExR, CASE WHEN ISNULL(A3.IsUsedEInvoice,0) = 1 THEN 1 ELSE NULL END 
		
FROM	#Data D
LEFT JOIN AT1202 A WITH (NOLOCK) ON A.ObjectID = D.VATObjectID
LEFT JOIN AT1010 A1 WITH (NOLOCK) ON A1.VATGroupID = D.VATGroupID
LEFT JOIN AT1101 A2 WITH (NOLOCK) ON A2.DivisionID = D.DivisionID --AND A2.BaseCurrencyID = D.CurrencyID
LEFT JOIN AT1202 A3 WITH (NOLOCK) ON A3.ObjectID = D.ObjectID
WHERE D.VATTransactionID Is Not Null AND ISNULL(IsMultiTax,1) = 1 
GROUP BY D.DivisionID,		D.VoucherID,		D.BatchID,		D.VATTransactionID,
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),	
		D.CurrencyID,	
		CASE WHEN ISNULL(D.GTGTObjectID,'') != '' THEN D.GTGTObjectID ELSE D.ObjectID END,	
		CASE WHEN ISNULL(D.GTGTObjectID,'') != '' THEN D.GTGTObjectID ELSE D.ObjectID END,
		A.VATNo,			D.VATObjectID,		A.ObjectName,	A.[Address],
		D.GTGTDebitAccountID,	D.GTGTCreditAccountID,	D.ExchangeRate, D.UnitPrice,
		D.OriginalAmount,		D.ConvertedAmount,
		D.IsWareHouse,		D.VoucherDate,	D.InvoiceDate,	D.VoucherTypeID,	D.VATTypeID,	D.VATGroupID,
		D.VoucherNo,	D.InvoiceCode,D.InvoiceSign, D.Serial,		D.InvoiceNo,	
		D.EmployeeID,	A.ObjectName,	A.ObjectName,	A.Address,
		D.VDescription,	D.BDescription,
		D.Quantity,		D.InventoryID,	D.UnitID,	
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,
		D.Ana06ID,	D.Ana07ID,	D.Ana08ID,	D.Ana09ID,		D.Ana10ID,
		D.ExchangeRate,		D.CurrencyID,
		D.PaymentID,		D.DueDate,	
		D.PaymentTermID,	ISNULL(D.PaymentDate,D.VoucherDate),	D.IsMultiExR, 
		CASE WHEN ISNULL(A3.IsUsedEInvoice,0) = 1 THEN 1 ELSE NULL END

	-- Insert quy cách 
	INSERT AT8899 ( DivisionID, VoucherID, TransactionID, TableID, S01ID, S02ID, S03ID, S04ID, S05ID,
					S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID )

	SELECT DivisionID, D.VoucherID, D.VATTransactionID, 'AT9000', S01ID, S02ID, S03ID, S04ID, S05ID,
		   S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID,S19ID, S20ID
      FROM #Data D

END 
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

	SELECT DISTINCT
		   DivisionID,		WHVoucherID,		'AT2006',	LEFT(Period, 2),RIGHT(Period, 4),
		   WareHouseVoucherTypeID,		WareHouseImVoucherDate,	
		   WareHouseImVoucherNo,		ObjectID,			InventoryTypeID	,		
		   WareHouseEx,	1,			0,				EmployeeID,		WHDescription,
		   VoucherNo,		InvoiceNo+'/'+Serial,			
		   GETDATE(),		@UserID,		@UserID,	GETDATE()	
	  FROM #Data

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
	Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,		Ana10ID,
	ReVoucherID,	ReTransactionID,	OrderID,
	ConversionFactor

)
SELECT	D.Orders,
		D.DivisionID,		D.WHTransactionID,		D.WHVoucherID,	
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),		D.CurrencyID,		D.ExchangeRate,
		D.InventoryID,		D.UnitID,				D.SourceNo,
		D.Quantity,			D.UnitPrice,
		D.Quantity,			D.UnitPrice,			
		D.OriginalAmount,	D.ConvertedAmount,
		D.WHDebitAccountID,	D.WHCreditAccountID,		
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,
		D.Ana06ID,	D.Ana07ID,	D.Ana08ID,	D.Ana09ID,		D.Ana10ID,
		Null,		Null,		D.VoucherNo,
		1

FROM	#Data D

	-- Insert quy cách xuât kho  
	INSERT WT8899 ( DivisionID, VoucherID, TransactionID, TableID, S01ID, S02ID, S03ID, S04ID, S05ID,
				    S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)

	SELECT DivisionID,D.WHVoucherID,D.WHTransactionID,'AT2007',S01ID,S02ID,S03ID,S04ID,S05ID,
		   S06ID,S07ID,S08ID,S09ID,S10ID,S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID
	  FROM #Data D


END


LB_RESULT:
SELECT * FROM #Data






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
