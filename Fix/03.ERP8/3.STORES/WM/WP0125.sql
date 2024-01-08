IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0125]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0125]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load lưới detail màn hình kế thừa phiếu nhập/xuất kho (EIMSKIP)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Bảo Thy on 11/01/2017
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified on  by 
-- <Example>
/*
	 WP0125 @DivisionID=N'HT',@ListVoucherID=N'bb3ca221-f67e-4a1f-a7ab-39ec751ff197'
*/

CREATE PROCEDURE [dbo].[WP0125] 
(
	@DivisionID nvarchar(50),				
	@ListVoucherID VARCHAR(MAX)
)	
AS

DECLARE @sSQL NVARCHAR(4000) = '',
		@sSQL1 NVARCHAR(4000) = ''

CREATE TABLE #Data
(
	VoucherID NVARCHAR(50)
)

IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#TAM')) 
	DROP TABLE #TAM

CREATE TABLE #TAM
(
	DivisionID NVARCHAR(50),
	VoucherID NVARCHAR(50),
	TransactionID NVARCHAR(50),
	InventoryID VARCHAR(50),
	Quantity DECIMAL(28,8),
	ContractID VARCHAR(50)
)


SET @sSQL = N'
----Tính tổng số lượng theo mặt hàng
SELECT DivisionID, VoucherID, InventoryID, SUM(ActualQuantity) AS Quantity
INTO #Inventory
FROM AT2007 WITH (NOLOCK)
WHERE DivisionID = '''+@DivisionID+'''
AND VoucherID IN ('''+@ListVoucherID+''')
GROUP BY DivisionID, VoucherID, InventoryID

----Tổng cộng số mặt hàng và chi phí cần tính

SELECT A26.DivisionID, A26.VoucherID, A26.VoucherNo, A27.TransactionID, A27.InventoryID, A24.CostID, T1.Quantity, A24.UnitPrice, 
A24.ConvertCoefficient, T4.ExchangeRate, T4.Operator, A20.CurrencyID, A20.ObjectID, A26.WareHouseID, W95.ContractID
INTO #Temp1
FROM AT2006 A26 WITH (NOLOCK)
INNER JOIN AT2007 A27 WITH (NOLOCK) ON A26.DivisionID = A27.DivisionID AND A26.VoucherID = A27.VoucherID
LEFT JOIN WT0095 W95 ON A26.DivisionID = W95.DivisionID AND A27.InheritVoucherID = W95.VoucherID
LEFT JOIN AT1020 A20 WITH (NOLOCK) ON A26.DivisionID = A20.DivisionID AND W95.ContractID = A20.ContractID
LEFT JOIN AT1024 A24 WITH (NOLOCK) ON A26.DivisionID = A24.DivisionID AND W95.ContractID = A24.ContractID
LEFT JOIN #Inventory T1 ON A26.DivisionID = T1.DivisionID AND A26.VoucherID = T1.VoucherID AND A27.InventoryID = T1.InventoryID
LEFT JOIN AV1004 T4 ON A26.DivisionID = T4.DivisionID AND A20.CurrencyID = T4.CurrencyID
WHERE A26.DivisionID = '''+@DivisionID+'''
AND A26.VoucherID IN ('''+@ListVoucherID+''')

----Số mặt hàng và chi phí đã tính

SELECT T1.DivisionID, T1.InheritVoucherID, T1.InheritTransactionID, T1.InventoryID, T1.CostID
INTO #Temp2
FROM WT0098 T1 WITH (NOLOCK)
WHERE T1.DivisionID = '''+@DivisionID+'''
AND T1.InheritVoucherID IN ('''+@ListVoucherID+''')
'
----Load lưới detail
SET @sSQL1 = N'
SELECT 0 AS Choose, T1.DivisionID, T1.VoucherID, T1.VoucherNo, T1.TransactionID, T1.InventoryID, A32.InventoryName, T1.CostID, A33.InventoryName AS CostName,
T1.UnitPrice, T1.ConvertCoefficient, T1.Quantity, T1.ExchangeRate, T1.Operator, T1.CurrencyID, T1.ObjectID, T1.WareHouseID, T1.ContractID
FROM #Temp1 T1 
LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (''@@@'', T1.DivisionID) AND T1.InventoryID = A32.InventoryID
LEFT JOIN AT1302 A33 WITH (NOLOCK) ON A33.DivisionID IN (''@@@'', T1.DivisionID) AND T1.CostID = A33.InventoryID
WHERE NOT EXISTS (SELECT TOP 1 1 FROM #Temp2 T2 WHERE T1.VoucherID = T2.InheritVoucherID AND T1.TransactionID = T2.InheritTransactionID 
				  AND T1.InventoryID = T2.InventoryID AND T1.CostID = T2.CostID)
ORDER BY T1.InventoryID, T1.CostID

DROP TABLE #Temp2
DROP TABLE #Temp1
DROP TABLE #Inventory
'
--PRINT (@sSQL)
--PRINT (@sSQL1)

EXEC (@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
