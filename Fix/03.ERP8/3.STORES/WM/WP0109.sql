IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0109]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0109]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kế thừa phiếu thống kê sản xuất - Angel
-- <History>
---- Created by Tiểu Mai on 02/26/2016
---- Modified by Tiểu Mai on 09/06/2016: Fix không lên dữ liệu do ObjectID, TeamID NULL
---- Modified by Hải Long on 19/10/2016: Bổ sung kế thừa từ màn hình nhập kho WF0011
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
/*
	EXEC WP0109 'KE', '02/26/2016', '02/26/2016', '', '', 1
	EXEC WP0109 'KE', '02/26/2016', '02/26/2016', '', '', 2
	EXEC WP0109 'KE', '02/26/2016', '02/26/2016', '', '', 3
 */

CREATE PROCEDURE [dbo].[WP0109] 	
	@DivisionID NVARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@TeamID NVARCHAR(50),
	@ObjectID NVARCHAR(50),
	@IsType TINYINT,	-- 1: Nguyên vật liệu
						-- 2: Sản phẩm / bán phẩm
						-- 3: Sản phẩm lỗi
	@Form TINYINT	-- 1: Màn hình yêu cầu nhập kho WF0095
						-- 2: Màn hình nhập kho WF0011
						
AS
DECLARE @sSQL NVARCHAR(MAX), @sSQL1 NVARCHAR(MAX), @wWhere NVARCHAR(MAX), @sJoin NVARCHAR(MAX)
SET @sSQL = ''
SET @sSQL1 = ''
SET @wWhere = ''
SET @sJoin = ''

IF @IsType = 1
	SET @sSQL = '
			SELECT ''MT1802'' as InheritTableID, MT1801.DivisionID, MT1802.VoucherID, MT1801.VoucherNo, MT1801.VoucherTypeID, MT1801.VoucherDate, MT1801.ProductDate, AT1202.ObjectName, 
			MT1801.ObjectID, MT1801.TeamID, MT1802.CombineID, MT1802.TableID, MT1801.MTC01, MT1801.MTC02, MT1801.VisorsID, MT1801.EmployeeID, MT1801.[Description],
			AT1103.FullName AS EmployeeName, HV1400.FullName AS VisorsName, AT0165.TableName, AT0156.CombineName, HT1101.TeamName,
			MT1802.TransactionID, 
			MT1802.InventoryID, A01.InventoryName, MT1802.UnitID, MT1802.LimitDate, (Isnull(MT1802.RemainQuantity,0) - Isnull(A1.ActualQuantity,0)) AS Quantity, MT1802.[Shift], MT1802.IsImport, MT1802.WarehouseID, MT1802.TypeTab,
			MT1802.Ana01ID, MT1802.Ana02ID, MT1802.Ana03ID, MT1802.Ana04ID, MT1802.Ana05ID, MT1802.Ana06ID, MT1802.Ana07ID, MT1802.Ana08ID, MT1802.Ana09ID, MT1802.Ana10ID'	

ELSE IF @IsType = 2
	SET @sSQL = '
			SELECT ''MT1802'' as InheritTableID, MT1801.DivisionID,MT1802.VoucherID, MT1801.VoucherNo, MT1801.VoucherTypeID, MT1801.VoucherDate, MT1801.ProductDate, AT1202.ObjectName, 
			MT1801.ObjectID, MT1801.TeamID, MT1802.CombineID, MT1802.TableID, MT1801.MTC01, MT1801.MTC02, MT1801.VisorsID, MT1801.EmployeeID, MT1801.[Description],
			AT1103.FullName AS EmployeeName, HV1400.FullName AS VisorsName, AT0165.TableName, AT0156.CombineName, HT1101.TeamName,
			MT1802.TransactionID, 
			MT1802.ProductID AS InventoryID, A02.InventoryName, MT1802.ProductUnitID AS UnitID, MT1802.LimitDate, (Isnull(MT1802.ActualQuantity,0) - Isnull(A1.ActualQuantity,0)) AS Quantity, MT1802.[Shift], 
			MT1802.IsImport, MT1802.WarehouseID, MT1802.TypeTab,
			MT1802.Ana01ID, MT1802.Ana02ID, MT1802.Ana03ID, MT1802.Ana04ID, MT1802.Ana05ID, MT1802.Ana06ID, MT1802.Ana07ID, MT1802.Ana08ID, MT1802.Ana09ID, MT1802.Ana10ID '
ELSE
	SET @sSQL = '
			SELECT ''MT1802'' as InheritTableID, MT1801.DivisionID,MT1802.VoucherID, MT1801.VoucherNo, MT1801.VoucherTypeID, MT1801.VoucherDate, MT1801.ProductDate, AT1202.ObjectName, 
			MT1801.ObjectID, MT1801.TeamID, MT1802.CombineID, MT1802.TableID, MT1801.MTC01, MT1801.MTC02, MT1801.VisorsID, MT1801.EmployeeID, MT1801.[Description],
			AT1103.FullName AS EmployeeName, HV1400.FullName AS VisorsName, AT0165.TableName, AT0156.CombineName, HT1101.TeamName,
			MT1802.TransactionID, 
			MT1802.ProductID AS InventoryID, A02.InventoryName, MT1802.ProductUnitID AS UnitID, MT1802.LimitDate, (Isnull(MT1802.ErrorQuantity,0) - Isnull(A1.ActualQuantity,0)) AS Quantity,  MT1802.[Shift], 
			MT1802.IsImport, MT1802.WarehouseID, MT1802.TypeTab,
			MT1802.Ana01ID, MT1802.Ana02ID, MT1802.Ana03ID, MT1802.Ana04ID, MT1802.Ana05ID, MT1802.Ana06ID, MT1802.Ana07ID, MT1802.Ana08ID, MT1802.Ana09ID, MT1802.Ana10ID '

IF @Form = 1 
BEGIN
	SET @sJoin = 'LEFT JOIN (SELECT WT0096.DivisionID, InheritTableID, WT0096.InheritVoucherID, WT0096.InheritTransactionID, WT0096.InventoryID, SUM(ActualQuantity) AS ActualQuantity
	             FROM WT0096
	           WHERE WT0096.DivisionID = '''+@DivisionID+'''
	           GROUP BY WT0096.DivisionID, InheritTableID, WT0096.InheritVoucherID, WT0096.InheritTransactionID, WT0096.InventoryID) AS A1 ON A1.DivisionID = A1.DivisionID AND A1.InheritVoucherID = MT1802.VoucherID AND A1.InheritTransactionID = MT1802.TransactionID AND A1.InheritTableID = ''MT1802'''	
END
ELSE
BEGIN
	SET @sJoin = 'LEFT JOIN (SELECT AT2007.DivisionID, InheritTableID, AT2007.InheritVoucherID, AT2007.InheritTransactionID, AT2007.InventoryID, SUM(ActualQuantity) AS ActualQuantity
	             FROM AT2007
	           WHERE AT2007.DivisionID = '''+@DivisionID+'''
	           GROUP BY AT2007.DivisionID, InheritTableID, AT2007.InheritVoucherID, AT2007.InheritTransactionID, AT2007.InventoryID) AS A1 ON A1.DivisionID = A1.DivisionID AND A1.InheritVoucherID = MT1802.VoucherID AND A1.InheritTransactionID = MT1802.TransactionID AND A1.InheritTableID = ''MT1802'''
END

SET @sSQL1 = '	
	FROM MT1802
	INNER JOIN MT1801 ON MT1801.DivisionID = MT1802.DivisionID AND MT1801.VoucherID = MT1802.VoucherID
	LEFT JOIN AT0156 ON AT0156.DivisionID = MT1802.DivisionID AND AT0156.CombineID = MT1802.CombineID
	LEFT JOIN HT1101 ON HT1101.DivisionID = AT0156.DivisionID AND HT1101.TeamID = MT1801.TeamID
	LEFT JOIN AT0165 ON AT0165.DivisionID = MT1802.DivisionID AND AT0165.TableID = MT1802.TableID
	LEFT JOIN AT1202 ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = MT1801.ObjectID
	LEFT JOIN AT1103 ON AT1103.EmployeeID = MT1801.EmployeeID
	LEFT JOIN HV1400 ON HV1400.DivisionID = MT1801.DivisionID AND HV1400.EmployeeID = MT1801.VisorsID
	LEFT JOIN AT1302 A01 ON A01.DivisionID IN (''@@@'', MT1802.DivisionID) AND A01.InventoryID = MT1802.InventoryID
	LEFT JOIN AT1302 A02 ON A02.DivisionID IN (''@@@'', MT1802.DivisionID) AND A02.InventoryID = MT1802.ProductID
	LEFT JOIN AT1303 ON AT1303.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND AT1303.WarehouseID = MT1802.WarehouseID
	' + @sJoin +
	'WHERE MT1801.DivisionID = '''+@DivisionID+'''
		AND MT1802.TypeTab = '+CONVERT(NVARCHAR(5),@IsType)+'
		AND Isnull(MT1801.ObjectID,'''') like '''+@ObjectID+'''
		AND Isnull(MT1801.TeamID,'''') like '''+@TeamID+'''
		AND ISNULL(MT1802.IsImport,0) = 1	
		' +
		(CASE WHEN @IsType = 1 THEN ' AND (Isnull(MT1802.RemainQuantity,0) - Isnull(A1.ActualQuantity,0)) > 0' ELSE 
		(CASE WHEN @IsType = 2 THEN ' AND (Isnull(MT1802.ActualQuantity,0) - Isnull(A1.ActualQuantity,0)) > 0' ELSE ' AND (Isnull(MT1802.ErrorQuantity,0) - Isnull(A1.ActualQuantity,0)) > 0' END) END) +
		'
		AND MT1801.VoucherDate BETWEEN '''+Convert(nvarchar(10),@FromDate,101)+''' AND '''+convert(nvarchar(10), @ToDate,101)+'''
	ORDER BY MT1802.Orders '

EXEC (@sSQL+@sSQL1)
PRINT @sSQL
PRINT @sSQL1

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

