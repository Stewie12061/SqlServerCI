IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP21410]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP21410]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Inport Yêu cầu mua hàng - PO
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 15/06/2023 by Đức Tuyên  import kế hoạch sản xuất.

-- <Example>
---- 
CREATE PROCEDURE MP21410
(	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTransTypeID AS NVARCHAR(50),
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
	TransactionID NVARCHAR(50),
	ImportMessage NVARCHAR(500) DEFAULT (''),
	ObjectName NVARCHAR(250),
	Address NVARCHAR(250),
	InventoryCommonName NVARCHAR(250),
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
    ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	StockCurrent DECIMAL (28,8),
	TranMonth INT,
	TranYear INT
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT NOT NULL,
	Orders INT,
	TransactionID NVARCHAR(50)--,	
	--CONSTRAINT ["PK_#Keys_" + @@SPID] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

-- Tạo khóa chính cho table #Data và #Keys
DECLARE @Keys_PK VARCHAR(50), @Data_PK VARCHAR(50),
		@SQL NVARCHAR(MAX);
--SET @Data_PK='PK_#Data_' + LTRIM(@@SPID);
--SET @Keys_PK='PK_#Keys_' + LTRIM(@@SPID);

--add constraint 
SET @SQL = 'ALTER TABLE #Data ADD CONSTRAINT ' + @Data_PK+ ' PRIMARY KEY(Row)
			ALTER TABLE #Keys ADD CONSTRAINT ' + @Keys_PK+ ' PRIMARY KEY(Row)'

EXEC(@SQL)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT		BTL.ColID, BTL.ColSQLDataType
	FROM		A01065 TL
	INNER JOIN	A00065 BTL
			ON	BTL.ImportTransTypeID = TL.ImportTemplateID
	WHERE		TL.ImportTemplateID = @ImportTransTypeID
	ORDER BY	BTL.OrderNum

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

SELECT	X.Data.query('OrderNo').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,
		X.Data.query('VoucherTypeID').value('.', 'NVARCHAR(50)') AS VoucherTypeID,
		X.Data.query('RequestNo').value('.', 'NVARCHAR(50)') AS RequestNo,
		CASE WHEN ISNULL(X.Data.query('RequestDate').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('RequestDate').value('.', 'VARCHAR(20)'), 103) END AS RequestDate,
		X.Data.query('ContractNo').value('.', 'NVARCHAR(50)') AS ContractNo,
		CASE WHEN ISNULL(X.Data.query('ContractDate').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('ContractDate').value('.', 'VARCHAR(20)'), 103) END AS ContractDate,
		X.Data.query('CurrencyID').value('.', 'NVARCHAR(50)') AS CurrencyID,
		X.Data.query('ExchangeRate').value('.', 'DECIMAL(28,8)') AS ExchangeRate,
		X.Data.query('ClassifyID').value('.', 'NVARCHAR(50)') AS ClassifyID,
		X.Data.query('Status').value('.', 'NVARCHAR(50)') AS Status,
		CASE WHEN ISNULL(X.Data.query('MasterShipDate').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('MasterShipDate').value('.', 'VARCHAR(20)'), 103) END AS MasterShipDate,
		X.Data.query('InventoryTypeID').value('.', 'NVARCHAR(50)') AS InventoryTypeID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('Description').value('.', 'NVARCHAR(250)') AS Description,
		CASE WHEN ISNULL(X.Data.query('DueDate').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('DueDate').value('.', 'VARCHAR(20)'), 103) END AS DueDate,
		X.Data.query('OrderAddress').value('.', 'NVARCHAR(250)') AS OrderAddress,
		X.Data.query('ReceivedAddress').value('.', 'NVARCHAR(250)') AS ReceivedAddress,
		X.Data.query('Transport').value('.', 'NVARCHAR(250)') AS Transport,
		X.Data.query('PaymentID').value('.', 'NVARCHAR(250)') AS PaymentID,
		X.Data.query('POAna01ID').value('.', 'NVARCHAR(250)') AS POAna01ID,
		X.Data.query('POAna02ID').value('.', 'NVARCHAR(250)') AS POAna02ID,
		X.Data.query('POAna03ID').value('.', 'NVARCHAR(250)') AS POAna03ID,
		X.Data.query('POAna04ID').value('.', 'NVARCHAR(250)') AS POAna04ID,
		X.Data.query('POAna05ID').value('.', 'NVARCHAR(250)') AS POAna05ID,
		X.Data.query('InventoryID').value('.', 'NVARCHAR(250)') AS InventoryID,
		X.Data.query('UnitID').value('.', 'NVARCHAR(250)') AS UnitID,
		X.Data.query('ConvertedQuantity').value('.', 'DECIMAL(28,8)') AS ConvertedQuantity,
		X.Data.query('ConvertedSaleprice').value('.', 'DECIMAL(28,8)') AS ConvertedSaleprice,
		X.Data.query('OrderQuantity').value('.', 'DECIMAL(28,8)') AS OrderQuantity,
		X.Data.query('RequestPrice').value('.', 'DECIMAL(28,8)') AS RequestPrice,
		X.Data.query('OriginalAmount').value('.', 'DECIMAL(28,8)') AS OriginalAmount,
		X.Data.query('ConvertedAmount').value('.', 'DECIMAL(28,8)') AS ConvertedAmount,
		X.Data.query('VATPercent').value('.', 'NVARCHAR(250)') AS VATPercent,
		X.Data.query('VATOriginalAmount').value('.', 'NVARCHAR(250)') AS VATOriginalAmount,
		X.Data.query('VATConvertedAmount').value('.', 'NVARCHAR(250)') AS VATConvertedAmount,
		X.Data.query('DetailDescription').value('.', 'NVARCHAR(250)') AS DetailDescription,
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
		X.Data.query('Notes').value('.', 'NVARCHAR(50)') AS Notes,
		X.Data.query('Notes01').value('.', 'NVARCHAR(250)') AS Notes01,
		X.Data.query('Notes02').value('.', 'NVARCHAR(250)') AS Notes02,
		X.Data.query('S01ID').value('.', 'NVARCHAR(50)') AS S01ID,
		X.Data.query('S02ID').value('.', 'NVARCHAR(50)') AS S02ID,
		X.Data.query('S03ID').value('.', 'NVARCHAR(50)') AS S03ID,
		X.Data.query('S04ID').value('.', 'NVARCHAR(50)') AS S04ID,
		X.Data.query('S05ID').value('.', 'NVARCHAR(50)') AS S05ID,
		X.Data.query('S06ID').value('.', 'NVARCHAR(50)') AS S06ID,
		X.Data.query('S07ID').value('.', 'NVARCHAR(50)') AS S07ID,
		X.Data.query('S08ID').value('.', 'NVARCHAR(50)') AS S08ID,
		X.Data.query('S09ID').value('.', 'NVARCHAR(50)') AS S09ID,
		X.Data.query('S10ID').value('.', 'NVARCHAR(50)') AS S10ID,
		X.Data.query('S11ID').value('.', 'NVARCHAR(50)') AS S11ID,
		X.Data.query('S12ID').value('.', 'NVARCHAR(50)') AS S12ID,
		X.Data.query('S13ID').value('.', 'NVARCHAR(50)') AS S13ID,
		X.Data.query('S14ID').value('.', 'NVARCHAR(50)') AS S14ID,
		X.Data.query('S15ID').value('.', 'NVARCHAR(50)') AS S15ID,
		X.Data.query('S16ID').value('.', 'NVARCHAR(50)') AS S16ID,
		X.Data.query('S17ID').value('.', 'NVARCHAR(50)') AS S17ID,
		X.Data.query('S18ID').value('.', 'NVARCHAR(50)') AS S18ID,
		X.Data.query('S19ID').value('.', 'NVARCHAR(50)') AS S19ID,
		X.Data.query('S20ID').value('.', 'NVARCHAR(50)') AS S20ID,
		X.Data.query('PriorityID').value('.', 'NVARCHAR(50)') AS PriorityID,
		X.Data.query('ApprovePerson01').value('.', 'NVARCHAR(50)') AS ApprovePerson01,
		X.Data.query('ApprovePerson02').value('.', 'NVARCHAR(50)') AS ApprovePerson02,
		X.Data.query('ApprovePerson03').value('.', 'NVARCHAR(50)') AS ApprovePerson03,
		X.Data.query('ApprovePerson04').value('.', 'NVARCHAR(50)') AS ApprovePerson04,
		X.Data.query('ApprovePerson05').value('.', 'NVARCHAR(50)') AS ApprovePerson05,
		X.Data.query('ApprovePerson06').value('.', 'NVARCHAR(50)') AS ApprovePerson06,
		X.Data.query('ApprovePerson07').value('.', 'NVARCHAR(50)') AS ApprovePerson07,
		X.Data.query('ApprovePerson08').value('.', 'NVARCHAR(50)') AS ApprovePerson08,
		X.Data.query('ApprovePerson09').value('.', 'NVARCHAR(50)') AS ApprovePerson09,
		X.Data.query('ApprovePerson10').value('.', 'NVARCHAR(50)') AS ApprovePerson10,
		CAST(SUBSTRING(X.Data.query('Period').value('.', 'VARCHAR(10)'), 1, 2) AS INT) AS TranMonth,
		CAST(SUBSTRING(X.Data.query('Period').value('.', 'VARCHAR(10)'), 4, 4) AS INT) AS TranYear

INTO	#MP21410	
FROM	@XML.nodes('//Data') AS X (Data)



INSERT INTO #Data (
		Row,
		DivisionID,
		Period,
		VoucherTypeID,
		RequestNo,
		RequestDate,
		ContractNo,
		ContractDate,
		CurrencyID,
		ExchangeRate,
		ClassifyID,
		[Status],
		MasterShipDate,
		InventoryTypeID,
		EmployeeID,
		[Description],
		DueDate,
		OrderAddress,
		ReceivedAddress,
		Transport,
		PaymentID,
		POAna01ID,
		POAna02ID,
		POAna03ID,
		POAna04ID,
		POAna05ID,
		InventoryID,
		UnitID,
		ConvertedQuantity,
		ConvertedSaleprice,
		OrderQuantity,
		RequestPrice,
		OriginalAmount,
		ConvertedAmount,
		VATPercent,
		VATOriginalAmount,
		VATConvertedAmount,
		DetailDescription,
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
		Notes,
		Notes01,
		Notes02,
		 S01ID,
		 S02ID,
		 S03ID,
		 S04ID,
		 S05ID,
		 S06ID,
		 S07ID,
		 S08ID,
		 S09ID,
		 S10ID,
		 S11ID,
		 S12ID,
		 S13ID,
		 S14ID,
		 S15ID,
		 S16ID,
		 S17ID,
		 S18ID,
		 S19ID,
		 S20ID,
		 PriorityID,
		 ApprovePerson01,
		 ApprovePerson02,
		 ApprovePerson03,
		 ApprovePerson04,
		 ApprovePerson05,
		 ApprovePerson06,
		 ApprovePerson07,
		 ApprovePerson08,
		 ApprovePerson09,
		 ApprovePerson10,
		 TranMonth,
		 TranYear
		)
SELECT Row,
		DivisionID,
		Period,
		VoucherTypeID,
		RequestNo,
		RequestDate,
		ContractNo,
		ContractDate,
		CurrencyID,
		ExchangeRate,
		ClassifyID,
		CASE WHEN ISNULL([Status],'') = '' THEN NULL ELSE CAST([Status] AS TINYINT) END [Status],
		MasterShipDate,
		InventoryTypeID,
		EmployeeID,
		[Description],
		DueDate,
		OrderAddress,
		ReceivedAddress,
		Transport,
		PaymentID,
		POAna01ID,
		POAna02ID,
		POAna03ID,
		POAna04ID,
		POAna05ID,
		InventoryID,
		UnitID,
		ConvertedQuantity,
		ConvertedSaleprice,
		OrderQuantity,
		RequestPrice,
		OriginalAmount,
		ConvertedAmount,
		CASE WHEN ISNULL(VATPercent,'') = '' THEN NULL ELSE CAST(VATPercent AS DECIMAL(28,8)) END VATPercent,
		CASE WHEN ISNULL(VATOriginalAmount,'') = '' THEN NULL ELSE CAST(VATOriginalAmount AS DECIMAL(28,8)) END VATOriginalAmount,
		CASE WHEN ISNULL(VATConvertedAmount,'') = '' THEN NULL ELSE CAST(VATConvertedAmount AS DECIMAL(28,8)) END VATConvertedAmount,
		DetailDescription,
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
		Notes,
		Notes01,
		Notes02,
		S01ID,
		S02ID,
		S03ID,
		S04ID,
		S05ID,
		S06ID,
		S07ID,
		S08ID,
		S09ID,
		S10ID,
		S11ID,
		S12ID,
		S13ID,
		S14ID,
		S15ID,
		S16ID,
		S17ID,
		S18ID,
		S19ID,
		S20ID,
		PriorityID,
		ApprovePerson01,
		ApprovePerson02,
		ApprovePerson03,
		ApprovePerson04,
		ApprovePerson05,
		ApprovePerson06,
		ApprovePerson07,
		ApprovePerson08,
		ApprovePerson09,
		ApprovePerson10,
		TranMonth,
		TranYear
FROM #MP21410

---- Kiểm tra check code mặc định
--EXEC AP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master
--EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-OP', @ColID = 'RequestNo', @Param1 = 'RequestNo,RequestDate,ContractNo,ContractDate,CurrencyID,ExchangeRate,ClassifyID,MasterShipDate,InventoryTypeID,EmployeeID,Description,ObjectID,DueDate,OrderAddress,ReceivedAddress,Transport,PaymentID,POAna01ID,POAna02ID,POAna03ID,POAna04ID,POAna05ID'


---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
        @ColName1 NVARCHAR(50),
        @Cur CURSOR,
        @InventoryID_01 VARCHAR(50),
		@UnitID NVARCHAR(50),
		@InventoryID NVARCHAR(50),
		@Row_tmp INT

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'RequestNo'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT  [Row], RequestNo, UnitID, InventoryID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row_tmp, @InventoryID_01, @UnitID, @InventoryID

WHILE @@FETCH_STATUS = 0
BEGIN

    ---- Kiểm tra trùng mã chứng từ
    IF EXISTS (SELECT TOP  1 1 FROM OT3102 WITH (NOLOCK) WHERE ROrderID = @InventoryID_01)
    BEGIN
        UPDATE #Data 
        SET ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR(@Row_tmp))) +'-POFML000018,',
                ErrorColumn = @ColName1 + ','
		BREAK
    END

	-- Kiểm tra có đơn vị tính
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1302 WHERE UnitID = @UnitID AND InventoryID = @InventoryID)
	BEGIN
		UPDATE #Data 
        SET ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR(@Row_tmp))) +'-POFML000017,',
                ErrorColumn = @ColName1 + ','
		BREAK
	END

    FETCH NEXT FROM @Cur INTO @Row_tmp, @InventoryID_01, @UnitID, @InventoryID
END

CLOSE @Cur

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
        UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
                            ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
        WHERE ErrorMessage <> ''
        GOTO LB_RESULT
END

---- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			ConvertedAmount = ROUND(ConvertedAmount, CUR.ConvertedDecimals),
			OriginalAmount = ROUND(OriginalAmount, CUR.OriginalDecimal),

			VATConvertedAmount = ROUND(VATConvertedAmount, CUR.ConvertedDecimals),
			VATOriginalAmount = ROUND(VATOriginalAmount, CUR.OriginalDecimal),
			
			ConvertedQuantity = ROUND(DT.ConvertedQuantity, CUR.QuantityDecimals),		
			OrderQuantity = ROUND(DT.OrderQuantity, CUR.QuantityDecimals),	
			RequestPrice = ROUND(DT.RequestPrice, CUR.UnitCostDecimals),	
			ConvertedSaleprice = ROUND(DT.ConvertedSaleprice, CUR.UnitCostDecimals),	
			ExchangeRate = ROUND(DT.ExchangeRate, CUR.ExchangeRateDecimal)
			,			
			MasterShipDate = CASE WHEN MasterShipDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), MasterShipDate, 101)) END,
			RequestDate = CASE WHEN RequestDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), RequestDate, 101)) END,
			ContractDate = CASE WHEN ContractDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), ContractDate, 101)) END,
			ClassifyID = CASE WHEN ISNULL(ClassifyID, '') = '' THEN NULL ELSE ClassifyID END
FROM		#Data DT
INNER JOIN	AV1004 CUR 
		ON	CUR.CurrencyID = DT.CurrencyID AND CUR.DivisionID In (DT.DivisionID,'@@@')

-- Cập nhật tên và địa chỉ đối tượng
--UPDATE		DT
--SET			ObjectName = OB.ObjectName,
--			Address = OB.Address 		
--FROM		#Data DT
--INNER JOIN	AT1202 OB
--		ON	OB.ObjectID = DT.ObjectID

-- Cập nhật tên hàng hóa
UPDATE		DT
SET			InventoryCommonName = INV.InventoryName	
FROM		#Data DT
INNER JOIN	AT1302 INV
		ON	INV.DivisionID IN (DT.DivisionID,'@@@') AND INV.InventoryID = DT.InventoryID
			
 --Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
        UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
                            ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
        WHERE ErrorMessage <> ''
        GOTO LB_RESULT
END

-- Sinh khóa
DECLARE @cKey AS CURSOR
DECLARE @Row AS INT,
		@Orders AS INT,
		@RequestNo AS NVARCHAR(50),
		@Period AS NVARCHAR(50),
		@RequestGroup AS NVARCHAR(50)

DECLARE	@TransID AS NVARCHAR(50)			

SET @cKey = CURSOR FOR
	SELECT	Row, RequestNo, Period
	FROM	#Data
		
OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row, @RequestNo, @Period
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Period = RIGHT(@Period, 4)
	IF @RequestGroup IS NULL OR @RequestGroup <> @RequestNo
	BEGIN
		SET @Orders = 0
		SET @RequestGroup = @RequestNo
	END
	SET @Orders = @Orders + 1
	EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @TransID OUTPUT, @TableName = 'OT3002', @StringKey1 = 'OT', @StringKey2 = @Period, @OutputLen = 16
	INSERT INTO #Keys (Row, Orders, TransactionID) VALUES (@Row, @Orders, @TransID)				
	FETCH NEXT FROM @cKey INTO @Row, @RequestNo, @Period
END	
CLOSE @cKey

-- Cập nhật khóa
UPDATE		DT
SET			Orders = K.Orders,
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
--PRINT(@SQL)
EXEC(@SQL)

			
-- Kiểm tra trùng số chứng từ
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateOtherVoucherNo', @ColID = 'RequestNo', @Param2 = 'OT3101', @Param3 = 'VoucherNo'

-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT


DECLARE @APK_OT9 uniqueidentifier, @cCur CURSOR
DECLARE @Period_M VARCHAR(10) , @VoucherTypeID_M NVARCHAR(50), @RequestNo_M NVARCHAR(50),	@OrderDate_M DATETIME, @ClassifyID_M NVARCHAR(50),
		@InventoryTypeID_M NVARCHAR(50), @CurrencyID_M NVARCHAR(50), @ExchangeRate_M DECIMAL(28), @ReceivedAddress_M NVARCHAR(250), @OrderStatus_M TINYINT, @ShipDate_M DATETIME, @EmployeeID_M NVARCHAR(50),
		@Description_M NVARCHAR(250), @DueDate_M DATETIME, @Address_M NVARCHAR(250), @Transport_M NVARCHAR(100), @PaymentID_M NVARCHAR(50), @Ana01ID_M NVARCHAR(50), @Ana02ID_M NVARCHAR(50), @Ana03ID_M NVARCHAR(50), @Ana04ID_M NVARCHAR(50), @Ana05ID_M NVARCHAR(50),
		@CreateUserID_M NVARCHAR(50), @CreateDate_M DATETIME, @LastModifyUserID_M NVARCHAR(50), @LastModifyDate_M DATETIME, @PriorityID_M NVARCHAR(10), @ContractNo_M NVARCHAR(50), @ContractDate_M DATETIME

SET @cCur = CURSOR SCROLL KEYSET FOR
			SELECT DISTINCT [Period], VoucherTypeID, RequestNo, RequestDate,ContractNo, ContractDate, ClassifyID, [Status], CurrencyID, ExchangeRate, InventoryTypeID, EmployeeID, [Description], DueDate, OrderAddress, ReceivedAddress,
							Transport, PaymentID, POAna01ID, POAna02ID, POAna03ID, POAna04ID, POAna05ID, PriorityID, MasterShipDate
			FROM #Data

OPEN @cCur
FETCH NEXT FROM @cCur INTO @Period_M, @VoucherTypeID_M, @RequestNo_M, @OrderDate_M, @ContractNo_M, @ContractDate_M, @ClassifyID_M, @OrderStatus_M, @CurrencyID_M, @ExchangeRate_M, @InventoryTypeID_M, @EmployeeID_M, @Description_M, @DueDate_M, @Address_M, @ReceivedAddress_M,
							@Transport_M, @PaymentID_M, @Ana01ID_M, @Ana02ID_M, @Ana03ID_M, @Ana04ID_M, @Ana05ID_M, @PriorityID_M, @ShipDate_M

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @APK_OT9 = NEWID()
	INSERT INTO OT3101
	(		DivisionID,			TranMonth,			TranYear,
			VoucherTypeID,		VoucherNo,			ROrderID,			OrderDate,
			ContractNo,			ContractDate,
			ClassifyID,			OrderStatus,		ShipDate,			
			CurrencyID,			ExchangeRate,
			InventoryTypeID,	EmployeeID,			[Description],
			DueDate,			[Address],			ReceivedAddress,	
			Transport,			PaymentID,
			Ana01ID,			Ana02ID,			Ana03ID,			Ana04ID,		Ana05ID,
			CreateUserID,		Createdate,			LastModifyUserID,	LastModifyDate,
			[Disabled],			OrderType,			PriorityID,			APKMaster_9000
	)
	VALUES(
			@DivisionID,		LEFT(@Period_M, 2), RIGHT(@Period_M, 4),
			@VoucherTypeID_M,	@RequestNo_M,		@RequestNo_M,		@OrderDate_M,
			@ContractNo_M,		@ContractDate_M,
			@ClassifyID_M,		@OrderStatus_M,		@ShipDate_M, 
			@CurrencyID_M,		@ExchangeRate_M,
			@InventoryTypeID_M ,@EmployeeID_M,		@Description_M,
			@DueDate_M,			@Address_M,			@ReceivedAddress_M,
			@Transport_M,		@PaymentID_M,		
			@Ana01ID_M,			@Ana02ID_M,			@Ana03ID_M,			@Ana04ID_M,		@Ana05ID_M,
			@UserID,			GETDATE(),			@UserID,			GETDATE(),
			0,					0,					@PriorityID_M,		@APK_OT9
	)
	------------------------------------------------------------------------------------------------
	-- insert cấp người duyệt

	 --Insert OOT9000
	INSERT INTO OOT9000
	(
		APK,					[Status],					DeleteFlag,				AppoveLevel,
		ApprovingLevel,			AskForVehicle,				UseVehicle,				HaveLunch,
		WorkType,				TranMonth,					TranYear,				CreateDate,
		LastModifyDate,			DivisionID,					ID,						DepartmentID,
		Type,					CreateUserID,				LastModifyUserID,		Description
	)
	VALUES(

		@APK_OT9,				@OrderStatus_M,				0,						0,
		0,						0,							0,						0,
		0,						LEFT(@Period_M, 2),			RIGHT(@Period_M, 4),	GETDATE(),
		GETDATE(),				@DivisionID,				@RequestNo_M,			N'',
		N'YCMH',				@UserID,					@UserID,				N''
	)

	-- Insert OOT9001

	INSERT OOT9001
	(
		DivisionID,				APKMaster,					ApprovePersonID,
		[Level],				Note,						DeleteFlag,				[Status],
		IsWatched
	)
	SELECT DISTINCT
		DivisionID,				@APK_OT9,					ApprovePerson01,
		1,						N'',						0,						[Status],
		0
	FROM #Data
	WHERE RequestNo = @RequestNo_M

	-- insert bảng detail

	INSERT INTO OT3102
	(
		DivisionID,				TransactionID,				ROrderID,				Orders,
		InventoryID,			UnitID,
		ConvertedQuantity,		ConvertedSaleprice,
		OrderQuantity,			RequestPrice,
		OriginalAmount,			ConvertedAmount,
	--	DiscountPercent,		DiscountOriginalAmount,		DiscountConvertedAmount,
		VATPercent,				VATOriginalAmount,			VATConvertedAmount,				
		Description,			
		Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,		Ana05ID,
		Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,		Ana10ID,
		Notes,		Notes01,	Notes02	,	StockCurrent,	DeleteFlag,
		ApproveLevel,	ApprovingLevel,		APKMaster_9000

	)
	SELECT	
		DivisionID,			TransactionID,				RequestNo,				Orders,
		InventoryID,			UnitID,
		ConvertedQuantity,		ConvertedSaleprice,
		OrderQuantity,			RequestPrice,
		OriginalAmount,			ConvertedAmount,
	--	DiscountPercent,		DiscountOriginalAmount,		DiscountConvertedAmount,
		VATPercent,				VATOriginalAmount,			VATConvertedAmount,
		DetailDescription,			
		Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
		Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,	Ana10ID,
		Notes,		Notes01,	Notes02,    StockCurrent,	0,
		1,			0,			@APK_OT9
	FROM #Data
	WHERE RequestNo = @RequestNo_M

	FETCH NEXT FROM @cCur INTO @Period_M, @VoucherTypeID_M, @RequestNo_M, @OrderDate_M, @ContractNo_M, @ContractDate_M, @ClassifyID_M, @OrderStatus_M, @CurrencyID_M, @ExchangeRate_M, @InventoryTypeID_M, @EmployeeID_M, @Description_M, @DueDate_M, @Address_M, @ReceivedAddress_M,
							@Transport_M, @PaymentID_M, @Ana01ID_M, @Ana02ID_M, @Ana03ID_M, @Ana04ID_M, @Ana05ID_M, @PriorityID_M, @ShipDate_M
END



--UPDATE AT4444
--SET LastKey = (SELECT SUBSTRING(MAX(VoucherNo), 4, 8) FROM OT3101)
--WHERE TableName = 'OT3101' AND KEYSTRING = 'YCM'

DECLARE  
		@CurDetail CURSOR, 
		@Row1 AS INT

SET @CurDetail = CURSOR SCROLL KEYSET FOR
SELECT Row,InventoryID FROM #Data

OPEN @CurDetail
FETCH NEXT FROM @CurDetail INTO  @Row1,@InventoryID

WHILE @@FETCH_STATUS = 0
BEGIN



	declare @a as int
----Load thông tin tồn kho hiện tại 
	SELECT @a = SUM(SignQuantity)
	FROM AV7000
	WHERE CONVERT(VARCHAR(10), CONVERT(DATE,VoucherDate,120), 126) <= 'GETDATE'
	AND InventoryID = @InventoryID 
	AND (WarehouseID  LIKE 'CT%' OR WarehouseID LIKE 'NM%')
	GROUP BY InventoryID

UPDATE #Data
SET StockCurrent = @a
WHERE InventoryID = @InventoryID
 
	FETCH NEXT FROM @CurDetail INTO @Row,@InventoryID


END	
CLOSE @CurDetail

----------- INSERT khoan muc

DECLARE @AnaCur AS CURSOR
DECLARE @Ana01ID NVARCHAR(50),
		@Ana02ID NVARCHAR(50),
		@Ana03ID NVARCHAR(50),
		@Ana04ID NVARCHAR(50),
		@Ana05ID NVARCHAR(50),
		@Ana06ID NVARCHAR(50),
		@Ana07ID NVARCHAR(50),
		@Ana08ID NVARCHAR(50),
		@Ana09ID NVARCHAR(50),
		@Ana10ID NVARCHAR(50)
		

SET @AnaCur = CURSOR FOR
	SELECT	Row , Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
			Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,	Ana10ID
	FROM	#Data
		
OPEN @AnaCur
FETCH NEXT FROM @AnaCur INTO 	@Row, @Ana01ID,	@Ana02ID,	@Ana03ID,	@Ana04ID,	@Ana05ID,
							@Ana06ID,	@Ana07ID,	@Ana08ID,	@Ana09ID,	@Ana10ID
WHILE @@FETCH_STATUS = 0
BEGIN
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE (AnaTypeID = 'A01' AND AnaID = @Ana01ID AND DivisionID = @DivisionID) OR ISNULL(@Ana01ID, '') = '')
	INSERT INTO AT1011 (DivisionID, AnaTypeID, AnaID, AnaName,
			CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	VALUES (@DivisionID, 'A01', @Ana01ID, @Ana01ID,
			@UserID, GETDATE(), @UserID, GETDATE())
			
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE (AnaTypeID = 'A02' AND AnaID = @Ana02ID AND DivisionID = @DivisionID) OR ISNULL(@Ana02ID, '') = '')
	INSERT INTO AT1011 (DivisionID, AnaTypeID, AnaID, AnaName,
			CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	VALUES (@DivisionID, 'A02', @Ana02ID, @Ana02ID,
			@UserID, GETDATE(), @UserID, GETDATE())

	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE (AnaTypeID = 'A03' AND AnaID = @Ana03ID AND DivisionID = @DivisionID) OR ISNULL(@Ana03ID, '') = '')
	INSERT INTO AT1011 (DivisionID, AnaTypeID, AnaID, AnaName,
			CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	VALUES (@DivisionID, 'A03', @Ana03ID, @Ana03ID,
			@UserID, GETDATE(), @UserID, GETDATE())
			
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE (AnaTypeID = 'A04' AND AnaID = @Ana04ID AND DivisionID = @DivisionID) OR ISNULL(@Ana04ID, '') = '')
	INSERT INTO AT1011 (DivisionID, AnaTypeID, AnaID, AnaName,
			CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	VALUES (@DivisionID, 'A04', @Ana04ID, @Ana04ID,
			@UserID, GETDATE(), @UserID, GETDATE())

	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE (AnaTypeID = 'A05' AND AnaID = @Ana05ID AND DivisionID = @DivisionID) OR ISNULL(@Ana05ID, '') = '')
	INSERT INTO AT1011 (DivisionID, AnaTypeID, AnaID, AnaName,
			CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	VALUES (@DivisionID, 'A05', @Ana05ID, @Ana05ID,
			@UserID, GETDATE(), @UserID, GETDATE())
			
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE (AnaTypeID = 'A06' AND AnaID = @Ana06ID AND DivisionID = @DivisionID) OR ISNULL(@Ana06ID, '') = '')
	INSERT INTO AT1011 (DivisionID, AnaTypeID, AnaID, AnaName,
			CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	VALUES (@DivisionID, 'A06', @Ana06ID, @Ana06ID,
			@UserID, GETDATE(), @UserID, GETDATE())

	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE (AnaTypeID = 'A07' AND AnaID = @Ana07ID AND DivisionID = @DivisionID) OR ISNULL(@Ana07ID, '') = '')
	INSERT INTO AT1011 (DivisionID, AnaTypeID, AnaID, AnaName,
			CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	VALUES (@DivisionID, 'A07', @Ana07ID, @Ana07ID,
			@UserID, GETDATE(), @UserID, GETDATE())
			
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE (AnaTypeID = 'A08' AND AnaID = @Ana08ID AND DivisionID = @DivisionID) OR ISNULL(@Ana08ID, '') = '')
	INSERT INTO AT1011 (DivisionID, AnaTypeID, AnaID, AnaName,
			CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	VALUES (@DivisionID, 'A08', @Ana08ID, @Ana08ID,
			@UserID, GETDATE(), @UserID, GETDATE())
			
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE (AnaTypeID = 'A09' AND AnaID = @Ana09ID AND DivisionID = @DivisionID) OR ISNULL(@Ana09ID, '') = '')
	INSERT INTO AT1011 (DivisionID, AnaTypeID, AnaID, AnaName,
			CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	VALUES (@DivisionID, 'A09', @Ana09ID, @Ana09ID,
			@UserID, GETDATE(), @UserID, GETDATE())
			
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE (AnaTypeID = 'A10' AND AnaID = @Ana10ID AND DivisionID = @DivisionID) OR ISNULL(@Ana10ID, '') = '')
	INSERT INTO AT1011 (DivisionID, AnaTypeID, AnaID, AnaName,
			CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	VALUES (@DivisionID, 'A10', @Ana10ID, @Ana10ID,
			@UserID, GETDATE(), @UserID, GETDATE())

				
	FETCH NEXT FROM @AnaCur INTO @Row ,@Ana01ID,	@Ana02ID,	@Ana03ID,	@Ana04ID,	@Ana05ID,
								@Ana06ID,	@Ana07ID,	@Ana08ID,	@Ana09ID,	@Ana10ID
END	
CLOSE @AnaCur

PRINT (@SQL)
EXEC(@SQL)



LB_RESULT:

SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

