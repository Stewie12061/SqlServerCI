IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3014]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3014]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In báo cáo theo dõi tình hình nghỉ bệnh của nhân viên (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
--- Created on 30/12/2018 by Bảo Anh
-- <Example>
---- EXEC HRMP3014 'NTY',2019,'01,02,03,04,05,06,07,08,09,10,11,12,13,CON',''
/*-- <Example>

----*/

CREATE PROCEDURE HRMP3014
( 
	@DivisionList VARCHAR(MAX),
	@TranYear INT,
	@DepartmentList VARCHAR(MAX),
	@TeamList VARCHAR(MAX)
)
AS 
DECLARE @sSQL VARCHAR (MAX)='',
		@sWhere VARCHAR(MAX)='',
		@i INT = 1,
		@s VARCHAR(3)=''

SET @sWhere = 'HT1360.DivisionID IN (''' + @DivisionList + ''')'

IF ISNULL(@DepartmentList,'') <> ''
	SET @sWhere = @sWhere + ' AND HT1360.DepartmentID IN (''' + @DepartmentList + ''')'

IF ISNULL(@TeamList, '') <> ''
	SET @sWhere = @sWhere + ' AND ISNULL(HT1360.TeamID,'''') IN ('''+@TeamList+''')'

--- Lấy danh sách nhân viên làm việc theo từng tháng trong năm
CREATE TABLE #HT13601 (DivisionID VARCHAR(50), TranMonth INT, EmployeeID VARCHAR(50), IsMale TINYINT, DutyGroupID VARCHAR(50))

WHILE @i <= 12
BEGIN
	SET @s = CASE WHEN @i < 10 THEN '0' + LTRIM(@i) ELSE LTRIM(@i) END

	SET @sSQL = '
	INSERT INTO #HT13601
	SELECT HT1360.DivisionID, ' + LTRIM(@i) + ' AS TranMonth, HT1360.EmployeeID, HT1400.IsMale, HT1102.DutyGroupID
	FROM HT1360 WITH (NOLOCK)
	LEFT JOIN HT1105 WITH (NOLOCK) ON HT1360.DivisionID = HT1105.DivisionID AND HT1360.ContractTypeID = HT1105.ContractTypeID
	LEFT JOIN HT1400 WITH (NOLOCK) ON HT1360.DivisionID = HT1400.DivisionID AND HT1360.EmployeeID = HT1400.EmployeeID
	LEFT JOIN HT1403 WITH (NOLOCK) ON HT1360.DivisionID = HT1403.DivisionID AND HT1360.EmployeeID = HT1403.EmployeeID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1403.DivisionID = HT1102.DivisionID AND HT1403.DutyID = HT1102.DutyID
	WHERE ' + @sWhere + ' AND Year(HT1360.SignDate) = ' + LTRIM(@TranYear) + ' AND Month(HT1360.SignDate) = ' + LTRIM(@i) + '
	
	UNION --ALL
	SELECT HT1360.DivisionID, ' + LTRIM(@i) + ' AS TranMonth, HT1360.EmployeeID, HT1400.IsMale, HT1102.DutyGroupID
	FROM HT1360 WITH (NOLOCK)
	LEFT JOIN HT1105 WITH (NOLOCK) ON HT1360.DivisionID = HT1105.DivisionID AND HT1360.ContractTypeID = HT1105.ContractTypeID
	LEFT JOIN HT1400 WITH (NOLOCK) ON HT1360.DivisionID = HT1400.DivisionID AND HT1360.EmployeeID = HT1400.EmployeeID
	LEFT JOIN HT1403 WITH (NOLOCK) ON HT1360.DivisionID = HT1403.DivisionID AND HT1360.EmployeeID = HT1403.EmployeeID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1403.DivisionID = HT1102.DivisionID AND HT1403.DutyID = HT1102.DutyID
	WHERE ' + @sWhere + ' AND HT1360.SignDate < CONVERT(DATETIME,''' + @s+'/01/'+LTRIM(@TranYear) + ''',101)
	AND (HT1105.Months = 0 OR DATEADD(m,HT1105.Months,HT1360.SignDate) > CONVERT(DATETIME,''' + @s+'/01/'+LTRIM(@TranYear) + ''',101))
	AND NOT EXISTS (SELECT 1 FROM HT1380 WITH (NOLOCK) WHERE DivisionID = HT1360.DivisionID AND EmployeeID = HT1360.EmployeeID
					AND LeaveDate < CONVERT(DATETIME,''' + @s+'/01/'+LTRIM(@TranYear) + ''',101))
	'
	--PRINT @sSQL
	EXEC(@sSQL)
	SET @i = @i + 1
END

--- Lấy số ngày làm việc của các nhân viên theo từng tháng
CREATE TABLE #WorkingDays (DivisionID VARCHAR(50), TranMonth INT, EmployeeID VARCHAR(50), WorkingDays INT)

SET @sSQL = '
INSERT INTO #WorkingDays
SELECT	DivisionID, TranMonth, EmployeeID, COUNT(AbsentDate) AS WorkingDays
FROM 
	(SELECT DISTINCT DivisionID, TranMonth, EmployeeID, AbsentDate
	FROM HT2408 WITH (NOLOCK)
	WHERE DivisionID IN (''' + @DivisionList + ''') AND TranYear = ' + LTRIM(@TranYear) + '
	) HT2408
GROUP BY DivisionID, TranMonth, EmployeeID
'
EXEC(@sSQL)

--- Lấy số ngày nghỉ bệnh của nhân viên theo từng tháng
CREATE TABLE #LeaveDays (DivisionID VARCHAR(50), TranMonth INT, EmployeeID VARCHAR(50), LeaveDays DECIMAL)

SET @sSQL = '
INSERT INTO #LeaveDays
SELECT OOT9000.DivisionID, OOT9000.TranMonth, OOT2010.EmployeeID, SUM(OOT2010.TotalDay) AS LeaveDays
	FROM OOT9000 WITH (NOLOCK)
	LEFT JOIN OOT2010 WITH (NOLOCK) ON OOT9000.DivisionID = OOT2010.DivisionID AND OOT9000.APK = OOT2010.APKMaster
	INNER JOIN OOT1000 WITH (NOLOCK) ON OOT1000.DivisionID = OOT2010.DivisionID AND OOT1000.AbsentTypeID = OOT2010.AbsentTypeID AND ISNULL(OOT1000.IsSickLeave,0) = 1
	WHERE OOT9000.DivisionID IN (''' + @DivisionList + ''') AND OOT9000.TranYear = ' + LTRIM(@TranYear) + ' AND OOT9000.Type = ''DXP''
		AND OOT9000.DepartmentID IN (''' + @DepartmentList + ''')
GROUP BY OOT9000.DivisionID, OOT9000.TranMonth, OOT2010.EmployeeID
'

--print  @sSQL
EXEC(@sSQL)
--- Trả dữ liệu báo cáo
SELECT	#HT13601.DivisionID, #HT13601.TranMonth, COUNT(#HT13601.EmployeeID) AS EmployeeTotal, 
		SUM(CASE WHEN #HT13601.IsMale = 1 AND #HT13601.DutyGroupID <> 'CN' THEN 1 ELSE 0 END) AS ColumnD,	--- số lượng nhân viên nam
		SUM(CASE WHEN #HT13601.IsMale = 0 AND #HT13601.DutyGroupID <> 'CN' THEN 1 ELSE 0 END) AS ColumnE,	--- số lượng nhân viên nữ
		SUM(CASE WHEN #HT13601.IsMale = 1 AND #HT13601.DutyGroupID = 'CN' THEN 1 ELSE 0 END) AS ColumnF,	--- số lượng công nhân nam
		SUM(CASE WHEN #HT13601.IsMale = 0 AND #HT13601.DutyGroupID = 'CN' THEN 1 ELSE 0 END) AS ColumnG,	--- số lượng công nhân nữ
		MAX(CASE WHEN #HT13601.IsMale = 1 AND #HT13601.DutyGroupID <> 'CN' THEN #WorkingDays.WorkingDays ELSE 0 END) AS ColumnH,	--- số ngày làm việc của nhân viên nam
		MAX(CASE WHEN #HT13601.IsMale = 0 AND #HT13601.DutyGroupID <> 'CN' THEN #WorkingDays.WorkingDays ELSE 0 END) AS ColumnI,	--- số ngày làm việc của nhân viên nữ
		MAX(CASE WHEN #HT13601.IsMale = 1 AND #HT13601.DutyGroupID = 'CN' THEN #WorkingDays.WorkingDays ELSE 0 END) AS ColumnJ,	--- số ngày làm việc của công nhân nam
		MAX(CASE WHEN #HT13601.IsMale = 0 AND #HT13601.DutyGroupID = 'CN' THEN #WorkingDays.WorkingDays ELSE 0 END) AS ColumnK,	--- số ngày làm việc của công nhân nữ
		SUM(CASE WHEN #HT13601.IsMale = 1 THEN #LeaveDays.LeaveDays ELSE 0 END) AS ColumnL,	--- số ngày nghỉ bệnh nhân viên nam
		SUM(CASE WHEN #HT13601.IsMale = 0 THEN #LeaveDays.LeaveDays ELSE 0 END) AS ColumnM,	--- số ngày nghỉ bệnh nhân viên nữ
		@TranYear TranYear
FROM #HT13601
LEFT JOIN #WorkingDays ON #HT13601.DivisionID = #WorkingDays.DivisionID AND #HT13601.TranMonth = #WorkingDays.TranMonth AND #HT13601.EmployeeID = #WorkingDays.EmployeeID
LEFT JOIN #LeaveDays ON #HT13601.DivisionID = #LeaveDays.DivisionID AND #HT13601.TranMonth = #LeaveDays.TranMonth AND #HT13601.EmployeeID = #LeaveDays.EmployeeID
GROUP BY #HT13601.DivisionID, #HT13601.TranMonth
ORDER BY #HT13601.DivisionID, #HT13601.TranMonth



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO