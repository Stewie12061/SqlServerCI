IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0550]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0550]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load dữ liệu lưới Detail màn hình kế thừa thống kê kết quả sản xuất (MAITHU)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 22/04/2021
----Update by: Nhật Thanh, Date: 24/03/2023: Join bảng LSX để lấy số lô
----Update by: Nhật Thanh, Date: 03/04/2023: Đổi cách lấy tên hàng mã hàng. Lưu vết không hiển thị phiếu đã kế thừa hết
----Update by Viết Toàn, Date: 26/05/2023: Fix lỗi không lấy được tên đơn vị tính
/*-- <Example>
	HP0550 @DivisionID = 'VF', @StrDivisionID = '', @UserID = 'ASOFTADMIN', @TranMonth = 12, @TranYear = 2017, @DepartmentID = '', @TeamID = '', @EmployeeID = '', 
	@FromProductID = '', @ToProductID = ''

	HP0550 @DivisionID, @UserID, @StrDivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @EmployeeID, @FromProductID, @ToProductID
----*/

CREATE PROCEDURE HP0550
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@StrDivisionID VARCHAR(4000), 
	@LstAPKMaster VARCHAR(MAX),
	@PhaseID VARCHAR(50)
)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sWhere NVARCHAR(MAX) = N''

IF ISNULL(@StrDivisionID, '') <> '' SET @sWhere = @sWhere + N' M2.DivisionID IN ('''+@StrDivisionID+''') '
ELSE SET @sWhere = @sWhere + N' M2.DivisionID = '''+@DivisionID+''' '

SET @sWhere = @sWhere + ' AND M2.DeleteFlg = 0 '

IF ISNULL(@StrDivisionID, '') <> '' 
BEGIN
	SET @sWhere = @sWhere + ' AND CONVERT(NVARCHAR(50), M2.APKMaster) IN (''' + REPLACE(@LstAPKMaster,',',''',''') + ''') '
END

IF ISNULL(@PhaseID, '') <> ''  SET @sWhere = @sWhere + N' AND M2.PhaseID = '''+@PhaseID+''' '

SET @sWhere = @sWhere + N' AND H94.RefAPKDetail IS NULL'

SET @sSQL = N'
			SELECT M2.DivisionID, M2.APK, M2.APKMaster, 0 Choose, M1.VoucherNo, 
			M2.DetailID InventoryID, M2.DetailName InventoryName, M2.UnitID, (SELECT TOP 1 UnitName FROM AT1304 A2 WHERE A2.UnitID = M2.UnitID) UnitName, 
			M2.Quantity-ISNULL((Select SUM(Quantity) from MT1001 where InheritTransactionID = M2.APK),0) as Quantity, M2.ProductionOrder, M2.PhaseID, A3.PhaseName PhaseName, M2.ObjectID, A4.ObjectName ObjectName,
			M2.SourceMachineID, 
			STUFF(( SELECT '','' + C15.MachineName
			        FROM CIT1150 C15 WITH(NOLOCK) WHERE CONCAT('','',M2.SourceMachineID,'','') LIKE CONCAT(''%,'',C15.MachineID,'',%'')
			        FOR XML PATH('''')
			        ), 1, 1, '''') SourceMachineName,
			M2.SourceEmployeeID, 
			STUFF(( SELECT DISTINCT '','' + CASE WHEN CONCAT('','',M2.SourceEmployeeID,'','') LIKE CONCAT(''%,'',A13.EmployeeID,'',%'') THEN A13.FullName ELSE H14.FullName END
			        FROM AT1103 A13, HV1400 H14 WITH(NOLOCK) WHERE CONCAT('','',M2.SourceEmployeeID,'','') LIKE CONCAT(''%,'',A13.EmployeeID,'',%'') OR CONCAT('','',M2.SourceEmployeeID,'','') LIKE CONCAT(''%,'',H14.EmployeeID,'',%'')
			        FOR XML PATH('''')
			        ), 1, 1, '''') SourceEmployeeName,
			M2.Description, M60.SourceNo, A1.AccountID
			FROM MT2211 M2 WITH(NOLOCK)
			LEFT JOIN MT2210 M1 WITH(NOLOCK) ON M1.DivisionID = M2.DivisionID AND M1.APK = M2.APKMaster
			LEFT JOIN AT1302 A1 WITH(NOLOCK) ON M2.DivisionID IN (''@@@'',A1.DivisionID) AND M2.DetailID = A1.InventoryID
			--LEFT JOIN AT1304 A2 WITH(NOLOCK) ON M2.DivisionID IN (''@@@'',A2.DivisionID) AND M2.UnitID = A2.UnitID
			LEFT JOIN AT0126 A3 WITH(NOLOCK) ON M2.DivisionID IN (''@@@'',A3.DivisionID) AND M2.PhaseID = A3.PhaseID
			LEFT JOIN AT1202 A4 WITH(NOLOCK) ON M2.DivisionID IN (''@@@'',A4.DivisionID) AND M2.ObjectID = A4.ObjectID
			LEFT JOIN HT1904_MT H94 WITH(NOLOCK) ON M2.DivisionID = H94.DivisionID AND M2.APK = H94.RefAPKDetail AND M2.APKMaster = H94.RefAPKMaster
			LEFT JOIN MT2160 M60 WITH(NOLOCK) ON M2.DivisionID = M60.DivisionID AND M2.ProductionOrder = M60.VoucherNo
			WHERE ' + @sWhere + '
			AND M2.Quantity-ISNULL((Select SUM(Quantity) from MT1001 where InheritTransactionID = M2.APK),0)>0
			'
--PRINT @sSQL
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
