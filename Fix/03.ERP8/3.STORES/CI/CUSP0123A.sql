IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CUSP0123A]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CUSP0123A]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In báo cáo tổng hợp doanh thu - Số kế hoạch, Bảng kê chi tiết
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 12/02/2015 by Trí Thiện
---- Modified on 01/09/2020 by Nhựt Trường: Thêm trường VoucherNo và OrderDate từ OT3004.
---- Modified on 21/09/2020 by Nhựt Trường: Thay đổi cách trường VoucherNo và OrderDate từ OT3004 thông qua OT3005.
---- Modified on 06/07/2023 by Đình Định: BBL - Sửa lại cách lấy Số CTQT & PTVC.
---- Modified on 13/07/2023 by Nhựt Trường: [2023/07/IS/0152] - Lấy O1.VoucherDate AS SettleDate thay GETDATE() AS SettleDate.
---- Modified on 06/09/2023 by Kiều Nga: [2023/09/IS/0005] - Xử lý điều chỉnh lại cột ngày quyết toán chỉ lấy lên ngày không lấy thời gian.
---- 
-- <Example>
--- EXEC CUSP0123A 'BBL', 'ASOFTADMIN','2015-02-01 00:00:00.000', '2015-02-28 00:00:00.000', 'E04','E04', 'KH014.0081', 'KH014.0081'


CREATE PROCEDURE CUSP0123A
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,	
	@FromAna01ID VARCHAR(50),
	@ToAna01ID VARCHAR(50),
	@FromObjectID NVARCHAR(50),
	@ToObjectID NVARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR(MAX), @sWhere NVARCHAR(1000) = ''

SET @sSQL = '
SELECT 
	X.DivisionID, X.SOrderID, X.OrderID, X.ObjectID, A22.ObjectName, A22.TradeName, X.Transport, CONVERT(DATE,X.ReceiveDate) ReceiveDate, 
	X.Ana01ID, A1.AnaName Ana01Name, X.Ana04ID, A4.AnaName Ana04Name, 
	X.Ana07ID, A7.AnaName Ana07Name, X.Ana08ID, A8.AnaName Ana08Name, 
	X.Ana10ID, A10.AnaName Ana10Name, X.InventoryID, A32.InventoryName, X.UnitID, A34.UnitName,
	X.OriginalQuantity, X.OrderQuantity, 
	X.SalePrice, X.PurchasePrice, X.TotalAmount, X.TotalOriginalAmount,
	X.SettleVoucherNo, CONVERT(DATE,X.SettleDate) SettleDate, X.ShipID, X.ShipName
FROM
(
	SELECT
		A.DivisionID, A.SOrderID, A.POrderID OrderID, A.ObjectID, A.ReceiveDate, A.UnitID,
		A.Ana01ID, A.Ana04ID, A.Ana07ID, A.Ana08ID, A.Ana10ID, A.InventoryID, A.Transport,
		0 OriginalQuantity, ISNULL(A.OrderQuantity, 0) OrderQuantity,
		ISNULL(A.PurchasePrice, 0) SalePrice, ISNULL(A.PurchasePrice, 0) PurchasePrice, A.TotalAmount, 
		ISNULL(A.OrderQuantity, 0) * ISNULL(A.PurchasePrice, 0) TotalOriginalAmount,
		SettleVoucherNo, SettleDate, '''' AS ShipID, '''' AS ShipName
	FROM
	(
		SELECT O1.DivisionID, O2.POrderID, O1.ObjectID, O1.Transport, O2.ReceiveDate, O2.Ana01ID, O2.OrderQuantity, 
			   O2.InventoryID, O2.Ana04ID, O2.Ana10ID, O2.Ana07ID, O2.Ana08ID, O1.SOrderID, O2.UnitID,
			   O2.PurchasePrice, O2.OrderQuantity * O2.PurchasePrice TotalAmount,
			   ISNULL(O4.VoucherNo, '''') AS SettleVoucherNo, O4.OrderDate AS SettleDate
		FROM OT3001 O1 WITH (NOLOCK)
		LEFT JOIN OT3002 O2 WITH (NOLOCK) ON O2.DivisionID = O1.DivisionID AND O2.POrderID = O1.POrderID
		LEFT JOIN OT3005 O5 WITH (NOLOCK) ON ISNULL(O5.RefTransactionID, '''') = ISNULL(O2.TransactionID, '''')
		LEFT JOIN OT3004 O4 WITH (NOLOCK) ON ISNULL(O4.DivisionID, '''') = ISNULL(O5.DivisionID, '''') AND ISNULL(O4.OrderID, '''') = ISNULL(O5.OrderID, '''')
		WHERE O2.DivisionID = '''+@DivisionID+'''
			AND ISNULL(O1.KindVoucherID, 0) = 2
			AND ISNULL(O2.Notes01, '''') = ''''
			AND O2.ReceiveDate IS NOT NULL
			AND CONVERT(VARCHAR, O2.ReceiveDate, 112) BETWEEN '''+CONVERT(VARCHAR, @FromDate, 112)+''' AND '''+CONVERT(VARCHAR, @ToDate, 112)+'''
			AND ISNULL(O2.Ana01ID,'''') <> ''''
			AND ISNULL(O2.Ana01ID,'''') BETWEEN '''+@FromAna01ID+''' AND '''+@ToAna01ID+'''
			AND ISNULL(O1.ObjectID, '''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
	)A
	
	UNION ALL
	
	SELECT O1.DivisionID, O1.VoucherNo AS SOrderID, O1.VoucherNo OrderID, O1.ObjectID, CONVERT(DATE,O1.VoucherDate) ReceiveDate, O2.UnitID,
		   O2.Ana01ID, O2.Ana04ID, O2.Ana07ID, O2.Ana08ID, O2.Ana10ID, O2.InventoryID, O3.ObjectName AS Transport,
		   ISNULL(OriginalQuantity, 0) OriginalQuantity, ISNULL(OriginalQuantity, 0) OrderQuantity, 
		   ISNULL(O2.ConvertedPrice, 0) SalePrice, 0 PurchasePrice, 
		   ISNULL(OriginalAmount, 0) TotalAmount, ISNULL(OriginalAmount, 0) TotalOriginalAmount,
		   ISNULL(O1.VoucherNo, '''') AS SettleVoucherNo, O1.VoucherDate AS SettleDate, O1.ShipID, O3.ObjectName AS ShipName
	FROM OT2010 O1 WITH (NOLOCK)
	LEFT JOIN OT2011 O2 WITH (NOLOCK) ON O2.DivisionID = O1.DivisionID AND O2.SOrderID = O1.SOrderID
	LEFT JOIN AT1202 O3 WITH (NOLOCK) ON O3.DivisionID IN ('''+@DivisionID+''',''@@@'') AND O3.ObjectID = O1.ShipID
	WHERE O1.DivisionID = '''+@DivisionID+'''
		AND CONVERT(VARCHAR, O1.VoucherDate, 112) BETWEEN '''+CONVERT(VARCHAR, @FromDate, 112)+''' AND '''+CONVERT(VARCHAR, @ToDate, 112)+'''
		AND ISNULL(O2.Ana01ID,'''') <> ''''
		AND ISNULL(O2.Ana01ID,'''') BETWEEN '''+@FromAna01ID+''' AND '''+@ToAna01ID+'''
		AND ISNULL(O1.ObjectID, '''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
) X
LEFT JOIN AT1011 A1	 WITH (NOLOCK) ON X.Ana01ID = A1.AnaID AND A1.AnaTypeID = ''A01''
LEFT JOIN AT1011 A4	 WITH (NOLOCK) ON X.Ana04ID = A4.AnaID AND A4.AnaTypeID = ''A04''
LEFT JOIN AT1011 A7	 WITH (NOLOCK) ON X.Ana07ID = A7.AnaID AND A7.AnaTypeID = ''A07''
LEFT JOIN AT1011 A8	 WITH (NOLOCK) ON X.Ana08ID = A8.AnaID AND A8.AnaTypeID = ''A08''
LEFT JOIN AT1011 A10 WITH (NOLOCK) ON X.Ana10ID = A10.AnaID AND A10.AnaTypeID = ''A10''
LEFT JOIN AT1302 A32 WITH (NOLOCK) ON X.InventoryID= A32.InventoryID
LEFT JOIN AT1202 A22 WITH (NOLOCK) ON X.ObjectID = A22.ObjectID
LEFT JOIN AT1304 A34 WITH (NOLOCK) ON X.UnitID = A34.UnitID
'

PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
