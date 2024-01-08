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
----Updated by: Võ Dương on 29/09/2023: Cập nhật phiếu in màn hình HRMF2040
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
	 @APKList VARCHAR(MAX),
	 @PeriodList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsPeriod TINYINT,
	 @IsSearch TINYINT,
	 @CandidateID VARCHAR(50),
	 @RecruitPeriodID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @RecruitStatus VARCHAR(1),
	 @IsCheckAll TINYINT
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

SET @OrderBy = 'HRMT2040.CandidateID, HRMT2040.RecruitPeriodID '
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT2040.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT2040.DivisionID = '''+@DivisionID+''' '

IF  Isnull(@IsSearch,'') = 1
BEGIN	
	IF ISNULL(@RecruitPeriodID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2040.RecruitPeriodID LIKE ''%'+@RecruitPeriodID+'%'' '
	IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DepartmentID LIKE ''%'+@DepartmentID+'%'' '
	IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DutyID LIKE ''%'+@DutyID+'%'' '
	IF ISNULL(@CandidateID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2040.CandidateID LIKE ''%'+@CandidateID+'%'' '
	IF ISNULL(@RecruitStatus,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT1031.RecruitStatus LIKE ''%'+@RecruitStatus+'%'' '
	IF @IsCheckAll  = 1
	BEGIN
	SET @sWhere = @sWhere + '
	AND HRMT2040.APK IN ('''+@APKList+''') '
	END
		--Lọc theo ngày
	IF (@IsPeriod = 0)
	BEGIN
		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) 
		BEGIN
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2040.TrialFromDate,120), 120) >= '''+CONVERT(VARCHAR(10),@FromDate,120)+''' '
		END
		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) 
		BEGIN
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2040.TrialToDate,120), 120) <= '''+CONVERT(VARCHAR(10),@ToDate,120)+''' '
		END
		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL)
		BEGIN
		SET @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2040.TrialFromDate,120), 120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''' 
		AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2040.TrialToDate,120), 120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''' '
		END
	END
	-- Lọc theo kỳ
	ELSE
	BEGIN
		IF @PeriodList IS NOT NULL AND @PeriodList != ''
			SET @sWhere = @sWhere + ' AND (SELECT FORMAT(ISNULL(HRMT2040.TrialFromDate,HRMT2040.TrialToDate), ''MM/yyyy'')) IN (''' + @PeriodList + ''') '
	END	
END


SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum,
  '+@TotalRow+' AS TotalRow,
  HRMT2040.APK,
  (HRMT2040.DivisionID + '' - '' + AT1101.DivisionName) AS DivisionName,
  (HRMT2040.RecruitPeriodID + '' - '' + HRMT2020.RecruitPeriodName) AS RecruitPeriodName,
  (HRMT2020.DepartmentID + '' - '' + AT1102.DepartmentName) AS DepartmentName,
  HRMT2020.DutyID,
  HT1102.DutyName,
  HRMT2040.CandidateID,
  LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName, N'''')))+ N'' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName, N''''))) + N'' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName, N''''))), N''  '', N'' ''))) AS CandidateName,
  HRMT2040.RequireSalary,
  HRMT2040.DealSalary,
  HRMT2040.Startdate,
  HRMT2040.TrialTime,
  HRMT2040.TrialFromDate,
  HRMT2040.TrialToDate,
  HRMT2041.InterviewLevel,
  HRMT2041.InterviewStatus,
  HRMT2041.InterviewAddress,
  HRMT2041.InterviewDate,
  HRMT2041.Comment
FROM HRMT2040 WITH (NOLOCK)
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT2020.DivisionID AND HRMT2040.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN HRMT2041 WITH (NOLOCK) ON HRMT2040.APK = HRMT2041.APKMaster
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT1030.DivisionID AND HRMT2040.CandidateID = HRMT1030.CandidateID
JOIN AT1101 ON HRMT2040.DivisionID = AT1101.DivisionID
LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT1031.DivisionID AND HRMT2040.CandidateID = HRMT1031.CandidateID
LEFT JOIN HT0099 WITH (NOLOCK) ON HRMT1031.RecruitStatus = HT0099.ID AND  HT0099.CodeMaster = ''RecruitStatus''
WHERE '+@sWhere+'
ORDER BY '+@OrderBy+',HRMT2041.InterviewLevel'

--PRINT(@sSQL)
EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
