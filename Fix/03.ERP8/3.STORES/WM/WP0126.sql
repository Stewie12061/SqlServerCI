IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0126]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0126]
GO
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load master danh sách các phiếu nhập/xuất kho lên màn hình kế thừa WF0125
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Bảo Thy on 12/01/2017
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 06/01/2020: Load Những phiếu chưa có chi phí nhập-xuất
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
/*
    EXEC WP0126 'MK','ASOFTADMIN',11,2016,11,2016, '2016-11-01 11:32:10.833', '2016-11-30 11:32:10.833','%',0, 1
*/

 CREATE PROCEDURE WP0126
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @FromMonth INT,
     @FromYear INT,
     @ToMonth INT,
     @ToYear INT,
     @FromDate DATETIME,
     @ToDate DATETIME,
     @ObjectID VARCHAR(50),
     @IsDate TINYINT,
     @Mode TINYINT --1: Phiếu nhập kho, 2: Phiếu xuất kho
)
AS
DECLARE @sSQL NVARCHAR(MAX) = '', 
		@sSQL1 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = ''

IF @IsDate = 0 SET @sWhere = N'AND A26.TranMonth + A26.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+' '
IF @IsDate = 1 SET @sWhere = N'AND CONVERT(VARCHAR, A26.VoucherDate,120) BETWEEN '''+CONVERT(VARCHAR,@FromDate,120)+''' AND '''+CONVERT(VARCHAR,@ToDate,120)+''' '

CREATE TABLE #Temp (DivisionID VARCHAR(50), VoucherID VARCHAR(50), Total INT)
CREATE TABLE #Temp1 (DivisionID VARCHAR(50), VoucherID VARCHAR(50), CostTotal TINYINT)

IF @Mode = 1 SET @sWhere = @sWhere + '
AND A26.KindVoucherID IN (1,3,5,7,9)'
IF @Mode = 2 SET @sWhere = @sWhere + '
AND A26.KindVoucherID IN (2,4,6,8,10)'

SET @sSQL = N'
SELECT A26.DivisionID, A26.VoucherID, COUNT(A27.InventoryID) * COUNT(A24.CostID) AS Total
INTO #Temp
FROM AT2006 A26 WITH (NOLOCK)
LEFT JOIN AT1024 A24 WITH (NOLOCK) ON A26.DivisionID = A24.DivisionID AND A26.ContractID = A24.ContractID
LEFT JOIN AT2007 A27 WITH (NOLOCK) ON A26.DivisionID = A27.DivisionID AND A26.VoucherID = A27.VoucherID
WHERE A26.DivisionID = '''+@DivisionID+'''
AND A26.VoucherID NOT IN (SELECT VoucherID FROM WT0097 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''')
'+@sWhere+'
GROUP BY A26.DivisionID, A26.VoucherID

SELECT T1.DivisionID, T1.VoucherID, COUNT(1) AS CostTotal
INTO #Temp1
FROM WT0098 T1
GROUP BY T1.DivisionID, T1.VoucherID
'
PRINT (@sSQL)
EXEC (@sSQL)

SET @sSQL1 = N'
----Những phiếu chưa được tính chi phí nhập xuất kho (NOT IN WT0097)
SELECT CONVERT(TINYINT,0) Choose, A26.VoucherID, A26.VoucherNo, A26.VoucherTypeID, A26.VoucherDate, A26.ObjectID, A02.ObjectName, 
A26.[Description], A26.WareHouseID, A03.WareHouseName AS WareHouseName
FROM AT2006 A26 WITH (NOLOCK)
LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A03.WareHouseID = A26.WareHouseID
LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A26.ObjectID
WHERE A26.DivisionID = '''+@DivisionID+'''
AND A26.ObjectID = '''+@ObjectID+'''
AND A26.VoucherID NOT IN (SELECT InheritVoucherID FROM WT0098 WITH (NOLOCK)
					LEFT JOIN WT0097 ON WT0097.VoucherID = WT0098.VoucherID
					 WHERE WT0097.DivisionID = '''+@DivisionID+''' and ISNULL(InheritVoucherID, '''') <> '''' AND IsOtherCosts = 0)
'+@sWhere+'

UNION ALL

----Những phiếu đã được tính chi phí nhập xuất kho nhưng chưa hết
SELECT CONVERT(TINYINT,0) Choose, A26.VoucherID, A26.VoucherNo, A26.VoucherTypeID, A26.VoucherDate, A26.ObjectID, A02.ObjectName, 
A26.[Description], A26.WareHouseID, A03.WareHouseName AS WareHouseName
FROM AT2006 A26 WITH (NOLOCK)
LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A03.WareHouseID = A26.WareHouseID
LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A26.ObjectID
INNER JOIN #Temp1 T2 ON A26.DivisionID = T2.DivisionID AND A26.VoucherID = T2.VoucherID
INNER JOIN #Temp T1 ON A26.DivisionID = T1.DivisionID AND A26.VoucherID = T1.VoucherID
WHERE A26.DivisionID = '''+@DivisionID+'''
AND A26.ObjectID = '''+@ObjectID+'''
AND T2.CostTotal < T1.Total
'+@sWhere+'

'	
PRINT(@sSQL1)
EXEC(@sSQL1)

DROP TABLE #Temp1
DROP TABLE #Temp


GO

