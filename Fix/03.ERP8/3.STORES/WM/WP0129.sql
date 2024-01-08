IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0129]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0129]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Truy vấn chi phí lưu kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Bảo Thy on 02/02/2017
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified on by 
-- <Example>
/*
    EXEC WP0129 'HT','ASOFTADMIN', '%', '%','%'
	EXEC WP0129 @DivisionID,@UserID, @ContractID, @ObjectID
*/

 CREATE PROCEDURE WP0129
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
	 @ContractID VARCHAR(50),
	 @ObjectID VARCHAR(50),
	 @WarehouseID VARCHAR(50) = ''
)
AS

SELECT T1.DivisionID, T1.VoucherID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T3.ObjectName, T1.ContractID, A20.ContractNo, T1.WareHouseID, T4.InventoryName AS WareHouseName, 
T1.UnitPrice, T1.InventoryID, T2.InventoryName, T1.Quantity, T1.ConvertCoefficient, T1.UnitID, T5.UnitName, T1.FromDate, T1.ToDate, T1.NumDate, T1.OriginalAmount, 
T1.ExchangeRate, T1.ConvertAmount, T1.CreateUserID, T1.CreateDate, T1.LastModifyUserID, T1.LastModifyDate, 
CASE WHEN ISNULL(T1.IsFinalCost,0) = 0 THEN N'Chưa quyết toán'
	 WHEN ISNULL(T1.IsFinalCost,0) = 1 THEN N'Đã quyết toán' END AS IsFinalCost
FROM WT0099 T1 WITH (NOLOCK)
LEFT JOIN AT1020 A20 WITH (NOLOCK) ON T1.DivisionID = A20.DivisionID AND T1.ContractID = A20.ContractID
LEFT JOIN AT1302 T2 WITH (NOLOCK) ON T1.InventoryID = T2.InventoryID
LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (@DivisionID, '@@@') AND T1.ObjectID = T3.ObjectID
LEFT JOIN AT1302 T4 ON T1.WareHouseID = T4.InventoryID
LEFT JOIN AT1304 T5 ON T1.UnitID = T5.UnitID
WHERE T1.DivisionID = @DivisionID
AND T1.ContractID LIKE @ContractID
AND T1.ObjectID LIKE @ObjectID
AND T1.WarehouseID LIKE @WarehouseID
ORDER BY T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T1.ContractID, T1.WareHouseID, T1.InventoryID, T1.FromDate

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

