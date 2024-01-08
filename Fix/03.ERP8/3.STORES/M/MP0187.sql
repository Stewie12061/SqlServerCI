IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0187]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0187]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Customize Angel: In Kế hoạch dự tính sản xuất cho ANGEL
---- Created by Tiểu Mai on 06/12/2016
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified on 22/11/2021 by Nhật Thanh: Customize cho Angel
---- MP0187 'ANG',N'24fd7323-f825-46f4-aea0-4aaf92ec4a65'

CREATE PROCEDURE [dbo].[MP0187] 
    @DivisionID NVARCHAR(50),
    @VoucherID AS NVARCHAR(50)
AS

SELECT	MT69.VoucherTypeID, MT69.VoucherNo, MT69.VoucherDate, MT69.[Description], MT69.EmployeeID, MT69.PurchasePlanID,
		MT70.DivisionID, MT70.VoucherID, MT70.TransactionID, MT70.TeamID, MT70.ProductTypeID, MT70.InventoryID, MT70.UnitID, 
		Isnull(MT0171.Quantity,0) AS PlanQuantity,
		CASE WHEN Isnull(MT0171.Quantity,0) <> 0 THEN Isnull(MT0171.Quantity,0) ELSE ISNULL(MT70.Quantity,0) END AS Quantity, MT70.ApportionID, MT70.TableID, MT70.BlockID, MT70.EmployeeNum, MT70.EmployeePower, MT70.[Power], MT70.[Hours], 
		MT70.Orders,	AT1302.InventoryName, AT1015.AnaName as ProductTypeName, AT1304.UnitName, HT1101.TeamName,
		MT0171.RequestDate, MT0171.BeginDate, MT0171.FinishDate
FROM MT0169 MT69 WITH (NOLOCK)
INNER JOIN MT0170 MT70 WITH (NOLOCK) ON MT69.DivisionID = MT70.DivisionID And MT69.VoucherID = MT70.VoucherID
LEFT JOIN MT0171 WITH (NOLOCK) ON MT0171.DivisionID = MT70.DivisionID AND MT0171.VoucherID = MT70.VoucherID AND MT0171.TransactionID = MT70.TransactionID
LEFT JOIN AT1302 WITH (NOLOCK) ON MT70.InventoryID = AT1302.InventoryID AND AT1302.DivisionID IN (MT70.DivisionID,'@@@')
LEFT JOIN AT1015 WITH (NOLOCK) On AT1302.I01ID = AT1015.AnaID and AT1015.AnaTypeID = 'I01' AND AT1302.DivisionID IN (AT1015.DivisionID,'@@@')
LEFT JOIN AT1304 WITH (NOLOCK) On MT70.UnitID = AT1304.UnitID
LEFT JOIN HT1101 WITH (NOLOCK) On MT70.DivisionID = HT1101.DivisionID And MT70.TeamID = HT1101.TeamID
WHERE MT69.DivisionID = @DivisionID AND MT69.VoucherID = @VoucherID
ORDER BY MT70.Orders, MT0171.RequestDate



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
