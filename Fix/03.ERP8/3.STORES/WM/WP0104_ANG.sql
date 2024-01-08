IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0104_ANG]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[WP0104_ANG]
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created by Tiểu Mai on 24/01/2016
--- Purpose: Load danh sách các mặt hàng dưới mức tồn kho an toàn (Customize cho ANGEL - CustomizeIndex = 57).
--- Modify on 03/05/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
--- Modified on 05/01/2018 by Bảo Anh: Sửa lỗi load dữ liệu sai khi định mức tồn kho thiết lập cho tất cả các kho
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.


CREATE PROCEDURE [dbo].[WP0104_ANG] 
(
	@DivisionID nvarchar(50),
	@TranMonth INT,
	@TranYear INT,
	@WarningStatus NVARCHAR(250)
)
AS

DECLARE @sSQL AS nvarchar(MAX)
		
SET @sSQL = 'SELECT AT2008.WareHouseID, AT1303.WareHouseName, AT2008.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName,
				AT2008.EndQuantity AS CurOriginalQuantity, AT2008.EndQuantity AS CurQuantity, AT1314.ReOrderQuantity,
				AT1314.MinQuantity, At1314.MaxQuantity, 
				(AT1314.ReOrderQuantity - AT2008.EndQuantity) AS DPQuantity,
				(AT1314.ReOrderQuantity - AT2008.EndQuantity) AS DPOriginalQuantity,
				N'''+@WarningStatus+''' AS WarStatus
			FROM AT2008
			LEFT JOIN AT1314 ON AT1314.DivisionID = AT2008.DivisionID AND AT1314.InventoryID = AT2008.InventoryID AND (case when AT1314.WareHouseID = ''%'' then AT2008.WareHouseID else AT1314.WareHouseID end) = AT2008.WareHouseID
			LEFT JOIN AT1302 ON AT1302.DivisionID IN (''@@@'', AT2008.DivisionID) AND AT1302.InventoryID = AT1314.InventoryID
			LEFT JOIN AT1303 ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = AT2008.WareHouseID
			LEFT JOIN AT1304 ON AT1304.UnitID = AT1302.UnitID
			WHERE AT2008.DivisionID = '''+@DivisionID+'''
			AND AT2008.TranMonth = '+convert(nvarchar(2),@TranMonth)+'
			AND AT2008.TranYear = '+convert(nvarchar(5),@TranYear)+'
			AND AT1302.IsMinQuantity = 1
			AND AT2008.EndQuantity <= AT1314.ReOrderQuantity
	'		
			
EXEC (@sSQL)
--PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
