IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0410]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0410]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Create by Tiểu Mai on 24/02/2017
--- Purpose: Load danh sách chấm công sản phẩm cho BourBon (CustomizeIndex = 72)
--- Modified by Tiểu Mai on 26/05/2017: Chỉnh sửa danh mục dùng chung và bổ sung WITH (NOLOCK)
---- Modified on 01/10/2020 by Đức Thông: Bổ sung điều kiện where DivisionID IN bảng AT1302
---- Modified on 12/10/2020 by Nhựt Trường:(Sửa danh mục dùng chung) Bổ sung DivisionID IN cho AT1302.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
 * EXEC HP0410 'BBL', 'ASOFTADMIN', 12, 2016
 */


CREATE PROCEDURE HP0410
( 
		@DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@TranMonth INT,
		@TranYear INT
		
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)
SET @sSQL = ''

SET @sSQL = '		
SELECT HT0410.*, AT1103.FullName AS EmployeeName, AT1007.VoucherTypeName, AT1202.ObjectName, AT1302.InventoryName,
	HT0410.Ana04ID, HT0410.Ana07ID, Ana04.AnaName as Ana04Name, Ana07.AnaName as Ana07Name
FROM HT0410  WITH (NOLOCK)
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = HT0410.EmployeeID
LEFT JOIN AT1007 WITH (NOLOCK) ON AT1007.DivisionID = HT0410.DivisionID AND AT1007.VoucherTypeID = HT0410.VoucherTypeID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID  = HT0410.ObjectID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID  = HT0410.InventoryID AND AT1302.DivisionID IN (HT0410.DivisionID,''@@@'')
LEFT JOIN AT1011 Ana04 WITH (NOLOCK)	ON HT0410.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = ''A04''
LEFT JOIN AT1011 Ana07 WITH (NOLOCK)	ON HT0410.Ana07ID = Ana07.AnaID AND Ana07.AnaTypeID = ''A07''
WHERE HT0410.DivisionID = '''+@DivisionID+''' AND TranMonth = '+CONVERT(nvarchar(5),@TranMonth) +' AND TranYear = '+CONVERT(nvarchar(5),@TranYear)+
'
ORDER BY HT0410.TrackingDate '


EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
