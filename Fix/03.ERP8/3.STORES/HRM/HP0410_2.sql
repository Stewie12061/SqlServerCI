IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0410_2]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0410_2]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Create by Tiểu Mai on 17/03/2017
--- Purpose: In báo cáo Bảng lương tổng hợp cho BourBon (CustomizeIndex = 38)
--- Modified by Tiểu Mai on 14/09/2017: Bổ sung danh sách phiếu được lọc trên lưới danh mục
/*
 * EXEC HP0410_2 'BBL', 12, 2016
 * 
 */

CREATE PROCEDURE HP0410_2
( 
		@DivisionID VARCHAR(50),
		@TranMonth INT,
		@TranYear INT,
		@ListTrackingID XML
		
) 
AS 

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BBL_HP04102]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE BBL_HP04102 (TrackingID NVARCHAR(50))
END

DELETE FROM BBL_HP04102

INSERT INTO BBL_HP04102
SELECT X.Data.query('TrackingID').value('.', 'NVARCHAR(50)') AS TrackingID
FROM @ListTrackingID.nodes('//Data') AS X (Data)

SELECT H10.DivisionID, H11.EmployeeID, H00.FullName AS EmployeeName, H00.TeamName, 
DAY (H10.TrackingDate) AS [Date],
SUM(ISNULL(H11.Amount,0)) AS Amount
INTO #HT0410_2
FROM HT0410 H10 WITH (NOLOCK)
LEFT JOIN HT0411 H11 WITH (NOLOCK) ON H11.DivisionID = H10.DivisionID AND H11.TrackingID = H10.TrackingID AND H11.TranMonth = H10.TranMonth AND H11.TranYear = H10.TranYear
LEFT JOIN HV1400 H00 ON H11.DivisionID = H00.DivisionID AND H00.EmployeeID = H11.EmployeeID
INNER JOIN BBL_HP04102 BBL ON BBL.TrackingID = H10.TrackingID
WHERE H10.DivisionID = @DivisionID AND H10.TranMonth = @TranMonth AND H10.TranYear = @TranYear
GROUP BY H10.DivisionID, H11.EmployeeID, H00.FullName, H00.TeamName, H10.TrackingDate

SELECT *
FROM
(SELECT * 
    FROM #HT0410_2) AS SourceTable
PIVOT
(
SUM(Amount)
FOR [Date] IN (	[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], 
				[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
				[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31])
) AS PivotTable

DROP TABLE #HT0410_2

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
