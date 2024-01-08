IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP3006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP3006]
GO
/****** Object:  StoredProcedure [dbo].[QCP3006]    Script Date: 11/13/2020 3:01:26 PM ******/
-- <Summary>
---- Lấy dữ liệu báo cáo xử lý lỗi thành phẩm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Create on 13/11/2020 by TAN TAI
-- <Example>
---- 
/*-- <Example>
	EXEC [dbo].[QCP3006]
		@DivisionID = N'VNP',
		@UserID = N'ASOFTADMIN',
		@FromDate = N'2019-11-12 00:00:00.000',
		@ToDate = N'2020-11-15 00:00:00.000',
		@MachineID = N'MAY01',
		@InventoryID = N''
----*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QCP3006]
( 
	 @DivisionID NVARCHAR(50),
	 @UserID NVARCHAR(50),	 
	 @FromDate NVARCHAR(50), 	 
	 @ToDate NVARCHAR(50),
	 @MachineID VARCHAR(MAX),
	 @InventoryID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N''
		SET @sWhere = ''
		IF ISNULL(@DivisionID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2020.DivisionID IN ('''+@DivisionID+''') '
		IF ISNULL(@FromDate, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2020.VoucherDate >= '''+@FromDate+''''
		IF ISNULL(@ToDate, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2020.VoucherDate <= '''+SUBSTRING(@ToDate, 0, 11) + ' 23:59:59' +''''
		IF ISNULL(@MachineID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2000.MachineID IN ('''+@MachineID+''')'
		IF ISNULL(@InventoryID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2001.InventoryID IN ('''+@InventoryID+''')'
		--DROP TABLE #Total_Standard
		DECLARE   @SQLQuery AS NVARCHAR(MAX)
		--select * from  #Total_Standard
		DECLARE   @PivotColumns AS NVARCHAR(MAX)
		SELECT   @PivotColumns= COALESCE(@PivotColumns + ',','') + QUOTENAME(StandardID) 
		FROM (SELECT DISTINCT StandardID FROM QCT1000 where TypeID='BOM') AS PivotExample
		--SELECT  @PivotColumns

		DECLARE   @PivotColumnsSUM AS NVARCHAR(MAX)
		SELECT   @PivotColumnsSUM= COALESCE(@PivotColumnsSUM + ',','') +'SUM(convert (int,'+ QUOTENAME(StandardID)+' )) as ' + QUOTENAME(StandardName)
		FROM (SELECT DISTINCT StandardID,StandardName FROM QCT1000 where TypeID='BOM') AS PivotExample
		--SELECT  @PivotColumnsSUM

SET   @SQLQuery =  N'
		SELECT QCT2020.APK AS QCT2020APK, QCT2001.InventoryID, AT1302.InventoryName,
		QCT2000.VoucherNo AS QCT2000VoucherNo,
		QCT2001.BatchNo AS QCT2001BatchNo,
		QCT2001.NetWeight,
		QCT2021.Description,
		QCT2020.VoucherNo AS QCT2020VoucherNo,
		QCT2021.MaterialID,
		QCT2021.MaterialQuantity,
		QCT2021.MaterialUnitID,
		QCT0099.Description AS Method, QCT2021.NewInventoryID, QCT2021.NewBatchID, QCT2021.NewQuantity  
		FROM QCT2020 QCT2020 WITH(NOLOCK)
		INNER JOIN QCT2021 QCT2021 WITH(NOLOCK) on QCT2021.APKMaster = QCT2020.APK
		INNER JOIN QCT2000 QCT2000 WITH(NOLOCK) on QCT2021.RefAPKMaster = QCT2000.APK
		INNER JOIN QCT2001 QCT2001 WITH(NOLOCK) on QCT2021.RefAPKDetail = QCT2001.APK
		INNER JOIN AT1302 AT1302 ON AT1302.InventoryID = QCT2001.InventoryID
		LEFT JOIN AT1302 AT1302NewInventory ON AT1302NewInventory.InventoryID = QCT2021.NewInventoryID
		LEFT JOIN (SELECT ID, Description FROM QCT0099 WHERE CodeMaster = ''QCF2021Method'') QCT0099 ON QCT2021.Method = QCT0099.ID
		WHERE QCT2020.DeleteFlg = 0 AND QCT2021.DeleteFlg = 0 '+ @sWhere
		print (@SQLQuery)
		EXEC sp_executesql @SQLQuery





