IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0048]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0048]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- IN BÁO CÁO ĐẶC THÙ "BÁO CÁO LÃI LỖ ĐƠN HÀNG" [Customize Index: 45 - ABA)
-- <History>
---- Create on 05/05/2015 by Lê Thị Hạnh 
---- Modified on 08/01/2015 by Quoc Tuan sua them PNotes03 
---- Modified on ... by 
---- Modified by Tiểu Mai on 23/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*
 OP0048 @DivisionID = 'vg', @FromPeriod = 201409, @ToPeriod = 201510, @FromDate = '2014-09-01',
 @ToDate = '2014-09-15', @TimeMode = 0, @FromObjectID = 'AC002', @ToObjectID = 'YKL001', @FromSupplyID = 'AC002',
 @ToSupplyID = 'YKL001', @FromAna02ID = '', @ToAna02ID = ''
 */

CREATE PROCEDURE [dbo].[OP0048] 	
	@DivisionID NVARCHAR(50),
	@FromPeriod INT,
	@ToPeriod INT,	
	@FromDate DATETIME,
	@ToDate DATETIME,
	@TimeMode TINYINT,
	@ToObjectID NVARCHAR(50),
	@FromObjectID NVARCHAR(50),
	@FromSupplyID NVARCHAR(50),
	@ToSupplyID NVARCHAR(50),
	@FromAna02ID NVARCHAR(50),
	@ToAna02ID NVARCHAR(50),
	@FromAna01ID NVARCHAR(50),
	@ToAna01ID NVARCHAR(50)	
AS
DECLARE @sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sWHERE NVARCHAR(MAX) 
IF LTRIM(STR(@TimeMode)) = 1	
SET @sWHERE = 'AND CONVERT(VARCHAR(10),OT21.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '

IF LTRIM(STR(@TimeMode)) = 0	
SET @sWHERE = 'AND (OT21.TranYear*100 + OT21.TranMonth) BETWEEN '+LTRIM(@FromPeriod)+' AND '+LTRIM(@ToPeriod)+' '
SET @sSQL1 = '
SELECT OT21.IsConfirm, OT21.VoucherNo AS SOVoucherNo, OT21.OrderDate AS SOVoucherDate, 
	   OT21.ObjectID AS SOObjectID, AT12.ObjectName AS SOObjectName, OT21.DeliveryAddress,
       OT31.VoucherNo AS POVoucherNo, OT31.OrderDate AS POVoucherDate, 
       OT31.ObjectID AS POObjectID, AT02.ObjectName AS POObjectName,
       OT22.Ana02ID, A02.AnaName AS Ana02Name, OT22.InventoryID, A13.InventoryName,
       OT22.Ana01ID, OT22.Ana03ID, OT22.Ana04ID, OT22.Ana05ID, OT22.Ana06ID, OT22.Ana07ID, OT22.Ana08ID, 
       OT22.Ana09ID, OT22.Ana10ID, 
       CASE WHEN ISNUMERIC(OT22.Varchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar10) END AS KmNumber,
       CASE WHEN ISNUMERIC(OT22.nvarchar03) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.nvarchar03) END AS Notes,    --Doanh thu thực tế
       CASE WHEN ISNUMERIC(OT22.nvarchar01) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.nvarchar01) END AS Notes01,  --Doanh thu kế hoạch
	   CASE WHEN ISNUMERIC(OT22.Varchar02) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar02) END AS Notes02,  --Lương tài xế
       CASE WHEN ISNUMERIC(OT22.Varchar11) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar11) END AS Notes03,  --Chi phí xăng dầu
       CASE WHEN ISNUMERIC(OT22.nvarchar09) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.nvarchar09) END AS Notes04,  --Chi phí cầu đường
       CASE WHEN ISNUMERIC(OT22.nvarchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.nvarchar10) END AS Notes05,  --Phí kiểm dịch
       CASE WHEN ISNUMERIC(OT22.Varchar01) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar01) END AS Notes06,  --Chi phí khác
       CASE WHEN ISNUMERIC(OT22.Varchar12) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar12) END AS Notes07,  --Chi phí đăng kiểm, cầu đường
       CASE WHEN ISNUMERIC(OT22.Varchar13) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar13) END AS Notes08,  --Chi phí bảo hiểm vật chất, TNDS
       CASE WHEN ISNUMERIC(OT22.Varchar05) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar05) END AS Notes09,  --Outsource
       CASE WHEN ISNUMERIC(OT22.Varchar06) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar06) END AS Notes10,  --Phí rớt điểm trả khay
       CASE WHEN ISNUMERIC(OT22.Varchar04) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar04) END AS Notes11,  --Khấu trừ
       CASE WHEN ISNUMERIC(OT22.Varchar07) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar07) END AS Notes12,  --Phí bốc xếp
       CASE WHEN ISNUMERIC(OT22.Varchar09) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar09) END AS Notes13,  --Nơi giao hàng
       CASE WHEN ISNUMERIC(OT22.Varchar08) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar08) END AS Notes14,  --Giá rớt điểm trả khay
       CASE WHEN ISNUMERIC(OT22.Varchar03) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar03) END AS Notes15,  --Số rớt điểm trả khay
       CASE WHEN ISNUMERIC(OT22.nvarchar08) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.nvarchar08) END AS Notes16,  --Chi phí thực tế
       CASE WHEN ISNUMERIC(OT22.nvarchar02) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.nvarchar02) END AS Notes17,  --Chi phí kế hoạch
       CASE WHEN ISNUMERIC(OT22.Varchar14) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar14) END AS Notes18,  --Khấu hao
       CASE WHEN ISNUMERIC(OT22.Varchar15) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT22.Varchar15) END AS Notes19,  --Lãi vay
       ISNULL(OT22.OrderQuantity,0) AS SOQuantity, 
       ISNULL(OT22.SalePrice,0) AS SalesPrice, 
       ISNULL(OT22.ConvertedQuantity,0) AS SOConvertedQuantity, 
       ISNULL(OT22.ConvertedSalePrice,0) AS SOSalePrice, 
	   ISNULL(OT22.ConvertedAmount,0) AS SOConvertedAmount, 
       ISNULL(OT32.OrderQuantity,0) AS POQuantity, 
       ISNULL(OT32.PurchasePrice,0) AS PurchasePrice, 
       ISNULL(OT32.ConvertedQuantity,0) AS POConvertedQuantity,
       ISNULL(OT32.ConvertedSalePrice,0) AS POPurchasePrice
	   '

SET @sSQL2 = 'FROM OT2001 OT21 WITH (NOLOCK)
INNER JOIN OT2002 OT22 WITH (NOLOCK) ON OT22.DivisionID = OT21.DivisionID AND OT22.SOrderID = OT21.SOrderID 
LEFT JOIN OT3001 OT31 WITH (NOLOCK) ON OT31.DivisionID = OT22.DivisionID AND OT31.POrderID = OT22.InheritVoucherID AND OT22.InheritTableID = ''OT3001''
LEFT JOIN OT3002 OT32 WITH (NOLOCK) ON OT32.DivisionID = OT22.DivisionID AND OT31.POrderID = OT22.InheritVoucherID AND OT32.TransactionID = OT22.InheritTransactionID AND OT22.InheritTableID = ''OT3001''
LEFT JOIN AT1202 AT12 WITH (NOLOCK) ON AT12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT12.ObjectID = OT21.ObjectID
LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT02.ObjectID = OT31.ObjectID
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaID = OT22.Ana02ID AND A02.AnaTypeID =''A02''
LEFT JOIN AT1302 A13 WITH (NOLOCK) ON A13.DivisionID IN (''@@@'', OT22.DivisionID) AND A13.InventoryID = OT22.InventoryID
WHERE OT21.DivisionID = '''+@DivisionID+''' AND OT21.OrderType = 0 
	  AND ISNULL(OT21.ObjectID,'''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
	  AND ISNULL(OT22.Ana02ID,'''') BETWEEN '''+@FromAna02ID+''' AND '''+@ToAna02ID+'''
	  AND ISNULL(OT22.Ana01ID,'''') BETWEEN '''+@FromAna01ID+''' AND '''+@ToAna01ID+'''
	  AND (CASE WHEN OT31.ObjectID IS NULL THEN 1 ELSE (CASE WHEN OT31.ObjectID BETWEEN '''+@FromSupplyID+''' AND '''+@ToSupplyID+''' THEN 1 ELSE 0 END) END) = 1	  
	  '+@sWHERE+'
ORDER BY OT21.OrderDate, OT21.VoucherNo, OT22.Orders'

PRINT (@sSQL1)
PRINT (@sSQL2)
EXEC (@sSQL1 + @sSQL2)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
