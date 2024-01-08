﻿IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0049]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0049]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Tiểu Mai on 22/12/2015
---- Purpose: Kế thừa đơn hàng sản xuất có định mức NVL
---- Modified by Tiểu Mai on 18/02/2016: Bổ sung trường M37.TransactionID
---- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Kim Vũ on 13/06/2016: Fix lỗi List TransactionID quá 500 kí tự
---- Modified by Tiểu Mai on 17/06/2016: Sum số lượng NPL theo yêu cầu của An Phát
---- Modified by Tiểu Mai on 30/08/2016: Bỏ RefInfo
---- Modified by Bảo Thy on 08/09/2016: Bổ sung SOrderIDRecognition
---- Modified by Tiểu Mai on 23/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung

CREATE PROCEDURE [dbo].[OP0049] 
    @DivisionID NVARCHAR(50), 
    @ListSOrderID NVARCHAR (4000),
    @ListTransactionID NVARCHAR(MAX),
    @InventoryTypeID NVARCHAR(50)
AS
DECLARE 
    @sSQL NVARCHAR(MAX),
    @sSQL1 NVARCHAR(MAX),
    @sSQL2 NVARCHAR(MAX),
	@sSQLWhere NVARCHAR(MAX),
	@sSQLWhere1 NVARCHAR(MAX)

SET @sSQL = '    
SELECT CONVERT(TINYINT,0) IsSelected,OT2002.Description, OT2002.SOrderID, --OT2002.RefInfor,
      MAX(OT2002.Ana01ID) AS Ana01ID, MAX(OT2002.Ana02ID) AS Ana02ID, MAX(OT2002.Ana03ID) AS Ana03ID, MAX(OT2002.Ana04ID) AS Ana04ID, MAX(OT2002.Ana05ID) AS Ana05ID, 
      OT2002.RefSOrderID, OT2002.SOrderIDRecognition,
      MAX(nvarchar01) AS nvarchar01, MAX(nvarchar02) AS nvarchar02, MAX(nvarchar03) AS nvarchar03, MAX(nvarchar04) AS nvarchar04, MAX(nvarchar05) AS nvarchar05,
      MAX(nvarchar06) AS nvarchar06, MAX(nvarchar07) AS nvarchar07, MAX(nvarchar08) AS nvarchar08, MAX(nvarchar09) AS nvarchar09, MAX(nvarchar10) AS nvarchar10,
      M37.DS01ID as S01ID, M37.DS02ID as S02ID, M37.DS03ID as S03ID, M37.DS04ID as S04ID, M37.DS05ID as S05ID, M37.DS06ID as S06ID, M37.DS07ID as S07ID, M37.DS08ID as S08ID, M37.DS09ID as S09ID, M37.DS10ID as S10ID,
      M37.DS11ID as S11ID, M37.DS12ID as S12ID, M37.DS13ID as S13ID, M37.DS14ID as S14ID, M37.DS15ID as S15ID, M37.DS16ID as S16ID, M37.DS17ID as S17ID, M37.DS18ID as S18ID, M37.DS19ID as S19ID, M37.DS20ID as S20ID,
      M37.MaterialID, A02.InventoryName AS MaterialName, M37.MaterialUnitID, SUM(ISNULL(M37.QuantityUnit,0)* ISNULL(EndQuantity,0)) as MaterialQuantity, M37.ExpenseID'
SET @sSQL1 = '      
FROM OT2002 WITH (NOLOCK) inner join OT2001 WITH (NOLOCK) on OT2002.SOrderID = OT2001.SOrderID AND OT2002.DivisionID = OT2001.DivisionID
      Inner Join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID = OT2002.InventoryID
      Left Join OV2906 on OV2906.TransactionID = OT2002.TransactionID AND OV2906.DivisionID = OT2002.DivisionID
      LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2002.DivisionID AND O99.VoucherID = OT2002.SOrderID AND O99.TransactionID = OT2002.TransactionID
      LEFT JOIN MT0136 M36 WITH (NOLOCK) ON M36.DivisionID = OT2001.DivisionID AND M36.ApportionID = OT2001.InheritApportionID AND M36.ProductID = OT2002.InventoryID  AND 
					ISNULL (M36.S01ID,'''') = ISNULL (O99.S01ID,'''') AND 
					ISNULL (M36.S02ID,'''') = ISNULL (O99.S02ID,'''') AND 
					ISNULL (M36.S03ID,'''') = ISNULL (O99.S03ID,'''') AND 
					ISNULL (M36.S04ID,'''') = ISNULL (O99.S04ID,'''') AND 
					ISNULL (M36.S05ID,'''') = ISNULL (O99.S05ID,'''') AND 
					ISNULL (M36.S06ID,'''') = ISNULL (O99.S06ID,'''') AND 
					ISNULL (M36.S07ID,'''') = ISNULL (O99.S07ID,'''') AND 
					ISNULL (M36.S08ID,'''') = ISNULL (O99.S08ID,'''') AND 
					ISNULL (M36.S09ID,'''') = ISNULL (O99.S09ID,'''') AND 
					ISNULL (M36.S10ID,'''') = ISNULL (O99.S10ID,'''') AND 
					ISNULL (M36.S11ID,'''') = ISNULL (O99.S11ID,'''') AND 
					ISNULL (M36.S12ID,'''') = ISNULL (O99.S12ID,'''') AND 
					ISNULL (M36.S13ID,'''') = ISNULL (O99.S13ID,'''') AND 
					ISNULL (M36.S14ID,'''') = ISNULL (O99.S14ID,'''') AND 
					ISNULL (M36.S15ID,'''') = ISNULL (O99.S15ID,'''') AND 
					ISNULL (M36.S16ID,'''') = ISNULL (O99.S16ID,'''') AND 
					ISNULL (M36.S17ID,'''') = ISNULL (O99.S17ID,'''') AND 
					ISNULL (M36.S18ID,'''') = ISNULL (O99.S18ID,'''') AND 
					ISNULL (M36.S19ID,'''') = ISNULL (O99.S19ID,'''') AND 
					ISNULL (M36.S20ID,'''') = ISNULL (O99.S20ID,'''')
		LEFT JOIN MT0137 M37 WITH (NOLOCK) ON M37.DivisionID = M36.DivisionID AND M37.ProductID = M36.ProductID AND M37.ReTransactionID = M36.TransactionID AND M37.ExpenseID =''COST001''
	    INNER JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', M37.DivisionID) AND A02.InventoryID = M37.MaterialID 
		'
SET @sSQLWhere ='
WHERE OrderType = 1 and OT2002.SOrderID in ('+@ListSOrderID+')
      AND OT2002.DivisionID = '''+@DivisionID+'''
      AND A02.InventoryTypeID LIKE '''+@InventoryTypeID+'''
      '
SET @sSQLWhere1 = '
		AND OT2002.TransactionID in ('+@ListTransactionID+')'   
		  
SET @sSQL2 = '
GROUP BY OT2002.Description, OT2002.SOrderID, --OT2002.RefInfor,
      OT2002.RefSOrderID,
      M37.DS01ID, M37.DS02ID, M37.DS03ID, M37.DS04ID, M37.DS05ID, M37.DS06ID, M37.DS07ID, M37.DS08ID, M37.DS09ID, M37.DS10ID,
      M37.DS11ID, M37.DS12ID, M37.DS13ID, M37.DS14ID, M37.DS15ID, M37.DS16ID, M37.DS17ID, M37.DS18ID, M37.DS19ID, M37.DS20ID,
      M37.MaterialID, A02.InventoryName, M37.MaterialUnitID, M37.ExpenseID,OT2002.SOrderIDRecognition
ORDER BY OT2002.SOrderID       '      
--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQLWhere
--PRINT @sSQL2     		
EXEC (@sSQL + @sSQL1 + @sSQLWhere + @sSQLWhere1 + @sSQL2)

SET NOCOUNT OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON	  
