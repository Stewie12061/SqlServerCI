IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2049]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2049]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Báo cáo kiểm kê hàng hóa ANGEL
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hải Long on 05/12/2014
---- Modified by Phương Thảo on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

-- <Example>
/*
   exec WP2049 @DivisionID=N'ANG', @VoucherID='2f4ce227-e6e5-4219-a9fc-e889c14a616c'
*/

 CREATE PROCEDURE [dbo].[WP2049]
(
     @DivisionID NVARCHAR(50),
	 @VoucherID VARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = '
SELECT A36.VoucherNo, A36.WareHouseID, A01.WareHouseName, A36.VoucherDate AS Date, A02.I03ID AS InventoryTypeID, A03.AnaName AS InventoryTypeName, A37.InventoryID, A02.InventoryName, A37.UnitID, A04.UnitName, 
A37.Quantity, A37.UnitPrice, A37.ConvertedAmount,
A37.AdjustQuantity, A37.AdjustUnitPrice, A37.AdjutsOriginalAmount, 
(CASE WHEN A37.AdjustQuantity > A37.Quantity THEN A37.AdjustQuantity - A37.Quantity ELSE NULL END) AS DesidualAdjustQuantity, 
(CASE WHEN A37.AdjustQuantity > A37.Quantity THEN A37.AdjustQuantity - A37.Quantity ELSE NULL END)*AdjustUnitPrice AS DesidualAdjustAmount,
(CASE WHEN A37.AdjustQuantity < A37.Quantity THEN A37.Quantity - A37.AdjustQuantity ELSE NULL END) AS DeficientAdjustQuantity, 
(CASE WHEN A37.AdjustQuantity < A37.Quantity THEN A37.Quantity - A37.AdjustQuantity ELSE NULL END)*AdjustUnitPrice AS DeficientAdjustAmount,
A37.PoorQAQty, A37.PoorQAQty*A37.AdjustUnitPrice AS PoorQAAmount, A37.DeterioratingQAQty, A37.DeterioratingQAQty*A37.AdjustUnitPrice AS DeterioratingQAAmount, A37.Notes
FROM AT2037 A37 WITH (NOLOCK)
INNER JOIN AT2036 A36 WITH (NOLOCK) ON A36.DivisionID = A37.DivisionID AND A36.VoucherID = A37.VoucherID
LEFT JOIN AT1303 A01 WITH (NOLOCK) ON A01.DivisionID IN (''@@@'', '''+@DivisionID+''') AND A01.WareHouseID = A36.WareHouseID
LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = A37.UnitID
LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', A37.DivisionID) AND A02.InventoryID = A37.InventoryID 
LEFT JOIN AT1015 A03 WITH (NOLOCK) ON A03.AnaID = A02.I03ID AND A03.AnaTypeID = ''I03'' 
WHERE A37.DivisionID = '''+@DivisionID+'''
AND A37.VoucherID = '''+@VoucherID+''' '

EXEC (@sSQL)
--PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
