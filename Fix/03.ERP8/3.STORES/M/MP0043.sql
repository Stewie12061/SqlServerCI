IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0043]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0043]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Created by Hải Long on 08/02/2017: Stored load chi chiết điều chỉnh dự trù chi phí sản xuất (CustomizeIndex = 71 ---- HHP)
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
/*
exec MP0043 @DivisionID=N'SC',	@SOrderID = 'CL/16/12/0001'
*/
 

CREATE PROCEDURE [dbo].[MP0043] 
(
	@DivisionID nvarchar(50),
	@SOrderID nvarchar(50)	

)
AS
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = '
SELECT OT2201.DivisionID, OT2201.EstimateID AS InheritVoucherID, OT2202.EDetailID AS InheritTransactionID, OT2201.VoucherDate,  
OT2201.DepartmentID, OT2201.EmployeeID, OT2201.InventoryTypeID, OT2201.WareHouseID, OT2201.ApportionType, OT2201.Description, OT2201.ObjectID, OT2201.PeriodID,
A02.SOrderID AS AdjustSOrderID, A02.TransactionID AS AdjustTransactionID, A02.InventoryID, AT1302.InventoryName, A02.UnitID, 
A02.OrderQuantity AS ProductQuantity, OT2202.ApportionID, OT2202.PDescription, A02.LinkNo, A02.RefInfor, A02.EndDate,
OT2202.Ana01ID, OT2202.Ana02ID, OT2202.Ana03ID, OT2202.Ana04ID, OT2202.Ana05ID, OT2202.Ana06ID, OT2202.Ana07ID, OT2202.Ana08ID, OT2202.Ana09ID, OT2202.Ana10ID
FROM OT2201 WITH (NOLOCK)
INNER JOIN OT2202 WITH (NOLOCK) ON OT2202.DivisionID = OT2201.DivisionID AND OT2202.EstimateID = OT2201.EstimateID
INNER JOIN OT2002 A01 WITH (NOLOCK) ON A01.DivisionID = OT2202.DivisionID AND A01.SOrderID = OT2202.MOrderID AND A01.TransactionID = OT2202.MOTransactionID
INNER JOIN OT2001 B01 WITH (NOLOCK) ON B01.DivisionID = A01.DivisionID AND B01.SOrderID = A01.SOrderID AND B01.OrderType = 1 AND ISNULL(B01.OrderTypeID, 0) = 0
INNER JOIN OT2002 A02 WITH (NOLOCK) ON A02.DivisionID = A01.DivisionID AND A02.InheritVoucherID = A01.SOrderID AND A02.InheritTransactionID = A01.TransactionID AND A02.InheritTableID = ''OT2001''
INNER JOIN OT2001 B02 WITH (NOLOCK) ON B02.DivisionID = A02.DivisionID AND B02.SOrderID = A02.SOrderID AND B02.OrderType = 1 AND ISNULL(B02.OrderTypeID, 0) = 1
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = A02.InventoryID AND AT1302.DivisionID IN (A02.DivisionID,''@@@'')
WHERE B02.DivisionID = ''' + @DivisionID + '''
AND B02.SOrderID = ''' + @SOrderID + '''
ORDER BY A02.Orders'

PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

