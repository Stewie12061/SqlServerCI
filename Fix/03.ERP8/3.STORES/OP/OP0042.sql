IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0042]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0042]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Detail cho màn hình OF0138 - kế thừa đơn hàng mua [Customize ABA]
-- <History>
---- Create on 20/04/2015 by Lê Thị Hạnh 
---- Modified on ... by 
---- Modified by Tiểu Mai on 18/11/2015: Bổ sung trường hợp có quản lý mặt hàng theo quy cách.
---- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hải Long on 25/08/2016: Bổ sung thêm trường cho ABA
---- Modified by Tiểu Mai on 23/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Trà Giang on 18/06/2019: Bổ sung tên quy cách (Customize NNP = 104) 
---- Modified by Kiều Nga on 27/05/2020 Lấy thêm trường UnitName
---- Modified by Kiều Nga on 07/07/2020 Lấy thêm mã phân tích
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Anh Đô on 09/03/2023: Cập nhật xử lí lấy dữ liệu cột ConvertedQuantity và ConvertedSalePrice
---- Modified by Nhật Thanh on 25/04/2023: Bổ sung load số lô
---- Modified by Anh Đô on 16/08/2023: Bổ sung xử lí cho màn hình QCF2001
---- Modified by Hồng Thắm on 05/10/2023: Fix lỗi load thiếu dữ liệu cho màn hình POF2101(customize PANGLOBE)
-- <Example>
/* 
OP0042 @DivisionID ='VG', @VoucherIDList = 'CL/01/15/024'',''DD/01/15/005'',''CT/01/15/003'',''DK/01/15/006'',''KH/01/15/006', @SOVoucherID = 'TV20140000000001'
 */
CREATE PROCEDURE [dbo].[OP0042] 	
	@DivisionID NVARCHAR(50),
	@VoucherIDList NVARCHAR(MAX),
	@SOVoucherID NVARCHAR(50), -- Truyền vào khi Edit
	@Mode INT = 0,
	@PageNumber INT = 1,
	@PageSize INT = 25,
	@ScreenID VARCHAR(50) = ''
AS
DECLARE @sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sSQL4 NVARCHAR(MAX),
		@sSQL5 NVARCHAR(MAX),
		@sSQL6 NVARCHAR(MAX),
		@Parameters NVARCHAR(MAX) = '',
		@TotalRow VARCHAR(50),
		@CustomerIndex INT =(select top 1 Customername from Customerindex) ,
		@having varchar(max) = ''

IF @ScreenID = 'QCF2001'
BEGIN
	-- Trường hợp kế thừa từ màn hình Phiếu quản lý chất lượng đầu ca
	SET @sSQL1 = N'
		SELECT ROW_NUMBER() OVER (ORDER BY OT32.Orders ) AS RowNum
			  , COUNT(*) OVER () AS TotalRow,CONVERT(TINYINT,0) AS IsCheck
			  , ''OT3001'' AS TableID
			  , OT31.POrderID
			  , OT32.TransactionID
			  , ISNULL(OT31.ExchangeRate, 0) AS ExchangeRate
			  , OT31.VoucherNo
			  , ISNULL(OT32.Orders, 0) AS Orders
			  , OT32.InventoryID
			  , AT12.InventoryName
			  , OT32.UnitID
			  , AT1304.UnitName
			  , ISNULL(OT32.OrderQuantity, 0) AS ConvertedQuantity
			  , ISNULL(OT32.PurchasePrice, 0) AS ConvertedSalePrice
			  , SUM(ISNULL(Q01.QuantityInherit, 0)) AS QuantityInherit
			  , ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(Q01.QuantityInherit, 0)) AS RemainQuantity
			  , ISNULL(OT32.PurchasePrice, 0) AS PurchasePrice
			  , ISNULL(OT32.VATPercent, 0) AS VATPercent
			  , OT32.Ana01ID, OT32.Ana02ID, OT32.Ana03ID, OT32.Ana04ID, OT32.Notes
			  , OT32.Notes01, OT32.Notes02, OT32.Ana05ID, OT32.Ana06ID, OT32.Ana07ID
			  , OT32.Ana08ID, OT32.Ana09ID, OT32.Ana10ID, OT32.Notes03, OT32.Notes04
			  , OT32.Notes05, OT32.Notes06, OT32.Notes07, OT32.Notes08, OT32.Notes09
			  , (ISNULL(OT32.OrderQuantity, 0) - SUM(ISNULL(Q01.QuantityInherit, 0))) * ISNULL(OT32.PurchasePrice, 0) AS OriginalAmount
			  , (ISNULL(OT32.OrderQuantity, 0) - SUM(ISNULL(Q01.QuantityInherit, 0))) * ISNULL(OT32.PurchasePrice, 0) * ISNULL(OT31.ExchangeRate, 0) AS ConvertedAmount
			  , (ISNULL(OT32.OrderQuantity, 0) - SUM(ISNULL(Q01.QuantityInherit, 0))) * ISNULL(OT32.PurchasePrice, 0) * ISNULL(OT32.VATPercent, 0) / 100 AS VATOriginalAmount
			  , (ISNULL(OT32.OrderQuantity, 0) - SUM(ISNULL(Q01.QuantityInherit, 0))) * ISNULL(OT32.PurchasePrice, 0) * ISNULL(OT31.ExchangeRate, 0) * ISNULL(OT32.VATPercent, 0) / 100 AS VATConvertedAmount
			  , ISNULL(AT14.ExchangeRateDecimal, 0) AS ExchangeRateDecimal
			  , OT31.ObjectID, OT31.[Description], OT31.CurrencyID
			  , O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID
			  , O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
			  , AT011.StandardName S01Name, AT021.StandardName S02Name, AT031.StandardName S03Name, AT041.StandardName S04Name, AT051.StandardName S05Name
			  , AT061.StandardName S06Name, AT071.StandardName S07Name, AT081.StandardName S08Name, AT091.StandardName S09Name, AT101.StandardName S10Name
			  , AT111.StandardName S11Name, AT121.StandardName S12Name, AT131.StandardName S13Name, AT141.StandardName S14Name, AT151.StandardName S15Name
			  , AT161.StandardName S16Name, AT171.StandardName S17Name, AT181.StandardName S18Name, AT191.StandardName S19Name, AT201.StandardName S20Name
			  , T01.AnaName As Ana01Name, T02.AnaName As Ana02Name, T03.AnaName As Ana03Name, T04.AnaName As Ana04Name, T05.AnaName As Ana05Name
			  , T06.AnaName As Ana06Name, T07.AnaName As Ana07Name,T08.AnaName As Ana08Name, T09.AnaName As Ana09Name, T10.AnaName As Ana10Name,OT32.SourceNo
			  , OT32.nvarchar01, OT32.nvarchar02, OT32.nvarchar03, OT32.nvarchar04, OT32.nvarchar05, OT32.nvarchar06, OT32.nvarchar07, OT32.nvarchar08, OT32.nvarchar09, OT32.nvarchar10
			  , OT32.nvarchar11, OT32.nvarchar12, OT32.nvarchar13, OT32.nvarchar14, OT32.nvarchar15, OT32.nvarchar16, OT32.nvarchar17, OT32.nvarchar18, OT32.nvarchar19, OT32.nvarchar20
			  , ISNULL(OT32.OrderQuantity, 0) - SUM(ISNULL(Q01.QuantityInherit, 0))'
	
	SET @sSQL2 = N'
		FROM OT3002 OT32 WITH (NOLOCK)
			INNER JOIN OT3001 OT31 WITH (NOLOCK) ON OT31.DivisionID = OT32.DivisionID AND OT31.POrderID = OT32.POrderID
			LEFT JOIN AT1302 AT12 WITH (NOLOCK) ON AT12.DivisionID IN (''@@@'', OT32.DivisionID) AND AT12.InventoryID = OT32.InventoryID
			LEFT JOIN AT1004 AT14 WITH (NOLOCK) ON AT14.CurrencyID = OT31.CurrencyID
			LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT32.DivisionID AND O99.VoucherID = OT32.POrderID AND O99.TransactionID = OT32.TransactionID AND O99.TableID = ''OT3002''
			LEFT JOIN AT0128 AT011 WITH (NOLOCK) ON AT011.StandardID = O99.S01ID AND AT011.StandardTypeID = ''S01''
			LEFT JOIN AT0128 AT021 WITH (NOLOCK) ON AT021.StandardID = O99.S02ID AND AT021.StandardTypeID = ''S02''
			LEFT JOIN AT0128 AT031 WITH (NOLOCK) ON AT031.StandardID = O99.S03ID AND AT031.StandardTypeID = ''S03''
			LEFT JOIN AT0128 AT041 WITH (NOLOCK) ON AT041.StandardID = O99.S04ID AND AT041.StandardTypeID = ''S04''
			LEFT JOIN AT0128 AT051 WITH (NOLOCK) ON AT051.StandardID = O99.S05ID AND AT051.StandardTypeID = ''S05''
			LEFT JOIN AT0128 AT061 WITH (NOLOCK) ON AT061.StandardID = O99.S06ID AND AT061.StandardTypeID = ''S06''
			LEFT JOIN AT0128 AT071 WITH (NOLOCK) ON AT071.StandardID = O99.S07ID AND AT071.StandardTypeID = ''S07''
			LEFT JOIN AT0128 AT081 WITH (NOLOCK) ON AT081.StandardID = O99.S08ID AND AT081.StandardTypeID = ''S08''
			LEFT JOIN AT0128 AT091 WITH (NOLOCK) ON AT091.StandardID = O99.S09ID AND AT091.StandardTypeID = ''S09''
			LEFT JOIN AT0128 AT101 WITH (NOLOCK) ON AT101.StandardID = O99.S10ID AND AT101.StandardTypeID = ''S10''
			LEFT JOIN AT0128 AT111 WITH (NOLOCK) ON AT111.StandardID = O99.S11ID AND AT111.StandardTypeID = ''S11''
			LEFT JOIN AT0128 AT121 WITH (NOLOCK) ON AT121.StandardID = O99.S12ID AND AT121.StandardTypeID = ''S12''
			LEFT JOIN AT0128 AT131 WITH (NOLOCK) ON AT131.StandardID = O99.S13ID AND AT131.StandardTypeID = ''S13''
			LEFT JOIN AT0128 AT141 WITH (NOLOCK) ON AT141.StandardID = O99.S15ID AND AT141.StandardTypeID = ''S14''
			LEFT JOIN AT0128 AT151 WITH (NOLOCK) ON AT151.StandardID = O99.S15ID AND AT151.StandardTypeID = ''S15''
			LEFT JOIN AT0128 AT161 WITH (NOLOCK) ON AT161.StandardID = O99.S16ID AND AT161.StandardTypeID = ''S16''
			LEFT JOIN AT0128 AT171 WITH (NOLOCK) ON AT171.StandardID = O99.S17ID AND AT171.StandardTypeID = ''S17''
			LEFT JOIN AT0128 AT181 WITH (NOLOCK) ON AT181.StandardID = O99.S18ID AND AT181.StandardTypeID = ''S18''
			LEFT JOIN AT0128 AT191 WITH (NOLOCK) ON AT191.StandardID = O99.S19ID AND AT191.StandardTypeID = ''S19''
			LEFT JOIN AT0128 AT201 WITH (NOLOCK) ON AT201.StandardID = O99.S20ID AND AT201.StandardTypeID = ''S20''
			LEFT JOIN AT1304 AT1304 WITH (NOLOCK) ON OT32.UnitID = AT1304.UnitID
			LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = OT32.Ana01ID AND T01.AnaTypeID = ''A01''
			LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = OT32.Ana02ID AND T02.AnaTypeID = ''A02''
			LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = OT32.Ana03ID AND T03.AnaTypeID = ''A03''
			LEFT JOIN AT1011 T04 WITH (NOLOCK) ON T04.AnaID = OT32.Ana04ID AND T04.AnaTypeID = ''A04''
			LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = OT32.Ana05ID AND T05.AnaTypeID = ''A05''
			LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = OT32.Ana06ID AND T06.AnaTypeID = ''A06''
			LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = OT32.Ana07ID AND T07.AnaTypeID = ''A07''
			LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = OT32.Ana08ID AND T08.AnaTypeID = ''A08''
			LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = OT32.Ana09ID AND T09.AnaTypeID = ''A09''
			LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = OT32.Ana10ID AND T10.AnaTypeID = ''A10''
			LEFT JOIN QCT2001 Q01 WITH (NOLOCK) ON Q01.InheritTransaction = OT32.TransactionID AND Q01.InheritTable = ''OT3001''
			AND Q01.DivisionID = OT32.DivisionID
	'

	SET @sSQL3 = N'
		WHERE OT32.POrderID IN ('''+ @VoucherIDList +''')
		GROUP BY OT31.POrderID, OT32.TransactionID, OT31.ExchangeRate
				, OT31.VoucherNo, OT32.Orders, OT32.InventoryID, AT12.InventoryName, OT32.UnitID, AT1304.UnitName
				, OT32.ConvertedQuantity, OT32.ConvertedSalePrice, OT32.OrderQuantity
				, OT32.PurchasePrice, OT32.VATPercent
				, OT32.Ana01ID, OT32.Ana02ID, OT32.Ana03ID, OT32.Ana04ID, OT32.Notes
				, OT32.Notes01, OT32.Notes02, OT32.Ana05ID, OT32.Ana06ID, OT32.Ana07ID
				, OT32.Ana08ID, OT32.Ana09ID, OT32.Ana10ID, OT32.Notes03, OT32.Notes04
				, OT32.Notes05, OT32.Notes06, OT32.Notes07, OT32.Notes08, OT32.Notes09
				, AT14.ExchangeRateDecimal, OT31.ObjectID, OT31.[Description], OT31.CurrencyID
				, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID
				, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
				, AT011.StandardName, AT021.StandardName, AT031.StandardName, AT041.StandardName, AT051.StandardName
				, AT061.StandardName, AT071.StandardName, AT081.StandardName, AT091.StandardName, AT101.StandardName
				, AT111.StandardName, AT121.StandardName, AT131.StandardName, AT141.StandardName, AT151.StandardName
				, AT161.StandardName, AT171.StandardName, AT181.StandardName, AT191.StandardName, AT201.StandardName
				, T01.AnaName, T02.AnaName, T03.AnaName,T04.AnaName, T05.AnaName, T06.AnaName, T07.AnaName, T08.AnaName, T09.AnaName, T10.AnaName, OT32.SourceNo
				, OT32.nvarchar01, OT32.nvarchar02, OT32.nvarchar03, OT32.nvarchar04, OT32.nvarchar05, OT32.nvarchar06, OT32.nvarchar07, OT32.nvarchar08, OT32.nvarchar09
				, OT32.nvarchar10, OT32.nvarchar11, OT32.nvarchar12, OT32.nvarchar13, OT32.nvarchar14, OT32.nvarchar15, OT32.nvarchar16, OT32.nvarchar17, OT32.nvarchar18
				, OT32.nvarchar19, OT32.nvarchar20
		HAVING ISNULL(OT32.OrderQuantity, 0) - SUM(ISNULL(Q01.QuantityInherit, 0)) > 0'

	EXEC(@sSQL1 + @sSQL2 + @sSQL3)
	PRINT(@sSQL1)
	PRINT(@sSQL2)
	PRINT(@sSQL3)

END
ELSE
BEGIN
	-- Trường hợp kế thừa từ màn hình đơn hàng bán
	SET @TotalRow = ''
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @Parameters = ', OT32.nvarchar01, OT32.nvarchar02, OT32.nvarchar03, OT32.nvarchar04, OT32.nvarchar05, OT32.nvarchar06, OT32.nvarchar07, OT32.nvarchar08, OT32.nvarchar09, OT32.nvarchar10,
					   OT32.nvarchar11, OT32.nvarchar12, OT32.nvarchar13, OT32.nvarchar14, OT32.nvarchar15, OT32.nvarchar16, OT32.nvarchar17, OT32.nvarchar18, OT32.nvarchar19, OT32.nvarchar20'

	SET @SOVoucherID = ISNULL(@SOVoucherID,'')

	IF (@CustomerIndex = 164)
		SET @having = 'HAVING ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) >= 0 '
	ELSE 
		SET @having = 'HAVING ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) > 0'

	-- Load dữ liệu cho Detail cho lưới
	IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 0)
		BEGIN
			SET @sSQL1 = '
			SELECT ROW_NUMBER() OVER (ORDER BY OT32.Orders ) AS RowNum, '+@TotalRow+' AS TotalRow, CONVERT(TINYINT,1) AS IsCheck, ''OT3001'' AS TableID, OT31.POrderID, OT32.TransactionID, 
					ISNULL(OT31.ExchangeRate,0) AS ExchangeRate, 
					OT31.VoucherNo, ISNULL(OT32.Orders,0) AS Orders, OT32.InventoryID, AT12.InventoryName, OT32.UnitID,T04.UnitName,
					ISNULL(OT32.OrderQuantity,0) AS ConvertedQuantity, 
					ISNULL(OT32.PurchasePrice,0) AS ConvertedSalePrice, 
					SUM(ISNULL(OT22.OrderQuantity,0)) AS InheritQuantity,
					ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) + ISNULL(OT32.OrderQuantity,0) AS RemainQuantity,
					ISNULL(OT32.PurchasePrice,0) AS PurchasePrice, 
					ISNULL(OT32.VATPercent,0) AS VATPercent, 
					OT32.Ana01ID, OT32.Ana02ID, OT32.Ana03ID, OT32.Ana04ID, OT32.Notes,
					OT32.Notes01, OT32.Notes02, OT32.Ana05ID, OT32.Ana06ID, OT32.Ana07ID,
					OT32.Ana08ID, OT32.Ana09ID, OT32.Ana10ID, OT32.Notes03, OT32.Notes04,
					OT32.Notes05, OT32.Notes06, OT32.Notes07, OT32.Notes08, OT32.Notes09,
					(ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) + ISNULL(OT32.OrderQuantity,0))*ISNULL(OT32.PurchasePrice,0) AS OriginalAmount,
					(ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) + ISNULL(OT32.OrderQuantity,0))*ISNULL(OT32.PurchasePrice,0)*ISNULL(OT31.ExchangeRate,0) AS ConvertedAmount,
					(ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) + ISNULL(OT32.OrderQuantity,0))*ISNULL(OT32.PurchasePrice,0)*ISNULL(OT32.VATPercent,0)/100 AS VATOriginalAmount,
					(ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) + ISNULL(OT32.OrderQuantity,0))*ISNULL(OT32.PurchasePrice,0)*ISNULL(OT31.ExchangeRate,0)*ISNULL(OT32.VATPercent,0)/100 AS VATConvertedAmount,
					ISNULL(AT14.ExchangeRateDecimal,0) AS ExchangeRateDecimal,
					OT31.ObjectID, OT31.[Description], OT31.CurrencyID,
					O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
					O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
					AT011.StandardName S01Name, AT021.StandardName S02Name, AT031.StandardName S03Name, AT041.StandardName S04Name, AT051.StandardName S05Name,
					AT061.StandardName S06Name, AT071.StandardName S07Name, AT081.StandardName S08Name, AT091.StandardName S09Name, AT101.StandardName S10Name,
					AT111.StandardName S11Name, AT121.StandardName S12Name, AT131.StandardName S13Name, AT141.StandardName S14Name, AT151.StandardName S15Name,
					AT161.StandardName S16Name, AT171.StandardName S17Name, AT181.StandardName S18Name, AT191.StandardName S19Name, AT201.StandardName S20Name
					,T01.AnaName As Ana01Name, T02.AnaName As Ana02Name, T03.AnaName As Ana03Name,T004.AnaName As Ana04Name, T05.AnaName As Ana05Name,
					T06.AnaName As Ana06Name, T07.AnaName As Ana07Name,T08.AnaName As Ana08Name,T09.AnaName As Ana09Name, T10.AnaName As Ana10Name, OT32.SourceNo
					' + @Parameters + ''
	SET @sSQL2 = '
			FROM OT3002 OT32 WITH (NOLOCK)
			INNER JOIN OT3001 OT31 WITH (NOLOCK) ON OT31.DivisionID = OT32.DivisionID AND OT31.POrderID = OT32.POrderID
			LEFT JOIN OT2002 OT22 WITH (NOLOCK) ON OT22.DivisionID = OT32.DivisionID AND OT22.InheritTableID = ''OT3001'' 
					AND OT22.InheritVoucherID = OT32.POrderID AND OT22.InheritTransactionID = OT32.TransactionID
			LEFT JOIN AT1302 AT12 WITH (NOLOCK) ON AT12.DivisionID IN (''@@@'', OT32.DivisionID) AND AT12.InventoryID = OT32.InventoryID 
			LEFT JOIN AT1004 AT14 WITH (NOLOCK) ON AT14.CurrencyID = OT31.CurrencyID
			LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT32.DivisionID AND O99.VoucherID = OT32.POrderID AND O99.TransactionID = OT32.TransactionID AND O99.TableID = ''OT3002''
			LEFT JOIN AT0128 AT011 WITH (NOLOCK) ON AT011.StandardID = O99.S01ID AND AT011.StandardTypeID = ''S01''
			LEFT JOIN AT0128 AT021 WITH (NOLOCK) ON AT021.StandardID = O99.S02ID AND AT021.StandardTypeID = ''S02''
			LEFT JOIN AT0128 AT031 WITH (NOLOCK) ON AT031.StandardID = O99.S03ID AND AT031.StandardTypeID = ''S03''
			LEFT JOIN AT0128 AT041 WITH (NOLOCK) ON AT041.StandardID = O99.S04ID AND AT041.StandardTypeID = ''S04''
			LEFT JOIN AT0128 AT051 WITH (NOLOCK) ON AT051.StandardID = O99.S05ID AND AT051.StandardTypeID = ''S05''
			LEFT JOIN AT0128 AT061 WITH (NOLOCK) ON AT061.StandardID = O99.S06ID AND AT061.StandardTypeID = ''S06''
			LEFT JOIN AT0128 AT071 WITH (NOLOCK) ON AT071.StandardID = O99.S07ID AND AT071.StandardTypeID = ''S07''
			LEFT JOIN AT0128 AT081 WITH (NOLOCK) ON AT081.StandardID = O99.S08ID AND AT081.StandardTypeID = ''S08''
			LEFT JOIN AT0128 AT091 WITH (NOLOCK) ON AT091.StandardID = O99.S09ID AND AT091.StandardTypeID = ''S09''
			LEFT JOIN AT0128 AT101 WITH (NOLOCK) ON AT101.StandardID = O99.S10ID AND AT101.StandardTypeID = ''S10''
			LEFT JOIN AT0128 AT111 WITH (NOLOCK) ON AT111.StandardID = O99.S11ID AND AT111.StandardTypeID = ''S11''
			LEFT JOIN AT0128 AT121 WITH (NOLOCK) ON AT121.StandardID = O99.S12ID AND AT121.StandardTypeID = ''S12''
			LEFT JOIN AT0128 AT131 WITH (NOLOCK) ON AT131.StandardID = O99.S13ID AND AT131.StandardTypeID = ''S13''
			LEFT JOIN AT0128 AT141 WITH (NOLOCK) ON AT141.StandardID = O99.S15ID AND AT141.StandardTypeID = ''S14''
			LEFT JOIN AT0128 AT151 WITH (NOLOCK) ON AT151.StandardID = O99.S15ID AND AT151.StandardTypeID = ''S15''
			LEFT JOIN AT0128 AT161 WITH (NOLOCK) ON AT161.StandardID = O99.S16ID AND AT161.StandardTypeID = ''S16''
			LEFT JOIN AT0128 AT171 WITH (NOLOCK) ON AT171.StandardID = O99.S17ID AND AT171.StandardTypeID = ''S17''
			LEFT JOIN AT0128 AT181 WITH (NOLOCK) ON AT181.StandardID = O99.S18ID AND AT181.StandardTypeID = ''S18''
			LEFT JOIN AT0128 AT191 WITH (NOLOCK) ON AT191.StandardID = O99.S19ID AND AT191.StandardTypeID = ''S19''
			LEFT JOIN AT0128 AT201 WITH (NOLOCK) ON AT201.StandardID = O99.S20ID AND AT201.StandardTypeID = ''S20''
			LEFT JOIN AT1304 T04  With (NOLOCK) on OT32.UnitID = T04.UnitID
			LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = OT32.Ana01ID AND T01.AnaTypeID = ''A01''
			LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = OT32.Ana02ID AND T02.AnaTypeID = ''A02''
			LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = OT32.Ana03ID AND T03.AnaTypeID = ''A03''
			LEFT JOIN AT1011 T004 WITH (NOLOCK) ON T004.AnaID = OT32.Ana04ID AND T004.AnaTypeID = ''A04''
			LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = OT32.Ana05ID AND T05.AnaTypeID = ''A05''
			LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = OT32.Ana06ID AND T06.AnaTypeID = ''A06''
			LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = OT32.Ana07ID AND T07.AnaTypeID = ''A07''
			LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = OT32.Ana08ID AND T08.AnaTypeID = ''A08''
			LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = OT32.Ana09ID AND T09.AnaTypeID = ''A09''
			LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = OT32.Ana10ID AND T10.AnaTypeID = ''A10''
			'
	SET @sSQL3 = ' WHERE OT32.DivisionID = '''+@DivisionID+''' 
			AND OT32.TransactionID IN (SELECT OT22.InheritTransactionID 
									FROM OT2002 OT22 WITH (NOLOCK) 
									WHERE OT22.DivisionID = '''+@DivisionID+''' AND OT22.SOrderID = '''+@SOVoucherID+''' 
										AND OT22.InheritTableID = ''OT3001'')
			GROUP BY OT31.POrderID, OT32.TransactionID, OT31.ExchangeRate,
						OT31.VoucherNo, OT32.Orders, OT32.InventoryID, AT12.InventoryName, OT32.UnitID,T04.UnitName,
						OT32.ConvertedQuantity, OT32.ConvertedSalePrice, OT32.OrderQuantity, 
						OT22.OrderQuantity, OT32.PurchasePrice, OT32.VATPercent, 
						OT32.Ana01ID, OT32.Ana02ID, OT32.Ana03ID, OT32.Ana04ID, OT32.Notes, 
						OT32.Notes01, OT32.Notes02, OT32.Ana05ID, OT32.Ana06ID, OT32.Ana07ID,
						OT32.Ana08ID, OT32.Ana09ID, OT32.Ana10ID, OT32.Notes03, OT32.Notes04,
						OT32.Notes05, OT32.Notes06, OT32.Notes07, OT32.Notes08, OT32.Notes09, 
						AT14.ExchangeRateDecimal, OT31.ObjectID, OT31.[Description], OT31.CurrencyID,
						O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
						O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
					AT011.StandardName, AT021.StandardName, AT031.StandardName, AT041.StandardName, AT051.StandardName,
					AT061.StandardName, AT071.StandardName, AT081.StandardName, AT091.StandardName, AT101.StandardName,
					AT111.StandardName, AT121.StandardName, AT131.StandardName, AT141.StandardName, AT151.StandardName,
					AT161.StandardName, AT171.StandardName, AT181.StandardName, AT191.StandardName, AT201.StandardName
					,T01.AnaName, T02.AnaName, T03.AnaName,T004.AnaName, T05.AnaName,T06.AnaName, T07.AnaName,T08.AnaName,T09.AnaName, T10.AnaName,OT32.SourceNo
					' + @Parameters + '
			UNION '
			
			SET @sSQL4 = '
			SELECT ROW_NUMBER() OVER (ORDER BY OT32.Orders ) AS RowNum, '+@TotalRow+' AS TotalRow,CONVERT(TINYINT,0) AS IsCheck, ''OT3001'' AS TableID, OT31.POrderID, OT32.TransactionID, 
					ISNULL(OT31.ExchangeRate,0) AS ExchangeRate, 
					OT31.VoucherNo, ISNULL(OT32.Orders,0) AS Orders, OT32.InventoryID, AT12.InventoryName, OT32.UnitID,T04.UnitName,
					ISNULL(OT32.OrderQuantity,0) AS ConvertedQuantity, 
					ISNULL(OT32.PurchasePrice,0) AS ConvertedSalePrice,
					SUM(ISNULL(OT22.OrderQuantity,0)) AS InheritQuantity,
					ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) AS RemainQuantity,
					ISNULL(OT32.PurchasePrice,0) AS PurchasePrice, 
					ISNULL(OT32.VATPercent,0) AS VATPercent, 
					OT32.Ana01ID, OT32.Ana02ID, OT32.Ana03ID, OT32.Ana04ID, OT32.Notes,
					OT32.Notes01, OT32.Notes02, OT32.Ana05ID, OT32.Ana06ID, OT32.Ana07ID,
					OT32.Ana08ID, OT32.Ana09ID, OT32.Ana10ID, OT32.Notes03, OT32.Notes04,
					OT32.Notes05, OT32.Notes06, OT32.Notes07, OT32.Notes08, OT32.Notes09,
					(ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)))*ISNULL(OT32.PurchasePrice,0) AS OriginalAmount,
					(ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)))*ISNULL(OT32.PurchasePrice,0)*ISNULL(OT31.ExchangeRate,0) AS ConvertedAmount,
					(ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)))*ISNULL(OT32.PurchasePrice,0)*ISNULL(OT32.VATPercent,0)/100 AS VATOriginalAmount,
					(ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)))*ISNULL(OT32.PurchasePrice,0)*ISNULL(OT31.ExchangeRate,0)*ISNULL(OT32.VATPercent,0)/100 AS VATConvertedAmount,
					ISNULL(AT14.ExchangeRateDecimal,0) AS ExchangeRateDecimal,
					OT31.ObjectID, OT31.[Description], OT31.CurrencyID,
					O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
					O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
					AT011.StandardName S01Name, AT021.StandardName S02Name, AT031.StandardName S03Name, AT041.StandardName S04Name, AT051.StandardName S05Name,
					AT061.StandardName S06Name, AT071.StandardName S07Name, AT081.StandardName S08Name, AT091.StandardName S09Name, AT101.StandardName S10Name,
					AT111.StandardName S11Name, AT121.StandardName S12Name, AT131.StandardName S13Name, AT141.StandardName S14Name, AT151.StandardName S15Name,
					AT161.StandardName S16Name, AT171.StandardName S17Name, AT181.StandardName S18Name, AT191.StandardName S19Name, AT201.StandardName S20Name
					,T01.AnaName As Ana01Name, T02.AnaName As Ana02Name, T03.AnaName As Ana03Name,T004.AnaName As Ana04Name, T05.AnaName As Ana05Name,
					T06.AnaName As Ana06Name, T07.AnaName As Ana07Name,T08.AnaName As Ana08Name,T09.AnaName As Ana09Name, T10.AnaName As Ana10Name,OT32.SourceNo
					' + @Parameters + ''
	SET @sSQL5 = '		FROM OT3002 OT32 WITH (NOLOCK)
			INNER JOIN OT3001 OT31 WITH (NOLOCK) ON OT31.DivisionID = OT32.DivisionID AND OT31.POrderID = OT32.POrderID
			LEFT JOIN OT2002 OT22 WITH (NOLOCK) ON OT22.DivisionID = OT32.DivisionID AND OT22.InheritTableID = ''OT3001'' 
					AND OT22.InheritVoucherID = OT32.POrderID AND OT22.InheritTransactionID = OT32.TransactionID
			LEFT JOIN AT1302 AT12 WITH (NOLOCK) ON AT12.DivisionID IN (''@@@'', OT32.DivisionID) AND AT12.InventoryID = OT32.InventoryID
			LEFT JOIN AT1004 AT14 WITH (NOLOCK) ON AT14.CurrencyID = OT31.CurrencyID
			LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT32.DivisionID AND O99.VoucherID = OT32.POrderID AND O99.TransactionID = OT32.TransactionID AND O99.TableID = ''OT3002''
			LEFT JOIN AT0128 AT011 WITH (NOLOCK) ON AT011.StandardID = O99.S01ID AND AT011.StandardTypeID = ''S01''
			LEFT JOIN AT0128 AT021 WITH (NOLOCK) ON AT021.StandardID = O99.S02ID AND AT021.StandardTypeID = ''S02''
			LEFT JOIN AT0128 AT031 WITH (NOLOCK) ON AT031.StandardID = O99.S03ID AND AT031.StandardTypeID = ''S03''
			LEFT JOIN AT0128 AT041 WITH (NOLOCK) ON AT041.StandardID = O99.S04ID AND AT041.StandardTypeID = ''S04''
			LEFT JOIN AT0128 AT051 WITH (NOLOCK) ON AT051.StandardID = O99.S05ID AND AT051.StandardTypeID = ''S05''
			LEFT JOIN AT0128 AT061 WITH (NOLOCK) ON AT061.StandardID = O99.S06ID AND AT061.StandardTypeID = ''S06''
			LEFT JOIN AT0128 AT071 WITH (NOLOCK) ON AT071.StandardID = O99.S07ID AND AT071.StandardTypeID = ''S07''
			LEFT JOIN AT0128 AT081 WITH (NOLOCK) ON AT081.StandardID = O99.S08ID AND AT081.StandardTypeID = ''S08''
			LEFT JOIN AT0128 AT091 WITH (NOLOCK) ON AT091.StandardID = O99.S09ID AND AT091.StandardTypeID = ''S09''
			LEFT JOIN AT0128 AT101 WITH (NOLOCK) ON AT101.StandardID = O99.S10ID AND AT101.StandardTypeID = ''S10''
			LEFT JOIN AT0128 AT111 WITH (NOLOCK) ON AT111.StandardID = O99.S11ID AND AT111.StandardTypeID = ''S11''
			LEFT JOIN AT0128 AT121 WITH (NOLOCK) ON AT121.StandardID = O99.S12ID AND AT121.StandardTypeID = ''S12''
			LEFT JOIN AT0128 AT131 WITH (NOLOCK) ON AT131.StandardID = O99.S13ID AND AT131.StandardTypeID = ''S13''
			LEFT JOIN AT0128 AT141 WITH (NOLOCK) ON AT141.StandardID = O99.S15ID AND AT141.StandardTypeID = ''S14''
			LEFT JOIN AT0128 AT151 WITH (NOLOCK) ON AT151.StandardID = O99.S15ID AND AT151.StandardTypeID = ''S15''
			LEFT JOIN AT0128 AT161 WITH (NOLOCK) ON AT161.StandardID = O99.S16ID AND AT161.StandardTypeID = ''S16''
			LEFT JOIN AT0128 AT171 WITH (NOLOCK) ON AT171.StandardID = O99.S17ID AND AT171.StandardTypeID = ''S17''
			LEFT JOIN AT0128 AT181 WITH (NOLOCK) ON AT181.StandardID = O99.S18ID AND AT181.StandardTypeID = ''S18''
			LEFT JOIN AT0128 AT191 WITH (NOLOCK) ON AT191.StandardID = O99.S19ID AND AT191.StandardTypeID = ''S19''
			LEFT JOIN AT0128 AT201 WITH (NOLOCK) ON AT201.StandardID = O99.S20ID AND AT201.StandardTypeID = ''S20''
			LEFT JOIN AT1304 T04  With (NOLOCK) on OT32.UnitID = T04.UnitID
			LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = OT32.Ana01ID AND T01.AnaTypeID = ''A01''
			LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = OT32.Ana02ID AND T02.AnaTypeID = ''A02''
			LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = OT32.Ana03ID AND T03.AnaTypeID = ''A03''
			LEFT JOIN AT1011 T004 WITH (NOLOCK) ON T004.AnaID = OT32.Ana04ID AND T004.AnaTypeID = ''A04''
			LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = OT32.Ana05ID AND T05.AnaTypeID = ''A05''
			LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = OT32.Ana06ID AND T06.AnaTypeID = ''A06''
			LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = OT32.Ana07ID AND T07.AnaTypeID = ''A07''
			LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = OT32.Ana08ID AND T08.AnaTypeID = ''A08''
			LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = OT32.Ana09ID AND T09.AnaTypeID = ''A09''
			LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = OT32.Ana10ID AND T10.AnaTypeID = ''A10'' 
	 '
		SET @sSQL6 = '	
					WHERE OT32.DivisionID = '''+@DivisionID+''' AND OT32.POrderID IN ('''+@VoucherIDList+''')
					AND OT32.TransactionID NOT IN (SELECT OT22.InheritTransactionID 
													FROM OT2002 OT22 WITH (NOLOCK) 
													WHERE OT22.DivisionID = '''+@DivisionID+''' AND OT22.SOrderID = '''+@SOVoucherID+''' 
														AND OT22.InheritTableID = ''OT3001'')
					GROUP BY OT31.POrderID, OT32.TransactionID, OT31.ExchangeRate,
						OT31.VoucherNo, OT32.Orders, OT32.InventoryID, AT12.InventoryName, OT32.UnitID,T04.UnitName,
						OT32.ConvertedQuantity, OT32.ConvertedSalePrice, OT32.OrderQuantity, 
						OT22.OrderQuantity, OT32.PurchasePrice, OT32.VATPercent,
						OT32.Ana01ID, OT32.Ana02ID, OT32.Ana03ID, OT32.Ana04ID, OT32.Notes, 
						OT32.Notes01, OT32.Notes02, OT32.Ana05ID, OT32.Ana06ID, OT32.Ana07ID,
						OT32.Ana08ID, OT32.Ana09ID, OT32.Ana10ID, OT32.Notes03, OT32.Notes04,
						OT32.Notes05, OT32.Notes06, OT32.Notes07, OT32.Notes08, OT32.Notes09,
						AT14.ExchangeRateDecimal, OT31.ObjectID, OT31.[Description], OT31.CurrencyID,
						O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
						O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
					AT011.StandardName, AT021.StandardName, AT031.StandardName, AT041.StandardName, AT051.StandardName,
					AT061.StandardName, AT071.StandardName, AT081.StandardName, AT091.StandardName, AT101.StandardName,
					AT111.StandardName, AT121.StandardName, AT131.StandardName, AT141.StandardName, AT151.StandardName,
					AT161.StandardName, AT171.StandardName, AT181.StandardName, AT191.StandardName, AT201.StandardName
					,T01.AnaName, T02.AnaName, T03.AnaName,T004.AnaName, T05.AnaName,T06.AnaName, T07.AnaName,T08.AnaName,T09.AnaName, T10.AnaName,OT32.SourceNo
					' + @Parameters + '
				'+@having+'
				ORDER BY VoucherNo, IsCheck DESC, Orders, InventoryID
				'
		END
	ELSE
		BEGIN
			SET @sSQL1 = '
				SELECT ROW_NUMBER() OVER (ORDER BY OT32.Orders ) AS RowNum, '+@TotalRow+' AS TotalRow,CONVERT(TINYINT,1) AS IsCheck, ''OT3001'' AS TableID, OT31.POrderID, OT32.TransactionID, 
					   ISNULL(OT31.ExchangeRate,0) AS ExchangeRate, 
					   OT31.VoucherNo, ISNULL(OT32.Orders,0) AS Orders, OT32.InventoryID, AT12.InventoryName, OT32.UnitID,T04.UnitName,
					   ISNULL(OT32.OrderQuantity,0) AS ConvertedQuantity, 
					   ISNULL(OT32.PurchasePrice,0) AS ConvertedSalePrice, 
					   SUM(ISNULL(OT22.OrderQuantity,0)) AS InheritQuantity,
					   ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) + ISNULL(OT32.OrderQuantity,0) AS RemainQuantity,
					   ISNULL(OT32.PurchasePrice,0) AS PurchasePrice, 
					   ISNULL(OT32.VATPercent,0) AS VATPercent, 
					   OT32.Ana01ID, OT32.Ana02ID, OT32.Ana03ID, OT32.Ana04ID, OT32.Notes,
					   OT32.Notes01, OT32.Notes02, OT32.Ana05ID, OT32.Ana06ID, OT32.Ana07ID,
					   OT32.Ana08ID, OT32.Ana09ID, OT32.Ana10ID, OT32.Notes03, OT32.Notes04,
					   OT32.Notes05, OT32.Notes06, OT32.Notes07, OT32.Notes08, OT32.Notes09,
					  (ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) + ISNULL(OT32.OrderQuantity,0))*ISNULL(OT32.PurchasePrice,0) AS OriginalAmount,
					  (ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) + ISNULL(OT32.OrderQuantity,0))*ISNULL(OT32.PurchasePrice,0)*ISNULL(OT31.ExchangeRate,0) AS ConvertedAmount,
					  (ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) + ISNULL(OT32.OrderQuantity,0))*ISNULL(OT32.PurchasePrice,0)*ISNULL(OT32.VATPercent,0)/100 AS VATOriginalAmount,
					  (ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) + ISNULL(OT32.OrderQuantity,0))*ISNULL(OT32.PurchasePrice,0)*ISNULL(OT31.ExchangeRate,0)*ISNULL(OT32.VATPercent,0)/100 AS VATConvertedAmount,
					   ISNULL(AT14.ExchangeRateDecimal,0) AS ExchangeRateDecimal,
					   OT31.ObjectID, OT31.[Description], OT31.CurrencyID
					   ,T01.AnaName As Ana01Name, T02.AnaName As Ana02Name, T03.AnaName As Ana03Name,T004.AnaName As Ana04Name, T05.AnaName As Ana05Name,
						T06.AnaName As Ana06Name, T07.AnaName As Ana07Name,T08.AnaName As Ana08Name,T09.AnaName As Ana09Name, T10.AnaName As Ana10Name,OT32.SourceNo
					   ' + @Parameters + '
				FROM OT3002 OT32 WITH (NOLOCK)
				INNER JOIN OT3001 OT31 WITH (NOLOCK) ON OT31.DivisionID = OT32.DivisionID AND OT31.POrderID = OT32.POrderID
				LEFT JOIN OT2002 OT22 WITH (NOLOCK) ON OT22.DivisionID = OT32.DivisionID AND OT22.InheritTableID = ''OT3001'' 
					 AND OT22.InheritVoucherID = OT32.POrderID AND OT22.InheritTransactionID = OT32.TransactionID
				LEFT JOIN AT1302 AT12 WITH (NOLOCK) ON AT12.DivisionID IN (''@@@'', OT32.DivisionID) AND AT12.InventoryID = OT32.InventoryID 
				LEFT JOIN AT1004 AT14 WITH (NOLOCK) ON AT14.CurrencyID = OT31.CurrencyID
				LEFT JOIN AT1304 T04  With (NOLOCK) on OT32.UnitID = T04.UnitID
				LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = OT32.Ana01ID AND T01.AnaTypeID = ''A01''
				LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = OT32.Ana02ID AND T02.AnaTypeID = ''A02''
				LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = OT32.Ana03ID AND T03.AnaTypeID = ''A03''
				LEFT JOIN AT1011 T004 WITH (NOLOCK) ON T004.AnaID = OT32.Ana04ID AND T004.AnaTypeID = ''A04''
				LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = OT32.Ana05ID AND T05.AnaTypeID = ''A05''
				LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = OT32.Ana06ID AND T06.AnaTypeID = ''A06''
				LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = OT32.Ana07ID AND T07.AnaTypeID = ''A07''
				LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = OT32.Ana08ID AND T08.AnaTypeID = ''A08''
				LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = OT32.Ana09ID AND T09.AnaTypeID = ''A09''
				LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = OT32.Ana10ID AND T10.AnaTypeID = ''A10'' 
				WHERE OT32.DivisionID = '''+@DivisionID+''' 
					  AND OT32.TransactionID IN (SELECT OT22.InheritTransactionID 
												 FROM OT2002 OT22 
												 WHERE OT22.DivisionID = '''+@DivisionID+''' AND OT22.SOrderID = '''+@SOVoucherID+''' 
													   AND OT22.InheritTableID = ''OT3001'') 
				GROUP BY OT31.POrderID, OT32.TransactionID, OT31.ExchangeRate,
						 OT31.VoucherNo, OT32.Orders, OT32.InventoryID, AT12.InventoryName, OT32.UnitID,T04.UnitName,
						 OT32.ConvertedQuantity, OT32.ConvertedSalePrice, OT32.OrderQuantity, 
						 OT22.OrderQuantity, OT32.PurchasePrice, OT32.VATPercent, 
						 OT32.Ana01ID, OT32.Ana02ID, OT32.Ana03ID, OT32.Ana04ID, OT32.Notes, 
						 OT32.Notes01, OT32.Notes02, OT32.Ana05ID, OT32.Ana06ID, OT32.Ana07ID,
						 OT32.Ana08ID, OT32.Ana09ID, OT32.Ana10ID, OT32.Notes03, OT32.Notes04,
						 OT32.Notes05, OT32.Notes06, OT32.Notes07, OT32.Notes08, OT32.Notes09, 
						 AT14.ExchangeRateDecimal, OT31.ObjectID, OT31.[Description], OT31.CurrencyID
						 ,T01.AnaName, T02.AnaName, T03.AnaName,T004.AnaName, T05.AnaName,T06.AnaName, T07.AnaName,T08.AnaName,T09.AnaName, T10.AnaName,OT32.SourceNo
						 ' + @Parameters + '
				UNION '
			
			SET @sSQL2 = '
				SELECT ROW_NUMBER() OVER (ORDER BY OT32.Orders ) AS RowNum, '+@TotalRow+' AS TotalRow,CONVERT(TINYINT,0) AS IsCheck, ''OT3001'' AS TableID, OT31.POrderID, OT32.TransactionID, 
						ISNULL(OT31.ExchangeRate,0) AS ExchangeRate, 
						OT31.VoucherNo, ISNULL(OT32.Orders,0) AS Orders, OT32.InventoryID, AT12.InventoryName, OT32.UnitID,T04.UnitName,
						ISNULL(OT32.OrderQuantity,0) AS ConvertedQuantity, 
						ISNULL(OT32.PurchasePrice,0) AS ConvertedSalePrice,
						SUM(ISNULL(OT22.OrderQuantity,0)) AS InheritQuantity,
						ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) AS RemainQuantity,
						ISNULL(OT32.PurchasePrice,0) AS PurchasePrice, 
						ISNULL(OT32.VATPercent,0) AS VATPercent, 
						OT32.Ana01ID, OT32.Ana02ID, OT32.Ana03ID, OT32.Ana04ID, OT32.Notes,
						OT32.Notes01, OT32.Notes02, OT32.Ana05ID, OT32.Ana06ID, OT32.Ana07ID,
						OT32.Ana08ID, OT32.Ana09ID, OT32.Ana10ID, OT32.Notes03, OT32.Notes04,
						OT32.Notes05, OT32.Notes06, OT32.Notes07, OT32.Notes08, OT32.Notes09,
					   (ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)))*ISNULL(OT32.PurchasePrice,0) AS OriginalAmount,
					   (ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)))*ISNULL(OT32.PurchasePrice,0)*ISNULL(OT31.ExchangeRate,0) AS ConvertedAmount,
					   (ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)))*ISNULL(OT32.PurchasePrice,0)*ISNULL(OT32.VATPercent,0)/100 AS VATOriginalAmount,
					   (ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)))*ISNULL(OT32.PurchasePrice,0)*ISNULL(OT31.ExchangeRate,0)*ISNULL(OT32.VATPercent,0)/100 AS VATConvertedAmount,
						ISNULL(AT14.ExchangeRateDecimal,0) AS ExchangeRateDecimal,
						OT31.ObjectID, OT31.[Description], OT31.CurrencyID
						,T01.AnaName As Ana01Name, T02.AnaName As Ana02Name, T03.AnaName As Ana03Name,T004.AnaName As Ana04Name, T05.AnaName As Ana05Name,
						T06.AnaName As Ana06Name, T07.AnaName As Ana07Name,T08.AnaName As Ana08Name,T09.AnaName As Ana09Name, T10.AnaName As Ana10Name,OT32.SourceNo
						' + @Parameters + '
				FROM OT3002 OT32 WITH (NOLOCK)
				INNER JOIN OT3001 OT31 WITH (NOLOCK) ON OT31.DivisionID = OT32.DivisionID AND OT31.POrderID = OT32.POrderID
				LEFT JOIN OT2002 OT22 WITH (NOLOCK) ON OT22.DivisionID = OT32.DivisionID AND OT22.InheritTableID = ''OT3001'' 
					 AND OT22.InheritVoucherID = OT32.POrderID AND OT22.InheritTransactionID = OT32.TransactionID
				LEFT JOIN AT1302 AT12 WITH (NOLOCK) ON AT12.DivisionID IN (''@@@'', OT32.DivisionID) AND AT12.InventoryID = OT32.InventoryID
				LEFT JOIN AT1004 AT14 WITH (NOLOCK) ON AT14.CurrencyID = OT31.CurrencyID
				LEFT JOIN AT1304 T04  With (NOLOCK) on OT32.UnitID = T04.UnitID
				LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = OT32.Ana01ID AND T01.AnaTypeID = ''A01''
				LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = OT32.Ana02ID AND T02.AnaTypeID = ''A02''
				LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = OT32.Ana03ID AND T03.AnaTypeID = ''A03''
				LEFT JOIN AT1011 T004 WITH (NOLOCK) ON T004.AnaID = OT32.Ana04ID AND T004.AnaTypeID = ''A04''
				LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = OT32.Ana05ID AND T05.AnaTypeID = ''A05''
				LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = OT32.Ana06ID AND T06.AnaTypeID = ''A06''
				LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = OT32.Ana07ID AND T07.AnaTypeID = ''A07''
				LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = OT32.Ana08ID AND T08.AnaTypeID = ''A08''
				LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = OT32.Ana09ID AND T09.AnaTypeID = ''A09''
				LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = OT32.Ana10ID AND T10.AnaTypeID = ''A10'' 
				WHERE OT32.DivisionID = '''+@DivisionID+''' AND OT32.POrderID IN ('''+@VoucherIDList+''')
					  AND OT32.TransactionID NOT IN (SELECT OT22.InheritTransactionID 
													 FROM OT2002 OT22  WITH (NOLOCK)
													 WHERE OT22.DivisionID = '''+@DivisionID+''' AND OT22.SOrderID = '''+@SOVoucherID+''' 
														   AND OT22.InheritTableID = ''OT3001'') 
				GROUP BY OT31.POrderID, OT32.TransactionID, OT31.ExchangeRate,
						 OT31.VoucherNo, OT32.Orders, OT32.InventoryID, AT12.InventoryName, OT32.UnitID,T04.UnitName,
						 OT32.ConvertedQuantity, OT32.ConvertedSalePrice, OT32.OrderQuantity, 
						 OT22.OrderQuantity, OT32.PurchasePrice, OT32.VATPercent,
						 OT32.Ana01ID, OT32.Ana02ID, OT32.Ana03ID, OT32.Ana04ID, OT32.Notes, 
						 OT32.Notes01, OT32.Notes02, OT32.Ana05ID, OT32.Ana06ID, OT32.Ana07ID,
						 OT32.Ana08ID, OT32.Ana09ID, OT32.Ana10ID, OT32.Notes03, OT32.Notes04,
						 OT32.Notes05, OT32.Notes06, OT32.Notes07, OT32.Notes08, OT32.Notes09,
						 AT14.ExchangeRateDecimal, OT31.ObjectID, OT31.[Description], OT31.CurrencyID
						 ,T01.AnaName, T02.AnaName, T03.AnaName,T004.AnaName, T05.AnaName,T06.AnaName, T07.AnaName,T08.AnaName,T09.AnaName, T10.AnaName,OT32.SourceNo
						 ' + @Parameters + '
				 HAVING ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) > 0
				 ORDER BY VoucherNo, IsCheck DESC, Orders, InventoryID
					'
		END

	IF @Mode = 1
	BEGIN
		SET @sSQL6 = @sSQL6+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END

	EXEC (@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4 + @sSQL5 + @sSQL6) 
	PRINT (@sSQL1)
	PRINT (@sSQL2)
	PRINT (@sSQL3)
	PRINT (@sSQL4)
	PRINT (@sSQL5)
	PRINT (@sSQL6)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
