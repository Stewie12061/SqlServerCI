IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2032]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2032]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In Lịch phỏng vấn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy on 22/08/2017
-- <Example>
----Update by : Thu Hà , Date: 25/07/2023 - Bổ sung DivisionName,ConfirmName và format InterviewDate cho master
----Update by : Thu Hà , Date: 02/10/2023 - Bổ sung dữ liệu in.
/*-- <Example>
	HRMP2032 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@InterviewScheduleID=NULL,@DutyID='LD',@Disabled=0

	EXEC HRMP2032 @DivisionID='CH',@DivisionList=NULL,@UserID='ASOFTADMIN',@IsSearch=1, 
	@InterviewScheduleID = 'aaa', @DepartmentID = NULL, @DutyID = NULL, @CandidateID=NULL, @CandidateName=NULL,@InterviewLevel = 1,@InterviewFromDate = NULL, 
	@InterviewToDate = '2017-08-05', @IsCheckAll = 1, @InterviewScheduleList = NULL
----*/

CREATE PROCEDURE HRMP2032
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @IsPeriod VARCHAR(MAX),
	 @PeriodList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @IsSearch TINYINT,
	 @InterviewScheduleID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	-- @CandidateID VARCHAR(50),
	-- @CandidateName NVARCHAR(250),
	 @InterviewLevel VARCHAR(1),
	 @InterviewFromDate DATETIME,
	 @InterviewToDate DATETIME,
	 @IsCheckAll TINYINT,
	-- @InterviewScheduleList XML
	 @InterviewScheduleList NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

SET @OrderBy = 'HRMT2030.InterviewScheduleID, HRMT2030.RecruitPeriodID'
--HRMT2020.DepartmentID, HRMT2020.DutyID, HRMT2030.InterviewLevel
IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT2030.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT2030.DivisionID = '''+@DivisionID+''' '

IF @InterviewScheduleList IS NOT NULL
SET @sWhere = @sWhere + ' AND HRMT2030.InterviewScheduleID IN (''' + @InterviewScheduleList +''') '


IF @IsSearch = 1
BEGIN
	
	IF ISNULL(@InterviewScheduleID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2030.InterviewScheduleID LIKE ''%'+@InterviewScheduleID+'%'' '

	IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DepartmentID LIKE ''%'+@DutyID+'%'' '

	IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DutyID LIKE ''%'+@DutyID+'%'' '

	--IF ISNULL(@CandidateID,'') <> '' SET @sWhere = @sWhere + '
	--AND HRMT2031.CandidateID LIKE ''%'+@CandidateID+'%'' '

	--IF ISNULL(@CandidateName,'') <> '' SET @sWhere = @sWhere + '
	--AND LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) LIKE N''%'+@CandidateName+'%'' '

	IF ISNULL(@InterviewLevel,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2030.InterviewLevel LIKE ''%'+@InterviewLevel+'%'' '

	--IF (@InterviewFromDate IS NOT NULL AND @InterviewToDate IS NULL) SET @sWhere = @sWhere + '
	--AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2031.InterviewDate,120), 126) >= '''+CONVERT(VARCHAR(10),@InterviewFromDate,126)+''' '
	--IF (@InterviewFromDate IS NULL AND @InterviewToDate IS NOT NULL) SET @sWhere = @sWhere + '
	--AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2031.InterviewDate,120), 126) <= '''+CONVERT(VARCHAR(10),@InterviewToDate,126)+''' '
	--IF (@InterviewFromDate IS NOT NULL AND @InterviewToDate IS NOT NULL) SET @sWhere = @sWhere + '
	--AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2031.InterviewDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@InterviewFromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@InterviewToDate,126)+''' '	
	--Lọc theo ngày
	IF (@IsPeriod = '0')
	BEGIN
		IF (@InterviewFromDate IS NOT NULL AND @InterviewToDate IS NULL) 
		BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2030.CreateDate >= N''' + CONVERT(NVARCHAR(10), @InterviewFromDate, 101) + ''''
		END
		IF (@InterviewFromDate IS NULL AND @InterviewToDate IS NOT NULL) 
		BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2030.CreateDate < N''' + CONVERT(NVARCHAR(10), @InterviewFromDate, 101) + ''''
		END
		IF (@InterviewFromDate IS NOT NULL AND @InterviewToDate IS NOT NULL)
		BEGIN
		SET @sWhere = @sWhere + '
				AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2030.CreateDate,120), 120) BETWEEN '''+CONVERT(VARCHAR(10),@InterviewFromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@InterviewToDate,120)+''''
		END
	END	
	-- Lọc theo kỳ
	ELSE
	BEGIN
		IF(@PeriodList IS NOT NULL)
			BEGIN
			SET @sWhere = @sWhere + ' AND (SELECT FORMAT(ISNULL(HRMT2030.CreateDate,HRMT2030.CreateDate), ''MM/yyyy'')) IN (''' + @PeriodList + ''') '
			END
	END

END

--IF ISNULL(@IsCheckAll,0) = 0
--BEGIN
--	CREATE TABLE #InterviewScheduleList (DivisionID VARCHAR(50), InterviewScheduleID VARCHAR(50))
--	INSERT INTO #InterviewScheduleList (DivisionID, InterviewScheduleID)
--	SELECT X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
--		   X.Data.query('InterviewScheduleID').value('.', 'NVARCHAR(50)') AS InterviewScheduleID
--	FROM	@InterviewScheduleList.nodes('//Data') AS X (Data)
--	ORDER BY InterviewScheduleID

--	SET @sJoin = @sJoin + N'
--	INNER JOIN #InterviewScheduleList T1 ON HRMT2020.DivisionID = T1.DivisionID AND HRMT2030.InterviewScheduleID = T1.InterviewScheduleID'
--END

SET @sSQL = N'
SELECT HRMT2030.APK, HRMT2030.DivisionID,AT1101.DivisionName, HRMT2030.InterviewScheduleID, HRMT2030.Description, HRMT2030.RecruitPeriodID, HRMT2020.RecruitPeriodName, HRMT2020.DepartmentID, 
	AT1102.DepartmentName, HRMT2020.DutyID, HT1102.DutyName, HRMT2021.InterviewAddress, 
	CASE WHEN HRMT2030.InterviewLevel = 1 THEN N''Vòng 1''
		 WHEN HRMT2030.InterviewLevel = 2 THEN N''Vòng 2''
		 WHEN HRMT2030.InterviewLevel = 3 THEN N''Vòng 3''
		 WHEN HRMT2030.InterviewLevel = 4 THEN N''Vòng 4''
		 WHEN HRMT2030.InterviewLevel = 5 THEN N''Vòng 5'' END AS InterviewLevel, HRMT2031.CandidateID,
	LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) AS CandidateName,
	 CONVERT(VARCHAR(19), HRMT2031.InterviewDate, 105) + '' '' + CONVERT(VARCHAR(8), HRMT2031.InterviewDate, 108)AS InterviewDate,
	H99.Description AS ConfirmID,H99.Description AS ConfirmName,
	HRMT2030.AssignedToUserID,AT1103.FullName  AS AssignedToUserName,
	HRMT2030.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2030.CreateUserID) CreateUserID, HRMT2030.CreateDate, 
	HRMT2030.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2030.LastModifyUserID) LastModifyUserID, HRMT2030.LastModifyDate,HRMT2031.Notes
FROM HRMT2030 WITH (NOLOCK)
LEFT JOIN HRMT2031 WITH (NOLOCK) ON HRMT2030.DivisionID = HRMT2031.DivisionID AND HRMT2030.InterviewScheduleID = HRMT2031.InterviewScheduleID
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2030.DivisionID = HRMT2020.DivisionID AND HRMT2030.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN HRMT2021 WITH (NOLOCK) ON HRMT2021.DivisionID = HRMT2020.DivisionID AND HRMT2021.RecruitPeriodID = HRMT2020.RecruitPeriodID AND HRMT2021.InterviewLevel = HRMT2030.InterviewLevel
LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT2031.DivisionID = HRMT1030.DivisionID AND HRMT2031.CandidateID = HRMT1030.CandidateID
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
LEFT JOIN AT1101 WITH (NOLOCK) ON HRMT2030.DivisionID = AT1101.DivisionID
LEFT JOIN AT1103 WITH (NOLOCK) ON HRMT2030.AssignedToUserID = AT1103.EmployeeID
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
LEFT JOIN HT0099 H99 WITH (NOLOCK) ON HRMT2031.ConfirmID = H99.ID AND H99.CodeMaster = ''InterviewConfirm''
'+@sJoin+'
WHERE '+@sWhere+'
ORDER BY '+@OrderBy+''

PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

