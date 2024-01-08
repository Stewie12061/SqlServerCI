IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP9024]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP9024]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Sinh tự động phiếu bán hàng từ Phiếu Xuất Kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 21/11/2023 by Kiều Nga
---- Modified on 14/12/2023 by Kiều Nga: [2023/12/IS/0176] Fix lỗi Màn hình truy vấn hoá đơn bán hàng bị hiển thị double phiếu khi hiển thị mặt hàng
---- Modified on 18/12/2023 by Kiều Nga: [2023/12/IS/0175] Xử lý mặc định TK có master theo loại chứng từ
---- Modified on 18/12/2023 by Kiều Nga: [2023/12/IS/0188] Xử lý Kiểm tra tồn tại phiếu bán hàng
---- Modified on 19/12/2023 by Kiều Nga : [2023/12/IS/0179] Fix lỗi tạo tự động đơn hàng bán không xem được phiếu xuất kho trong chi tiết hoá đơn

CREATE PROCEDURE [dbo].[OP9024]
    @DivisionID AS NVARCHAR(50),
    @TranMonth AS INT,
    @TranYear AS INT,
    @SOrderID AS NVARCHAR(50),
	@VoucherTypeID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50) = ''

AS
Declare @SIDebitAccountID NVARCHAR(50),
		@SIVoucherNo NVARCHAR(50),
		@StringKey1T04 nvarchar(50),
		@StringKey2T04 nvarchar(50),
		@StringKey3T04 nvarchar(50), 
		@OutputLenT04 int, 
		@OutputOrderT04 int,
		@SeparatedT04 int, 
		@SeparatorT04 char(1),
		@VATTypeIDT04 nvarchar(50),
		@Serial NVARCHAR(250),
		@InvoiceNo NVARCHAR(250),
		@VDescription NVARCHAR(250),
		@BDescription NVARCHAR(250),
		@TDescription NVARCHAR(250),
		@ConvertedDecimals INT,
		@QuantityDecimals INT,
		@UnitCostDecimals INT,
		@Enabled1 TINYINT,
		@Enabled2 TINYINT,
		@Enabled3 TINYINT,
		@S1 NVARCHAR(50),
		@S2 NVARCHAR(50),
		@S3 NVARCHAR(50),
		@S1Type TINYINT,
		@S2Type TINYINT,
		@S3Type TINYINT,
		@VoucherID NVARCHAR(50),
		@BatchID NVARCHAR(50),
		@SUMOAmount DECIMAL(28,8),
		@SUMCAmount DECIMAL(28,8),
		@RoundOAmount DECIMAL(28,8),
		@RoundCAmount DECIMAL(28,8),
		@InheritVoucherIDWM NVARCHAR(50),
		@InheritVoucherIDOP NVARCHAR(50),
        @InheritVoucherNoWM NVARCHAR(50),
		@InheritVoucherNoOP NVARCHAR(50),
		@InvoiceSign NVARCHAR(50),
		@InvoiceCode NVARCHAR(50),
		@OriginalAmountVAT DECIMAL(28,8),
		@ConvertedAmountVAT DECIMAL(28,8),
		@VATGroupID NVARCHAR(50),
		@VATRate DECIMAL(28,8),
		@QuantityVAT INT, -- Số lượng Loại Thuế
		@ParamLastKey INT = 0,
		@CreditAccountID NVARCHAR(50) =''

IF(@VoucherTypeID IN ('BH','BH-02','VAT'))
	SET @CreditAccountID = '33311'
ELSE IF (@VoucherTypeID IN ('PQ-BH','PQ-BH-02','PQ-VAT'))
	SET @CreditAccountID = '33311P'

PRINT N'------ OP9024---------------'

--Kiểm tra tồn tại
IF EXISTS (SELECT 1 FROM AT9000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TransactionTypeID = 'T04' AND OrderID = @SOrderID)
RETURN

SET @SUMOAmount = 0
SET @SUMCAmount = 0
SET @RoundOAmount = 0
SET @RoundCAmount = 0

SELECT @ConvertedDecimals = ConvertedDecimals
		, @QuantityDecimals = QuantityDecimals
		, @UnitCostDecimals = UnitCostDecimals
FROM AT1101 WITH (NOLOCK) 
WHERE DivisionID = @DivisionID

--SELECT @Serial = Serial
--	 , @InvoiceNo = @InvoiceNo + 1 
--	 , @InvoiceSign = InvoiceSign
--	 , @InvoiceCode = InvoiceCode
--	 FROM AT0001 WITH (NOLOCK) 
--WHERE DivisionID = @DivisionID

--PRINT @Serial

--Lấy chỉ số tăng số chứng từ bán hàng
Select	@Enabled1 = Enabled1
		, @Enabled2 = Enabled2
		, @Enabled3 = Enabled3
		, @S1 = S1
		, @S2 = S2
		, @S3 = S3
		, @S1Type = S1TYPE
		, @S2Type = S2Type
		, @S3Type = S3Type
		, @OutputLenT04 = OutputLength
		, @OutputOrderT04 = OutputOrder
		, @SeparatedT04 = Separated
		, @SeparatorT04 = Separator
		, @SIDebitAccountID = DebitAccountID
		, @VATTypeIDT04 = VATTypeID
		, @VDescription = ISNULL(VDescription,'')
		, @TDescription = ISNULL(TDescription,'')
		, @BDescription = ISNULL(BDescription,'')
FROM AT1007 WITH (NOLOCK) 
WHERE DivisionID = @DivisionID AND VoucherTypeID = @VoucherTypeID

If @Enabled1 = 1
	SET @StringKey1T04 = 
	CASE @S1Type 
	WHEN 1 THEN CASE WHEN @TranMonth <10 THEN '0' + LTRIM(@TranMonth) ELSE LTRIM(@TranMonth) END
	WHEN 2 THEN LTRIM(@TranYear)
	WHEN 3 THEN @VoucherTypeID
	WHEN 4 THEN @DivisionID
	WHEN 5 THEN @S1
	ELSE '' END
Else
	SET @StringKey1T04 = ''

IF @Enabled2 = 1
	SET @StringKey2T04 = 
	CASE @S2Type 
	WHEN 1 THEN CASE WHEN @TranMonth <10 THEN '0' + LTRIM(@TranMonth) ELSE LTRIM(@TranMonth) END
	WHEN 2 THEN LTRIM(@TranYear)
	WHEN 3 THEN @VoucherTypeID
	WHEN 4 THEN @DivisionID
	WHEN 5 THEN @S2
	ELSE '' END
ELSE
	SET @StringKey2T04 = ''

IF @Enabled3 = 1
	SET @StringKey3T04 = 
	CASE @S3Type 
	WHEN 1 THEN CASE WHEN @TranMonth < 10 THEN '0' + LTRIM(@TranMonth) ELSE LTRIM(@TranMonth) END
	WHEN 2 THEN ltrim(@TranYear)
	WHEN 3 THEN @VoucherTypeID
	WHEN 4 THEN @DivisionID
	WHEN 5 THEN @S3
	ELSE '' END
ELSE
	SET @StringKey3T04 = ''

--- Sinh VoucherID, BatchID
SET @VoucherID = NEWID()
SET @BatchID = NEWID()

--PRINT @VoucherID

Recal:

--PRINT @DivisionID
--PRINT @StringKey1T04
--PRINT @StringKey2T04
--PRINT @StringKey3T04
--PRINT @OutputLenT04
--PRINT @OutputOrderT04
--PRINT @SeparatedT04
--PRINT @SeparatorT04

--- Sinh số chứng từ bán hàng
BEGIN
    EXEC AP0000_HT @DivisionID,          
                @SIVoucherNo OUTPUT,
                'AT9000',
                @StringKey1T04,
                @StringKey2T04,
                @StringKey3T04,
                @OutputLenT04,
                @OutputOrderT04,
                @SeparatedT04,
                @SeparatorT04,
				@ParamLastKey OUTPUT
END;

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OP9023temp]') AND type in (N'U'))
DROP TABLE OP9024temp

SELECT @ParamLastKey as LastKey INTO OP9024temp


IF EXISTS (SELECT 1 FROM AT9000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TransactionTypeID = 'T04' AND VoucherNo = @SIVoucherNo)
	GOTO Recal

--PRINT @SIVoucherNo
--PRINT @SOrderID

-- Insert Số lượng Loại Thuế
SELECT @QuantityVAT = COUNT(DISTINCT VATGroupID) FROM OT2002 OT02 WITH (NOLOCK)
WHERE OT02.VATGroupID IS NOT NULL AND OT02.SOrderID = @SOrderID

--- Insert dòng bán hàng T04
INSERT INTO AT9000
(
    DivisionID,										
    VoucherID,
    BatchID,
    TransactionID,
    TableID,
    TranMonth,
    TranYear,
    TransactionTypeID,
    CurrencyID,
    ObjectID,
    VATObjectID,
	VATObjectName,
    DebitAccountID,
    CreditAccountID,
    ExchangeRate,
    UnitPrice,
    ConvertedPrice,
    OriginalAmount,
    ConvertedAmount,
    IsStock,
    VoucherDate,
    InvoiceDate,
    VoucherTypeID,
    VATGroupID,
    VoucherNo,
    Serial,
    InvoiceNo,
    Orders,
    EmployeeID,
    VDescription,
    BDescription,
    TDescription,
    Quantity,
    ConvertedQuantity,
    InventoryID,
    UnitID,
    ConvertedUnitID,
    Status,
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
    SenderReceiver,
    SRDivisionName,
    OriginalAmountCN,
    ExchangeRateCN,
    CurrencyIDCN,
    PaymentID,
    PaymentTermID,
    DueDate,
    DiscountRate,
    DiscountAmount,
    OrderID,
    IsMultiTax,
    VATOriginalAmount,
    VATConvertedAmount,
    PriceListID,
    VATTypeID,
    MOrderID,
    CreateDate,
    CreateUserID,
    LastModifyDate,
    LastModifyUserID,
	OTransactionID,
	WTransactionID,
	WOrderID,
	Parameter02,
	Parameter04,
	SRAddress,
	VATObjectAddress,
	InvoiceSign,
	InvoiceCode,
	IsEInvoice,
	IsProInventoryID,
	InheritQuantity,
	VATNo
)
SELECT OT01.DivisionID,
       @VoucherID,
       @BatchID,
       NEWID(),
       'AT9000',
       @TranMonth,
       @TranYear,
       'T04',
       OT01.CurrencyID,
       OT01.ObjectID,
       OT01.ObjectID,
	   ISNULL(OT01.VATObjectName, AT02.ObjectName) as VATObjectName,
       (SELECT TOP 1 ReAccountID 
			FROM AT1202 WITH (NOLOCK)
			WHERE AT1202.DivisionID IN ('@@@', OT01.DivisionID) AND AT1202.ObjectID = OT01.ObjectID)
		as DebitAccountID, --Tài khoản nợ
       (
           SELECT TOP 1
                  SalesAccountID
           FROM AT1302 WITH (NOLOCK)
           WHERE AT1302.DivisionID IN ('@@@', OT01.DivisionID) AND InventoryID = OT02.InventoryID -- Tài khoản có
       ) AS CreditAccountID,
       OT01.ExchangeRate,
       ROUND(OT02.SalePrice, @UnitCostDecimals),
       CASE WHEN ISNULL(OT02.IsProInventoryID,0) = 0 THEN ISNULL(ROUND(OT02.ConvertedSalePrice, @UnitCostDecimals),ROUND(OT02.SalePrice, @UnitCostDecimals))
			ELSE NULL END, -- ConvertedSalePrice
       ROUND(OT02.OriginalAmount - ISNULL(OT02.DiscountOriginalAmount, 0), T04.ExchangeRateDecimal),
       ROUND(OT02.ConvertedAmount - ISNULL(OT02.DiscountConvertedAmount, 0), @ConvertedDecimals),
       1,
       OT01.OrderDate,
       OT01.OrderDate,
       @VoucherTypeID,
       OT02.VATGroupID,
       @SIVoucherNo,
       CASE WHEN ISNULL(OT01.ContractNo,'') <>'' THEN  OT01.VoucherNo + '-' + OT01.ContractNo ELSE OT01.VoucherNo END as Serial,
       CASE WHEN ISNULL(OT01.ContractNo,'') <>'' THEN  OT01.VoucherNo + '-' + OT01.ContractNo ELSE OT01.VoucherNo END as InvoiceNo,
       OT02.Orders,
       OT01.EmployeeID,
       OT01.Notes ,
       OT01.Notes  ,
       OT01.Notes,
       ROUND(OT02.OrderQuantity, @QuantityDecimals),
       ROUND(OT02.ConvertedQuantity, @QuantityDecimals),
       OT02.InventoryID,
       OT02.UnitID,
       OT02.UnitID,
       0,
       OT02.Ana01ID,
       OT02.Ana02ID,
       OT02.Ana03ID,
       OT02.Ana04ID,
       OT02.Ana05ID,
       OT02.Ana06ID,
       OT02.Ana07ID,
       OT02.Ana08ID,
       OT02.Ana09ID,
       OT02.Ana10ID,
       OT01.ObjectName,
       OT01.ObjectName,
       ROUND(OT02.OriginalAmount - ISNULL(OT02.DiscountOriginalAmount, 0), T04.ExchangeRateDecimal),
       OT01.ExchangeRate,
       OT02.CurrencyID,
       OT01.PaymentID,
	   (SELECT TOP 1 RePaymentTermID 
			FROM AT1202 WITH (NOLOCK)
			WHERE AT1202.DivisionID IN ('@@@', OT01.DivisionID) AND AT1202.ObjectID = OT01.ObjectID)
		as PaymentTermID,-- Điều khoản thanh toán
       OT01.DueDate,
       OT02.DiscountPercent,
       ROUND(OT02.DiscountConvertedAmount, @ConvertedDecimals),
       OT01.SOrderID,
       1, -- IsMultiTax
       OT02.VATOriginalAmount, 
       OT02.VATConvertedAmount,
	   OT01.PriceListID,
       @VATTypeIDT04,
       OT01.SOrderID,
       GETDATE(),
       OT01.CreateUserID,
       GETDATE(),
       OT01.CreateUserID,
	   OT02.TransactionID as OTransactionID,
	   NULL as WTransactionID,
	   NULL as WOrderID,
	   OT01.Contact as Parameter02,
	   OT01.PaymentID as Parameter04,
	   OT01.DeliveryAddress as SRAddress,
	   OT01.DeliveryAddress as VATObjectAddress, -- RDAddress - Địa chỉ giao hàng
	   @InvoiceSign,
	   @InvoiceCode,
	   1, -- IsEInvoice
	   OT02.IsProInventoryID,
	   OT02.OrderQuantity as InheritQuantity,
	   ISNULL(OT01.VatNo,T02.VATNo) as VATNo
FROM OT2001 OT01 WITH (NOLOCK)
	INNER JOIN OT2002 OT02 WITH (NOLOCK) ON OT02.DivisionID = OT01.DivisionID AND OT02.SOrderID = OT01.SOrderID
	LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON  OT01.DivisionID IN (AT02.DivisionID, '@@@') AND OT01.VATObjectID = AT02.ObjectID
    LEFT JOIN AT1004 T04 WITH (NOLOCK) ON OT01.CurrencyID = T04.CurrencyID
	LEFT JOIN AT1202 T02 WITH (NOLOCK) ON OT01.DivisionID = T02.DivisionID AND OT01.VATObjectID = T02.ObjectID
WHERE OT01.DivisionID = @DivisionID
      AND OT01.SOrderID = @SOrderID;

--- Insert dòng thuế T14
BEGIN 
	INSERT INTO AT9000
(
    DivisionID,										
    VoucherID,
    BatchID,
    TransactionID,
    TableID,
    TranMonth,
    TranYear,
    TransactionTypeID,
    CurrencyID,
    ObjectID,
    VATObjectID,
	VATObjectName,
    DebitAccountID,
    CreditAccountID,
    ExchangeRate,
    UnitPrice,
    ConvertedPrice,
    OriginalAmount,
    ConvertedAmount,
    IsStock,
    VoucherDate,
    InvoiceDate,
    VoucherTypeID,
    VATGroupID,
    VoucherNo,
    Serial,
    InvoiceNo,
    Orders,
    EmployeeID,
    VDescription,
    BDescription,
    TDescription,
    Quantity,
    ConvertedQuantity,
    InventoryID,
    UnitID,
    ConvertedUnitID,
    Status,
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
    SenderReceiver,
    SRDivisionName,
    OriginalAmountCN,
    ExchangeRateCN,
    CurrencyIDCN,
    PaymentID,
    PaymentTermID,
    DueDate,
    DiscountRate,
    DiscountAmount,
    OrderID,
    IsMultiTax,
    VATOriginalAmount,
    VATConvertedAmount,
    PriceListID,
    VATTypeID,
    MOrderID,
    CreateDate,
    CreateUserID,
    LastModifyDate,
    LastModifyUserID,
	OTransactionID,
	WTransactionID,
	WOrderID,
	Parameter02,
	Parameter04,
	SRAddress,
	VATObjectAddress,
	InvoiceSign,
	InvoiceCode,
	IsEInvoice,
	IsProInventoryID,
	InheritQuantity,
	VATNo
)
SELECT OT01.DivisionID,
       @VoucherID,
       @BatchID,
       NEWID(),
       'AT9000', -- TableID
       @TranMonth,
       @TranYear,
       'T14', -- TransactionTypeID
       OT01.CurrencyID,
       OT01.ObjectID,
       OT01.ObjectID,
	   ISNULL(OT01.VATObjectName, AT02.ObjectName) as VATObjectName,
       (SELECT TOP 1 ReAccountID 
			FROM AT1202 WITH (NOLOCK)
			WHERE AT1202.DivisionID IN ('@@@', OT01.DivisionID) AND AT1202.ObjectID = OT01.ObjectID)
		as DebitAccountID, --Tài khoản nợ,
       @CreditAccountID AS CreditAccountID,-- CreditAccountID,
       OT01.ExchangeRate,
       ROUND(OT02.SalePrice, @UnitCostDecimals),
       ROUND(OT02.ConvertedSalePrice, @UnitCostDecimals),
	   ROUND(OT02.VATOriginalAmount,0), 
       ROUND(OT02.VATConvertedAmount,0),
       1, -- IsStock
       OT01.OrderDate,
       OT01.OrderDate,
       @VoucherTypeID, -- VoucherTypeID
	   OT02.VATGroupID,	 
       @SIVoucherNo,
       CASE WHEN ISNULL(OT01.ContractNo,'') <>'' THEN  OT01.VoucherNo + '-' + OT01.ContractNo ELSE OT01.VoucherNo END as Serial,
       CASE WHEN ISNULL(OT01.ContractNo,'') <>'' THEN  OT01.VoucherNo + '-' + OT01.ContractNo ELSE OT01.VoucherNo END as InvoiceNo,
       0, -- Orders
       OT01.EmployeeID,
       OT01.Notes , -- VDescription
       OT01.Notes , -- BDescription
       N'Thuế GTGT đầu ra', -- TDescription
       ROUND(OT02.OrderQuantity, @QuantityDecimals),
       ROUND(OT02.ConvertedQuantity, @QuantityDecimals),
       NULL,
       OT02.UnitID,
       OT02.UnitID,
       0, -- Status
       OT02.Ana01ID,
       OT02.Ana02ID,
       OT02.Ana03ID,
       OT02.Ana04ID,
       OT02.Ana05ID,
       OT02.Ana06ID,
       OT02.Ana07ID,
       OT02.Ana08ID,
       OT02.Ana09ID,
       OT02.Ana10ID,
       OT01.ObjectName,
       OT01.ObjectName,
       ROUND(OT02.OriginalAmount - ISNULL(OT02.DiscountOriginalAmount, 0), T04.ExchangeRateDecimal),
       OT01.ExchangeRate,
       OT01.CurrencyID,
       OT01.PaymentID,
	   (SELECT TOP 1 RePaymentTermID 
			FROM AT1202 WITH (NOLOCK)
			WHERE AT1202.DivisionID IN ('@@@', OT01.DivisionID) AND AT1202.ObjectID = OT01.ObjectID)
	   as PaymentTermID,
       OT01.DueDate,
       OT02.DiscountPercent,
       ROUND(OT02.DiscountConvertedAmount, @ConvertedDecimals),
       OT01.SOrderID,
       NULL, -- IsMultiTax
       NULL, -- VATOriginalAmount
       NULL,
       OT01.PriceListID,
       @VATTypeIDT04,
       OT01.SOrderID,
       GETDATE(),
       OT01.CreateUserID,
       GETDATE(),
       OT01.CreateUserID,
	   OT02.TransactionID as OTransactionID,
	   NULL as WTransactionID,
	   NULL as WOrderID,
	   OT01.Contact as Parameter02,
	   OT01.PaymentID as Parameter04,
	   OT01.DeliveryAddress as SRAddress,
	   OT01.DeliveryAddress as VATObjectAddress,
	   @InvoiceSign,
	   @InvoiceCode,
	   1, -- IsEInvoice,
	   NULL as IsProInventoryID,
	   NULL as ActualQuantity,
	   ISNULL(OT01.VatNo,T02.VATNo)
FROM OT2001 OT01 WITH (NOLOCK)
	INNER JOIN OT2002 OT02 WITH (NOLOCK) ON OT02.DivisionID = OT01.DivisionID AND OT02.SOrderID = OT01.SOrderID
	LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON  OT01.DivisionID IN (AT02.DivisionID, '@@@') AND OT01.VATObjectID = AT02.ObjectID
    LEFT JOIN AT1004 T04 WITH (NOLOCK) ON OT01.CurrencyID = T04.CurrencyID
    LEFT JOIN AT1202 T02 WITH (NOLOCK) ON OT01.DivisionID = T02.DivisionID AND OT01.VATObjectID = T02.ObjectID
WHERE OT01.DivisionID = @DivisionID
      AND OT01.SOrderID = @SOrderID;
END

Update AT9000 Set IsStock = 1 Where VoucherID = @VoucherID And BatchID = @BatchID And DivisionID = @DivisionID

INSERT INTO HistoryInfo
(	DivisionID,
	TableID,	
    ModifyUserID,	
    ModifyDate,	
    Action,	
    VoucherNo,	
    TransactionTypeID
)
SELECT @DivisionID,
       'AF0066',
	   AT06.CreateUserID,
	   GETDATE(),
	   '1',
	   @SIVoucherNo,
	   'T04'
FROM AT2006 AT06 WITH (NOLOCK)
WHERE AT06.DivisionID = @DivisionID
      AND AT06.OrderID = @SOrderID;	  

SET @InheritVoucherIDWM = (SELECT STRING_AGG(VoucherID, ', ') FROM AT2007 AT07 WITH (NOLOCK) WHERE AT07.OrderID = @SOrderID)
SET @InheritVoucherNoWM = (SELECT STRING_AGG(AT06.VoucherNo, ', ') FROM AT2007 AT07 WITH (NOLOCK)
						   INNER JOIN AT2006 AT06 WITH (NOLOCK) ON AT07.DivisionID = AT06.DivisionID AND AT07.VoucherID = AT06.VoucherID
						   WHERE AT07.OrderID = @SOrderID)

SET @InheritVoucherIDOP = (SELECT TOP 1 OrderID FROM AT2007 AT07 WITH (NOLOCK) WHERE AT07.OrderID = @SOrderID)
SET @InheritVoucherNoOP = (SELECT TOP 1 OrderID FROM AT2007 AT07 WITH (NOLOCK) WHERE AT07.OrderID = @SOrderID)


--PRINT @InheritVoucherIDWM
--PRINT @InheritVoucherNoWM
--PRINT @InheritVoucherIDOP
--PRINT @InheritVoucherNoOP

-- Insert Lịch sử kế thừa kế thừa ĐHB
IF ISNULL (@InheritVoucherIDOP, '') <> ''
BEGIN
	INSERT INTO AT9990
(	DivisionID,
    VoucherID,
    VoucherNo,
    VoucherDate,
    InheritDate,
    EmployeeID,
    InheritSourceID,
    InheritVoucherID,
    InheritVoucherNo
)
SELECT TOP 1
	   @DivisionID,
       @VoucherID,
	   @SIVoucherNo,
	   CAST(CONVERT(VARCHAR,GETDATE(),102) AS DATETIME),
	   CAST(CONVERT(VARCHAR,GETDATE(),102) AS DATETIME),
	   EmployeeID,
	   0,
	   @InheritVoucherIDOP,
	   @InheritVoucherNoOP
FROM AT9000 AT90 WITH (NOLOCK)
WHERE AT90.DivisionID = @DivisionID
      AND AT90.SOrderID = @SOrderID;
END

-- Insert Lịch sử kế thừa kế thừa PXK
--IF ISNULL (@InheritVoucherIDWM, '') <> ''
--BEGIN
--	INSERT INTO AT9990
--	(	DivisionID,
--	    VoucherID,
--	    VoucherNo,
--	    VoucherDate,
--	    InheritDate,
--	    EmployeeID,
--	    InheritSourceID,
--	    InheritVoucherID,
--	    InheritVoucherNo
--	)
--	SELECT TOP 1
--		   @DivisionID,
--	       @VoucherID,
--		   @SIVoucherNo,
--		   CAST(CONVERT(VARCHAR,GETDATE(),102) AS DATETIME),
--		   CAST(CONVERT(VARCHAR,GETDATE(),102) AS DATETIME),
--		   EmployeeID,
--		   1,
--		   @InheritVoucherIDWM,
--		   @InheritVoucherNoWM
--	FROM AT9000 AT90 WITH (NOLOCK)
--	WHERE AT90.DivisionID = @DivisionID
--	      AND AT90.SOrderID = @SOrderID;	
--END

--select  VoucherNo, InheritVoucherNo, InheritVoucherID, * from AT9990 
--where AT9990.VoucherNo like @SIVoucherNo

-- Lưu vết pxk khi kế thừa lẫn ĐHB và PXK
--INSERT INTO AT0266_AG
--(	  DivisionID,
--      VoucherID,
--      InheritVoucherID,
--      InheritTransactionID,
--      Quantity
--)
--SELECT @DivisionID,
--       @VoucherID,
--	   AT07.VoucherID,
--	   AT07.TransactionID,
--	   SUM(ActualQuantity)
--FROM AT2007 AT07 WITH (NOLOCK) WHERE AT07.OrderID = @SOrderID  
--GROUP BY AT07.InventoryID, AT07.DivisionID, AT07.VoucherID, AT07.TransactionID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
