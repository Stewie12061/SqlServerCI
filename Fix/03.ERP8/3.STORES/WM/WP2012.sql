IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2012]
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
----Created by Huỳnh Thử on 20/03/2020
---- Modified by Huỳnh Thử on 30/03/2020: Load thêm loại chi phí lưu kho
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified on by 
-- <Example>
/*
    EXEC WP0129 'HT','ASOFTADMIN', '%', '%','%'
	EXEC WP0129 @DivisionID,@UserID, @ContractID, @ObjectID
*/

 CREATE PROCEDURE WP2012
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
	 @ObjectID VARCHAR(50)
)
AS
SELECT VoucherID, (SUM(CostExPallet) + SUM(EndCostPallet)) AS Total INTO #TEMP FROM WT2004   GROUP BY VoucherID, UnitPrice 

SELECT T1.DivisionID, T1.VoucherID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T3.ObjectName, T1.FromDate, T1.ToDate, 
 (SELECT SUM(#TEMP.Total) FROM #TEMP WHERE #TEMP.VoucherID = T1.VoucherID) AS ToTalPrice,
T1.ExchangeRate, T1.ConvertAmount, T1.CreateUserID, T1.CreateDate, T1.LastModifyUserID, T1.LastModifyDate, T1.IsFinalCost, T1.IsEnd, Case WHEN ISnull(T1.IsRent,0) = 0 THEN N'Lưu kho' else N'Thuê Pallet' end AS Type
FROM WT0099 T1 WITH (NOLOCK)
--LEFT JOIN AT1302 T2 WITH (NOLOCK) ON T1.InventoryID = T2.InventoryID
LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (@DivisionID, '@@@') AND T1.ObjectID = T3.ObjectID
--LEFT JOIN AT1302 T4 ON T1.WareHouseID = T4.InventoryID
--LEFT JOIN AT1304 T5 ON T1.UnitID = T5.UnitID
WHERE T1.DivisionID =  @DivisionID
AND T1.ObjectID LIKE @ObjectID
ORDER BY T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T1.ContractID, T1.WareHouseID, T1.InventoryID, T1.FromDate

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
