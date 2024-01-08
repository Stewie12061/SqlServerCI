 IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0531]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
 DROP PROCEDURE [DBO].[HP0531]
 GO
 SET QUOTED_IDENTIFIER ON
 GO
 SET ANSI_NULLS ON
 GO
 
 
 
  -- <Summary>
 ---- Báo cáo chênh lệch chấm công ra/vào 
 -- <Param>
 ---- 
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Khả Vi, Date: 27/11/2017
 -- <Example>
 /*	[HP0531] @DivisionID='NTY', @TranMonth=10, @TranYear=2017, @DepartmentID = 'PB001', @FromDate = '', @ToDate = ''
 */
 
 --	EXEC HP0531 @DivisionID, @TranMonth, @TranYear, @DepartmentID, @FromDate, @ToDate
 ---- 
 
 CREATE PROCEDURE [dbo].HP0531 
     @DivisionID NVARCHAR(50), 
 	@TranMonth INT,
 	@TranYear INT,
 	@DepartmentID NVARCHAR(50),
 	@FromDate DATETIME, 
 	@ToDate DATETIME
 	
 AS
 
 DECLARE @sSQL NVARCHAR(MAX) = N'',
		 @sSQL1 NVARCHAR(MAX) = N'',
 		 @Period INT = 0
 SET @Period = @TranMonth + @TranYear * 100
 

-- Thời gian làm việc theo bảng xếp ca  
SELECT * 
INTO #HT1025
FROM 
 	(SELECT DivisionID, EmployeeID, TranMonth, TranYear, D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
 	D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31
 	FROM HT1025 WITH (NOLOCK)
 	WHERE DivisionID = @DivisionID AND TranMonth + TranYear * 100 = STR(@Period)
 	) AS P
UNPIVOT (ShiftID FOR DateShift IN (D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)) AS UNPV
 
SELECT #HT1025.*, HT1020.BeginTime, HT1020.EndTime
INTO #Temp
FROM #HT1025 
LEFT JOIN HT1020 WITH (NOLOCK) ON #HT1025.ShiftID = HT1020.ShiftID AND #HT1025.DivisionID = HT1020.DivisionID
 
SELECT * 
INTO #HT1025_EndTime
FROM (
 	SELECT DivisionID, EmployeeID, TranMonth, TranYear, DateShift, EndTime
 	FROM #Temp) AS P
PIVOT (MAX(EndTime) FOR DateShift IN (D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)) AS PIVOTTABLE
 
SELECT * 
INTO #HT1025_BeginTime
FROM (
 	SELECT DivisionID, EmployeeID, TranMonth, TranYear, DateShift, BeginTime
 	FROM #Temp) AS P
PIVOT (MAX(BeginTime) FOR DateShift IN (D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)) AS PIVOTTABLE
 
SET @sSQL = @sSQL + N'
SELECT T1.DivisionID, T1.EmployeeID, 
(CASE WHEN ISNULL(MiddleName,'''') = '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
WHEN ISNULL(MiddleName,'''') <> '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.MiddleName,''''))) + '' '' +  LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
END) AS EmployeeName, T1.TranMonth, T1.TranYear, HT1400.DepartmentID, AT1102.DepartmentName, 1 AS Type,
T2.D01 AS BeginTime1, T1.D01 AS EndTime1, T2.D02 AS BeginTime2, T1.D02 AS EndTime2, T2.D03 AS BeginTime3, T1.D03 AS EndTime3, T2.D04 AS BeginTime4, T1.D04 AS EndTime4,
T2.D05 AS BeginTime5, T1.D05 AS EndTime5, T2.D06 AS BeginTime6, T1.D06 AS EndTime6, T2.D07 AS BeginTime7, T1.D07 AS EndTime7, T2.D08 AS BeginTime8, T1.D08 AS EndTime8,
T2.D09 AS BeginTime9, T1.D09 AS EndTime9, T2.D10 AS BeginTime10, T1.D10 AS EndTime10, T2.D11 AS BeginTime11, T1.D11 AS EndTime11, T2.D12 AS BeginTime12, T1.D12 AS EndTime12,
T2.D13 AS BeginTime13, T1.D13 AS EndTime13, T2.D14 AS BeginTime14, T1.D14 AS EndTime14, T2.D15 AS BeginTime15, T1.D15 AS EndTime15, T2.D16 AS BeginTime16, 
T1.D16 AS EndTime16, T2.D17 AS BeginTime17, T1.D17 AS EndTime17, T2.D18 AS BeginTime18, T1.D18 AS EndTime18, T2.D19 AS BeginTime19, T1.D19 AS EndTime19,
T2.D20 AS BeginTime20, T1.D20 AS EndTime20, T2.D21 AS BeginTime21, T1.D21 AS EndTime21, T2.D22 AS BeginTime22, T1.D22 AS EndTime22, T2.D23 AS BeginTime23, 
T1.D23 AS EndTime23, T2.D24 AS BeginTime24, T1.D24 AS EndTime24, T2.D25 AS BeginTime25, T1.D25 AS EndTime25, T2.D26 AS BeginTime26, T1.D26 AS EndTime26,
T2.D27 AS BeginTime27, T1.D27 AS EndTime27, T2.D28 AS BeginTime28, T1.D28 AS EndTime28, T2.D29 AS BeginTime29, T1.D29 AS EndTime29, T2.D30 AS BeginTime30, 
T1.D30 AS EndTime30, T2.D31 AS BeginTime31,  T1.D31 AS EndTime31
FROM #HT1025_EndTime T1
INNER JOIN #HT1025_BeginTime T2 ON T1.EmployeeID = T2.EmployeeID
INNER JOIN HT1400 WITH (NOLOCK) ON T1.EmployeeID = HT1400.EmployeeID AND T1.DivisionID = HT1400.DivisionID
LEFT JOIN AT1102 WITH (NOLOCK) ON HT1400.DepartmentID = AT1102.DepartmentID AND AT1102.DivisionID IN ('''+@DivisionID+''', ''@@@'')
'
-- Thời gian làm việc theo máy chấm công 
SELECT DivisionID, TranMonth, TranYear, EmployeeID, 
CASE WHEN CONVERT(NVARCHAR(5), DATEPART(D,AbsentDate))  <= 9 THEN N'D0'+ CONVERT(NVARCHAR(5), DATEPART(D,AbsentDate)) 
ELSE N'D'+ CONVERT(NVARCHAR(5), DATEPART(D,AbsentDate)) END AS [Date], CONVERT(VARCHAR(10), FromTimeValid, 24) AS FromTimeValid, 
CONVERT(VARCHAR(10), ToTimevalid, 24) AS ToTimevalid
INTO #HT2407
FROM HT2407 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND TranMonth + TranYear * 100 = STR(@Period)

SELECT *
INTO #HT2407_BeginTime
FROM (
	SELECT DivisionID, EmployeeID, TranMonth, TranYear, [Date], FromTimeValid
	FROM #HT2407 
) AS P 
PIVOT (MAX(FromTimeValid) FOR [Date] IN (D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)) AS PIVOTTABLE

SELECT * 
INTO #HT2407_EndTime
FROM (
	SELECT DivisionID, EmployeeID, TranMonth, TranYear, [Date], ToTimevalid
	FROM #HT2407 ) AS P
PIVOT (MAX(ToTimevalid) FOR [Date] IN (D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)) AS PIVOTTABLE

SET @sSQL = @sSQL + N'
UNION ALL
SELECT T1.DivisionID, T1.EmployeeID, 
(CASE WHEN ISNULL(MiddleName,'''') = '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
WHEN ISNULL(MiddleName,'''') <> '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.MiddleName,''''))) + '' '' +  LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
END) AS EmployeeName, T1.TranMonth, T1.TranYear, HT1400.DepartmentID, AT1102.DepartmentName, 2 AS Type,
T2.D01 AS BeginTime1, T1.D01 AS EndTime1, T2.D02 AS BeginTime2, T1.D02 AS EndTime2, T2.D03 AS BeginTime3, T1.D03 AS EndTime3, T2.D04 AS BeginTime4, T1.D04 AS EndTime4,
T2.D05 AS BeginTime5, T1.D05 AS EndTime5, T2.D06 AS BeginTime6, T1.D06 AS EndTime6, T2.D07 AS BeginTime7, T1.D07 AS EndTime7, T2.D08 AS BeginTime8, T1.D08 AS EndTime8,
T2.D09 AS BeginTime9, T1.D09 AS EndTime9, T2.D10 AS BeginTime10, T1.D10 AS EndTime10, T2.D11 AS BeginTime11, T1.D11 AS EndTime11, T2.D12 AS BeginTime12, T1.D12 AS EndTime12,
T2.D13 AS BeginTime13, T1.D13 AS EndTime13, T2.D14 AS BeginTime14, T1.D14 AS EndTime14, T2.D15 AS BeginTime15, T1.D15 AS EndTime15, T2.D16 AS BeginTime16, 
T1.D16 AS EndTime16, T2.D17 AS BeginTime17, T1.D17 AS EndTime17, T2.D18 AS BeginTime18, T1.D18 AS EndTime18, T2.D19 AS BeginTime19, T1.D19 AS EndTime19,
T2.D20 AS BeginTime20, T1.D20 AS EndTime20, T2.D21 AS BeginTime21, T1.D21 AS EndTime21, T2.D22 AS BeginTime22, T1.D22 AS EndTime22, T2.D23 AS BeginTime23, 
T1.D23 AS EndTime23, T2.D24 AS BeginTime24, T1.D24 AS EndTime24, T2.D25 AS BeginTime25, T1.D25 AS EndTime25, T2.D26 AS BeginTime26, T1.D26 AS EndTime26,
T2.D27 AS BeginTime27, T1.D27 AS EndTime27, T2.D28 AS BeginTime28, T1.D28 AS EndTime28, T2.D29 AS BeginTime29, T1.D29 AS EndTime29, T2.D30 AS BeginTime30, 
T1.D30 AS EndTime30, T2.D31 AS BeginTime31,  T1.D31 AS EndTime31
FROM #HT2407_EndTime T1
INNER JOIN #HT2407_BeginTime T2 ON T1.EmployeeID = T2.EmployeeID
INNER JOIN HT1400 WITH (NOLOCK) ON T1.EmployeeID = HT1400.EmployeeID AND T1.DivisionID = HT1400.DivisionID
LEFT JOIN AT1102 WITH (NOLOCK) ON HT1400.DepartmentID = AT1102.DepartmentID AND AT1102.DivisionID IN ('''+@DivisionID+''', ''@@@'')
'
--Thời gian làm việc thực tế
SELECT DivisionID, TranMonth, TranYear, EmployeeID, 
CASE WHEN CONVERT(NVARCHAR(5), DATEPART(D,[Date]))  <= 9 THEN N'D0'+ CONVERT(NVARCHAR(5), DATEPART(D,[Date])) 
ELSE N'D'+ CONVERT(NVARCHAR(5), DATEPART(D,[Date])) 
END AS [Date], ActFromTime, ActToTime
INTO #HT1113
FROM HT1113 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND TranMonth + TranYear * 100 = STR(@Period)
	

SELECT * 
INTO #HT1113_BeginTime
FROM (
	SELECT DivisionID, EmployeeID, TranMonth, TranYear, [Date], ActFromTime
	FROM #HT1113) AS P
PIVOT (MAX(ActFromTime) FOR  [Date] IN (D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)) AS PIVOTTABLE
	
SELECT * 
INTO #HT1113_EndTime
FROM (
	SELECT DivisionID, EmployeeID, TranMonth, TranYear, [Date], ActToTime
	FROM #HT1113) AS P
PIVOT (MAX(ActToTime) FOR [Date] IN (D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)) AS PIVOTTABLE

SET @sSQL = @sSQL + N'
UNION ALL
SELECT T1.DivisionID, T1.EmployeeID, 
(CASE WHEN ISNULL(MiddleName,'''') = '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
WHEN ISNULL(MiddleName,'''') <> '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.MiddleName,''''))) + '' '' +  LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
END) AS EmployeeName, T1.TranMonth, T1.TranYear, HT1400.DepartmentID, AT1102.DepartmentName, 3 AS Type,
T2.D01 AS BeginTime1, T1.D01 AS EndTime1, T2.D02 AS BeginTime2, T1.D02 AS EndTime2, T2.D03 AS BeginTime3, T1.D03 AS EndTime3, T2.D04 AS BeginTime4, T1.D04 AS EndTime4,
T2.D05 AS BeginTime5, T1.D05 AS EndTime5, T2.D06 AS BeginTime6, T1.D06 AS EndTime6, T2.D07 AS BeginTime7, T1.D07 AS EndTime7, T2.D08 AS BeginTime8, T1.D08 AS EndTime8,
T2.D09 AS BeginTime9, T1.D09 AS EndTime9, T2.D10 AS BeginTime10, T1.D10 AS EndTime10, T2.D11 AS BeginTime11, T1.D11 AS EndTime11, T2.D12 AS BeginTime12, T1.D12 AS EndTime12,
T2.D13 AS BeginTime13, T1.D13 AS EndTime13, T2.D14 AS BeginTime14, T1.D14 AS EndTime14, T2.D15 AS BeginTime15, T1.D15 AS EndTime15, T2.D16 AS BeginTime16, 
T1.D16 AS EndTime16, T2.D17 AS BeginTime17, T1.D17 AS EndTime17, T2.D18 AS BeginTime18, T1.D18 AS EndTime18, T2.D19 AS BeginTime19, T1.D19 AS EndTime19,
T2.D20 AS BeginTime20, T1.D20 AS EndTime20, T2.D21 AS BeginTime21, T1.D21 AS EndTime21, T2.D22 AS BeginTime22, T1.D22 AS EndTime22, T2.D23 AS BeginTime23, 
T1.D23 AS EndTime23, T2.D24 AS BeginTime24, T1.D24 AS EndTime24, T2.D25 AS BeginTime25, T1.D25 AS EndTime25, T2.D26 AS BeginTime26, T1.D26 AS EndTime26,
T2.D27 AS BeginTime27, T1.D27 AS EndTime27, T2.D28 AS BeginTime28, T1.D28 AS EndTime28, T2.D29 AS BeginTime29, T1.D29 AS EndTime29, T2.D30 AS BeginTime30, 
T1.D30 AS EndTime30, T2.D31 AS BeginTime31,  T1.D31 AS EndTime31
FROM #HT1113_EndTime T1
INNER JOIN #HT1113_BeginTime T2 ON T1.EmployeeID = T2.EmployeeID
INNER JOIN HT1400 WITH (NOLOCK) ON T1.EmployeeID = HT1400.EmployeeID AND T1.DivisionID = HT1400.DivisionID
LEFT JOIN AT1102 WITH (NOLOCK) ON HT1400.DepartmentID = AT1102.DepartmentID AND AT1102.DivisionID IN ('''+@DivisionID+''', ''@@@'')
'
 --Chênh lệch thời gian thực tế/ xếp ca 
SELECT T1.DivisionID, T1.EmployeeID, T1.TranMonth, T1.TranYear, T2.[Date],
CONVERT (DECIMAL(28,8), DATEDIFF(MI, T2.ActFromTime, T1.BeginTime)) / 60.0 AS BeginTime, 
CONVERT (DECIMAL(28,8), DATEDIFF(MI, T2.ActToTime, T1.EndTime)) / 60.0 AS EndTime
INTO #ActTime
FROM #Temp T1
INNER JOIN #HT1113 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.DateShift = T2.[Date]
	
SELECT * 
INTO #ActTime_BeginTime
FROM (
	SELECT DivisionID, EmployeeID, TranMonth, TranYear, [Date], CONVERT(NVARCHAR(50), BeginTime) AS BeginTime
	FROM #ActTime) AS P
PIVOT (MAX(BeginTime) FOR  [Date] IN (D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)) AS PIVOTTABLE
	
SELECT * 
INTO #ActTime_EndTime
FROM (
	SELECT DivisionID, EmployeeID, TranMonth, TranYear, [Date], CONVERT(NVARCHAR(50), EndTime) AS EndTime
	FROM #ActTime) AS P
PIVOT (MAX(EndTime) FOR [Date] IN (D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)) AS PIVOTTABLE

SET @sSQL = @sSQL + N'
UNION ALL
SELECT T1.DivisionID, T1.EmployeeID, 
(CASE WHEN ISNULL(MiddleName,'''') = '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
WHEN ISNULL(MiddleName,'''') <> '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.MiddleName,''''))) + '' '' +  LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
END) AS EmployeeName, T1.TranMonth, T1.TranYear, HT1400.DepartmentID, AT1102.DepartmentName, 4 AS Type,
T2.D01 AS BeginTime1, T1.D01 AS EndTime1, T2.D02 AS BeginTime2, T1.D02 AS EndTime2, T2.D03 AS BeginTime3, T1.D03 AS EndTime3, T2.D04 AS BeginTime4, T1.D04 AS EndTime4,
T2.D05 AS BeginTime5, T1.D05 AS EndTime5, T2.D06 AS BeginTime6, T1.D06 AS EndTime6, T2.D07 AS BeginTime7, T1.D07 AS EndTime7, T2.D08 AS BeginTime8, T1.D08 AS EndTime8,
T2.D09 AS BeginTime9, T1.D09 AS EndTime9, T2.D10 AS BeginTime10, T1.D10 AS EndTime10, T2.D11 AS BeginTime11, T1.D11 AS EndTime11, T2.D12 AS BeginTime12, T1.D12 AS EndTime12,
T2.D13 AS BeginTime13, T1.D13 AS EndTime13, T2.D14 AS BeginTime14, T1.D14 AS EndTime14, T2.D15 AS BeginTime15, T1.D15 AS EndTime15, T2.D16 AS BeginTime16, 
T1.D16 AS EndTime16, T2.D17 AS BeginTime17, T1.D17 AS EndTime17, T2.D18 AS BeginTime18, T1.D18 AS EndTime18, T2.D19 AS BeginTime19, T1.D19 AS EndTime19,
T2.D20 AS BeginTime20, T1.D20 AS EndTime20, T2.D21 AS BeginTime21, T1.D21 AS EndTime21, T2.D22 AS BeginTime22, T1.D22 AS EndTime22, T2.D23 AS BeginTime23, 
T1.D23 AS EndTime23, T2.D24 AS BeginTime24, T1.D24 AS EndTime24, T2.D25 AS BeginTime25, T1.D25 AS EndTime25, T2.D26 AS BeginTime26, T1.D26 AS EndTime26,
T2.D27 AS BeginTime27, T1.D27 AS EndTime27, T2.D28 AS BeginTime28, T1.D28 AS EndTime28, T2.D29 AS BeginTime29, T1.D29 AS EndTime29, T2.D30 AS BeginTime30, 
T1.D30 AS EndTime30, T2.D31 AS BeginTime31,  T1.D31 AS EndTime31
FROM #ActTime_EndTime T1
INNER JOIN #ActTime_BeginTime T2 ON T1.EmployeeID = T2.EmployeeID
INNER JOIN HT1400 WITH (NOLOCK) ON T1.EmployeeID = HT1400.EmployeeID AND T1.DivisionID = HT1400.DivisionID
LEFT JOIN AT1102 WITH (NOLOCK) ON HT1400.DepartmentID = AT1102.DepartmentID AND AT1102.DivisionID IN ('''+@DivisionID+''', ''@@@'')
'
--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

