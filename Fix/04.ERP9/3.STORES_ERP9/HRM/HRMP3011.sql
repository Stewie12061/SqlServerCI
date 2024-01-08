IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo kết quả phỏng vấn 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 12/12/2017
-- <Example>
---- 
/*-- <Example>
	EXEC HRMP3011 @DivisionID = 'AS',
	@DepartmentID = '', @RecruitPeriodID = '', @DutyID = '', @CandidateID = '', @InterviewLevel = '2'
	
	EXEC HRMP3011 @DivisionID, @DepartmentID, @RecruitPeriodID, @DutyID, @CandidateID, @InterviewLevel
----*/
CREATE PROCEDURE HRMP3011
( 
	 @DivisionID VARCHAR(50),
	 @DepartmentID NVARCHAR(50),
	 @RecruitPeriodID NVARCHAR(50),
	 @DutyID NVARCHAR(50),
	 @CandidateID NVARCHAR(50),
	 @InterviewLevel VARCHAR(1)
	
)
AS 


DECLARE @sSQL NVARCHAR (MAX)=N'',
		@sWhere NVARCHAR(MAX) = N'',
		@sOrderBy NVARCHAR(MAX) = N''

SET @sWhere = @sWhere + ' HRMT2040.DivisionID = '''+@DivisionID+''''
SET @sOrderBy = @sOrderBy + ' HRMT2041.InterviewLevel, HRMT1010.InterviewTypeID'
BEGIN
IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
AND HRMT1031.DepartmentID = '''+@DepartmentID+''''
IF ISNULL(@RecruitPeriodID,'') <> '' SET @sWhere = @sWhere + '
AND HRMT2040.RecruitPeriodID = '''+@RecruitPeriodID+''''
IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
AND HRMT1010.DutyID = '''+@DutyID+''''
IF ISNULL(@CandidateID,'') <> '' SET @sWhere = @sWhere + '
AND  HRMT2040.CandidateID = '''+@CandidateID+''''
IF ISNULL(@InterviewLevel,'') <> '' SET @sWhere = @sWhere + '
AND  HRMT2041.InterviewLevel = '''+@InterviewLevel+''''
END

SET @sSQL = N'
SELECT HRMT2040.DivisionID, HRMT2041.InterviewLevel, CASE
 WHEN HRMT2041.InterviewLevel = 1 THEN N''Vòng 1''
 WHEN HRMT2041.InterviewLevel = 2 THEN N''Vòng 2''
 WHEN HRMT2041.InterviewLevel = 3 THEN N''Vòng 3''
 WHEN HRMT2041.InterviewLevel = 4 THEN N''Vòng 4''
 WHEN HRMT2041.InterviewLevel = 5 THEN N''Vòng 5'' END AS InterviewLevelName, '''' AS InterviewerID, '''' AS InterviewerName,
 HRMT2040.CandidateID, CASE 
 WHEN ISNULL(HRMT1030.MiddleName,'''') = '''' THEN LTRIM(RTRIM(ISNULL(HRMT1030.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))) 
 WHEN ISNULL(HRMT1030.MiddleName,'''') <> '''' THEN LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' +  
 LTRIM(RTRIM(ISNULL(HRMT1030.LastName,''''))) END AS CandidateName, HT09.[Description] AS Gender, HRMT1030.Birthday, HRMT1030.BornPlace, HRMT1010.DutyID, 
 HT1102.DutyName, HRMT1031.DepartmentID, AT1102.DepartmentName, HRMT1010.InterviewTypeID, HRMT1010.InterviewTypeName, HRMT2042.DetailTypeID, 
 HRMT1011.[Description] AS DetailTypeName, HRMT2042.InterviewResult, CASE 
 WHEN HRMT1011.ResultFormat = 0 OR HRMT1011.ResultFormat = 1 THEN HRMT2042.InterviewResult
 WHEN HRMT1011.ResultFormat = 2 THEN HT091.[Description] END AS InterviewResultName
FROM HRMT2040 WITH (NOLOCK)
INNER JOIN HRMT2041 WITH (NOLOCK) ON HRMT2040.APK = HRMT2041.APKMaster
INNER JOIN HRMT2042 WITH (NOLOCK) ON HRMT2041.APK = HRMT2042.ReAPK 
INNER JOIN HRMT1010 WITH (NOLOCK) ON HRMT2042.DivisionID = HRMT1010.DivisionID AND HRMT2042.InterviewTypeID = HRMT1010.InterviewTypeID
INNER JOIN HRMT1011 WITH (NOLOCK) ON HRMT1010.DivisionID = HRMT1011.DivisionID AND HRMT1010.InterviewTypeID = HRMT1011.InterviewTypeID AND HRMT2042.DetailTypeID = HRMT1011.DetailTypeID
INNER JOIN HRMT1030 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT1030.DivisionID AND HRMT2040.CandidateID = HRMT1030.CandidateID
INNER JOIN HRMT1031 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT1031.DivisionID AND HRMT2040.CandidateID = HRMT1031.CandidateID
INNER JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND HRMT1031.DepartmentID = AT1102.DepartmentID
--LEFT JOIN HRMT2022 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT2022.DivisionID AND HRMT2040.RecruitPeriodID = HRMT2022.RecruitPeriodID AND HRMT2041.InterviewLevel = HRMT2022.InterviewLevel
LEFT JOIN HT0099 HT09 WITH (NOLOCK) ON HRMT1030.Gender = HT09.ID AND HT09.CodeMaster = ''Gender''
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT1010.DivisionID = HT1102.DivisionID AND HRMT1010.DutyID = HT1102.DutyID
LEFT JOIN HT0099 HT091 WITH (NOLOCK) ON HRMT2042.InterviewResult = HT091.ID AND HT091.CodeMaster = ''Rate''
WHERE '+@sWhere+'
ORDER BY '+@sOrderBy+'
'

--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
