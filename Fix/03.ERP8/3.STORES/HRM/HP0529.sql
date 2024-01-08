IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0529]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0529]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load form HF0518 khi edit/view (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 20/11/2017
----Modified by Bảo Thy on 09/01/2018: fix lỗi trường hợp tháng có 31 ngày
----Modified by Bảo Thy on 10/01/2018: nếu giá trị <0 thì hiển thị 0
----Modified by on
-- <Example>
---- 
/*-- <Example>	
EXEC [HP0529] @DivisionID = 'NTY', @MachineID = 'CONEBO1', @TranMonth = 10, @TranYear = 2017	
----*/
CREATE PROCEDURE HP0529
( 
	 @DivisionID VARCHAR(50),
	 @MachineID VARCHAR(50),
	 @TranMonth INT,
	 @TranYear INT
)
AS 
DECLARE @EmployeeID VARCHAR(50)

SELECT @EmployeeID = MAX(EmployeeID)
FROM HT1113 T1 WITH (NOLOCK)
WHERE T1.DivisionID = @DivisionID
AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100
AND T1.MachineID = @MachineID

SELECT T1.APK, T1.DivisionID, T1.MachineID, T2.MachineName, T1.TranMonth, T1.TranYear, T1.Date, CONVERT(DATETIME,T4.FromTime,120) AS FromTime, 
CONVERT(DATETIME,T4.ToTime,120) AS ToTime, CONVERT(DATETIME,NULL,120) AS StandardFromTime, CONVERT(DATETIME,NULL,120) AS StandardToTime,
T1.ActWorkingTime, T1.StandardQuantity,T1.InQuantity, T1.OutQuantity, (ISNULL(T1.InQuantity,0) + ISNULL(T1.OutQuantity,0)) AS TotalQuantity, 
CASE WHEN T1.InVariance <= 0 THEN 0 ELSE T1.InVariance END InVariance, CASE WHEN T1.TotalVariance <= 0 THEN 0 ELSE T1.TotalVariance END AS TotalVariance, T1.Notes, T1.CreateUserID, T1.CreateDate, 
T1.LastModifyUserID, T1.LastModifyDate, CONVERT(DECIMAL(28,8),NULL) AS StopWorkingTime, CONVERT(VARCHAR(50),NULL) AS ShiftID
INTO #HP0529_HT1117
FROM HT1117 T1 WITH (NOLOCK)
LEFT JOIN HT1109 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.MachineID = T2.MachineID
INNER JOIN HT1110 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T1.MachineID = T3.MachineID AND T1.TranMonth+T1.TranYear*100 = T3.TranMonth+T3.TranYear*100
INNER JOIN HT1111 T4 WITH (NOLOCK) ON T3.DivisionID = T4.DivisionID AND T3.APK = T4.APKMaster AND T1.Date = T4.Date
WHERE T1.DivisionID = @DivisionID
AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100
AND T1.MachineID = @MachineID
GROUP BY T1.APK, T1.DivisionID, T1.MachineID, T2.MachineName, T1.TranMonth, T1.TranYear, T1.Date, T4.FromTime, T4.ToTime, T1.ActWorkingTime, T1.StandardQuantity,
T1.InQuantity, T1.OutQuantity, T1.InVariance, T1.TotalVariance, T1.Notes, T1.CreateUserID, T1.CreateDate, T1.LastModifyUserID, T1.LastModifyDate

SELECT *
INTO #Temp_HT1025
FROM 
(
	SELECT HT1025.DivisionID, HT1025.TranMonth, HT1025.TranYear, HT1025.EmployeeID,[D01],[D02],[D03],[D04],[D05],
	[D06],[D07],[D08],[D09],[D10],[D11],[D12],[D13],[D14],[D15],[D16],[D17],[D18],[D19],[D20],[D21],[D22],[D23],[D24],[D25],[D26],[D27],[D28],[D29],[D30],[D31]
	FROM HT1025 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @EmployeeID
) p
UNPIVOT
(ShiftID FOR StrDate IN 
([D01],[D02],[D03],[D04],[D05],[D06],[D07],[D08],[D09],[D10],[D11],[D12],[D13],[D14],[D15],[D16],[D17],[D18],[D19],[D20],[D21],[D22],[D23],[D24],[D25],[D26],[D27],[D28],[D29],[D30],[D31])
)AS unpvt

DECLARE @LastDay INT = DAY(DATEADD(DAY,-(DAY(CONVERT(DATETIME,STR(@TranMonth)+'/01/'+STR(@TranYear)))),DATEADD(MONTH,1,CONVERT(DATETIME,STR(@TranMonth)+'/01/'+STR(@TranYear)))))
UPDATE T1
SET T1.ShiftID = T2.ShiftID
FROM #HP0529_HT1117 T1
INNER JOIN #Temp_HT1025 T2 ON T1.DivisionID = T2.DivisionID AND T2.EmployeeID = @EmployeeID AND T1.TranMonth+T1.TranYear*100 = T2.TranMonth+T2.TranYear*100
AND T1.Date = CONVERT(DATETIME,CONVERT(VARCHAR(4),@TranYear)+'-'+CONVERT(VARCHAR(2),@TranMonth)+'-'+LTRIM(RIGHT(StrDate,2)),120) AND CONVERT(INT,LTRIM(RIGHT(StrDate,2))) <= @LastDay

UPDATE T1
SET T1.StandardFromTime = CONVERT(DATETIME,ISNULL(T2.StandardFromTime, T3.FromBreakTime),120),
	T1.StandardToTime = CONVERT(DATETIME,ISNULL(T2.StandardToTime, T3.ToBreakTime),120),
	T1.StopWorkingTime = T2.StopWorkingTime
FROM #HP0529_HT1117 T1
LEFT JOIN 
(	SELECT DivisionID, MachineID, TranMonth, TranYear, Date, SUM(ISNULL(TotalTime,0)) AS StopWorkingTime, MAX(StandardFromTime) AS StandardFromTime, MAX(StandardToTime) AS StandardToTime
	FROM HT1115 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID
	AND TranMonth+TranYear*100 = @TranMonth+@TranYear*100 AND MachineID = @MachineID
	GROUP BY DivisionID, MachineID, TranMonth, TranYear, Date
)T2 ON T1.DivisionID = T2.DivisionID AND T1.MachineID = T2.MachineID AND T1.TranMonth+T1.TranYear*100 = T2.TranMonth+T2.TranYear*100 AND T1.Date = T2.Date
INNER JOIN HT1020 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T3.ShiftID = T1.ShiftID


SELECT * FROM #HP0529_HT1117
ORDER BY Date

DROP TABLE #Temp_HT1025
DROP TABLE #HP0529_HT1117

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
