IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2040]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2040]
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
----Created by: Bảo Thy on 22/08/2017
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
----Modified on 21/10/2020 by Huỳnh Thử: Cập nhật phân quyền
----Modified on 14/08/2023 by Tiến Sỹ: Cập nhật Param
----Modified on 07/09/2023 by Thu Hà: Cập nhật sắp xếp giảm dần theo mã ứng viên
----Modified on 29/09/2023 by Võ Dương: Cập nhật tách lọc màn hình và phiếu in ra 2 procedure
----Modified on 17/10/2023 by Thu Hà: - Cập nhật bổ sung điều kiện lọc ( DeleteFlg = 0 )
-- <Example>
----	
/*-- <Example>
	HRMP2040 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@InterviewScheduleID=NULL,@DutyID='LD',@Disabled=0

	EXEC HRMP2040 @DivisionID='CH',@DivisionList='CH'',''CH1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1, 
	@CandidateID = 'aaa', @DepartmentID = NULL, @DutyID = NULL, @RecruitPeriodID=NULL, @FromDate = '2017-08-01', 
	@ToDate = '2017-08-05', @RecruitStatus = NULL

	 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @IsSearch, @CandidateID, @RecruitPeriodID, @DepartmentID, @DutyID, @FromDate, @ToDate, @RecruitStatus
----*/

CREATE PROCEDURE HRMP2040
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @PeriodList VARCHAR(MAX),
	 @IsPeriod TINYINT,
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
	 @ConditionInterviewResultID VARCHAR(MAX),
	 @CandidateName NVARCHAR(100)


)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'',
		@CandidateNameDECLARE NVARCHAR(100) = N'';

SET @OrderBy = 'HRMT2040.CandidateID DESC,HRMT2040.RecruitPeriodID '
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
	IF ISNULL(@CandidateName,'') <> '' SET @sWhere = @sWhere + '
	AND LTRIM(RTRIM(
        CONCAT(
            HRMT1030.LastName, 
            '' '', 
            CASE WHEN LEN(HRMT1030.MiddleName) > 0 THEN HRMT1030.MiddleName + '' '' ELSE '''' END,
            HRMT1030.FirstName
        )
    )) LIKE N''%'+@CandidateName+'%'' '

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
IF Isnull(@ConditionInterviewResultID, '') != ''
BEGIN
SET @sWhere = @sWhere + ' AND ISNULL(HRMT2040.CreateUserID,'''') in (N'''+@ConditionInterviewResultID+''','''+@UserID+''' )'
END
	--Bổ sung điều kiện cờ xóa = 0
	SET @sWhere = @sWhere + ' AND ISNULL(HRMT2040.DeleteFlg,0) = 0 '

SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
	HRMT2040.APK, HRMT2040.DivisionID, HRMT2040.RecruitPeriodID, HRMT2020.DepartmentID, AT1102.DepartmentName,
	HRMT2020.DutyID, HT1102.DutyName, HRMT2040.CandidateID,
	LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) AS CandidateName,
	HRMT2040.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2040.CreateUserID) CreateUserID, HRMT2040.CreateDate, 
	HRMT2040.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2040.LastModifyUserID) LastModifyUserID, HRMT2040.LastModifyDate,
	HRMT2040.Startdate, HT0099.Description AS RecruitStatus
FROM HRMT2040 WITH (NOLOCK)
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT2020.DivisionID AND HRMT2040.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT1030.DivisionID AND HRMT2040.CandidateID = HRMT1030.CandidateID
LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT1031.DivisionID AND HRMT2040.CandidateID = HRMT1031.CandidateID
LEFT JOIN HT0099 WITH (NOLOCK) ON HRMT1031.RecruitStatus = HT0099.ID AND  HT0099.CodeMaster = ''RecruitStatus''
WHERE '+@sWhere +'
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