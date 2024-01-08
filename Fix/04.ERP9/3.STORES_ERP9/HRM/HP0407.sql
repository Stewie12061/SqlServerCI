IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0407]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0407]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In báo cáo tổng hợp phép năm (ERP 9.0)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tiểu Mai on 12/12/2016
--- Modified on 07/01/2019 by Bảo Anh: Bổ sung các cột phép nghỉ bù
--- Modified on 13/06/2020 by Văn Tài: Điều chỉnh cách lấy TOP 1 DaysInYear.
-- <Example>
---- 
/*-- <Example>
	EXEC HP0407 'NTY',2018,NULL, NULL, NULL, 'HF0406'
----*/

CREATE PROCEDURE HP0407
( 
	@DivisionID VARCHAR(50),
	@TranYear INT,
	@ListDepartmentID NVARCHAR(MAX),
	@ListTeamID NVARCHAR(MAX),
	@ListEmployeeID NVARCHAR(MAX),
	@ReportID NVARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX), @sSQL1 NVARCHAR(MAX), @sSQL2 NVARCHAR(MAX), @sSQL3 NVARCHAR(MAX),
        @sWhere NVARCHAR(MAX)
 
SET @sSQL = ''
SET @sSQL1 = ''
SET @sSQL2 = ''
SET @sSQL3 = ''
SET @sWhere = ''

IF isnull(@ListDepartmentID,'%') = '%'
	SET @sWhere = @sWhere + '
				AND H14.DepartmentID LIKE N''%'' '
ELSE 	
	SET @sWhere = @sWhere + '
				AND H14.DepartmentID IN ('''+@ListDepartmentID+''') ' 
				
IF isnull(@ListTeamID,'%') = '%'
	SET @sWhere = @sWhere + '
				AND H14.TeamID LIKE N''%'' '
ELSE 	
	SET @sWhere = @sWhere + '
				AND H14.TeamID IN ('''+@ListTeamID+''') ' 

IF isnull(@ListEmployeeID,'%') = '%'
	SET @sWhere = @sWhere + '
				AND H14.EmployeeID LIKE N''%'' '
ELSE 	
	SET @sWhere = @sWhere + '
				AND H14.EmployeeID IN ('''+@ListEmployeeID+''') ' 
SET @sSQL = '				         
SELECT H14.DepartmentID, H14.DepartmentName, H14.TEAMID, H14.TeamName, H03.EmployeeID, H14.FullName, H03.TranMonth, 
		(SELECT TOP 1 MAX(HT2803.DaysInYear) FROM HT2803 WHERE H14.EmployeeID = H03.EmployeeID) AS DaysInYear,
		--ISNULL(H03.DaysInYear,0) AS DaysInYear, 
		ISNULL(H04.VacSeniorDays,0) AS VacSeniorDays, ISNULL(H05.DaysPrevMonth,0) AS DaysPrevMonth,
		ISNULL(AddDays,0) AS AddDays, ISNULL(DaysSpent,0) AS DaysSpent, ISNULL(HT1029.IsManagaVacation,0) AS IsManagaVacation, H05.MethodVacationID
INTO #TEMP
FROM HT2803 H03 WITH (NOLOCK)
LEFT JOIN HV1400 H14 ON H14.DivisionID = H03.DivisionID AND H14.EmployeeID = H03.EmployeeID
LEFT JOIN (SELECT DivisionID, EmployeeID, MAX(VacSeniorDays) AS VacSeniorDays 
           FROM HT2803 WITH (NOLOCK)
           WHERE DivisionID = '''+@DivisionID+''' AND TranYear = '+CONVERT(Nvarchar(5),@TranYear)+'
           GROUP BY DivisionID, EmployeeID) H04 
			ON H14.DivisionID = H03.DivisionID AND H04.EmployeeID = H03.EmployeeID
LEFT JOIN (SELECT DivisionID, EmployeeID, DaysPrevMonth, MethodVacationID 
           FROM HT2803 WITH (NOLOCK)
           WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = 1 AND TranYear = '+CONVERT(Nvarchar(5),@TranYear)+') H05 
			ON H14.DivisionID = H03.DivisionID AND H05.EmployeeID = H03.EmployeeID
LEFT JOIN HT1029 WITH (NOLOCK) ON HT1029.DivisionID = H05.DivisionID AND HT1029.MethodVacationID = H05.MethodVacationID
WHERE H03.DivisionID = '''+@DivisionID+''' AND H03.TranYear = '+CONVERT(Nvarchar(5),@TranYear)
+ @sWhere + '
ORDER BY H14.DepartmentID, H14.TEAMID, H03.EmployeeID, H03.TranMonth  
'
SET @sSQL1 = '
SELECT *
INTO #TEMP1
FROM  
(SELECT DepartmentID, DepartmentName, TeamID, TeamName, EmployeeID, FullName, DaysInYear, VacSeniorDays, DaysPrevMonth,
		IsManagaVacation, AddDays, TranMonth, MethodVacationID  
    FROM #TEMP) AS SourceTable  
PIVOT  
(  
MAX(AddDays)  
FOR TranMonth IN ([1], [2], [3], [4],[5], [6], [7], [8], [9],[10], [11], [12])  
) AS PivotTable;

SELECT *
INTO #TEMP2
FROM  
(SELECT DepartmentID, DepartmentName, TeamID, TeamName, EmployeeID, FullName, DaysInYear, VacSeniorDays, DaysPrevMonth,
		IsManagaVacation, DaysSpent, TranMonth, MethodVacationID  
    FROM #TEMP) AS SourceTable  
PIVOT  
(  
MAX(DaysSpent)  
FOR TranMonth IN ([1], [2], [3], [4],[5], [6], [7], [8], [9],[10], [11], [12])  
) AS PivotTable;
'

--- Customize NEWTOYO: Lấy tồn phép bù
IF (SELECT CustomerName FROM CustomerIndex) = 81
BEGIN
	SET @sSQL2 = '
	--- Tinh phep bu ton dau
	SELECT	#TEMP.EmployeeID,
			ISNULL(HT1420.FirstOTLeaveDays,0) + ISNULL(I.IncreaseDays,0) - ISNULL(D.DecreaseDays,0) AS BeginOTLeaveDays
	INTO #TEMP0
	FROM (SELECT DISTINCT EmployeeID FROM #TEMP) #TEMP 
	LEFT JOIN HT1420 WITH (NOLOCK) ON #TEMP.EmployeeID = HT1420.EmployeeID
	LEFT JOIN (	SELECT H22.EmployeeID, SUM(CASE WHEN H13.UnitID = ''H'' THEN ISNULL((H22.AbsentAmount/H00.TimeConvert),0) ELSE ISNULL(H22.AbsentAmount,0) END) AS IncreaseDays
				FROM HT2401 H22 WITH (NOLOCK)
				LEFT JOIN HT0000 H00 WITH (NOLOCK) ON H22.DivisionID = H00.DivisionID
				LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = H22.DivisionID AND H13.AbsentTypeID = H22.AbsentTypeID
				LEFT JOIN HT1013 H14 WITH (NOLOCK) ON H13.DivisionID = H14.DivisionID AND H13.ParentID = H14.AbsentTypeID AND H14.IsMonth = 1
				WHERE H22.DivisionID = ''' + @DivisionID + ''' AND H22.TranYear < ' + LTRIM(@TranYear) + '
				AND H13.IsMonth = 0 AND ISNULL(H14.IsOTLeave,0) = 1 AND ISNULL(H22.IsFromAO,0) = 0
				GROUP BY H22.EmployeeID) I ON #TEMP.EmployeeID = I.EmployeeID
	LEFT JOIN (	SELECT H22.EmployeeID, SUM(CASE WHEN H13.UnitID = ''H'' THEN ISNULL((H22.AbsentAmount/H00.TimeConvert),0) ELSE ISNULL(H22.AbsentAmount,0) END) AS DecreaseDays
				FROM HT2401_MK H22 WITH (NOLOCK)
				LEFT JOIN HT0000 H00 WITH (NOLOCK) ON H22.DivisionID = H00.DivisionID
				LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = H22.DivisionID AND H13.AbsentTypeID = H22.AbsentTypeID
				LEFT JOIN HT1013 H14 WITH (NOLOCK) ON H13.DivisionID = H14.DivisionID AND H13.ParentID = H14.AbsentTypeID AND H14.IsMonth = 1
				WHERE H22.DivisionID = ''' + @DivisionID + ''' AND H22.TranYear < ' + LTRIM(@TranYear) + '
				AND H13.IsMonth = 0 AND ISNULL(H14.IsOTLeave,0) = 1
				GROUP BY H22.EmployeeID) D ON #TEMP.EmployeeID = D.EmployeeID


	SELECT	#TEMP.EmployeeID,
			ISNULL(#TEMP0.BeginOTLeaveDays,0) AS BeginOTLeaveDays,
			ISNULL(I.IncreaseDays,0) AS IncreaseOTLeaveDays,
			ISNULL(D.DecreaseDays,0) AS DecreaseOTLeaveDays,
			ISNULL(#TEMP0.BeginOTLeaveDays,0) + ISNULL(I.IncreaseDays,0) - ISNULL(D.DecreaseDays,0) AS RemainOTLeaveDays
	INTO #TEMP3
	FROM (SELECT DISTINCT EmployeeID FROM #TEMP) #TEMP 
	LEFT JOIN #TEMP0 ON #TEMP.EmployeeID = #TEMP0.EmployeeID
	LEFT JOIN (	SELECT H22.EmployeeID, SUM(CASE WHEN H13.UnitID = ''H'' THEN ISNULL((H22.AbsentAmount/H00.TimeConvert),0) ELSE ISNULL(H22.AbsentAmount,0) END) AS IncreaseDays
				FROM HT2401 H22 WITH (NOLOCK)
				LEFT JOIN HT0000 H00 WITH (NOLOCK) ON H22.DivisionID = H00.DivisionID
				LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = H22.DivisionID AND H13.AbsentTypeID = H22.AbsentTypeID
				LEFT JOIN HT1013 H14 WITH (NOLOCK) ON H13.DivisionID = H14.DivisionID AND H13.ParentID = H14.AbsentTypeID AND H14.IsMonth = 1
				WHERE H22.DivisionID = ''' + @DivisionID + ''' AND H22.TranYear = ' + LTRIM(@TranYear) + '
				AND H13.IsMonth = 0 AND ISNULL(H14.IsOTLeave,0) = 1 AND ISNULL(H22.IsFromAO,0) = 0
				GROUP BY H22.EmployeeID) I ON #TEMP.EmployeeID = I.EmployeeID
	LEFT JOIN (	SELECT H22.EmployeeID, SUM(CASE WHEN H13.UnitID = ''H'' THEN ISNULL((H22.AbsentAmount/H00.TimeConvert),0) ELSE ISNULL(H22.AbsentAmount,0) END) AS DecreaseDays
				FROM HT2401_MK H22 WITH (NOLOCK)
				LEFT JOIN HT0000 H00 WITH (NOLOCK) ON H22.DivisionID = H00.DivisionID
				LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = H22.DivisionID AND H13.AbsentTypeID = H22.AbsentTypeID
				LEFT JOIN HT1013 H14 WITH (NOLOCK) ON H13.DivisionID = H14.DivisionID AND H13.ParentID = H14.AbsentTypeID AND H14.IsMonth = 1
				WHERE H22.DivisionID = ''' + @DivisionID + ''' AND H22.TranYear = ' + LTRIM(@TranYear) + '
				AND H13.IsMonth = 0 AND ISNULL(H14.IsOTLeave,0) = 1
				GROUP BY H22.EmployeeID) D ON #TEMP.EmployeeID = D.EmployeeID
	'
END

SET @sSQL3 = '
SELECT ROW_NUMBER () OVER(ORDER BY t1.DepartmentID, t1.TeamID, t1.EmployeeID) AS Row, t1.DepartmentID, t1.DepartmentName, t1.TeamID, t1.TeamName, t1.EmployeeID, t1.FullName, t1.MethodVacationID, t1.DaysInYear, t1.VacSeniorDays, t1.DaysPrevMonth, t1.IsManagaVacation, 
	ISNULL(t1.[1],0) AS AddTran01, ISNULL(t1.[2],0) AS AddTran02, ISNULL(t1.[3],0) AS AddTran03, ISNULL(t1.[4],0) AS AddTran04, ISNULL(t1.[5],0) AS AddTran05, ISNULL(t1.[6],0) AS AddTran06,
	ISNULL(t1.[7],0) AS AddTran07, ISNULL(t1.[8],0) AS AddTran08, ISNULL(t1.[9],0) AS AddTran09, ISNULL(t1.[10],0) AS AddTran10, ISNULL(t1.[11],0) AS AddTran11, ISNULL(t1.[12],0) AS AddTran12,
	ISNULL(t2.[1],0) AS SpentTran01, ISNULL(t2.[2],0) AS SpentTran02, isnull(t2.[3],0) AS SpentTran03, ISNULL(t2.[4],0) AS SpentTran04, ISNULL(t2.[5],0) AS SpentTran05, ISNULL(t2.[6],0) AS SpentTran06,
	ISNULL(t2.[7],0) AS SpentTran07, ISNULL(t2.[8],0) AS SpentTran08, isnull(t2.[9],0) AS SpentTran09, ISNULL(t2.[10],0) AS SpentTran10, ISNULL(t2.[11],0) AS SpentTran11, ISNULL(t2.[12],0) AS SpentTran12
'

IF (SELECT CustomerName FROM CustomerIndex) = 81
	SET @sSQL3 = @sSQL3+',
	t3.BeginOTLeaveDays, t3.IncreaseOTLeaveDays, t3.DecreaseOTLeaveDays, t3.RemainOTLeaveDays'

SET @sSQL3 = @sSQL3+'
FROM #TEMP1 t1
LEFT JOIN #TEMP2 t2 ON t1.EmployeeID = t2.EmployeeID'

IF (SELECT CustomerName FROM CustomerIndex) = 81
	SET @sSQL3 = @sSQL3+'
LEFT JOIN #TEMP3 t3 ON t1.EmployeeID = t3.EmployeeID'

EXEC (@sSQL+@sSQL1+@sSQL2+@sSQL3)
PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
