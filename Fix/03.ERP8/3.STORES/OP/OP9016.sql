IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP9016]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP9016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Sinh tự động phiếu xuất kho từ đơn hàng bán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 30/03/2018 by Bảo Anh
---- Modified on 16/03/2020 by Văn Tài	Bổ sung sử dụng AP0000_MP02 và format lại SQL.
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
-- <Example> OP9016 'MP',4,2018,'XO/04/2018/0943','X1'
---- 
CREATE PROCEDURE [dbo].[OP9016]
    @DivisionID AS NVARCHAR(50),
    @TranMonth AS INT,
    @TranYear AS INT,
    @SOrderID AS NVARCHAR(50),
    @DEVoucherTypeID AS NVARCHAR(50) --- loại chứng từ xuất kho

AS

Declare @IsMultiTax BIT,
		@DEDebitAccountID NVARCHAR(50),
		@DEVoucherNo NVARCHAR(50),
		@StringKey1T06 nvarchar(50),
		@StringKey2T06 nvarchar(50),
		@StringKey3T06 nvarchar(50), 
		@OutputLenT06 int, 
		@OutputOrderT06 int,
		@SeparatedT06 int, 
		@SeparatorT06 char(1),
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
		@WarehouseID NVARCHAR(50),
		@VoucherID NVARCHAR(50)

SELECT @ConvertedDecimals = ConvertedDecimals,
       @QuantityDecimals = QuantityDecimals,
       @UnitCostDecimals = UnitCostDecimals
FROM AT1101 WITH (NOLOCK)
WHERE DivisionID = @DivisionID;

--Lấy chỉ số tăng số chứng từ xuất kho
SELECT @Enabled1 = Enabled1,
       @Enabled2 = Enabled2,
       @Enabled3 = Enabled3,
       @S1 = S1,
       @S2 = S2,
       @S3 = S3,
       @S1Type = S1Type,
       @S2Type = S2Type,
       @S3Type = S3Type,
       @OutputLenT06 = OutputLength,
       @OutputOrderT06 = OutputOrder,
       @SeparatedT06 = Separated,
       @SeparatorT06 = separator,
       @DEDebitAccountID = DebitAccountID,
       @VDescription = ISNULL(VDescription, ''),
       @TDescription = ISNULL(TDescription, ''),
       @WarehouseID = WareHouseID
FROM AT1007 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
      AND VoucherTypeID = @DEVoucherTypeID;

IF @Enabled1 = 1
	SET @StringKey1T06 = 
	CASE @S1Type 
	WHEN 1 THEN CASE WHEN @TranMonth < 10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	WHEN 2 Then ltrim(@TranYear)
	WHEN 3 Then @DEVoucherTypeID
	WHEN 4 Then @DivisionID
	WHEN 5 Then @S1
	ELSE '' End
Else
	SET @StringKey1T06 = ''

If @Enabled2 = 1
	SET @StringKey2T06 = 
	Case @S2Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @DEVoucherTypeID
	When 4 Then @DivisionID
	When 5 Then @S2
	Else '' End
Else
	SET @StringKey2T06 = ''

If @Enabled3 = 1
	SET @StringKey3T06 = 
	Case @S3Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @DEVoucherTypeID
	When 4 Then @DivisionID
	When 5 Then @S3
	Else '' End
Else
	SET @StringKey3T06 = ''

Recal:
--- Sinh số chứng từ xuất kho
IF (@DEVoucherTypeID IN ( 'XB1', 'XB2', 'XB3', 'XB4', 'XB5', 'XB6', 'XB7' ))
BEGIN
    EXEC AP0000_MP02 @DivisionID,
                  @DEVoucherNo OUTPUT,
                  'AT9000',
                  @StringKey1T06,
                  @StringKey2T06,
                  @StringKey3T06,
                  @OutputLenT06,
                  @OutputOrderT06,
                  @SeparatedT06,
                  @SeparatorT06;
END;
ELSE
BEGIN
    EXEC AP0000 @DivisionID,
                @DEVoucherNo OUTPUT,
                'AT9000',
                @StringKey1T06,
                @StringKey2T06,
                @StringKey3T06,
                @OutputLenT06,
                @OutputOrderT06,
                @SeparatedT06,
                @SeparatorT06;
END;

IF EXISTS
(
    SELECT 1
    FROM AT2006 WITH (NOLOCK)
    WHERE DivisionID = @DivisionID
          AND VoucherNo = @DEVoucherNo
)
    GOTO Recal;

INSERT INTO AT2006
(
    DivisionID,
    VoucherID,
    TableID,
    TranMonth,
    TranYear,
    VoucherTypeID,
    VoucherDate,
    VoucherNo,
    ObjectID,
    WareHouseID,
    KindVoucherID,
    [Description],
    EmployeeID,
    CreateDate,
    CreateUserID,
    LastModifyDate,
    LastModifyUserID,
    InventoryTypeID,
    OrderID,
    RefNo01,
    RefNo02
)
SELECT TOP 1
       AT9000.DivisionID,
       VoucherID,
       'AT2006',
       @TranMonth,
       @TranYear,
       @DEVoucherTypeID,
       VoucherDate,
       @DEVoucherNo,
       ObjectID,
       (
           SELECT TOP 1
                  WareHouseID
           FROM OT2002 WITH (NOLOCK)
           WHERE DivisionID = AT9000.DivisionID
                 AND TransactionID = AT9000.OTransactionID
       ) AS WareHouseID,
       4,
       @VDescription + ' - ' + ISNULL(AT9000.SRDivisionName, ''),
       EmployeeID,
       GETDATE(),
       CreateUserID,
       GETDATE(),
       CreateUserID,
       '%',
       @SOrderID,
       VoucherNo,
       @SOrderID
FROM AT9000 WITH (NOLOCK)
WHERE AT9000.DivisionID = @DivisionID
      AND AT9000.OrderID = @SOrderID
      AND TransactionTypeID = 'T04';

INSERT INTO AT2007
(
    DivisionID,
    TransactionID,
    VoucherID,
    InventoryID,
    UnitID,
    ActualQuantity,
    TranMonth,
    TranYear,
    CurrencyID,
    ExchangeRate,
    DebitAccountID,
    CreditAccountID,
    Orders,
    ConversionFactor,
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
    OrderID,
    MOrderID,
    OTransactionID,
    ConvertedQuantity,
    ConvertedUnitID,
    Notes
)
SELECT T90.DivisionID,
       TransactionID,
       VoucherID,
       T90.InventoryID,
       T90.UnitID,
       ROUND(T90.Quantity, @QuantityDecimals),
       @TranMonth,
       @TranYear,
       T90.CurrencyID,
       T90.ExchangeRate,
       @DEDebitAccountID,
       (
           SELECT TOP 1
                  AccountID
           FROM AT1302 WITH (NOLOCK)
           WHERE AT1302.DivisionID IN ('@@@', T90.DivisionID) AND InventoryID = T90.InventoryID
       ) AS AccountID,
       T90.Orders,
       1,
       T90.Ana01ID,
       T90.Ana02ID,
       T90.Ana03ID,
       T90.Ana04ID,
       T90.Ana05ID,
       T90.Ana06ID,
       T90.Ana07ID,
       T90.Ana08ID,
       T90.Ana09ID,
       T90.Ana10ID,
       T90.OrderID,
       T90.OrderID,
       T90.OTransactionID,
       ROUND(T90.ConvertedQuantity, @QuantityDecimals),
       T90.ConvertedUnitID,
       @TDescription + ' - ' + ISNULL(T90.SRDivisionName, '')
FROM AT9000 T90 WITH (NOLOCK)
    LEFT JOIN AT1004 T04 WITH (NOLOCK)
        ON T90.CurrencyID = T04.CurrencyID
WHERE T90.DivisionID = @DivisionID
      AND T90.OrderID = @SOrderID
      AND TransactionTypeID = 'T04';

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
