IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP3004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP3004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Báo cáo chi tiết theo dõi tình hình thực hiện kế hoạch sản xuất
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đình Hòa on: 11/05/2021
---- Modify by : Phương thảo: 5/5/2023 --- leftjoin với ot2202  dự trù chi phí để lấy đơn hàng sản xuất
---- Modify by : Phương Thảo: 07/06/2023 --- Tạm thời bỏ điều kiện check trạng thái kê hoạch sản xuất = 2 để lên được số lượng thực tế = số lượng kế hoạch
---- Modify by : Phương Thảo: 22/06/2023 ---  fix lỗi lấy thiếu lệnh được kế thừa từ kế hoạch 
---- Modify by : Nhật Thanh: 18/09/2023 : Bổ sung cột tỷ lệ
---- Modify by : Hồng Thắm : 05/12/2023 : Bổ sung cột đặc tính kỹ thuật thành phẩm và đặc tính kỹ thuật nguyên vật liệu
CREATE PROCEDURE MP3004
(
	@DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(2000),
	@IsDate INT, ---- 1: là ngày, 0: là kỳ
	@FromDate DATETIME,
	@ToDate DATETIME,
	@PeriodList NVARCHAR(MAX),
	@ProductionOrderID NVARCHAR(MAX),
	@ProduceOrderID NVARCHAR(MAX),
	@InventoryID NVARCHAR(MAX)
)
AS

DECLARE @sSQL NVARCHAR (MAX)='',
        @sWhere NVARCHAR(MAX)='',
		@CustomerName INT = (SELECT CustomerName FROM CustomerIndex)
        
--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	BEGIN
		SET @sWhere = ' M1.DivisionID IN ('''+@DivisionIDList+''')'
	END
ELSE 
	BEGIN
		SET @sWhere = ' M1.DivisionID = N'''+@DivisionID+''''
	END

IF @IsDate = 1
	BEGIN
	IF ISNULL(@PeriodList,'') <> ''
		SET @sWhere = @sWhere + ' AND ((CASE WHEN M1.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(M1.TranMonth)))+''/''+ltrim(Rtrim(str(M1.TranYear))) in ('''+@PeriodList +'''))'
	END
ELSE
	BEGIN
	IF ISNULL(@FromDate,'') <> ''
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(20), M1.VoucherDate,112) BETWEEN ''' + CONVERT(VARCHAR(20),@FromDate,112) + ''' AND ''' + CONVERT(VARCHAR(20),Isnull(@ToDate,'12/31/9999'),112) + ''''
	END


IF ISNULL(@ProductionOrderID, '') != '' 
BEGIN
	SET @sWhere = @sWhere + ' AND M9.VoucherNo = ''' + @ProductionOrderID + ''''
END

IF ISNULL(@ProduceOrderID, '') != '' 
BEGIN
	SET @sWhere = @sWhere + ' AND M3.VoucherNo = '''+ @ProduceOrderID +''' '
END

IF ISNULL(@InventoryID, '') != '' 
BEGIN
	SET @sWhere = @sWhere + ' AND M2.InventoryID = '''+ rtrim(ltrim(@InventoryID)) +''''
END

IF @CustomerName = 117
BEGIN
	SET @sSQL = N' 
	SELECT DISTINCT M3.VoucherNo AS VoucherNo_DHSX, M1.VoucherNo AS VoucherNo_TP, M1.VoucherDate AS VoucherDate_TP, ISNULL(M3.DepartmentID, M15.DepartmentID), M6.DepartmentName,M4.InventoryID AS InventoryID_TP, M5.InventoryName AS InventoryName_TP 
	, M4.UnitID AS UnitID_TP, M7.UnitName AS Unitname_TP, M4.OrderQuantity AS QuantityRequest_TP, M2.StartDate AS StartDate_TP, M2.EndDatePlan AS EndDatePlan_TP, M2.Quantity AS QuantityActual_TP
	, M9.ProductID AS InventoryID_BTP, M9.ProductName AS InventoryName_BTP, S81.OffsetQuantity AS QuantityActual_BTP, S81.ActualQuantity AS QuantityRequest_BTP, M7_1.UnitName AS UnitName_BTP,M9.VoucherNo AS VoucherNo_NVL, M9.VoucherDate AS VoucherDate_NVL, M10.MaterialID AS InventoryID_NVL, M10.MaterialName AS InventoryName_NVL, M10.UnitID  AS UnitID_NVL, M10.UnitName AS Unitname_NVL,  M13.QuantityActual_NVL
	, M8.StartDateManufacturing AS StartDate_NVL, M2.EndDatePlan AS EndDatePlan_NVL, M4.OrderQuantity * M12.QuantitativeValue AS QuantityRequest_NVL
	FROM MT2140 M1 WITH(NOLOCK)
	LEFT JOIN MT2141 M2 WITH(NOLOCK) ON M1.APK = M2.APKMaster AND M1.DivisionID = M2.DivisionID
	LEFT JOIN ot2202 M14 WITH (NOLOCK) ON  M2.VoucherNoProduct = M14.EstimateID AND M14.DivisionID IN(M1.DivisionID,''@@@'')    --thêm vào : left join với dự trù chi phí để lấy đơn hàng sản xuất
	LEFT JOIN OT2201 M15 WITH (NOLOCK) ON M15.EstimateID = M14.EstimateID AND M14.DivisionID = M15.DivisionID
	LEFT JOIN OT2001 M3 WITH(NOLOCK) ON M14.Ana08ID = M3.VoucherNo AND M3.OrderType = 0 AND M1.DivisionID = M3.DivisionID     ---thay đôi M14.MOrderID = M3.VoucherNo 
	LEFT JOIN OT2002 M4 WITH(NOLOCK) ON M3.SOrderID = M4.SOrderID AND M3.DivisionID = M4.DivisionID AND M2.InventoryID = M4.InventoryID
	LEFT JOIN AT1302 M5 WITH(NOLOCK) ON M4.InventoryID = M5.InventoryID AND M5.DivisionID IN (M1.DivisionID, ''@@@'')
	LEFT JOIN AT1102 M6 WITH(NOLOCK) ON ISNULL(M3.DepartmentID, M15.DepartmentID) = M6.DepartmentID AND M6.DivisionID IN (M1.DivisionID, ''@@@'') and M6.Disabled = 0
	LEFT JOIN AT1304 M7 WITH(NOLOCK) ON M4.UnitID = M7.UnitID AND M7.DivisionID IN (M1.DivisionID, ''@@@'')
	LEFT JOIN MT2142 M8 WITH(NOLOCK) ON M8.APKMaster = M1.APK AND M2.VoucherNoProduct = M8.VoucherNoProduct AND M8.DivisionID = M1.DivisionID
	LEFT JOIN MT2160 M9 WITH(NOLOCK) ON M9.MOrderID = M2.VoucherNoProduct  AND M9.MOrderID = M8.VoucherNoProduct AND M9.MPlanID = M1.VoucherNo AND  M9.DivisionID = M2.DivisionID AND m9.DeleteFlg = 0
	LEFT JOIN MT2161 M10 WITH(NOLOCK) ON M10.APKMaster = M9.APK AND M10.DivisionID = M9.DivisionID
	LEFT JOIN SOT2080 S80 WITH (NOLOCK) ON S80.VoucherNo = M14.MOrderID AND S80.DivisionID = M1.DivisionID
	LEFT JOIN SOT2081 S81 WITH (NOLOCK) ON S81.APKMaster = S80.APK AND M9.ProductID = S81.SemiProduct
	LEFT JOIN AT1302 M5_1 WITH (NOLOCK) ON M9.ProductID = M5_1.InventoryID AND M5_1.DivisionID = M9.DivisionID
	LEFT JOIN AT1304 M7_1 WITH (NOLOCK) ON M7_1.UnitID = M5_1.UnitID
	LEFT JOIN MT2120 M11 WITH (NOLOCK) ON  M11.NodeID = M4.InventoryID AND M11.DivisionID = M4.DivisionID
	LEFT JOIN MT2121 M12 WITH (NOLOCK) ON M11.APK = M12.APK_2120 AND M12.NodeTypeID <> 0 AND M8.PhaseID = M12.PhaseID AND M12.DivisionID = M11.DivisionID
	INNER JOIN (SELECT SUM(MaterialQuantity) AS QuantityActual_NVL, M61.MaterialID, M60.APK
	FROM MT2160 M60 WITH(NOLOCK)
	LEFT JOIN MT2161 M61 WITH(NOLOCK) ON M60.APK = M61.APKMaster AND M61.DivisionID = M60.DivisionID
	GROUP BY M61.MaterialID, M60.APK) AS M13 ON M13.APK = M9.APK AND M13.MaterialID = M10.MaterialID AND M12.NodeID = M13.MaterialID
	WHERE '+@sWhere+'	
	ORDER BY M3.VoucherNo, M1.VoucherNo, M9.VoucherNo
	'
END
ELSE
BEGIN
	SET @sSQL = N' 
	SELECT DISTINCT M3.VoucherNo AS VoucherNo_DHSX, M1.VoucherNo AS VoucherNo_TP, M1.VoucherDate AS VoucherDate_TP, M3.DepartmentID, M6.DepartmentName,M4.InventoryID AS InventoryID_TP, M5.InventoryName AS InventoryName_TP 
	, M4.UnitID AS UnitID_TP, M7.UnitName AS Unitname_TP, M4.OrderQuantity AS QuantityRequest_TP, M2.StartDate AS StartDate_TP, M2.EndDatePlan AS EndDatePlan_TP, M2.Quantity AS QuantityActual_TP, Case when M2.Quantity = 0 then 0 else isnull(M2.Quantity,0)/isnull(M4.OrderQuantity,0) end as Rate_TP
	,M9.ProductID , M9.VoucherNo AS VoucherNo_NVL, M9.VoucherDate AS VoucherDate_NVL, M10.MaterialID AS InventoryID_NVL, M10.MaterialName AS InventoryName_NVL, M10.UnitID  AS UnitID_NVL, M10.UnitName AS Unitname_NVL,  M13.QuantityActual_NVL
	, M8.StartDateManufacturing AS StartDate_NVL, M2.EndDatePlan AS EndDatePlan_NVL, M4.OrderQuantity * M12.QuantitativeValue AS QuantityRequest_NVL
	, Case when M2.Quantity = 0 then 0 else isnull(M13.QuantityActual_NVL,0)/isnull(M4.OrderQuantity * M12.QuantitativeValue,0) end as Rate_NVL, M5.Specification as Specification_TP, M10.Specification as Specification_NVL
	FROM MT2140 M1 WITH(NOLOCK)
	LEFT JOIN MT2141 M2 WITH(NOLOCK) ON M1.APK = M2.APKMaster AND M1.DivisionID = M2.DivisionID
	LEFT JOIN ot2202 M14 WITH (NOLOCK) ON  M2.VoucherNoProduct = M14.EstimateID AND M14.DivisionID IN(M1.DivisionID,''@@@'')    --thêm vào : left join với dự trù chi phí để lấy đơn hàng sản xuất
	LEFT JOIN OT2001 M3 WITH(NOLOCK) ON M14.MOrderID = M3.VoucherNo AND M3.OrderType = 1 AND M1.DivisionID = M3.DivisionID     ---thay đôi M14.MOrderID = M3.VoucherNo 
	LEFT JOIN OT2002 M4 WITH(NOLOCK) ON M3.VoucherNo = M4.SOrderID AND M3.DivisionID = M4.DivisionID AND M2.InventoryID = M4.InventoryID
	LEFT JOIN AT1302 M5 WITH(NOLOCK) ON M4.InventoryID = M5.InventoryID AND M5.DivisionID IN (M1.DivisionID, ''@@@'')
	LEFT JOIN AT1102 M6 WITH(NOLOCK) ON M3.DepartmentID = M6.DepartmentID AND M6.DivisionID IN (M1.DivisionID, ''@@@'') and M6.Disabled = 0
	LEFT JOIN AT1304 M7 WITH(NOLOCK) ON M4.UnitID = M7.UnitID AND M7.DivisionID IN (M1.DivisionID, ''@@@'')
	LEFT JOIN MT2142 M8 WITH(NOLOCK) ON M8.APKMaster = M1.APK AND M2.VoucherNoProduct = M8.VoucherNoProduct AND M8.DivisionID = M1.DivisionID
	LEFT JOIN MT2160 M9 WITH(NOLOCK) ON M9.MOrderID = M2.VoucherNoProduct  AND M9.MOrderID = M8.VoucherNoProduct AND M9.MPlanID = M1.VoucherNo AND  M9.DivisionID = M2.DivisionID AND m9.DeleteFlg = 0
	LEFT JOIN MT2161 M10 WITH(NOLOCK) ON M10.APKMaster = M9.APK AND M10.DivisionID = M9.DivisionID
	LEFT JOIN MT2120 M11 WITH (NOLOCK) ON  M11.NodeID = M4.InventoryID AND M11.DivisionID = M4.DivisionID
	LEFT JOIN MT2121 M12 WITH (NOLOCK) ON M11.APK = M12.APK_2120 AND M12.NodeTypeID <> 0 AND M8.PhaseID = M12.PhaseID AND M12.DivisionID = M11.DivisionID
	INNER JOIN (SELECT SUM(MaterialQuantity) AS QuantityActual_NVL, M61.MaterialID, M60.APK
	FROM MT2160 M60 WITH(NOLOCK)
	LEFT JOIN MT2161 M61 WITH(NOLOCK) ON M60.APK = M61.APKMaster AND M61.DivisionID = M60.DivisionID
	GROUP BY M61.MaterialID, M60.APK) AS M13 ON M13.APK = M9.APK AND M13.MaterialID = M10.MaterialID AND M12.NodeID = M13.MaterialID
	WHERE '+@sWhere+'	
	ORDER BY M3.VoucherNo, M1.VoucherNo, M9.VoucherNo
	'
END

PRINT (@sSQL)

EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

