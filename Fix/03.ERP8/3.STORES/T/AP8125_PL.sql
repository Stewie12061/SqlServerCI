IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8125_PL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8125_PL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Import Hóa đơn bán hàng có phần xuất kho tự động
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 25/06/2012 by Lê Thị Thu Hiền
---- 
---- Modified on Dang Le Bao Quynh. Purpose: xu ly lai cach sinh key, Ban hang, xuat kho, thue trung VoucherID. Ban hang, xuat kho trung TransactionID
---- Sinh TransactionID kieu UniqueIdentifier 
---- Modified on 21/11/2013 by Lê Thị Thu Hiền : Insert IsStock
---- Modified on 20/04/2015 by Lê Thị Hạnh: Bổ sung nếu IsWareHouse = 1 thì bắt buộc nhập WHDebitAccountID,WHCreditAccountID [LAVO]
---- Modified on 08/10/2015 by Tieu Mai: Sửa phần làm tròn số lẻ, tiền hạch toán theo thiết lập đơn vị-chi nhánh
---- Modified on 07/03/2016 by Phương Thảo: Bổ sung lấy tỷ giá Mua theo TT200
---- Modified by Tiểu Mai on 28/03/2016: Kiểm tra VATGroupID <> NULL
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Thy on 16/06/2016: Bổ sung Ana06ID->Ana10ID
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified on 05/03/2019 by Kim Thư: Tạo khóa chính cho table #Data và #Keys có nối với @@SPID để tránh trùng khóa chính khi nhiều user sử dụng
---- Modified on 15/05/2019 by Kim Thư: Bổ sung lưu thêm diễn giải từng dòng ở phiếu xuất kho, lấy từ TDescription của hóa đơn
---- Modified on 12/06/2019 by Kim Thư: Điều chỉnh các cột người dùng để trống sẽ insert là null thay vì giá trị rỗng
---- Modified on 15/07/2019 by Hoàng Trúc: Bổ sung điều kiện TransactionTypeID cho mã hàng 'Z001' ở hóa đơn bán hàng
---- Modified on 12/03/2020 by Văn Minh: Bổ sung IsEInvoice
---- Modified on 23/03/2020 by Huỳnh Thử: Set Null ReVoucherID, ReTransactionID (Trường hợp xuất theo lô mới cần 2 trường này)
---- Modified on 03/04/2020 by Văn Minh: Bổ sung lại PaymentID
---- Modified by Huỳnh Thử on 01/04/2020: Tạo ra 1 dòng thuế cho từng loại thuế
---- Modified by Huỳnh Thử on 20/08/2020: Merge Code: MEKIO và MTE
---- Modified by Huỳnh Thử on 01/04/2020: Lưu TDescription cho dòng Thuế (T14) 'Thuế GTGT đầu ra'
---- Modified by Đức Thông on 31/08/2020: Bổ sung tính VAT trường hợp 1 nhóm thuế
---- Modified by Hoài Phong on 18/09/2020:Bổ sung làm tròn theo thiết lập:+VATOriginalAmount và OriginalAmount làm tròn theo ExchangeRateDecimal trong AT1004
----                                                                      +VATConvertedAmount, ConvertedAmount làm tròn theo ConvertedDecimals trong AT1101.
---- Modified by Hoài Phong on 08/10/2020: Bổ sung Lấy ConversionFactor 
---- Modified by Hoài Phong on 20/10/2020: Bổ sung Cách tính  DiscountedUnitPrice  cho PL
---- Modified by Đức Thông on 13/11/2020: Bổ sung isnull cho các case làm tròn
---- Modified by Đức Thông on 08/12/2020: Rẽ nhánh tính tiền thuế cho bút toán thuế (T14) cho trường hợp 1 và nhiều nhóm thuế
---- Modified by Nhựt Trường on 14/12/2020: Bổ sung lấy InventoryID khi insert vào AT9000 (Bút toán thuế).
---- Modified by Đức Thông on 21/12/2020: 2020/12/IS/0249: [NKTTN] Chỉ insert 1 dòng bút toán thuế (T14), không tính bút toán chiết khấu (T64) vào thuế
---- Modified by Đức Thông on 28/12/2020: 2020/12/IS/0249: [NKTTN] Trừ tiền thuế của bút toán T64
---- Modified by Đức Thông on 28/12/2020: 2020/12/IS/0249: [NKTTN] Fix lỗi lấy thuế nguyên tệ sai
---- Modified by Đức Thông on 29/12/2020: 2020/12/IS/0249: [NKTTN] Fix lỗi không lấy được dòng thuế trường hợp không có hàng chiết khấu + cách tính thuế khi có hàng ck th nhiều và 1 nhóm thuế: nhiều nhóm thuế thì làm tròn tiền thuế ở ck, 1 nhóm thuế thì trừ ck trước rồi mới đi tính thuế rồi mới làm tròn
---- Modified by Đức Thông on 30/12/2020: 2020/12/IS/0540: [NKTTN]
---- Modified by Đức Thông on 05/01/2021: 2020/12/IS/0249: [NKTTN] Fix lỗi chỉ thêm vào 1 dòng thuế khi file có nhiều hóa đơn
---- Modified by Đức Thông on 06/01/2021: 2020/12/IS/0249: [NKTTN] Sửa lại xử lí tính thuế và cải tiến xử lí kiểm tra trùng số ct
---- Modified by Đức Thông on 08/01/2021: 2020/12/IS/0249: [NKTTN] Bỏ group by theo mã phân tích ở xử lí insert thuế tránh bị tách dòng
---- Modified by Đức Thông on 12/01/2021: 2021/01/IS/0024: [Phúc Long] Lấy random 1 mpt 6 và 7 của dòng hàng vào dòng thuế (phục vụ xem dữ liệu)
---- Modified by Đức Thông on 12/01/2021: 2020/12/IS/0249: [Phúc Long] Lấy random các mpt còn lại của dòng hàng vào dòng thuế (phục vụ xem dữ liệu)
---- Modified by Đức Thông   on 25/01/2021: 2021/01/IS/0115: [Phúc Long] Bỏ sung kiểm tra trùng số chứng từ phiếu xuất kho
---- Modified by Nhựt Trường on 23/02/2021: Tách store AP8125_THTP (Khách hàng Tổng hợp THỊNH PHÁT).
---- Modified by Hoài Phong on 27/04/2021: Bổ sung thêm DivisionID).
---- Modified bt Nhựt Trường on 03/06/2021: Bỏ trừ chiết khấu khi insert vào AT9000 (vì số tiền OriginalAmount và ConvertedAmount trong file excel import, khách hàng đã trừ tiền chiết khấu rồi).
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>																			  
---- 
---- 

CREATE PROCEDURE AP8125_PL
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
		@IsWareHouse AS TINYINT	,
		@ExchangeRate AS DECIMAL(28,8),
		@i int, @n int,
		@PaymentDate Datetime, 
		@CurrencyID NVarchar(50), @Method Tinyint

DECLARE @Operator AS INT,
		@CustomerName INT 
select @CustomerName = CustomerName FROM dbo.CustomerIndex

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
	WHVoucherID NVARCHAR(50),
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
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE	SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	--PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END


-- @XML: dữ liệu xml tạo từ file excel
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
		X.Data.query('WareHouseExVoucherNo').value('.', 'NVARCHAR(50)') AS WareHouseExVoucherNo,
		X.Data.query('WareHouseExVoucherDate').value('.', 'NVARCHAR(50)') AS WareHouseExVoucherDate,	
		X.Data.query('WareHouseImVoucherNo').value('.', 'NVARCHAR(50)') AS WareHouseImVoucherNo,
		X.Data.query('WareHouseEx').value('.', 'NVARCHAR(50)') AS WareHouseEx,
		X.Data.query('SourceNo').value('.', 'NVARCHAR(50)') AS SourceNo,
		X.Data.query('WHContactPerson').value('.', 'NVARCHAR(250)') AS WHContactPerson,
		X.Data.query('WHRDAddress').value('.', 'NVARCHAR(250)') AS WHRDAddress,
		X.Data.query('WHDescription').value('.', 'NVARCHAR(250)') AS WHDescription,
		X.Data.query('WHDebitAccountID').value('.', 'NVARCHAR(50)') AS WHDebitAccountID,
		X.Data.query('WHCreditAccountID').value('.', 'NVARCHAR(50)') AS WHCreditAccountID,
		X.Data.query('PaymentDate').value('.', 'NVARCHAR(50)') AS PaymentDate,
		X.Data.query('IsEInvoice').value('.','TINYINT') AS IsEInvoice,
		X.Data.query('IsMultiTax').value('.','TINYINT') AS IsMultiTax,	
		IDENTITY(int, 1, 1) AS OrderNo
INTO	#AP8125	
FROM	@XML.nodes('//Data') AS X (Data)

--- thực hiện chuyển dữ liệu null thành chuỗi rỗng và chuyển đổi dữ liệu
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
		InvoiceCode,
		InvoiceSign,
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
		PaymentID,
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
		WareHouseExVoucherNo,
		WareHouseExVoucherDate,
		WareHouseImVoucherNo,
		WareHouseEx,
		SourceNo,
		WHContactPerson,
		WHRDAddress,
		WHDescription,
		WHDebitAccountID,
		WHCreditAccountID,
		PaymentDate,
		IsEInvoice,
		IsMultiTax
		)
SELECT Row,
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
		InvoiceCode,
		InvoiceSign,
		Serial,
		InvoiceNo,
		CASE WHEN ISNULL(InvoiceDate,'') = '' THEN NULL ELSE CAST(InvoiceDate AS DATETIME) END InvoiceDate,
		CASE WHEN ISNULL(VATTypeID,'') = '' THEN NULL ELSE VATTypeID END AS VATTypeID,
		CASE WHEN ISNULL(DueDate,'') = '' THEN NULL ELSE CAST(DueDate AS DATETIME) END DueDate,
		CurrencyID,
		CASE WHEN ISNULL(ExchangeRate,'') = '' THEN NULL ELSE CAST(ExchangeRate AS DECIMAL(28,8)) END ExchangeRate,
		ObjectID,
		CASE WHEN ISNULL(VATObjectID,'')='' THEN NULL ELSE VATObjectID END AS VATObjectID,
		CASE WHEN ISNULL(PaymentTermID,'')='' THEN NULL ELSE PaymentTermID END AS PaymentTermID,
		PaymentID,
		BDescription,
		CASE WHEN ISNULL(GTGTObjectID,'')='' THEN NULL ELSE GTGTObjectID END AS GTGTObjectID,
		GTGTDebitAccountID,
		GTGTCreditAccountID,
		InventoryID,
		UnitID,
		Quantity,
		UnitPrice,
		CASE WHEN ISNULL(DiscountRate,'') = '' THEN NULL ELSE CAST(DiscountRate AS DECIMAL(28,8)) END DiscountRate,	
		CASE WHEN ISNULL(DiscountAmount,'') = '' THEN NULL ELSE CAST(DiscountAmount AS DECIMAL(28,8)) END DiscountAmount,	
		OriginalAmount,
		CASE WHEN ISNULL(ConvertedAmount,'') = '' THEN NULL ELSE CAST(ConvertedAmount AS DECIMAL(28,8)) END ConvertedAmount, 
		CASE WHEN ISNULL(VATGroupID,'')='' THEN NULL ELSE VATGroupID END AS VATGroupID,
		DebitAccountID,
		CreditAccountID,
		TDescription,
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
		WareHouseExVoucherNo,
		CASE WHEN ISNULL(WareHouseExVoucherDate,'') = '' THEN NULL ELSE CAST(WareHouseExVoucherDate AS DATETIME) END	WareHouseExVoucherDate,
		WareHouseImVoucherNo,
		WareHouseEx,
		SourceNo,
		WHContactPerson,
		WHRDAddress,
		WHDescription,
		WHDebitAccountID,
		WHCreditAccountID,
		CASE WHEN ISNULL(PaymentDate,'') ='' THEN NULL ELSE CAST(PaymentDate AS DATETIME) END PaymentDate,
		IsEInvoice,
		IsMultiTax
FROM #AP8125


UPDATE #Data
SET		#Data.Method = ISNULL(AT1004.Method,0)
FROM #Data INNER JOIN  AT1004 WITH (NOLOCK) ON #Data.CurrencyID = AT1004.CurrencyID

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidObject', @ColID = 'ObjectID', @Param1 = '',    @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 1, @SQLWhere = ''

---- Kiểm tra bắt buộc nhập tỷ giá, thành tiền quy đổi nếu loại tiền ko sử dụng pp BQGQ di động
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @ColID = 'ExchangeRate',		@Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 0, @SQLWhere = 'Method = 0'
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @ColID = 'ConvertedAmount',	@Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 0, @SQLWhere = 'Method = 0'


---- Kiểm tra dữ liệu không đồng nhất tại phần master
IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE IsWareHouse = 1) 
BEGIN
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidAccount', @ColID = 'WHDebitAccountID',	@ObligeCheck = 1, @SQLFilter = 'A.GroupID <> ''G00'''
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidAccount', @ColID = 'WHCreditAccountID',    @ObligeCheck = 1, @SQLFilter = 'A.GroupID <> ''G00'''
END
ELSE 
BEGIN
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidAccount', @ColID = 'WHDebitAccountID',	@ObligeCheck = 0, @SQLFilter = 'A.GroupID <> ''G00'''
	EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidAccount', @ColID = 'WHCreditAccountID',    @ObligeCheck = 0, @SQLFilter = 'A.GroupID <> ''G00'''
END
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-T', @ColID =	'VoucherNo', @Param1 =	   'VoucherNo,VoucherDate,EmployeeID,VDescription,InvoiceCode,InvoiceSign,Serial,InvoiceNo,InvoiceDate,VATTypeID,DueDate,CurrencyID,Object ID,VATObjectID,PaymentTermID,PaymentID,BDescription,GTGTObjectID,GTGTDebitAccountID,GTGTCreditAccountID,WareHouseExVoucherNo,WareHouseE  xVoucherDate,WareHouseEx,WHContactPerson,WHRDAddress,WHDescription'

---- Xử lý lấy tỷ giá Mua
select @i = 0
select @n = max(Orders) from #Data

while (@i<= @n)
begin
	select	@CurrencyID = CurrencyID,		
			@PaymentDate = CASE WHEN Isnull(PaymentDate,'') = '' THEN VoucherDate ELSE PaymentDate END,
			@Method = Method
	from #Data
	where Orders = @i

	SELECT TOP 1 @Operator=Operator
	FROM 	AT1004 
	WHERE 	CurrencyID = @CurrencyID 				

	IF EXISTS (SELECT TOP 1 1 FROM  AT1012 WITH(NOLOCK) WHERE	CurrencyID = @CurrencyID AND DATEDIFF(dd, ExchangeDate, @PaymentDate) >=	0 AND IsDefault = 1)
	BEGIN
			SELECT		TOP 1 @ExchangeRate =  BuyingExchangeRate 
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

		SET @ExchangeRate = COALESCE(@ExchangeRate, (SELECT ExchangeRate FROM AT1004 WITH (NOLOCK) WHERE CurrencyID = @CurrencyID AND	DivisionID IN (@DivisionID, '@@@')), 0)
			
	END

	Update #Data
	set		ExchangeRate = @ExchangeRate,
			ConvertedAmount = CASE WHEN @Operator = 0 THEN OriginalAmount * @ExchangeRate ELSE CASE WHEN @ExchangeRate = 0 THEN 0 ELSE	OriginalAmount /@ExchangeRate END END
	where Orders = @i and Isnull(ExchangeRate,0) = 0
	
	

	Set @i = @i + 1
END

IF(@CustomerName = 50 OR @CustomerName = 115) -- Mekio or Mte
BEGIN

	------------- Xử lý dữ liệu ngày đáo hạn ---------------------------
	/*
	Nếu không nhập dữ liệu ngày đáo hạn thì tính ngày đáo hạn theo điều khoản thanh toán
	Điều khoản thanh toán lấy theo thiết lập đối tượng (nếu không nhập trên file import)
	*/
	DECLARE		@ObjectID Varchar(50),
				@VoucherDate datetime ,	
				@InvoiceDate datetime ,	 		    
				@PaymentTermID NVARCHAR(50),
				@DueDate datetime
	select @i = 1
	select @n = max(Orders) from #Data

	--CREATE TABLE #DueDate (DueDate Datetime)

	while (@i<= @n)
	begin
		select	@ObjectID = ObjectID,
				@VoucherDate= VoucherDate,
				@InvoiceDate = InvoiceDate,
				@PaymentTermID = PaymentTermID
		from #Data
		where Orders = @i
		
		--INSERT INTO #DUEDATE (DueDate)
		EXEC AP2222_MK @ObjectID, @VoucherDate, @InvoiceDate, 'SA', @PaymentTermID, @DivisionID, @DueDate OUTPUT 

		Update #Data
		set	   #Data.DueDate = @DueDate
		--set	   #Data.DueDate = #DUEDATE.DueDate
		--From   #DUEDATE
		where  #Data.Orders = @i and Isnull(#Data.DueDate,'') = '' 		

			--Delete #DUEDATE

		Set @i = @i + 1
	end


END

--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			Quantity = ROUND(DT.Quantity, ISNULL(A.QuantityDecimals, 0)),
			ExchangeRate = ROUND(DT.ExchangeRate, ISNULL(A1.ExchangeRateDecimal, 0)),
			OriginalAmount = ROUND(OriginalAmount, ISNULL(A1.ExchangeRateDecimal, 0)),
			ConvertedAmount = ROUND(ConvertedAmount, ISNULL(A.ConvertedDecimals, 0)),
			UnitPrice = ROUND(DT.UnitPrice, ISNULL(A.UnitCostDecimals, 0)),	
			DiscountRate = ROUND(DiscountRate, 2),
			DiscountAmount = ROUND(DiscountAmount, ISNULL(A1.ExchangeRateDecimal, 0)),
		
			VoucherDate = CASE WHEN VoucherDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), VoucherDate, 101)) END,
			InvoiceDate = CASE WHEN InvoiceDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), InvoiceDate, 101)) END,
			DueDate = CASE WHEN DueDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10), DueDate, 101)) END,
			WareHouseExVoucherDate = CASE WHEN WareHouseExVoucherDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(10),	WareHouseExVoucherDate, 101)) END
FROM		#Data DT
LEFT JOIN	AT1101 A WITH (NOLOCK) ON A.DivisionID = DT.DivisionID
LEFT JOIN	AT1004 A1 WITH (NOLOCK) ON A1.CurrencyID = DT.CurrencyID

			
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT
	
---------->>> Xuất kho
SET @IsWareHouse = (SELECT TOP 1 IsWareHouse FROM #Data WHERE DivisionID = @DivisionID)

-- Sinh khóa
DECLARE @cKey AS CURSOR
DECLARE @Row AS INT,
		@Orders AS INT,
		@VoucherNo AS NVARCHAR(50),
		@Period AS NVARCHAR(50),
		@VoucherGroup AS NVARCHAR(50),
		@VATGroupID AS NVARCHAR(50)

DECLARE	@TransID AS NVARCHAR(50),
		@VATTransID AS NVARCHAR(50),
		@WHTransID AS NVARCHAR(50),
		@VoucherID AS NVARCHAR(50),
		@WHVoucherID AS NVARCHAR(50),
		@BatchID AS NVARCHAR(50),
		--@CurrencyID AS NVARCHAR(50),
		@ReVoucherID AS NVARCHAR(50)	

SET @cKey = CURSOR FOR
	SELECT	Row, VoucherNo, Period, VATGroupID
	FROM	#Data
		
OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row, @VoucherNo, @Period, @VATGroupID
WHILE @@FETCH_STATUS = 0
BEGIN
	
	SET @Period = RIGHT(@Period, 4)
	IF @VoucherGroup IS NULL OR @VoucherGroup <> (@VoucherNo + '#' + @Period)
	BEGIN
		---------->> Hóa đơn bán hàng VoucherID
		SET @Orders = 0
		EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @VoucherID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AV', @StringKey2 =	@Period, @OutputLen = 16
		
		---------->> Xuất kho VoucherID
		IF ISNULL(@IsWareHouse,0) <> 0
			--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @WHVoucherID OUTPUT, @TableName = 'AT2006', @StringKey1 = 'AD',	@StringKey2 = @Period, @OutputLen = 16
			SET @WHVoucherID = @VoucherID
		SET @VoucherGroup = (@VoucherNo + '#' + @Period)
	END
	SET @Orders = @Orders + 1
	--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @TransID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AT', @StringKey2 = @Period,    @OutputLen = 16
	SET @TransID = NEWID()
	IF ISNULL(@IsWareHouse,0) <> 0
	--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @WHTransID OUTPUT, @TableName = 'AT2006', @StringKey1 = 'BD', @StringKey2 =	@Period, @OutputLen = 16
	SET @WHTransID = @TransID
	
	IF ISNULL(@VATGroupID,'') <> ''
	--EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @VATTransID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AT', @StringKey2 =		@Period, @OutputLen = 16
		SET @VATTransID = NEWID()
	ELSE
		SET @VATTransID = NULL

	INSERT INTO #Keys (Row, Orders, VoucherID, TransactionID, VATTransactionID, WHVoucherID, WHTransactionID) 
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
	EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @BatchID OUTPUT, @TableName = 'AT9000', @StringKey1 = 'AB', @StringKey2 = @Period,		@OutputLen = 16
	
	Update #Data
	set		BatchID = @BatchID
	Where	VoucherID = @VoucherID AND ExchangeRate = @ExchangeRate
FETCH NEXT FROM @cKeyBatchID INTO @VoucherID, @ExchangeRate

END	
CLOSE @cKeyBatchID
				
-- Kiểm tra trùng số chứng từ hóa đơn bán hàng
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateOtherVoucherNo', @ColID = 'VoucherNo',	@Param2 = '#AT9000', @Param3 = 'VoucherNo'

-- Kiểm tra trùng số chứng từ phiếu xuất kho
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'DuplicateVoucherNoWareHouse', @ColID = 'VoucherNo',		@Param2 = '#AT2006', @Param3 = 'VoucherNo'


-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT


--- Cập nhật giá trị trường IsMultiExR (nhiều tỷ giá)
UPDATE #Data
SET		#Data.IsMultiExR = 1
WHERE #Data.VoucherID in (Select VoucherID from (select distinct VoucherID, ExchangeRate from #Data ) T group by VoucherID having Count (1) >= 2 )
				
--- Bỏ kiểm tra bị lặp lại (ảnh hưởng tốc độ query)
-- Kiểm tra trùng số chứng từ
--EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateOtherVoucherNo', @ColID =	'VoucherNo', @Param2 = 'AT9000', @Param3 = 'VoucherNo'

-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

-------->>> Phần Hóa đơn bán hàng đẩy vào bảng AT9000
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
	PaymentTermID,	ConvertedQuantity,		ConvertedPrice,		ConvertedUnitID,
	ExchangeRateDate,	IsMultiExR, IsEInvoice,DiscountedUnitPrice
)
SELECT	D.DivisionID,		D.VoucherID,		D.BatchID,		D.TransactionID,	'AT9000',
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),	case when D.InventoryID = 'Z001' then 'T64' else 'T04' end,
		D.CurrencyID,		D.ObjectID,			D.ObjectID,
		A.VATNo,			D.VATObjectID,		A.ObjectName,	A.[Address],
		D.DebitAccountID,	D.CreditAccountID,	D.ExchangeRate,	D.UnitPrice,
		ROUND(D.OriginalAmount,A4.ExchangeRateDecimal),	ROUND(D.ConvertedAmount,A2.ConvertedDecimals),
		--(case when ISNULL (D.VATGroupID,'') <> '' THEN 1 ELSE 0 END),
		D.IsMultiTax,
		ROUND(A1.VATRate/100*(D.OriginalAmount - ISNULL(D.DiscountAmount, 0)),A4.ExchangeRateDecimal), -- VATOriginalAmount
		ROUND((A1.VATRate/100*(D.ConvertedAmount - ISNULL(D.ConvertedAmount*D.DiscountRate/100,0))),ISNULL(A2.ConvertedDecimals,0)) , --	VATConvertedAmount
		@IsWareHouse ,		D.VoucherDate,	D.InvoiceDate,	D.VoucherTypeID,	D.VATTypeID,	D.VATGroupID,
		D.VoucherNo,	D.InvoiceCode,	D.InvoiceSign,  D.Serial,		D.InvoiceNo,	
		D.Orders,		D.EmployeeID,	A.ObjectName,	A.ObjectName,	A.Address,
		D.VDescription,	D.BDescription,	D.TDescription,
		D.Quantity,		D.InventoryID,	D.UnitID,		
		0,		0,		0,	
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,
		D.Ana06ID,	D.Ana07ID,	D.Ana08ID,	D.Ana09ID,		D.Ana10ID,
		GETDATE(),	@UserID,	GETDATE(),	@UserID,
		ROUND(D.OriginalAmount, A4.ExchangeRateDecimal),	D.ExchangeRate,	D.CurrencyID,
		NULL,				D.PaymentID,			D.DueDate,	
		D.DiscountRate,		D.DiscountAmount,
		NULL,				NULL,			NULL,
		D.PaymentTermID,	D.Quantity,		D.UnitPrice,	D.UnitID,
		ISNULL(D.PaymentDate,D.VoucherDate),	D.IsMultiExR, IsEInvoice, CASE WHEN ISNULL(DiscountAmount,0)=0 THEN D.UnitPrice  ELSE	ROUND(D.ConvertedAmount / D.Quantity,A2.ConvertedDecimals) END
FROM	#Data D
LEFT JOIN AT1202 A WITH (NOLOCK) ON A.DivisionID IN (@DivisionID, '@@@') AND A.ObjectID = D.VATObjectID
LEFT JOIN AT1010 A1 WITH (NOLOCK) ON A1.VATGroupID = D.VATGroupID
LEFT JOIN AT1101 A2 WITH (NOLOCK) ON A2.DivisionID = D.DivisionID 
LEFT JOIN AT1004 A4 WITH (NOLOCK) ON  A4.DivisionID = D.DivisionID AND D.CurrencyID = A4.CurrencyID   

---------->>> Bút toán thuế

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
	VoucherNo,		InvoiceCode,	InvoiceSign,    Serial,			InvoiceNo,	
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
	PaymentTermID,	ConvertedQuantity,		ConvertedPrice,		ConvertedUnitID,
	ExchangeRateDate,	IsMultiExR, IsEInvoice
)
SELECT	D.DivisionID,		D.VoucherID,		D.BatchID,		NewID(),	'AT9000',
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),	'T14',
		D.CurrencyID,		ISNULL(D.GTGTObjectID,D.ObjectID),	ISNULL(D.GTGTObjectID,D.ObjectID),
		A.VATNo,			D.VATObjectID,		A.ObjectName,	A.[Address],
		D.GTGTDebitAccountID,	D.GTGTCreditAccountID,	D.ExchangeRate,
		NULL, -- UnitPrice
		CASE ISNULL(D.IsMultiTax, 0) WHEN 1 THEN -- Nhiều nhóm thuế nguyên tệ
				SUM(ROUND(A1.VATRate / 100 * (CASE WHEN D.InventoryID != 'Z001' THEN D.OriginalAmount ELSE	0 END), A2.ConvertedDecimals)) - ROUND(A1.VATRate / 100 * SUM(CASE D.InventoryID WHEN 'Z001' THEN OriginalAmount ELSE 0	 END), A2.ConvertedDecimals)
			ELSE -- Một nhóm thuế nguyên tệ				
				ROUND(A1.VATRate / 100 * (SUM(CASE WHEN D.InventoryID != 'Z001' THEN D.OriginalAmount ELSE	0 END) - SUM(CASE D.InventoryID WHEN 'Z001' THEN D.OriginalAmount ELSE 0 END)), A2.ConvertedDecimals)
				 END, -- OriginalAmount
		CASE ISNULL(D.IsMultiTax, 0) WHEN 1 THEN -- Nhiều nhóm thuế qui đổi
				SUM(ROUND(A1.VATRate / 100 * (CASE WHEN D.InventoryID != 'Z001' THEN D.ConvertedAmount ELSE 0 END), A2.ConvertedDecimals)) - ROUND(A1.VATRate / 100 * SUM(CASE D.InventoryID WHEN 'Z001' THEN ConvertedAmount ELSE	 0 END), A2.ConvertedDecimals)
			ELSE -- Một nhóm thuế qui đổi
				ROUND(A1.VATRate / 100 * (SUM(CASE WHEN D.InventoryID != 'Z001' THEN D.ConvertedAmount ELSE 0 END) - SUM(CASE D.InventoryID WHEN 'Z001' THEN D.ConvertedAmount ELSE 0 END)), A2.ConvertedDecimals)
				 END, -- ConvertedAmount		
		NULL, -- VATOriginalAmount
		NULL, -- VATConvertedAmount
		D.IsWareHouse,		D.VoucherDate,	D.InvoiceDate,	D.VoucherTypeID,	D.VATTypeID,	D.VATGroupID,
		D.VoucherNo,	D.InvoiceCode,	D.InvoiceSign,	D.Serial,		D.InvoiceNo,	
		NULL,		D.EmployeeID,	A.ObjectName,	A.ObjectName,	A.Address,
		D.VDescription,
		D.BDescription,
		N'Thuế GTGT đầu ra', -- TDescription
		NULL,
		NULL, -- InventoryID
		NULL,
		0,		0,		0,	
		(SELECT TOP 1 Ana01ID FROM #Data D1 WHERE D.DivisionID = D1.DivisionID AND D.VoucherID = D1.VoucherID), -- Mã phân tích 1
		(SELECT TOP 1 Ana02ID FROM #Data D1 WHERE D.DivisionID = D1.DivisionID AND D.VoucherID = D1.VoucherID),
		(SELECT TOP 1 Ana03ID FROM #Data D1 WHERE D.DivisionID = D1.DivisionID AND D.VoucherID = D1.VoucherID),
		(SELECT TOP 1 Ana04ID FROM #Data D1 WHERE D.DivisionID = D1.DivisionID AND D.VoucherID = D1.VoucherID),
		(SELECT TOP 1 Ana05ID FROM #Data D1 WHERE D.DivisionID = D1.DivisionID AND D.VoucherID = D1.VoucherID),
		(SELECT TOP 1 Ana06ID FROM #Data D1 WHERE D.DivisionID = D1.DivisionID AND D.VoucherID = D1.VoucherID),
		(SELECT TOP 1 Ana07ID FROM #Data D1 WHERE D.DivisionID = D1.DivisionID AND D.VoucherID = D1.VoucherID),
		(SELECT TOP 1 Ana08ID FROM #Data D1 WHERE D.DivisionID = D1.DivisionID AND D.VoucherID = D1.VoucherID),
		(SELECT TOP 1 Ana09ID FROM #Data D1 WHERE D.DivisionID = D1.DivisionID AND D.VoucherID = D1.VoucherID),
		(SELECT TOP 1 Ana10ID FROM #Data D1 WHERE D.DivisionID = D1.DivisionID AND D.VoucherID = D1.VoucherID), -- Mã phân tích 10
		GETDATE(),	@UserID,	GETDATE(),	@UserID,
		SUM(A1.VATRate*(D.OriginalAmount - ISNULL(D.DiscountAmount, 0))/100),
		D.ExchangeRate,		D.CurrencyID,
		NULL,				D.PaymentID,			D.DueDate,	
		NULL,				NULL,
		NULL,				NULL,			NULL,
		D.PaymentTermID,	NULL,			NULL,	NULL,
		ISNULL(D.PaymentDate,D.VoucherDate),	D.IsMultiExR, IsEInvoice		
FROM	#Data D
LEFT JOIN AT1202 A WITH (NOLOCK) ON A.DivisionID IN (@DivisionID, '@@@') AND A.ObjectID = D.VATObjectID
LEFT JOIN AT1010 A1 WITH (NOLOCK) ON A1.VATGroupID = D.VATGroupID
LEFT JOIN AT1101 A2 WITH (NOLOCK) ON A2.DivisionID = D.DivisionID --AND A2.BaseCurrencyID = D.CurrencyID
LEFT JOIN AT1004 A4 WITH (NOLOCK) ON  A4.DivisionID = D.DivisionID AND D.CurrencyID = A4.CurrencyID   
WHERE D.VATTransactionID IS NOT NULL
GROUP BY 
		D.DivisionID,
		D.VoucherID,
		D.BatchID,
		LEFT(D.Period, 2),
		RIGHT(D.Period, 4),
		D.CurrencyID,
		D.GTGTObjectID,
		D.ObjectID,	
		A.VATNo,
		D.VATObjectID,
		A.ObjectName,
		A.[Address],
		D.GTGTDebitAccountID,
		D.GTGTCreditAccountID,
		D.ExchangeRate,
		D.IsMultiTax,
		D.IsWareHouse,
		D.VoucherDate,
		D.InvoiceDate,
		D.VoucherTypeID,
		D.VATTypeID,
		D.VATGroupID,
		D.VoucherNo,
		D.InvoiceCode,
		D.InvoiceSign,
		D.Serial,
		D.InvoiceNo,	
	    D.EmployeeID,
		D.VDescription, -- diễn giải hóa đơn
		D.BDescription,
		--D.InventoryID, -- mã hàng: khác
		--D.Ana01ID,
		--D.Ana02ID,
		--D.Ana03ID,
		--D.Ana04ID,
		--D.Ana05ID,
		--D.Ana06ID,
		--D.Ana07ID,
		--D.Ana08ID,
		--D.Ana09ID,	
		--D.Ana10ID,
		D.PaymentID,
		D.DueDate,	
		D.PaymentTermID,
		D.PaymentDate,
		D.IsMultiExR,
		IsEInvoice,
		A1.VATRate,
		A4.ExchangeRateDecimal,
		A2.ConvertedDecimals
		--D.DiscountAmount, --ck: khác
		--D.UnitPrice, -- đơn giá: khác
		--D.Quantity, -- số lượng: khác
		--D.ConvertedAmount -- thành tiền qui đổi: khác


--------->>>> Xuất kho

IF ISNULL(@IsWareHouse, 0) <> 0
BEGIN
	
-- Đẩy dữ liệu vào bảng master
INSERT INTO AT2006
(
	DivisionID,		VoucherID,		TableID,	TranMonth,	TranYear,
	VoucherTypeID,	VoucherDate,	
	VoucherNo,		ObjectID,		InventoryTypeID,
	WareHouseID,	KindVoucherID,	[Status],	EmployeeID,	[Description],
	RefNo01,		RefNo02,		RDAddress,	ContactPerson,
	CreateDate,		CreateUserID,	LastModifyUserID,	LastModifyDate
	
)

SELECT	DISTINCT
		DivisionID,		WHVoucherID,		'AT2006',	LEFT(Period, 2),RIGHT(Period, 4),
		WareHouseVoucherTypeID,		WareHouseExVoucherDate,	
		WareHouseExVoucherNo,		ObjectID,			'%'	,		
		WareHouseEx,	4,			0,				EmployeeID,		WHDescription,
		VoucherNo,		InvoiceNo+'/'+Serial,		WHRDAddress,	WHContactPerson,
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
	Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,		Ana10ID,
	ReVoucherID,	ReTransactionID,	OrderID,
	ConversionFactor, Notes

)
SELECT	D.Orders,
		D.DivisionID,		D.WHTransactionID,		D.WHVoucherID,	
		LEFT(D.Period, 2),	RIGHT(D.Period, 4),		D.CurrencyID,		D.ExchangeRate,
		D.InventoryID,		D.UnitID,				D.SourceNo,
		D.Quantity,			D.UnitPrice,
		D.Quantity,			D.UnitPrice,			
		Round(D.OriginalAmount,A4.ExchangeRateDecimal),	Round(D.ConvertedAmount,A2.ConvertedDecimals),
		D.WHDebitAccountID,	D.WHCreditAccountID,		
		D.Ana01ID,	D.Ana02ID,	D.Ana03ID,	D.Ana04ID,	D.Ana05ID,
		D.Ana06ID,	D.Ana07ID,	D.Ana08ID,	D.Ana09ID,		D.Ana10ID,
		Null,		Null,		D.VoucherNo,
		ISNULL(A6.ConversionFactor,1), D.TDescription

FROM	#Data D
LEFT JOIN AT1101 A2 WITH (NOLOCK) ON A2.DivisionID = D.DivisionID --AND A2.BaseCurrencyID = D.CurrencyID
LEFT JOIN AT1004 A4 WITH (NOLOCK) ON D.CurrencyID = A4.CurrencyID 
LEFT JOIN AT1309 A6 WITH (NOLOCK) ON A6.InventoryID = D.InventoryID  AND A6.UnitID = D.UnitID
END


LB_RESULT:
SELECT * FROM #Data

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
