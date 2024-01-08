IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP8124_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8124_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xử lý Import phiếu xuất kho (tách store cho Meiko)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 21/06/2012 by Lê Thị Thu Hiền
---- Modified on 19/03/2014 by Bảo Anh: Sửa phần làm tròn số lẻ (theo thiết lập đơn vị)
---- Modified on 08/10/2015 by Tieu Mai: Sửa phần làm tròn số lẻ, tiền hạch toán theo thiết lập đơn vị-chi nhánh
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Anh on 16/04/2018: Bổ sung store customize BaSon
---- Modified on 07/06/2018 by Bảo Anh: Bổ sung kiểm tra CreditAccountID phải là TK tồn kho không
---- Modified on 20/08/2020 by Huỳnh Thử: Merge Code: MEKIO và MTE -- Bổ sung kiểm tra xuất kho âm
---- Modified on 11/03/2020 by Đức Thông: Bổ sung phần import phiếu xuất kho trưởng RetransactionID của at0114
---- Modified on 11/05/2020 by Đức Thông: Bổ sung phần import phiếu xuất kho trưởng ReVoucherID của at0114 + thay điều kiện kết
---- Modified on 11/05/2020 by Đức Thông: Bổ sung validate dữ liệu file excel import phiếu xuất: Ngày xuất phải lớn hơn ngày tạo lô nhập và số lượng xuất không được vượt quá lô nhập
---- Modified on 16/12/2020 by Đức Thông: Sửa lỗi câu update (Update Alias bảng phải thêm from)
---- Modified on 06/05/2021 by Văn Tài	: Điều chỉnh convert DATE, cải tiến tốc độ.
---- Modified on 10/09/2021 by Nhựt Trường: Bổ sung thêm điều kiện ReVoucherNo khi kiểm tra số lượng xuất có có hợp lệ không (không vượt quá số lượng trong lô nhập).
---- Modified on 14/10/2021 by Xuân Nguyên: Điều chỉnh cách insert vào AT2007 để khắc phục lỗi (1 phiếu xuất kho có 2 dòng, số chứng từ nhập trong 2 dòng đó giống nhau trong at0114).
---- Modified on 27/10/2021 by Xuân Nguyên: Bổ sung insert Orders vào AT2007 
---- Modified on 03/12/2021 by Nhật Thanh: Bổ sung trường hợp insert phiếu không có chứng từ nhập và lô nhập
-- <Example>
---- 
CREATE PROCEDURE [DBO].[AP8124_MK]
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
	Orders INT,
	VoucherID NVARCHAR(50) NULL,
	TransactionID NVARCHAR(50),
	ImportMessage NVARCHAR(500) DEFAULT (''),
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

--- Đẩy dữ liệu file excel vào bảng tạm
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,
		X.Data.query('VoucherTypeID').value('.', 'NVARCHAR(50)') AS VoucherTypeID,
		X.Data.query('VoucherNo').value('.', 'NVARCHAR(50)') AS VoucherNo,
		X.Data.query('VoucherDate').value('.', 'DATETIME') AS VoucherDate,
		X.Data.query('RefNo01').value('.', 'NVARCHAR(50)') AS RefNo01,
		X.Data.query('RefNo02').value('.', 'NVARCHAR(50)') AS RefNo02,
		X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID,
		X.Data.query('WareHouseID').value('.', 'NVARCHAR(50)') AS WareHouseID,
		X.Data.query('InventoryTypeID').value('.', 'NVARCHAR(50)') AS InventoryTypeID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('ContactPerson').value('.', 'NVARCHAR(250)') AS ContactPerson,
		X.Data.query('RDAddress').value('.', 'NVARCHAR(250)') AS RDAddress,
		X.Data.query('Description').value('.', 'NVARCHAR(250)') AS Description,		
		X.Data.query('BarCode').value('.', 'NVARCHAR(50)') AS BarCode,		
		X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') AS InventoryID,
		X.Data.query('UnitID').value('.', 'NVARCHAR(50)') AS UnitID,
		X.Data.query('ReVoucherNo').value('.', 'NVARCHAR(50)') AS ReVoucherNo,
		X.Data.query('SourceNo').value('.', 'NVARCHAR(50)') AS SourceNo,
		X.Data.query('LimitDate').value('.', 'DATETIME') AS LimitDate,
		X.Data.query('ConvertedQuantity').value('.', 'NVARCHAR(50)') AS ConvertedQuantity,
		X.Data.query('ConvertedPrice').value('.', 'NVARCHAR(50)') AS ConvertedPrice,		
		X.Data.query('ActualQuantity').value('.', 'Decimal(28,8)') AS ActualQuantity,
		X.Data.query('UnitPrice').value('.', 'NVARCHAR(50)') AS UnitPrice,
		X.Data.query('OriginalAmount').value('.', 'NVARCHAR(50)') AS OriginalAmount,
		X.Data.query('DebitAccountID').value('.', 'NVARCHAR(50)') AS DebitAccountID,
		X.Data.query('CreditAccountID').value('.', 'NVARCHAR(50)') AS CreditAccountID,
		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes,		
		X.Data.query('ActEndQty').value('.', 'NVARCHAR(50)') AS ActEndQty,
		--CAST(X.Data.query('ActEndQty').value('.', 'NVARCHAR(50)') + '0'AS DECIMAL(28,8)) AS ActEndQty,		
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
		X.Data.query('PeriodID').value('.','NVARCHAR(50)') AS PeriodID,
		X.Data.query('ProductID').value('.','NVARCHAR(50)') AS ProductID


INTO	#AP8124_MK
FROM	@XML.nodes('//Data') AS X (Data)

-- Thực hiện convert dữ liệu
INSERT INTO #Data (
		Row,
		DivisionID,
		Period,
		VoucherTypeID,
		VoucherNo,
		VoucherDate,
		RefNo01,
		RefNo02,
		ObjectID,
		WareHouseID,
		InventoryTypeID,
		EmployeeID,
		ContactPerson,
		RDAddress,
		DESCRIPTION,
		BarCode,
		InventoryID,
		UnitID,
		ReVoucherNo,
		SourceNo,
		LimitDate,
		ConvertedQuantity,
		ConvertedPrice,
		ActualQuantity,
		UnitPrice,
		OriginalAmount,
		DebitAccountID,
		CreditAccountID,
		Notes,
		ActEndQty,
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
		PeriodID,
		ProductID

		)
SELECT Row,
		DivisionID,
		Period,
		VoucherTypeID,
		VoucherNo,
		VoucherDate,
		RefNo01,
		RefNo02,
		ObjectID,
		WareHouseID,
		InventoryTypeID,
		EmployeeID,
		ContactPerson,
		RDAddress,
		DESCRIPTION,
		BarCode,
		InventoryID,
		UnitID,
		ReVoucherNo,
		SourceNo,
		LimitDate,
		CASE WHEN ISNULL(ConvertedQuantity,'') ='' THEN NULL ELSE CAST(ConvertedQuantity AS DECIMAL(28,8)) END ConvertedQuantity,
		CASE WHEN ISNULL(ConvertedPrice,'') ='' THEN NULL ELSE CAST(ConvertedPrice AS DECIMAL(28,8)) END ConvertedPrice,
		ActualQuantity,
		CASE WHEN ISNULL(UnitPrice,'') ='' THEN NULL ELSE CAST(UnitPrice AS DECIMAL(28,8)) END UnitPrice,
		CASE WHEN ISNULL(OriginalAmount,'') ='' THEN NULL ELSE CAST(OriginalAmount AS DECIMAL(28,8)) END OriginalAmount,
		DebitAccountID,
		CreditAccountID,
		Notes,
		CASE WHEN ISNULL(ActEndQty,'') ='' THEN NULL ELSE CAST(ActEndQty AS DECIMAL(28,8)) END ActEndQty,
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
		PeriodID,
		ProductID 
FROM #AP8124_MK WITH (NOLOCK)

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-WM', @ColID = 'VoucherNo', @Param1 = 'VoucherNo,VoucherDate,RefNo01,RefNo02,ObjectID,WareHouseID,InventoryTypeID,EmployeeID,ContactPerson,RDAddress,Description'

--- Kiểm tra xuất âm
IF (SELECT TOP 1 IsNegativeStock FROM WT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID) = 0
BEGIN
	SET @sSQL = 
	'	UPDATE	#DATA 
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''WFML000251 {0}=''''' + 'T' + '''''''
		WHERE	ActualQuantity
				+ ISNULL((Select SUM(A.ActualQuantity) FROM #DATA A
							Where A.InventoryID = #Data.InventoryID
								and A.CreditAccountID = #Data.CreditAccountID
								and A.WareHouseID = #Data.WareHouseID
								and A.Row < #Data.Row),0)
		
				> ISNULL((Select SUM(SignQuantity) From AV7000_MK WITH (NOLOCK) Where DivisionID = ''' + @DivisionID + '''
								and InventoryID = #Data.InventoryID 
								and InventoryAccountID = #Data.CreditAccountID
								and WareHouseID = #Data.WareHouseID
								and VoucherDate <= #Data.VoucherDate),0)
			'
	EXEC (@sSQL)
	--PRINT @sSQL
END

--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			OriginalAmount = ROUND(OriginalAmount, A.ConvertedDecimals),
			ConvertedQuantity = ROUND(ConvertedQuantity, A.QuantityDecimals),
			ConvertedPrice = ROUND(ConvertedPrice, A.UnitCostDecimals),
			ActEndQty = ROUND(ActEndQty, A.QuantityDecimals),
			ActualQuantity = ROUND(DT.ActualQuantity, A.QuantityDecimals),	
			UnitPrice = ROUND(DT.UnitPrice, A.UnitCostDecimals),	
			VoucherDate = CASE WHEN VoucherDate IS NOT NULL THEN CONVERT(datetime, CONVERT(DATE, VoucherDate)) END,
			LimitDate = CASE WHEN LimitDate IS NOT NULL THEN CONVERT(datetime, CONVERT(DATE, LimitDate)) END
FROM		#Data DT WITH (NOLOCK)
LEFT JOIN	AT1101 A WITH (NOLOCK) ON A.DivisionID = DT.DivisionID
			
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WITH (NOLOCK) WHERE ImportMessage <> '')
	GOTO LB_RESULT


-- Sinh khóa
DECLARE @cKey AS CURSOR
DECLARE @Row AS INT,
		@Orders AS INT,
		@VoucherNo AS NVARCHAR(50),
		@Period AS NVARCHAR(50),
		@VoucherGroup AS NVARCHAR(50)

DECLARE	@TransID AS NVARCHAR(50),
		@VoucherID AS NVARCHAR(50),
		@CurrencyID AS NVARCHAR(50),
		@ReVoucherID AS NVARCHAR(50)		

SET @cKey = CURSOR FOR
	SELECT	Row, VoucherNo, Period
	FROM	#Data WITH (NOLOCK)
		
OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row, @VoucherNo, @Period
WHILE @@FETCH_STATUS = 0
BEGIN
	--PRINT (@VoucherGroup)
	--PRINT (@VoucherNo)
	SET @Period = RIGHT(@Period, 4)
	IF @VoucherGroup IS NULL OR @VoucherGroup <> (@VoucherNo + '#' + @Period)
	BEGIN
		SET @Orders = 0
		EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @VoucherID OUTPUT, @TableName = 'AT2006', @StringKey1 = 'AD', @StringKey2 = @Period, @OutputLen = 16
		SET @VoucherGroup = (@VoucherNo + '#' + @Period)
	END
	SET @Orders = @Orders + 1
	EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @TransID OUTPUT, @TableName = 'AT2007', @StringKey1 = 'BD', @StringKey2 = @Period, @OutputLen = 16
	INSERT INTO #Keys (Row, Orders, VoucherID, TransactionID) VALUES (@Row, @Orders, @VoucherID, @TransID)				
	FETCH NEXT FROM @cKey INTO @Row, @VoucherNo, @Period
END	
CLOSE @cKey

-- Cập nhật khóa
UPDATE		DT
SET			Orders = K.Orders,
			DT.VoucherID = K.VoucherID ,
			DT.TransactionID = K.TransactionID			
FROM		#Data DT WITH (NOLOCK)
INNER JOIN	#Keys K WITH (NOLOCK)
		ON	K.Row = DT.Row

-- Cập nhật Loại tiền
SET @CurrencyID = (SELECT TOP 1 BaseCurrencyID FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
				
-- Kiểm tra trùng số chứng từ
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateOtherVoucherNo', @ColID = 'VoucherNo', @Param2 = 'AT2006', @Param3 = 'VoucherNo'

-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WITH (NOLOCK) WHERE ImportMessage <> '')
	GOTO LB_RESULT

-- Đẩy dữ liệu vào bảng master
INSERT INTO AT2006
(
	DivisionID,		VoucherID,		TableID,	TranMonth,	TranYear,
	VoucherTypeID,	VoucherDate,	VoucherNo,	ObjectID,	InventoryTypeID,
	WareHouseID,	KindVoucherID,	[Status],	EmployeeID,	[Description],
	RefNo01,		RefNo02,		RDAddress,	ContactPerson,
	CreateDate,		CreateUserID,	LastModifyUserID,	LastModifyDate
	
)

SELECT	DISTINCT
		DivisionID,		VoucherID,		'AT2006',	LEFT(Period, 2),RIGHT(Period, 4),
		VoucherTypeID,	VoucherDate,	VoucherNo,	ObjectID,		InventoryTypeID	,		
		WareHouseID,	2,				0,			EmployeeID,		[Description],
		RefNo01,		RefNo02,		RDAddress,	ContactPerson,
		GETDATE(),		@UserID,		@UserID,	GETDATE()	
FROM	#Data WITH (NOLOCK)

--- Đẩy dữ liệu vào bảng AT2007
INSERT INTO AT2007
(
	Orders,
	DivisionID,		TransactionID,	VoucherID,	
	TranMonth,		TranYear,		CurrencyID,		ExchangeRate,
	InventoryID,	UnitID,			ReVoucherID,	SourceNo,
	LimitDate,		ConvertedQuantity,				ConvertedPrice,
	ActualQuantity,	UnitPrice,		OriginalAmount,	ConvertedAmount,
	DebitAccountID,	CreditAccountID,				Notes,		
	Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
	Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,	Ana10ID,
	PeriodID,	ProductID, ConvertedUnitID, ReTransactionID

)
SELECT	D.Orders,	D.DivisionID,		D.TransactionID,		D.VoucherID,	
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),		@CurrencyID,		1,
		D.InventoryID,		D.UnitID,
		CASE WHEN B.ReVoucherID is not null AND B.ReTransactionID is not null OR B.EndQuantity is not null THEN B.ReVoucherID ELSE NULL END,
		D.SourceNo,
		CASE WHEN D.LimitDate = '' THEN NULL ELSE D.LimitDate END,		D.ConvertedQuantity,	D.ConvertedPrice,
		D.ActualQuantity,	D.UnitPrice,			D.OriginalAmount,	D.OriginalAmount,
		D.DebitAccountID,	D.CreditAccountID,		D.Notes,		
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,
		D.Ana06ID,	D.Ana07ID,	D.Ana08ID,	D.Ana09ID,	D.Ana10ID,
		D.PeriodID,	D.ProductID, D.UnitID,
		CASE WHEN B.ReVoucherID is not null AND B.ReTransactionID is not null OR B.EndQuantity is not null THEN B.ReTransactionID ELSE NULL END
FROM	#Data D WITH (NOLOCK)
LEFT JOIN AT0114 B WITH (NOLOCK) ON D.DivisionID = B.DivisionID AND D.WarehouseId = B.WareHouseID AND D.InventoryId = B.InventoryId AND D.ReVoucherNo = B.ReVoucherNo AND D.SourceNo = B.ReSourceNO 
WHERE NOT EXISTS (SELECT TOP 1 1 FROM AT2007 WITH (NOLOCK) WHERE DivisionID = D.DivisionID AND ReVoucherID = B.ReVoucherID and B.ReVoucherID is not null AND TransactionID = D.TransactionID and D.TransactionID is not null)

LB_RESULT:
SELECT * FROM #Data WITH (NOLOCK)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

