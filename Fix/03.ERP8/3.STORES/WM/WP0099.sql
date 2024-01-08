IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0099]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0099]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
------ Load danh sách phiếu yêu cầu nhập - xuất - VCNB lên màn hình Duyệt
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:
----Modified by Bảo Thy on 15/02/2017: lấy thông tin kho hàng Customize EIMSKIP
--- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
/*
    EXEC WP0099 'EIS','',5,2014
*/

 CREATE PROCEDURE WP0099
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @TranMonth INT,
     @TranYear INT     
)
AS
DECLARE @CustomerIndex INT,
		@sSelect1 NVARCHAR(MAX)='',
		@sJoin NVARCHAR(MAX)='',
		@sSQL NVARCHAR(MAX)='',
		@sGroup NVARCHAR(MAX)=''

SELECT @CustomerIndex = ISNULL(CustomerName,-1) FROM CustomerIndex

IF @CustomerIndex = 70 ----EIMSKIP
BEGIN
	SET @sGroup = ', A03.InventoryName,A04.InventoryName'
	SET @sSelect1 = ', (CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) THEN A03.InventoryName ELSE '''' END) ImWareHouseName,
					(CASE WHEN W95.KindVoucherID in (2,4,6,8,10) THEN A03.InventoryName
					ELSE CASE WHEN W95.KindVoucherID = 3 THEN A04.InventoryName ELSE '''' END END) ExWareHouseName'

	SET @sJoin = 'LEFT JOIN AT1302 A03 WITH (NOLOCK) ON A03.DivisionID IN (''@@@'', W95.DivisionID) AND A03.InventoryID = W95.WareHouseID
				  LEFT JOIN AT1302 A04 WITH (NOLOCK) ON A04.DivisionID IN (''@@@'', W95.DivisionID) AND A04.InventoryID = W95.WareHouseID2'
END
ELSE
BEGIN
	SET @sGroup = ', A03.WareHouseName,A04.WareHouseName'

	SET @sJoin = 'LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND A03.WareHouseID = W95.WareHouseID
				  LEFT JOIN AT1303 A04 WITH (NOLOCK) ON A04.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND A04.WareHouseID = W95.WareHouseID2'

	SET @sSelect1 = ', (CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) THEN A03.WareHouseName ELSE '''' END) ImWareHouseName,
		(CASE WHEN W95.KindVoucherID in (2,4,6,8,10) THEN A03.WareHouseName
		  ELSE CASE WHEN W95.KindVoucherID = 3 THEN A04.WareHouseName ELSE '''' END END) ExWareHouseName'
END

SET @sSQL = '
SELECT CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) AND W95.WareHouseID2 IS NULL THEN 1 
WHEN W95.KindVoucherID  = 3 AND W95.WareHouseID2 IS NOT NULL THEN 3 ELSE 2 END KindVoucherID, ISNULL(W95.IsCheck,0) IsCheck,
 W95.VoucherTypeID, W95.VoucherID, W95.VoucherNo, W95.VoucherDate, W95.ObjectID, A02.ObjectName, W95.WareHouseID, 
 ' +  case when @CustomerIndex = 57 then '
	(CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) THEN A33.WareHouseName ELSE '''' END) ImWareHouseName,
	(CASE WHEN W95.KindVoucherID in (2,4,6,8,10) THEN A33.WareHouseName
		  ELSE CASE WHEN W95.KindVoucherID = 3 THEN A03.WareHouseName ELSE '''' END END) ExWareHouseName,'
		  else '' end + '
SUM (W96.ConvertedAmount) ConvertedAmount, W95.RefNo01, W95.RefNo02, W95.[Description]
'+@sSelect1+'
FROM WT0095 W95
LEFT JOIN WT0096 W96 ON W96.DivisionID = W95.DivisionID AND W96.VoucherID = W95.VoucherID
LEFT JOIN AT1202 A02 ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = W95.ObjectID
'+@sJoin+'
WHERE W95.DivisionID = '''+@DivisionID+'''
AND W95.TranMonth = '+STR(@TranMonth)+'
AND W95.TranYear = '+STR(@TranYear)+'
GROUP BY W95.VoucherID, W95.VoucherTypeID, W95.VoucherNo, W95.VoucherDate, W95.ObjectID, A02.ObjectName, W95.WareHouseID,
KindVoucherID, W95.RefNo01, W95.RefNo02, W95.[Description],W95.WareHouseID2, IsCheck '+@sGroup+'

'
--PRINT(@sSQL)
EXEC(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
