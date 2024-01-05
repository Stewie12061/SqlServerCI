IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP3003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP3003]
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
---- Modified by: Lê Hoàng on: 23/07/2021 - Sửa lỗi Invalid column name PhaseID, PhaseID chuyển từ bảng master sang detail MT2161, lưu vết phiếu kế thừa không cần điều kiện PhaseID nên bỏ ra.
---- Modified by: Phương Thảo on: 09/05/2023 -[2023/04/IS/0092]-[EXEDY]- điều chỉnh lấy dữ liệu các cột cho đúng VoucherNo_DHSX,DepartmentID,UnitName,QuantityActual;bổ sung cột WarehouseDate 
---- Modified by: Phương Thảo on: 06/06/2023 bỏ điều kiện  M1.StatusID = 1 ( Thabico)
---- Modified by: Phương Thảo on: [2023/06/IS/0207][THABICO]22/06/2023 điều chỉnh lấy tên hàng theo lệnh MT2160 và sắp xếp theo số chứng từ tạo lệnh
---- Modified by: Phương Thảo on: [2023/06/IS/0207][THABICO]24/06/2023 điều chỉnh  lấy từ bảng thống kê để không bị trùng mặt hàng khi tách mặt hàng ở DHSX và thay đổi đặt tên gợi nhớ
---- Modified by: Mạnh Cường on: [2023/08/IS/0137][MAITHU] 14/08/2023 M/MF3000 - Khi in Báo cáo Chi tiết tình hình sản xuất thành phẩm đã chọn các điều kiện in nhưng in không hiện dữ liệu
---- Modified by: Đức Tuyên: 04/10/2023 [THABICO] Customize dữ liệu báo cáo cho THABICO.

CREATE PROCEDURE MP3003
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
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)
        
--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	BEGIN
		SET @sWhere = ' MT41.DivisionID IN ('''+@DivisionIDList+''')'
	END
ELSE 
	BEGIN
		SET @sWhere = ' MT41.DivisionID = N'''+@DivisionID+''''
	END

IF @IsDate = 1
	BEGIN
	IF ISNULL(@PeriodList,'') <> ''
		SET @sWhere = @sWhere + ' AND ((CASE WHEN MT40.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(MT40.TranMonth)))+''/''+ltrim(Rtrim(str(MT40.TranYear))) in ('''+@PeriodList +'''))'
	END
ELSE
	BEGIN
	IF ISNULL(@FromDate,'') <> ''
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(20), MT40.VoucherDate,112) BETWEEN ''' + CONVERT(VARCHAR(20),@FromDate,112) + ''' AND ''' + CONVERT(VARCHAR(20),Isnull(@ToDate,'12/31/9999'),112) + ''''
	END


IF ISNULL(@ProductionOrderID, '') != '' 
BEGIN
	SET @sWhere = @sWhere + ' AND MT60.VoucherNo = ''' + @ProductionOrderID + ''''
END

IF ISNULL(@ProduceOrderID, '') != '' 
BEGIN
	SET @sWhere = @sWhere + ' AND T01.VoucherNo = '''+ @ProduceOrderID +''' '
END

IF ISNULL(@InventoryID, '') != '' 
BEGIN
	SET @sWhere = @sWhere + ' AND MT41.InventoryID = '''+ LTRIM(RTRIM(@InventoryID)) +''''
END

IF(@CustomerIndex = 146)
BEGIN
	SET @sSQL = N' 
		SELECT 
			MT40.DivisionID, MT40.VoucherNo ,MT40.VoucherDate
			, MT41.Quantity
			, MT60.ProductID, MT60.VoucherDate, MT60.VoucherNo, MT60.VoucherDate As StartDate
			, MT11.ItemActual AS QuantityActual
			, MT10.VoucherNo AS VoucherNo_MT2210, MT10.VoucherDate As EndDatePlan
			, A04.UnitName
			, T22.ProductID as InventoryID, T21.DepartmentID AS DepartmentID , T22.MOrderID AS VoucherNo_DHSX
			, A02.InventoryName, A12.DepartmentName AS DepartmentName
			, '''' AS WarehouseDate
		FROM MT2140 MT40 WITH (NOLOCK)
		LEFT JOIN MT2141 MT41 WITH (NOLOCK) ON MT41.DivisionID = MT40.DivisionID AND MT41.APKMaster = MT40.APK
		LEFT JOIN MT2142 MT42 WITH (NOLOCK) ON MT42.DivisionID = MT40.DivisionID AND MT42.APK_MT2141 = MT41.APK
		LEFT JOIN OT2202 T22 WITH (NOLOCK) ON T22.DivisionID = MT40.DivisionID AND MT41.InheritTransactionID = CONVERT(VARCHAR(50), T22.APK)
		LEFT JOIN OT2201 T21 WITH (NOLOCK) ON T21.DivisionID = MT40.DivisionID AND T21.APK = T22.APKMaster
		LEFT JOIN MT2160 MT60 WITH (NOLOCK) ON MT60.DivisionID = MT40.DivisionID AND MT60.InheritTransactionID = MT42.APK
		LEFT JOIN MT2211 MT11 WITH( NOLOCK) ON MT11.DivisionID = MT40.DivisionID AND MT11.InheritVoucherID= MT60.APK AND ISNULL(MT11.IsWaste, 0) <> 1
		LEFT JOIN MT2210 MT10 WITH( NOLOCK) ON MT10.APK= MT11.APKMaster 
		LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.DivisionID = MT40.DivisionID AND  A04.UnitID = T22.UnitID 
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID = MT40.DivisionID AND A02.InventoryID = MT60.ProductID
		LEFT JOIN AT1102 A12 WITH (NOLOCK) ON A12.DepartmentID = T21.DepartmentID
		WHERE '+@sWhere+ ' AND MT40.DeleteFlg <> 1
	ORDER BY T22.MOrderID, MT10.VoucherDate
	'
END
ELSE
BEGIN
	SET @sSQL = N' 
	SELECT M10.VoucherNo AS VoucherNo_MT2210 , MT41.DivisionID, T01.VoucherNo AS VoucherNo_DHSX, MT40.VoucherNo ,MT40.VoucherDate,
		T01.DepartmentID ,A12.DepartmentName, MT60.ProductID as InventoryID, A02.InventoryName, A04.UnitName,
		MT60.VoucherDate As StartDate, M10.VoucherDate As EndDatePlan,  MT41.Quantity, MT11.ItemActual AS QuantityActual, '''' AS WarehouseDate,MT60.VoucherNo
		FROM MT2211 MT11 WITH (NOLOCK)
		LEFT JOIN MT2210 M10 WITH( NOLOCK) ON M10.apk= MT11.APKMaster 
		LEFT JOIN MT2160 MT60 WITH (NOLOCK) ON MT11.InheritVoucherID = MT60.apk 
		LEFT JOIN MT2142 MT42 WITH (NOLOCK) ON MT60.InheritTransactionID = MT42.APK
		LEFT JOIN MT2141 MT41 WITH (NOLOCK) ON MT42.APK_MT2141 = MT41.apk
		LEFT JOIN MT2140 MT40 WITH (NOLOCK) ON MT41.APKMaster = MT40.APK AND MT41.DivisionID = MT40.DivisionID
		LEFT JOIN OT2202 T22 WITH (NOLOCK) ON MT41.InheritTransactionID = CONVERT(VARCHAR(50), T22.apk)
		LEFT JOIN OT2002 T02 WITH (NOLOCK) ON T22.Ana08ID = T02.Ana08ID
		LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = T02.UnitID 
		LEFT JOIN OT2001 T01 WITH (NOLOCK) ON T01.SOrderID = T02.SOrderID
		LEFT JOIN AT1102 A12 WITH (NOLOCK) ON A12.DepartmentID = T01.DepartmentID 
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON MT60.ProductID = A02.InventoryID AND A02.DivisionID IN (''@@@'', MT11.DivisionID)
	

	WHERE '+@sWhere+'  --	and ISNULL(MT11.IsWaste,0) = 0 
	ORDER BY M10.VoucherNo
	'
END

PRINT (@sSQL)

EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
