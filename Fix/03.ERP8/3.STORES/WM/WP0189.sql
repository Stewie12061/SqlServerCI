IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0189]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0189]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Kế thừa lệnh sản xuất từ màn hình nghiệp vụ xuất kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 08/03/2023 by Nhật Thanh
---- Modified on 27/04/2023 by Đức Duy : Sửa lỗi ẩn kế thừa Lệnh sản xuất
---- Modified on 28/04/2023 by Đức Duy : Fix lỗi ẩn kế thừa Lệnh sản xuất
---- Modified on 23/05/2023 by Viết Toàn : Cho phép kế thừa 1 lệnh sản xuất nhiều lần cho đến khi lệnh chuyển trạng thái hoàn tất - Customize THABICO
---- Modified on 05/06/2023 by Phương Thảo : Xử lý kế thừa thay bao bì - Customize THABICO
---- Modified on 16/06/2023 by Viết Toàn : Bổ sung phương thức lọc theo LineProduceID
-- <Example>
---- 
--exec WP0189 @DivisionID=N'EXV',@UserID=N'ASOFTADMIN',@ObjectID=N'%',@FromMonth=11,@FromYear=2022,@ToMonth=1,@ToYear=2023,@IsDisplayAll=0

CREATE PROCEDURE WP0189
( 
		@DivisionID AS NVARCHAR(50),
		@UserID AS NVARCHAR(50),
		@ObjectID AS NVARCHAR(50),
		@FromMonth AS INT,
		@FromYear AS INT,
		@ToMonth AS INT,
		@ToYear AS INT,
		@IsDisplayAll AS INT,
		@LineProduceID NVARCHAR(50) = N''
		
) 
AS 
DECLARE @Ssql AS NVARCHAR(4000),
        @Ssql1 AS NVARCHAR(4000),
		@SWhere AS NVARCHAR(4000),
		@SWhere1 AS NVARCHAR(4000),
		@sSQLFrom as NVARCHAR(MAX),
		@subColumn as NVARCHAR(MAX) = N'',
		@subColumn1 as NVARCHAR(MAX) = N'',
		@CustomerIndex INT

SET @CustomerIndex = (SELECT CustomerName FROM CustomerIndex)

IF @CustomerIndex = 146
BEGIN
	SET @SWhere = ' AND M60.OrderStatus <> 2 AND ISNULL(M60.IsChangePack, 0) = 0'
	SET @subColumn = @subColumn + N' (ISNULL(M61.MaterialQuantity,0) - ISNULL(A07.Quantity,0)) AS RemainQuantity, '
	SET @SWhere1 = ' AND M60.OrderStatus <> 2 AND ISNULL(M60.IsChangePack, 0) = 1'
	SET @subColumn1 = @subColumn1 + N' M60.ProductQuantity AS RemainQuantity, '

END
ELSE
BEGIN
	SET @SWhere = ' AND (M61.MaterialQuantity - ISNULL(A07.Quantity,0)) > 0'
	SET @SWhere1 = ''
	SET @subColumn = @subColumn + N' MaterialQuantity - ISNULL(A07.Quantity, 0) AS RemainQuantity, '
END
	
IF( @CustomerIndex = 146)-- Customize cho Thabico
BEGIN
---Nếu không thay bao bì lấy detail(MT2161)
SET @Ssql = '
		SELECT 
		M61.APK, M61.DivisionID, M60.TranMonth, M60.TranYear, 
		M60.VoucherNo, M60.VoucherDate, 
		'''' VoucherTypeID, M60.VoucherNo EstimateID, '''' MDescription, '''' TransactionID, A02.IsSource, 0 IsLimitDate, 1 MethodID, 1 Orders,
		M60.MPlanID, M60.MOrderID,
		ObjectID, ObjectName,M61.Description,  
		'''' AS WareHouseID, 
	    M61.MaterialID, M61.MaterialName, 
		M61.UnitID, M61.PhaseID, PhaseName, M61.MachineID, MachineName, M61.StartDate,
		CONVERT(DATETIME, NULL) AS EstimateExportDate,  
		M61.MaterialQuantity AS MaterialQuantity,
		MaterialQuantity AS StandardMaterialQuantity, M61.UnitID AS StandardQuantityUnit,
		(	SELECT	MAX(VoucherDate) 
			FROM	AT2006 WITH (NOLOCK) 
			INNER JOIN AT2007 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID  AND AT2006.DivisionID = AT2007.DivisionID 
		 	WHERE	AT2007.ETransactionID = TransactionID) AS ExportDate,
		ISNULL(A07.Quantity, 0) AS InheritedQuantity,'
		+ @subColumn +
		''''' AS PeriodID, '''' AS PeriodName,
		ProductID, ProductName ,
		'''' AS Ana01ID, 
		'''' AS Ana02ID, 
		'''' AS Ana03ID, 
		'''' AS Ana04ID, 
		'''' AS Ana05ID, 
		'''' AS Ana06ID, 
		'''' AS Ana07ID, 
		'''' AS Ana08ID, 
		'''' AS Ana09ID, 
		'''' AS Ana10ID, 
		'''' AS Ana01Name, 
		'''' AS Ana02Name, 
		'''' AS Ana03Name, 
		'''' AS Ana04Name, 
		'''' AS Ana05Name,
		'''' AS Ana06Name, 
		'''' AS Ana07Name, 
		'''' AS Ana08Name, 
		'''' AS Ana09Name, 
		'''' AS Ana10Name,
		'''' AS SOrderID, 
		'''' AS MTransactionID, 
		'''' AS STransactionID,
		'''' as S01ID, '''' as S02ID, '''' as S03ID, '''' as S04ID, '''' as S05ID, '''' as S06ID, '''' as S07ID, '''' as S08ID, '''' as S09ID, '''' as S10ID,
		'''' as S11ID, '''' as S12ID, '''' as S13ID, '''' as S14ID, '''' as S15ID, '''' as S16ID, '''' as S17ID, '''' as S18ID, '''' as S19ID, '''' as S20ID,
		NULL AS Parameter01, NULL AS Parameter02, NULL AS Parameter03, NULL AS Parameter04, NULL AS Parameter05, A02.AccountID, M60.SourceNo
FROM MT2161 M61 WITH(NOLOCK)
LEFT JOIN MT2160 M60 WITH(NOLOCK) ON M60.APK = M61.APKMaster
LEFT JOIN AT0126 A26 WITH(NOLOCK) ON A26.PhaseID = M61.PhaseID
LEFT JOIN CIT1150 C50 WITH(NOLOCK) ON C50.MachineID = M61.MachineID
LEFT JOIN AT1302 A02 ON A02.InventoryID = M61.MaterialID 
LEFT JOIN (SELECT APKMT2161, SUM(ISNULL(ActualQuantity,0)) as Quantity
			FROM AT2007 WITH (NOLOCK)
			WHERE DivisionID = '''+@DivisionID+'''
			GROUP BY APKMT2161) AS A07 ON CONVERT(nvarchar(50), A07.APKMT2161) = CONVERT(nvarchar(50),M61.APK)
WHERE M60.DeleteFlg <> 1 AND M60.TranMonth + M60.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' AND ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))+ @SWhere
---Nếu có thay bao bì lấy Master(MT2160)
SET @Ssql1 = '
UNION ALL
		SELECT DISTINCT
		M60.APK, M60.DivisionID, M60.TranMonth, M60.TranYear, 
		M60.VoucherNo, M60.VoucherDate, 
		'''' VoucherTypeID, M60.VoucherNo EstimateID, '''' MDescription, '''' TransactionID, A02.IsSource, 0 IsLimitDate, 1 MethodID, 1 Orders,
		M60.MPlanID, M60.MOrderID,
		'''' AS ObjectID, '''' AS ObjectName,M61.Description,  
		'''' AS WareHouseID, 
	    M60.ProductID AS MaterialID, M60.ProductName AS MaterialName,  
		A04.UnitID, M42.PhaseID, A26.PhaseName, M42.MachineID, C50.MachineName, M41.StartDate,
		CONVERT(DATETIME, NULL) AS EstimateExportDate,  
		ISNULL(M60.ProductQuantity,0)  AS MaterialQuantity,
		ISNULL(M60.ProductQuantity,0)  AS StandardMaterialQuantity, A02.UnitID AS StandardQuantityUnit,
		(	SELECT	MAX(VoucherDate) 
			FROM	AT2006 WITH (NOLOCK) 
			INNER JOIN AT2007 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID  AND AT2006.DivisionID = AT2007.DivisionID 
		 	WHERE	AT2007.ETransactionID = TransactionID) AS ExportDate,
		0 AS InheritedQuantity,'
		+ @subColumn1 +
		''''' AS PeriodID, '''' AS PeriodName,
		ProductID, ProductName ,
		'''' AS Ana01ID, 
		'''' AS Ana02ID, 
		'''' AS Ana03ID, 
		'''' AS Ana04ID, 
		'''' AS Ana05ID, 
		'''' AS Ana06ID, 
		'''' AS Ana07ID, 
		'''' AS Ana08ID, 
		'''' AS Ana09ID, 
		'''' AS Ana10ID, 
		'''' AS Ana01Name, 
		'''' AS Ana02Name, 
		'''' AS Ana03Name, 
		'''' AS Ana04Name, 
		'''' AS Ana05Name,
		'''' AS Ana06Name, 
		'''' AS Ana07Name, 
		'''' AS Ana08Name, 
		'''' AS Ana09Name, 
		'''' AS Ana10Name,
		'''' AS SOrderID, 
		'''' AS MTransactionID, 
		'''' AS STransactionID,
		'''' as S01ID, '''' as S02ID, '''' as S03ID, '''' as S04ID, '''' as S05ID, '''' as S06ID, '''' as S07ID, '''' as S08ID, '''' as S09ID, '''' as S10ID,
		'''' as S11ID, '''' as S12ID, '''' as S13ID, '''' as S14ID, '''' as S15ID, '''' as S16ID, '''' as S17ID, '''' as S18ID, '''' as S19ID, '''' as S20ID,
		NULL AS Parameter01, NULL AS Parameter02, NULL AS Parameter03, NULL AS Parameter04, NULL AS Parameter05, A02.AccountID, M60.SourceNo
FROM MT2160 M60 WITH(NOLOCK)
LEFT JOIN MT2161 M61 WITH(NOLOCK) ON M60.APK = M61.APKMaster
--LEFT JOIN AT0126 A26 WITH(NOLOCK) ON A26.PhaseID = M61.PhaseID
--LEFT JOIN CIT1150 C50 WITH(NOLOCK) ON C50.MachineID = M61.MachineID
LEFT JOIN AT1302 A02 ON A02.InventoryID = M60.ProductID 
LEFT JOIN AT1304 A04 WITH(NOLOCK) ON A04.UnitID = A02.UnitID
LEFT JOIN MT2142 M42 WITH (NOLOCK) ON M42.MaterialID = M60.ProductID AND M42.APK = M61.InheritVoucherID
LEFT JOIN MT2141 M41 WITH (NOLOCK) ON M41.APK = M42.APK_MT2141
LEFT JOIN AT0126 A26 WITH(NOLOCK) ON A26.PhaseID = M42.PhaseID
LEFT JOIN CIT1150 C50 WITH(NOLOCK) ON C50.MachineID = M42.MachineID 
WHERE M60.DeleteFlg <> 1 AND M60.TranMonth + M60.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' AND ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))+ @SWhere1

END
ELSE	
--- Luồng chuẩn
BEGIN

IF @LineProduceID = '%'
	SET @SWhere = @SWhere + ' AND M42.LineProduceID LIKE ''%'' '
ELSE
	SET @SWhere = @SWhere + ' AND M42.LineProduceID = '''+ @LineProduceID +''' '

SET @Ssql = '
		SELECT 
		M61.APK, M61.DivisionID, M60.TranMonth, M60.TranYear, 
		M60.VoucherNo, M60.VoucherDate, 
		'''' VoucherTypeID, M60.VoucherNo EstimateID, '''' MDescription, '''' TransactionID, A02.IsSource, 0 IsLimitDate, 1 MethodID, 1 Orders,
		M60.MPlanID, M60.MOrderID,
		ObjectID, ObjectName, M61.Description,  
		'''' AS WareHouseID, 
	    M61.MaterialID, M61.MaterialName, 
		M61.UnitID, M61.PhaseID, A26.PhaseName, M61.MachineID, C50.MachineName, M61.StartDate,
		CONVERT(DATETIME, NULL) AS EstimateExportDate,  
		(ISNULL(M61.MaterialQuantity,0) - ISNULL(A07.Quantity,0)) AS MaterialQuantity,
		MaterialQuantity AS StandardMaterialQuantity, M61.UnitID AS StandardQuantityUnit,
		(	SELECT	MAX(VoucherDate) 
			FROM	AT2006 WITH (NOLOCK) 
			INNER JOIN AT2007 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID  AND AT2006.DivisionID = AT2007.DivisionID 
		 	WHERE	AT2007.ETransactionID = TransactionID) AS ExportDate,
		ISNULL(A07.Quantity, 0) AS InheritedQuantity,'
		+ @subColumn +
		''''' AS PeriodID, '''' AS PeriodName,
		ProductID, ProductName ,
		'''' AS Ana01ID, 
		'''' AS Ana02ID, 
		'''' AS Ana03ID, 
		'''' AS Ana04ID, 
		'''' AS Ana05ID, 
		M42.LineProduceID AS Ana06ID, 
		'''' AS Ana07ID, 
		'''' AS Ana08ID, 
		'''' AS Ana09ID, 
		'''' AS Ana10ID, 
		'''' AS Ana01Name, 
		'''' AS Ana02Name, 
		'''' AS Ana03Name, 
		'''' AS Ana04Name, 
		'''' AS Ana05Name,
		'''' AS Ana06Name, 
		'''' AS Ana07Name, 
		'''' AS Ana08Name, 
		'''' AS Ana09Name, 
		'''' AS Ana10Name,
		'''' AS SOrderID, 
		'''' AS MTransactionID, 
		'''' AS STransactionID,
		'''' as S01ID, '''' as S02ID, '''' as S03ID, '''' as S04ID, '''' as S05ID, '''' as S06ID, '''' as S07ID, '''' as S08ID, '''' as S09ID, '''' as S10ID,
		'''' as S11ID, '''' as S12ID, '''' as S13ID, '''' as S14ID, '''' as S15ID, '''' as S16ID, '''' as S17ID, '''' as S18ID, '''' as S19ID, '''' as S20ID,
		NULL AS Parameter01, NULL AS Parameter02, NULL AS Parameter03, NULL AS Parameter04, NULL AS Parameter05, A02.AccountID, M60.SourceNo
FROM MT2161 M61 WITH(NOLOCK)
LEFT JOIN MT2160 M60 WITH(NOLOCK) ON M60.APK = M61.APKMaster
LEFT JOIN MT2142 M42 WITH(NOLOCK) ON M42.APK = M60.InheritTransactionID AND M42.MaterialID = M60.ProductID
LEFT JOIN AT0126 A26 WITH(NOLOCK) ON A26.PhaseID = M61.PhaseID
LEFT JOIN CIT1150 C50 WITH(NOLOCK) ON C50.MachineID = M61.MachineID
LEFT JOIN AT1302 A02 ON A02.InventoryID = M61.MaterialID 
LEFT JOIN (SELECT APKMT2161, SUM(ISNULL(ActualQuantity,0)) as Quantity
			FROM AT2007 WITH (NOLOCK)
			WHERE DivisionID = '''+@DivisionID+'''
			GROUP BY APKMT2161) AS A07 ON CONVERT(nvarchar(50), A07.APKMT2161) = CONVERT(nvarchar(50),M61.APK)
WHERE M60.DeleteFlg <> 1 AND M60.TranMonth + M60.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' AND ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))+ @SWhere

END
PRINT(@Ssql)
PRINT(@Ssql1)
PRINT(@sSQLFrom)
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME ='WQ3027')
	EXEC ('CREATE VIEW WQ3027  ---TAO BOI WP0189
		AS '+@sSQL + @Ssql1 +@sSQLFrom )
ELSE
	EXEC( 'ALTER VIEW WQ3027  ---TAO BOI WP0189
		AS '+@sSQL + @Ssql1 +@sSQLFrom)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
