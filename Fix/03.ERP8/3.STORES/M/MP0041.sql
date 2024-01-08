IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Created by Hải Long on 08/02/2017: Load Master kế thừa dự trù chi phí sản xuất (CustomizeIndex = 71 ---- HHP)
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

/*
exec MP0041 @DivisionID = 'SC', @FromPeriod = 201605, @ToPeriod = 201701, @FromDate = '01/05/2016', @ToDate = '01/31/2017', @TimeMode = 0
*/
 

CREATE PROCEDURE [dbo].[MP0041] 
(
	@DivisionID nvarchar(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@TimeMode TINYINT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = ''

IF @TimeMode = 0
BEGIN
	SET @sWhere = @sWhere + '
	AND OT2201.TranMonth + OT2201.TranYear * 100 BETWEEN '+Convert(Nvarchar(10),@FromPeriod)+' AND '+CONVERT(NVARCHAR(10),@ToPeriod)										
END	
ELSE
BEGIN
	SET @sWhere = @sWhere + '
	AND OT2201.VoucherDate  BETWEEN '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''''							
END	


SET @sSQL = '
	SELECT OT2201.DivisionID, OT2201.EstimateID, OT2201.VoucherDate, OT2201.DepartmentID, AT1102.DepartmentName, OT2201.EmployeeID, 
	OT2201.InventoryTypeID, AT1301.InventoryTypeName, OT2201.WareHouseID, AT1303.WareHouseName, OT2201.Description, OT2201.ObjectID, AT1202.ObjectName
	FROM OT2201 WITH (NOLOCK)
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND OT2201.ObjectID = AT1202.ObjectID
	LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2201.InventoryTypeID 
	LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1303.WareHouseID = OT2201.WareHouseID
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = OT2201.DepartmentID
	INNER JOIN OT2202 WITH (NOLOCK) ON OT2202.DivisionID = OT2201.DivisionID AND OT2202.EstimateID = OT2201.EstimateID
	INNER JOIN OT2002 A01 WITH (NOLOCK) ON A01.DivisionID = OT2202.DivisionID AND A01.SOrderID = OT2202.MOrderID AND A01.TransactionID = OT2202.MOTransactionID
	INNER JOIN OT2001 B01 WITH (NOLOCK) ON B01.DivisionID = A01.DivisionID AND B01.SOrderID = A01.SOrderID AND B01.OrderType = 1 AND ISNULL(B01.OrderTypeID, 0) = 0
	INNER JOIN OT2002 A02 WITH (NOLOCK) ON A02.DivisionID = A01.DivisionID AND A02.InheritVoucherID = A01.SOrderID AND A02.InheritTransactionID = A01.TransactionID AND A02.InheritTableID = ''OT2001''
	INNER JOIN OT2001 B02 WITH (NOLOCK) ON B02.DivisionID = A02.DivisionID AND B02.SOrderID = A02.SOrderID AND B02.OrderType = 1 AND ISNULL(B02.OrderTypeID, 0) = 1
	WHERE  
	OT2201.DivisionID = ''' + @DivisionID + '''
	--AND OT2201.OrderStatus not in (0, 9)
	AND ISNULL(OT2201.EstimateTypeID, 0) = 0'
	+ @sWhere +'
	GROUP BY OT2201.DivisionID, OT2201.EstimateID, OT2201.VoucherDate, OT2201.DepartmentID, AT1102.DepartmentName, OT2201.EmployeeID, 
	OT2201.InventoryTypeID, AT1301.InventoryTypeName, OT2201.WareHouseID, AT1303.WareHouseName, OT2201.Description, OT2201.ObjectID, AT1202.ObjectName
	ORDER BY OT2201.VoucherDate, OT2201.EstimateID
'


PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO



