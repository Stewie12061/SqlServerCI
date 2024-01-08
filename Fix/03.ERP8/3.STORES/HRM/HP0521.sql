IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0521]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0521]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Tính thời gian làm thực tế của nhân viên (gọi từ HP0520 - NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT-HRM \ Danh mục \ Thông tin chấm công \ Tính lương năng suất \ Tính lương
----
-- <History>
----Created by Bảo Thy on 03/10/2017
----Modified by Bảo Thy on 09/01/2018: fix lỗi trường hợp tháng có 31 ngày
---- Modified by  on 
-- <Example>
---- 
/*-- <Example>
	EXEC [HP0521] @DivisionID= 'CH', @TranMonth = 1, @TranYear = 2017
	
----*/
CREATE PROCEDURE HP0521
( 
	 @DivisionID VARCHAR(50),
	 @TranMonth INT,
	 @TranYear INT
)
AS 
DECLARE @LastDay INT = DAY(DATEADD(DAY,-(DAY(CONVERT(DATETIME,STR(@TranMonth)+'/01/'+STR(@TranYear)))),DATEADD(MONTH,1,CONVERT(DATETIME,STR(@TranMonth)+'/01/'+STR(@TranYear)))))
----Thời gian làm việc thực tế
SELECT DISTINCT unpvt.DivisionID, unpvt.TranMonth, unpvt.TranYear, unpvt.EmployeeID, unpvt.StrDate, T1.MachineID,
CONVERT(DATE,CONVERT(VARCHAR(4),@TranYear)+'-'+CONVERT(VARCHAR(2),@TranMonth)+'-'+ RIGHT(StrDate,LEN(StrDate) -1),120) AS [Date], unpvt.ShiftID,

CASE WHEN T1.ActFromTime BETWEEN HT1020.BeginTime AND HT1020.EndTime THEN T1.ActFromTime 
	 WHEN T1.ActFromTime <= HT1020.BeginTime AND T1.ActToTime >= HT1020.BeginTime THEN HT1020.BeginTime END AS BeginTime,
CASE WHEN T1.ActToTime BETWEEN HT1020.BeginTime AND HT1020.EndTime THEN T1.ActToTime
	 WHEN T1.ActToTime >= HT1020.EndTime AND T1.ActFromTime <= HT1020.EndTime THEN HT1020.EndTime END AS EndTime

INTO #HP0521_LVTT
FROM 
(SELECT HT1025.DivisionID, HT1025.TranMonth, HT1025.TranYear, HT1025.EmployeeID,[D01],[D02],[D03],[D04],[D05],
[D06],[D07],[D08],[D09],[D10],[D11],[D12],[D13],[D14],[D15],[D16],[D17],[D18],[D19],[D20],[D21],[D22],[D23],
[D24],[D25],[D26],[D27],[D28],[D29],[D30],[D31]
FROM HT1025 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear) p
UNPIVOT
(ShiftID FOR StrDate IN 
([D01],[D02],[D03],[D04],[D05],[D06],[D07],[D08],[D09],[D10],[D11],[D12],[D13],[D14],[D15],[D16],[D17],[D18],[D19],
[D20],[D21],[D22],[D23],[D24],[D25],[D26],[D27],[D28],[D29],[D30],[D31])
)AS unpvt
INNER JOIN HT1020 WITH (NOLOCK) ON unpvt.DivisionID = HT1020.DivisionID AND unpvt.ShiftID = HT1020.ShiftID
INNER JOIN Employee_HP0520 T1 ON unpvt.DivisionID = T1.DivisionID AND unpvt.EmployeeID = T1.EmployeeID AND T1.DutyID = 'NV'
	   AND CONVERT(DATE,CONVERT(VARCHAR(4),@TranYear)+'-'+CONVERT(VARCHAR(2),@TranMonth)+'-'+ RIGHT(StrDate,LEN(StrDate) -1),120) = T1.FromDate AND CONVERT(INT,RIGHT(StrDate,LEN(StrDate) -1)) <= @LastDay
--INNER JOIN 
--(
--	SELECT HT1021.ShiftID, HT1021.DateTypeID, MAX(HT1021.IsNextDay) AS IsNextDay
--	FROM HT1021 WITH (NOLOCK) 
--	--WHERE EXISTS (SELECT TOP 1 1 FROM unpvt WHERE HT1021.DivisionID = unpvt.DivisionID AND HT1021.ShiftID = unpvt.ShiftID )
--	GROUP BY HT1021.ShiftID, HT1021.DateTypeID
--)T2 ON unpvt.ShiftID = T2.ShiftID AND DATENAME(dd,T1.FromDate) = T2.DateTypeID

---Thời gian nghỉ thực tế
SELECT DISTINCT T1.EmployeeID, T1.ShiftID, T1.[Date],
CASE WHEN T2.FromBreakTime BETWEEN T1.BeginTime AND T1.EndTime THEN T2.FromBreakTime 
	 WHEN T2.FromBreakTime <= T1.BeginTime AND T2.ToBreakTime >= T1.BeginTime THEN T1.BeginTime END AS FromBreakTime,
CASE WHEN T2.ToBreakTime BETWEEN T1.BeginTime AND T1.EndTime THEN T2.ToBreakTime
	 WHEN T2.ToBreakTime >= T1.EndTime AND T2.FromBreakTime <= T1.EndTime THEN T1.EndTime END AS ToBreakTime
INTO #HP0521_NTT
FROM #HP0521_LVTT T1
INNER JOIN HT1020 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ShiftID = T2.ShiftID

---Thời gian dừng máy thực tế
SELECT T1.EmployeeID, T1.ShiftID, T1.[Date], T1.MachineID,
CASE WHEN T2.FromTime BETWEEN T1.BeginTime AND T1.EndTime THEN T2.FromTime 
	 WHEN T2.FromTime <= T1.BeginTime AND T2.ToTime >= T1.BeginTime THEN T1.BeginTime END AS StopFromTime,
CASE WHEN T2.ToTime BETWEEN T1.BeginTime AND T1.EndTime THEN T2.ToTime
	 WHEN T2.ToTime >= T1.EndTime AND T2.FromTime <= T1.EndTime THEN T1.EndTime END AS StopToTime
INTO #HP0521_DMTT
FROM #HP0521_LVTT T1
LEFT JOIN HT1115 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear AND T1.MachineID = T2.MachineID
ANd T1.[Date] = T2.[Date]

---Tính số giờ tính lương năng suất
IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WorkingTime_HP0521]') AND TYPE IN (N'U'))
DROP TABLE WorkingTime_HP0521

SELECT	T1.DivisionID, T1.TranMonth, T1.TranYear, T1.EmployeeID, T1.StrDate, T1.MachineID, T1.[Date], T1.ShiftID,
CONVERT(DECIMAL(28,8),DATEDIFF(mi,T1.BeginTime,T1.EndTime))/60 - ISNULL(CONVERT(DECIMAL(28,8),DATEDIFF(mi,T2.FromBreakTime,T2.ToBreakTime))/60,0) - 
SUM(ISNULL(CONVERT(DECIMAL(28,8),DATEDIFF(mi,T3.StopFromTime,T3.StopToTime))/60,0)) AS TotalInTime
INTO WorkingTime_HP0521
FROM	#HP0521_LVTT T1
LEFT JOIN #HP0521_NTT T2 ON T1.EmployeeID = T2.EmployeeID AND T1.ShiftID = T2.ShiftID AND T1.[Date] = T2.[Date]
LEFT JOIN #HP0521_DMTT T3 ON T1.EmployeeID = T3.EmployeeID AND T1.ShiftID = T3.ShiftID AND T1.[Date] = T3.[Date] AND T1.MachineID = T3.MachineID
GROUP BY T1.DivisionID, T1.TranMonth, T1.TranYear, T1.EmployeeID, T1.StrDate, T1.MachineID, T1.[Date], T1.ShiftID,T1.BeginTime,
T1.EndTime,T2.FromBreakTime,T2.ToBreakTime

--select '#HP0521_LVTT',*,CONVERT(DECIMAL(28,8),DATEDIFF(mi,BeginTime,EndTime))/60  from #HP0521_LVTT order by employeeid, date
--select '#HP0521_NTT',*, ISNULL(CONVERT(DECIMAL(28,8),DATEDIFF(mi,FromBreakTime,ToBreakTime))/60,0) from #HP0521_NTT order by employeeid, date
--select '#HP0521_DMTT',*, ISNULL(CONVERT(DECIMAL(28,8),DATEDIFF(mi,StopFromTime,StopToTime))/60,0) from #HP0521_DMTT order by employeeid, date
--select 'WorkingTime_HP0521',* from WorkingTime_HP0521 order by employeeid, date

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO