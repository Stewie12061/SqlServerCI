IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo theo dõi tuyển dụng (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 04/10/2017
----Modified by Trọng Kiên on 27/10/2020: Fix lỗi bảng #Temp khi chạy fix
----
-- <Example>
---- 
/*-- <Example>
	EXEC [HRMP3010] @DivisionID = 'CH', @DivisionList = 'CH', @FromRecruitPeriod = 'Period1', @ToRecruitPeriod = 'Period5',
	 @FromDate='2017-01-01', @ToDate='2017-12-01', @DepartmentList = 'PSX', @DutyList = 'NV', @Status = NULL
	
----*/
CREATE PROCEDURE HRMP3010
( 
	 
	 @DivisionID VARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @FromRecruitPeriod VARCHAR(50),
	 @ToRecruitPeriod VARCHAR(50),
	 @DepartmentList NVARCHAR(MAX),
	 @DutyList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @Status NVARCHAR(50)
)
AS 

SELECT DISTINCT HRMT2040.CandidateID, HRMT2040.RecruitPeriodID, 
CONVERT(NVARCHAR(50),HRMT2041.InterviewLevel) AS InterviewLevel , 
CASE WHEN CONVERT(NVARCHAR(50),HRMT2041.InterviewStatus) = 0 THEN N'Không đạt'
WHEN CONVERT(NVARCHAR(50),HRMT2041.InterviewStatus) = 1 THEN N'Đạt' ELSE '' END AS InterviewStatus
INTO #TempHRMP3010_1
FROM HRMT2040 WITH (NOLOCK)
INNER JOIN HRMT2041 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT2041.DivisionID AND HRMT2040.APK = HRMT2041.APKMaster
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT2020.DivisionID AND HRMT2040.RecruitPeriodID = HRMT2020.RecruitPeriodID 
LEFT JOIN 
(
	SELECT HRMT1031.DivisionID, HRMT1031.CandidateID, HT0099.Description AS [Status] FROM HRMT1031 LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1031.RecruitStatus AND HT0099.CodeMaster = 'RecruitStatus'
	WHERE HRMT1031.DivisionID = @DivisionID
) AS Temp ON HRMT2040.DivisionID = Temp.DivisionID AND HRMT2040.CandidateID = Temp.CandidateID
WHERE HRMT2040.DivisionID IN (@DivisionList)
AND HRMT2040.RecruitPeriodID BETWEEN @FromRecruitPeriod AND @ToRecruitPeriod
AND HRMT2020.DepartmentID IN (@DepartmentList)
AND HRMT2020.DutyID IN (@DutyList)
AND HRMT2020.PeriodFromDate BETWEEN @FromDate AND @ToDate
AND HRMT2020.PeriodToDate BETWEEN @FromDate AND @ToDate
AND Temp.[Status] LIKE ISNULL(@Status,'%')
ORDER BY HRMT2040.CandidateID

SELECT DISTINCT N'Vòng'+' '+CONVERT(NVARCHAR(50),InterviewLevel) AS InterviewLevel
INTO #TempHRMP3010_2
FROM #TempHRMP3010_1 


DECLARE @sSQL1 NVARCHAR (MAX)=N'',
		@sSQL2 NVARCHAR (MAX)=N'',
		@sSQL3 NVARCHAR(MAX)=N'',
		@sSQL4 NVARCHAR(MAX)=N'',
		@sSQL5 NVARCHAR(MAX)=N'',
		@InterviewStatus NVARCHAR(MAX)=N''

SET @sSQL1 = @sSQL1 + '
SELECT * 
INTO #InterviewLevel
FROM (SELECT CandidateID, N''Vòng''+'' ''+CONVERT(NVARCHAR(50),InterviewLevel) AS InterviewLevel, InterviewStatus FROM #TempHRMP3010_1) AS P
PIVOT 
(MAX(InterviewStatus) FOR InterviewLevel IN ('
SELECT @sSQL2 = @sSQL2 + CASE WHEN @sSQL2 <> '' THEN ',' ELSE '' END + '['+''+InterviewLevel+''+']'
FROM #TempHRMP3010_2 
SET @InterviewStatus = @sSQL2
SELECT @sSQL2 = @sSQL2 +
'
)) AS PIVOTTABLE
'



SET @sSQL3 = @sSQL3 + '
SELECT DISTINCT HRMT2040.DivisionID, HRMT2040.RecruitPeriodID, HRMT2020.RecruitPeriodName, HRMT2020.DepartmentID, AT1102.DepartmentName,(CASE 
WHEN ISNULL(HRMT1030.MiddleName,'''') = '''' THEN LTRIM(RTRIM(ISNULL(HRMT1030.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))) 
WHEN ISNULL(HRMT1030.MiddleName,'''') <> '''' THEN LTRIM(RTRIM(ISNULL(HRMT1030.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' +  LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))) 
END) AS CandidateName, YEAR(HRMT1030.Birthday) AS Birthday, HT0099.Description AS Gender, HRMT1030.PhoneNumber, HRMT1031.DutyID, HT1102.DutyName,
HRMT1032.EducationLevelID, HT1005.EducationLevelName, Temp_1.Language1ID, Temp_1.LanguageName1, Temp_2.Language2ID, Temp_2.LanguageName2, 
Temp_3.Language3ID, Temp_3.LanguageName3, HRMT1032.InformaticsLevel, HRMT1034.EducationCenter, HRMT1034.EducationMajor, Temp_4.*, Temp.[Status]
FROM HRMT2040 WITH (NOLOCK)
LEFT JOIN HRMT2041 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT2041.DivisionID AND HRMT2040.APK = HRMT2041.APKMaster  
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT2020.DivisionID AND HRMT2040.RecruitPeriodID = HRMT2020.RecruitPeriodID  
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID AND AT1102.DivisionID IN ('''+@DivisionID+''', ''@@@'') 
LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT1031.DivisionID AND HRMT2040.RecruitPeriodID = HRMT1031.RecPeriodID 
LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT1030.DivisionID AND HRMT2040.CandidateID = HRMT1030.CandidateID 
LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1030.RecruitStatus AND HT0099.CodeMaster = ''Gender''
LEFT JOIN 
(
	SELECT HRMT1031.DivisionID, HRMT1031.CandidateID, HT0099.Description AS [Status] FROM HRMT1031 LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1031.RecruitStatus AND HT0099.CodeMaster = ''RecruitStatus''
	WHERE HRMT1031.DivisionID = '''+@DivisionID+'''
) AS Temp ON HRMT2040.DivisionID = Temp.DivisionID AND HRMT2040.CandidateID = Temp.CandidateID 
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT1031.DivisionID = HT1102.DivisionID  AND HRMT1031.DutyID = HT1102.DutyID 
LEFT JOIN HRMT1032 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT1032.DivisionID AND HRMT2040.CandidateID = HRMT1032.CandidateID 
LEFT JOIN HT1005 WITH (NOLOCK) ON HRMT1032.DivisionID = HT1005.DivisionID AND HRMT1032.EducationLevelID = HT1005.EducationLevelID
LEFT JOIN HRMT1034 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT1034.DivisionID AND HRMT2040.CandidateID = HRMT1034.CandidateID
LEFT JOIN 
(
	SELECT DISTINCT HRMT1032.DivisionID, HRMT1032.Language1ID, ISNULL(HT1006.LanguageName+ '':'' + '' '' + HRMT1032.LanguageLevel1ID,'''') AS LanguageName1, 
	HRMT1032.CandidateID
	FROM HRMT1032 WITH (NOLOCK) 
	INNER JOIN HT1006 WITH (NOLOCK) ON HRMT1032.DivisionID = HT1006.DivisionID AND HRMT1032.Language1ID = HT1006.LanguageID
	WHERE HRMT1032.DivisionID = '''+@DivisionID+'''
) AS Temp_1 ON HRMT2040.DivisionID = Temp_1.DivisionID AND HRMT2040.CandidateID = Temp_1.CandidateID 
LEFT JOIN 
(
	SELECT DISTINCT HRMT1032.DivisionID, HRMT1032.Language2ID, ISNULL(HT1006.LanguageName+ '':'' + '' '' + HRMT1032.LanguageLevel2ID,'''') AS LanguageName2,
	HRMT1032.CandidateID
	FROM HRMT1032 WITH (NOLOCK) 
	INNER JOIN HT1006 WITH (NOLOCK) ON HRMT1032.DivisionID = HT1006.DivisionID AND HRMT1032.Language2ID = HT1006.LanguageID
	WHERE HRMT1032.DivisionID = '''+@DivisionID+'''
) AS Temp_2 ON HRMT2040.DivisionID = Temp_2.DivisionID AND HRMT2040.CandidateID = Temp_2.CandidateID 
LEFT JOIN
(
	SELECT DISTINCT HRMT1032.DivisionID, HRMT1032.Language3ID, ISNULL(HT1006.LanguageName+ '':'' + '' '' + HRMT1032.LanguageLevel3ID,'''') AS LanguageName3,
	HRMT1032.CandidateID
	FROM HRMT1032 WITH (NOLOCK) 
	INNER JOIN HT1006 WITH (NOLOCK) ON HRMT1032.DivisionID = HT1006.DivisionID AND HRMT1032.Language3ID = HT1006.LanguageID
	WHERE HRMT1032.DivisionID = '''+@DivisionID+'''
) AS Temp_3 ON HRMT2040.DivisionID = Temp_2.DivisionID AND HRMT2040.CandidateID = Temp_3.CandidateID 
LEFT JOIN (
	SELECT CandidateID '+CASE WHEN ISNULL(@InterviewStatus,'') <> '' THEN ',' +@InterviewStatus ELSE '' END +'
	FROM #InterviewLevel
) AS Temp_4 ON HRMT2040.CandidateID = Temp_4.CandidateID
WHERE  HRMT2040.DivisionID = '''+@DivisionID+'''
ORDER BY Temp_4.CandidateID
'




--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
--PRINT @sSQL4

IF ISNULL(@InterviewStatus,'') <>'' 
EXEC (@sSQL1+@sSQL2+@sSQL3+@sSQL4)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
