IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV0035]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0035]
GO
/****** Object: View [dbo].[AV0035] Script Date: 01/04/2011 15:36:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

------ 	Created by Nguyen Van Nhan, date 27/05/2005
-----	Purpose: Xuat kho theo bo, In phieu xuat kho theo bo
---Edit ThuyTuyen 10/07/2007--- lay UnitName
---- Modified on 08/06/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified by Phương Thảo on 10/05/2016 : Sửa danh mục dùng chung
---- Modified by Đức Duy on 17/02/2023: [2023/02/IS/0091] -  Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE VIEW [dbo].[AV0035] 
AS 
SELECT
T26.VOucherNo,	
T26.VoucherDate,
T26.WareHouseID,	
T26.ObjectID,
T12.ObjectName,
T26.Description,
T27.VoucherID,
T03.WareHouseName,
T27.InventoryID,
T02.InventoryName, 
T27.UnitID, 
AT1304.UnitName,
T27.ActualQuantity,
T27.DivisionID,
T27.TranMonth,
T27.TranYear,
T27.Notes,
T27.DebitAccountID,
T27.CreditAccountID,
(
	SELECT SUM(ISNULL(T07.ConvertedAmount,0)) 
	FROM AT2007 T07  WITH (NOLOCK)
	WHERE T07.VoucherID = T27.VoucherID
	AND T27.InventoryID = T07.ProductID
	AND T07.ActualQuantity = T27.ActualQuantity * 
	(
	CASE WHEN T26.TableID = 'MT1603' THEN(
		SELECT MaterialQuantity FROM MT1603  WITH (NOLOCK)
		WHERE MT1603.ProductID = T27.InventoryID AND MT1603.ApportionID = T27.ApportionID 
		AND MT1603.MaterialID = T07.InventoryID AND MT1603.DivisionID = T27.DivisionID )
	ELSE(
		SELECT ItemQuantity FROM AT1326  WITH (NOLOCK)
		WHERE InventoryID = T27.InventoryID AND KitID = T27.ApportionID 
		AND ItemID = T07.InventoryID )
	END
	)
) AS ConvertedAmount,
T27.ApportionID, T27.ApportionTable,T26.TableID		
FROM AT2027 T27  WITH (NOLOCK)
INNER JOIN AT1302 T02 WITH (NOLOCK) ON T02.DivisionID IN ('@@@', T27.DivisionID) AND T27.InventoryID = T02.InventoryID 
LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = T27.UnitID 
INNER JOIN AT2026 T26 WITH (NOLOCK) on T26.VoucherID = T27.VoucherID AND T26.DivisionID = T27.DivisionID
INNER JOIN AT1303 T03 WITH (NOLOCK) on T03.WareHouseID = T26.WareHouseID
LEFT JOIN AT1202 T12 WITH (NOLOCK) on T12.DivisionID IN (T27.DivisionID, '@@@') AND T12.ObjectID = T26.ObjectID 
GO
