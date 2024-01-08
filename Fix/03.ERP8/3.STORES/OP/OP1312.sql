IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP1312]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP1312]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Lay gia ban cua mat hang cho man hinh lap don hang ban - QUAN LY GIA
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 25/08/2017 by Truong Ngoc Phuong Thao
---- Modified on 28/02/2019 by Store trả thẳng dữ liệu, ko qua view 
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
--- EXEC OP1312 'mp', '%', '05-05-2012', '0', 'VND', '','','','','','','','','','','','','','','','','','','',''

CREATE PROCEDURE [dbo].[OP1312]
(
    @DivisionID NVARCHAR(50),
    @ObjectID NVARCHAR(50),
    @VoucherDate DATETIME,
    @PriceListID NVARCHAR(50),
    @CurrencyID NVARCHAR(50),
	@S01ID VARCHAR(50),
	@S02ID VARCHAR(50),
	@S03ID VARCHAR(50),
	@S04ID VARCHAR(50),
	@S05ID VARCHAR(50),
	@S06ID VARCHAR(50),
	@S07ID VARCHAR(50),
	@S08ID VARCHAR(50),
	@S09ID VARCHAR(50),
	@S10ID VARCHAR(50),
	@S11ID VARCHAR(50),
	@S12ID VARCHAR(50),
	@S13ID VARCHAR(50),
	@S14ID VARCHAR(50),
	@S15ID VARCHAR(50),
	@S16ID VARCHAR(50),
	@S17ID VARCHAR(50),
	@S18ID VARCHAR(50),
	@S19ID VARCHAR(50),
	@S20ID VARCHAR(50)
) 
AS
DECLARE 
    @sSQL NVARCHAR(max),
    @OTypeID NVARCHAR(50),
    @ID_Price NVARCHAR(50),
    @ID_Quantity NVARCHAR(50),
    @IsQuantityControl TINYINT,
    @IsPriceControl TINYINT,
    @IsConvertedPrice TINYINT,
    @OriginalCurrencyID TINYINT,
    @ExchangeRate DECIMAL(28,8),
    @BaseCurrencyID NVARCHAR(50),
    @Operator TINYINT,
    @IsConvertedUnit AS TINYINT,
	@sSQL01 NVARCHAR(max),
	@sSQL02 NVARCHAR(max),
	@sSQL03 NVARCHAR(max),
    @sSQL1 NVARCHAR(max),
    @sSQL2 NVARCHAR(max),
    @sSQL3 NVARCHAR(max),
	@CustomerIndex int

SET @sSQL = ''
SET @sSQL1 = ''
SET @sSQL2 = ''
SET @BaseCurrencyID = (SELECT TOP 1 ISNULL(BaseCurrencyID,0) FROM AV1004 WHERE DivisionID IN ( @DivisionID, '@@@'))
SET @IsConvertedUnit = (SELECT TOP 1 ISNULL(IsConvertUnit,0) AS IsConvertUnit FROM OT0000 WHERE DivisionID = @DivisionID)

--IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OV1302]') AND  OBJECTPROPERTY(ID, N'IsView') = 1)			
--DROP VIEW [DBO].[OV1302]

--IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OV1302]') AND  OBJECTPROPERTY(ID, N'IsTable') = 1)			
--DROP TABLE [DBO].[OV1302]

----------->>> Thiết lập bảng giá
--SELECT @OriginalCurrencyID = CurrencyID,
-- @IsConvertedPrice = IsConvertedPrice 
--FROM OT1301
--WHERE DivisionID = @DivisionID
-- AND ID = @PriceListID
----------<<< 
--SET @ExchangeRate = 1
--SET @Operator = 1

--IF @IsConvertedPrice = 1 AND @OriginalCurrencyID = @BaseCurrencyID
--SELECT @ExchangeRate = ExchangeRate ,
-- @Operator = Operator
--FROM AV1004 
--WHERE CurrencyID = @OriginalCurrencyID AND DivisionID = @DivisionID

--TypeQuantityControl 0: Khong
--1 Toi thieu
--2 Toi da
--3 Toi thieu va toi da 

--TypePriceControl 0: Khong
--1 Toi thieu
--2 Toi da
--3 Toi thieu va toi da 

SET @VoucherDate = DATEADD(dd, DATEDIFF(dd, 0, @VoucherDate), 1)
SELECT TOP 1 @CustomerIndex = CustomerName From CustomerIndex

SELECT
    @OTypeID = OPriceTypeID + 'ID',
    @IsPriceControl = ISNULL(IsPriceControl, 0),
    @IsQuantityControl = ISNULL(IsQuantityControl,0)
FROM OT0000
WHERE DivisionID = @DivisionID


SET @sSQL01 = '
SELECT TOP 1
AT1302.DivisionID,
AT1302.InventoryID,
AT1302.InventoryName,
AT1302.Specification,
AT1302.UnitID,
AT1304.UnitName,
AT1302.InventoryTypeID,
AT1302.IsStocked,
AT1302.VATGroupID,
AT1302.VATPercent,
ISNULL((CASE WHEN AV1004.Operator = 0 THEN AT1302.SalePrice01 * AV1004.ExchangeRate 
				ELSE AT1302.SalePrice01 / AV1004.ExchangeRate END), 0) AS SalePrice,
CAST(0 AS DECIMAL(28,8)) AS UnitPrice,
CAST(0 AS DECIMAL(28,8)) AS MinPrice , 
CAST(0 AS DECIMAL(28,8)) AS MaxPrice,
CAST(0 AS DECIMAL(28,8)) AS MinQuantity, 
CAST(0 AS DECIMAL(28,8)) AS MaxQuantity,
0 AS TypePriceControl,
0 AS TypeQuantityControl,
ISNULL(AT1302.SalePrice01, 0) As SalePrice01,
ISNULL(AT1302.SalePrice02, 0) As SalePrice02,
ISNULL(AT1302.SalePrice03, 0) As SalePrice03,
ISNULL(AT1302.SalePrice04, 0) As SalePrice04,
ISNULL(AT1302.SalePrice05, 0) As SalePrice05,
CAST(NULL AS NVARCHAR(250)) AS Notes,
CAST(NULL AS NVARCHAR(250)) AS Notes01,
CAST(NULL AS NVARCHAR(250)) AS Notes02,
AT1302.Barcode,
'
SET @sSQL02 = '
CAST(0 AS DECIMAL(28,8)) AS DiscountPercent,
CAST(0 AS DECIMAL(28,8)) AS DiscountAmount,
CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent01,
CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount01,
CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent02,
CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount02,
CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent03,
CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount03,
CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent04,
CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount04,
CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent05,
CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount05,
ISNULL(OT0117.FromQuantity1, 0) As FromQuantity1, ISNULL(OT0117.ToQuantity1, 0) As ToQuantity1, ISNULL(OT0117.Price1, 0) As Price1,ISNULL(OT0117.DiscountAmount1, 0) As DiscountAmount1,
ISNULL(OT0117.FromQuantity2, 0) As FromQuantity2, ISNULL(OT0117.ToQuantity2, 0) As ToQuantity2, ISNULL(OT0117.Price2, 0) As Price2,ISNULL(OT0117.DiscountAmount2, 0) As DiscountAmount2,
ISNULL(OT0117.FromQuantity3, 0) As FromQuantity3, ISNULL(OT0117.ToQuantity3, 0) As ToQuantity3, ISNULL(OT0117.Price3, 0) As Price3,ISNULL(OT0117.DiscountAmount3, 0) As DiscountAmount3,
ISNULL(OT0117.FromQuantity4, 0) As FromQuantity4, ISNULL(OT0117.ToQuantity4, 0) As ToQuantity4, ISNULL(OT0117.Price4, 0) As Price4,ISNULL(OT0117.DiscountAmount4, 0) As DiscountAmount4,
ISNULL(OT0117.FromQuantity5, 0) As FromQuantity5, ISNULL(OT0117.ToQuantity5, 0) As ToQuantity5, ISNULL(OT0117.Price5, 0) As Price5,ISNULL(OT0117.DiscountAmount5, 0) As DiscountAmount5,
ISNULL(OT0117.FromQuantity6, 0) As FromQuantity6, ISNULL(OT0117.ToQuantity6, 0) As ToQuantity6, ISNULL(OT0117.Price6, 0) As Price6,ISNULL(OT0117.DiscountAmount6, 0) As DiscountAmount6,
ISNULL(OT0117.FromQuantity7, 0) As FromQuantity7, ISNULL(OT0117.ToQuantity7, 0) As ToQuantity7, ISNULL(OT0117.Price7, 0) As Price7,ISNULL(OT0117.DiscountAmount7, 0) As DiscountAmount7,
ISNULL(OT0117.FromQuantity8, 0) As FromQuantity8, ISNULL(OT0117.ToQuantity8, 0) As ToQuantity8, ISNULL(OT0117.Price8, 0) As Price8,ISNULL(OT0117.DiscountAmount8, 0) As DiscountAmount8,
ISNULL(OT0117.FromQuantity9, 0) As FromQuantity9, ISNULL(OT0117.ToQuantity9, 0) As ToQuantity9, ISNULL(OT0117.Price9, 0) As Price9,ISNULL(OT0117.DiscountAmount9, 0) As DiscountAmount9,
ISNULL(OT0117.FromQuantity10, 0) As FromQuantity10,ISNULL(OT0117.ToQuantity10, 0) As ToQuantity10,ISNULL(OT0117.Price10, 0) As Price10,ISNULL(OT0117.DiscountAmount10, 0) As DiscountAmount10,
ISNULL(OT0117.Price, 0) AS OT0117Price,
ISNULL(OT0117.Discount, 0) AS OT0117Discount,
CAST(NULL AS NVARCHAR(250)) AS O01ID,
	0 TrayPrice, 0 DecreaseTrayPrice,NULL Qtyfrom,NULL QtyTo,
OT1301.IsPlanPrice,
AT1302.RecievedPrice, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.AccountID, 
AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate,isnull(AT1302.IsDiscount,0) as IsDiscount ,AT1302.SalesAccountID,
AT1302.PurchaseAccountID, AT1302.PrimeCostAccountID, AT1302.MethodID,AT1302.DeliveryPrice,
AT1302.ETaxID, 
AT1302.ETaxConvertedUnit, 
AT1302.NRTClassifyID, AT1302.SETID,
Convert(Decimal(28,8),0) AS [AddCost01],
Convert(Decimal(28,8),0) AS [AddCost02],
Convert(Decimal(28,8),0) AS [AddCost03],
Convert(Decimal(28,8),0) AS [AddCost04],
Convert(Decimal(28,8),0) AS [AddCost05],
Convert(Decimal(28,8),0) AS [AddCost06],
Convert(Decimal(28,8),0) AS [AddCost07],
Convert(Decimal(28,8),0) AS [AddCost08],
Convert(Decimal(28,8),0) AS [AddCost09],
Convert(Decimal(28,8),0) AS [AddCost10],
Convert(Decimal(28,8),0) AS [AddCost11],
Convert(Decimal(28,8),0) AS [AddCost12],
Convert(Decimal(28,8),0) AS [AddCost13],
Convert(Decimal(28,8),0) AS [AddCost14],
Convert(Decimal(28,8),0) AS [AddCost15], 0 AS IsPriceID
'

SET @sSQL03 = '
INTO #OP1302 
FROM AT1302 WITH (NOLOCK)
LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = ''' + @PriceListID + '''
LEFT JOIN (
	SELECT AV1004.CurrencyID,AV1004.DivisionID, AV1004.Operator, 
	COALESCE(AT1012.ExchangeRate, AV1004.ExchangeRate) AS ExchangeRate
	FROM AV1004 
	LEFT JOIN ( 
				SELECT Top 1 DivisionID , CurrencyID, ExchangeRate, ExchangeDate
				FROM AT1012  WITH (NOLOCK)
				WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),@VoucherDate,101) + ''') >= 0
				ORDER BY ExchangeDate DESC
				)AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
	) AV1004 ON AV1004.CurrencyID = ' + CASE WHEN @CurrencyID = @BaseCurrencyID THEN 'ISNULL(OT1301.CurrencyID, ''' + @BaseCurrencyID + ''')' 
										ELSE '''' + @BaseCurrencyID + '''' END + ' 
LEFT JOIN OT0117 WITH (NOLOCK) ON OT0117.InventoryID = AT1302.InventoryID AND OT0117.ID = ''' + @PriceListID + '''

WHERE 1 = 0
AND AT1302.DivisionID IN (''@@@'', '''+@DivisionID+''')
--IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N''[dbo].[OV1302]'') AND name = N''OV1302_Index1'')
--DROP INDEX [OV1302_Index1] ON [dbo].[OV1302] WITH ( ONLINE = OFF )

--CREATE NONCLUSTERED INDEX [AT9000_Index1] ON [dbo].[OV1302] 
--(
--	[DivisionID] ASC,
--	[InventoryID] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

'


--Truong hop khong QL So luong va gia ban
IF @IsPriceControl = 0 AND @IsQuantityControl = 0
BEGIN

    SET @sSQL = '	
	INSERT INTO #OP1302
	SELECT 
	AT1302.DivisionID,
	AT1302.InventoryID,
	AT1302.InventoryName,
	AT1302.Specification,
	AT1302.UnitID,
	AT1304.UnitName,
	AT1302.InventoryTypeID,
	AT1302.IsStocked,
	AT1302.VATGroupID,
	AT1302.VATPercent,
	ISNULL((CASE WHEN AV1004.Operator = 0 THEN AT1302.SalePrice01 * AV1004.ExchangeRate 
				 ELSE AT1302.SalePrice01 / AV1004.ExchangeRate END), 0) AS SalePrice,
	CAST(0 AS DECIMAL(28,8)) AS UnitPrice,
	CAST(0 AS DECIMAL(28,8)) AS MinPrice , 
	CAST(0 AS DECIMAL(28,8)) AS MaxPrice,
	CAST(0 AS DECIMAL(28,8)) AS MinQuantity, 
	CAST(0 AS DECIMAL(28,8)) AS MaxQuantity,
	0 AS TypePriceControl,
	0 AS TypeQuantityControl,
	ISNULL(AT1302.SalePrice01, 0) As SalePrice01,
	ISNULL(AT1302.SalePrice02, 0) As SalePrice02,
	ISNULL(AT1302.SalePrice03, 0) As SalePrice03,
	ISNULL(AT1302.SalePrice04, 0) As SalePrice04,
	ISNULL(AT1302.SalePrice05, 0) As SalePrice05,
	CAST(NULL AS NVARCHAR(250)) AS Notes,
	CAST(NULL AS NVARCHAR(250)) AS Notes01,
	CAST(NULL AS NVARCHAR(250)) AS Notes02,
	AT1302.Barcode,
	'
	SET @sSQL1 = '
	CAST(0 AS DECIMAL(28,8)) AS DiscountPercent,
	CAST(0 AS DECIMAL(28,8)) AS DiscountAmount,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent01,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount01,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent02,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount02,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent03,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount03,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent04,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount04,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent05,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount05,
	ISNULL(OT0117.FromQuantity1, 0) As FromQuantity1, ISNULL(OT0117.ToQuantity1, 0) As ToQuantity1, ISNULL(OT0117.Price1, 0) As Price1,ISNULL(OT0117.DiscountAmount1, 0) As DiscountAmount1,
	ISNULL(OT0117.FromQuantity2, 0) As FromQuantity2, ISNULL(OT0117.ToQuantity2, 0) As ToQuantity2, ISNULL(OT0117.Price2, 0) As Price2,ISNULL(OT0117.DiscountAmount2, 0) As DiscountAmount2,
	ISNULL(OT0117.FromQuantity3, 0) As FromQuantity3, ISNULL(OT0117.ToQuantity3, 0) As ToQuantity3, ISNULL(OT0117.Price3, 0) As Price3,ISNULL(OT0117.DiscountAmount3, 0) As DiscountAmount3,
	ISNULL(OT0117.FromQuantity4, 0) As FromQuantity4, ISNULL(OT0117.ToQuantity4, 0) As ToQuantity4, ISNULL(OT0117.Price4, 0) As Price4,ISNULL(OT0117.DiscountAmount4, 0) As DiscountAmount4,
	ISNULL(OT0117.FromQuantity5, 0) As FromQuantity5, ISNULL(OT0117.ToQuantity5, 0) As ToQuantity5, ISNULL(OT0117.Price5, 0) As Price5,ISNULL(OT0117.DiscountAmount5, 0) As DiscountAmount5,
	ISNULL(OT0117.FromQuantity6, 0) As FromQuantity6, ISNULL(OT0117.ToQuantity6, 0) As ToQuantity6, ISNULL(OT0117.Price6, 0) As Price6,ISNULL(OT0117.DiscountAmount6, 0) As DiscountAmount6,
	ISNULL(OT0117.FromQuantity7, 0) As FromQuantity7, ISNULL(OT0117.ToQuantity7, 0) As ToQuantity7, ISNULL(OT0117.Price7, 0) As Price7,ISNULL(OT0117.DiscountAmount7, 0) As DiscountAmount7,
	ISNULL(OT0117.FromQuantity8, 0) As FromQuantity8, ISNULL(OT0117.ToQuantity8, 0) As ToQuantity8, ISNULL(OT0117.Price8, 0) As Price8,ISNULL(OT0117.DiscountAmount8, 0) As DiscountAmount8,
	ISNULL(OT0117.FromQuantity9, 0) As FromQuantity9, ISNULL(OT0117.ToQuantity9, 0) As ToQuantity9, ISNULL(OT0117.Price9, 0) As Price9,ISNULL(OT0117.DiscountAmount9, 0) As DiscountAmount9,
	ISNULL(OT0117.FromQuantity10, 0) As FromQuantity10,ISNULL(OT0117.ToQuantity10, 0) As ToQuantity10,ISNULL(OT0117.Price10, 0) As Price10,ISNULL(OT0117.DiscountAmount10, 0) As DiscountAmount10,
	ISNULL(OT0117.Price, 0) AS OT0117Price,
	ISNULL(OT0117.Discount, 0) AS OT0117Discount,
	CAST(NULL AS NVARCHAR(250)) AS O01ID,
	 0 TrayPrice, 0 DecreaseTrayPrice,NULL Qtyfrom,NULL QtyTo,
	OT1301.IsPlanPrice,
	AT1302.RecievedPrice, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.AccountID, 
	AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate,isnull(AT1302.IsDiscount,0) as IsDiscount ,AT1302.SalesAccountID,
	AT1302.PurchaseAccountID, AT1302.PrimeCostAccountID, AT1302.MethodID,AT1302.DeliveryPrice,
	AT1302.ETaxID, 
	AT1302.ETaxConvertedUnit, 
	AT1302.NRTClassifyID, AT1302.SETID,
	Convert(Decimal(28,8),0) AS [AddCost01],
	Convert(Decimal(28,8),0) AS [AddCost02],
	Convert(Decimal(28,8),0) AS [AddCost03],
	Convert(Decimal(28,8),0) AS [AddCost04],
	Convert(Decimal(28,8),0) AS [AddCost05],
	Convert(Decimal(28,8),0) AS [AddCost06],
	Convert(Decimal(28,8),0) AS [AddCost07],
	Convert(Decimal(28,8),0) AS [AddCost08],
	Convert(Decimal(28,8),0) AS [AddCost09],
	Convert(Decimal(28,8),0) AS [AddCost10],
	Convert(Decimal(28,8),0) AS [AddCost11],
	Convert(Decimal(28,8),0) AS [AddCost12],
	Convert(Decimal(28,8),0) AS [AddCost13],
	Convert(Decimal(28,8),0) AS [AddCost14],
	Convert(Decimal(28,8),0) AS [AddCost15], 0 AS IsPriceID
	'

			SET @sSQL2 = '	
	FROM AT1302 WITH (NOLOCK)
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID 
	LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = ''' + @PriceListID + ''' 
	LEFT JOIN (
				SELECT AV1004.CurrencyID,AV1004.DivisionID, AV1004.Operator, 
				COALESCE(AT1012.ExchangeRate, AV1004.ExchangeRate) AS ExchangeRate
				FROM AV1004 
				LEFT JOIN ( 
							SELECT Top 1 DivisionID , CurrencyID, ExchangeRate, ExchangeDate
							FROM AT1012  WITH (NOLOCK)
							WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),@VoucherDate,101) + ''') >= 0
							ORDER BY ExchangeDate DESC
						  )AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
			  ) AV1004 ON AV1004.CurrencyID = ' + CASE WHEN @CurrencyID = @BaseCurrencyID THEN 'ISNULL(OT1301.CurrencyID, ''' + @BaseCurrencyID + ''')' 
													ELSE '''' + @BaseCurrencyID + '''' END + ' 
	LEFT JOIN OT0117 WITH (NOLOCK) ON OT0117.InventoryID = AT1302.InventoryID AND OT0117.ID = ''' + @PriceListID + '''

	WHERE AT1302.Disabled = 0
	AND AT1302.DivisionID IN (''@@@'', '''+@DivisionID+''')
	'
END
ELSE 
IF @IsPriceControl = 1 AND @IsQuantityControl = 1
BEGIN

    IF @PriceListID = '' -- Nếu không chọn bảng giá, sẽ lấy 1 bảng giá thỏa điều kiện đầu tiên
    BEGIN
            IF ISNULL(@ObjectID, '') = ''
			BEGIN              
			    SELECT TOP 1 @ID_Price = ISNULL(ID, '')
                FROM OT1301 WITH (NOLOCK)
                WHERE @VoucherDate BETWEEN FromDate AND DATEADD(dd, 1, ISNULL(ToDate, CAST('12/30/9999' AS DATETIME)))
                AND OID = '%' AND DivisionID = @DivisionID AND [Disabled] = 0
			END
            ELSE
			BEGIN		
                SELECT TOP 1 
                @ID_Price = ISNULL(ID, '')
                FROM OT1301 WITH (NOLOCK)
                WHERE @VoucherDate BETWEEN FromDate AND DATEADD(dd, 1, ISNULL(ToDate, CAST('12/30/9999' AS DATETIME)))
                AND (
                    SELECT TOP 1 
                        CASE WHEN @OTypeID = 'O01ID' THEN ISNULL(O01ID, '%')
                                WHEN @OTypeID = 'O02ID' THEN ISNULL(O02ID, '%')
                                WHEN @OTypeID = 'O03ID' THEN ISNULL(O03ID, '%')
                                WHEN @OTypeID = 'O04ID' THEN ISNULL(O04ID, '%')
                        ELSE ISNULL(O05ID, '%')
                        END AS ObjectTypeID
                    FROM AT1202 WITH (NOLOCK)
                    WHERE ObjectID LIKE ISNULL(@ObjectID, '') AND [Disabled] = 0 AND DivisionID IN ( @DivisionID, '@@@')
                    ) LIKE OID AND DivisionID = @DivisionID AND [Disabled] = 0
                ORDER BY ID
			END
	END -- @PriceListID <> ''
	ELSE
        SET @ID_Price = @PriceListID

        SET @ID_Quantity = ISNULL(( 
                                    SELECT TOP 1 ID
                                    FROM OT1303 WITH (NOLOCK)
                                    WHERE @VoucherDate BETWEEN FromDate AND CASE WHEN ToDate = '01/01/1900' THEN '12/30/9999' ELSE ToDate END
                                    AND DivisionID = @DivisionID AND [Disabled] = 0), 
                                 '') 
	SET @sSQL = 
	'	
	INSERT INTO #OP1302
	SELECT 
	AT1302.DivisionID,
	AT1302.InventoryID, 
	AT1302.InventoryName,
	AT1302.Specification,
	ISNULL(OT1302.UnitID, AT1302.UnitID) AS UnitID, 
	AT1304.UnitName, 
	AT1302.InventoryTypeID, 
	AT1302.IsStocked,
	AT1302.VATGroupID,
	AT1302.VATPercent,
	ISNULL((CASE WHEN AV1004.Operator = 0 
			THEN ISNULL((CASE WHEN ''' + LTRIM(@IsConvertedUnit) + ''' = ''0'' 
							THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
							ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), AT1302.SalePrice01)* ISNULL(AV1004.ExchangeRate, 1) 
			ELSE ISNULL((CASE WHEN ''' + LTRIM(@IsConvertedUnit) + ''' = ''0'' 
							THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
							ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), AT1302.SalePrice01)/ ISNULL(AV1004.ExchangeRate, 1) END),0) 
	AS SalePrice,
	CASE WHEN AV1004.Operator = 0 
		THEN OT1302.UnitPrice * AV1004.ExchangeRate 
		ELSE OT1302.UnitPrice / AV1004.ExchangeRate 
	END AS UnitPrice,
	ISNULL(OT1302.MinPrice, 0) As MinPrice, 
	ISNULL(OT1302.MaxPrice, 0) As MaxPrice,
	ISNULL(OT1304.MinQuantity, 0) As MinQuantity, 
	ISNULL(OT1304.MaxQuantity, 0) As MaxQuantity,
	CASE WHEN ISNULL(OT1302.MaxPrice, 0) <> 0 AND ISNULL(OT1302.MinPrice, 0) <> 0 THEN 3
			WHEN ISNULL(OT1302.MaxPrice, 0) <> 0 AND ISNULL(OT1302.MinPrice, 0) = 0 THEN 2
			WHEN ISNULL(OT1302.MaxPrice, 0) = 0 AND ISNULL(OT1302.MinPrice, 0) <> 0 THEN 1 
			ELSE 0 
	END AS TypePriceControl,
	CASE WHEN ISNULL(OT1304.MaxQuantity, 0) <> 0 AND ISNULL(OT1304.MinQuantity, 0) <> 0 THEN 3
			WHEN ISNULL(OT1304.MaxQuantity, 0) <> 0 AND ISNULL(OT1304.MinQuantity, 0) = 0 THEN 2
			WHEN ISNULL(OT1304.MaxQuantity, 0) = 0 AND ISNULL(OT1304.MinQuantity, 0) <> 0 THEN 1 
			ELSE 0 
	END AS TypeQuantityControl,
	ISNULL(AT1302.SalePrice01, 0) As SalePrice01,
	ISNULL(AT1302.SalePrice02, 0) As SalePrice02,
	ISNULL(AT1302.SalePrice03, 0) As SalePrice03,
	ISNULL(AT1302.SalePrice04, 0) As SalePrice04,
	ISNULL(AT1302.SalePrice05, 0) As SalePrice05,
	ISNULL(OT1302.Notes, '''') AS Notes,
	ISNULL(OT1302.Notes01, '''') AS Notes01,
	ISNULL(OT1302.Notes02, '''') AS Notes02,
	AT1302.Barcode,
	'
	SET @sSQL1 = '
	ISNULL(DiscountPercent, 0) AS DiscountPercent,
	ISNULL(DiscountAmount, 0) AS DiscountAmount,
	ISNULL(SaleOffPercent01, 0) AS SaleOffPercent01,
	ISNULL(SaleOffAmount01, 0) AS SaleOffAmount01,
	ISNULL(SaleOffPercent02, 0) AS SaleOffPercent02,
	ISNULL(SaleOffAmount02, 0) AS SaleOffAmount02,
	ISNULL(SaleOffPercent03, 0) AS SaleOffPercent03,
	ISNULL(SaleOffAmount03, 0) AS SaleOffAmount03,
	ISNULL(SaleOffPercent04, 0) AS SaleOffPercent04,
	ISNULL(SaleOffAmount04, 0) AS SaleOffAmount04,
	ISNULL(SaleOffPercent05, 0) AS SaleOffPercent05,
	ISNULL(SaleOffAmount05, 0) AS SaleOffAmount05,
	ISNULL(OT0117.FromQuantity1, 0) As FromQuantity1, ISNULL(OT0117.ToQuantity1, 0) As ToQuantity1, ISNULL(OT0117.Price1, 0) As Price1,ISNULL(OT0117.DiscountAmount1, 0) As DiscountAmount1,
	ISNULL(OT0117.FromQuantity2, 0) As FromQuantity2, ISNULL(OT0117.ToQuantity2, 0) As ToQuantity2, ISNULL(OT0117.Price2, 0) As Price2,ISNULL(OT0117.DiscountAmount2, 0) As DiscountAmount2,
	ISNULL(OT0117.FromQuantity3, 0) As FromQuantity3, ISNULL(OT0117.ToQuantity3, 0) As ToQuantity3, ISNULL(OT0117.Price3, 0) As Price3,ISNULL(OT0117.DiscountAmount3, 0) As DiscountAmount3,
	ISNULL(OT0117.FromQuantity4, 0) As FromQuantity4, ISNULL(OT0117.ToQuantity4, 0) As ToQuantity4, ISNULL(OT0117.Price4, 0) As Price4,ISNULL(OT0117.DiscountAmount4, 0) As DiscountAmount4,
	ISNULL(OT0117.FromQuantity5, 0) As FromQuantity5, ISNULL(OT0117.ToQuantity5, 0) As ToQuantity5, ISNULL(OT0117.Price5, 0) As Price5,ISNULL(OT0117.DiscountAmount5, 0) As DiscountAmount5,
	ISNULL(OT0117.FromQuantity6, 0) As FromQuantity6, ISNULL(OT0117.ToQuantity6, 0) As ToQuantity6, ISNULL(OT0117.Price6, 0) As Price6,ISNULL(OT0117.DiscountAmount6, 0) As DiscountAmount6,
	ISNULL(OT0117.FromQuantity7, 0) As FromQuantity7, ISNULL(OT0117.ToQuantity7, 0) As ToQuantity7, ISNULL(OT0117.Price7, 0) As Price7,ISNULL(OT0117.DiscountAmount7, 0) As DiscountAmount7,
	ISNULL(OT0117.FromQuantity8, 0) As FromQuantity8, ISNULL(OT0117.ToQuantity8, 0) As ToQuantity8, ISNULL(OT0117.Price8, 0) As Price8,ISNULL(OT0117.DiscountAmount8, 0) As DiscountAmount8,
	ISNULL(OT0117.FromQuantity9, 0) As FromQuantity9, ISNULL(OT0117.ToQuantity9, 0) As ToQuantity9, ISNULL(OT0117.Price9, 0) As Price9,ISNULL(OT0117.DiscountAmount9, 0) As DiscountAmount9,
	ISNULL(OT0117.FromQuantity10, 0) As FromQuantity10,ISNULL(OT0117.ToQuantity10, 0) As ToQuantity10,ISNULL(OT0117.Price10, 0) As Price10,ISNULL(OT0117.DiscountAmount10, 0) As DiscountAmount10,
	ISNULL(OT0117.Price, 0) AS OT0117Price,
	ISNULL(OT0117.Discount, 0) AS OT0117Discount,
	AT1202.O01ID,
	ISNULL(OT1302.TrayPrice,0) [TrayPrice] , ISNULL(OT1302.DecreaseTrayPrice,0) [DecreaseTrayPrice],OT1312.Qtyfrom,OT1312.QtyTo,
	OT1301.IsPlanPrice,
	AT1302.RecievedPrice, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.AccountID, 
	AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate,isnull(AT1302.IsDiscount,0) as IsDiscount ,AT1302.SalesAccountID,
	AT1302.PurchaseAccountID, AT1302.PrimeCostAccountID, AT1302.MethodID,AT1302.DeliveryPrice,
	AT1302.ETaxID, 
	AT1302.ETaxConvertedUnit, 
	AT1302.NRTClassifyID, AT1302.SETID,	
	OT1302.[AddCost01],
	OT1302.[AddCost02],
	OT1302.[AddCost03],
	OT1302.[AddCost04],
	OT1302.[AddCost05],
	OT1302.[AddCost06],
	OT1302.[AddCost07],
	OT1302.[AddCost08],
	OT1302.[AddCost09],
	OT1302.[AddCost10],
	OT1302.[AddCost11],
	OT1302.[AddCost12],
	OT1302.[AddCost13],
	OT1302.[AddCost14],
	OT1302.[AddCost15], 
	CASE WHEN ISNULL(OT1302.InventoryID,'''') = '''' THEN 0 ELSE 1 END AS IsPriceID
	'
   SET @sSQL2 = '		
	FROM AT1302 WITH (NOLOCK)
	FULL JOIN OT1302 WITH (NOLOCK) ON AT1302.InventoryID = OT1302.InventoryID AND OT1302.ID = ''' + ISNULL(@ID_Price, '') + '''
	LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.ID = OT1302.DetailID AND OT1312.DivisionID = OT1302.DivisionID AND OT1312.PriceID = ''' + ISNULL(@ID_Price, '') + '''
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID  
	LEFT JOIN OT1304 WITH (NOLOCK) ON OT1304.ID = ''' + @ID_Quantity + ''' AND OT1304.InventoryID = AT1302.InventoryID 
	LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = ''' + @PriceListID + ''' 
	LEFT JOIN (
				SELECT AV1004.CurrencyID,AV1004.DivisionID, AV1004.Operator, 
					COALESCE(AT1012.ExchangeRate,AV1004.ExchangeRate) AS ExchangeRate
				FROM AV1004
				LEFT JOIN (
							SELECT Top 1 DivisionID , CurrencyID, ExchangeRate, ExchangeDate
							FROM AT1012  WITH (NOLOCK)
							WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),@VoucherDate,101) + ''') >= 0
							ORDER BY ExchangeDate DESC
						  )AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
			   ) AV1004 ON AV1004.CurrencyID = ' + CASE WHEN @CurrencyID = @BaseCurrencyID THEN 'ISNULL(OT1301.CurrencyID, ''' + @BaseCurrencyID + ''')' ELSE '''' + @BaseCurrencyID + '''' END + ' 
	LEFT JOIN OT0117 WITH (NOLOCK) ON OT0117.InventoryID = AT1302.InventoryID AND OT0117.ID = ''' + @PriceListID + '''
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = ''' + @ObjectID + '''

	WHERE AT1302.Disabled = 0
	AND AT1302.DivisionID IN (''@@@'', '''+@DivisionID+''')
	AND ISNULL(OT1302.[S01ID],'''') = '''+ISNULL(@S01ID,'')+'''
	AND ISNULL(OT1302.[S02ID],'''') = '''+ISNULL(@S02ID,'')+'''
	AND ISNULL(OT1302.[S03ID],'''') = '''+ISNULL(@S03ID,'')+'''
	AND ISNULL(OT1302.[S04ID],'''') = '''+ISNULL(@S04ID,'')+'''
	AND ISNULL(OT1302.[S05ID],'''') = '''+ISNULL(@S05ID,'')+'''
	AND ISNULL(OT1302.[S06ID],'''') = '''+ISNULL(@S06ID,'')+'''
	AND ISNULL(OT1302.[S07ID],'''') = '''+ISNULL(@S07ID,'')+'''
	AND ISNULL(OT1302.[S08ID],'''') = '''+ISNULL(@S08ID,'')+'''
	AND ISNULL(OT1302.[S09ID],'''') = '''+ISNULL(@S09ID,'')+'''
	AND ISNULL(OT1302.[S10ID],'''') = '''+ISNULL(@S10ID,'')+'''
	AND ISNULL(OT1302.[S11ID],'''') = '''+ISNULL(@S11ID,'')+'''
	AND ISNULL(OT1302.[S12ID],'''') = '''+ISNULL(@S12ID,'')+'''
	AND ISNULL(OT1302.[S13ID],'''') = '''+ISNULL(@S13ID,'')+'''
	AND ISNULL(OT1302.[S14ID],'''') = '''+ISNULL(@S14ID,'')+'''
	AND ISNULL(OT1302.[S15ID],'''') = '''+ISNULL(@S15ID,'')+'''
	AND ISNULL(OT1302.[S16ID],'''') = '''+ISNULL(@S16ID,'')+'''
	AND ISNULL(OT1302.[S17ID],'''') = '''+ISNULL(@S17ID,'')+'''
	AND ISNULL(OT1302.[S18ID],'''') = '''+ISNULL(@S18ID,'')+'''
	AND ISNULL(OT1302.[S19ID],'''') = '''+ISNULL(@S19ID,'')+'''
	AND ISNULL(OT1302.[S20ID],'''') = '''+ISNULL(@S20ID,'')+'''
	'	
	SET @sSQL2 = @sSQL2+ '
		
		UPDATE #OP1302
		SET		SalePrice =  SalePrice 
							+ SalePrice*Isnull([AddCost01],0)/100 
							+ SalePrice* Isnull([AddCost02],0)/100 
							+ SalePrice*Isnull([AddCost03],0)/100 
							+ SalePrice*Isnull([AddCost04],0)/100 
							+ SalePrice*Isnull([AddCost05],0)/100
							+ SalePrice*Isnull([AddCost06],0)/100 
							+ SalePrice*Isnull([AddCost07],0)/100 
							+ SalePrice*Isnull([AddCost08],0)/100 
							+ SalePrice*Isnull([AddCost09],0)/100 
							+ SalePrice*Isnull([AddCost10],0)/100
							+ SalePrice*Isnull([AddCost11],0)/100
							+ SalePrice*Isnull([AddCost12],0)/100
							+ SalePrice*Isnull([AddCost13],0)/100
							+ SalePrice*Isnull([AddCost14],0)/100
							+ SalePrice*Isnull([AddCost15],0)/100
		FROM #OP1302
		'
	
--	SET @sSQL3 = '
--	SELECT distinct OV1302.*,  AT34.UnitID as NRTUnitID, AT34.NRTClassifyName, AT34.TaxRate as NRTTaxRate,
--     	   At36.SETName, At36.UnitID as SETUnitID, At36.TaxRate as SETTaxRate, AT93.ETaxName, AT93.UnitID AS ETaxUnitID
--	FROM #OP1312_OT1302 OV1302
--	LEFT JOIN AT0134 AT34  WITH (NOLOCK) ON AT34.NRTClassifyID = OV1302.NRTClassifyID
--    LEFT JOIN AT0136 At36  WITH (NOLOCK) ON AT36.SETID = OV1302.SETID
--	LEFT JOIN AT0293 AT93 WITH (NOLOCK) ON AT93.ETaxID = OV1302.ETaxID
--	WHERE OV1302.DivisionID = '''+@DivisionID+'''
	
	
--	DROP TABLE #OP1312_OT1302
	
--'
	
END
ELSE IF @IsPriceControl = 1 AND @IsQuantityControl = 0
BEGIN
    IF @PriceListID = '' -- Nếu không chọn bảng giá, sẽ lấy 1 bảng giá thỏa điều kiện đầu tiên
        BEGIN 
            IF ISNULL(@ObjectID, '') = ''
                SELECT TOP 1 @ID_Price = ISNULL(ID, '')
                FROM OT1301 WITH (NOLOCK)
                WHERE @VoucherDate BETWEEN FromDate AND DATEADD(dd, 1, ISNULL(ToDate, CAST('12/30/9999' AS DATETIME)))
                AND OID = '%' AND DivisionID = @DivisionID
            ELSE
                SELECT TOP 1 
                @ID_Price = ISNULL(ID, '')
                FROM OT1301 WITH (NOLOCK)
                WHERE @VoucherDate BETWEEN FromDate AND DATEADD(dd, 1, ISNULL(ToDate, CAST('12/30/9999' AS DATETIME)))
                AND (
                        SELECT TOP 1 
                        CASE WHEN @OTypeID = 'O01ID' THEN ISNULL(O01ID, '%')
                        WHEN @OTypeID = 'O02ID' THEN ISNULL(O02ID, '%')
                        WHEN @OTypeID = 'O03ID' THEN ISNULL(O03ID, '%')
                        WHEN @OTypeID = 'O04ID' THEN ISNULL(O04ID, '%')
                        ELSE ISNULL(O05ID, '%')
                        END AS ObjectTypeID
                        FROM AT1202 WITH (NOLOCK)
                        WHERE ObjectID LIKE ISNULL(@ObjectID, '')
                        AND DivisionID IN ( @DivisionID, '@@@') AND [Disabled] = 0
                    ) LIKE OID
                AND DivisionID = @DivisionID AND [Disabled] = 0
                ORDER BY ID
        END
	ELSE 
		SET @ID_Price = @PriceListID

	SET @sSQL = '	
	INSERT INTO #OP1302
	SELECT distinct
	AT1302.DivisionID,
	AT1302.InventoryID,
	AT1302.InventoryName,
	AT1302.Specification,
	ISNULL(OT1302.UnitID,AT1302.UnitID) AS UnitID,
	AT1304.UnitName,
	AT1302.InventoryTypeID,
	AT1302.IsStocked,
	AT1302.VATGroupID,
	AT1302.VATPercent,
		ISNULL((CASE WHEN AV1004.Operator = 0 
				THEN ISNULL((CASE WHEN ''' + LTRIM(@IsConvertedUnit) + ''' = ''0'' 
								THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
								ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), AT1302.SalePrice01)*ISNULL(AV1004.ExchangeRate, 1)
				ELSE ISNULL((CASE WHEN ''' + LTRIM(@IsConvertedUnit) + ''' = ''0'' 
								THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
								ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), AT1302.SalePrice01)/ISNULL(AV1004.ExchangeRate, 1) END),0) 
		AS SalePrice,
	CASE WHEN AV1004.Operator = 0 THEN OT1302.UnitPrice*AV1004.ExchangeRate ELSE OT1302.UnitPrice/AV1004.ExchangeRate END AS UnitPrice,
	ISNULL(OT1302.MinPrice, 0) AS MinPrice,
	ISNULL(OT1302.MaxPrice, 0) AS MaxPrice,
	CAST(NULL AS DECIMAL(28, 8)) AS MinQuantity,
	CAST(NULL AS DECIMAL(28, 8)) AS MaxQuantity,
	CASE WHEN ISNULL(OT1302.MaxPrice, 0) <> 0 AND ISNULL(OT1302.MinPrice, 0) <> 0 THEN 3
		 WHEN ISNULL(OT1302.MaxPrice, 0) <> 0 AND ISNULL(OT1302.MinPrice, 0) = 0 THEN 2
		 WHEN ISNULL(OT1302.MaxPrice, 0) = 0 AND ISNULL(OT1302.MinPrice, 0) <> 0 THEN 1 
		 ELSE 0 
	END AS TypePriceControl, 
	0 AS TypeQuantityControl,
	ISNULL(AT1302.SalePrice01, 0) As SalePrice01,
	ISNULL(AT1302.SalePrice02, 0) As SalePrice02,
	ISNULL(AT1302.SalePrice03, 0) As SalePrice03,
	ISNULL(AT1302.SalePrice04, 0) As SalePrice04,
	ISNULL(AT1302.SalePrice05, 0) As SalePrice05,
	ISNULL(OT1302.Notes, '''') AS Notes,
	ISNULL(OT1302.Notes01, '''') AS Notes01,
	ISNULL(OT1302.Notes02, '''') AS Notes02,
	AT1302.Barcode,
	'
	SET @sSQL1 = '
	ISNULL(DiscountPercent, 0) AS DiscountPercent,
	ISNULL(DiscountAmount, 0) AS DiscountAmount,
	ISNULL(SaleOffPercent01, 0) AS SaleOffPercent01,
	ISNULL(SaleOffAmount01, 0) AS SaleOffAmount01,
	ISNULL(SaleOffPercent02, 0) AS SaleOffPercent02,
	ISNULL(SaleOffAmount02, 0) AS SaleOffAmount02,
	ISNULL(SaleOffPercent03, 0) AS SaleOffPercent03,
	ISNULL(SaleOffAmount03, 0) AS SaleOffAmount03,
	ISNULL(SaleOffPercent04, 0) AS SaleOffPercent04,
	ISNULL(SaleOffAmount04, 0) AS SaleOffAmount04,
	ISNULL(SaleOffPercent05, 0) AS SaleOffPercent05,
	ISNULL(SaleOffAmount05, 0) AS SaleOffAmount05,
	ISNULL(OT0117.FromQuantity1, 0) As FromQuantity1, ISNULL(OT0117.ToQuantity1, 0) As ToQuantity1, ISNULL(OT0117.Price1, 0) As Price1,ISNULL(OT0117.DiscountAmount1, 0) As DiscountAmount1,
	ISNULL(OT0117.FromQuantity2, 0) As FromQuantity2, ISNULL(OT0117.ToQuantity2, 0) As ToQuantity2, ISNULL(OT0117.Price2, 0) As Price2,ISNULL(OT0117.DiscountAmount2, 0) As DiscountAmount2,
	ISNULL(OT0117.FromQuantity3, 0) As FromQuantity3, ISNULL(OT0117.ToQuantity3, 0) As ToQuantity3, ISNULL(OT0117.Price3, 0) As Price3,ISNULL(OT0117.DiscountAmount3, 0) As DiscountAmount3,
	ISNULL(OT0117.FromQuantity4, 0) As FromQuantity4, ISNULL(OT0117.ToQuantity4, 0) As ToQuantity4, ISNULL(OT0117.Price4, 0) As Price4,ISNULL(OT0117.DiscountAmount4, 0) As DiscountAmount4,
	ISNULL(OT0117.FromQuantity5, 0) As FromQuantity5, ISNULL(OT0117.ToQuantity5, 0) As ToQuantity5, ISNULL(OT0117.Price5, 0) As Price5,ISNULL(OT0117.DiscountAmount5, 0) As DiscountAmount5,
	ISNULL(OT0117.FromQuantity6, 0) As FromQuantity6, ISNULL(OT0117.ToQuantity6, 0) As ToQuantity6, ISNULL(OT0117.Price6, 0) As Price6,ISNULL(OT0117.DiscountAmount6, 0) As DiscountAmount6,
	ISNULL(OT0117.FromQuantity7, 0) As FromQuantity7, ISNULL(OT0117.ToQuantity7, 0) As ToQuantity7, ISNULL(OT0117.Price7, 0) As Price7,ISNULL(OT0117.DiscountAmount7, 0) As DiscountAmount7,
	ISNULL(OT0117.FromQuantity8, 0) As FromQuantity8, ISNULL(OT0117.ToQuantity8, 0) As ToQuantity8, ISNULL(OT0117.Price8, 0) As Price8,ISNULL(OT0117.DiscountAmount8, 0) As DiscountAmount8,
	ISNULL(OT0117.FromQuantity9, 0) As FromQuantity9, ISNULL(OT0117.ToQuantity9, 0) As ToQuantity9, ISNULL(OT0117.Price9, 0) As Price9,ISNULL(OT0117.DiscountAmount9, 0) As DiscountAmount9,
	ISNULL(OT0117.FromQuantity10, 0) As FromQuantity10,ISNULL(OT0117.ToQuantity10, 0) As ToQuantity10,ISNULL(OT0117.Price10, 0) As Price10,ISNULL(OT0117.DiscountAmount10, 0) As DiscountAmount10,
	ISNULL(OT0117.Price, 0) AS OT0117Price,
	ISNULL(OT0117.Discount, 0) AS OT0117Discount,
	AT1202.O01ID,
	ISNULL(OT1302.TrayPrice,0) [TrayPrice] , ISNULL(OT1302.DecreaseTrayPrice,0) [DecreaseTrayPrice],OT1312.Qtyfrom,OT1312.QtyTo,
	OT1301.IsPlanPrice,
	AT1302.RecievedPrice, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.AccountID, 
	AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate,isnull(AT1302.IsDiscount,0) as IsDiscount ,AT1302.SalesAccountID,
	AT1302.PurchaseAccountID, AT1302.PrimeCostAccountID, AT1302.MethodID,AT1302.DeliveryPrice,
	AT1302.ETaxID,
	AT1302.ETaxConvertedUnit,
	AT1302.NRTClassifyID, AT1302.SETID,
	OT1302.[AddCost01],
	OT1302.[AddCost02],
	OT1302.[AddCost03],
	OT1302.[AddCost04],
	OT1302.[AddCost05],
	OT1302.[AddCost06],
	OT1302.[AddCost07],
	OT1302.[AddCost08],
	OT1302.[AddCost09],
	OT1302.[AddCost10],
	OT1302.[AddCost11],
	OT1302.[AddCost12],
	OT1302.[AddCost13],
	OT1302.[AddCost14],
	OT1302.[AddCost15], CASE WHEN ISNULL(OT1302.InventoryID,'''') = '''' THEN 0 ELSE 1 END AS IsPriceID
	'
			SET @sSQL2 = '		
	FROM AT1302 WITH (NOLOCK)
	FULL JOIN OT1302 WITH (NOLOCK) ON AT1302.InventoryID = OT1302.InventoryID AND OT1302.ID = ''' + ISNULL(@ID_Price, '') + '''
	LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.ID = OT1302.DetailID AND OT1312.DivisionID = OT1302.DivisionID AND OT1312.PriceID = ''' + ISNULL(@ID_Price, '') + '''
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID  
	LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = ''' + @PriceListID + ''' 
	LEFT JOIN (
				SELECT AV1004.CurrencyID,AV1004.DivisionID, AV1004.Operator,
					COALESCE(AT1012.ExchangeRate,AV1004.ExchangeRate) AS ExchangeRate
				FROM AV1004
				LEFT JOIN (
							SELECT Top 1 DivisionID , CurrencyID, ExchangeRate, ExchangeDate 
							FROM AT1012  WITH (NOLOCK)
							WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),@VoucherDate,101) + ''') >= 0
							ORDER BY ExchangeDate DESC
						  )AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
			  ) AV1004 ON AV1004.CurrencyID = ' + CASE WHEN @CurrencyID = @BaseCurrencyID THEN 'ISNULL(OT1301.CurrencyID, ''' + @BaseCurrencyID + ''')' ELSE '''' + @BaseCurrencyID + '''' END + ' 
	LEFT JOIN OT0117  WITH (NOLOCK) ON OT0117.InventoryID = AT1302.InventoryID AND OT0117.ID = ''' + @PriceListID + '''
	LEFT JOIN AT1202  WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = ''' + @ObjectID + '''

	WHERE AT1302.Disabled = 0
	AND AT1302.DivisionID IN (''@@@'', '''+@DivisionID+''')
	AND ISNULL(OT1302.[S01ID],'''') = '''+ISNULL(@S01ID,'')+'''
	AND ISNULL(OT1302.[S02ID],'''') = '''+ISNULL(@S02ID,'')+'''
	AND ISNULL(OT1302.[S03ID],'''') = '''+ISNULL(@S03ID,'')+'''
	AND ISNULL(OT1302.[S04ID],'''') = '''+ISNULL(@S04ID,'')+'''
	AND ISNULL(OT1302.[S05ID],'''') = '''+ISNULL(@S05ID,'')+'''
	AND ISNULL(OT1302.[S06ID],'''') = '''+ISNULL(@S06ID,'')+'''
	AND ISNULL(OT1302.[S07ID],'''') = '''+ISNULL(@S07ID,'')+'''
	AND ISNULL(OT1302.[S08ID],'''') = '''+ISNULL(@S08ID,'')+'''
	AND ISNULL(OT1302.[S09ID],'''') = '''+ISNULL(@S09ID,'')+'''
	AND ISNULL(OT1302.[S10ID],'''') = '''+ISNULL(@S10ID,'')+'''
	AND ISNULL(OT1302.[S11ID],'''') = '''+ISNULL(@S11ID,'')+'''
	AND ISNULL(OT1302.[S12ID],'''') = '''+ISNULL(@S12ID,'')+'''
	AND ISNULL(OT1302.[S13ID],'''') = '''+ISNULL(@S13ID,'')+'''
	AND ISNULL(OT1302.[S14ID],'''') = '''+ISNULL(@S14ID,'')+'''
	AND ISNULL(OT1302.[S15ID],'''') = '''+ISNULL(@S15ID,'')+'''
	AND ISNULL(OT1302.[S16ID],'''') = '''+ISNULL(@S16ID,'')+'''
	AND ISNULL(OT1302.[S17ID],'''') = '''+ISNULL(@S17ID,'')+'''
	AND ISNULL(OT1302.[S18ID],'''') = '''+ISNULL(@S18ID,'')+'''
	AND ISNULL(OT1302.[S19ID],'''') = '''+ISNULL(@S19ID,'')+'''
	AND ISNULL(OT1302.[S20ID],'''') = '''+ISNULL(@S20ID,'')+'''
	'	
	SET @sSQL2 = @sSQL2+ '
	--select * from #OP1312_OT1302
		UPDATE #OP1302
		SET		SalePrice =  SalePrice 
							+ SalePrice*Isnull([AddCost01],0)/100 
							+ SalePrice* Isnull([AddCost02],0)/100 
							+ SalePrice*Isnull([AddCost03],0)/100 
							+ SalePrice*Isnull([AddCost04],0)/100 
							+ SalePrice*Isnull([AddCost05],0)/100
							+ SalePrice*Isnull([AddCost06],0)/100 
							+ SalePrice*Isnull([AddCost07],0)/100 
							+ SalePrice*Isnull([AddCost08],0)/100 
							+ SalePrice*Isnull([AddCost09],0)/100 
							+ SalePrice*Isnull([AddCost10],0)/100
							+ SalePrice*Isnull([AddCost11],0)/100
							+ SalePrice*Isnull([AddCost12],0)/100
							+ SalePrice*Isnull([AddCost13],0)/100
							+ SalePrice*Isnull([AddCost14],0)/100
							+ SalePrice*Isnull([AddCost15],0)/100
		FROM #OP1302
		'	
--	SET @sSQL3 = '
--	SELECT OV1302.*,  AT34.UnitID as NRTUnitID, AT34.NRTClassifyName, AT34.TaxRate as NRTTaxRate,
--     	   At36.SETName, At36.UnitID as SETUnitID, At36.TaxRate as SETTaxRate, AT93.ETaxName, AT93.UnitID AS ETaxUnitID
--	FROM #OP1312_OT1302 OV1302
--	LEFT JOIN AT0134 AT34  WITH (NOLOCK) ON AT34.NRTClassifyID = OV1302.NRTClassifyID
--    LEFT JOIN AT0136 At36  WITH (NOLOCK) ON AT36.SETID = OV1302.SETID
--	LEFT JOIN AT0293 AT93 WITH (NOLOCK) ON AT93.ETaxID = OV1302.ETaxID
--	WHERE OV1302.DivisionID = '''+@DivisionID+'''
	
	
--	DROP TABLE #OP1312_OT1302
	
--'
END
ELSE
------------Quan ly so luong
BEGIN
	SET @ID_Quantity = ISNULL(( SELECT TOP 1 ID
	FROM OT1303 WITH (NOLOCK)
	WHERE @VoucherDate BETWEEN FromDate AND CASE WHEN ToDate = '01/01/1900' THEN '12/30/9999' ELSE ToDate END
	AND DivisionID = @DivisionID AND [Disabled] = 0), '')

	SET @sSQL = '	
	INSERT INTO #OP1302
	SELECT distinct
	AT1302.DivisionID,
	AT1302.InventoryID,
	AT1302.InventoryName,
	AT1302.Specification,
	AT1302.UnitID,
	AT1304.UnitName,
	AT1302.InventoryTypeID,
	AT1302.IsStocked,
	AT1302.VATGroupID,
	AT1302.VATPercent,
	ISNULL((CASE WHEN AV1004.Operator = 0 
	THEN AT1302.SalePrice01*AV1004.ExchangeRate 
	ELSE AT1302.SalePrice01/AV1004.ExchangeRate END),0) 
	AS SalePrice,
	CAST(NULL AS DECIMAL(28,8)) AS UnitPrice,
	CAST(NULL AS DECIMAL(28,8)) AS MinPrice,
	CAST(NULL AS DECIMAL(28,8)) AS MaxPrice,
	ISNULL(OT1304.MinQuantity, 0) AS MinQuantity,
	ISNULL(OT1304.MaxQuantity, 0) AS MaxQuantity,
	0 AS TypePriceControl,
	CASE WHEN ISNULL(OT1304.MaxQuantity, 0) <> 0 AND ISNULL(OT1304.MinQuantity, 0) <> 0 THEN 3
	WHEN ISNULL(OT1304.MaxQuantity, 0) <> 0 AND ISNULL(OT1304.MinQuantity, 0) = 0 THEN 2
	WHEN ISNULL(OT1304.MaxQuantity, 0) = 0 AND ISNULL(OT1304.MinQuantity, 0) <> 0 THEN 1 
	ELSE 0 
	END AS TypeQuantityControl,
	ISNULL(AT1302.SalePrice01, 0) As SalePrice01,
	ISNULL(AT1302.SalePrice02, 0) As SalePrice02,
	ISNULL(AT1302.SalePrice03, 0) As SalePrice03,
	ISNULL(AT1302.SalePrice04, 0) As SalePrice04,
	ISNULL(AT1302.SalePrice05, 0) As SalePrice05,
	CAST(NULL AS NVARCHAR(250)) AS Notes,
	CAST(NULL AS NVARCHAR(250)) AS Notes01,
	CAST(NULL AS NVARCHAR(250)) AS Notes02,
	AT1302.Barcode,
	'
	SET @sSQL1 = '
	CAST(0 AS DECIMAL(28,8)) AS DiscountPercent,
	CAST(0 AS DECIMAL(28,8)) AS DiscountAmount,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent01,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount01,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent02,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount02,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent03,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount03,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent04,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount04,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent05,
	CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount05,
	ISNULL(OT0117.FromQuantity1, 0) As FromQuantity1, ISNULL(OT0117.ToQuantity1, 0) As ToQuantity1, ISNULL(OT0117.Price1, 0) As Price1,ISNULL(OT0117.DiscountAmount1, 0) As DiscountAmount1,
	ISNULL(OT0117.FromQuantity2, 0) As FromQuantity2, ISNULL(OT0117.ToQuantity2, 0) As ToQuantity2, ISNULL(OT0117.Price2, 0) As Price2,ISNULL(OT0117.DiscountAmount2, 0) As DiscountAmount2,
	ISNULL(OT0117.FromQuantity3, 0) As FromQuantity3, ISNULL(OT0117.ToQuantity3, 0) As ToQuantity3, ISNULL(OT0117.Price3, 0) As Price3,ISNULL(OT0117.DiscountAmount3, 0) As DiscountAmount3,
	ISNULL(OT0117.FromQuantity4, 0) As FromQuantity4, ISNULL(OT0117.ToQuantity4, 0) As ToQuantity4, ISNULL(OT0117.Price4, 0) As Price4,ISNULL(OT0117.DiscountAmount4, 0) As DiscountAmount4,
	ISNULL(OT0117.FromQuantity5, 0) As FromQuantity5, ISNULL(OT0117.ToQuantity5, 0) As ToQuantity5, ISNULL(OT0117.Price5, 0) As Price5,ISNULL(OT0117.DiscountAmount5, 0) As DiscountAmount5,
	ISNULL(OT0117.FromQuantity6, 0) As FromQuantity6, ISNULL(OT0117.ToQuantity6, 0) As ToQuantity6, ISNULL(OT0117.Price6, 0) As Price6,ISNULL(OT0117.DiscountAmount6, 0) As DiscountAmount6,
	ISNULL(OT0117.FromQuantity7, 0) As FromQuantity7, ISNULL(OT0117.ToQuantity7, 0) As ToQuantity7, ISNULL(OT0117.Price7, 0) As Price7,ISNULL(OT0117.DiscountAmount7, 0) As DiscountAmount7,
	ISNULL(OT0117.FromQuantity8, 0) As FromQuantity8, ISNULL(OT0117.ToQuantity8, 0) As ToQuantity8, ISNULL(OT0117.Price8, 0) As Price8,ISNULL(OT0117.DiscountAmount8, 0) As DiscountAmount8,
	ISNULL(OT0117.FromQuantity9, 0) As FromQuantity9, ISNULL(OT0117.ToQuantity9, 0) As ToQuantity9, ISNULL(OT0117.Price9, 0) As Price9,ISNULL(OT0117.DiscountAmount9, 0) As DiscountAmount9,
	ISNULL(OT0117.FromQuantity10, 0) As FromQuantity10,ISNULL(OT0117.ToQuantity10, 0) As ToQuantity10,ISNULL(OT0117.Price10, 0) As Price10,ISNULL(OT0117.DiscountAmount10, 0) As DiscountAmount10,
	ISNULL(OT0117.Price, 0) AS OT0117Price,
	ISNULL(OT0117.Discount, 0) AS OT0117Discount,
	CAST(NULL AS NVARCHAR(250)) AS O01ID,
	0 TrayPrice , 0 DecreaseTrayPrice,NULL Qtyfrom,NULL QtyTo,
	OT1301.IsPlanPrice,
	AT1302.RecievedPrice, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.AccountID, 
	AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate,isnull(AT1302.IsDiscount,0) as IsDiscount ,AT1302.SalesAccountID,
	AT1302.PurchaseAccountID, AT1302.PrimeCostAccountID, AT1302.MethodID,AT1302.DeliveryPrice,
	AT1302.ETaxID, 
	AT1302.ETaxConvertedUnit, 
	AT1302.NRTClassifyID, AT1302.SETID, 0 AS IsPriceID
	'
	SET @sSQL2 = ' 
	FROM AT1302 WITH (NOLOCK) 
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
	LEFT JOIN OT1304 WITH (NOLOCK) ON OT1304.ID = ''' + @ID_Quantity + ''' AND OT1304.InventoryID = AT1302.InventoryID 
	LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = ''' + @PriceListID + ''' 
	LEFT JOIN (
		SELECT AV1004.CurrencyID,AV1004.DivisionID, AV1004.Operator,
			COALESCE(AT1012.ExchangeRate,AV1004.ExchangeRate) AS ExchangeRate
		FROM AV1004
		LEFT JOIN (
					SELECT Top 1 DivisionID , CurrencyID, ExchangeRate, ExchangeDate 
					FROM AT1012  WITH (NOLOCK)
					WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),@VoucherDate,101) + ''') >= 0
					ORDER BY ExchangeDate DESC
					)AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
		) AV1004 ON AV1004.CurrencyID = ' + CASE WHEN @CurrencyID = @BaseCurrencyID THEN 'ISNULL(OT1301.CurrencyID, ''' + @BaseCurrencyID + ''')' ELSE '''' + @BaseCurrencyID + '''' END + ' 
	LEFT JOIN OT0117 WITH (NOLOCK) ON OT0117.InventoryID = AT1302.InventoryID AND OT0117.ID = ''' + @PriceListID + '''

	WHERE AT1302.Disabled = 0
	AND AT1302.DivisionID IN (''@@@'', '''+@DivisionID+''')
	'
END 	
SET @sSQL3 = '
	SELECT OV1302.*,  AT34.UnitID as NRTUnitID, AT34.NRTClassifyName, AT34.TaxRate as NRTTaxRate,
     	   At36.SETName, At36.UnitID as SETUnitID, At36.TaxRate as SETTaxRate, AT93.ETaxName, AT93.UnitID AS ETaxUnitID
	FROM #OP1302 OV1302
	LEFT JOIN AT0134 AT34  WITH (NOLOCK) ON AT34.NRTClassifyID = OV1302.NRTClassifyID
    LEFT JOIN AT0136 At36  WITH (NOLOCK) ON AT36.SETID = OV1302.SETID
	LEFT JOIN AT0293 AT93 WITH (NOLOCK) ON AT93.ETaxID = OV1302.ETaxID
	WHERE OV1302.DivisionID = '''+@DivisionID+'''
	
	
	----DROP TABLE OV1302
	
'

--PRINT @sSQL01
--PRINT @sSQL02
--PRINT @sSQL03
--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
--IF NOT EXISTS(SELECT TOP 1 1 FROM SysObjects WHERE XType = 'V' AND NAME = 'OV1302')
--    EXEC ('CREATE VIEW OV1302 -- Tao boi OP1302 
--        AS ' + @sSQL + @sSQL1)
--ELSE
--    EXEC ('ALTER VIEW OV1302 -- Tao boi OP1302 
--        AS ' + @sSQL + @sSQL1)

--EXEC (@sSQL+@sSQL1+@sSQL2)

/*
SET @sSQL3 = '
	SELECT OV1302.*,  AT34.UnitID as NRTUnitID, AT34.NRTClassifyName, AT34.TaxRate as NRTTaxRate,
     	   At36.SETName, At36.UnitID as SETUnitID, At36.TaxRate as SETTaxRate, AT93.ETaxName, AT93.UnitID AS ETaxUnitID
	FROM OV1302
	LEFT JOIN AT0134 AT34  WITH (NOLOCK) ON AT34.NRTClassifyID = OV1302.NRTClassifyID
    LEFT JOIN AT0136 At36  WITH (NOLOCK) ON AT36.SETID = OV1302.SETID
	LEFT JOIN AT0293 AT93 WITH (NOLOCK) ON AT93.ETaxID = OV1302.ETaxID
	WHERE OV1302.DivisionID = '''+@DivisionID+'''
	
	
	----DROP TABLE OV1302
	
'
*/--------
EXEC (@sSQL01+@sSQL02 + @sSQL03 + @sSQL+@sSQL1+@sSQL2 + @sSQL3)
--PRINT @sSQL3



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
