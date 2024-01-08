IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0165]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0165]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh sách phiếu thống kê sản xuất - Angel
-- <History>
---- Created by Tiểu Mai on 02/26/2016
---- Modified by Tiểu Mai on 05/08/2016: Sửa lại cách Order by cho ANGEL 
---- Modified by Hải Long on 22/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*
 EXEC MP0165 'KE', 'ASOFTADMIN', '02/01/2016', '02/29/2016'
 */


CREATE PROCEDURE [dbo].[MP0165] 	
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME
AS
DECLARE @sSQL NVARCHAR(MAX)
---- Thực hiện kiểm tra phân quyền dữ liệu
DECLARE @sSQLPer NVARCHAR(1000),
		@sWHEREPer NVARCHAR(1000)
SET @sSQL = ''
SET @sSQLPer = ''
SET @sWHEREPer = ''		
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = '
		LEFT JOIN AT0010 ON AT0010.DivisionID = MT1801.DivisionID AND AT0010.AdminUserID = '''+@UserID+''' AND AT0010.UserID = MT1801.CreateUserID '
		SET @sWHEREPer = '
		AND (MT1801.CreateUserID = AT0010.UserID OR  MT1801.CreateUserID = '''+@UserID+''') '		
	END

SET @sSQL = N' 
	SELECT MT1801.*, AT1202.ObjectName, AT1103.FullName AS EmployeeName, HV1400.FullName AS VisorsName, HT1101.TeamName
	FROM MT1801
	LEFT JOIN HT1101 ON HT1101.DivisionID = MT1801.DivisionID AND HT1101.TeamID = MT1801.TeamID
	LEFT JOIN AT1202 ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = MT1801.ObjectID
	LEFT JOIN AT1103 ON AT1103.EmployeeID = MT1801.EmployeeID
	LEFT JOIN HV1400 ON HV1400.DivisionID = MT1801.DivisionID AND HV1400.EmployeeID = MT1801.VisorsID
	' + @sSQLPer + '
	WHERE MT1801.DivisionID = '''+@DivisionID+'''
	AND MT1801.VoucherDate BETWEEN '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+'''
	' + @sWHEREPer + '
	ORDER BY MT1801.VoucherDate, MT1801.VoucherTypeID '
	
EXEC (@sSQL)
--PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

