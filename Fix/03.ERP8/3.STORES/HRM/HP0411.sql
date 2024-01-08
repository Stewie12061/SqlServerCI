

IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0411]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0411]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Create by Tiểu Mai on 24/02/2017
--- Purpose: Load edit chấm công sản phẩm cho BourBon (CustomizeIndex = 72)
--- Modified by Tiểu Mai on 26/05/2017: Chỉnh sửa danh mục dùng chung
--- Modified on 01/10/2020 by Đức Thông: Bổ sung điều kiện where DivisionID IN bảng AT1302
--- Modified on 12/10/2020 by Nhựt Trường:(Sửa danh mục dùng chung) Bổ sung DivisionID IN cho AT1302.
--- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
 * exec HP0411 'BBL', 'CC/12/2016/001'
 */

CREATE PROCEDURE HP0411
( 
		@DivisionID NVARCHAR(50),
		@TrackingID NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)
SET @sSQL = ''

SET @sSQL = '
	SELECT H10.*, A13.FullName AS EmployeeName, H11. TrackingDetailID, H11.EmployeeID AS EmployeeID2, H00.FullName AS EmployeeName2, 
	H00.DepartmentName, H00.TeamName, H11.Quantity, H11.Amount, H11.Orders, A12.ObjectName, A32.InventoryName, Ana04.AnaName as Ana04Name, Ana07.AnaName as Ana07Name
	FROM HT0410 H10 WITH (NOLOCK)
	LEFT JOIN HT0411 H11 WITH (NOLOCK) ON H10.DivisionID = H11.DivisionID AND H10.TrackingID = H11.TrackingID AND H10.TranMonth = H11.TranMonth AND H10.TranYear = H11.TranYear
	LEFT JOIN AT1103 A13 WITH (NOLOCK) ON A13.EmployeeID = H10.EmployeeID
	LEFT JOIN HV1400 H00 WITH (NOLOCK) ON H00.DivisionID = H11.DivisionID AND H00.EmployeeID = H11.EmployeeID
	LEFT JOIN AT1202 A12 WITH (NOLOCK) ON A12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A12.ObjectID = H10.ObjectID
	LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.InventoryID = H10.InventoryID AND A32.DivisionID IN (H10.DivisionID,''@@@'')
	LEFT JOIN AT1011 Ana04 WITH (NOLOCK)	ON H10.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = ''A04''
	LEFT JOIN AT1011 Ana07 WITH (NOLOCK)	ON H10.Ana07ID = Ana07.AnaID AND Ana07.AnaTypeID = ''A07''
	WHERE H10.DivisionID = '''+@DivisionID+'''
		AND H10.TrackingID = '''+@TrackingID+'''
	ORDER BY H11.Orders '
	               
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
