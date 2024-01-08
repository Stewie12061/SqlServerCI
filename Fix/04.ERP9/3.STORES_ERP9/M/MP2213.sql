IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2213]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2213]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


















-- <Summary>
---- Load Grid: Màn hình kế thừa thống kê kết quả sản xuất (Detail)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Trọng Kiên on 27/04/2021
----Modified by Nhật Thanh on 25/04/2023: Lấy số lô và MPT04
----Modified by Trọng Phúc on 26/07/2023: Lấy tên sản phẩm theo DetailName ở Phiếu thống kê
----Modified by Trọng Phúc on 09/08/2023: Sửa có thể kế thừa nhiều phiếu thống kê sản xuất
----Modified by Anh Đô on 09/08/2023: Select thêm cột Ana06Name; Fix lỗi load lưới detail khi chọn nhiều phiếu
----Modify by: Thanh Lượng on 15/09/2023 - Cập nhật : [2023/09/TA/0070] - Xử lý bổ sung trường Specification (Customize PANGLOBE).
----Modify by: Minh Dũng on 19/10/2023 - Cập nhật : [2023/10/IS/0168] - Sửa tên cột select vào bảng tạm (Customize MAITHU).
----Modify by: Hoàng Long on 25/10/2023 - Cập nhật : [2023/10/IS/0226] - QC/QCF2001 - Phiếu quản lý chất lượng đầu ca khi kế thừa thống kê kết quả sản xuất, lấy sai Số lượng đặt	
----Modify by: Hoàng Long on 25/10/2023 - Cập nhật : [2023/10/IS/0227] - QC/QCF2001 - Phiếu quản lý chất lượng đầu ca khi kế thừa phiếu thống kê kết quả sản xuất không lên được số PO
-- <Example>
---- 
/*-- <Example>
    MP2213 @DivisionID = 'AIC', @UserID = '', @PageNumber = 1, @PageSize = 25, @ROrderID = 'sfasdf'

----*/

CREATE PROCEDURE [dbo].[MP2213]
( 
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @APKMaster VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sSQL01 NVARCHAR(MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @sJoin NVARCHAR(MAX) =N'',
        @CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)

SET @OrderBy = 'M1.ProductionOrder ASC'
SET @sWhere = ''
IF(@CustomerIndex = 117)    --Customize cho MAITHU
BEGIN
SET @sSQL = @sSQL + N'
SELECT DISTINCT M1.APK, M1.ProductionOrder, M1.PhaseID, A1.PhaseName, M1.ObjectID, A2.ObjectName
	   , M1.SourceMachineID, C1.MachineName AS SourceMachineName, M1.SourceEmployeeName
	   , M1.SourceEmployeeID, M1.DetailID AS InventoryID, M1.DetailName AS InventoryName, M1.UnitID, A4.UnitName, M1.Quantity,
	   (SELECT TOP 1 SourceNo from MT2160 WHERE MT2160.APK = M1.InheritVoucherID) as SourceNo,
	   (SELECT TOP 1 Ana04ID from MT2160
	   LEFT JOIN MT2140 ON MT2160.MPlanID = MT2140.VoucherNo
	   LEFT JOIN MT2141 ON MT2140.APK = MT2141.APKMaster
	   LEFT JOIN OT2202 ON OT2202.Ana04ID = MT2141.InheritVoucherID
	    WHERE MT2160.APK = M1.InheritVoucherID) as Ana04ID
		, M1.Ana06ID
INTO #TempMP2213
FROM MT2211 M1 WITH (NOLOCK)
	LEFT JOIN AT0126 A1 WITH (NOLOCK) ON M1.PhaseID = A1.PhaseID
	LEFT JOIN AT1202 A2 WITH (NOLOCK) ON M1.ObjectID = A2.ObjectID
	LEFT JOIN CIT1150 C1 WITH (NOLOCK) ON M1.SourceMachineID = C1.MachineID
	--INNER JOIN AT1302 A3 WITH (NOLOCK) ON M1.InventoryID = A3.InventoryID
	LEFT JOIN AT1304 A4 WITH (NOLOCK) ON M1.UnitID = A4.UnitID'

SET @sWhere = ' WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APKMaster) IN (''' + @APKMaster + ''') AND ISNULL(M1.DetailID, '''') <> '''''

SET @sSQL01 = ' DECLARE @Count INT
SELECT @Count = COUNT (*) FROM #TempMP2213

SELECT @Count AS TotalRow, M1.APK, M1.ProductionOrder, M1.PhaseID, M1.PhaseName, M1.ObjectID, M1.ObjectName
	   , M1.SourceMachineID, M1.SourceMachineName, M1.SourceEmployeeName
	   , M1.SourceEmployeeID, M1.InventoryID, M1.InventoryName, M1.UnitID, M1.UnitName, M1.Quantity, M1.SourceNo, M1.Ana04ID

FROM #TempMP2213 M1
ORDER BY ' + @OrderBy + '
OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END
ELSE
BEGIN
SET @sSQL = @sSQL + N'
SELECT DISTINCT M1.APK, M1.ProductionOrder, M1.PhaseID, A1.PhaseName, M1.ObjectID, A2.ObjectName
	   , M1.SourceMachineID, C1.MachineName AS SourceMachineName, M1.SourceEmployeeName
	   , M1.SourceEmployeeID, M1.DetailID AS InventoryID, M1.DetailName AS InventoryName, M1.UnitID, A4.UnitName,M1.Specification, M1.Quantity,
	   (SELECT TOP 1 SourceNo from MT2160 WHERE MT2160.APK = M1.InheritVoucherID) as SourceNo,
	   (SELECT TOP 1 Ana04ID from MT2160
	   LEFT JOIN MT2140 ON MT2160.MPlanID = MT2140.VoucherNo
	   LEFT JOIN MT2141 ON MT2140.APK = MT2141.APKMaster
	   LEFT JOIN OT2202 ON OT2202.Ana04ID = MT2141.InheritVoucherID
	    WHERE MT2160.APK = M1.InheritVoucherID) as Ana04ID
		, M1.Ana06ID, A5.AnaName AS Ana06Name, M1.ItemActual, M1.PONumber
INTO #TempMP2213
FROM MT2211 M1 WITH (NOLOCK)
	LEFT JOIN AT0126 A1 WITH (NOLOCK) ON M1.PhaseID = A1.PhaseID
	LEFT JOIN AT1202 A2 WITH (NOLOCK) ON M1.ObjectID = A2.ObjectID
	LEFT JOIN CIT1150 C1 WITH (NOLOCK) ON M1.SourceMachineID = C1.MachineID
	--INNER JOIN AT1302 A3 WITH (NOLOCK) ON M1.InventoryID = A3.InventoryID
	LEFT JOIN AT1304 A4 WITH (NOLOCK) ON M1.UnitID = A4.UnitID
	LEFT JOIN AT1011 A5 WITH (NOLOCK) ON A5.AnaID = M1.Ana06ID AND A5.AnaTypeID = ''A06'' AND A5.DivisionID IN (M1.DivisionID, ''@@@'')'

SET @sWhere = ' WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APKMaster) IN (''' + @APKMaster + ''') AND ISNULL(M1.InventoryID, '''') <> '''''

SET @sSQL01 = ' DECLARE @Count INT
SELECT @Count = COUNT (*) FROM #TempMP2213

SELECT @Count AS TotalRow, M1.APK, M1.ProductionOrder, M1.PhaseID, M1.PhaseName, M1.ObjectID, M1.ObjectName
	   , M1.SourceMachineID, M1.SourceMachineName, M1.SourceEmployeeName
	   , M1.SourceEmployeeID, M1.InventoryID, M1.InventoryName, M1.UnitID, M1.UnitName, M1.Specification, M1.Quantity, M1.SourceNo, M1.Ana04ID, M1.Ana06ID, M1.Ana06Name, M1.ItemActual, M1.PONumber

FROM #TempMP2213 M1
ORDER BY ' + @OrderBy + '
OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END
    EXEC (@sSQL + @sWhere + @sSQL01)
    PRINT(@sSQL + @sWhere + @sSQL01)
















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
