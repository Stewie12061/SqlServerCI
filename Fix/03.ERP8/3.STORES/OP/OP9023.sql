IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP9023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP9023]
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
---- Create on 21/11/2023 by Kiều Nga
---- Modified on 18/12/2023 by Kiều Nga: [2023/12/IS/0188] Xử lý Kiểm tra tồn tại Phiếu Xuất Kho
---- Modified on 19/12/2023 by Kiều Nga : [2023/12/IS/0179] Fix lỗi tạo tự động đơn hàng bán không xem được phiếu xuất kho trong chi tiết hoá đơn

CREATE PROCEDURE [dbo].[OP9023]
    @DivisionID AS NVARCHAR(50),
    @TranMonth AS INT,
    @TranYear AS INT,
    @SOrderID AS NVARCHAR(50),
	@VoucherTypeID AS NVARCHAR(50),
	@WareHouseID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50) = ''
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
		@VoucherID NVARCHAR(50),
		@ParamLastKey INT =0

PRINT N'------ OP9023---------------'

--Kiểm tra tồn tại
IF EXISTS (SELECT 1 FROM AT2006 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND OrderID = @SOrderID)
RETURN

		--- Sinh VoucherID, BatchID
--SET @VoucherID = NEWID()

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
       @TDescription = ISNULL(TDescription, '') --,
       --@WarehouseID = WareHouseID
FROM AT1007 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
      AND VoucherTypeID = @VoucherTypeID;

IF @Enabled1 = 1
	SET @StringKey1T06 = 
	CASE @S1Type 
	WHEN 1 THEN CASE WHEN @TranMonth < 10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	WHEN 2 Then ltrim(@TranYear)
	WHEN 3 Then @VoucherTypeID
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
	When 3 Then @VoucherTypeID
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
	When 3 Then @VoucherTypeID
	When 4 Then @DivisionID
	When 5 Then @S3
	Else '' End
Else
	SET @StringKey3T06 = ''

Recal:

--PRINT @DivisionID
--PRINT @StringKey1T06
--PRINT @StringKey2T06
--PRINT @StringKey3T06
--PRINT @OutputLenT06
--PRINT @OutputOrderT06
--PRINT @SeparatedT06
--PRINT @SeparatorT06

--- Sinh số chứng từ xuất kho
SET @ParamLastKey = (SELECT TOP 1 LastKey FROM OP9024temp)

EXEC AP0000_HT @DivisionID,
            @DEVoucherNo OUTPUT,
            'AT2006',
            @StringKey1T06,
            @StringKey2T06,
            @StringKey3T06,
            @OutputLenT06,
            @OutputOrderT06,
            @SeparatedT06,
            @SeparatorT06,
			@ParamLastKey OUTPUT


IF EXISTS
(
    SELECT 1
    FROM AT2006 WITH (NOLOCK)
    WHERE DivisionID = @DivisionID
          AND VoucherNo = @DEVoucherNo
)
    GOTO Recal;

--PRINT @DEVoucherNo

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
	VATObjectName,
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
    RefNo02,
	ContactPerson,
	RDAddress
)
SELECT TOP 1
       AT90.DivisionID,
       AT90.VoucherID,
       'AT2006',
       @TranMonth,
       @TranYear,
       @VoucherTypeID,
       AT90.VoucherDate, 
       @DEVoucherNo,
       AT90.ObjectID,
	   ISNULL(AT90.VATObjectName, AT02.ObjectName),
       @WareHouseID,
       4,
       TDescription,
       AT90.EmployeeID,
       GETDATE(),
       AT90.CreateUserID,
       GETDATE(),
       AT90.CreateUserID,
       '%',
       @SOrderID,
       AT90.VoucherNo,
       @SOrderID,
	   AT90.Parameter02,
	   AT90.SRAddress
FROM AT9000 AT90 WITH (NOLOCK)
LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON  AT90.DivisionID IN (AT02.DivisionID, '@@@') AND AT90.VATObjectID = AT02.ObjectID
WHERE AT90.DivisionID = @DivisionID
      AND AT90.OrderID = @SOrderID
	  AND AT90.TransactionTypeID = 'T04'

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
	SOrderID,
    OTransactionID,
    ConvertedQuantity,
    ConvertedUnitID,
    Notes
)
SELECT AT90.DivisionID,
       NewID(),
       AT90.VoucherID,
       AT90.InventoryID,
       AT90.UnitID,
       ROUND(AT90.Quantity, @QuantityDecimals),
       @TranMonth,
       @TranYear,
       AT90.CurrencyID,
       AT90.ExchangeRate,
	   CASE WHEN AT90.IsProInventoryID = 1 THEN CASE WHEN AT90.VoucherTypeID like 'PQ%' THEN '6418P' ELSE '6418' END
	   ELSE	   
		   (
			   SELECT TOP 1
					  PrimeCostAccountID
			   FROM AT1302 WITH (NOLOCK)
			   WHERE AT1302.DivisionID IN ('@@@', AT90.DivisionID) AND InventoryID = AT90.InventoryID
		   )
	   END
	   AS PrimeCostAccountID, -- tài khoản nợ
       (
           SELECT TOP 1
                  AccountID
           FROM AT1302 WITH (NOLOCK)
           WHERE AT1302.DivisionID IN ('@@@', AT90.DivisionID) AND InventoryID = AT90.InventoryID
       ) AS AccountID, -- tài khoản có
       AT90.Orders,
       1,
       AT90.Ana01ID,
       CASE WHEN AT90.IsProInventoryID = 1 THEN '08003' ELSE AT90.Ana02ID END Ana02ID, -- loại chi phí
       AT90.Ana03ID,
       AT90.Ana04ID,
       AT90.Ana05ID,
       AT90.Ana06ID,
       AT90.Ana07ID,
       AT90.Ana08ID,
       AT90.Ana09ID,
       AT90.Ana10ID,
       AT90.SOrderID,
	   AT90.SOrderID,
	   AT90.SOrderID,
       AT90.OTransactionID,
       ROUND(AT90.ConvertedQuantity, @QuantityDecimals),
       AT90.UnitID,
       @TDescription
FROM AT9000 AT90 WITH (NOLOCK)
    LEFT JOIN AT1004 T04 WITH (NOLOCK) ON AT90.CurrencyID = T04.CurrencyID
WHERE AT90.DivisionID = @DivisionID
      AND AT90.OrderID = @SOrderID
	  AND AT90.TransactionTypeID = 'T04'

--INSERT INTO AT3206_AG
--(	DivisionID,
--	VoucherID,
--	OrderID,
--	OTransactionID,
--	ActualQuantity
--)
--SELECT 
--	   @DivisionID,
--	   @VoucherID,
--	   OT01.SOrderID,
--	   OT02.TransactionID,
--	   OT02.OrderQuantity
--FROM OT2002 OT02 WITH (NOLOCK)
--    INNER JOIN OT2001 OT01 WITH (NOLOCK)
--        ON OT02.DivisionID = OT01.DivisionID
--           AND OT02.SOrderID = OT01.SOrderID
--WHERE OT02.DivisionID = @DivisionID
--      AND OT02.SOrderID = @SOrderID;

-- Update số lượng đã kế thừa 
--UPDATE 	OT2002
--SET SOActualQuantity = OrderQuantity
--WHERE DivisionID = @DivisionID
--      AND SOrderID = @SOrderID;

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
       'AT2006',
	   @UserID,
	   GETDATE(),
	   '1',
	   @DEVoucherNo,
	   NULL
FROM OT2001 OT01 WITH (NOLOCK)
WHERE OT01.DivisionID = @DivisionID
      AND OT01.SOrderID = @SOrderID;	  

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
