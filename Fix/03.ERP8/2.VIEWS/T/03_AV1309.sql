IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV1309]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV1309]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 CREATE VIEW AV1309 AS 
		SELECT AT2008.WareHouseID, 
			AT2008.InventoryID, 
			AT2008.InventoryAccountID, 
			--AT1302.InventoryName AS InventoryName, 
			--AT1303.WareHouseName AS WareHouseName, 
			AT2008.DivisionID,
			SUM(ISNULL(AT2008.BeginQuantity, 0)) AS ActBegQty, 
			SUM(ISNULL(AT2008.BeginAmount, 0)) AS ActBegTotal, 
			SUM(ISNULL(AT2008.DebitQuantity, 0)) AS ActReceivedQty, 
			SUM(ISNULL(AT2008.DebitAmount, 0)) AS ActReceivedTotal, 
			SUM(ISNULL(AT2008.CreditQuantity, 0)) AS ActDeliveryQty, 
			SUM(ISNULL(AT2008.EndQuantity, 0)) AS ActEndQty, 
			CASE WHEN (SUM(ISNULL(AT2008.BeginQuantity, 0) + ISNULL(AT2008.DebitQuantity, 0)
					  )) = 0 
				THEN 0 
				ELSE convert(decimal(28,8),(SUM(ISNULL(AT2008.BeginAmount, 0) + ISNULL(AT2008.DebitAmount, 0)) - ISNULL((Select SUM(AT2007.ConvertedAmount) From AT2007 Inner join AT2006 on AT2006.DivisionID = AT2007.DivisionID And AT2006.VoucherID = AT2007.VoucherID Where AT2007.DivisionID = AT2008.DivisionID And AT2007.TranMonth = 6 And AT2007.TranYear = 2020 And AT2006.WarehouseID = AT2008.WarehouseID And AT2006.KindVoucherID = 10 And AT2007.InventoryID = AT2008.InventoryID And Isnull(AT2007.ActualQuantity,0) = 0),0))) / 
					convert(decimal(28,8),(SUM(ISNULL(AT2008.BeginQuantity, 0) + ISNULL(AT2008.DebitQuantity, 0))
						)) 
			END AS UnitPrice,
			0 AS UnitPrice2
		FROM AT2008  WITH (NOLOCK)
		--INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT2008.InventoryID 
		--INNER JOIN AT1303 WITH (NOLOCK) ON AT1303.WareHouseID = AT2008.WareHouseID 
		WHERE AT2008.DivisionID = 'CBN' 
			AND AT2008.TranYear =       2020 
			AND AT2008.TranMonth =          6 
			AND (SELECT MethodID FROM AT1302 WITH (NOLOCK) WHERE InventoryID = AT2008.InventoryID) = 4
			AND (AT2008.WareHouseID BETWEEN 'KBH' AND 'KST-CN') 
			AND (AT2008.InventoryAccountID BETWEEN '153' AND '157') 
			AND (AT2008.InventoryID BETWEEN '.' AND 'ZZZ') 
		GROUP BY AT2008.WareHouseID, 
			AT2008.InventoryID, 
			--AT1303.WareHouseName, 
			--AT1302.InventoryName, 
			AT2008.InventoryAccountID,
			AT2008.DivisionID 
		
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
