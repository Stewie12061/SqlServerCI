IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0122]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0122]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Tra ra du lieu NPL từ định mức cho MH yêu cầu xuất kho (WF0096) khi kế thừa đơn hàng bán -- AN PHÁT (CustomizeIndex = 54)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created on 09/08/2016 by Tiểu Mai
---- Modified by Tiểu Mai on 16/09/2016: Bổ sung trường O02.SOrderIDRecognition
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by ... on ...
---- EXEC 

CREATE PROCEDURE [dbo].[WP0122]      
( 
 @DivisionID AS NVARCHAR(50),
 @ListSOrderID AS NVARCHAR(500),
 @XML AS XML
) 
AS 
BEGIN 

  SELECT X.Data.query('TransactionID').value('.', 'NVARCHAR(50)') AS TransactionID,
	X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') AS InventoryID,
	X.Data.query('UnitID').value('.', 'NVARCHAR(50)') AS UnitID,
	X.Data.query('OrderQuantity').value('.', 'decimal(28,8)') AS OrderQuantity,
	X.Data.query('SOActualQuantity').value('.', 'decimal(28,8)') AS SOActualQuantity,  
	X.Data.query('S01ID').value('.', 'NVARCHAR(50)') AS S01ID,
	X.Data.query('S02ID').value('.', 'NVARCHAR(50)') AS S02ID,
	X.Data.query('S03ID').value('.', 'NVARCHAR(50)') AS S03ID,
	X.Data.query('S04ID').value('.', 'NVARCHAR(50)') AS S04ID,
	X.Data.query('S05ID').value('.', 'NVARCHAR(50)') AS S05ID,
	X.Data.query('S06ID').value('.', 'NVARCHAR(50)') AS S06ID,
	X.Data.query('S07ID').value('.', 'NVARCHAR(50)') AS S07ID,
	X.Data.query('S08ID').value('.', 'NVARCHAR(50)') AS S08ID,
	X.Data.query('S09ID').value('.', 'NVARCHAR(50)') AS S09ID,
	X.Data.query('S10ID').value('.', 'NVARCHAR(50)') AS S10ID,
	X.Data.query('S11ID').value('.', 'NVARCHAR(50)') AS S11ID,
	X.Data.query('S12ID').value('.', 'NVARCHAR(50)') AS S12ID,
	X.Data.query('S13ID').value('.', 'NVARCHAR(50)') AS S13ID,
	X.Data.query('S14ID').value('.', 'NVARCHAR(50)') AS S14ID,
	X.Data.query('S15ID').value('.', 'NVARCHAR(50)') AS S15ID,
	X.Data.query('S16ID').value('.', 'NVARCHAR(50)') AS S16ID,
	X.Data.query('S17ID').value('.', 'NVARCHAR(50)') AS S17ID,
	X.Data.query('S18ID').value('.', 'NVARCHAR(50)') AS S18ID,
	X.Data.query('S19ID').value('.', 'NVARCHAR(50)') AS S19ID,
	X.Data.query('S20ID').value('.', 'NVARCHAR(50)') AS S20ID
   
 INTO #Data
 FROM @XML.nodes('//Data') AS X (Data)
 
DECLARE @sSQL AS NVARCHAR(MAX) = '', @sSQL1 AS NVARCHAR(MAX) = ''

SET @sSQL = '
--select * from #Data

SELECT CONVERT(TINYINT,0) IsSelected, O02.[Description], O02.SOrderID, O02.RefInfor,
      MAX(O02.Ana01ID) AS Ana01ID, MAX(O02.Ana02ID) AS Ana02ID, MAX(O02.Ana03ID) AS Ana03ID, MAX(O02.Ana04ID) AS Ana04ID, MAX(O02.Ana05ID) AS Ana05ID, 
      O02.RefSOrderID,
      MAX(nvarchar01) AS nvarchar01, MAX(nvarchar02) AS nvarchar02, MAX(nvarchar03) AS nvarchar03, MAX(nvarchar04) AS nvarchar04, MAX(nvarchar05) AS nvarchar05,
      MAX(nvarchar06) AS nvarchar06, MAX(nvarchar07) AS nvarchar07, MAX(nvarchar08) AS nvarchar08, MAX(nvarchar09) AS nvarchar09, MAX(nvarchar10) AS nvarchar10,
      M37.DS01ID as S01ID, M37.DS02ID as S02ID, M37.DS03ID as S03ID, M37.DS04ID as S04ID, M37.DS05ID as S05ID, M37.DS06ID as S06ID, M37.DS07ID as S07ID, M37.DS08ID as S08ID, M37.DS09ID as S09ID, M37.DS10ID as S10ID,
      M37.DS11ID as S11ID, M37.DS12ID as S12ID, M37.DS13ID as S13ID, M37.DS14ID as S14ID, M37.DS15ID as S15ID, M37.DS16ID as S16ID, M37.DS17ID as S17ID, M37.DS18ID as S18ID, M37.DS19ID as S19ID, M37.DS20ID as S20ID,
      M37.MaterialID, A32.InventoryName AS MaterialName, M37.MaterialUnitID, SUM(ISNULL(M37.QuantityUnit,0)* ISNULL(DATA.SOActualQuantity,0)) as MaterialQuantity, M37.ExpenseID, DATA.SOActualQuantity, O02.SOrderIDRecognition
'

SET @sSQL1 = '
FROM #Data DATA
 LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = '''+@DivisionID+''' AND O02.TransactionID = DATA.TransactionID
 LEFT JOIN OT2001 O01 WITH (NOLOCK) ON O01.DivisionID = O02.DivisionID AND O01.SOrderID = O02.SOrderID
 LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O02.DivisionID = O99.DivisionID AND O02.SOrderID = O99.VoucherID AND O02.TransactionID = O99.TransactionID
										AND ISNULL(O99.S01ID,'''') = ISNULL(DATA.S01ID,'''')
										AND ISNULL(O99.S02ID,'''') = ISNULL(DATA.S02ID,'''')
 										AND ISNULL(O99.S03ID,'''') = ISNULL(DATA.S03ID,'''')
										AND ISNULL(O99.S04ID,'''') = ISNULL(DATA.S04ID,'''')
										AND ISNULL(O99.S05ID,'''') = ISNULL(DATA.S05ID,'''')
										AND ISNULL(O99.S06ID,'''') = ISNULL(DATA.S06ID,'''')
										AND ISNULL(O99.S07ID,'''') = ISNULL(DATA.S07ID,'''')
										AND ISNULL(O99.S08ID,'''') = ISNULL(DATA.S08ID,'''')
										AND ISNULL(O99.S09ID,'''') = ISNULL(DATA.S09ID,'''')
										AND ISNULL(O99.S10ID,'''') = ISNULL(DATA.S10ID,'''')
										AND ISNULL(O99.S11ID,'''') = ISNULL(DATA.S11ID,'''')
										AND ISNULL(O99.S12ID,'''') = ISNULL(DATA.S12ID,'''')      
 										AND ISNULL(O99.S13ID,'''') = ISNULL(DATA.S13ID,'''')
										AND ISNULL(O99.S14ID,'''') = ISNULL(DATA.S14ID,'''')
										AND ISNULL(O99.S15ID,'''') = ISNULL(DATA.S15ID,'''')
										AND ISNULL(O99.S16ID,'''') = ISNULL(DATA.S16ID,'''')
										AND ISNULL(O99.S17ID,'''') = ISNULL(DATA.S17ID,'''')
										AND ISNULL(O99.S18ID,'''') = ISNULL(DATA.S18ID,'''')
										AND ISNULL(O99.S19ID,'''') = ISNULL(DATA.S19ID,'''')
										AND ISNULL(O99.S20ID,'''') = ISNULL(DATA.S20ID,'''')
LEFT JOIN MT0136 M36 WITH (NOLOCK) ON M36.DivisionID = O02.DivisionID AND M36.ApportionID = O02.InheritVoucherID AND M36.TransactionID = O02.InheritTransactionID AND O02.InheritTableID = ''MT0136''							
LEFT JOIN MT0137 M37 WITH (NOLOCK) ON M37.DivisionID = M36.DivisionID AND M37.ReTransactionID = M36.TransactionID AND M37.ProductID = M36.ProductID
LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (''@@@'', M37.DivisionID) AND A32.InventoryID = M37.MaterialID

WHERE O01.OrderType = 0 --and O02.SOrderID IN ('''+@ListSOrderID+''')
      AND O02.DivisionID = '''+@DivisionID+'''
	  AND M37.ExpenseID = ''COST001''
GROUP BY O02.[Description], O02.SOrderID, O02.RefInfor,
      O02.RefSOrderID,
      M37.DS01ID, M37.DS02ID, M37.DS03ID, M37.DS04ID, M37.DS05ID, M37.DS06ID, M37.DS07ID, M37.DS08ID, M37.DS09ID, M37.DS10ID,
      M37.DS11ID, M37.DS12ID, M37.DS13ID, M37.DS14ID, M37.DS15ID, M37.DS16ID, M37.DS17ID, M37.DS18ID, M37.DS19ID, M37.DS20ID,
      M37.MaterialID, A32.InventoryName, M37.MaterialUnitID, M37.ExpenseID, DATA.SOActualQuantity, O02.SOrderIDRecognition
ORDER BY O02.SOrderID 

DROP TABLE #Data
'

EXEC (@sSQL+@sSQL1)
--PRINT @sSQL
--PRINT @sSQL1
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
