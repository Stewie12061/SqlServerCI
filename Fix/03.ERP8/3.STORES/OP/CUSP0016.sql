IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CUSP0016]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CUSP0016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Báo cáo quyết toán thầu phụ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 06/10/2014 by Mai Tri Thien
---- Create on 21/11/2017 by BBL -- Add Loai Hang hoa trong giao dien tim kiem
---- Modified by Đức Duy on 10/04/2023 : [2023/04/IS/0064] - Tách @sSQL thành 2 đoạn vì quá dài
-- <Example>
---- EXEC CUSP0016 'BBL', 201401, 201501, '2014-12-10 00:00:00.000', '2014-12-10 00:00:00.000', 1, 'CCBX0.0001', 'CCBX0.0001', '', ''

CREATE PROCEDURE [dbo].[CUSP0016]
( 
		@DivisionID AS NVARCHAR(50),
		@FromPeriod AS INT,
		@ToPeriod AS INT,
		@FromDate DATETIME,  
		@ToDate DATETIME,
		@TimeMode as INT, -- Period=0. day = 1
		@FromObjectID AS VARCHAR(50),
		@ToObjectID AS VARCHAR(50) = '',
		@FromPriceListID AS VARCHAR(50),
		@ToPriceListID AS VARCHAR(50) = '',
		@FromGoodsName As VARCHAR(50),
		@ToGoodsName As VARCHAR(50)='',
		@TenPT AS VARCHAR(50)
) 
AS 
DECLARE @sSQL AS NVARCHAR(MAX),
		@sSQLBG AS NVARCHAR(MAX),
		@sSQL1 AS NVARCHAR(MAX),
		@sSQL2 AS NVARCHAR(MAX),
		@sWhere AS NVARCHAR(MAX),
		@sWHERE1 AS NVARCHAR(MAX),
		@sWHEREBG AS NVARCHAR(MAX),
		@sOrder AS NVARCHAR(MAX),
		@sSelect AS NVARCHAR(MAX)

SET @sWhere = ''
SET @sWHERE1 = ''
SET @sWHEREBG = ''
SET @sOrder = N'
				ORDER BY OT11.POrderID, OT11.ObjectID, OT12.InventoryID'
------------>>> Điều kiện Lọc

IF @TimeMode = 1
BEGIN
	SET @sWhere = @sWhere + N' AND CONVERT(VARCHAR,OT11.OrderDate,112) BETWEEN '+CONVERT(VARCHAR,@FromDate,112)+' AND '+CONVERT(VARCHAR,@ToDate,112)+' '
	SET @sWHEREBG = @sWHEREBG + N' AND CONVERT(VARCHAR,OT32.ReceiveDate,112) BETWEEN '+CONVERT(VARCHAR,@FromDate,112)+' AND '+CONVERT(VARCHAR,@ToDate,112)+' '
END

IF @TimeMode = 0
BEGIN
	SET @sWhere = @sWhere + N' AND OT11.TranYear*100 + OT11.TranMonth BETWEEN '+CONVERT(NVARCHAR(10), @FromPeriod)+' AND '+CONVERT(NVARCHAR(10), @ToPeriod)+' '
	SET @sWHEREBG = @sWHEREBG + N' AND OT31.TranYear*100 + OT31.TranMonth BETWEEN '+CONVERT(NVARCHAR(10), @FromPeriod)+' AND '+CONVERT(NVARCHAR(10), @ToPeriod)+' '
END
-----------<<< Điều kiện Lọc

SET @sSelect = N'
	SELECT Distinct
			OT11.*, 
			Ana01.AnaName as Ana01Name, 
			Ana02.AnaName as Ana02Name, 
			Ana03.AnaName as Ana03Name, 
			Ana04.AnaName as Ana04Name, 
			Ana05.AnaName as Ana05Name, 
			Ana06.AnaName as Ana06Name, 
			Ana07.AnaName as Ana07Name, 
			Ana08.AnaName as Ana08Name, 
			Ana09.AnaName as Ana09Name, 
			Ana10.AnaName as Ana10Name, 
			OT12.Ana01ID SAna01ID, SAna01.AnaName as SAna01Name, 
			OT12.Ana02ID SAna02ID, SAna02.AnaName as SAna02Name, 
			OT12.Ana03ID SAna03ID, SAna03.AnaName as SAna03Name, 
			OT12.Ana04ID SAna04ID, SAna04.AnaName as SAna04Name, 
			OT12.Ana05ID SAna05ID, SAna05.AnaName as SAna05Name, 
			OT12.Ana06ID SAna06ID, SAna06.AnaName as SAna06Name, 
			OT12.Ana07ID SAna07ID, SAna07.AnaName as SAna07Name, 
			OT12.Ana08ID SAna08ID, SAna08.AnaName as SAna08Name, 
			OT12.Ana09ID SAna09ID, SAna09.AnaName as SAna09Name, 
			OT12.Ana10ID SAna10ID, SAna10.AnaName as SAna10Name, 
			OT12.InventoryID, AT1302.InventoryName,
			OT12.UnitID, AT1304.UnitName, 
			ISNULL(OT12.ConvertedQuantity, 0) ConvertedQuantity, 
			ISNULL(OT12.ImTaxPercent, 0) ImTaxPercent, 
			ISNULL(OT12.ImTaxOriginalAmount, 0) ImTaxOriginalAmount, 
			ISNULL(OT12.ImTaxConvertedAmount, 0) ImTaxConvertedAmount, 
			ISNULL(OT12.OrderQuantity, 0) OOrderQuantity, ISNULL(TT.OrderQuantity, 0) AS OrderQuantity, ISNULL(OT12.ConvertedAmount, 0) ConvertedAmount, 
			ISNULL(OT12.VATPercent, 0) VATPercent, ISNULL(OT12.VATConvertedAmount, 0) VATConvertedAmount, ISNULL(OT12.VATOriginalAmount, 0) VATOriginalAmount, OT12.ShipDate SShipDate,
			ISNULL(OT12.DiscountPercent, 0) DiscountPercent, ISNULL(OT12.DiscountConvertedAmount, 0) DiscountConvertedAmount, 
			OT12.IsPicking, ISNULL(OT12.DiscountOriginalAmount, 0) DiscountOriginalAmount, ISNULL(OT12.ConvertedSalePrice, 0) ConvertedSalePrice, 
			OT12.Orders, OT12.Description as SDescription, OT12.AdjustQuantity, OT12.InventoryCommonName, OT12.Finish, TT.ReceiveDate,
			OT12.Notes SNotes, OT12.Notes01 SNotes01, OT12.Notes02 SNotes02, OT12.Notes03 SNotes03, OT12.Notes04 SNotes04, 
			OT12.Notes05 SNotes05, OT12.Notes06 SNotes06, OT12.Notes07 SNotes07, OT12.Notes08 SNotes08, OT12.Notes09 SNotes09, 
			OT12.ROrderID, ISNULL(OT12.PurchasePrice, 0) PurchasePrice, ISNULL(OT12.OriginalAmount, 0) OriginalAmount,  dbo.BoDau(OT21.Transport) AS TrieuTranSport
'

SET @sSQL = N'
		FROM OT3001 OT11
		INNER JOIN OT3002 OT12 ON OT12.POrderID = OT11.POrderID AND OT12.DivisionID = OT11.DivisionID
		LEFT JOIN OT2001 OT21 ON OT21.SOrderID = OT12.Notes03 and OT21.DivisionID = OT12.DivisionID
		INNER JOIN (
				SELECT 
					OT01.DivisionID, OT01.TranMonth, OT01.TranYear,
					OT01.OrderDate, OT02.Ana04ID, OT01.ObjectID,
					OT02.Notes01, OT02.Notes03, OT02.Notes04,  
					OT02.InventoryID, OT02.POrderID, OT02.Ana10ID,
					XN.SOrderID, XN.ReceiveDate, SUM(XN.OrderQuantity) OrderQuantity
				FROM OT3001 OT01
				INNER JOIN OT3002 OT02 ON OT02.POrderID = OT01.POrderID AND OT02.DivisionID = OT01.DivisionID
				INNER JOIN (
						SELECT 
							OT31.DivisionID, OT31.TranMonth, OT31.TranYear, OT32.Notes01, OT32.OrderQuantity, 
							OT32.Notes03, OT32.Notes04, OT32.Notes05, OT32.InventoryID, OT31.SOrderID, OT32.ReceiveDate,
							OT32.Ana04ID, OT32.Ana10ID
						FROM OT3001 OT31
						INNER JOIN OT3002 OT32 ON OT32.POrderID = OT31.POrderID AND OT32.DivisionID = OT31.DivisionID
						WHERE ISNULL(OT31.KindVoucherID, 0) = 2  --- Phiếu xác nhận
						' + @sWHEREBG + '
						AND OT32.ReceiveDate IS NOT NULL
				) XN
				ON XN.Notes01 = OT01.POrderID AND XN.InventoryID = OT02.Notes04 AND XN.SOrderID = OT02.Notes03 AND ISNULL(XN.Ana04ID, '''') = ISNULL(OT02.Ana04ID, '''') AND XN.Notes04 = OT02.InventoryID
				WHERE ISNULL(OT01.KindVoucherID, 0) = 1 --- Phiếu lệnh
				AND XN.Ana10ID = OT02.Ana10ID
				GROUP BY 
					OT01.DivisionID, OT01.TranMonth, OT01.TranYear,
					OT01.OrderDate, OT02.Ana04ID, OT01.ObjectID,
					OT02.Notes01, OT02.Notes03, OT02.Notes04,  
					OT02.InventoryID, OT02.POrderID, OT02.Ana10ID,
					XN.SOrderID, XN.ReceiveDate
		) TT -- Thực tế thực hiện thầu phụ OOrderQuantity
		'
	SET @sSQL1 = N'
		ON TT.DivisionID = OT12.DivisionID 
			AND TT.InventoryID = OT12.InventoryID 
			AND ISNULL(TT.Ana04ID, '''') = ISNULL(OT12.Ana04ID, '''') 
			AND TT.ObjectID = OT11.ObjectID
			AND TT.Notes03 = OT12.Notes03 
			AND TT.Notes04 = OT12.Notes04 
			AND TT.TranMonth = OT11.TranMonth
			AND TT.TranYear = OT11.TranYear 
			AND TT.POrderID = OT11.POrderID
			AND TT.Ana10ID = OT12.Ana10ID
		LEFT JOIN AT1304 on AT1304.DivisionID = OT12.DivisionID and AT1304.UnitID = OT12.UnitID
		LEFT JOIN OT1002 Ana01 on Ana01.DivisionID = OT11.DivisionID and Ana01.AnaID = OT11.Ana01ID
		LEFT JOIN OT1002 Ana02 on Ana02.DivisionID = OT11.DivisionID and Ana02.AnaID = OT11.Ana02ID
		LEFT JOIN OT1002 Ana03 on Ana03.DivisionID = OT11.DivisionID and Ana03.AnaID = OT11.Ana03ID
		LEFT JOIN OT1002 Ana04 on Ana04.DivisionID = OT11.DivisionID and Ana04.AnaID = OT11.Ana04ID
		LEFT JOIN OT1002 Ana05 on Ana05.DivisionID = OT11.DivisionID and Ana05.AnaID = OT11.Ana05ID
		LEFT JOIN OT1002 Ana06 on Ana06.DivisionID = OT11.DivisionID and Ana06.AnaID = OT11.Ana06ID
		LEFT JOIN OT1002 Ana07 on Ana07.DivisionID = OT11.DivisionID and Ana07.AnaID = OT11.Ana07ID
		LEFT JOIN OT1002 Ana08 on Ana08.DivisionID = OT11.DivisionID and Ana08.AnaID = OT11.Ana08ID
		LEFT JOIN OT1002 Ana09 on Ana09.DivisionID = OT11.DivisionID and Ana09.AnaID = OT11.Ana09ID
		LEFT JOIN OT1002 Ana10 on Ana10.DivisionID = OT11.DivisionID and Ana10.AnaID = OT11.Ana10ID
		LEFT JOIN AT1011 SAna01 on SAna01.DivisionID = OT12.DivisionID and SAna01.AnaID = OT12.Ana01ID
		LEFT JOIN AT1011 SAna02 on SAna02.DivisionID = OT12.DivisionID and SAna02.AnaID = OT12.Ana02ID
		LEFT JOIN AT1011 SAna03 on SAna03.DivisionID = OT12.DivisionID and SAna03.AnaID = OT12.Ana03ID
		LEFT JOIN AT1011 SAna04 on SAna04.DivisionID = OT12.DivisionID and SAna04.AnaID = OT12.Ana04ID
		LEFT JOIN AT1011 SAna05 on SAna05.DivisionID = OT12.DivisionID and SAna05.AnaID = OT12.Ana05ID
		LEFT JOIN AT1011 SAna06 on SAna06.DivisionID = OT11.DivisionID and SAna06.AnaID = OT11.Ana06ID
		LEFT JOIN AT1011 SAna07 on SAna07.DivisionID = OT11.DivisionID and SAna07.AnaID = OT11.Ana07ID
		LEFT JOIN AT1011 SAna08 on SAna08.DivisionID = OT11.DivisionID and SAna08.AnaID = OT11.Ana08ID
		LEFT JOIN AT1011 SAna09 on SAna09.DivisionID = OT11.DivisionID and SAna09.AnaID = OT11.Ana09ID
		LEFT JOIN AT1011 SAna10 on SAna10.DivisionID = OT11.DivisionID and SAna10.AnaID = OT11.Ana10ID
		LEFT JOIN AT1302 AT1302 on AT1302.DivisionID = OT12.DivisionID and AT1302.InventoryID = OT12.InventoryID
		WHERE OT11.DivisionID = '''+@DivisionID+'''
		AND ISNULL(OT11.ObjectID, '''') BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + '''
		AND ISNULL(OT11.PriceListID, '''') BETWEEN ''' + @FromPriceListID + ''' AND ''' + @ToPriceListID + '''
		AND ISNULL(OT12.Ana04ID, '''') BETWEEN ''' + @FromGoodsName + ''' AND ''' + @ToGoodsName + '''
		AND ISNULL(OT11.KindVoucherID, 0) = 1
		AND ISNULL(dbo.BoDau(OT21.Transport),''%'') LIKE N''%'+@TenPT+'%''
	'

--PRINT(@sSelect)
--PRINT(@sSQL)
--PRINT(@sSQL1)
--PRINT(@sOrder)

EXEC(@sSelect + @sSQL+ @sSQL1 + @sOrder)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


