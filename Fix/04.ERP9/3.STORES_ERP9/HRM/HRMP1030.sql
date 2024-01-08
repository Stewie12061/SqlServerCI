IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form HRF1020: Load Grid/In hồ sơ ứng viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 20/07/2017
----Modified by: Khả Vi, Date: 25/10/2017: fix lỗi khi in
----Modified by Anh Đô, Date: 12/07/2023: Cập nhật điều kiện lọc
----Modified by Phương Thảo, Date: 24/08/2023: Cập nhật điều kiện lọc( bổ sung lọc đợt tuyển dụng)
----Modified by Thu Hà, Date: 06/09/2023: Cập nhật sắp xếp giảm dần theo mã ứng viên
-- <Example>
---- 
/*-- <Example>
	HRMP1030 @DivisionID='MK',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@BoundaryID=NULL,@DepartmentID=NULL,@DutyID='LD',@FromDate=NULL,@ToDate='2017-08-30',@Disabled=0
----*/

CREATE PROCEDURE HRMP1030
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @CandidateID VARCHAR(50),
	 @CandidateName NVARCHAR(250),
	 @DepartmentID VARCHAR(MAX),
	 @RecPeriodName NVARCHAR(MAX),
	 @DutyID VARCHAR(MAX),
	 @Gender VARCHAR(MAX),
	 @RecruitStatus VARCHAR(MAX),
	 @IsCheckAll TINYINT,
	 @CandidateList VARCHAR(MAX),
	 @Language VARCHAR(50),
	 @Mode TINYINT, --0: loadform, 1: In
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'',
		@sSQL1 NVARCHAR (MAX)=N''

SET @OrderBy = 'HRMT1030.CandidateID DESC, HT90.Description'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT1030.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT1030.DivisionID = '''+@DivisionID+''' '

IF @IsCheckAll = 0 AND @Mode = 1 
	SET @sWhere = @sWhere + '
		AND HRMT1030.CandidateID IN ('+@CandidateList+')  '

IF  @IsSearch = 1 OR @Mode = 1
BEGIN
	
	IF ISNULL(@CandidateID,'') <> '' 
		SET @sWhere = @sWhere + '
			AND HRMT1030.CandidateID LIKE ''%'+@CandidateID+'%'' '
	IF ISNULL(@CandidateName,'') <> ''
		IF @Language <> 'vi-VN'
			SET @sWhere = @sWhere + '
				AND LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.LastName,''''))),''  '','' ''))) LIKE N''%'+@CandidateName+'%'' '
		ELSE
			SET @sWhere = @sWhere + '
				AND LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) LIKE N''%'+@CandidateName+'%'' '
	IF ISNULL(@DepartmentID,'') <> '' 
		SET @sWhere = @sWhere + '
			AND HRMT1031.DepartmentID IN ('''+ @DepartmentID +''') '
    IF ISNULL(@RecPeriodName,'') <> '' 
		SET @sWhere = @sWhere + '
			AND ((HRMT2020.RecruitPeriodName LIKE N''%'+@RecPeriodName+'%'' ) OR (HRMT1031.RecPeriodID LIKE  N''%'+@RecPeriodName+'%''))'
	IF ISNULL(@DutyID,'') <> '' 
		SET @sWhere = @sWhere + '
			AND HRMT1031.DutyID IN ('''+ @DutyID +''') '
	IF ISNULL(@Gender,'') <> '' 
		SET @sWhere = @sWhere + '
			AND HRMT1030.Gender IN ('''+ @Gender +''') '
	IF ISNULL(@RecruitStatus,'') <> '' 
		SET @sWhere = @sWhere + '
			AND HRMT1031.RecruitStatus IN ('''+ @RecruitStatus +''') '
	
	IF @IsPeriod = 1
	BEGIN
		SET @sWhere = @sWhere + 'AND FORMAT(HRMT1030.CreateDate, ''MM/yyyy'') IN ('''+ @PeriodList +''') '
	END
	ELSE
	BEGIN
		IF ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') = ''
			SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR, HRMT1030.CreateDate, 112) >= '''+ CONVERT(VARCHAR, @FromDate, 112) +''' '
		ELSE IF ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') != ''
			SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR, HRMT1030.CreateDate, 112) <= '''+ CONVERT(VARCHAR, @ToDate, 112) +''' '
		ELSE IF ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != ''
			SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR, HRMT1030.CreateDate, 112) 
			BETWEEN '''+ CONVERT(VARCHAR, @FromDate, 112) +''' AND '''+ CONVERT(VARCHAR, @ToDate, 112) +''' '
	END
END

BEGIN --Load Tên ứng viên (CandidateName) theo ngôn ngữ
	IF @Language <> 'vi-VN'
		SET @sSQL1 = N'LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.LastName,''''))),''  '','' ''))) AS CandidateName '
	ELSE
		SET @sSQL1 = N'LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) AS CandidateName '
END

IF ISNULL(@Mode,0) = 0 ---Load form
	BEGIN
		SET @sSQL = N'
			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
				HRMT1030.APK, HRMT1030.DivisionID, HRMT1030.CandidateID, HRMT1031.DepartmentID, AT1102.DepartmentName,
				HRMT1031.DutyID, HT1102.DutyName, HRMT1031.RecPeriodID, HRMT2020.RecruitPeriodName AS RecPeriodName, HT90.Description AS RecruitStatus, HRMT1030.Note,
				HRMT1030.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1030.CreateUserID) CreateUserID, HRMT1030.CreateDate, 
				HRMT1030.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1030.LastModifyUserID) LastModifyUserID, HRMT1030.LastModifyDate,
				 ' + @sSQL1 + '
				, HRMT1030.Gender AS GenderID
				, HT91.Description AS Gender
			FROM HRMT1030 WITH (NOLOCK)
				LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1031.DivisionID AND CAST( HRMT1030.APK AS VARCHAR(250)) = HRMT1031.CandidateID 
				LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT1031.DutyID = HT1102.DutyID AND HRMT1031.DivisionID = HT1102.DivisionID 
				LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT1031.DepartmentID = AT1102.DepartmentID 
				LEFT JOIN HT0099 HT90 WITH (NOLOCK) ON HT90.ID = HRMT1031.RecruitStatus AND HT90.CodeMaster = ''RecruitStatus''
				LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT2020.DivisionID AND HRMT1031.RecPeriodID = HRMT2020.RecruitPeriodID
				LEFT JOIN HT0099 HT91 WITH (NOLOCK) ON HT91.ID = HRMT1030.Gender AND HT91.CodeMaster = ''Gender'' AND HT91.Disabled = 0
			WHERE '+@sWhere +'
			ORDER BY '+@OrderBy+'

			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	END
ELSE
	BEGIN ---@Mode = 1: In
		SET @sSQL = N'
			SELECT HRMT1030.DivisionID, AT1101.DivisionName, HRMT1030.CandidateID,
				HRMT1031.RecPeriodID, HRMT2020.RecruitPeriodName AS RecPeriodName,HRMT1031.DepartmentID, AT1102.DepartmentName, HRMT1031.DutyID, HT1102.DutyName, 
				HT90.Description AS RecruitStatus, HRMT1030.Note, ' + @sSQL1 + ' 
			FROM HRMT1030 WITH (NOLOCK)
				LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1031.DivisionID AND CAST( HRMT1030.APK AS VARCHAR(250)) = HRMT1031.CandidateID 
				LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT1031.DutyID = HT1102.DutyID AND HRMT1031.DivisionID = HT1102.DivisionID 
				LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT1031.DepartmentID = AT1102.DepartmentID 
				LEFT JOIN HT0099 HT90 WITH (NOLOCK) ON HT90.ID = HRMT1031.RecruitStatus AND HT90.CodeMaster = ''RecruitStatus''
				LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT2020.DivisionID AND HRMT1031.RecPeriodID = HRMT2020.RecruitPeriodID
				LEFT JOIN AT1101 WITH (NOLOCK) ON HRMT1030.DivisionID = AT1101.DivisionID
			WHERE '+@sWhere +'
			ORDER BY '+@OrderBy+'
			'
END
--PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
