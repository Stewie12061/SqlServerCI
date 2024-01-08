IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2053]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2053]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Chọn ứng viên trúng tuyển từ Đợt tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 29/08/2017
----Modified on 24/08/2023 by Thu Hà: Cập nhật sử dụng hàm ISNULL để kiểm tra giá trị của cột InterviewStatus trong bảng T1. 
-- <Example>
---- 
/*-- <Example>
	HRMP2053 @DivisionID='CH',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25, @RecruitPeriodID='aaa'',''bbb'',''ccc', @CandidateID='bbb', @DepartmentID = 'aaa',
	@DutyID = 'ccc', @FromDate = '2017-05-01', @ToDate = '2017-05-30'

	@DivisionID,@UserID,@PageNumber,@PageSize,@IsSearch, @RecruitPlanID, @DepartmentID, @DutyID,@FromDate,@ToDate, @Status
----*/

CREATE PROCEDURE HRMP2053
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @RecruitPeriodID VARCHAR(MAX),
	 @CandidateID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'',
		@sWhere NVARCHAR(500)=N''

		SET @OrderBy = 'T1.RecruitPeriodID, T1.CandidateID'
		IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

		IF ISNULL(@RecruitPeriodID,'') <> '' SET @sWhere = @sWhere + '
		AND HRMT2040.RecruitPeriodID IN ('''+@RecruitPeriodID+''') '

		IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
		AND T2.DepartmentID LIKE ''%'+@DepartmentID+'%'' '

		IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
		AND T2.DutyID LIKE ''%'+@DutyID+'%'' '

		IF ISNULL(@CandidateID,'') <> '' SET @sWhere = @sWhere + '
		AND HRMT2040.CandidateID LIKE ''%'+@CandidateID+'%'' '

		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE,T2.PeriodFromDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '

		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE,T2.PeriodToDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '

		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE,T2.PeriodFromDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' 
		AND CONVERT(VARCHAR(10), CONVERT(DATE,T2.PeriodToDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '

		SET @sSQL = N'
		SELECT  T1.DivisionID, HRMT2040.RecruitPeriodID, HRMT2040.RecruitPeriodID+'' - ''+T2.RecruitPeriodName AS RecruitPeriodName, HRMT2040.CandidateID,
		LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) AS CandidateName,
		T2.DepartmentID, AT1102.DepartmentName, T2.DutyID, HT1102.DutyName,
		HRMT1030.Gender, H10.Description AS GenderName, HRMT1030.Birthday AS BirthDay, IsSingle, 
		CASE WHEN ISNULL(IsSingle,0) = 0 
			THEN N''Đã kết hôn'' 
			ELSE N''Độc thân'' 
			END AS MaterialStatus,
		HRMT1031.WorkType, H11.Description AS WorkTypeName, HRMT2040.RequireSalary, HRMT2040.DealSalary, HRMT2040.TrialFromDate, HRMT2040.TrialToDate,
		HRMT1031.RecruitStatus, H12.Description AS StatusName
		INTO #Temp_HRMP2053
		FROM HRMT2040 WITH (NOLOCK)
		INNER JOIN HRMT2041 T1 WITH (NOLOCK) ON T1.DivisionID = HRMT2040.DivisionID AND T1.APKMaster = HRMT2040.APK
		LEFT JOIN HRMT2020 T2 WITH (NOLOCK) ON HRMT2040.DivisionID = T2.DivisionID AND HRMT2040.RecruitPeriodID = T2.RecruitPeriodID
		INNER JOIN HRMT1030 WITH (NOLOCK) ON HRMT1030.DivisionID = T1.DivisionID AND HRMT1030.CandidateID = HRMT2040.CandidateID
		LEFT JOIN AT1102 WITH (NOLOCK) ON T2.DepartmentID = AT1102.DepartmentID
		LEFT JOIN HT1102 WITH (NOLOCK) ON T2.DivisionID = HT1102.DivisionID AND T2.DutyID = HT1102.DutyID
		LEFT JOIN HT0099 H10 WITH (NOLOCK) ON HRMT1030.Gender = H10.ID AND H10.CodeMaster = ''Gender''
		LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT1030.DivisionID AND HRMT1031.CandidateID = HRMT1030.CandidateID
		LEFT JOIN HT0099 H11 WITH (NOLOCK) ON HRMT1031.WorkType = H11.ID AND H11.CodeMaster = ''WorkType''
		LEFT JOIN HT0099 H12 WITH (NOLOCK) ON HRMT1031.RecruitStatus = H12.ID AND H12.CodeMaster = ''RecruitStatus''
		WHERE T1.DivisionID = '''+@DivisionID+'''
		AND   ISNULL(T1.InterviewStatus,1) = 1
		--AND NOT EXISTS (SELECT TOP 1 1 FROM HRMT2051 WITH (NOLOCK) WHERE T1.DivisionID = HRMT2051.DivisionID AND HRMT2040.RecruitPeriodID = HRMT2051.RecruitPeriodID AND HRMT2040.CandidateID = HRMT2051.CandidateID)
		'+@sWhere+'
		GROUP BY T1.DivisionID, HRMT2040.RecruitPeriodID, T2.RecruitPeriodName, HRMT2040.CandidateID, T2.DepartmentID, AT1102.DepartmentName, T2.DutyID, HT1102.DutyName, 
		HRMT1030.LastName, HRMT1030.MiddleName, HRMT1030.FirstName, T2.TotalLevel, HRMT1030.Gender, H10.Description, HRMT1030.Birthday, IsSingle,
		HRMT1031.WorkType, H11.Description, HRMT2040.RequireSalary, HRMT2040.DealSalary, HRMT2040.TrialFromDate, HRMT2040.TrialToDate, HRMT1031.RecruitStatus, H12.Description
		---HAVING MAX(T1.InterviewLevel) = T2.TotalLevel

		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, T1.*
		FROM #Temp_HRMP2053 T1
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
		DROP TABLE #Temp_HRMP2053


'
PRINT(@sSQL)

EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

