IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2054]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2054]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRMF2054: Xác nhận tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy on 30/08/2017
--- Modified on 18/02/2019 by Bảo Anh: Chỉ load ứng viên đã được duyệt quyết định tuyển dụng
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
----Modified on 22/10/2020 by Huỳnh Thử: Cập nhật phân quyền
-- <Example>
---- 
/*-- <Example>
	HRMP2050 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@InterviewScheduleID=NULL,@DutyID='LD',@Disabled=0

	EXEC HRMP2054 @DivisionID='CH',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1, @RecDecisionNo = 'abc',
	@CandidateID = 'aaa', @DepartmentID = 'SOF', @DutyID = 'BA', @RecruitPeriodID='bbb', @RecruitStatus = 1

	EXEC HRMP2050 @DivisionList, @UserID, @PageNumber, @PageSize, @IsSearch, @RecDecisionNo, @CandidateID, @RecruitPeriodID, @DepartmentID,
	 @DutyID, @CreateUserID, @FromDate, @ToDate, @Status
----*/

CREATE PROCEDURE HRMP2054
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @RecDecisionNo VARCHAR(50),
	 @CandidateID VARCHAR(50),
	 @RecruitPeriodID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @RecruitStatus VARCHAR(1),
	 @ConditionComfirmationRecruitmentID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

SET @OrderBy = 'HRMT2051.RecruitPeriodID, HRMT2050.RecDecisionID, HRMT2051.CandidateID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

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
	IF ISNULL(@RecruitStatus,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT1031.RecruitStatus LIKE ''%'+@RecruitStatus+'%'' '

END
IF Isnull(@ConditionComfirmationRecruitmentID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HRMT2050.CreateUserID,'''') in (N'''+@ConditionComfirmationRecruitmentID+''','''+@UserID+''' )'

SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, HRMT2051.APK, HRMT2051.DivisionID, HRMT2051.RecDecisionID,
HRMT2050.RecDecisionNo, HRMT2051.RecruitPeriodID, HRMT2051.RecruitPeriodID+'' - ''+HRMT2020.RecruitPeriodName AS RecruitPeriodName,
HRMT2020.DepartmentID, AT1102.DepartmentName, HRMT2020.DutyID, HT1102.DutyName, HRMT2051.CandidateID, 
LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) AS CandidateName,
HRMT1031.RecruitStatus, H09.Description AS RecruitStatusName
FROM HRMT2051 WITH (NOLOCK)
LEFT JOIN HRMT2050 WITH (NOLOCK) ON HRMT2050.DivisionID = HRMT2051.DivisionID AND HRMT2050.RecDecisionID = HRMT2051.RecDecisionID
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT2020.DivisionID AND HRMT2051.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT2051.DivisionID AND HRMT1030.CandidateID = HRMT2051.CandidateID 
LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1031.DivisionID AND HRMT1030.CandidateID = HRMT1031.CandidateID 
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
LEFT JOIN HT0099 H09 WITH (NOLOCK) ON HRMT1031.RecruitStatus = H09.ID AND H09.CodeMaster = ''RecruitStatus''
WHERE HRMT2051.DivisionID = '''+@DivisionID+''' '+@sWhere +'
AND ISNULL(HRMT2051.Status,0) = 1
AND ISNULL((SELECT MIN(Status) FROM OOT9001 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND APKDetail = HRMT2051.APK),0) = 1
ORDER BY '+@OrderBy+'

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
