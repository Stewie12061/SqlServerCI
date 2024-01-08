IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0131]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0131]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Add New quyết toán
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Bảo Thy on 03/02/2017
---- 
---- Modified by Phương Thảo on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*
    EXEC WP0131 'MK','ASOFTADMIN',11,2016,'BIDV', 'ad',  '2016-11-01','2016-11-30', 'LK', 'sfsgtgr', 'fd','2016-12-20',0
	EXEC WP0131 @DivisionID,@UserID,@TranMonth,@TranYear,@Date,@FromObjectID,@ToObjectID,
	@FromContractID,@ToContractID,@FromWareHouseID,@ToWareHouseID,@Mode
*/

 CREATE PROCEDURE WP0131
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @TranMonth INT,
     @TranYear INT,
	 @ObjectID VARCHAR(50),
	 @ContractID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @VoucherTypeID VARCHAR(50),
	 @VoucherID VARCHAR(50),
	 @VoucherNo VARCHAR(50),
	 @VoucherDate DATETIME,
	 @Mode TINYINT, --0: Load grid Addnew, 1: Lưu Addnew
	 @WareHouseID VARCHAR(50) = ''
)
AS

IF @Mode = 0
BEGIN
	SELECT T1.VoucherID AS DetailVoucherID, T1.VoucherNo AS DetailVoucherNo, T1.VoucherDate AS DetailVoucherDate, 'NK' AS Type, T2.CostID, T1.WareHouseID,
	T2.InventoryID, Quantity, NULL AS DetailFromDate, NULL AS DetailToDate, CostUnitPrice AS UnitPrice, OriginalAmount, ConvertAmount,
	T5.InventoryName AS CostName, T6.InventoryName AS WareHouseName, T7.InventoryName
	FROM WT0097 T1 WITH (NOLOCK)
	LEFT JOIN WT0098 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
	LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (@DivisionID, '@@@') AND T1.ObjectID = T3.ObjectID
	LEFT JOIN AT1302 T5 WITH (NOLOCK) ON T2.CostID = T5.InventoryID
	LEFT JOIN AT1302 T6 WITH (NOLOCK) ON T1.WareHouseID = T6.InventoryID
	LEFT JOIN AT1302 T7 WITH (NOLOCK) ON T7.DivisionID IN ('@@@', T1.DivisionID) AND T2.InventoryID = T7.InventoryID
	WHERE T1.DivisionID = @DivisionID
	AND T1.ObjectID = @ObjectID
	AND T2.ContractID = @ContractID
	AND T1.IsImportVoucher = 1
	AND ISNULL(T1.IsFinalCost,0) = 0
	AND T1.WareHouseID LIKE @WareHouseID

	UNION

	SELECT T1.VoucherID AS DetailVoucherID, T1.VoucherNo AS DetailVoucherNo, T1.VoucherDate AS DetailVoucherDate, 'XK' AS Type, T2.CostID, T1.WareHouseID,
	T2.InventoryID, Quantity, NULL AS DetailFromDate, NULL AS DetailToDate, CostUnitPrice AS UnitPrice, OriginalAmount, ConvertAmount,
	T5.InventoryName AS CostName, T6.InventoryName AS WareHouseName, T7.InventoryName
	FROM WT0097 T1 WITH (NOLOCK)
	LEFT JOIN WT0098 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
	LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (@DivisionID, '@@@') AND T1.ObjectID = T3.ObjectID
	LEFT JOIN AT1302 T5 WITH (NOLOCK) ON T2.CostID = T5.InventoryID
	LEFT JOIN AT1302 T6 WITH (NOLOCK) ON T1.WareHouseID = T6.InventoryID
	LEFT JOIN AT1302 T7 WITH (NOLOCK) ON T7.DivisionID IN ('@@@', T1.DivisionID) AND T2.InventoryID = T7.InventoryID
	WHERE T1.DivisionID = @DivisionID
	AND T1.ObjectID = @ObjectID
	AND T2.ContractID = @ContractID
	AND T1.IsImportVoucher = 0
	AND ISNULL(T1.IsFinalCost,0) = 0
	AND T1.WareHouseID LIKE @WareHouseID

	UNION

	SELECT T1.VoucherID AS DetailVoucherID, T1.VoucherNo AS DetailVoucherNo, T1.VoucherDate AS DetailVoucherDate, 'LK' AS Type, NULL AS CostID, T1.WareHouseID,
	T1.InventoryID, Quantity, FromDate AS DetailFromDate, ToDate AS DetailFromDate, UnitPrice, OriginalAmount, ConvertAmount,
	N'Chi phí lưu kho' AS CostName, T6.InventoryName AS WareHouseName, T7.InventoryName
	FROM WT0099 T1 WITH (NOLOCK)
	LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (@DivisionID, '@@@') AND T1.ObjectID = T3.ObjectID
	LEFT JOIN AT1302 T6 WITH (NOLOCK) ON T1.WareHouseID = T6.InventoryID
	LEFT JOIN AT1302 T7 WITH (NOLOCK) ON T7.DivisionID IN ('@@@', T1.DivisionID) AND T1.InventoryID = T7.InventoryID
	WHERE T1.DivisionID = @DivisionID
	AND T1.ObjectID = @ObjectID
	AND T1.ContractID = @ContractID
	AND ISNULL(T1.IsFinalCost,0) = 0
	AND T1.WareHouseID LIKE @WareHouseID
END
ELSE --@Mode = 1
BEGIN
--- Insert master
IF NOT EXISTS (SELECT TOP 1 1 FROM WT0100 WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID AND ObjectID = @ObjectID AND ContractID = @ContractID)
INSERT INTO WT0100 (DivisionID, VoucherTypeID, VoucherID, VoucherNo, VoucherDate, ContractID, ObjectID, FromDate, ToDate, CreateUserID, 
					CreateDate, LastModifyUserID, LastModifyDate, DayUnit)

SELECT @DivisionID, @VoucherTypeID, @VoucherID, @VoucherNo, @VoucherDate, @ContractID, @ObjectID, @FromDate, @ToDate, @UserID, GETDATE(), @UserID, GETDATE(), DayUnit
FROM AT1020 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND ContractID = @ContractID

--- Insert detail Chi phí nhập kho (Type = 'NK')
--WT0100 master quyết toán, WT0103 detail quyết toán, WT0099 chi phí lưu kho, WT0097 master chi phí nhập/xuất kho, WT0098 detail chi phí nhập/xuất kho
INSERT INTO WT0103 (DivisionID, TransationID, VoucherID, DetailTransationID, DetailVoucherID, DetailVoucherNo, DetailVoucherDate, Type, CostID, WareHouseID,
					InventoryID, Quantity, DetailFromDate, DetailToDate, UnitPrice, OriginalAmount, ConvertAmount)

SELECT @DivisionID, NEWID(), @VoucherID, T2.TransactionID, T1.VoucherID, T1.VoucherNo, T1.VoucherDate, 'NK' , T2.CostID, T1.WareHouseID,
T2.InventoryID, Quantity, NULL, NULL, CostUnitPrice, OriginalAmount, ConvertAmount
FROM WT0097 T1 WITH (NOLOCK)
LEFT JOIN WT0098 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
WHERE T1.DivisionID = @DivisionID
AND T1.ObjectID = @ObjectID
AND T2.ContractID = @ContractID
AND T1.IsImportVoucher = 1
AND ISNULL(T1.IsFinalCost,0) = 0
AND T1.WareHouseID LIKE @WareHouseID

--- Insert detail Chi phí xuất kho (Type = 'XK')
INSERT INTO WT0103 (DivisionID, TransationID, VoucherID, DetailTransationID, DetailVoucherID, DetailVoucherNo, DetailVoucherDate, Type, CostID, WareHouseID,
					InventoryID, Quantity, DetailFromDate, DetailToDate, UnitPrice, OriginalAmount, ConvertAmount)

SELECT @DivisionID, NEWID(), @VoucherID, T2.TransactionID, T1.VoucherID, T1.VoucherNo, T1.VoucherDate, 'XK', T2.CostID, T1.WareHouseID,
T2.InventoryID, Quantity, NULL, NULL, CostUnitPrice, OriginalAmount, ConvertAmount
FROM WT0097 T1 WITH (NOLOCK)
LEFT JOIN WT0098 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
WHERE T1.DivisionID = @DivisionID
AND T1.ObjectID = @ObjectID
AND T2.ContractID = @ContractID
AND T1.IsImportVoucher = 0
AND ISNULL(T1.IsFinalCost,0) = 0
AND T1.WareHouseID LIKE @WareHouseID

--- Insert detail Chi phí lưu kho (Type = 'LK')
INSERT INTO WT0103 (DivisionID, TransationID, VoucherID, DetailTransationID, DetailVoucherID, DetailVoucherNo, DetailVoucherDate, Type, CostID, WareHouseID,
					InventoryID, Quantity, DetailFromDate, DetailToDate, UnitPrice, OriginalAmount, ConvertAmount)

SELECT @DivisionID, NEWID(), @VoucherID, NULL, T1.VoucherID, T1.VoucherNo, T1.VoucherDate, 'LK', NULL, T1.WareHouseID,
T1.InventoryID, Quantity, FromDate, ToDate, UnitPrice, OriginalAmount, ConvertAmount
FROM WT0099 T1 WITH (NOLOCK)
WHERE T1.DivisionID = @DivisionID
AND T1.ObjectID = @ObjectID
AND T1.ContractID = @ContractID
AND ISNULL(T1.IsFinalCost,0) = 0
AND T1.WareHouseID LIKE @WareHouseID

---Update trạng thái Đã quyết toán cho các bút toán chi phí
UPDATE WT0097
SET IsFinalCost = 1
FROM WT0097
INNER JOIN 
(
	SELECT T1.DivisionID, T1.ContractID, T1.ObjectID, T2.DetailVoucherID
	FROM WT0100 T1 WITH (NOLOCK)
	LEFT JOIN WT0103 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
	WHERE T1.DivisionID = @DivisionID
	AND T1.ObjectID = @ObjectID
	AND T1.ContractID = @ContractID
)A ON WT0097.DivisionID = A.DivisionID AND WT0097.VoucherID = A.DetailVoucherID
WHERE WT0097.DivisionID = @DivisionID
AND ISNULL(WT0097.IsFinalCost,0) = 0

UPDATE WT0099 WITH (ROWLOCK)
SET IsFinalCost = 1
WHERE DivisionID = @DivisionID
AND ObjectID = @ObjectID
AND ContractID = @ContractID
AND ISNULL(IsFinalCost,0) = 0

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
