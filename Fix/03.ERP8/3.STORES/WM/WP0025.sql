IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0025]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0025]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Báo cáo tồn kho an toàn (ANGEL)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 25/11/2016 by Hải Long
----- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung

--exec WP0025 @DivisionID=N'HT', @ReportDate='2016-01-30 00:00:00', @WareHouseID=N'KBP'
-- <Example>

CREATE PROCEDURE WP0025
(
    @DivisionID AS nvarchar(50), 
    @ReportDate AS datetime, 
    @WareHouseID as nvarchar(50)
)
AS

DECLARE 
	@sSQL1 AS nvarchar(4000), 
	@ReportDateText NVARCHAR(50) = ''

		
	
SET @ReportDateText = CONVERT(NVARCHAR(20), @ReportDate, 102)
		
--PRINT @ReportDateText
	
SET @sSQL1 = N'
	Select AV7000.DivisionID, AV7000.InventoryID, AV7000.InventoryName, AV7000.WareHouseID, AV7000.WareHouseName, 
	AV7000.InventoryTypeID, AT1301.InventoryTypeName, AV7000.UnitName, SUM(SignQuantity) AS Quantity, AT1314.MinQuantity, ''' + convert(varchar, @ReportDate, 103) + ''' AS ReportDate
	FROM AV7000 
	LEFT JOIN AT1301 WITH (NOLOCK) ON AV7000.InventoryTypeID = AT1301.InventoryTypeID
	LEFT JOIN AT1314 WITH (NOLOCK) ON AV7000.InventoryID = AT1314.InventoryID AND (''' + @ReportDateText + ''' BETWEEN AT1314.FromDate AND AT1314.ToDate)
	WHERE AV7000.DivisionID = ''' + @DivisionID + '''
	AND AV7000.WareHouseID = ''' + @WareHouseID + '''
	AND (AV7000.VoucherDate <= ''' + @ReportDateText + ''' OR AV7000.D_C = ''BD'')
	GROUP BY AV7000.DivisionID, AV7000.InventoryID, AV7000.InventoryName, AV7000.WareHouseID, AV7000.WareHouseName, 
	AV7000.InventoryTypeID, AT1301.InventoryTypeName, AV7000.UnitName, AT1314.MinQuantity'
		
		 
EXEC(@sSQL1)
--PRINT @sSQL1	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
