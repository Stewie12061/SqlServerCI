IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP8124_BS]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8124_BS]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Store customize Ba Son: Import phiếu xuất kho (cho trùng số chứng từ, chỉ tách phiếu khi khác kho)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 16/04/2018 by Bảo Anh
---- 
---- Modified on 05/03/2019 by Kim Thư: Tạo khóa chính cho table #Data và #Keys có nối với @@SPID để tránh trùng khóa chính khi nhiều user sử dụng
---- Modified on 30/08/2021 by Văn Tài: [2021/08/IS/0231] Xử lý vấn đề đặc biệt Description đầu vào giống nhau nhưng phát sinh khoảng trắng.
-- <Example>
----

CREATE PROCEDURE [DBO].[AP8124_BS]
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
	Orders INT,
	VoucherID NVARCHAR(50) NULL,
	TransactionID NVARCHAR(50),
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


INTO	#AP8124_BS		
FROM	@XML.nodes('//Data') AS X (Data)


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
		Description,
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
		Description,
		BarCode,
		InventoryID,
		UnitID,
		ReVoucherNo,
		SourceNo,
		LimitDate,
		SUM(CASE WHEN ISNULL(ConvertedQuantity,'') ='' THEN NULL ELSE CAST(ConvertedQuantity AS DECIMAL(28,8)) END) AS ConvertedQuantity,
		AVG(CASE WHEN ISNULL(ConvertedPrice,'') ='' THEN NULL ELSE CAST(ConvertedPrice AS DECIMAL(28,8)) END) AS ConvertedPrice,
		SUM(ActualQuantity) AS ActualQuantity,
		AVG(CASE WHEN ISNULL(UnitPrice,'') ='' THEN NULL ELSE CAST(UnitPrice AS DECIMAL(28,8)) END) AS UnitPrice,
		SUM(CASE WHEN ISNULL(OriginalAmount,'') ='' THEN NULL ELSE CAST(OriginalAmount AS DECIMAL(28,8)) END) AS OriginalAmount,
		DebitAccountID,
		CreditAccountID,
		Notes,
		SUM(CASE WHEN ISNULL(ActEndQty,'') ='' THEN NULL ELSE CAST(ActEndQty AS DECIMAL(28,8)) END) AS ActEndQty,
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
FROM #AP8124_BS
GROUP BY Row,DivisionID,Period,VoucherTypeID,VoucherNo,VoucherDate,RefNo01,RefNo02,ObjectID,WareHouseID,InventoryTypeID,EmployeeID,ContactPerson,
		RDAddress,Description,BarCode,InventoryID,UnitID,ReVoucherNo,SourceNo,LimitDate,DebitAccountID,CreditAccountID,Notes,
		Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,PeriodID,ProductID

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master
--EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-WM', @ColID = 'VoucherNo', @Param1 = 'VoucherNo,VoucherDate,RefNo01,RefNo02,ObjectID,WareHouseID,InventoryTypeID,EmployeeID,ContactPerson,RDAddress,Description'

--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			OriginalAmount = ROUND(OriginalAmount, A.ConvertedDecimals),
			ConvertedQuantity = ROUND(ConvertedQuantity, A.QuantityDecimals),
			ConvertedPrice = ROUND(ConvertedPrice, A.UnitCostDecimals),
			ActEndQty = ROUND(ActEndQty, A.QuantityDecimals),
			ActualQuantity = ROUND(DT.ActualQuantity, A.QuantityDecimals),	
			UnitPrice = ROUND(DT.UnitPrice, A.UnitCostDecimals),	
			VoucherDate = CASE WHEN VoucherDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), VoucherDate, 101)) END,
			LimitDate = CASE WHEN LimitDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), LimitDate, 101)) END
FROM		#Data DT
LEFT JOIN	AT1101 A WITH (NOLOCK) ON A.DivisionID = DT.DivisionID
			
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT


-- Sinh khóa
DECLARE @cKey AS CURSOR
DECLARE @Row AS INT,
		@Orders AS INT,
		@VoucherNo AS NVARCHAR(50),
		@Period AS NVARCHAR(50),
		@VoucherGroup AS NVARCHAR(50),
		@WarehouseID AS NVARCHAR(50)

DECLARE	@TransID AS NVARCHAR(50),
		@VoucherID AS NVARCHAR(50),
		@CurrencyID AS NVARCHAR(50),
		@ReVoucherID AS NVARCHAR(50)		

SET @cKey = CURSOR FOR
	SELECT	Row, VoucherNo, Period, WarehouseID
	FROM	#Data
		
OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row, @VoucherNo, @Period, @WarehouseID
WHILE @@FETCH_STATUS = 0
BEGIN
	--PRINT (@VoucherGroup)
	--PRINT (@VoucherNo)
	SET @Period = RIGHT(@Period, 4)
	IF @VoucherGroup IS NULL OR @VoucherGroup <> (@VoucherNo + '#' + @Period + '#' + @WarehouseID)
	BEGIN
		SET @Orders = 0
		EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @VoucherID OUTPUT, @TableName = 'AT2006', @StringKey1 = 'AD', @StringKey2 = @Period, @OutputLen = 16
		SET @VoucherGroup = (@VoucherNo + '#' + @Period + '#' + @WarehouseID)
	END
	SET @Orders = @Orders + 1
	EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @TransID OUTPUT, @TableName = 'AT2007', @StringKey1 = 'BD', @StringKey2 = @Period, @OutputLen = 16
	INSERT INTO #Keys (Row, Orders, VoucherID, TransactionID) VALUES (@Row, @Orders, @VoucherID, @TransID)				
	FETCH NEXT FROM @cKey INTO @Row, @VoucherNo, @Period, @WarehouseID
END	
CLOSE @cKey

-- Cập nhật khóa
UPDATE		DT
SET			Orders = K.Orders,
			DT.VoucherID = K.VoucherID ,
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

		
-- Cập nhật Loại tiền
SET @CurrencyID = (SELECT TOP 1 BaseCurrencyID FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
/*				
-- Kiểm tra trùng số chứng từ
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateOtherVoucherNo', @ColID = 'VoucherNo', @Param2 = 'AT2006', @Param3 = 'VoucherNo'

-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT
*/
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
		WareHouseID,	2,				0,			EmployeeID,		(SELECT TOP 1 Description FROM #Data D02 WHERE D02.DivisionID = D01.DivisionID AND D02.VoucherID = D01.VoucherID),
		RefNo01,		RefNo02,		RDAddress,	ContactPerson,
		GETDATE(),		@UserID,		@UserID,	GETDATE()	
FROM	#Data D01


INSERT INTO AT2007
(
	DivisionID,		TransactionID,	VoucherID,	
	TranMonth,		TranYear,		CurrencyID,		ExchangeRate,
	InventoryID,	UnitID,			ReVoucherID,	SourceNo,
	LimitDate,		ConvertedQuantity,				ConvertedPrice,
	ActualQuantity,	UnitPrice,		OriginalAmount,	ConvertedAmount,
	DebitAccountID,	CreditAccountID,				Notes,		
	Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
	Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,	Ana10ID,
	PeriodID,	ProductID, ConvertedUnitID

)
SELECT	D.DivisionID,		D.TransactionID,		D.VoucherID,	
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),		@CurrencyID,		1,
		D.InventoryID,		D.UnitID,				A.VoucherID,		D.SourceNo,
		CASE WHEN D.LimitDate = '' THEN NULL ELSE D.LimitDate END,		D.ConvertedQuantity,	D.ConvertedPrice,
		D.ActualQuantity,	D.UnitPrice,			D.OriginalAmount,	D.OriginalAmount,
		D.DebitAccountID,	D.CreditAccountID,		D.Notes,		
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,
		D.Ana06ID,	D.Ana07ID,	D.Ana08ID,	D.Ana09ID,	D.Ana10ID,
		D.PeriodID,	D.ProductID, D.UnitID
FROM	#Data D
LEFT JOIN AT2006 A WITH (NOLOCK) ON A.VoucherID = D.VoucherID AND A.DivisionID = D.DivisionID

LB_RESULT:
SELECT * FROM #Data


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

