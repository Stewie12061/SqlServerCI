IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0410_1]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0410_1]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Create by Tiểu Mai on 17/03/2017
--- Purpose: In báo cáo Bảng lương tổng hợp cho BourBon (CustomizeIndex = 38)
--- Modified by Tiểu Mai on 14/09/2017: Bổ sung danh sách phiếu được lọc trên lưới danh mục
/*
 * EXEC HP0410_1 'BBL', 3, 2017
 * 
 */

CREATE PROCEDURE HP0410_1
( 
		@DivisionID VARCHAR(50),
		@TranMonth INT,
		@TranYear INT,
		@ListTrackingID XML
		
) 
AS 

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BBL_HP04101]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE BBL_HP04101 (TrackingID NVARCHAR(50))
END

DELETE FROM BBL_HP04101

INSERT INTO BBL_HP04101
SELECT X.Data.query('TrackingID').value('.', 'NVARCHAR(50)') AS TrackingID
FROM @ListTrackingID.nodes('//Data') AS X (Data)

SELECT H10.DivisionID, H11.EmployeeID, H00.FullName AS EmployeeName, 
A.TrackingDecimal, SUM(ISNULL(H11.Quantity,0)) AS Quantity, SUM(ISNULL(H11.Amount,0)) AS Amount, 
ROW_NUMBER() OVER(ORDER BY SUM(ISNULL(H11.Amount,0)) DESC) AS IndexNumber
FROM HT0410 H10 WITH (NOLOCK)
LEFT JOIN HT0411 H11 WITH (NOLOCK) ON H11.DivisionID = H10.DivisionID AND H11.TrackingID = H10.TrackingID AND H11.TranMonth = H10.TranMonth AND H11.TranYear = H10.TranYear
LEFT JOIN HV1400 H00 ON H11.DivisionID = H00.DivisionID AND H00.EmployeeID = H11.EmployeeID
LEFT JOIN (SELECT DivisionID, EmployeeID, COUNT(TrackingDate) AS TrackingDecimal FROM (SELECT DISTINCT HT0411.DivisionID, HT0411.EmployeeID, TrackingDate
            FROM HT0410 WITH (NOLOCK) 
			LEFT JOIN HT0411 WITH (NOLOCK) ON HT0411.DivisionID = HT0410.DivisionID AND HT0411.TrackingID = HT0410.TrackingID
			INNER JOIN BBL_HP04101 BBL ON BBL.TrackingID = HT0410.TrackingID
			WHERE HT0410.TranMonth = @TranMonth AND HT0410.TranYear = @TranYear) B
			GROUP BY DivisionID, EmployeeID) A ON A.DivisionID = H11.DivisionID AND A.EmployeeID = H11.EmployeeID
INNER JOIN BBL_HP04101 BBL ON BBL.TrackingID = H10.TrackingID
WHERE H10.DivisionID = @DivisionID 
	AND H10.TranMonth = @TranMonth 
	AND H10.TranYear = @TranYear
GROUP BY H10.DivisionID, H11.EmployeeID, H00.FullName, A.TrackingDecimal
ORDER BY H11.EmployeeID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
