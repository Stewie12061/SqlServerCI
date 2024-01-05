IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
-- Import Excel nghiệp vụ Đơn hàng bán ERP9
 --<Param>
-- 
 --<Return>
-- 
 --<Reference>
-- 
 --<History>
-- Created by Viết Toàn on 17/02/2023
-- Update by Viết Toàn on 01/04/2023 - Bỏ tăng chứng từ tự động, lấy theo khách hàng nhập + Không cập nhật khóa khi người duyệt là người tạo đơn
-- Update by Viết Toàn	on 25/05/2023 - Check kiểm tra báo giá không khác null
-- Modified by on
 --<Example>
CREATE PROCEDURE SOP20009
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth int,
	@TranYear int,
	@ImportTransTypeID VARCHAR(50),
	@ImportTemplateID AS NVARCHAR(50),
	@XML XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000),
		@ApprovePersonID NVARCHAR(50)
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50)
		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,
	Orders INT,
	SOrderID UNIQUEIDENTIFIER DEFAULT (NEWID()),
	TransactionID UNIQUEIDENTIFIER DEFAULT (NEWID()),
	ImportMessage NVARCHAR(MAX) DEFAULT (''),
    ErrorMessage NVARCHAR(MAX) DEFAULT (''),
    ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT NOT NULL,	
	Orders INT,
	SOrderID NVARCHAR(50),
	TransactionID NVARCHAR(50),
	VoucherNo NVARCHAR(50),
	Period NVARCHAR(50),
	InventoryID NVARCHAR(50),
	UnitID NVARCHAR(50)
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
	SELECT A00065.ColID, A00065.ColSQLDataType
	FROM A01065 WITH (NOLOCK)
	INNER JOIN A00065 WITH (NOLOCK) ON A01065.ImportTemplateID = A00065.ImportTransTypeID
	WHERE A01065.ImportTemplateID = @ImportTransTypeID
	ORDER BY A00065.OrderNum

OPEN @cCURSOR

 --Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
CLOSE @cCURSOR

-- Thêm cột BarCode

SELECT  
		X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('VoucherNo').value('.', 'NVARCHAR(50)') AS VoucherNo,
		X.Data.query('VoucherTypeID').value('.', 'NVARCHAR(50)') AS VoucherTypeID,
		CONVERT(DateTime, X.Data.query('OrderDate').value('.','NVARCHAR(50)'), 103) AS OrderDate,
		X.Data.query('ContractNo').value('.','NVARCHAR(50)') AS ContractNo,
		CONVERT(DateTime, X.Data.query('ContractDate').value('.','NVARCHAR(50)'), 103) AS ContractDate,
		X.Data.query('CurrencyID').value('.','NVARCHAR(50)') AS CurrencyID,
		X.Data.query('ExchangeRate').value('.','DECIMAL(28,8)') AS ExchangeRate,
		X.Data.query('OrderStatus').value('.','DECIMAL(28,8)') AS OrderStatus,
		CONVERT(DateTime, X.Data.query('ShipDate').value('.','NVARCHAR(50)'), 103) AS ShipDate,
		X.Data.query('ClassifyID').value('.','NVARCHAR(50)') AS ClassifyID,
		X.Data.query('InventoryTypeID').value('.','NVARCHAR(50)') AS InventoryTypeID,
		X.Data.query('ObjectID').value('.','NVARCHAR(250)') AS ObjectID,
		X.Data.query('Contact').value('.','NVARCHAR(100)') AS Contact,
		X.Data.query('DeliveryAddress').value('.','NVARCHAR(250)') AS DeliveryAddress,
		X.Data.query('Transport').value('.','NVARCHAR(250)') AS Transport,
		X.Data.query('PriceListID').value('.','NVARCHAR(50)') AS PriceListID,
		CONVERT(DateTime, X.Data.query('DueDate').value('.','NVARCHAR(50)'), 103) AS DueDate,
		X.Data.query('PaymentID').value('.','NVARCHAR(50)') AS PaymentID,
		X.Data.query('PaymentTermID').value('.','NVARCHAR(500)') AS PaymentTermID,
		X.Data.query('Notes').value('.','NVARCHAR(500)') AS Notes,
		X.Data.query('ApprovePerson01').value('.','NVARCHAR(50)') AS ApprovePerson01,
		X.Data.query('EmployeeID').value('.','NVARCHAR(50)') AS EmployeeID,
		X.Data.query('SalesManID').value('.','NVARCHAR(50)') AS SalesManID,
		X.Data.query('InventoryID').value('.','NVARCHAR(50)') AS InventoryID,
		X.Data.query('OrderQuantity').value('.','decimal(28, 8)') AS OrderQuantity,
		X.Data.query('UnitID').value('.','VARCHAR(50)') AS UnitID,
		X.Data.query('SalePrice').value('.','decimal(28, 8)') AS SalePrice,
		CAST(X.Data.query('VATPercent').value('.','VARCHAR(50)') AS INT) AS VATPercent,
		CAST(X.Data.query('VATOriginalAmount').value('.','VARCHAR(50)') AS INT) AS VATOriginalAmount,
		X.Data.query('VATGroupID').value('.','NVARCHAR(50)') AS VATGroupID,	
		X.Data.query('Description').value('.','NVARCHAR(500)') AS Description,
		X.Data.query('BarCode').value('.', 'NVARCHAR(50)') AS BarCode,
		(CASE WHEN X.Data.query('Ana01ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Ana01ID').value('.', 'NVARCHAR(50)') END) AS Ana01ID,
		(CASE WHEN X.Data.query('Ana02ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Ana02ID').value('.', 'NVARCHAR(50)') END) AS Ana02ID,
		(CASE WHEN X.Data.query('Ana03ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Ana03ID').value('.', 'NVARCHAR(50)') END) AS Ana03ID,
		(CASE WHEN X.Data.query('Ana04ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Ana04ID').value('.', 'NVARCHAR(50)') END) AS Ana04ID,
		(CASE WHEN X.Data.query('Ana05ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Ana05ID').value('.', 'NVARCHAR(50)') END) AS Ana05ID,
		(CASE WHEN X.Data.query('Ana06ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Ana06ID').value('.', 'NVARCHAR(50)') END) AS Ana06ID,
		(CASE WHEN X.Data.query('Ana07ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Ana07ID').value('.', 'NVARCHAR(50)') END) AS Ana07ID,
		(CASE WHEN X.Data.query('Ana08ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Ana08ID').value('.', 'NVARCHAR(50)') END) AS Ana08ID,
		(CASE WHEN X.Data.query('Ana09ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Ana09ID').value('.', 'NVARCHAR(50)') END) AS Ana09ID,
		(CASE WHEN X.Data.query('Ana10ID').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Ana10ID').value('.', 'NVARCHAR(50)') END) AS Ana10ID,
		(CASE WHEN X.Data.query('nvarchar01').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('nvarchar01').value('.', 'NVARCHAR(250)') END) AS nvarchar01,
		(CASE WHEN X.Data.query('nvarchar02').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('nvarchar02').value('.', 'NVARCHAR(250)') END) AS nvarchar02,
		(CASE WHEN X.Data.query('nvarchar03').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('nvarchar03').value('.', 'NVARCHAR(250)') END) AS nvarchar03,
		(CASE WHEN X.Data.query('nvarchar04').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('nvarchar04').value('.', 'NVARCHAR(250)') END) AS nvarchar04,
		(CASE WHEN X.Data.query('nvarchar05').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('nvarchar05').value('.', 'NVARCHAR(250)') END) AS nvarchar05,
		(CASE WHEN X.Data.query('nvarchar06').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('nvarchar06').value('.', 'NVARCHAR(250)') END) AS nvarchar06
INTO #SOP20009
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], DivisionID,VoucherNo,VoucherTypeID,OrderDate, ContractNo, ContractDate,CurrencyID, ExchangeRate, OrderStatus,ShipDate,ClassifyID,InventoryTypeID,ObjectID,Contact,DeliveryAddress,Transport,PriceListID,DueDate,PaymentID,PaymentTermID,Notes,ApprovePerson01,EmployeeID,SalesManID,InventoryID,OrderQuantity,UnitID,SalePrice,VATPercent,VATOriginalAmount,VATGroupID,Description, BarCode, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, nvarchar01, nvarchar02, nvarchar03, nvarchar04, nvarchar05, nvarchar06)
SELECT [Row], DivisionID,VoucherNo, VoucherTypeID,OrderDate, ContractNo, ContractDate,CurrencyID, ExchangeRate, OrderStatus,ShipDate,ClassifyID,InventoryTypeID,ObjectID,Contact,DeliveryAddress,Transport,PriceListID,DueDate,PaymentID,PaymentTermID,Notes,ApprovePerson01,EmployeeID,SalesManID,InventoryID,OrderQuantity,UnitID,SalePrice,VATPercent,VATOriginalAmount,VATGroupID,Description, BarCode, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, nvarchar01, nvarchar02, nvarchar03, nvarchar04, nvarchar05, nvarchar06
FROM #SOP20009
ORDER BY [Row]



----Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID


----- Kiểm tra và lưu dữ liệu bảng giá bán
--EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'VoucherNo', @Param1 = 'DivisionID, Period, VoucherTypeID, VoucherNo, OrderDate, ContractNo, 
--ContractDate, CurrencyID, ExchangeRate, ClassifyID, OrderStatus, ShipDate, InventoryTypeID, EmployeeID, SalesManID, Notes, ObjectID, PriceListID, Contact, DeliveryAddress, 
--PaymentTermID, Transport, PaymentID' 

----- Kiểm tra VoucherID đã tồn tại trong OT2001 (DivisionID, SOrderID)
DECLARE @Cur CURSOR,
		@Row INT,
		@VoucherNo NVARCHAR(50),
		@VoucherNo_Tmp NVARCHAR(50),
		@ColumnName VARCHAR(50),
		@ColName VARCHAR(50),
		@ApprovePerson01 NVARCHAR(50),
		@PriceListID NVARCHAR(50)

SELECT TOP 1 @ColumnName = DataCol, @ColName = ColName FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'VoucherNo'

SET @Cur = CURSOR SCROLL KEYSET FOR
		   SELECT [Row], DivisionID, VoucherNo, ApprovePerson01, PriceListID
		   FROM #Data
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row, @DivisionID, @VoucherNo_Tmp, @ApprovePerson01, @PriceListID
WHILE @@FETCH_STATUS = 0
BEGIN
---- Kiểm tra số chứng từ đã tồn tại
	IF EXISTS (SELECT TOP 1 1 FROM OT2001 WHERE DivisionID = @DivisionID AND VoucherNo = @VoucherNo_Tmp)
	BEGIN		
		UPDATE #Data SET 
		ErrorMessage = @ColumnName + LTRIM(RTRIM(STR(@Row))) + '-SOFML000041', ErrorColumn = @ColName + ','
		BREAK
	END

---- Kiểm tra người duyệt 01

	IF @ApprovePerson01 = @UserID
	BEGIN
		UPDATE #Data SET 
		ErrorMessage = @ColumnName + LTRIM(RTRIM(STR(@Row))) + '-SOFML000042', ErrorColumn = @ColName + ','
		BREAK
	END

---- Kiểm tra tồn tại bảng giá bán
	IF (ISNULL(@PriceListID, '') <>'' )
	BEGIN
	IF NOT EXISTS(SELECT TOP 1 ID FROM OT1301 WHERE ID = @PriceListID)
	BEGIN
		UPDATE #Data SET 
		ErrorMessage = @ColumnName + LTRIM(RTRIM(STR(@Row))) + '-SOFML000043', ErrorColumn = @ColName + ','
		BREAK
	END
	END

	FETCH NEXT FROM @Cur INTO @Row, @DivisionID, @VoucherNo_Tmp, @ApprovePerson01, @PriceListID
END

CLOSE @Cur

------


---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
        UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage)),
                         ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn))
        WHERE ErrorMessage <> ''
        GOTO LB_RESULT
END

---- BEGIN - Xử lý tăng số chứng từ tự động
--DECLARE 
--        @TableBusiness VARCHAR(10) = 'OT2001',
--        @VoucherNo VARCHAR(50),
--        @NewVoucherNo VARCHAR(50),
--        @KeyString VARCHAR(50),
--        @LastKey INT,
--		@ColumnSetting VARCHAR(50),
--		@APKMaster VARCHAR(50)

--SELECT DISTINCT [Row]
--INTO #VoucherData
--FROM #SOP20009
--ORDER BY [Row]

----SET  @ColumnSetting = (SELECT  S1 FROM AT0002 WHERE TableID ='CRMT20301' AND TypeID = 'LEA' AND DivisionID = @DivisionID)

--WHILE EXISTS (SELECT TOP 1 1 FROM #VoucherData)
--BEGIN
--    SELECT @VoucherNo = [Row] FROM #VoucherData

--    --EXEC GetVoucherNo_Ver1 @DivisionID, 'CRM', 'AT0002', 'S1', @TableBusiness, @ColumnSetting, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
--	EXEC GetVoucherNo_Ver2 @DivisionID, 'SO', 'SOF2000', @TableBusiness, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	

--	-- Kiểm tra đã tồn tại VoucherNo trong data 
--	IF NOT EXISTS(SELECT TOP 1 1 FROM OT2001 WITH (NOLOCK) WHERE VoucherNo = @NewVoucherNo)
--	BEGIN
--		PRINT (@VoucherNo + 'abc')
--		-- Cập nhật số chứng từ vào bảng dữ liệu import từ Excel
--		UPDATE #SOP20009 SET VoucherNo = @NewVoucherNo WHERE [Row] = @VoucherNo
		
--		DELETE #VoucherData WHERE [Row] = @VoucherNo
--	END

--	-- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
--	UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString
--END
-- END - Xử lý tăng số chứng từ tự động

-- Insert Master 
DECLARE @masterCursor CURSOR, @SOrderID_tmp NVARCHAR(50), @ObjectID  NVARCHAR(50)
SET @masterCursor = CURSOR STATIC FOR
SELECT DISTINCT VoucherNo, ObjectID
FROM #Data

OPEN @masterCursor

FETCH NEXT FROM @masterCursor INTO @VoucherNo, @ObjectID

WHILE @@FETCH_STATUS = 0
BEGIN
	IF NOT EXISTS(SELECT top 1 VoucherNo FROM OT2001 WHERE VoucherNo = @VoucherNo)
	BEGIN
		DECLARE @ObjectName NVARCHAR(250)
		SET @ObjectName = (SELECT TOP 1 ObjectName FROM AT1202 WHERE ObjectID = @ObjectID)
		SET @SOrderID_tmp = (SELECT top 1 SOrderID FROM #Data WHERE VoucherNo = @VoucherNo)
		INSERT INTO OT2001(APK, SOrderID,DivisionID, VoucherNo, VoucherTypeID, ContractNo, OrderDate, ContractDate, CurrencyID, ObjectID, ObjectName, ExchangeRate, OrderStatus, ShipDate, ClassifyID,InventoryTypeID,Contact,DeliveryAddress,Transport,PriceListID,PaymentID,PaymentTermID,DueDate,EmployeeID,SalesManID,Notes,CreateDate,CreateUserID,LastModifyUserID,LastModifyDate,TranMonth,TranYear,IsInvoice,IsReceiveAmount)
		SELECT top 1 APK, SOrderID,DivisionID, VoucherNo, VoucherTypeID, ContractNo, OrderDate, ContractDate, CurrencyID, ObjectID, @ObjectName, ExchangeRate, OrderStatus, ShipDate, ClassifyID,InventoryTypeID,Contact,DeliveryAddress,Transport,PriceListID,PaymentID,PaymentTermID,DueDate,EmployeeID,SalesManID,Notes,GETDATE(),@UserID,@UserID,GETDATE(),@TranMonth,@TranYear,0,0
		FROM #Data DT
		WHERE DT.VoucherNo = @VoucherNo

		INSERT INTO OT2002(APK, SOrderID,TransactionID,DivisionID,InventoryID,OrderQuantity,SalePrice,OriginalAmount,UnitID,VATPercent,VATOriginalAmount,ConvertedAmount,VATGroupID,Description,
				Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID,
				Ana07ID, Ana08ID, Ana09ID, Ana10ID, nvarchar01, nvarchar02, nvarchar03,
				nvarchar04, nvarchar05, nvarchar06)
		SELECT DISTINCT APK, @SOrderID_tmp, TransactionID, DivisionID,InventoryID,OrderQuantity,SalePrice,OrderQuantity*SalePrice,UnitID,VATPercent,VATOriginalAmount,(OrderQuantity*SalePrice) * ExchangeRate,VATGroupID,Description,
						Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID,
						Ana07ID, Ana08ID, Ana09ID, Ana10ID, nvarchar01, nvarchar02, nvarchar03,
						nvarchar04, nvarchar05, nvarchar06
		FROM #Data DT WHERE DT.VoucherNo = @VoucherNo
	END


	FETCH NEXT FROM @masterCursor INTO @VoucherNo, @ObjectID
END

CLOSE @masterCursor
--INSERT INTO OT2001(SOrderID,DivisionID, VoucherNo, VoucherTypeID, ContractNo, OrderDate, ContractDate, CurrencyID, ObjectID, ExchangeRate, OrderStatus, ShipDate, ClassifyID,InventoryTypeID,Contact,DeliveryAddress,Transport,PriceListID,PaymentID,PaymentTermID,DueDate,EmployeeID,SalesManID,Notes,CreateDate,CreateUserID,LastModifyUserID,LastModifyDate,TranMonth,TranYear,IsInvoice,IsReceiveAmount)
--SELECT DISTINCT SOrderID,DivisionID, VoucherNo, VoucherTypeID, ContractNo, OrderDate, ContractDate, CurrencyID, ObjectID, ExchangeRate, OrderStatus, ShipDate, ClassifyID,InventoryTypeID,Contact,DeliveryAddress,Transport,PriceListID,PaymentID,PaymentTermID,DueDate,EmployeeID,SalesManID,Notes,GETDATE(),@UserID,@UserID,GETDATE(),@TranMonth,@TranYear,0,0
--FROM #Data DT
--WHERE DT.VoucherNo NOT IN (SELECT distinct VoucherNo FROM OT2001  WITH (NOLOCK))


-- Insert Detail
--INSERT INTO OT2002(APK, SOrderID,TransactionID,DivisionID,InventoryID,OrderQuantity,SalePrice,OriginalAmount,UnitID,VATPercent,VATOriginalAmount,ConvertedAmount,VATGroupID,Description,
--				Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID,
--				Ana07ID, Ana08ID, Ana09ID, Ana10ID, nvarchar01, nvarchar02, nvarchar03,
--				nvarchar04, nvarchar05, nvarchar06)
--SELECT DISTINCT APK, SOrderID, TransactionID, DivisionID,InventoryID,OrderQuantity,SalePrice,OrderQuantity*SalePrice,UnitID,VATPercent,VATOriginalAmount,(OrderQuantity*SalePrice) * ExchangeRate,VATGroupID,Description,
--				Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID,
--				Ana07ID, Ana08ID, Ana09ID, Ana10ID, nvarchar01, nvarchar02, nvarchar03,
--				nvarchar04, nvarchar05, nvarchar06
--FROM #Data DT

 --cập nhật lại các khóa
DECLARE @NewKey NVARCHAR(50), @APK9000 VARCHAR(50) , @sSQL1 NVARCHAR(MAX), @sSQL2 NVARCHAR(MAX), @cCur CURSOR
SET @cCur = CURSOR STATIC FOR
	SELECT DISTINCT VoucherNo, ApprovePerson01
	FROM #Data

OPEN @cCur

FETCH NEXT FROM @cCur INTO @VoucherNo_Tmp, @ApprovePerson01

WHILE @@FETCH_STATUS = 0
BEGIN
	--EXEC AP0000 @DivisionID, @NewKey OUTPUT, 'OT2001','DHB', @TranMonth, @TranYear, 14,3,1,'/'
	print @NewKey
	set @NewKey = @VoucherNo_Tmp
	--update OT2001
	--SET VoucherNo = @NewKey
	--where VoucherNo = @VoucherNo_Tmp
	IF NOT EXISTS(select top 1 ID FROM OOT9000 WHERE ID = @NewKey)
	BEGIN
		INSERT	OOT9000(APK, TranMonth, TranYear, CreateDate, LastModifyDate, DivisionID, ID, Type, CreateUserID, LastModifyUserID, DepartmentID, Description)
		VALUES	(NEWID(), @TranMonth, @TranYear, GETDATE(), GETDATE(), @DivisionID, @NewKey, 'DHB', @ApprovePerson01, @ApprovePerson01, N'', N'')
	END

	--print @NewKey
	--select APK from OOT9000 where ID = 'DHB/1/2022/292'
	SET @APK9000 = (select top 1 APK from OOT9000 where ID = @NewKey)

	update OT2001
	SET APKMaster_9000 = @APK9000
	where VoucherNo = (select top(1) VoucherNo from OT2001 where VoucherNo = @NewKey)

	update OT2002
	SET APKMaster_9000 = @APK9000
	where SOrderID = (select top(1) SOrderID from OT2001 where VoucherNo = @NewKey)

	----- Insert người duyệt
	SET @ApprovePersonID = (select top 1 ApprovePerson01 from #Data DT where DT.VoucherNo = @VoucherNo_Tmp)
	SET @sSQL1='
	INSERT INTO OOT9001 (DivisionID, APKMaster, ApprovePersonID, [Level], DeleteFlag, [Status])
	SELECT A.DivisionID,OOT9.APK,'''+@ApprovePersonID+''', 1, 0, 0
	FROM
	(
		SELECT DivisionID, TranMonth, TranYear, VoucherNo
		FROM OT2001
		WHERE VoucherNo='''+@NewKey+'''
		GROUP BY DivisionID, TranMonth, TranYear, VoucherNo
	)A
	INNER JOIN OOT9000 OOT9 ON OOT9.DivisionID = A.DivisionID AND OOT9.TranMonth = A.TranMonth AND OOT9.TranYear = A.TranYear AND OOT9.ID = A.VoucherNo '
	--PRINT (@sSQL1)
	EXEC (@sSQL1)
	FETCH NEXT FROM @cCur INTO @VoucherNo_Tmp, @ApprovePerson01
END

CLOSE @cCur


LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE ErrorColumn <> ''
--WHERE  ErrorColumn <> ''
--ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO