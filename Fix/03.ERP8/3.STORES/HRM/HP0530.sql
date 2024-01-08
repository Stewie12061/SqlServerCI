IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0530]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0530]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thoi gian san xuat, thoi gian dung may, sp gio lam viec (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 20/11/2017
----Modified by on
-- <Example>
---- 
/*-- <Example>	
EXEC [HP0530] @DivisionID = 'NTY', @MachineID = 'CONEBO1', @TranMonth = 10, @TranYear = 2017	
----*/
CREATE PROCEDURE HP0530
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

SELECT *
INTO #Temp_HT1025_HP0530
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


SELECT T1.DivisionID, T1.TranMonth, T1.TranYear, T1.MachineID, T2.Date, T2.FromTime, T2.ToTime, CONVERT(DATETIME,NULL,120) AS StandardFromTime, CONVERT(DATETIME,NULL,120) AS StandardToTime,
CONVERT(DECIMAL(28,8),NULL) AS ActWorkingTime, CONVERT(DECIMAL(28,8),NULL) AS StopWorkingTime, CONVERT(VARCHAR(50),NULL) AS ShiftID
INTO #HP0530_HT1110
FROM HT1110 T1 WITH (NOLOCK)
INNER JOIN HT1111 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.APKMaster
WHERE T1.DivisionID = @DivisionID
AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100
AND T1.MachineID = @MachineID

DECLARE @LastDay INT = DAY(DATEADD(DAY,-(DAY(CONVERT(DATETIME,STR(@TranMonth)+'/01/'+STR(@TranYear)))),DATEADD(MONTH,1,CONVERT(DATETIME,STR(@TranMonth)+'/01/'+STR(@TranYear)))))
UPDATE T1
SET T1.ShiftID = T2.ShiftID
FROM #HP0530_HT1110 T1
INNER JOIN #Temp_HT1025_HP0530 T2 ON T1.DivisionID = T2.DivisionID AND T2.EmployeeID = @EmployeeID AND T1.TranMonth+T1.TranYear*100 = T2.TranMonth+T2.TranYear*100
AND T1.Date = CONVERT(VARCHAR(4),@TranYear)+'-'+CONVERT(VARCHAR(50),@TranMonth)+'-'+LTRIM(RIGHT(StrDate,2)) AND CONVERT(INT,LTRIM(RIGHT(StrDate,2))) <= @LastDay


UPDATE T1 
SET T1.StandardFromTime = CONVERT(DATETIME,ISNULL(T2.StandardFromTime, T3.FromBreakTime),120),
	T1.StandardToTime = CONVERT(DATETIME,ISNULL(T2.StandardToTime, T3.ToBreakTime),120),
	T1.StopWorkingTime = T2.StopWorkingTime,
	T1.ActWorkingTime = CONVERT(DECIMAL(28,8),DATEDIFF(mi, T1.FromTime, T1.ToTime))/60 - 1 - ISNULL(T2.StopWorkingTime,0)
FROM #HP0530_HT1110 T1
LEFT JOIN 
(
 SELECT T1.DivisionID, T1.TranMonth, T1.TranYear, T1.MachineID, T1.Date, SUM(ISNULL(T1.TotalTime,0)) AS StopWorkingTime, MAX(T1.StandardFromTime) AS StandardFromTime, MAX(T1.StandardToTime) AS StandardToTime
 FROM HT1115 T1 WITH (NOLOCK)
 WHERE T1.DivisionID = @DivisionID
 AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100
 AND T1.MachineID = @MachineID
 GROUP BY T1.DivisionID, T1.TranMonth, T1.TranYear, T1.MachineID, T1.Date
) T2 ON T1.DivisionID = T2.DivisionID AND T1.MachineID = T2.MachineID AND T1.TranMonth+T1.TranYear*100 = T2.TranMonth+T2.TranYear*100 AND T1.Date = T2.Date
INNER JOIN HT1020 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T3.ShiftID = T1.ShiftID

SELECT * FROM #HP0530_HT1110 ORDER BY Date

DROP TABLE #Temp_HT1025_HP0530
DROP TABLE #HP0530_HT1110

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO