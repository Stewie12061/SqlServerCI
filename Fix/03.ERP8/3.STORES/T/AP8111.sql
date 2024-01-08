IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP8111]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8111]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Xử lý Import dữ liệu phiếu chi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 13/10/2011 by Nguyễn Bình Minh
---- 
---- Modified on 03/03/2016 by Phương Thảo : Tự động tính tỷ giá và sinh chênh lệch theo TT200
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Thy on 15/06/2016: Bổ sung Ana07ID->Ana10ID
---- Modified on 12/05/2017 by Tiểu Mai: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Bảo Thy on 07/06/2017: Sửa ExchangeRate, ConvertedAmount Decimal --> Nvarchar
---- Modified on 05/03/2019 by Kim Thư: Tạo khóa chính cho table #Data và #Keys có nối với @@SPID để tránh trùng khóa chính khi nhiều user sử dụng
---- Modified on 14/06/2019 by Kim Thư :Điều chỉnh các cột người dùng để trống sẽ insert là null thay vì giá trị rỗng
---- Modified on 16/10/2020 by Hoài Phong: Điều chỉnh cột InvoiceDate nếu 1900-01-01 về NULL
---- Modified on 23/06/2021 by Nhựt Trường: Bổ sung trường InvoiceCode, InvoiceSign.
---- Modified on 24/01/2022 by Xuân Nguyên: Fix lỗi sai kiểu dữ liệu cột OriginalAmount
---- Modified on 28/11/2023 by Kiều Nga: Bổ sung trường PeriodID,ProductID.
-- <Example>
---- 
CREATE PROCEDURE [DBO].[AP8111]
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
	Row INT NOT NULL,	
	ImportMessage NVARCHAR(500) DEFAULT (''),
	Orders INT, -- Số thứ tự dòng
	VoucherID NVARCHAR(50) NULL,
	TransactionID NVARCHAR(50) NULL,
	BatchID NVARCHAR(50) NULL--,
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
	TransactionID NVARCHAR(50)--,	
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
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + ' NULL'
	--PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END

ALTER TABLE #Data ADD Method Tinyint NULL 
ALTER TABLE #Data ADD PaymentExR Decimal(28,8) NULL 
ALTER TABLE #Data ADD AVRExR Decimal(28,8) NULL 



SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,
		X.Data.query('VoucherTypeID').value('.', 'NVARCHAR(50)') AS VoucherTypeID,
		X.Data.query('VoucherNo').value('.', 'NVARCHAR(50)') AS VoucherNo,
		X.Data.query('VoucherDate').value('.', 'DATETIME') AS VoucherDate,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('RefNo01').value('.', 'NVARCHAR(100)') AS RefNo01,
		X.Data.query('SenderReceiver').value('.', 'NVARCHAR(250)') AS SenderReceiver,
		X.Data.query('SRDivisionName').value('.', 'NVARCHAR(250)') AS SRDivisionName,
		X.Data.query('SRAddress').value('.', 'NVARCHAR(50)') AS SRAddress,
		X.Data.query('InvoiceCode').value('.', 'NVARCHAR(50)') AS InvoiceCode,
		X.Data.query('InvoiceSign').value('.', 'NVARCHAR(50)') AS InvoiceSign,
		X.Data.query('Serial').value('.', 'NVARCHAR(50)') AS Serial,
		X.Data.query('InvoiceNo').value('.', 'NVARCHAR(50)') AS InvoiceNo,
		X.Data.query('InvoiceDate').value('.', 'DATETIME') AS InvoiceDate,
		X.Data.query('VDescription').value('.', 'NVARCHAR(250)') AS VDescription,
		X.Data.query('BDescription').value('.', 'NVARCHAR(250)') AS BDescription,
		X.Data.query('CurrencyID').value('.', 'NVARCHAR(50)') AS CurrencyID,
		-- X.Data.query('ExchangeRate').value('.', 'DECIMAL(28,8)') AS ExchangeRate,
		X.Data.query('ExchangeRate').value('.', 'NVARCHAR(50)') AS ExchangeRate,
		X.Data.query('OriginalAmount').value('.', 'NVARCHAR(50)') AS OriginalAmount,
		-- X.Data.query('ConvertedAmount').value('.', 'DECIMAL(28,8)') AS ConvertedAmount,
		X.Data.query('ConvertedAmount').value('.', 'NVARCHAR(50)') AS ConvertedAmount,
		X.Data.query('DebitAccountID').value('.', 'NVARCHAR(50)') AS DebitAccountID,
		X.Data.query('CreditAccountID').value('.', 'NVARCHAR(50)') AS CreditAccountID,
		X.Data.query('VATTypeID').value('.', 'NVARCHAR(50)') AS VATTypeID,
		X.Data.query('VATGroupID').value('.', 'NVARCHAR(50)') AS VATGroupID,
		X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID,
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
		X.Data.query('PeriodID').value('.', 'NVARCHAR(50)') AS PeriodID,
		X.Data.query('ProductID').value('.', 'NVARCHAR(50)') AS ProductID
into	#AP8111
FROM	@XML.nodes('//Data') AS X (Data)


INSERT INTO #Data (
		Row,				DivisionID,			Period,				VoucherTypeID,		VoucherNo,			VoucherDate,		EmployeeID,	RefNo01,		
		SenderReceiver,		SRDivisionName,		SRAddress,			InvoiceCode,		InvoiceSign,		Serial,				InvoiceNo,			InvoiceDate,		
		VDescription,		BDescription,		CurrencyID,			ExchangeRate, 		OriginalAmount, 	ConvertedAmount, 	
		DebitAccountID, 	CreditAccountID,	VATTypeID, 			VATGroupID, 		ObjectID,			
		TDescription,		Ana01ID, 			Ana02ID, 			Ana03ID, 			Ana04ID,			Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,PeriodID,ProductID)		
SELECT	Row,				DivisionID,			Period,				VoucherTypeID,		VoucherNo,			VoucherDate,		EmployeeID,	
		--RefNo01,
		CASE WHEN ISNULL(RefNo01,'') = '' THEN NULL ELSE RefNo01 END RefNo01,	
		--SenderReceiver,
		CASE WHEN ISNULL(SenderReceiver,'') = '' THEN NULL ELSE SenderReceiver END SenderReceiver,	
		--SRDivisionName,
		CASE WHEN ISNULL(SRDivisionName,'') = '' THEN NULL ELSE SRDivisionName END SRDivisionName,	
		--SRAddress,	
		CASE WHEN ISNULL(SRAddress,'') = '' THEN NULL ELSE SRAddress END SRAddress,
		CASE WHEN ISNULL(InvoiceCode,'') = '' THEN NULL ELSE InvoiceCode END InvoiceCode,
		CASE WHEN ISNULL(InvoiceSign,'') = '' THEN NULL ELSE InvoiceSign END InvoiceSign,
		--Serial,
		CASE WHEN ISNULL(Serial,'') = '' THEN NULL ELSE Serial END Serial,	
		InvoiceNo,	
		CONVERT(DATE, CASE WHEN InvoiceDate = '1900-01-01' THEN NULL ELSE InvoiceDate END) AS InvoiceDate,		
		--VDescription,
		CASE WHEN ISNULL(VDescription,'') = '' THEN NULL ELSE VDescription END VDescription,
		--BDescription,
		CASE WHEN ISNULL(BDescription,'') = '' THEN NULL ELSE BDescription END BDescription,
		CurrencyID,			
		-- ExchangeRate, 		
		CASE WHEN ISNULL(ExchangeRate,'') = '' THEN NULL ELSE CAST(ExchangeRate AS DECIMAL(28,8)) END ExchangeRate,
		CASE WHEN ISNULL(OriginalAmount,'') = '' THEN NULL ELSE CAST(OriginalAmount AS DECIMAL(28,8)) END OriginalAmount, 	
		CASE WHEN ISNULL(ConvertedAmount,'') = '' THEN NULL ELSE CAST(ConvertedAmount AS DECIMAL(28,8)) END ConvertedAmount,
		-- ConvertedAmount, 	
		DebitAccountID, 	CreditAccountID,	
		--VATTypeID, 
		CASE WHEN ISNULL(VATTypeID,'') = '' THEN NULL ELSE VATTypeID END VATTypeID,			
		--VATGroupID, 
		CASE WHEN ISNULL(VATGroupID,'') = '' THEN NULL ELSE VATGroupID END VATGroupID,			
		ObjectID,			
		--TDescription,	
		CASE WHEN ISNULL(TDescription,'') = '' THEN NULL ELSE TDescription END TDescription,	
		--Ana01ID, 			Ana02ID, 			Ana03ID, 			Ana04ID,			Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID
		CASE WHEN ISNULL(Ana01ID,'')='' THEN NULL ELSE Ana01ID END AS Ana01ID,
		CASE WHEN ISNULL(Ana02ID,'')='' THEN NULL ELSE Ana02ID END AS Ana02ID,
		CASE WHEN ISNULL(Ana03ID,'')='' THEN NULL ELSE Ana03ID END AS Ana03ID,
		CASE WHEN ISNULL(Ana04ID,'')='' THEN NULL ELSE Ana04ID END AS Ana04ID,
		CASE WHEN ISNULL(Ana05ID,'')='' THEN NULL ELSE Ana05ID END AS Ana05ID,
		CASE WHEN ISNULL(Ana06ID,'')='' THEN NULL ELSE Ana06ID END AS Ana06ID,
		CASE WHEN ISNULL(Ana07ID,'')='' THEN NULL ELSE Ana07ID END AS Ana07ID,
		CASE WHEN ISNULL(Ana08ID,'')='' THEN NULL ELSE Ana08ID END AS Ana08ID,
		CASE WHEN ISNULL(Ana09ID,'')='' THEN NULL ELSE Ana09ID END AS Ana09ID,
		CASE WHEN ISNULL(Ana10ID,'')='' THEN NULL ELSE Ana10ID END AS Ana10ID,
		CASE WHEN ISNULL(PeriodID,'')='' THEN NULL ELSE PeriodID END AS PeriodID,
		CASE WHEN ISNULL(ProductID,'')='' THEN NULL ELSE ProductID END AS ProductID
FROM	#AP8111

UPDATE #Data
SET		#Data.Method = ISNULL(AT1004.Method,0)
FROM #Data INNER JOIN  AT1004 WITH (NOLOCK) ON #Data.CurrencyID = AT1004.CurrencyID


---- Kiểm tra bắt buộc nhập tỷ giá, thành tiền quy đổi nếu loại tiền ko sử dụng pp BQGQ di động
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @ColID = 'STR(ExchangeRate)', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 0, @SQLWhere = 'Method = 0'
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @ColID = 'STR(ConvertedAmount)', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 0, @SQLWhere = 'Method = 0'



---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần phiếu
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'VoucherNo', @Param1 = 'VoucherNo,VoucherTypeID,VoucherDate,CurrencyID,ExchangeRate,EmployeeID,SenderReceiver,SRDivisionName,SRAddress,CreditAccountID,VDescription'

--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			ConvertedAmount = ROUND(ConvertedAmount, CUR.ConvertedDecimals),
			OriginalAmount = ROUND(OriginalAmount, CUR.OriginalDecimal),
			ExchangeRate = ROUND(DT.ExchangeRate, CUR.ExchangeRateDecimal),
			VoucherDate = CONVERT(DATE, VoucherDate),
			InvoiceDate = CONVERT(DATE, CASE WHEN InvoiceDate = '1900-01-01' THEN NULL ELSE InvoiceDate END)
FROM		#Data DT
INNER JOIN	AV1004 CUR 
		ON	CUR.CurrencyID = DT.CurrencyID AND CUR.DivisionID in (DT.DivisionID,'@@@')


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

-- Đẩy dữ liệu vào bảng
INSERT INTO AT9000
(
	APK,				Orders,
	VoucherID,			BatchID,			TransactionID,
	DivisionID,			TranMonth,			TranYear,
	VoucherTypeID,		VoucherNo,
	VoucherDate,		EmployeeID,
	SenderReceiver,		SRDivisionName,		SRAddress,
	InvoiceCode,		InvoiceSign,
	Serial,				InvoiceNo,			InvoiceDate,
	VDescription,		BDescription,		CurrencyID,
	ExchangeRate,		ExchangeRateCN,		CurrencyIDCN,
	OriginalAmount,		OriginalAmountCN,	ConvertedAmount,
	DebitAccountID,		CreditAccountID,
	VATTypeID,			VATGroupID,
	ObjectID,			TDescription,
	Ana01ID,			Ana02ID,			Ana03ID,			Ana04ID,			Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
	CreateDate,			CreateUserID,		LastModifyDate,		LastModifyUserID,
	TableID,			TransactionTypeID,RefNo01,PeriodID,ProductID
)
SELECT	APK,				Orders,
		VoucherID,			BatchID,			TransactionID,
		DivisionID,			LEFT(Period, 2),	RIGHT(Period, 4),
		VoucherTypeID,		VoucherNo,
		VoucherDate,		EmployeeID,
		SenderReceiver,		SRDivisionName,		SRAddress,
		InvoiceCode,		InvoiceSign,
		Serial,				InvoiceNo,			InvoiceDate,
		VDescription,		BDescription,		CurrencyID,
		CASE WHEN Method = 0 THEN ExchangeRate ELSE 0 END,		
		CASE WHEN Method = 0 THEN ExchangeRate ELSE 0 END,				
		CurrencyID,
		OriginalAmount,		OriginalAmount,		
		CASE WHEN Method = 0 THEN ConvertedAmount ELSE 0 END,				
		DebitAccountID,		CreditAccountID,
		VATTypeID,			VATGroupID,
		ObjectID,			TDescription,
		Ana01ID,			Ana02ID,			Ana03ID,			Ana04ID,	Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
		GETDATE(),			@UserID,			GETDATE(),			@UserID,
		'AT9000',			'T02',RefNo01,PeriodID,ProductID		
FROM	#Data

------------------ Xử lý tỷ giá bình quân gia quyền di động theo TT200 (Method = 1) ----------------------------------
IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE Method = 1)
BEGIN	
	DECLARE @LostAccountID Nvarchar(50),
			@ProfitAccountID NVarchar(50)

	SELECT	@LostAccountID = LossExchangeAccID,
			@ProfitAccountID = InterestExchangeAccID
	FROM AT0000

	DECLARE @cBatchID AS CURSOR
	DECLARE @cTransID AS CURSOR
	DECLARE @CurrencyID AS NVARCHAR(50), @VoucherDate Datetime, @AccountID NVarchar(50),
			@PaymentExR Decimal(28,8), @AVRExR Decimal(28,8), @ExchangeRate Decimal(28,8), @OAmount Decimal(28,8)	

	DECLARE @SumDebitCA AS DECIMAL(28,8) , @SumDebitOA AS  DECIMAL(28,8),
			@SumCreditCA AS  DECIMAL(28,8), @SumCreditOA AS  DECIMAL(28,8)
	DECLARE @Operator AS INT, @ERDecimal AS INT
				
	Select @BatchID = '',  @TransID = ''

	--SELECT	BatchID, VoucherDate, CurrencyID, CreditAccountID
	--	FROM	#Data
	--	WHERE Method = 1

	SET @cBatchID = CURSOR FOR
		SELECT	DISTINCT BatchID, VoucherDate, CurrencyID, CreditAccountID
		FROM	#Data
		WHERE Method = 1
		
	OPEN @cBatchID
	FETCH NEXT FROM @cBatchID INTO @BatchID, @VoucherDate, @CurrencyID, @AccountID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		------ B1: Tính tỷ giá Mua -----
		IF EXISTS (SELECT TOP 1 1 FROM  AT1012 WITH(NOLOCK) WHERE	CurrencyID = @CurrencyID AND DATEDIFF(dd, ExchangeDate, @VoucherDate) >= 0 AND IsDefault = 1)
		BEGIN
				SELECT		TOP 1 @PaymentExR =  SellingExchangeRate 
				FROM		AT1012 WITH (NOLOCK)
				WHERE		CurrencyID = @CurrencyID
							AND DATEDIFF(dd, ExchangeDate, @VoucherDate) >= 0
							AND DivisionID = @DivisionID
							AND IsDefault = 1
				ORDER BY	DATEDIFF(dd, ExchangeDate, @VoucherDate)
				
		END
		ELSE
		BEGIN
			SELECT		TOP 1 @PaymentExR = ExchangeRate
			FROM		AT1012 WITH (NOLOCK)
			WHERE		CurrencyID = @CurrencyID
						AND DATEDIFF(dd, ExchangeDate, @VoucherDate) >= 0
						AND DivisionID = @DivisionID
			ORDER BY	DATEDIFF(dd, ExchangeDate, @VoucherDate)

			SET @PaymentExR = COALESCE(@PaymentExR, (SELECT ExchangeRate FROM AT1004 WHERE CurrencyID = @CurrencyID AND DivisionID = @DivisionID), 0)
	
		END

		UPDATE T1
		SET		PaymentExchangeRate  = @PaymentExR
		FROM AT9000 T1
		INNER JOIN #Data T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
		WHERE T2.BatchID = @BatchID

		------ B2: Tính tỷ giá BQ -----
		SELECT TOP 1 @Operator=Operator, 
					@ERDecimal = ExchangeRateDecimal
		FROM 	AT1004 
		WHERE 	CurrencyID = @CurrencyID 


		SELECT		TOP 1 @AVRExR = ExchangeRate
		FROM		AT1012 WITH (NOLOCK)
		WHERE		CurrencyID = @CurrencyID
					AND DATEDIFF(dd, ExchangeDate, @VoucherDate) >= 0
					AND DivisionID = @DivisionID
		ORDER BY	DATEDIFF(dd, ExchangeDate, @VoucherDate)

		SET @AVRExR = COALESCE(@AVRExR, (SELECT ExchangeRate FROM AT1004 WITH (NOLOCK) WHERE CurrencyID = @CurrencyID AND DivisionID = @DivisionID), 0)
   

		SELECT 	@SumDebitCA = IsNull(SUM(SignAmount),0), 
 				@SumDebitOA=IsNull(SUM(OSignAmount),0) 
		FROM 	AV5000 
		WHERE 	VoucherDate <=@VoucherDate 
 			AND DebitAccountID = @AccountID 
 			AND CurrencyID = @CurrencyID 
 			AND D_C =  'D'
 			AND DivisionID = @DivisionID
		 	
		SELECT 	@SumCreditCA = IsNull(SUM(SignAmount),0), 
 				@SumCreditOA=IsNull(SUM(OSignAmount),0) 
		FROM 	AV5000 
		WHERE 	VoucherDate <=@VoucherDate  
 			AND CreditAccountID = @AccountID 
 			AND CurrencyID = @CurrencyID 
 			AND D_C =  'C'
			AND DivisionID = @DivisionID

				--select @SumDebitOA as SumDebitOA, @SumCreditOA as SumCreditOA, @SumDebitCA as SumDebitCA, @SumCreditCA as SumCreditCA

		IF @Operator = 0 -- Ty gia nhan 
 			SELECT @AVRExR =  (CASE WHEN @SumDebitOA - @SumCreditOA <>0 THEN ROUND((@SumDebitCA + @SumCreditCA)/(@SumDebitOA + @SumCreditOA),@ERDecimal) ELSE @AVRExR END)
		ELSE 
 			SELECT @AVRExR = (CASE WHEN @SumDebitCA - @SumCreditCA <>0 THEN ROUND((@SumDebitOA + @SumCreditOA)/(@SumDebitCA + @SumCreditCA),@ERDecimal) ELSE @AVRExR END) 
 		
		UPDATE T1
		SET		AVRExchangeRate  = @AVRExR
		FROM AT9000 T1
		INNER JOIN #Data T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
		
		--select @PaymentExR, @AVRExR
		------ B3: Lưu lại tỷ giá (ExchangeRate), thành tiền quy đổi (ConvertedAmount) và sinh dòng chênh lệch-----
		SELECT @OAmount = OriginalAmount
		FROM #Data
		WHERE TransactionID = @TransID

		IF ((@Operator = 0 AND @AVRExR < @PaymentExR) OR (@Operator = 1 AND @AVRExR > @PaymentExR))  ---- Chênh lệch lời
		BEGIN
			
			UPDATE T1
			SET		T1.ExchangeRate = @AVRExR, T1.ExchangeRateCN = @AVRExR,
					T1.ConvertedAmount = ROUND(
										CASE WHEN @Operator = 0 THEN T1.OriginalAmount * @AVRExR 
											ELSE CASE WHEN @AVRExR = 0 THEN 0 ELSE T1.OriginalAmount/ @AVRExR END END
										,CUR.ConvertedDecimals)	
			FROM AT9000 T1
			INNER JOIN #Data T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
			INNER JOIN	AV1004 CUR ON	CUR.CurrencyID = T2.CurrencyID AND CUR.DivisionID in (T2.DivisionID,'@@@')
			WHERE  T2.BatchID = @BatchID

			INSERT INTO AT9000
			(
				APK,				Orders,
				VoucherID,			BatchID,			TransactionID,
				DivisionID,			TranMonth,			TranYear,
				VoucherTypeID,		VoucherNo,
				VoucherDate,		EmployeeID,
				SenderReceiver,		SRDivisionName,		SRAddress,
				Serial,				InvoiceNo,			InvoiceDate,
				VDescription,		BDescription,		CurrencyID,
				ExchangeRate,		ExchangeRateCN,		CurrencyIDCN,
				OriginalAmount,		OriginalAmountCN,	ConvertedAmount,
				DebitAccountID,		CreditAccountID,				
				ObjectID,			TDescription,
				Ana01ID,			Ana02ID,			Ana03ID,			Ana04ID,			Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
				CreateDate,			CreateUserID,		LastModifyDate,		LastModifyUserID,
				TableID,			TransactionTypeID,	RefNo01,
				ReTransactionID, ReBatchID, ReVoucherID, ReTableID,
				PaymentExchangeRate, AVRExchangeRate,PeriodID,ProductID
			)
			SELECT	#Data.APK,				#Data.Orders,
					#Data.VoucherID,		#Data.BatchID,			NEWID(),
					#Data.DivisionID,		LEFT(#Data.Period, 2),	RIGHT(#Data.Period, 4),
					#Data.VoucherTypeID,	#Data.VoucherNo,
					#Data.VoucherDate,		#Data.EmployeeID,
					#Data.SenderReceiver,	#Data.SRDivisionName,		#Data.SRAddress,
					#Data.Serial,			#Data.InvoiceNo,			#Data.InvoiceDate,
					#Data.VDescription,		#Data.BDescription,			#Data.CurrencyID,
					@AVRExR,		
					@AVRExR,				
					#Data.CurrencyID,
					0,		0,							
					ROUND(
							CASE WHEN @Operator = 0 THEN #Data.OriginalAmount * ABS(@AVRExR-@PaymentExR) 
								ELSE  ABS(#Data.OriginalAmount/@AVRExR- #Data.OriginalAmount/@PaymentExR) END
						,CUR.ConvertedDecimals),				
					#Data.DebitAccountID,		@ProfitAccountID,					
					#Data.ObjectID,			#Data.TDescription,
					#Data.Ana01ID,			#Data.Ana02ID,			#Data.Ana03ID,			#Data.Ana04ID,	#Data.Ana05ID, #Data.Ana06ID,
					#Data.Ana07ID,#Data.Ana08ID,#Data.Ana09ID,#Data.Ana10ID,
					GETDATE(),			@UserID,			GETDATE(),			@UserID,
					'AT9000',			'T10',			#Data.RefNo01	,
					#Data.TransactionID, #Data.BatchID, #Data.VoucherID, 'AT9000',
					@PaymentExR, @AVRExR,#Data.PeriodID,#Data.ProductID
			FROM	#Data
			INNER JOIN	AV1004 CUR ON	CUR.CurrencyID = #Data.CurrencyID AND CUR.DivisionID in (#Data.DivisionID,'@@@')
			WHERE  #Data.BatchID = @BatchID
		END
		ELSE
		IF ((@Operator = 0 AND @AVRExR > @PaymentExR) OR (@Operator = 1 AND @AVRExR < @PaymentExR))  ---- Chênh lệch Lỗ
		BEGIN
			UPDATE T1
			SET		T1.ExchangeRate = @PaymentExR, T1.ExchangeRateCN = @PaymentExR,
					T1.ConvertedAmount = ROUND
											(CASE WHEN @Operator = 0 THEN T1.OriginalAmount * @PaymentExR 
													ELSE CASE WHEN @PaymentExR = 0 THEN 0 ELSE T1.OriginalAmount/ @PaymentExR END END
											,CUR.ConvertedDecimals)					
			FROM AT9000 T1
			INNER JOIN #Data T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
			INNER JOIN	AV1004 CUR ON	CUR.CurrencyID = T2.CurrencyID AND CUR.DivisionID in (T2.DivisionID,'@@@')
			WHERE  T2.BatchID = @BatchID

			INSERT INTO AT9000
			(
				APK,				Orders,
				VoucherID,			BatchID,			TransactionID,
				DivisionID,			TranMonth,			TranYear,
				VoucherTypeID,		VoucherNo,
				VoucherDate,		EmployeeID,
				SenderReceiver,		SRDivisionName,		SRAddress,
				Serial,				InvoiceNo,			InvoiceDate,
				VDescription,		BDescription,		CurrencyID,
				ExchangeRate,		ExchangeRateCN,		CurrencyIDCN,
				OriginalAmount,		OriginalAmountCN,	ConvertedAmount,
				DebitAccountID,		CreditAccountID,				
				ObjectID,			TDescription,
				Ana01ID,			Ana02ID,			Ana03ID,			Ana04ID,			Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
				CreateDate,			CreateUserID,		LastModifyDate,		LastModifyUserID,
				TableID,			TransactionTypeID,	RefNo01,
				ReTransactionID, ReBatchID, ReVoucherID, ReTableID,
				PaymentExchangeRate, AVRExchangeRate,PeriodID,ProductID
			)
			SELECT	#Data.APK,				#Data.Orders,
					#Data.VoucherID,		#Data.BatchID,			NEWID(),
					#Data.DivisionID,		LEFT(#Data.Period, 2),	RIGHT(#Data.Period, 4),
					#Data.VoucherTypeID,	#Data.VoucherNo,
					#Data.VoucherDate,		#Data.EmployeeID,
					#Data.SenderReceiver,	#Data.SRDivisionName,	#Data.SRAddress,
					#Data.Serial,			#Data.InvoiceNo,		#Data.InvoiceDate,
					#Data.VDescription,		#Data.BDescription,		#Data.CurrencyID,
					@PaymentExR,		
					@PaymentExR,				
					#Data.CurrencyID,
					0,		0,							
					ROUND(
							CASE WHEN @Operator = 0 THEN #Data.OriginalAmount * ABS(@AVRExR-@PaymentExR) 
								ELSE  ABS(#Data.OriginalAmount/@AVRExR-#Data.OriginalAmount/@PaymentExR) END
						,CUR.ConvertedDecimals),				
					@LostAccountID,		#Data.CreditAccountID,					
					#Data.ObjectID,			#Data.TDescription,
					#Data.Ana01ID,			#Data.Ana02ID,			#Data.Ana03ID,			#Data.Ana04ID,	#Data.Ana05ID, #Data.Ana06ID,
					#Data.Ana07ID,#Data.Ana08ID,#Data.Ana09ID,#Data.Ana10ID,
					GETDATE(),			@UserID,			GETDATE(),			@UserID,
					'AT9000',			'T10',			#Data.RefNo01	,
					#Data.TransactionID, #Data.BatchID, #Data.VoucherID, 'AT9000',
					@PaymentExR, @AVRExR,#Data.PeriodID,#Data.ProductID
			FROM	#Data
			INNER JOIN	AV1004 CUR ON	CUR.CurrencyID = #Data.CurrencyID AND CUR.DivisionID in (#Data.DivisionID,'@@@')
			WHERE  #Data.BatchID = @BatchID 
		END

	FETCH NEXT FROM @cBatchID INTO @BatchID, @VoucherDate, @CurrencyID, @AccountID
	END	
	CLOSE @cBatchID

END

LB_RESULT:
SELECT * FROM #Data


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

