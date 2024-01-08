IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2052]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRMF2040: Kết quả phỏng vấn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy on 28/08/2017
---<Example>
---- 
/*-- <Example>
	HRMP2052 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@InterviewScheduleID=NULL,@DutyID='LD',@Disabled=0

	EXEC HRMP2052 @DivisionID='CH',@DivisionList='CH'',''CH1',@UserID='ASOFTADMIN',@IsSearch=1, @RecDecisionNo = 'abc',
	@CandidateID = 'aaa', @DepartmentID = 'SOF', @DutyID = 'BA', @RecruitPeriodID='bbb', @FromDate = '2017-08-01', 
	@ToDate = NULL, @Status = 0, @Ischeckall = 1, @RecDecisionList = NULL
----*/

CREATE PROCEDURE HRMP2052
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @IsSearch TINYINT,
	 @RecDecisionNo VARCHAR(50),
	 @CandidateID VARCHAR(50),
	 @RecruitPeriodID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @Status VARCHAR(1),
	 @IsCheckAll TINYINT,
	 @RecDecisionList XML
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

SET @OrderBy = 'HRMT2050.RecDecisionID, HRMT2051.RecruitPeriodID, HRMT2051.CandidateID'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT2050.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT2050.DivisionID = '''+@DivisionID+''' '

IF  @IsSearch = 1
BEGIN
	
	IF ISNULL(@RecDecisionNo,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2050.RecDecisionNo LIKE ''%'+@RecDecisionNo+'%'' '
	IF ISNULL(@CandidateID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2051.CandidateID LIKE ''%'+@CandidateID+'%'' '
	IF ISNULL(@RecruitPeriodID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2051.RecruitPeriodID LIKE ''%'+@RecruitPeriodID+'%'' '
	IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DepartmentID LIKE ''%'+@DepartmentID+'%'' '
	IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DutyID LIKE ''%'+@DutyID+'%'' '
	IF ISNULL(@Status,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2051.Status LIKE ''%'+@Status+'%'' '
	IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2050.DecisionDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
	IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2050.DecisionDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
	IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2050.DecisionDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '	

END
IF ISNULL(@IsCheckAll,0) = 0
BEGIN
	CREATE TABLE #RecDecisionID (DivisionID VARCHAR(50), RecDecisionID VARCHAR(50))
	INSERT INTO #RecDecisionID (DivisionID, RecDecisionID)
	SELECT X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		   X.Data.query('RecDecisionID').value('.', 'NVARCHAR(50)') AS RecDecisionID
	FROM	@RecDecisionList.nodes('//Data') AS X (Data)
	ORDER BY DivisionID, RecDecisionID
	--SET @sJoin = @sJoin + N'
	--INNER JOIN #RecDecisionID T1 ON HRMT2050.DivisionID = T1.DivisionID AND HRMT2050.RecDecisionID = T1.RecDecisionID'
END
SET @sSQL = N'
SELECT HRMT2050.APK, HRMT2050.DivisionID, HRMT2050.RecDecisionID, HRMT2050.RecDecisionNo, HRMT2050.Description, 
	HRMT2050.DecisionDate,
	HRMT2050.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE DivisionID = HRMT2050.DivisionID AND UserID = HRMT2050.CreateUserID) CreateUserID, HRMT2050.CreateDate, 
	HRMT2050.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE DivisionID = HRMT2050.DivisionID AND UserID = HRMT2050.LastModifyUserID) LastModifyUserID, HRMT2050.LastModifyDate,
	HRMT2020.DepartmentID, AT1102.DepartmentName, HRMT2020.DutyID, HT1102.DutyName, HRMT2051.CandidateID, HRMT2051.RecruitPeriodID, HRMT2020.RecruitPeriodName, H09.Description AS [StatusName],
	LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) AS CandidateName,
	H10.Description AS Gender, HRMT1030.Birthday, CASE WHEN ISNULL(IsSingle,0) = 0 THEN N''Đã kết hôn'' ELSE N''Độc thân'' END AS MaterialStatus,
	H11.Description AS WorkType, HRMT2040.RequireSalary, HRMT2040.DealSalary, HRMT2040.TrialFromDate, HRMT2040.TrialToDate
FROM HRMT2050 WITH (NOLOCK)
INNER JOIN #RecDecisionID T1 ON HRMT2050.DivisionID = T1.DivisionID AND HRMT2050.RecDecisionID = T1.RecDecisionID
LEFT JOIN HRMT2051 WITH (NOLOCK) ON HRMT2050.DivisionID = HRMT2051.DivisionID AND HRMT2050.RecDecisionID = HRMT2051.RecDecisionID
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT2020.DivisionID AND HRMT2051.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN HT0099 H09 WITH (NOLOCK) ON HRMT2051.Status = H09.ID AND H09.CodeMaster = ''Status''
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT1030.DivisionID AND HRMT2051.CandidateID = HRMT1030.CandidateID
LEFT JOIN HT0099 H10 WITH (NOLOCK) ON HRMT1030.Gender = H10.ID AND H10.CodeMaster = ''Gender''
LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT1030.DivisionID AND HRMT1031.CandidateID = HRMT1030.CandidateID
LEFT JOIN HT0099 H11 WITH (NOLOCK) ON HRMT1031.WorkType = H11.ID AND H11.CodeMaster = ''WorkType''
LEFT JOIN HRMT2040 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT2040.DivisionID AND HRMT2051.CandidateID = HRMT2040.CandidateID
WHERE '+@sWhere +'
ORDER BY '+@OrderBy+'
'
PRINT(@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


