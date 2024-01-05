IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP3001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP3001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- In báo cáo quyết toán
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Bảo Thy on 03/02/2017
---- 
---- Modified on by 
---- Modified by TIểu Mai on 24/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
-- <Example>
/*
    EXEC WMP3001 'ESP','ASOFTADMIN',11,2016,'BIDV'
	EXEC WMP3001 @DivisionID,@UserID,@TranMonth,@TranYear,@ContractID
*/

 CREATE PROCEDURE WMP3001
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @TranMonth INT,
     @TranYear INT,
	 @ContractID VARCHAR(50)
)
AS

SELECT T1.DivisionID, T2.Type, T1.VoucherTypeID, T1.VoucherID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T3.ObjectName, T1.FromDate, T1.ToDate, T1.ContractID, 
T4.ContractNo, T2.DetailVoucherID, T2.DetailVoucherNo, T2.DetailVoucherDate, T2.CostID, ISNULL(T5.InventoryName,N'Chi phí lưu kho') AS CostName, 
T2.WareHouseID AS WareHouseID, T6.InventoryName AS WareHouseName, T2.InventoryID, T7.InventoryName, T2.Quantity, T2.DetailFromDate, T2.DetailToDate, 
T2.UnitPrice, T2.OriginalAmount, T2.ConvertAmount,
CEILING(DATEDIFF(d,T2.DetailFromDate, T2.DetailToDate)/CASE WHEN T1.DayUnit = 0 THEN 1
															WHEN T1.DayUnit = 1 THEN 7
															WHEN T1.DayUnit = 2 THEN 30 END) AS NumDate
FROM WT0100 T1 WITH (NOLOCK)
LEFT JOIN WT0103 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T1.ObjectID = T3.ObjectID
LEFT JOIN AT1020 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.ContractID = T4.ContractID
LEFT JOIN AT1302 T5 WITH (NOLOCK) ON T2.CostID = T5.InventoryID
LEFT JOIN AT1302 T6 WITH (NOLOCK) ON T2.WareHouseID = T6.InventoryID
LEFT JOIN AT1302 T7 WITH (NOLOCK) ON T2.InventoryID = T7.InventoryID
WHERE T1.DivisionID = @DivisionID
AND T1.ContractID = @ContractID
ORDER BY T2.Type, T2.DetailVoucherNo, T2.DetailVoucherDate, T2.CostID, T2.InventoryID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

