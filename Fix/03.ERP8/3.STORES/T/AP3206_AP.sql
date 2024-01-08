IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3206_AP]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3206_AP]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load detail cho form ke thua nhieu don hang ban o phieu nhap kho (Customize An Phát)
---- Created by Tieu Mai on 25/12/2015
---- Modified by Tiểu Mai on 29/01/2016: Sửa lại cho load tất cả NPL, không loại trừ các dòng đã kế thừa.
---- Modified by Tiểu Mai on 03/06/2016: Bổ sung WITH(NOLOCK)
---- Modified by Tiểu Mai on 17/06/2016: Sum số lượng NPL theo yêu cầu của An Phát
---- Modified by Bảo Thy on 18/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
-- <Example>
---- EXEC AP3206_AP 'HT', '', '', 1,'%'
CREATE PROCEDURE [dbo].[AP3206_AP] 
    @DivisionID NVARCHAR(50),
    @lstSOrderID NVARCHAR(MAX),
    -- Thêm mới   : ''
    -- Hiệu chỉnh : Số chứng từ đang sửa
    @VoucherID NVARCHAR(50), 
    @ConnID NVARCHAR(100),
    @InventoryTypeID NVARCHAR(50)
AS

DECLARE 
    @sSQL1 NVARCHAR(MAX),
    @sSQL2 NVARCHAR(MAX),
    @Customize AS INT,
	@sWHERE AS NVARCHAR(4000)
SET @sWHERE = N''
DECLARE	@TempTable table(CustomerName  int,IsExcel  int)

INSERT @TempTable
EXEC	[dbo].[AP4444]

SET @Customize = (SELECT TOP 1 CustomerName FROM @TempTable)


SET @DivisionID = ISNULL(@DivisionID, '')
SET @lstSOrderID = ISNULL(@lstSOrderID, '')
SET @VoucherID = ISNULL(@VoucherID, '')
SET @ConnID = ISNULL(@ConnID, '')

SET @lstSOrderID = REPLACE(@lstSOrderID, ',', ''',''')

SET @sSQL1 = '
SELECT 
	O02.SOrderID AS OrderID,
    --M37.TransactionID, 
    O02.Parameter01,
	O02.Parameter02, O02.Parameter03, O02.Parameter04,O02.Parameter05,
	O02.Ana01ID, O02.Ana02ID, O02.Ana03ID, O02.Ana04ID, O02.Ana05ID, O02.Ana06ID, O02.Ana07ID, 
	O02.Ana08ID, O02.Ana09ID, O02.Ana10ID,
	O01.DivisionID, 
	O01.TranMonth, 
	O01.TranYear, 
	O01.SOrderID, 
	O01.OrderStatus, 
	O01.Duedate, 
	O01.Shipdate,
	O01.PaymentTermID,
	AT1208.Duedays,
	ROW_NUMBER() OVER(ORDER BY M37.MaterialID DESC) AS Orders,
	M37.MaterialID as InventoryID, A32.InventoryName, M37.MaterialUnitID as UnitID,
	M37.DS01ID as S01ID, M37.DS02ID as S02ID, M37.DS03ID as S03ID, M37.DS04ID as S04ID, M37.DS05ID as S05ID, 
	M37.DS06ID as S06ID, M37.DS07ID as S07ID, M37.DS08ID as S08ID, M37.DS09ID as S09ID, M37.DS10ID as S10ID,
	M37.DS11ID as S11ID, M37.DS12ID as S12ID, M37.DS13ID as S13ID, M37.DS14ID as S14ID, M37.DS15ID as S15ID, 
	M37.DS16ID as S16ID, M37.DS17ID as S17ID, M37.DS18ID as S18ID, M37.DS19ID as S19ID, M37.DS20ID as S20ID,

	SUM(CASE WHEN Isnull(M37.MaterialQuantity,0) = 0 THEN 0 ELSE ISNULL(O02.OrderQuantity, 0)*Isnull(M37.QuantityUnit,0) END) AS ActualQuantity,
	SUM(CASE WHEN Isnull(M37.MaterialQuantity,0) = 0 THEN 0 ELSE ISNULL(O02.ConvertedQuantity, 0)*Isnull(M37.QuantityUnit,0) END) AS ActualConvertedQuantity,
	0 as OriginalAmount,
	0 as ConvertedAmount,
	0 as UnitPrice,
	ISNULL(O02.SOrderIDRecognition,O02.SOrderID) as SOrderIDRecognition
'
SET @sSQL2 = '
FROM OT2002 O02 WITH (NOLOCK)
	LEFT JOIN OT2001 O01 WITH (NOLOCK) ON O01.DivisionID = O02.DivisionID AND O01.SOrderID = O02.SOrderID
	LEFT JOIN MT0136 M36 WITH (NOLOCK) ON M36.DivisionID = O02.DivisionID AND M36.ApportionID = O02.InheritVoucherID AND M36.TransactionID = O02.InheritTransactionID
	LEFT JOIN MT0137 M37 WITH (NOLOCK) ON M37.DivisionID = M36.DivisionID AND M37.ProductID = M36.ProductID AND M37.ReTransactionID = M36.TransactionID
	LEFT JOIN AT1302 A31 WITH (NOLOCK) ON A31.DivisionID IN (O02.DivisionID,''@@@'') AND A31.InventoryID = O02.InventoryID
	LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (M37.DivisionID,''@@@'') AND A32.InventoryID = M37.MaterialID
	LEFT JOIN AT1208 WITH (NOLOCK) ON AT1208.PaymentTermID = O01.PaymentTermID
'+ '
WHERE O02.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(''' + @DivisionID + '''))
    AND O02.SOrderID in (''' + @lstSOrderID + ''')
    AND ISNULL(A32.InventoryTypeID, '''') LIKE '''+@InventoryTypeID+'''
    --AND (CASE WHEN A32.IsDiscount = 1 THEN ISNULL(O02.ConvertedQuantity, 0)*Isnull(M37.MaterialQuantity,0)/ISNULL(M36.ProductQuantity,1) ELSE ISNULL(O02.OrderQuantity, 0)*Isnull(M37.MaterialQuantity,0)/ISNULL(M36.ProductQuantity,1) END ) > 0
    '+@sWHERE+'
GROUP BY 
    O02.SOrderID,
    --M37.TransactionID, 
    O02.Parameter01,
	O02.Parameter02, O02.Parameter03, O02.Parameter04,O02.Parameter05,
	O02.Ana01ID, O02.Ana02ID, O02.Ana03ID, O02.Ana04ID, O02.Ana05ID, O02.Ana06ID, O02.Ana07ID, 
	O02.Ana08ID, O02.Ana09ID, O02.Ana10ID,
	O01.DivisionID, 
	O01.TranMonth, 
	O01.TranYear, 
	O01.SOrderID, 
	O01.OrderStatus, 
	O01.Duedate, 
	O01.Shipdate,
	O01.PaymentTermID,
	AT1208.Duedays,
	M37.MaterialID, A32.InventoryName, M37.MaterialUnitID,
	M37.DS01ID, M37.DS02ID, M37.DS03ID, M37.DS04ID, M37.DS05ID, 
	M37.DS06ID, M37.DS07ID, M37.DS08ID, M37.DS09ID, M37.DS10ID,
	M37.DS11ID, M37.DS12ID, M37.DS13ID, M37.DS14ID, M37.DS15ID, 
	M37.DS16ID, M37.DS17ID, M37.DS18ID, M37.DS19ID, M37.DS20ID,O02.SOrderIDRecognition
--ORDER BY M37.MaterialID
' 

--PRINT @sSQL1 
--PRINT @sSQL2

IF NOT EXISTS(SELECT TOP 1 1 FROM sysObjects WHERE XType = 'V' AND Name = 'AV3206' + @ConnID)
    EXEC('CREATE VIEW AV3206' + @ConnID + ' -- Tạo bởi AP3206_AP
            AS ' + @sSQL1 + @sSQL2)
ELSE 
    EXEC('ALTER VIEW AV3206' + @ConnID + ' -- Tạo bởi AP3206_AP
            AS ' + @sSQL1 + @sSQL2)

IF NOT EXISTS(SELECT TOP 1 1 FROM sysObjects WHERE XType = 'V' AND Name = 'AV3206')
    EXEC('CREATE VIEW AV3206 -- Tạo bởi AP3206_AP
            AS ' + @sSQL1 + @sSQL2)
ELSE 
    EXEC('ALTER VIEW AV3206 -- Tạo bởi AP3206_AP
            AS ' + @sSQL1 + @sSQL2)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
