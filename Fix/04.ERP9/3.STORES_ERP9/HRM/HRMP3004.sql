IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo thống kê hồ sơ tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 02/10/2017
-- <Example>
---- 
/*-- <Example>
	EXEC [HRMP3004] @DivisionID= 'CH', @DivisionList ='',
	@FromRecruitPeriod = 'Period1', @ToRecruitPeriod = 'Period2', @DepartmentList = NULL, @FromDate='2017-01-01', @ToDate='2017-12-01'
	
----*/
CREATE PROCEDURE HRMP3004
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @FromRecruitPeriod VARCHAR(50),
	 @ToRecruitPeriod VARCHAR(50),
	 @DepartmentList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME
)
AS 



SELECT (CASE WHEN DATEDIFF(YEAR, Birthday, GETDATE()) < 25 THEN 'Age_25'
WHEN 25 < DATEDIFF(YEAR, Birthday, GETDATE()) AND DATEDIFF(YEAR, Birthday, GETDATE()) <= 30 THEN 'Age_25_30' 
WHEN 30 <= DATEDIFF(YEAR, Birthday, GETDATE()) AND DATEDIFF(YEAR, Birthday, GETDATE()) <= 40 THEN 'Age_30_40'
WHEN 40 <= DATEDIFF(YEAR, Birthday, GETDATE()) AND DATEDIFF(YEAR, Birthday, GETDATE()) <= 50 THEN 'Age_40_50'
WHEN DATEDIFF(YEAR, Birthday, GETDATE()) > 50 THEN 'Age_50'
END
) AS Age, HRMT1031.DepartmentID, Birthday
INTO #Temp_Age
FROM HRMT1030 WITH (NOLOCK)
LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1031.DivisionID AND HRMT1030.CandidateID = HRMT1031.CandidateID
WHERE HRMT1030.DivisionID = @DivisionID



DECLARE @sSQL1 NVARCHAR (MAX)=N'',
		@sSQL2 NVARCHAR (MAX)=N'',
		@sSQL3 NVARCHAR(MAX) =N'',
		@sSQL4 NVARCHAR(MAX) =N'',
		@Orderby NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N''

SET @Orderby = 'HRMT2020.RecruitPeriodID'
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT1031.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT1031.DivisionID = '''+@DivisionID+''' '

BEGIN



IF ISNULL(@DepartmentList,'') <> '' SET @sWhere = @sWhere + 'AND HRMT1031.DepartmentID IN ('''+@DepartmentList+''')'
IF (@FromRecruitPeriod IS NOT NULL AND @ToRecruitPeriod IS NULL) SET @sWhere = @sWhere + '
AND HRMT2020.RecruitPeriodID  >= '''+@FromRecruitPeriod+''' '
IF (@FromRecruitPeriod IS NULL AND @ToRecruitPeriod IS NOT NULL) SET @sWhere = @sWhere + '
AND HRMT2020.RecruitPeriodID <= '''+@ToRecruitPeriod+''' '
IF (@FromRecruitPeriod IS NOT NULL AND @ToRecruitPeriod IS NOT NULL) SET @sWhere = @sWhere + '
AND HRMT2020.RecruitPeriodID BETWEEN '''+@FromRecruitPeriod+''' AND '''+@ToRecruitPeriod+''' '	
IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2020.PeriodFromDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2020.PeriodToDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2020.PeriodFromDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' 
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2020.PeriodToDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '	
END


SET @sSQL1 = @sSQL1 + '
SELECT * 
INTO #Temp_Count_Gender
FROM (SELECT HRMT1031.DepartmentID, HT0099.DescriptionE, COUNT(DescriptionE) AS Count_Gender
FROM HRMT1030 WITH (NOLOCK) LEFT JOIN HT0099 WITH (NOLOCK) ON HRMT1030.RecruitStatus = HT0099.ID AND HT0099.CodeMaster = ''Gender''
INNER JOIN HRMT1031 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1031.DivisionID AND HRMT1030.CandidateID = HRMT1031.CandidateID
WHERE HRMT1030.DivisionID = '''+@DivisionID+'''
GROUP BY HRMT1031.DepartmentID, HT0099.DescriptionE) AS P
PIVOT 
(SUM(Count_Gender) FOR DescriptionE IN ([Male], [Female]))
AS PIVOTABLE
'

SET @sSQL2 = @sSQL2 + '
SELECT * 
INTO #Temp_Count_EducationLevel
FROM (SELECT HT1005.EducationLevelID, DepartmentID, COUNT(HT1005.EducationLevelID) AS Count_EducationLevel
FROM HT1005 WITH (NOLOCK)
INNER JOIN HRMT1032 ON HT1005.DivisionID = HRMT1032.DivisionID AND HT1005.EducationLevelID = HRMT1032.EducationLevelID
INNER JOIN HRMT1031 ON HRMT1032.DivisionID = HRMT1031.DivisionID AND HRMT1032.CandidateID = HRMT1031.CandidateID
WHERE HT1005.DivisIonID = '''+@DivisionID+'''
GROUP BY HT1005.EducationLevelID, DepartmentID
) AS P
PIVOT 
(SUM(Count_EducationLevel) FOR EducationLevelID IN ([SCN], [TC], [TCN], [THCS], [THPT], [ThS], [TS], [DH], [CD]))
AS PIVOTABLE
'

SET @sSQL3 = @sSQL3 + '
SELECT * 
INTO #Temp_Count_Age
FROM (SELECT *  FROM #Temp_Age) AS P
PIVOT 
(COUNT(Birthday) FOR Age IN ([Age_25], [Age_25_30], [Age_30_40], [Age_40_50], [Age_50]))
AS PIVOTABLE
'


SET @sSQL4 = 'SELECT DISTINCT HRMT2020.RecruitPeriodID, HRMT2020.RecruitPeriodName, AT1102.DepartmentName, 
Temp1.InformaticsLevel, Temp.Count_Cadidate, Temp3.Language, Temp4.*
FROM HRMT1031 WITH (NOLOCK)
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT2020.DivisionID AND HRMT1031.RecPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT1031.DepartmentID = AT1102.DepartmentID AND AT1102.DivisionID IN ('''+@DivisionID+''', ''@@@'')
LEFT JOIN HRMT1032 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT1032.DivisionID AND HRMT1031.CandidateID = HRMT1032.CandidateID
LEFT JOIN 
(
	SELECT  COUNT (CandidateID) AS Count_Cadidate, DepartmentID, DivisionID 
	FROM HRMT1031 WITH (NOLOCK) 
	GROUP BY DepartmentID, DivisionID
) AS Temp ON HRMT1031.DivisionID = Temp.DivisionID AND HRMT1031.DepartmentID = Temp.DepartmentID 
LEFT JOIN 
(
	SELECT COUNT(HRMT1032.InformaticsLevel) AS InformaticsLevel, HRMT1032.DivisionID, HRMT1031.DepartmentID 
	FROM HRMT1032 WITH (NOLOCK)
	LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT1032.DivisionID AND HRMT1031.CandidateID = HRMT1032.CandidateID
	GROUP BY HRMT1032.DivisionID, HRMT1031.DepartmentID
) AS Temp1 ON HRMT1031.DivisionID = Temp1.DivisionID AND HRMT1031.DepartmentID = Temp1.DepartmentID 
LEFT JOIN 
(
	SELECT SUM(Language1 + Language2 + Language3 ) AS Language, DivisionID, DepartmentID
	FROM 
	(
		SELECT CONVERT(INT, COUNT(Language1ID)) AS Language1, CONVERT(INT, COUNT(Language2ID)) AS Language2, 
		CONVERT(INT, COUNT(Language3ID)) AS Language3, HRMT1032.DivisionID, HRMT1031.DepartmentID
		FROM HRMT1032 WITH (NOLOCK)
		LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1032.DivisionID = HRMT1031.DivisionID AND HRMT1032.CandidateID = HRMT1031.CandidateID 
		GROUP BY HRMT1032.DivisionID, HRMT1031.DepartmentID
	) AS Temp2
	GROUP BY DivisionID, DepartmentID
) AS Temp3 ON HRMT1031.DivisionID = Temp3.DivisionID AND HRMT1031.DepartmentID = Temp3.DepartmentID
LEFT JOIN 
(
	SELECT T1.DepartmentID, Male, Female, SCN, TC, TCN, THCS, THPT, ThS, TS, DH, CD, Age_25, Age_25_30, Age_30_40, Age_40_50, Age_50
	FROM #Temp_Count_Gender T1
	LEFT JOIN #Temp_Count_EducationLevel T2 ON T1.DepartmentID = T2.DepartmentID
	LEFT JOIN #Temp_Count_Age T3 ON T1.DepartmentID = T3.DepartmentID
) AS Temp4 ON HRMT1031.DepartmentID = Temp4.DepartmentID 
WHERE '+@sWhere+'
ORDER BY '+@OrderBy+'
'



--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
--PRINT @sSQL4

EXEC (@sSQL1+@sSQL2+@sSQL3+@sSQL4)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
