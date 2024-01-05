IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP3002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP3002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Báo cáo theo dõi tình hình thực hiện kế hoạch sản xuất
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đình Hòa on: 28/05/2021
---- Modify by : Phương thảo: 07/06/2023 --- leftjoin với ot2202  dự trù chi phí để lấy đơn hàng sản xuất
---- Modify by : Phương Thảo: 07/06/2023 --- Tạm thời bỏ điều kiện check trạng thái kê hoạch sản xuất = 2 để lên được số lượng thực tế = số lượng kế hoạch
                                          ----Customize THABICO, đem vào chuẩn
---- Modify by : Viết Toàn: 11/08/2023 ---- customize MAITHU
---- Modify by : Nhật Thanh: 18/09/2023 : Bổ sung cột tỷ lệ
---- Modify by : Đức Tuyên: 04/10/2023 : Loại bỏ các kế hoạch đã bị xóa.
---- Modify by : Hồng Thắm : 05/12/2023 : Bổ sung cột đặc tính kỹ thuật

CREATE PROCEDURE MP3002
(
	@DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(2000),
	@IsDate INT, ---- 1: là ngày, 0: là kỳ
	@FromDate DATETIME,
	@ToDate DATETIME,
	@PeriodList NVARCHAR(MAX),
	@FromDepartmentID NVARCHAR(MAX),
	@ToDepartmentID NVARCHAR(MAX),
	@FromInventoryID NVARCHAR(MAX),
	@ToInventoryID NVARCHAR(MAX)
)
AS

DECLARE @sSQL NVARCHAR (MAX)='',
        @sWhere NVARCHAR(MAX)='',
		@CustomerIndex INT

SET @CustomerIndex = (SELECT CustomerName FROM CustomerIndex)
        
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
		SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(20), M2.StartDate,112) BETWEEN ''' + CONVERT(VARCHAR(20),@FromDate,112) + ''' AND ''' + CONVERT(VARCHAR(20),Isnull(@ToDate,'12/31/9999'),112) + '''
										OR CONVERT(VARCHAR(20), M2.EndDate,112) BETWEEN ''' + CONVERT(VARCHAR(20),@FromDate,112) + ''' AND ''' + CONVERT(VARCHAR(20),Isnull(@ToDate,'12/31/9999'),112) + ''')'
	END


IF ISNULL(@FromDepartmentID, '') != '' AND ISNULL(@ToDepartmentID, '') != ''
BEGIN
	IF @CustomerIndex = 117
		SET @sWhere = @sWhere + ' AND ISNULL(M3.DepartmentID, M15.DepartmentID) BETWEEN ''' + @FromDepartmentID + '''  AND '''+ @ToDepartmentID + ''''
	ELSE
		SET @sWhere = @sWhere + ' AND M3.DepartmentID BETWEEN ''' + @FromDepartmentID + '''  AND '''+ @ToDepartmentID + ''''
END

IF ISNULL(@FromInventoryID, '') != '' AND ISNULL(@ToInventoryID, '') != ''
BEGIN
	IF @CustomerIndex = 117
		SET @sWhere = @sWhere + ' AND  M4.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''''
	ELSE
		SET @sWhere = @sWhere + ' AND  M2.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''''
END

IF @CustomerIndex = 117
	SET @sSQL = N'
		SELECT M3.VoucherNo AS VoucherNo_DHSX, M1.VoucherNo, M1.VoucherDate, ISNULL(M3.DepartmentID, M15.DepartmentID), M6.DepartmentName,M4.InventoryID, M5.InventoryName, M4.UnitID, M7.UnitName, M2.Quantity, M2.StartDate, M2.EndDatePlan
		, M2.Quantity AS QuantityActual
		FROM MT2140 M1 WITH(NOLOCK)
		LEFT JOIN MT2141 M2 WITH(NOLOCK) ON M1.APK = M2.APKMaster AND M1.DivisionID = M2.DivisionID
		LEFT JOIN ot2202 M14 WITH (NOLOCK) ON  M2.VoucherNoProduct = M14.EstimateID AND M14.DivisionID IN(M1.DivisionID,''@@@'')    --thêm vào : left join với dự trù chi phí để lấy đơn hàng sản xuất
		LEFT JOIN OT2201 M15 WITH (NOLOCK) ON M15.EstimateID = M14.EstimateID AND M14.DivisionID = M15.DivisionID
		INNER JOIN OT2001 M3 WITH(NOLOCK) ON M14.Ana08ID = M3.VoucherNo AND M3.OrderType = 0 AND M1.DivisionID = M3.DivisionID     ---thay đôi M14.MOrderID = M3.VoucherNo 
		INNER JOIN OT2002 M4 WITH(NOLOCK) ON M3.SOrderID = M4.SOrderID AND M3.DivisionID = M4.DivisionID AND M2.InventoryID = M4.InventoryID
		LEFT JOIN AT1302 M5 WITH(NOLOCK) ON M4.InventoryID = M5.InventoryID AND M5.DivisionID IN (M1.DivisionID, ''@@@'')
		LEFT JOIN AT1102 M6 WITH(NOLOCK) ON ISNULL(M3.DepartmentID, M15.DepartmentID) = M6.DepartmentID AND M6.DivisionID IN (M1.DivisionID, ''@@@'') and M6.Disabled = 0
		LEFT JOIN AT1304 M7 WITH(NOLOCK) ON M4.UnitID = M7.UnitID AND M7.DivisionID IN (M1.DivisionID, ''@@@'')
		WHERE '+@sWhere+'	
		ORDER BY M3.VoucherNo, M1.VoucherDate
	'
ELSE
	SET @sSQL = N' 
	SELECT M3.VoucherNo AS VoucherNo_DHSX, M1.VoucherNo, M1.VoucherDate, M3.DepartmentID, M6.DepartmentName,M4.InventoryID, M5.InventoryName, M4.UnitID, M7.UnitName, M2.Quantity, M2.StartDate, M2.EndDatePlan
	, M2.Quantity AS QuantityActual, Case when M2.Quantity = 0 Then 0 Else ISNULL(M2.Quantity,0)/ISNULL(M2.Quantity,0) end as Rate, M8.Specification
	FROM MT2140 M1 WITH(NOLOCK)
	LEFT JOIN MT2141 M2 WITH(NOLOCK) ON M1.APK = M2.APKMaster AND M1.DivisionID = M2.DivisionID
	LEFT JOIN ot2202 M14 WITH (NOLOCK) ON  M2.VoucherNoProduct = M14.EstimateID AND M14.DivisionID IN(M1.DivisionID,''@@@'')    --thêm vào : left join với dự trù chi phí để lấy đơn hàng sản xuất
	LEFT JOIN OT2001 M3 WITH(NOLOCK) ON M14.MOrderID = M3.VoucherNo AND M3.OrderType = 1 AND M1.DivisionID = M3.DivisionID     ---thay đôi M14.MOrderID = M3.VoucherNo 
	LEFT JOIN OT2002 M4 WITH(NOLOCK) ON M3.VoucherNo = M4.SOrderID AND M3.DivisionID = M4.DivisionID AND M2.InventoryID = M4.InventoryID
	LEFT JOIN AT1302 M5 WITH(NOLOCK) ON M4.InventoryID = M5.InventoryID AND M5.DivisionID IN (M1.DivisionID, ''@@@'')
	LEFT JOIN AT1102 M6 WITH(NOLOCK) ON M3.DepartmentID = M6.DepartmentID AND M6.DivisionID IN (M1.DivisionID, ''@@@'') and M6.Disabled = 0
	LEFT JOIN AT1304 M7 WITH(NOLOCK) ON M4.UnitID = M7.UnitID AND M7.DivisionID IN (M1.DivisionID, ''@@@'')
	LEFT JOIN AT1302 M8 WITH(NOLOCK) ON M8.InventoryID = M2.InventoryID AND M8.DivisionID = M1.DivisionID 
	WHERE M1.DeleteFlg <> 1 AND '+@sWhere+'	
	ORDER BY M3.VoucherNo, M1.VoucherDate
	'

PRINT (@sSQL)

EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
