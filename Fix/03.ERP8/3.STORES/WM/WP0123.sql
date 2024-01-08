IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0123]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0123]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo xuất kho kiêm VCNB cho ANGEL (CustomizeIndex = 57)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created on 22/11/2016 by Tiểu Mai
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by ... on ...
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

---- EXEC WP0123 'HT', '2016-04-25 00:00:00.000', '2016-05-25 00:00:00.000', 'XB1', 'XS9', 'KDH', 'KXH', 2

CREATE PROCEDURE [dbo].[WP0123]      
( 
 @DivisionID AS NVARCHAR(50),
 @FromDate AS DATETIME,
 @ToDate AS DATETIME,
 @FromVoucherTypeID AS NVARCHAR(50),
 @ToVoucherTypeID AS NVARCHAR(50),
 @ImWareHouseID AS NVARCHAR(50),
 @ExWareHouseID AS NVARCHAR(50),
 @IsData INT ------	0: Phiếu xuất; 1: VCNB; 2: Cả 2
) 
AS 
DECLARE @sSQL NVARCHAR(MAX), @sSQL1 NVARCHAR(MAX)

SET @sSQL = N'
SELECT AT2006.WareHouseID AS ExWareHouseID, AT1303.WareHouseName AS ExWareHouseName, AT2006.WareHouseID2 AS ImWareHouseID, A03.WareHouseName as ImWareHouseName,
AT2007.InventoryID, AT1302.InventoryName, AT2007.UnitID, AT2007.ConvertedUnitID,
SUM(Isnull(AT2007.ActualQuantity,0)) as ActualQuantity, SUM(Isnull(AT2007.ConvertedQuantity,0)) as ConvertedQuantity
FROM AT2007 WITH (NOLOCK)
LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = AT2006.WareHouseID
LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN (''@@@'', '''+@DivisionID+''') AND A03.WareHouseID = AT2006.WareHouseID2
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT2007.DivisionID) AND AT1302.InventoryID = AT2007.InventoryID
WHERE AT2006.DivisionID = '''+@DivisionID+''' AND CONVERT(NVARCHAR(10),AT2006.VoucherDate,112) BETWEEN '+CONVERT(NVARCHAR(10),@FromDate,112)+' AND '+CONVERT(NVARCHAR(10),@ToDate,112)+'
	AND AT2006.VoucherTypeID BETWEEN '''+@FromVoucherTypeID+''' AND '''+@ToVoucherTypeID+'''
	AND AT2006.KindVoucherID = 2 AND AT2006.WareHouseID = '''+@ExWareHouseID+'''
GROUP BY AT2006.WareHouseID, AT1303.WareHouseName, AT2006.WareHouseID2, A03.WareHouseName,
AT2007.InventoryID, AT1302.InventoryName, AT2007.UnitID, AT2007.ConvertedUnitID
' + Case when @IsData  = 0 then ' ORDER BY AT2007.InventoryID ' ELSE '' END 

SET @sSQL1 = N'
SELECT AT2006.WareHouseID2 AS ExWareHouseID, A03.WareHouseName as ExWareHouseName, AT2006.WareHouseID AS ImWareHouseID, AT1303.WareHouseName as ImWareHouseName,
AT2007.InventoryID, AT1302.InventoryName, AT2007.UnitID, AT2007.ConvertedUnitID,
SUM(Isnull(AT2007.ActualQuantity,0)) as ActualQuantity, SUM(Isnull(AT2007.ConvertedQuantity,0)) as ConvertedQuantity
FROM AT2007 WITH (NOLOCK)
LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = AT2006.WareHouseID
LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN (''@@@'', '''+@DivisionID+''') AND A03.WareHouseID = AT2006.WareHouseID2
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT2007.DivisionID) AND AT1302.InventoryID = AT2007.InventoryID
WHERE AT2006.DivisionID = '''+@DivisionID+''' AND CONVERT(NVARCHAR(10),AT2006.VoucherDate,112) BETWEEN '+CONVERT(NVARCHAR(10),@FromDate,112)+' AND '+CONVERT(NVARCHAR(10),@ToDate,112)+'
	AND AT2006.VoucherTypeID BETWEEN '''+@FromVoucherTypeID+''' AND '''+@ToVoucherTypeID+'''
	AND AT2006.KindVoucherID = 3 AND AT2006.WareHouseID2 = '''+@ExWareHouseID+''' AND AT2006.WareHouseID = '''+@ImWareHouseID+'''
GROUP BY AT2006.WareHouseID, AT1303.WareHouseName, AT2006.WareHouseID2, A03.WareHouseName,
AT2007.InventoryID, AT1302.InventoryName, AT2007.UnitID, AT2007.ConvertedUnitID
' + Case when @IsData  = 0 then ' ORDER BY AT2007.InventoryID ' ELSE '' END

IF @IsData = 0
	EXEC (@sSQL)
IF @IsData = 1
	EXEC (@sSQL1)
IF @IsData = 2
	EXEC ('SELECT ExWareHouseID, ExWareHouseName, ImWareHouseID, ImWareHouseName, InventoryID, InventoryName, UnitID, ConvertedUnitID,
				SUM(Isnull(A.ActualQuantity,0)) as ActualQuantity, SUM(Isnull(A.ConvertedQuantity,0)) as ConvertedQuantity
	       FROM ('+ @sSQL +' UNION ' + @sSQL1 +') AS A
	       GROUP BY ExWareHouseID, ExWareHouseName, ImWareHouseID, ImWareHouseName, InventoryID, InventoryName, UnitID, ConvertedUnitID
	       ORDER BY InventoryID	')

--PRINT ('SELECT ExWareHouseID, ExWareHouseName, ImWareHouseID, ImWareHouseName, InventoryID, InventoryName, UnitID, ConvertedUnitID,
--				SUM(Isnull(A.ActualQuantity,0)) as ActualQuantity, SUM(Isnull(A.ConvertedQuantity,0)) as ConvertedQuantity
--	       FROM ('+ @sSQL +' UNION ' + @sSQL1 +') AS A
--	       GROUP BY ExWareHouseID, ExWareHouseName, ImWareHouseID, ImWareHouseName, InventoryID, InventoryName, UnitID, ConvertedUnitID
--	       ORDER BY InventoryID	')

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
