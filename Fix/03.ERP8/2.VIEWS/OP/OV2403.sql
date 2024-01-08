IF EXISTS (
		SELECT TOP 1 1
		FROM DBO.SYSOBJECTS
		WHERE ID = OBJECT_ID(N'[DBO].[OV2403]')
			AND OBJECTPROPERTY(ID, N'IsView') = 1
		)
	DROP VIEW [DBO].[OV2403]
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

------- 	Created by Đinh Đức Thông
------- 	Created Date 04/09/2020
------ 	Purpose:  Tinh hinh nhap xuat cua cac mat hang (view chet)

CREATE VIEW [dbo].[OV2403]
AS
SELECT AT2008.DivisionID
	,WareHouseID
	,InventoryID
	,SUM(BeginQuantity) AS BeginQuantity
	,SUM(EndQuantity) AS EndQuantity
	,TranMonth
	,TranYear
FROM AT2008 WITH (NOLOCK)
GROUP BY AT2008.DivisionID
	,WareHouseID
	,InventoryID
	,TranMonth
	,TranYear
GO

SET QUOTED_IDENTIFIER OFF
GO

SET ANSI_NULLS ON
GO



