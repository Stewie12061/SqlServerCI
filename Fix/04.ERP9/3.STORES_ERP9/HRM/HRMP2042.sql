IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2042]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2042]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In kết quả phỏng vấn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy on 22/08/2017
-- <Example>
---- 
/*-- <Example>
	HRMP2042 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@InterviewScheduleID=NULL,@DutyID='LD',@Disabled=0

	EXEC HRMP2042 @DivisionID='CH',@DivisionList='CH'',''CH1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1, 
	@CandidateID = 'aaa', @DepartmentID = NULL, @DutyID = NULL, @RecruitPeriodID=NULL, @FromDate = '2017-08-01', 
	@ToDate = '2017-08-05', @RecruitStatus = NULL, @IsCheckAll = 0, @InterviewFileList = NULL

	 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @IsSearch, @CandidateID, @RecruitPeriodID, @DepartmentID, @DutyID, @FromDate, @ToDate, @RecruitStatus
----*/

CREATE PROCEDURE HRMP2042
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @CandidateID VARCHAR(50),
	 @RecruitPeriodID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @RecruitStatus VARCHAR(1),
	 @IsCheckAll TINYINT,
	 @InterviewFileList XML
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

SET @OrderBy = 'HRMT2040.RecruitPeriodID, HRMT2040.CandidateID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT2040.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT2040.DivisionID = '''+@DivisionID+''' '

IF  @IsSearch = 1
BEGIN
	
	IF ISNULL(@RecruitPeriodID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2040.RecruitPeriodID LIKE ''%'+@RecruitPeriodID+'%'' '
	IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2040.DepartmentID LIKE ''%'+@DepartmentID+'%'' '
	IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2040.DutyID LIKE ''%'+@DutyID+'%'' '
	IF ISNULL(@CandidateID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2040.CandidateID LIKE ''%'+@CandidateID+'%'' '
	IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2040.StartDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
	IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2040.StartDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
	IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2040.StartDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '	

END

IF ISNULL(@IsCheckAll,0) = 0
BEGIN
	CREATE TABLE #InterviewFileID (APK VARCHAR(50), DivisionID VARCHAR(50))
	INSERT INTO #InterviewFileID (APK, DivisionID)
	SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK,
		   X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID
	FROM	@InterviewFileList.nodes('//Data') AS X (Data)

	SET @sJoin = @sJoin + N'
	INNER JOIN #InterviewFileID T1 ON HRMT2040.DivisionID = T1.DivisionID AND HRMT2040.APK = T1.APK'
END

SET @sSQL = N'
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
	HRMT2040.APK, HRMT2040.DivisionID, HRMT2040.RecruitPeriodID, HRMT2020.DepartmentID, AT1102.DepartmentName,
	HRMT2020.DutyID, HT1102.DutyName, HRMT2040.CandidateID,
	LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,N'''')))+ N'' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,N''''))) + N'' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,N''''))),N''  '',N'' ''))) AS CandidateName,
	HRMT2040.RequireSalary, HRMT2040.Startdate,
	CASE WHEN #HRMT2041.InterviewStatus = 1 THEN N''Đạt''
	WHEN #HRMT2041.InterviewStatus = 0 THEN N''Không đạt'' ELSE N'''' END AS InterviewStatus
FROM HRMT2040 WITH (NOLOCK)
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT2020.DivisionID AND HRMT2040.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN (SELECT TOP 1 APKMaster, InterviewStatus FROM HRMT2041 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''') AS #HRMT2041
ON HRMT2040.APK = #HRMT2041.APKMaster
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT1030.DivisionID AND HRMT2040.CandidateID = HRMT1030.CandidateID
'+@sJoin+'
WHERE '+@sWhere +'
ORDER BY '+@OrderBy+'

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
