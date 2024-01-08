IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7000_LITE]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV7000_LITE]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- View chet. Xu ly so du hang ton kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 10/04/2023 by Đức Tuyên
---- Modified on 06/07/2023 by Văn Tài - Vị trí điều kiện DivisionID đứng trước.
---- Modified on 03/10/2023 by Đức Tuyên - Bổ sung SignQuantity tính tồn kho thực tế.
-- <Example>
---- 

CREATE VIEW [dbo].[AV7000_LITE] AS 

--- So du No cua tai khoan ton kho
SELECT  D17.DivisionID
		, D17.TranMonth
		, D17.TranYear
		, D16.WareHouseID
		, D17.InventoryID
		, D17.ActualQuantity 
		, ActualQuantity AS SignQuantity
From AT2017 AS D17 WITH (NOLOCK)
INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.DivisionID IN ('@@@', D17.DivisionID) AND D16.VoucherID = D17.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN ('@@@', D17.DivisionID) AND AT1202.ObjectID = D16.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('@@@', D17.DivisionID) AND D02.InventoryID = D17.InventoryID
LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.DivisionID IN ('@@@', D17.DivisionID) AND D04.UnitID = D02.UnitID
INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('@@@', D17.DivisionID) AND D03.WareHouseID = D16.WareHouseID
LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.DivisionID IN ('@@@', D17.DivisionID) AND D05.UnitID = D17.ConvertedUnitID

WHERE ISNULL(DebitAccountID, '') <> ''

UNION ALL 

--- So du co hang ton kho
SELECT  D17.DivisionID
		, D17.TranMonth
		, D17.TranYear
		, D16.WareHouseID
		, D17.InventoryID
		, D17.ActualQuantity
		, -ActualQuantity AS SignQuantity
FROM AT2017 AS D17 WITH (NOLOCK) 
INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.DivisionID IN ('@@@', D17.DivisionID) AND D16.VoucherID = D17.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN ('@@@', D17.DivisionID) AND AT1202.ObjectID = D16.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('@@@', D17.DivisionID) AND D02.InventoryID = D17.InventoryID
LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.DivisionID IN ('@@@', D17.DivisionID) AND D04.UnitID = D02.UnitID
INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('@@@', D17.DivisionID) AND D03.WareHouseID = D16.WareHouseID
LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.DivisionID IN ('@@@', D17.DivisionID) AND D05.UnitID = D17.ConvertedUnitID

WHERE ISNULL(CreditAccountID, '') <> ''

UNION ALL  

--- Nhap kho
SELECT  D07.DivisionID
		, D07.TranMonth
		, D07.TranYear
		, D06.WareHouseID
		, D07.InventoryID
		, D07.ActualQuantity
		, ActualQuantity AS SignQuantity
FROM AT2007 AS D07 WITH (NOLOCK)
INNER JOIN AT2006 D06 WITH (NOLOCK) ON  D06.DivisionID IN ('@@@', D07.DivisionID) AND D06.VoucherID = D07.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN ('@@@', D07.DivisionID) AND AT1202.ObjectID = D06.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('@@@', D07.DivisionID) AND D02.InventoryID = D07.InventoryID
LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.DivisionID IN ('@@@', D07.DivisionID) AND D04.UnitID = D02.UnitID
INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('@@@', D07.DivisionID) AND D03.WareHouseID = D06.WareHouseID
LEFT JOIN AT1302 AS P02 WITH (NOLOCK) ON P02.DivisionID IN ('@@@', D07.DivisionID) AND P02.InventoryID = D07.ProductID
LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.DivisionID IN ('@@@', D07.DivisionID) AND D05.UnitID = D07.ConvertedUnitID

WHERE D06.KindVoucherID IN (1, 3, 5, 7, 9, 15, 17) 
		AND ISNULL(D06.TableID, '') <> 'AT0114' ------- Phiếu nhập bù của ANGEL

UNION ALL 

--- xuat kho
SELECT  D07.DivisionID
		, D07.TranMonth
		, D07.TranYear
		, CASE WHEN D06.KindVoucherID = 3 
			THEN D06.WareHouseID2 
			ELSE D06.WareHouseID 
			End 
			AS WareHouseID
		, D07.InventoryID
		, ActualQuantity
		, -ActualQuantity AS SignQuantity

FROM AT2007 AS D07 WITH (NOLOCK)
INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.DivisionID IN ('@@@', D07.DivisionID) AND D06.VoucherID = D07.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in ('@@@', D07.DivisionID) AND AT1202.ObjectID = D06.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('@@@', D07.DivisionID) AND D02.InventoryID = D07.InventoryID
LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.DivisionID IN ('@@@', D07.DivisionID) AND D04.UnitID = D02.UnitID
INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('@@@', D07.DivisionID) AND D03.WareHouseID = D06.WareHouseID
LEFT JOIN AT1302 AS P02 WITH (NOLOCK) ON P02.DivisionID IN ('@@@', D07.DivisionID) AND P02.InventoryID = D07.ProductID
LEFT JOIN AT1303 AS  D031 WITH (NOLOCK) ON D031.DivisionID IN ('@@@', D07.DivisionID) AND D031.WareHouseID = D06.WareHouseID2 
LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.DivisionID IN ('@@@', D07.DivisionID) AND D05.UnitID = D07.ConvertedUnitID

WHERE D06.KindVoucherID in (2, 3, 4, 6, 8, 10, 14, 20)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

