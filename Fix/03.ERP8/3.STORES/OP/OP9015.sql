IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP9015]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP9015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Sinh tự động phiếu bán hàng từ đơn hàng bán (customize Mạnh Phương)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 30/03/2018 by Bảo Anh
---- Modified on 10/05/2018 by Bảo Anh: Bổ sung làm tròn cho cột OriginalAmountCN
---- Modified on 16/03/2020 by Văn Tài: Bổ sung xử lý AP0000_MP01 và format lại SQL.
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
-- <Example> OP9015 'MP',4,2018,'XO/04/2018/0943','BH'
---- 
CREATE PROCEDURE [dbo].[OP9015]
    @DivisionID AS NVARCHAR(50),
    @TranMonth AS INT,
    @TranYear AS INT,
    @SOrderID AS NVARCHAR(50),
    @SIVoucherTypeID AS NVARCHAR(50) --- loại chứng từ HDBH

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
		@RoundCAmount DECIMAL(28,8)

SET @SUMOAmount = 0
SET @SUMCAmount = 0
SET @RoundOAmount = 0
SET @RoundCAmount = 0

SELECT @ConvertedDecimals = ConvertedDecimals
		, @QuantityDecimals = QuantityDecimals
		, @UnitCostDecimals = UnitCostDecimals
FROM AT1101 WITH (NOLOCK) 
WHERE DivisionID = @DivisionID

SELECT @Serial = Serial
		, @InvoiceNo = @InvoiceNo + 1 
FROM AT0001 WITH (NOLOCK) 
WHERE DivisionID = @DivisionID

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
WHERE DivisionID = @DivisionID AND VoucherTypeID = @SIVoucherTypeID

If @Enabled1 = 1
	SET @StringKey1T04 = 
	CASE @S1Type 
	WHEN 1 THEN CASE WHEN @TranMonth <10 THEN '0' + LTRIM(@TranMonth) ELSE LTRIM(@TranMonth) END
	WHEN 2 THEN LTRIM(@TranYear)
	WHEN 3 THEN @SIVoucherTypeID
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
	WHEN 3 THEN @SIVoucherTypeID
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
	WHEN 3 THEN @SIVoucherTypeID
	WHEN 4 THEN @DivisionID
	WHEN 5 THEN @S3
	ELSE '' END
ELSE
	SET @StringKey3T04 = ''

--- Sinh VoucherID, BatchID
SET @VoucherID = NEWID()
SET @BatchID = NEWID()

Recal:
--- Sinh số chứng từ bán hàng
IF (@SIVoucherTypeID IN ('N'))
BEGIN
    EXEC AP0000_MP01 @DivisionID,
                @SIVoucherNo OUTPUT,
                'AT9000',
                @StringKey1T04,
                @StringKey2T04,
                @StringKey3T04,
                @OutputLenT04,
                @OutputOrderT04,
                @SeparatedT04,
                @SeparatorT04;
END
ELSE
BEGIN
    EXEC AP0000 @DivisionID,
                @SIVoucherNo OUTPUT,
                'AT9000',
                @StringKey1T04,
                @StringKey2T04,
                @StringKey3T04,
                @OutputLenT04,
                @OutputOrderT04,
                @SeparatedT04,
                @SeparatorT04;
END;

IF EXISTS (SELECT 1 FROM AT9000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TransactionTypeID = 'T04' AND VoucherNo = @SIVoucherNo)
	GOTO Recal

--- Insert dòng bán hàng (kg insert dòng VAT vì Mạnh Phương rất ít khi có VAT)
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
    OTransactionID,
    IsMultiTax,
    VATOriginalAmount,
    VATConvertedAmount,
    PriceListID,
    VATTypeID,
    MOrderID,
    CreateDate,
    CreateUserID,
    LastModifyDate,
    LastModifyUserID
)
SELECT OT02.DivisionID,
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
       @SIDebitAccountID,
       (
           SELECT TOP 1
                  SalesAccountID
           FROM AT1302 WITH (NOLOCK)
           WHERE AT1302.DivisionID IN ('@@@', OT02.DivisionID) AND InventoryID = OT02.InventoryID
       ) AS SalesAccountID,
       OT01.ExchangeRate,
       ROUND(OT02.SalePrice, @UnitCostDecimals),
       ROUND(OT02.ConvertedSalePrice, @UnitCostDecimals),
       ROUND(OT02.OriginalAmount - ISNULL(OT02.DiscountOriginalAmount, 0), T04.ExchangeRateDecimal),
       ROUND(OT02.ConvertedAmount - ISNULL(OT02.DiscountConvertedAmount, 0), @ConvertedDecimals),
       1,
       OT01.OrderDate,
       OT01.OrderDate,
       @SIVoucherTypeID,
       OT02.VATGroupID,
       @SIVoucherNo,
       @Serial,
       @InvoiceNo,
       OT02.Orders,
       OT01.EmployeeID,
       @VDescription + ' - ' + ISNULL(OT01.ObjectName, ''),
       @BDescription + ' - ' + ISNULL(OT01.ObjectName, ''),
       OT02.Description,
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
       OT01.CurrencyID,
       OT01.PaymentID,
       OT01.PaymentTermID,
       OT01.DueDate,
       OT02.DiscountPercent,
       ROUND(OT02.DiscountConvertedAmount, @ConvertedDecimals),
       OT02.SOrderID,
       OT02.TransactionID,
       0,
       NULL,
       NULL,
       OT01.PriceListID,
       @VATTypeIDT04,
       OT02.SOrderID,
       GETDATE(),
       OT01.CreateUserID,
       GETDATE(),
       OT01.CreateUserID
FROM OT2002 OT02 WITH (NOLOCK)
    INNER JOIN OT2001 OT01 WITH (NOLOCK)
        ON OT02.DivisionID = OT01.DivisionID
           AND OT02.SOrderID = OT01.SOrderID
    LEFT JOIN AT1004 T04 WITH (NOLOCK)
        ON OT01.CurrencyID = T04.CurrencyID
WHERE OT02.DivisionID = @DivisionID
      AND OT02.SOrderID = @SOrderID;

--- Làm tròn tiền cho dòng cuối cùng để tổng tiền hóa đơn là số chẵn
SELECT	@SUMOAmount = SUM(OriginalAmount), @SUMCAmount = SUM(ConvertedAmount),
		@RoundOAmount = SUM(OriginalAmount) - ROUND(SUM(OriginalAmount),-3),
		@RoundCAmount = SUM(ConvertedAmount) - ROUND(SUM(ConvertedAmount),-3)
FROM AT9000 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID AND TransactionTypeID = 'T04'

IF @RoundOAmount <> 0 OR @RoundCAmount <> 0
BEGIN
	WITH CTE AS (SELECT TOP 1 TransactionID, OriginalAmount, ConvertedAmount, OriginalAmountCN FROM AT9000 WITH (NOLOCK)
				WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID AND TransactionTypeID = 'T04' ORDER BY Orders DESC)
	UPDATE CTE
	SET OriginalAmount = OriginalAmount - @RoundOAmount,
		ConvertedAmount = ConvertedAmount - @RoundCAmount,
		OriginalAmountCN = OriginalAmount - @RoundOAmount
END

Update AT0001 Set Serial = @Serial, InvoiceNo = @InvoiceNo Where DivisionID = @DivisionID		

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
