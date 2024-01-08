IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP8123_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8123_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xử lý Import phiếu nhập kho (Customize MEIKO).
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 20/06/2012 by Lê Thị Thu Hiền
---- 
---- Modified on 21/12/2011 by 
 ----Modified on 20/03/2014 by Khanh Van: Sửa phần làm tròn số lẻ (theo thiết lập đơn vị)
---- Modified on 08/10/2015 by Tieu Mai: Sửa phần làm tròn số lẻ, tiền hạch toán theo thiết lập đơn vị-chi nhánh
---- Modified on 18/11/2015 by Phuong Thao: Bo sung them thong tin don hang (so PO), cac thong tin hoa don va tu dong sinh HD mua hang
---- Modified on 18/11/2015 by Phuong Thao: Bo sung them ngay chung tu, ngay hoa don, truong danh dau hoa don chiu thue nha thau
---- Modified on 25/02/2016 by Phuong Thao: Bo sung lay ty gia Ban theo bang ty gia 
---- Modified on 12/03/2016 by Quốc Tuấn: Sửa cách gen số chứng từ và voucherID và trasactiomID
---- Modified on 14/03/2016 by Quốc Tuấn: bổ sung nhập Serial và InvoiceNo thì bắt buộc PVoucherDate
---- Modified on 19/05/2016 by Tiểu Mai: Isnull các trường khai thiết lập số lẻ ở thông tin đơn vị
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Thy on 19/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Anh on 16/04/2018: Bổ sung store customize BaSon
---- Modified on 05/03/2019 by Kim Thư: Tạo khóa chính cho table #Data và #Keys có nối với @@SPID để tránh trùng khóa chính khi nhiều user sử dụng
---- Modified by Huỳnh Thử on 25/06/2020: Customer MEKIO: ObjectID khác nhau thì Sinh ra hóa đơn, check Kiem tra thong tin dong nhat cho hoa don Mua hang bỏ ObjectID
---- Modified by Huỳnh Thử on 25/06/2020: Customer MEKIO: Merge Code: MEKIO và MTE
---- Modified by Huỳnh Thử on 20/08/2020: Customer MEKIO: Fix lỗi chạ all fix
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Kiều Nga on 30/03/2021: Bổ sung lưu Số PO (OrderID) vào nghiệp vụ Phiếu mua hàng (AT9000) 
---- Nodified by Nhựt Trường on 19/04/2021: Customer MEKIO: Thêm cột Invoicecheck vào bảng tạm #data để check đối tượng + hóa đơn + serial thì mới đồng bộ thông tin.
---- Modified by Nhựt Trường on 31/08/2021: Xử lý tự động sinh phiếu mua hàng - Điều chỉnh đồng bộ thông tin nếu đồng nhất dữ liệu ở các trường InvoiceNo, Serial, PVoucherDate, VATGroupID, ObjectID.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Kiều Nga on 13/07/2023: [2023/02/TA/0107] - Bổ sung thêm cột DepartmentID cho phiếu mua hàng sinh động.

-- <Example>
---- 
CREATE PROCEDURE [DBO].[AP8123_MK]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(MAX),
		@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
		
IF @CustomerName = 84	--- BaSon
BEGIN
	EXEC AP8123_BS @DivisionID, @UserID, @ImportTemplateID, @XML
	return
END

DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50),
		@ExchangeRate AS DECIMAL(28,8),
		@i int, @n int,
		@InvoiceDate Datetime, @InvoiceNo NVarchar(50),
		@CurrencyID NVarchar(50),
		@ColumnName NVARCHAR(500)

		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,
	Orders INT,
	VoucherID NVARCHAR(50) NULL,
	TransactionID NVARCHAR(50),
	ImportMessage NVARCHAR(500) DEFAULT (''),
	POrders INT,
	PVoucherNo NVarchar	(50),
	PVoucherID NVarchar(50),
	PTransactionID NVarchar(50),
	VATTransactionID NVarchar(50)--,
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
-- Thêm cột Invoicecheck vào bảng tạm #data để check đối tượng + hóa đơn + serial thì mới đồng bộ thông tin.
   ALTER TABLE #data ADD InvoiceCheck NVARCHAR(500) NULL 

SELECT	X.Data.query('Row').value('.', 'INT') AS Row,		
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,
		X.Data.query('VoucherTypeID').value('.', 'NVARCHAR(50)') AS VoucherTypeID,
		X.Data.query('VoucherNo').value('.', 'NVARCHAR(50)') AS VoucherNo,
		X.Data.query('VoucherDate').value('.', 'NVARCHAR(50)') AS PurchaseDate,
		X.Data.query('RefNo01').value('.', 'NVARCHAR(50)') AS RefNo01,
		X.Data.query('RefNo02').value('.', 'NVARCHAR(50)') AS RefNo02,
		X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID,
		X.Data.query('WareHouseID').value('.', 'NVARCHAR(50)') AS WareHouseID,
		X.Data.query('InventoryTypeID').value('.', 'NVARCHAR(50)') AS InventoryTypeID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('Description').value('.', 'NVARCHAR(250)') AS Description,		
		X.Data.query('BarCode').value('.', 'NVARCHAR(50)') AS BarCode,		
		X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') AS InventoryID,
		X.Data.query('UnitID').value('.', 'NVARCHAR(50)') AS UnitID,
		X.Data.query('ActualQuantity').value('.', 'DECIMAL(28,8)') AS ActualQuantity,
		X.Data.query('UnitPrice').value('.', 'DECIMAL(28,8)') AS UnitPrice,
		X.Data.query('OriginalAmount').value('.', 'DECIMAL(28,8)') AS OriginalAmount,
		X.Data.query('SourceNo').value('.', 'NVARCHAR(50)') AS SourceNo,
		X.Data.query('LimitDate').value('.', 'NVARCHAR(50)') AS LimitDate,
		X.Data.query('DebitAccountID').value('.', 'NVARCHAR(50)') AS DebitAccountID,
		X.Data.query('CreditAccountID').value('.', 'NVARCHAR(50)') AS CreditAccountID,
		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes,
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
		X.Data.query('ProductID').value('.', 'NVARCHAR(50)') AS ProductID,
		X.Data.query('PONo').value('.', 'NVARCHAR(50)') AS PONo,
		X.Data.query('PEmployeeID').value('.', 'NVARCHAR(50)') AS PEmployeeID,
		X.Data.query('InvoiceNo').value('.', 'NVARCHAR(50)') AS InvoiceNo,
		X.Data.query('Serial').value('.', 'NVARCHAR(50)') AS Serial,
		X.Data.query('CurrencyID').value('.', 'NVARCHAR(50)') AS CurrencyID,
		X.Data.query('ExchangeRate').value('.', 'NVARCHAR(50)') AS ExchangeRate,
		X.Data.query('PVoucherDate').value('.', 'NVARCHAR(50)') AS PVoucherDate,
		X.Data.query('PInvoiceDate').value('.', 'NVARCHAR(50)') AS PInvoiceDate,
		X.Data.query('IsWithhodingTax').value('.', 'NVARCHAR(50)') AS IsWithhodingTax,
		X.Data.query('PUnitPrice').value('.', 'NVARCHAR(50)') AS PUnitPrice,
		X.Data.query('POriginalAmount').value('.', 'NVARCHAR(50)') AS POriginalAmount,
		X.Data.query('PaymentTermID').value('.', 'NVARCHAR(50)') AS PaymentTermID,
		X.Data.query('DueDate').value('.', 'NVARCHAR(50)') AS DueDate,
		X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') AS DepartmentID,
		IDENTITY(int, 1, 1) AS OrderNo
INTO	#AP8123		
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (
		Row,	
		Orders,	
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
		Description,
		BarCode,
		InventoryID,
		UnitID,
		ActualQuantity,
		UnitPrice,
		OriginalAmount,
		SourceNo,
		LimitDate,
		DebitAccountID,
		CreditAccountID,
		Notes,
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
		ProductID,
		PONo,
		PEmployeeID,
		InvoiceNo,
		Serial, 
		CurrencyID, 
		ExchangeRate,
		PVoucherDate,
		PInvoiceDate,
		IsWithhodingTax,
		PUnitPrice,
		POriginalAmount,
		PaymentTermID,
		DueDate,
		DepartmentID,
		InvoiceCheck
		)
SELECT	Row,		
		OrderNo,
		DivisionID,
		Period,
		VoucherTypeID,
		VoucherNo,
		CASE WHEN ISNULL(PurchaseDate,'') ='' THEN NULL ELSE CAST(PurchaseDate AS DATETIME) END,		
		RefNo01,
		RefNo02,
		ObjectID,
		WareHouseID,
		InventoryTypeID,
		EmployeeID,
		Description,
		BarCode,
		InventoryID,
		UnitID,
		ActualQuantity, 
		UnitPrice,
		OriginalAmount,
		--CASE WHEN ISNULL(ActualQuantity,0) = 0 THEN NULL ELSE CAST(ActualQuantity AS DECIMAL(28,8)) END ActualQuantity,
		--CASE WHEN ISNULL(UnitPrice,0) =0 THEN NULL ELSE CAST(UnitPrice AS DECIMAL(28,8)) END UnitPrice,
		--CASE WHEN ISNULL(OriginalAmount,0) =0 THEN NULL ELSE CAST(OriginalAmount AS DECIMAL(28,8)) END OriginalAmount,
		SourceNo,
		CASE WHEN ISNULL(LimitDate,'') ='' THEN NULL ELSE CAST(LimitDate AS DATETIME) END LimitDate,
		DebitAccountID,
		CreditAccountID,
		Notes,
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
		ProductID,
		PONo,
		PEmployeeID,
		InvoiceNo,
		Serial, 
		CurrencyID, 
		CASE WHEN ISNULL(ExchangeRate,'') = '' THEN NULL ELSE CAST(ExchangeRate AS DECIMAL(28,8)) END ExchangeRate,
		CASE WHEN ISNULL(PVoucherDate,'') ='' THEN NULL ELSE CAST(PVoucherDate AS DATETIME) END PVoucherDate,
		CASE WHEN ISNULL(PInvoiceDate,'') ='' THEN NULL ELSE CAST(PInvoiceDate AS DATETIME) END PInvoiceDate,
		CASE WHEN ISNULL(IsWithhodingTax,'') ='' THEN NULL ELSE CAST(IsWithhodingTax AS TINYINT) END IsWithhodingTax,
		CASE WHEN ISNULL(PUnitPrice,'') ='' THEN NULL ELSE CAST(PUnitPrice AS DECIMAL(28,8)) END PUnitPrice,
		CASE WHEN ISNULL(POriginalAmount,'') ='' THEN NULL ELSE CAST(POriginalAmount AS DECIMAL(28,8)) END POriginalAmount,
		PaymentTermID,
		CASE WHEN ISNULL(DueDate,'') ='' THEN NULL ELSE CAST(DueDate AS DATETIME) END DueDate,
		DepartmentID,
		CONCAT(ObjectID,InvoiceNo,Serial)
FROM #AP8123

---- Xử lý lấy tỷ giá Bán
select @i = 0
select @n = max(Orders) from #Data

while (@i<= @n)
begin
	select	@CurrencyID = CurrencyID,
			@InvoiceNo = InvoiceNo,
			@InvoiceDate = PInvoiceDate
	from #Data
	where Orders = @i

	If(isnull(@InvoiceNo,'') <> '')
	begin 
		
		IF EXISTS (SELECT TOP 1 1 FROM  AT1012 WITH(NOLOCK) WHERE	CurrencyID = @CurrencyID AND DATEDIFF(dd, ExchangeDate, @InvoiceDate) >= 0 AND IsDefault = 1)
		BEGIN
				SELECT		TOP 1 @ExchangeRate =  SellingExchangeRate 
				FROM		AT1012 WITH (NOLOCK)
				WHERE		CurrencyID = @CurrencyID
							AND DATEDIFF(dd, ExchangeDate, @InvoiceDate) >= 0
							AND DivisionID = @DivisionID
							AND IsDefault = 1
				ORDER BY	DATEDIFF(dd, ExchangeDate, @InvoiceDate)
				
		END
		ELSE
		BEGIN
			SELECT		TOP 1 @ExchangeRate = ExchangeRate
			FROM		AT1012 WITH (NOLOCK)
			WHERE		CurrencyID = @CurrencyID
						AND DATEDIFF(dd, ExchangeDate, @InvoiceDate) >= 0
						AND DivisionID = @DivisionID
			ORDER BY	DATEDIFF(dd, ExchangeDate, @InvoiceDate)

			SET @ExchangeRate = COALESCE(@ExchangeRate, (SELECT ExchangeRate FROM AT1004 WITH (NOLOCK) WHERE CurrencyID = @CurrencyID AND DivisionID IN (@DivisionID,'@@@')), 0)
	
		END
	end

	Update #Data
	set	   ExchangeRate = @ExchangeRate
	where Orders = @i and Isnull(ExchangeRate,0) = 0

	Set @i = @i + 1
end

IF(@CustomerName = 50 OR @CustomerName = 115) -- Mekio và Mte
BEGIN
	
	------------- Xử lý dữ liệu ngày đáo hạn ---------------------------
	/*
	Nếu không nhập dữ liệu ngày đáo hạn thì tính ngày đáo hạn theo điều khoản thanh toán
	Điều khoản thanh toán lấy theo thiết lập đối tượng (nếu không nhập trên file import)
	*/
	DECLARE		@ObjectID Varchar(50),
				@VoucherDate datetime ,		 		    
				@PaymentTermID NVARCHAR(50),
				@DueDate datetime
	select @i = 1
	select @n = max(Orders) from #Data

	--CREATE TABLE #DueDate (DueDate Datetime)

	while (@i<= @n)
	begin
		select	@InvoiceNo = InvoiceNo,
				@ObjectID = ObjectID,
				@VoucherDate= PVoucherDate,
				@InvoiceDate = PInvoiceDate,
				@PaymentTermID = PaymentTermID
		from #Data
		where Orders = @i

		If(isnull(@InvoiceNo,'') <> '')
		begin 
			--INSERT INTO #DUEDATE (DueDate)
			EXEC AP2222_MK @ObjectID, @VoucherDate, @InvoiceDate, 'PU', @PaymentTermID, @DivisionID, @DueDate OUTPUT

			Update #Data
			set	   #Data.DueDate = @DueDate
			--set	   #Data.DueDate = #DUEDATE.DueDate
			--From   #DUEDATE
			where  #Data.Orders = @i and Isnull(#Data.DueDate,'') = '' 	and Isnull(InvoiceNo,'') <> ''		
		end

		--Delete #DUEDATE
	
		Set @i = @i + 1
	END
    
	-- Kiểm tra ngày chứng từ mua phải thuộc kỳ kế toán import
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidVoucherDate', @Module = 'ASOFT-WM', @ColID = 'PVoucherDate', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'ISNULL(PVoucherDate,'''')<>'''''

END


---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-WM', @ColID = 'VoucherNo', @Param1 = 'VoucherNo,VoucherDate,RefNo01,RefNo02,ObjectID,WareHouseID,InventoryTypeID,EmployeeID,Description'

EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidObject', @ColID = 'ObjectID', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 1, @SQLWhere = ''

----------- Doan xu ly kiem tra du lieu co nhap thong tin Hoa Don de sinh tu dong phieu mua hang --------------
-- Kiem tra bat buoc nhap thong tin den hoa don Mua hang neu co nhap so HĐ
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @Module = 'ASOFT-WM', @ColID = 'PEmployeeID', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'ISNULL(InvoiceNo,'''')<>'''''
IF(@CustomerName <> 50 OR @ColumnName <> 115) -- Mekio và Mte
BEGIN
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @Module = 'ASOFT-WM', @ColID = 'Serial', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'ISNULL(InvoiceNo,'''')<>'''''
END 
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @Module = 'ASOFT-WM', @ColID = 'CurrencyID', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'ISNULL(InvoiceNo,'''')<>'''''
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @Module = 'ASOFT-WM', @ColID = 'PUnitPrice', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'ISNULL(InvoiceNo,'''')<>'''''
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @Module = 'ASOFT-WM', @ColID = 'POriginalAmount', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'ISNULL(InvoiceNo,'''')<>'''''



-- Kiem tra loai tien
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidCurrency', @Module = 'ASOFT-WM', @ColID = 'CurrencyID', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'ISNULL(InvoiceNo,'''')<>'''''
-- Customer Mokio or Mte
IF @CustomerName = 50 OR @CustomerName = 115
BEGIN
	-- Kiem tra thong tin dong nhat cho hoa don Mua hang
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-WM',@ColID = 'InvoiceCheck', @Param1 = 'PEmployeeID,CurrencyID,ExchangeRate,PVoucherDate,PInvoiceDate,IsWithhodingTax,PaymentTermID,DueDate',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'ISNULL(InvoiceNo,'''')<>'''''
END
ELSE
BEGIN
	-- Kiem tra thong tin dong nhat cho hoa don Mua hang
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-WM',@ColID = 'InvoiceNo', @Param1 = 'ObjectID,PEmployeeID,CurrencyID,ExchangeRate,PVoucherDate,PInvoiceDate,IsWithhodingTax,Serial,',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'ISNULL(InvoiceNo,'''')<>'''''
END


--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			OriginalAmount = ROUND(OriginalAmount, A.ConvertedDecimals),
			ActualQuantity = ROUND(DT.ActualQuantity, A.QuantityDecimals),	
			UnitPrice = ROUND(DT.UnitPrice, A.UnitCostDecimals),	
			VoucherDate = CASE WHEN VoucherDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), VoucherDate, 101)) END,
			LimitDate = CASE WHEN LimitDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), LimitDate, 101)) END
FROM		#Data DT
LEFT JOIN	AT1101 A ON A.DivisionID = DT.DivisionID


--Kiểm tra có nhập Serial và InvoiceNo thì bắt bược nhập ngày chứng từ mua
SELECT	TOP 1 @ColumnName = DataCol
FROM	A01066 WITH (NOLOCK)
WHERE	ImportTemplateID = @ImportTemplateID AND ColID = 'PVoucherDate'
 
UPDATE	#Data
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'ASML000074 {0}=''AM'''
		WHERE	(ISNULL(Serial,'') <>''OR ISNULL(InvoiceNo,'') <>'')  AND PVoucherDate IS NULL

				
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT


-- Sinh khóa
DECLARE @cKey AS CURSOR
DECLARE @Row AS INT,
		@Orders AS INT,
		@VoucherNo AS NVARCHAR(50),
		@Period AS NVARCHAR(50),
		@VoucherGroup AS NVARCHAR(50)

DECLARE	@TransID AS NVARCHAR(50),
		@VoucherID AS NVARCHAR(50)--,
		--@CurrencyID AS NVARCHAR(50)			

SET @cKey = CURSOR FOR
	SELECT	Row, VoucherNo, Period
	FROM	#Data
		
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
		--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @VoucherID OUTPUT, @TableName = 'AT2006', @StringKey1 = 'AD', @StringKey2 = @Period, @OutputLen = 16
		SET @VoucherID=NEWID()
		SET @VoucherGroup = (@VoucherNo + '#' + @Period)
	END
	SET @Orders = @Orders + 1
	--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @TransID OUTPUT, @TableName = 'AT2007', @StringKey1 = 'BD', @StringKey2 = @Period, @OutputLen = 16
	SET @TransID=NEWID()
	INSERT INTO #Keys (Row, Orders, VoucherID, TransactionID) VALUES (@Row, @Orders, @VoucherID, @TransID)				
	FETCH NEXT FROM @cKey INTO @Row, @VoucherNo, @Period
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
				
-- Kiểm tra trùng số chứng từ
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateOtherVoucherNo', @ColID = 'VoucherNo', @Param2 = 'AT2006', @Param3 = 'VoucherNo'


-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

-- Đẩy dữ liệu vào bảng master
INSERT INTO AT2006
(
	DivisionID,		VoucherID,		TableID,	TranMonth,	TranYear,
	VoucherTypeID,	VoucherDate,	VoucherNo,	ObjectID,	InventoryTypeID,
	WareHouseID,	KindVoucherID,	[Status],	EmployeeID,	[Description],
	RefNo01,		RefNo02,
	CreateDate,		CreateUserID,	LastModifyUserID,	LastModifyDate
	
)

SELECT	DISTINCT
		DivisionID,		VoucherID,		
		CASE WHEN Isnull(MAX(InvoiceNo),'') <> '' THEN 'AT9000' ELSE 'AT2006' END,	
		LEFT(Period, 2),	RIGHT(Period, 4),
		VoucherTypeID,	VoucherDate,	VoucherNo,	ObjectID,			InventoryTypeID,			
		WareHouseID,	
		1,						
		0,			EmployeeID,			[Description],
		RefNo01,		RefNo02,
		GETDATE(),		@UserID,		@UserID,	GETDATE()	
FROM	#Data
GROUP BY DivisionID,		VoucherID,	Period, VoucherTypeID,	VoucherDate,	VoucherNo,	ObjectID,			InventoryTypeID,			
		WareHouseID,	EmployeeID,			[Description],
		RefNo01,		RefNo02

INSERT INTO AT2007
(
	DivisionID,	TransactionID,	VoucherID,	
	InventoryID,UnitID,	ActualQuantity,	UnitPrice,	OriginalAmount,	ConvertedAmount,
	Notes,	TranMonth,	TranYear,	CurrencyID,	ExchangeRate,
	SourceNo,	DebitAccountID,	CreditAccountID,
	LimitDate,	Orders,
	Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
	Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,	Ana10ID,
	PeriodID,	ProductID, OrderID, ConvertedQuantity, ConvertedUnitID
)
SELECT	DivisionID,	TransactionID,	VoucherID,	
		InventoryID, UnitID,	ActualQuantity,	UnitPrice,	OriginalAmount,	OriginalAmount,
		Notes,		LEFT(Period, 2),	RIGHT(Period, 4),	@CurrencyID,	
		1,						
		SourceNo,	DebitAccountID,	CreditAccountID,
		LimitDate,	Orders,
		Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
		Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,	Ana10ID,
		PeriodID,	ProductID,
		PONo, ActualQuantity, UnitID
FROM	#Data

UPDATE T1
SET		T1.OTransactionID = T3.TransactionID
FROM AT2007 T1
INNER JOIN #Data T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
INNER JOIN OT3002 T3 WITH (NOLOCK) ON T2.PONo = T3.POrderID  AND T2.InventoryID = T3.InventoryID AND T2.DivisionID = T3.DivisionID


---------- Xử lý tự động sinh phiếu mua hàng ------------
IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE Isnull(InvoiceNo,'') <> '')
BEGIN

CREATE TABLE #PKeys
(
	Row INT,
	Orders INT,
	VoucherNo NVARCHAR(50),
	VoucherID NVARCHAR(50),
	TransactionID NVARCHAR(50),	
	VATTransactionID NVARCHAR(50),	
	CONSTRAINT [PK_#PKeys] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)


DECLARE @cPKey AS CURSOR
--DECLARE @Row AS INT,
--		@Orders AS INT,
--		@VoucherNo AS NVARCHAR(50),
--		@Period AS NVARCHAR(50),
--		@VoucherGroup AS NVARCHAR(50),
--		@VATGroupID AS NVARCHAR(50)
		

DECLARE	@PTransID AS NVARCHAR(50),
		-- @InvoiceNo AS NVARCHAR(50),
		@VATTransID AS NVARCHAR(50),		
		@PVoucherID AS NVARCHAR(50),		
		@PBatchID AS NVARCHAR(50),		
		@WOrderID AS NVARCHAR(50),
		@WTransactionID AS NVARCHAR(50),
		@VATGroupID AS NVARCHAR(50),
		@Serial AS NVARCHAR(50)	,
		@PVoucherDate AS Datetime,
		@Number AS INT,
		@Number_Temp AS INT,
		@String_VoucherID AS NVARCHAR(50),
		@String_VoucherNo AS NVARCHAR(50),
		@InvoiceNo_Temp AS NVARCHAR(50),
		@Serial_Temp AS NVARCHAR(50),
		@PVoucherDate_Temp AS NVARCHAR(50),
		@VATGroupID_Temp AS NVARCHAR(50),
		@ObjectID_Temp AS NVARCHAR(50)

declare @PVoucherNo NVarchar(50), @S1 Varchar(10),  @S2 Varchar(10),  @S3 Varchar(10), 
		@OutputLength int, @Seperator varchar(3), @Seperated int, @OutputOrder int,
		@VATTypeID NVarchar(50), @VATAccountID  NVarchar(50)

SET @VoucherGroup = ''

--- Gán giá trị
SELECT @OutputLength = OutputLength, @OutputOrder = OutputOrder, @Seperated = Separated, @Seperator = ISNULL(separator,'/')
, @VATTypeID = VATTypeID
FROM AT1007 WHERE DivisionID = @DivisionID AND VoucherTypeID = 'MH'

-- gán giá trị @StringKey1,@StringKey2,@StringKey3
	SELECT @S1 = S1, @S2 = S2, @S3 = S3 FROM dbo.S123 (@DivisionID, 'MH',CONVERT(INT,(select top 1 LEFT(Period, 2) From #Data)),CONVERT(INT,(select top 1	RIGHT(Period, 4) From #Data)))

SELECT @VATAccountID = VATInAccountID
FROM AT0000 WITH (NOLOCK)

SELECT	T1.Row, T1.InvoiceNo, T1.Serial, T1.PVoucherDate, T2.VATGroupID, T1.ObjectID
	INTO #Temp00
	FROM	#Data T1
	INNER JOIN AT1302 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,'@@@') AND T1.InventoryID = T2.InventoryID
	WHERE	Isnull(T1.InvoiceNo,'') <> ''
	ORDER BY  T1.InvoiceNo

SELECT T00.*,
	   (SELECT COUNT(InvoiceNo)
	    FROM #Temp00
		WHERE InvoiceNo = T00.InvoiceNo AND
			  ISNULL(Serial,'') = ISNULL(T00.Serial,'') AND
			  ISNULL(PVoucherDate,'') = ISNULL(T00.PVoucherDate,'') AND
			  ISNULL (VATGroupID,'') = ISNULL(T00.VATGroupID,'') AND
			  ISNULL(ObjectID,'') = ISNULL(T00.ObjectID,'')
		GROUP BY InvoiceNo, Serial, PVoucherDate, VATGroupID, ObjectID) AS Number
INTO #Temp01
FROM #Temp00 T00

SELECT InvoiceNo, Serial, PVoucherDate, VATGroupID, ObjectID, Number
INTO #Temp02
FROM #Temp01
GROUP BY InvoiceNo, Serial, PVoucherDate, VATGroupID, ObjectID, Number

DECLARE cPKey01 CURSOR FOR
SELECT InvoiceNo, Serial, PVoucherDate, VATGroupID, ObjectID, Number FROM #Temp02
open cPKey01
FETCH NEXT FROM cPKey01 INTO @InvoiceNo_Temp, @Serial_Temp, @PVoucherDate_Temp, @VATGroupID_Temp, @ObjectID_Temp, @Number_Temp
WHILE @@FETCH_STATUS = 0
BEGIN
   --- Sinh khoa VoucherID
   SET @PVoucherID=NEWID()
   --- Sinh so phieu VoucherNo
   EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @PVoucherNo OUTPUT, @TableName = 'AT9000', @StringKey1 = @S1, @StringKey2 = @S2, @StringKey3 = @S3, @OutputLen = @OutputLength,
	  				@OutputOrder = @OutputOrder, @Seperated = @Seperated, @Seperator = @Seperator
   SET @String_VoucherID = @PVoucherID
   SET @String_VoucherNo = @PVoucherNo
   DECLARE cPKey02 CURSOR FOR
   SELECT Row, InvoiceNo, Serial, PVoucherDate, VATGroupID, ObjectID, Number
   FROM #Temp01
   WHERE InvoiceNo = @InvoiceNo_Temp AND
		 ISNULL(Serial,'') = ISNULL(@Serial_Temp,'') AND
		 ISNULL(PVoucherDate,'') = ISNULL(@PVoucherDate_Temp,'') AND
		 ISNULL (VATGroupID,'') = ISNULL(@VATGroupID_Temp,'') AND
		 ISNULL(ObjectID,'') = ISNULL(@ObjectID_Temp,'') AND
		 Number = @Number_Temp
   --ORDER BY InvoiceNo, Serial, PVoucherDate, VATGroupID, ObjectID
   open cPKey02
   FETCH NEXT FROM cPKey02 INTO @Row, @InvoiceNo, @Serial, @PVoucherDate, @VATGroupID, @ObjectID, @Number
   WHILE @@FETCH_STATUS = 0
   BEGIN
	  IF  ISNULL(@VoucherGroup,'') = '' OR @VoucherGroup <> @InvoiceNo+ '#' + @Serial+ '#' + Convert(Varchar(50),@PVoucherDate,101)+ @ObjectID
	  IF  ISNULL(@VoucherGroup,'') = '' OR @VoucherGroup <> @InvoiceNo+ '#' + @Serial+ '#' + Convert(Varchar(50),@PVoucherDate,101)+ @ObjectID
	  BEGIN
	  	---------->> Hóa đơn mua hàng VoucherID
	  	SET @Orders = 0
	  	--- Sinh khoa VoucherID
	  	--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @PVoucherID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AV', @StringKey2 = @Period, @OutputLen = 16		
	   SET @PVoucherID=@String_VoucherID
	   SET @PVoucherNo = @String_VoucherNo
	  	
	   SET @VoucherGroup = @InvoiceNo+ '#' + @Serial+ '#' + Convert(Varchar(50),@PVoucherDate,101)+ @ObjectID
	  END
	  SET @Orders = @Orders + 1
	  --EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @PTransID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AT', @StringKey2 = @Period, @OutputLen = 16
	  set @PTransID=NEWID()
	  
	  IF ISNULL(@VATGroupID,'') <> ''
	  --EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @VATTransID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AT', @StringKey2 = @Period, @OutputLen = 16
	  SET @VATTransID=NEWID()
	  
	  INSERT INTO #PKeys (Row, Orders, VoucherNo, VoucherID, TransactionID, VATTransactionID) 
	  VALUES (@Row, @Orders, @PVoucherNo, @PVoucherID, @PTransID, @VATTransID)

      FETCH NEXT FROM cPKey02
             INTO @Row, @InvoiceNo, @Serial, @PVoucherDate, @VATGroupID, @ObjectID, @Number
   END
   CLOSE cPKey02
   DEALLOCATE cPKey02
   FETCH NEXT FROM cPKey01
          INTO @InvoiceNo_Temp, @Serial_Temp, @PVoucherDate_Temp, @VATGroupID_Temp, @ObjectID_Temp, @Number_Temp
END
CLOSE cPKey01
DEALLOCATE cPKey01

-- Cập nhật khóa
UPDATE		DT
SET			POrders = K.Orders,
			DT.PVoucherNo = K.VoucherNo,
			DT.PVoucherID = K.VoucherID ,			
			DT.PTransactionID = K.TransactionID,
			DT.VATTransactionID = K.VATTransactionID
FROM		#Data DT
INNER JOIN	#PKeys K
		ON	K.Row = DT.Row

-- Kiểm tra trùng số chứng từ
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateOtherVoucherNo', @ColID = 'PVoucherNo', @Param2 = 'AT9000', @Param3 = 'VoucherNo'

-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

	
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
	Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
	CreateDate,		CreateUserID,			LastModifyDate,		LastModifyUserID,
	OriginalAmountCN,						ExchangeRateCN,		CurrencyIDCN,	
	ConvertedQuantity,		ConvertedPrice,		ConvertedUnitID, 
	InventoryName1,
	WOrderID, WTransactionID, IsWithhodingTax,PaymentTermID, DueDate,DepartmentID,OrderID
)
SELECT	D.DivisionID,		D.PVoucherID,		D.PVoucherID,		D.PTransactionID,	'AT9000',
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),	'T03',
		D.CurrencyID,		D.ObjectID,			D.ObjectID,
		A.VATNo,			D.ObjectID,		A.ObjectName,	A.[Address],
		D.DebitAccountID,	D.CreditAccountID,	
		D.ExchangeRate,	
		D.PUnitPrice,
		--CASE WHEN AT1004.Operator = 0 THEN ROUND(D.UnitPrice / D.ExchangeRate,ISNULL(A2.UnitCostDecimals,0)) ELSE ROUND(D.UnitPrice * D.ExchangeRate,A2.UnitCostDecimals) END AS OriginalAmount,
		--CASE WHEN AT1004.Operator = 0 THEN ROUND(D.OriginalAmount / D.ExchangeRate,ISNULL(AT1004.ExchangeRateDecimal,0)) ELSE ROUND(D.OriginalAmount * D.ExchangeRate,ExchangeRateDecimal) END AS OriginalAmount,
		D.POriginalAmount,
		D.OriginalAmount AS ConvertedAmount,
		1,		
		--CASE WHEN AT1004.Operator = 0 THEN ROUND((A1.VATRate/100* (D.OriginalAmount/ D.ExchangeRate)),ISNULL(AT1004.ExchangeRateDecimal,0)) ELSE ROUND((A1.VATRate/100* (D.OriginalAmount*D.ExchangeRate)),ISNULL(AT1004.ExchangeRateDecimal,0)) END, 				
		Round(A1.VATRate/100*D.POriginalAmount,ISNULL(AT1004.ExchangeRateDecimal,0)),
		Round(A1.VATRate/100*D.OriginalAmount,ISNULL(A2.ConvertedDecimals,0)),
		0,		D.PVoucherDate,	D.PInvoiceDate,	'MH',	@VATTypeID,	A1302.VATGroupID,
		D.PVoucherNo,	D.Serial,		D.InvoiceNo,	
		D.POrders,		D.PEmployeeID,	A.ObjectName,	A.ObjectName,	A.Address,
		(select Max(Description) From #Data T2 where D.PVoucherID = T2.PVoucherID and Isnull(T2.POrders,1) = 1  Group By PVoucherID) AS VDescription,
		(select Max(Description) From #Data T2 where D.PVoucherID = T2.PVoucherID and Isnull(T2.POrders,1) = 1  Group By PVoucherID) AS BDescription,
		D.Description,
		D.ActualQuantity,		D.InventoryID,	D.UnitID,		
		0,		0,		0,	
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,
		GETDATE(),	@UserID,	GETDATE(),	@UserID,
		--CASE WHEN AT1004.Operator = 0 THEN ROUND(D.OriginalAmount / D.ExchangeRate,ISNULL(AT1004.ExchangeRateDecimal,0)) ELSE ROUND(D.OriginalAmount * D.ExchangeRate,ExchangeRateDecimal) END,	
		D.POriginalAmount,
		D.ExchangeRate,	D.CurrencyID,
		D.ActualQuantity,		D.UnitPrice,	D.UnitID,
		InventoryName, D.VoucherID, D.TransactionID, D.IsWithhodingTax,
		CASE WHEN ISNULL(D.PaymentTermID,'') = '' THEN A.PaPaymentTermID ELSE PaymentTermID END , D.DueDate, D.DepartmentID,D.PONo
FROM	#Data D
LEFT JOIN AT1302 A1302 WITH (NOLOCK) ON A1302.DivisionID IN (D.DivisionID,'@@@') AND A1302.InventoryID = D.InventoryID
LEFT JOIN AT1202 A WITH (NOLOCK) ON A.DivisionID IN (@DivisionID, '@@@') AND A.ObjectID = D.ObjectID
LEFT JOIN AT1010 A1 WITH (NOLOCK) ON A1.VATGroupID = A1302.VATGroupID
LEFT JOIN AT1101 A2 WITH (NOLOCK) ON A2.DivisionID = D.DivisionID 
LEFT JOIN AT1004 WITH (NOLOCK) ON D.CurrencyID = AT1004.CurrencyID
WHERE Isnull(D.InvoiceNo,'') <> ''

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
	Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
	CreateDate,		CreateUserID,			LastModifyDate,		LastModifyUserID,
	OriginalAmountCN,						ExchangeRateCN,		CurrencyIDCN,
	ConvertedQuantity,		ConvertedPrice,		ConvertedUnitID, IsWithhodingTax,
	PaymentTermID, DueDate,DepartmentID,OrderID
)
SELECT	D.DivisionID,		D.PVoucherID,		D.PVoucherID,		D.VATTransactionID,	'AT9000',
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),	'T13',
		D.CurrencyID,		D.ObjectID,	D.ObjectID,
		A.VATNo,			D.ObjectID,		A.ObjectName,	A.[Address],
		@VATAccountID,		D.CreditAccountID,	D.ExchangeRate,	NULL,
		--A1.VATRate/100*D.OriginalAmount,
		--CASE WHEN AT1004.Operator = 0 THEN ROUND((A1.VATRate/100* (D.OriginalAmount* D.ExchangeRate)),ISNULL(A2.ConvertedDecimals,0)) ELSE ROUND((A1.VATRate/100* (D.OriginalAmount/D.ExchangeRate)),ISNULL(A2.ConvertedDecimals,0)) END, 		
		--CASE WHEN AT1004.Operator = 0 THEN ROUND((A1.VATRate/100* (D.OriginalAmount/ D.ExchangeRate)),ISNULL(AT1004.ExchangeRateDecimal,0)) ELSE ROUND((A1.VATRate/100* (D.OriginalAmount*D.ExchangeRate)),ISNULL(AT1004.ExchangeRateDecimal,0)) END, 				
		Round(A1.VATRate/100*D.POriginalAmount,ISNULL(AT1004.ExchangeRateDecimal,0)) AS OriginalAmount,
		Round(A1.VATRate/100*D.OriginalAmount,ISNULL(A2.ConvertedDecimals,0)) AS ConvertedAmount,
		NULL, NULL,
		0,		D.PVoucherDate,	D.PInvoiceDate,	D.VoucherTypeID,	@VATTypeID,	A1302.VATGroupID,
		D.PVoucherNo,	D.Serial,		D.InvoiceNo,	
		D.POrders,		D.PEmployeeID,	A.ObjectName,	A.ObjectName,	A.Address,
		(select Max(Description) From #Data T2 where D.PVoucherID = T2.PVoucherID  Group By PVoucherID) AS VDescription,
		(select Max(Description) From #Data T2 where D.PVoucherID = T2.PVoucherID  Group By PVoucherID) AS BDescription,
			D.Description,
		NULL,			NULL,			NULL,		
		0,		0,		0,	
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,
		GETDATE(),	@UserID,	GETDATE(),	@UserID,
		--CASE WHEN AT1004.Operator = 0 THEN ROUND((A1.VATRate/100* (D.OriginalAmount/ D.ExchangeRate)),ISNULL(AT1004.ExchangeRateDecimal,0)) ELSE ROUND((A1.VATRate/100* (D.OriginalAmount*D.ExchangeRate)),ISNULL(AT1004.ExchangeRateDecimal,0)) END, 			
		A1.VATRate/100*D.POriginalAmount,
		D.ExchangeRate,		D.CurrencyID,
		NULL,			NULL,	NULL, D.IsWithhodingTax,
		CASE WHEN ISNULL(D.PaymentTermID,'') = '' THEN A.PaPaymentTermID ELSE PaymentTermID END , D.DueDate,D.DepartmentID,D.PONo
		
FROM	#Data D
LEFT JOIN AT1302 A1302 WITH (NOLOCK) ON A1302.DivisionID IN (D.DivisionID,'@@@') AND A1302.InventoryID = D.InventoryID
LEFT JOIN AT1202 A WITH (NOLOCK) ON A.DivisionID IN (@DivisionID, '@@@') AND A.ObjectID = D.ObjectID
LEFT JOIN AT1010 A1 WITH (NOLOCK) ON A1.VATGroupID = A1302.VATGroupID
LEFT JOIN AT1101 A2 WITH (NOLOCK) ON A2.DivisionID = D.DivisionID AND A2.BaseCurrencyID = D.CurrencyID
LEFT JOIN AT1004 WITH (NOLOCK) ON D.CurrencyID = AT1004.CurrencyID
WHERE Isnull(D.InvoiceNo,'') <> ''

END

LB_RESULT:
SELECT * FROM #Data




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

