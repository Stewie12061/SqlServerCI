IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0410_5]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0410_5]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Create by Tiểu Mai on 03/04/2017
--- Purpose: In báo cáo Bảng chi tiết làm hàng từng cá nhân cho BourBon (CustomizeIndex = 38)
--- Modified by Tiểu Mai on 26/05/2017: Chỉnh sửa danh mục dùng chung
--- Modified by Tiểu Mai on 14/09/2017: Bổ sung danh sách phiếu được lọc trên lưới danh mục
--- Modified on 01/10/2020 by Đức Thông: Bổ sung điều kiện where DivisionID IN bảng AT1302
--- Modified on 12/10/2020 by Nhựt Trường:(Sửa danh mục dùng chung) Bổ sung DivisionID IN cho AT1302.
--- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
 * EXEC HP0410_5 'BBL', 12, 2016
 * 
 */

CREATE PROCEDURE HP0410_5
( 
		@DivisionID VARCHAR(50),
		@TranMonth INT,
		@TranYear INT,
		@ListTrackingID XML		
) 
AS 

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BBL_HP04105]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE BBL_HP04105 (TrackingID NVARCHAR(50))
END

DELETE FROM BBL_HP04105

INSERT INTO BBL_HP04105
SELECT X.Data.query('TrackingID').value('.', 'NVARCHAR(50)') AS TrackingID
FROM @ListTrackingID.nodes('//Data') AS X (Data)

SELECT H10.SOrderID, H10.TrackingDate, H10.SOrderDate, H10.ObjectID, A01.TradeName ObjectName, H10.Ana04ID, Ana04.AnaName AS Ana04Name, 
		H10.Ana07ID, Ana07.AnaName AS Ana07Name, H10.PurchasePrice, O32.Notes01,
		H10.InventoryID, A33.InventoryName, H11.EmployeeID, H00.FullName AS EmployeeName, H00.TeamID, H00.TeamName, 
		SUM(H11.Quantity) AS Quantity, SUM(H11.Amount) AS Amount
FROM HT0410 H10 WITH (NOLOCK)
LEFT JOIN HT0411 H11 WITH (NOLOCK) ON H11.DivisionID = H10.DivisionID AND H11.TrackingID = H10.TrackingID AND H11.TranMonth = H10.TranMonth AND H11.TranYear = H10.TranYear
LEFT JOIN HV1400 H00 ON H11.DivisionID = H00.DivisionID AND H00.EmployeeID = H11.EmployeeID
LEFT JOIN AT1202 A01 WITH (NOLOCK)	ON A01.DivisionID IN (@DivisionID, '@@@') AND A01.ObjectID = H10.ObjectID
LEFT JOIN AT1011 Ana04 WITH (NOLOCK)	ON H10.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = 'A04'
LEFT JOIN AT1011 Ana07 WITH (NOLOCK)	ON H10.Ana07ID = Ana07.AnaID AND Ana07.AnaTypeID = 'A07'
LEFT JOIN AT1302 A33 WITH (NOLOCK)	ON A33.InventoryID= H10.InventoryID  AND A33.DivisionID IN (H10.DivisionID,'@@@')
LEFT JOIN OT3002 O32 WITH (NOLOCK) ON O32.DivisionID = H10.DivisionID AND O32.TransactionID = H10.InheritPTransactionID
INNER JOIN BBL_HP04105 BBL ON BBL.TrackingID = H10.TrackingID
WHERE H10.DivisionID = @DivisionID AND H10.TranMonth = @TranMonth AND H10.TranYear = @TranYear
GROUP BY H10.SOrderID, H10.TrackingDate, H10.SOrderDate, H10.ObjectID, A01.TradeName, H10.Ana04ID, Ana04.AnaName, 
		H10.Ana07ID, Ana07.AnaName, H10.PurchasePrice, O32.Notes01,
		H10.InventoryID, A33.InventoryName, H11.EmployeeID, H00.FullName, H00.TeamID, H00.TeamName
ORDER BY H10.TrackingDate, H11.EmployeeID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
