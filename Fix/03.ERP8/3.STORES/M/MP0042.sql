IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0042]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0042]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Created by Hải Long on 08/02/2017: Load Detail kế thừa dự trù chi phí sản xuất (CustomizeIndex = 71 ---- HHP)
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
exec MP0042 @DivisionID=N'SC',	@EstimateID = 'CL/16/12/0001'
*/
 

CREATE PROCEDURE [dbo].[MP0042] 
(
	@DivisionID nvarchar(50),
	@EstimateID nvarchar(50)		-- Là ID truyền trên master xuống Detail của màn hình kế thừa đơn hàng 

)
AS
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = '
SELECT B02.SOrderID, B02.OrderDate, B02.ShipDate, B02.ObjectID, AT1202.ObjectName, B02.Notes
FROM OT2201 WITH (NOLOCK)  
INNER JOIN OT2001 B01 WITH (NOLOCK) ON OT2201.DivisionID = B01.DivisionID AND OT2201.SOrderID = B01.SOrderID AND B01.OrderType = 1 AND ISNULL(B01.OrderTypeID, 0) = 0
INNER JOIN OT2001 B02 WITH (NOLOCK) ON B02.DivisionID = B01.DivisionID AND B02.InheritSOrderID = B01.SOrderID AND B02.OrderType = 1 AND ISNULL(B02.OrderTypeID, 0) = 1
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND B02.ObjectID = AT1202.ObjectID 
WHERE OT2201.DivisionID = ''' + @DivisionID + '''
AND OT2201.EstimateID = ''' + @EstimateID + '''
AND B02.SOrderID NOT IN (SELECT AdjustSOrderID FROM OT2201 B03 WITH (NOLOCK) WHERE B03.DivisionID = OT2201.DivisionID AND B03.InheritVoucherID = OT2201.EstimateID AND ISNULL(B03.EstimateTypeID, 0) = 1)
'
PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

