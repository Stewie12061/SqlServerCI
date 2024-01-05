IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3016]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo theo dõi tình hình nghỉ việc (ERP 9.0)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
--- Created on 12/02/2019 by Bảo Anh
-- <Example>
---- EXEC HRMP3016 'NTY',2017,'01,02,03,04,05,06,07,08,09,10,11,12,13,CON',''
/*-- <Example>

----*/

CREATE PROCEDURE HRMP3016
( 
	@DivisionList VARCHAR(MAX),
	@TranYear INT,
	@DepartmentList VARCHAR(MAX),
	@TeamList VARCHAR(MAX)
)
AS 
DECLARE @sSQL VARCHAR (MAX)='',
		@sSQL1 VARCHAR (MAX)='',
		@sSQL2 VARCHAR (MAX)='',
		@sWhere VARCHAR(MAX)='',
		@i INT = 1,
		@s VARCHAR(3)=''

SET @sWhere = 'HT1360.DivisionID IN (''' + @DivisionList + ''')'

IF ISNULL(@DepartmentList,'') <> ''
	SET @sWhere = @sWhere + ' AND HT1360.DepartmentID IN (''' + @DepartmentList + ''')'

IF ISNULL(@TeamList, '') <> ''
	SET @sWhere = @sWhere + ' AND ISNULL(HT1360.TeamID,'''') IN ('''+@TeamList+''')'

CREATE TABLE #HT1360 (DivisionID VARCHAR(50), TranMonth INT, EmployeeID VARCHAR(50))
CREATE TABLE #HT1380 (DivisionID VARCHAR(50), TranMonth INT, EmployeeID VARCHAR(50), ContractTypeID VARCHAR(50), IsLimitContract TINYINT, IsMale TINYINT, Ages TINYINT, IsST TINYINT)

WHILE @i <= 12
BEGIN
	SET @s = CASE WHEN @i < 10 THEN '0' + LTRIM(@i) ELSE LTRIM(@i) END

	--- Lấy danh sách nhân viên theo từng tháng
	SET @sSQL = '
	INSERT INTO #HT1360
	SELECT DivisionID, ' + LTRIM(@i) + ' AS TranMonth, EmployeeID
	FROM HT1360 WITH (NOLOCK)
	WHERE ' + @sWhere + ' 
		AND Year(HT1360.SignDate) = ' + LTRIM(@TranYear) + ' 
		AND Month(HT1360.SignDate) = ' + LTRIM(@i) + '
	UNION ALL
	SELECT HT1360.DivisionID, ' + LTRIM(@i) + ' AS TranMonth, HT1360.EmployeeID
	FROM HT1360 WITH (NOLOCK)
		LEFT JOIN HT1105 WITH (NOLOCK) ON HT1360.DivisionID = HT1105.DivisionID AND HT1360.ContractTypeID = HT1105.ContractTypeID
	WHERE ' + @sWhere + ' AND HT1360.SignDate < CONVERT(DATETIME,''' + @s+'/01/'+LTRIM(@TranYear) + ''',101)
		AND (HT1105.Months = 0 OR DATEADD(m,HT1105.Months,HT1360.SignDate) > CONVERT(DATETIME,''' + @s+'/01/'+LTRIM(@TranYear) + ''',101))
		AND NOT EXISTS 
			(
				SELECT 1 
				FROM HT1380 WITH (NOLOCK) 
				WHERE DivisionID = HT1360.DivisionID 
					AND EmployeeID = HT1360.EmployeeID
					AND LeaveDate < CONVERT(DATETIME,''' + @s+'/01/'+LTRIM(@TranYear) + ''',101)
			)
	'
	--PRINT @sSQL
	--- lấy danh sách nghỉ việc theo từng tháng
	SET @sSQL1 = '
	INSERT INTO #HT1380
	SELECT HT1380.DivisionID, ' + LTRIM(@i) + ' AS TranMonth, HT1380.EmployeeID,
		(
			SELECT TOP 1 ContractTypeID 
			FROM HT1360 WITH (NOLOCK) 
			WHERE DivisionID = HT1380.DivisionID AND EmployeeID = HT1380.EmployeeID
				AND SignDate < HT1380.DecidingDate 
			ORDER BY SignDate DESC
		) AS ContractTypeID,
		0 AS IsLimitContract,
		HT1400.IsMale, DATEDIFF(yy,HT1400.Birthday,HT1380.DecidingDate) AS Ages,
		(CASE WHEN HT1107.QuitJobID = ''ST'' THEN 1 ELSE 0 END) AS IsST	--- bị sa thải
	FROM HT1380 WITH (NOLOCK)
	LEFT JOIN HT1400 WITH (NOLOCK) ON HT1380.DivisionID = HT1400.DivisionID AND HT1380.EmployeeID = HT1400.EmployeeID
	LEFT JOIN HT1107 WITH (NOLOCK) ON HT1380.DivisionID = HT1107.DivisionID AND HT1380.QuitJobID = HT1107.QuitJobID
	WHERE HT1380.DivisionID IN (''' + @DivisionList + ''') 
		AND MONTH(HT1380.DecidingDate) = ' + LTRIM(@i) + ' 
		AND YEAR(HT1380.DecidingDate) = ' + LTRIM(@TranYear)
	
	IF ISNULL(@DepartmentList,'') <> ''
		SET @sSQL1 = @sSQL1 + ' AND HT1400.DepartmentID IN (''' + @DepartmentList + ''')'

	IF ISNULL(@TeamList, '') <> ''
		SET @sSQL1 = @sSQL1 + ' AND ISNULL(HT1380.TeamID,'''') IN ('''+@TeamList+''')'

	SET @sSQL2 = '
		UPDATE #HT1380
		SET IsLimitContract = (CASE WHEN HT1105.Months = 0 THEN 0 ELSE 1 END)
		FROM #HT1380
		LEFT JOIN HT1105 WITH (NOLOCK) ON #HT1380.DivisionID = HT1105.DivisionID AND #HT1380.ContractTypeID = HT1105.ContractTypeID
	'
	--PRINT @sSQL1
	EXEC(@sSQL)
	EXEC(@sSQL1)
	EXEC(@sSQL2)
	SET @i = @i + 1
END

--- lấy số nhân viên theo từng tháng
SELECT TranMonth, COUNT(EmployeeID) AS EmployeeTotal
INTO #HT1
FROM #HT1360
GROUP BY TranMonth

--- Lấy số nhân viên nghỉ việc trong từng tháng
SELECT	TranMonth,
		SUM(CASE WHEN IsMale = 1 AND IsLimitContract = 0 AND IsST = 0 THEN 1 ELSE 0 END) AS Count01,
		SUM(CASE WHEN IsMale = 1 AND IsLimitContract = 0 AND IsST = 1 THEN 1 ELSE 0 END) AS Count02,
		SUM(CASE WHEN IsMale = 1 AND IsLimitContract = 1 AND IsST = 0 THEN 1 ELSE 0 END) AS Count03,
		SUM(CASE WHEN IsMale = 1 AND IsLimitContract = 1 AND IsST = 1 THEN 1 ELSE 0 END) AS Count04,
		SUM(CASE WHEN IsMale = 0 AND IsLimitContract = 0 AND IsST = 0 THEN 1 ELSE 0 END) AS Count05,
		SUM(CASE WHEN IsMale = 0 AND IsLimitContract = 0 AND IsST = 1 THEN 1 ELSE 0 END) AS Count06,
		SUM(CASE WHEN IsMale = 0 AND IsLimitContract = 1 AND IsST = 0 THEN 1 ELSE 0 END) AS Count07,
		SUM(CASE WHEN IsMale = 0 AND IsLimitContract = 1 AND IsST = 1 THEN 1 ELSE 0 END) AS Count08,

		SUM(CASE WHEN IsMale = 1 AND Ages < 30 THEN 1 ELSE 0 END) AS Count09,
		SUM(CASE WHEN IsMale = 0 AND Ages < 30 THEN 1 ELSE 0 END) AS Count10,
		SUM(CASE WHEN IsMale = 1 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count11,
		SUM(CASE WHEN IsMale = 0 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count12,
		SUM(CASE WHEN IsMale = 1 AND Ages > 50 THEN 1 ELSE 0 END) AS Count13,
		SUM(CASE WHEN IsMale = 0 AND Ages > 50 THEN 1 ELSE 0 END) AS Count14
INTO #HT2
FROM #HT1380
GROUP BY TranMonth

--- Dataset 1: Trả ra danh sách nghỉ việc theo từng tháng, phân loại theo giới tính, loại HĐLĐ, độ tuổi, lý do thôi việc
SELECT	#HT1.TranMonth, #HT1.EmployeeTotal,
		Count01, Count02, Count03, Count04, Count05, Count06, Count07, Count08, Count09, Count10, Count11, Count12, Count13, Count14
FROM #HT1
	LEFT JOIN #HT2 ON #HT1.TranMonth = #HT2.TranMonth
ORDER BY #HT1.TranMonth

--- Dataset 2: thống kê theo giới tính, loại HĐLĐ ở từng tháng trong năm
SELECT	IsMale,
		SUM(CASE WHEN TranMonth = 1 AND IsLimitContract = 0 THEN 1 ELSE 0 END) AS Count01,
		SUM(CASE WHEN TranMonth = 1 AND IsLimitContract = 1 THEN 1 ELSE 0 END) AS Count02,
		SUM(CASE WHEN TranMonth = 2 AND IsLimitContract = 0 THEN 1 ELSE 0 END) AS Count03,
		SUM(CASE WHEN TranMonth = 2 AND IsLimitContract = 1 THEN 1 ELSE 0 END) AS Count04,
		SUM(CASE WHEN TranMonth = 3 AND IsLimitContract = 0 THEN 1 ELSE 0 END) AS Count05,
		SUM(CASE WHEN TranMonth = 3 AND IsLimitContract = 1 THEN 1 ELSE 0 END) AS Count06,
		SUM(CASE WHEN TranMonth = 4 AND IsLimitContract = 0 THEN 1 ELSE 0 END) AS Count07,
		SUM(CASE WHEN TranMonth = 4 AND IsLimitContract = 1 THEN 1 ELSE 0 END) AS Count08,
		SUM(CASE WHEN TranMonth = 5 AND IsLimitContract = 0 THEN 1 ELSE 0 END) AS Count09,
		SUM(CASE WHEN TranMonth = 5 AND IsLimitContract = 1 THEN 1 ELSE 0 END) AS Count10,
		SUM(CASE WHEN TranMonth = 6 AND IsLimitContract = 0 THEN 1 ELSE 0 END) AS Count11,
		SUM(CASE WHEN TranMonth = 6 AND IsLimitContract = 1 THEN 1 ELSE 0 END) AS Count12,
		SUM(CASE WHEN TranMonth = 7 AND IsLimitContract = 0 THEN 1 ELSE 0 END) AS Count13,
		SUM(CASE WHEN TranMonth = 7 AND IsLimitContract = 1 THEN 1 ELSE 0 END) AS Count14,
		SUM(CASE WHEN TranMonth = 8 AND IsLimitContract = 0 THEN 1 ELSE 0 END) AS Count15,
		SUM(CASE WHEN TranMonth = 8 AND IsLimitContract = 1 THEN 1 ELSE 0 END) AS Count16,
		SUM(CASE WHEN TranMonth = 9 AND IsLimitContract = 0 THEN 1 ELSE 0 END) AS Count17,
		SUM(CASE WHEN TranMonth = 9 AND IsLimitContract = 1 THEN 1 ELSE 0 END) AS Count18,
		SUM(CASE WHEN TranMonth = 10 AND IsLimitContract = 0 THEN 1 ELSE 0 END) AS Count19,
		SUM(CASE WHEN TranMonth = 10 AND IsLimitContract = 1 THEN 1 ELSE 0 END) AS Count20,
		SUM(CASE WHEN TranMonth = 11 AND IsLimitContract = 0 THEN 1 ELSE 0 END) AS Count21,
		SUM(CASE WHEN TranMonth = 11 AND IsLimitContract = 1 THEN 1 ELSE 0 END) AS Count22,
		SUM(CASE WHEN TranMonth = 12 AND IsLimitContract = 0 THEN 1 ELSE 0 END) AS Count23,
		SUM(CASE WHEN TranMonth = 12 AND IsLimitContract = 1 THEN 1 ELSE 0 END) AS Count24
FROM #HT1380
GROUP BY IsMale

--- Dataset 3: thống kê theo giới tính, độ tuổi ở từng tháng trong năm
SELECT	IsMale,
		SUM(CASE WHEN TranMonth = 1 AND Ages < 30 THEN 1 ELSE 0 END) AS Count01,
		SUM(CASE WHEN TranMonth = 1 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count02,
		SUM(CASE WHEN TranMonth = 1 AND Ages > 50 THEN 1 ELSE 0 END) AS Count03,
		SUM(CASE WHEN TranMonth = 2 AND Ages < 30 THEN 1 ELSE 0 END) AS Count04,
		SUM(CASE WHEN TranMonth = 2 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count05,
		SUM(CASE WHEN TranMonth = 2 AND Ages > 50 THEN 1 ELSE 0 END) AS Count06,
		SUM(CASE WHEN TranMonth = 3 AND Ages < 30 THEN 1 ELSE 0 END) AS Count07,
		SUM(CASE WHEN TranMonth = 3 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count08,
		SUM(CASE WHEN TranMonth = 3 AND Ages > 50 THEN 1 ELSE 0 END) AS Count09,
		SUM(CASE WHEN TranMonth = 4 AND Ages < 30 THEN 1 ELSE 0 END) AS Count10,
		SUM(CASE WHEN TranMonth = 4 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count11,
		SUM(CASE WHEN TranMonth = 4 AND Ages > 50 THEN 1 ELSE 0 END) AS Count12,
		SUM(CASE WHEN TranMonth = 5 AND Ages < 30 THEN 1 ELSE 0 END) AS Count13,
		SUM(CASE WHEN TranMonth = 5 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count14,
		SUM(CASE WHEN TranMonth = 5 AND Ages > 50 THEN 1 ELSE 0 END) AS Count15,
		SUM(CASE WHEN TranMonth = 6 AND Ages < 30 THEN 1 ELSE 0 END) AS Count16,
		SUM(CASE WHEN TranMonth = 6 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count17,
		SUM(CASE WHEN TranMonth = 6 AND Ages > 50 THEN 1 ELSE 0 END) AS Count18,
		SUM(CASE WHEN TranMonth = 7 AND Ages < 30 THEN 1 ELSE 0 END) AS Count19,
		SUM(CASE WHEN TranMonth = 7 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count20,
		SUM(CASE WHEN TranMonth = 7 AND Ages > 50 THEN 1 ELSE 0 END) AS Count21,
		SUM(CASE WHEN TranMonth = 8 AND Ages < 30 THEN 1 ELSE 0 END) AS Count22,
		SUM(CASE WHEN TranMonth = 8 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count23,
		SUM(CASE WHEN TranMonth = 8 AND Ages > 50 THEN 1 ELSE 0 END) AS Count24,
		SUM(CASE WHEN TranMonth = 9 AND Ages < 30 THEN 1 ELSE 0 END) AS Count25,
		SUM(CASE WHEN TranMonth = 9 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count26,
		SUM(CASE WHEN TranMonth = 9 AND Ages > 50 THEN 1 ELSE 0 END) AS Count27,
		SUM(CASE WHEN TranMonth = 10 AND Ages < 30 THEN 1 ELSE 0 END) AS Count28,
		SUM(CASE WHEN TranMonth = 10 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count29,
		SUM(CASE WHEN TranMonth = 10 AND Ages > 50 THEN 1 ELSE 0 END) AS Count30,
		SUM(CASE WHEN TranMonth = 11 AND Ages < 30 THEN 1 ELSE 0 END) AS Count31,
		SUM(CASE WHEN TranMonth = 11 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count32,
		SUM(CASE WHEN TranMonth = 11 AND Ages > 50 THEN 1 ELSE 0 END) AS Count33,
		SUM(CASE WHEN TranMonth = 12 AND Ages < 30 THEN 1 ELSE 0 END) AS Count34,
		SUM(CASE WHEN TranMonth = 12 AND (Ages BETWEEN 30 AND 50) THEN 1 ELSE 0 END) AS Count35,
		SUM(CASE WHEN TranMonth = 12 AND Ages > 50 THEN 1 ELSE 0 END) AS Count36
FROM #HT1380
GROUP BY IsMale


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
