IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Grid Form HRMF2030: Lịch phỏng vấn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy on 22/08/2017
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
----Modified on 21/10/2020 by Huỳnh Thử: Cập nhật phân quyền
----Modified on 04/07/2023 by Anh Đô: Cập nhật điều kiện lọc
----Modified on 07/09/2023 by Thu Hà: Cập nhật sắp xếp giảm dần theo mã lịch phỏng vấn
----Modified on 25/09/2023 by Thu Hà: Bổ sung trường lọc người phụ trách
----Modified on 17/10/2023 by Thu Hà: Cập nhật bổ sung điều kiện lọc ( DeleteFlg = 0 )
-- <Example>
---- 
/*-- <Example>
	HRMP2030 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@InterviewScheduleID=NULL,@DutyID='LD',@Disabled=0

	EXEC HRMP2030 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1, 
	@InterviewScheduleID = 'aaa', @DepartmentID = NULL, @DutyID = NULL, @CandidateID=NULL, @InterviewLevel = 1,@InterviewFromDate = NULL, 
	@InterviewToDate = '2017-08-05'
----*/

CREATE PROCEDURE HRMP2030
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @InterviewScheduleID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @CandidateID VARCHAR(50),
	 @CandidateName NVARCHAR(250),
	 @AssignedToUserName NVARCHAR(500),
	 @InterviewLevel VARCHAR(1),
	 @InterviewFromDate DATETIME,
	 @InterviewToDate DATETIME,
	 @ConditionInterviewScheduleID VARCHAR(MAX),
	 @PeriodList VARCHAR(MAX),
	 @RecruitPeriodID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

SET @OrderBy = 'InterviewScheduleID DESC'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT2030.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT2030.DivisionID = '''+@DivisionID+''' '

IF @IsSearch = 0
BEGIN
	
	IF ISNULL(@InterviewScheduleID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2030.InterviewScheduleID LIKE ''%'+@InterviewScheduleID+'%'' '
	IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DepartmentID LIKE ''%'+@DepartmentID+'%'' '
	IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DutyID LIKE ''%'+@DutyID+'%'' '
	IF ISNULL(@CandidateID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2031.CandidateID LIKE ''%'+@CandidateID+'%'' '
	IF ISNULL(@CandidateName,'') <> '' SET @sWhere = @sWhere + '
	AND LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) LIKE N''%'+@CandidateName+'%'' '
	IF ISNULL(@InterviewLevel,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2030.InterviewLevel LIKE ''%'+@InterviewLevel+'%'' '

		IF ISNULL(@AssignedToUserName,'') <> ''
		BEGIN
			SET @sWhere = @sWhere + '
			AND AT1103.FullName LIKE N''%'+@AssignedToUserName+'%'''
		END

	IF ISNULL(@RecruitPeriodID, '') != ''
		SET @sWhere = @sWhere + 'AND HRMT2020.RecruitPeriodID LIKE ''%'+ @RecruitPeriodID +'%'' '
	
	IF @IsSearch = 1
	BEGIN
		SET @sWhere = @sWhere + 'AND FORMAT(HRMT2031.InterViewDate, ''MM/yyyy'') IN ('''+ @PeriodList +''')'
	END
	ELSE
	BEGIN
		IF (@InterviewFromDate IS NOT NULL AND @InterviewToDate IS NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2031.InterviewDate,120), 126) >= '''+CONVERT(VARCHAR(10),@InterviewFromDate,126)+''' '

		IF (@InterviewFromDate IS NULL AND @InterviewToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2031.InterviewDate,120), 126) <= '''+CONVERT(VARCHAR(10),@InterviewToDate,126)+''' '

		IF (@InterviewFromDate IS NOT NULL AND @InterviewToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2031.InterviewDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@InterviewFromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@InterviewToDate,126)+''' '
	END
END

IF ISNULL(@ConditionInterviewScheduleID,'') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(HRMT2030.AssignedToUserID, '''') IN (''' + @ConditionInterviewScheduleID + ''' ) OR ISNULL(HRMT2030.CreateUserID, '''') IN (''' + @ConditionInterviewScheduleID + ''' ))'


	--Bổ sung điều kiện cờ xóa = 0
	SET @sWhere = @sWhere + ' AND ISNULL(HRMT2030.DeleteFlg,0) = 0 '

SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM 
(	SELECT DISTINCT HRMT2030.APK, HRMT2030.DivisionID, HRMT2030.InterviewScheduleID, HRMT2020.RecruitPeriodID, HRMT2020.RecruitPeriodName, AT1102.DepartmentName, HRMT2030.Description,
	HT1102.DutyName, HRMT2030.InterviewLevel, HRMT2030.CreateUserID, HRMT2030.CreateDate, 
	HRMT2030.LastModifyUserID, HRMT2030.LastModifyDate,
	HRMT2030.AssignedToUserID,AT1103.FullName  AS AssignedToUserName
	FROM HRMT2030 WITH (NOLOCK)
	LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2030.DivisionID = HRMT2020.DivisionID AND HRMT2030.RecruitPeriodID = HRMT2020.RecruitPeriodID
	LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
	LEFT JOIN HRMT2031 WITH (NOLOCK) ON HRMT2030.DivisionID = HRMT2031.DivisionID AND HRMT2030.InterviewScheduleID = HRMT2031.InterviewScheduleID
	LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT2031.DivisionID AND HRMT1030.CandidateID = HRMT2031.CandidateID 
	LEFT JOIN AT1103 WITH (NOLOCK) ON HRMT2030.AssignedToUserID = AT1103.EmployeeID AND AT1103.DivisionID IN ('''+@DivisionID+''', ''@@@'')
	WHERE '+@sWhere +'
)   AS #Table
ORDER BY '+@OrderBy+'


OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

PRINT(@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
