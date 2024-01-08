IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MV8701]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[MV8701]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created BY Văn Tài Date 18/07/2020
--Purpose : View tạm để chạy tools fix. Store tạo từ MP8701
CREATE VIEW dbo.MV8701
AS
SELECT     dbo.MT0400.DivisionID, dbo.MT0400.MaterialID, SUM(ISNULL(dbo.MT0400.MaterialQuantity, 0)) AS MaterialQuantity, 
                      SUM(ISNULL(dbo.MT0400.ConvertedAmount, 0)) AS ConvertedAmount, dbo.MT0400.ProductID,
					  MT0400.ProductQuantity as ActualProductQuantity,
                          (SELECT     SUM(dbo.MT1001.Quantity) AS Expr1
                            FROM          dbo.MT1001 INNER JOIN
                                                   dbo.MT0810 ON dbo.MT0810.VoucherID = dbo.MT1001.VoucherID
                            WHERE      (dbo.MT1001.ProductID = dbo.MT0400.ProductID) AND (dbo.MT0810.ResultTypeID = 'R01') AND (dbo.MT0810.PeriodID = '1') AND 
                                                   (dbo.MT0810.DivisionID = '1')) AS ProductQuantity, AT1302_P.UnitID AS ProductUnitID, AT1302_M.UnitID AS MaterialUnitID
FROM         dbo.MT0400 LEFT OUTER JOIN
                      dbo.AT1302 AS AT1302_P ON dbo.MT0400.ProductID = AT1302_P.InventoryID LEFT OUTER JOIN
                      dbo.AT1302 AS AT1302_M ON dbo.MT0400.MaterialID = AT1302_M.InventoryID
WHERE     (dbo.MT0400.DivisionID = '1') AND (dbo.MT0400.PeriodID = '1') AND (dbo.MT0400.ExpenseID = 'COST003') AND (dbo.MT0400.MaterialTypeID = '1') AND
                       (dbo.MT0400.ProductID IN
                          (SELECT     ProductID
                            FROM          dbo.MT2222))
GROUP BY dbo.MT0400.DivisionID, dbo.MT0400.MaterialID, dbo.MT0400.ProductID, dbo.MT0400.ProductQuantity, AT1302_P.UnitID, AT1302_M.UnitID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
