IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2035]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2035]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Chọn ứng viên (lịch PV)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 23/08/2017
-- <Example>
---- 
/*-- <Example>
	HRMP2035 @DivisionID='CH',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25, @RecruitPeriodID = 'aaa', @InterviewLevel = 1, @InterviewRecruitList=NULL,@TxtSearch=NULL

	@DivisionID,@UserID,@PageNumber,@PageSize,@IsSearch, @RecruitPlanID, @DepartmentID, @DutyID,@FromDate,@ToDate, @Status
----*/

CREATE PROCEDURE HRMP2035
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @RecruitPeriodID VARCHAR(50),
	 @InterviewLevel INT,
	 @InterviewRecruitList XML,
	 @TxtSearch NVARCHAR(250)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @TotalRow NVARCHAR(50)=N''

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @InterviewRecruitList IS NOT NULL
BEGIN
	CREATE TABLE #InterviewRecruitList (CandidateID VARCHAR(50))
	INSERT INTO #InterviewRecruitList (CandidateID)
	SELECT X.Data.query('CandidateID').value('.', 'NVARCHAR(50)') AS CandidateID
	FROM	@InterviewRecruitList.nodes('//Data') AS X (Data)
	ORDER BY CandidateID
END

IF @InterviewLevel <> 1
BEGIN
	SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY HRMT2040.CandidateID) AS RowNum, '+@TotalRow+' AS TotalRow, HRMT2041.DivisionID, HRMT2040.CandidateID,
LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) AS CandidateName
FROM HRMT2041 WITH (NOLOCK)
INNER JOIN HRMT2040 WITH (NOLOCK) ON HRMT2041.DivisionID = HRMT2040.DivisionID AND HRMT2041.APKMaster = CONVERT(VARCHAR(50),HRMT2040.APK)
LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT2041.DivisionID = HRMT1030.DivisionID AND HRMT2040.CandidateID = HRMT1030.CandidateID
WHERE HRMT2041.DivisionID = '''+@DivisionID+'''
AND HRMT2040.RecruitPeriodID = '''+ISNULL(@RecruitPeriodID,'')+'''
AND HRMT2041.InterviewLevel = '+STR(@InterviewLevel-1)+' 
AND HRMT2041.InterviewStatus = 1
AND (ISNULL(HRMT2040.CandidateID,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%'' 
	OR LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) LIKE ''%'+ISNULL(@TxtSearch,'')+'%''
	) 
'+ CASE WHEN @InterviewRecruitList IS NOT NULL THEN 'AND NOT EXISTS (SELECT TOP 1 1 FROM #InterviewRecruitList T1 WHERE HRMT2040.CandidateID = T1.CandidateID)' ELSE '' END+'
ORDER BY HRMT2040.CandidateID

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'
END
ELSE IF @InterviewLevel = 1
BEGIN 
	SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY HRMT1030.CandidateID) AS RowNum, '+@TotalRow+' AS TotalRow, HRMT1030.DivisionID, HRMT1030.CandidateID,
LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.LastName,''''))),''  '','' ''))) AS CandidateName
FROM HRMT1030 WITH (NOLOCK)
INNER JOIN HRMT1031 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT1030.DivisionID AND HRMT1031.CandidateID = HRMT1030.CandidateID
WHERE HRMT1030.DivisionID = '''+@DivisionID+'''
AND HRMT1031.RecPeriodID = '''+@RecruitPeriodID+'''
AND HRMT1031.RecruitStatus = 1 
AND (ISNULL(HRMT1030.CandidateID,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%'' 
	OR LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) LIKE ''%'+ISNULL(@TxtSearch,'')+'%''
	) 
AND HRMT1030.CandidateID NOT IN (SELECT CandidateID FROM HRMT2031 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND CandidateID = HRMT1030.CandidateID)
'+ CASE WHEN @InterviewRecruitList IS NOT NULL THEN 'AND NOT EXISTS (SELECT TOP 1 1 FROM #InterviewRecruitList T1 WHERE HRMT1030.CandidateID = T1.CandidateID)' ELSE '' END+'
ORDER BY HRMT1030.CandidateID

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'
END



--PRINT(@sSQL)
EXEC (@sSQL)

IF @InterviewRecruitList IS NOT NULL
DROP TABLE #InterviewRecruitList

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
