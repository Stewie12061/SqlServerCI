IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRMF2020: Đợt tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy on 14/08/2017
----Updated by: Phương Thảo on 26/07/2023  [2023/07/TA/0035]bổ sung điều kiện lọc từ ngày đến ngày và theo kì 
----Updated by: Phương Thảo on 27/07/2023  [2023/07/TA/0035]Xóa điều kiện lọc thực hiện từ, thực hiện đến
----Updated by: Phương Thảo on 14/08/2023   [2023/08/IS/0008]Bổ sung điều kiện lọc tên đợt tuyển dụng
----Update  by Thu Hà on 07092023 - Cập nhật sắp xếp giảm dần theo mã đợt tuyển dụng
---- 
/*-- <Example>
	HRMP2020 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@RecruitPeriodID=NULL,@DutyID='LD',@Disabled=0

	EXEC HRMP2020 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1, 
	@RecruitPeriodID = 'aaa', @DepartmentID = NULL, @DutyID = NULL, @PeriodFromDate = '2017-08-01', @PeriodToDate = '2017-08-05'

	exec HRMP2020 @DivisionID=N'BBA-SI',@DivisionList=N''
	,@UserID=N'ADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1
	,@RecruitPeriodID=N'',@DepartmentID=N'',@DutyID=N''
	,@FromDate=NULL,@ToDate=NULL,@IsPeriod=1,@PeriodList=N'07/2023'
	,@ConditionRecruitPeriodID=N'ADMIN'',''ANGI-SS001'',''BBA-SELLIN'',''BRVT-SS001'',''HCQ12-SS001''
	,''MTA1-ASM001'',''NM-NV01'',''NM-NV02'',''NM-NV03'',''NMT-ASM001'',''QUNG-SS001'',''UNASSIGNED'',''VP-ADMIN'',''VP-KT04'',''VP-KT05'',''VP-KT06'',''VP-SO01'',''VP-SO02'',''VP-SO03'',''VP-SO04'',''VP-SO05'',''VP-SO06'',''VP-SO07'',''VP-SO08'',''VP-SO09'',''VP-SO10'',''VP-TGD'

----*/

CREATE PROCEDURE HRMP2020
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @RecruitPeriodID VARCHAR(50),
     @RecruitPeriodName NVARCHAR(MAX),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @FromDate DATETIME = NULL,
	 @ToDate DATETIME = NULL,
	 @IsPeriod INT = 0,
	 @PeriodList VARCHAR(MAX) = '',
	 @ConditionRecruitPeriodID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @OrderBy = 'HRMT2020.RecruitPeriodID DESC,HRMT2020.DepartmentID, HRMT2020.DutyID '
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT2020.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT2020.DivisionID = '''+@DivisionID+''' '

IF  @IsSearch = 1
BEGIN
	
	IF ISNULL(@RecruitPeriodID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.RecruitPeriodID LIKE ''%'+@RecruitPeriodID+'%'' '
    IF ISNULL(@RecruitPeriodName,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.RecruitPeriodName LIKE ''%'+@RecruitPeriodName+'%'' '
	IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DepartmentID = '''+@DepartmentID+''' '
	IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DutyID LIKE ''%'+@DutyID+'%'' '
    -- Check Para FromDate và ToDate _ Begin add
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (HRMT2020.PeriodFromDate >= ''' + @FromDateText + '''
												OR HRMT2020.PeriodToDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (HRMT2020.PeriodFromDate <= ''' + @ToDateText + ''' 
												OR HRMT2020.PeriodToDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (HRMT2020.PeriodFromDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										OR HRMT2020.PeriodToDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HRMT2020.PeriodFromDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END
	-- Check Para FromDate và ToDate _ End add
	
	IF Isnull(@ConditionRecruitPeriodID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HRMT2020.CreateUserID,'''') in (N'''+@ConditionRecruitPeriodID+''', '''+@UserID+''' )'
END

SET @sSQL = N'
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		HRMT2020.APK, HRMT2020.DivisionID, HRMT2020.RecruitPeriodID, HRMT2020.RecruitPeriodName, HRMT2020.DepartmentID, AT1102.DepartmentName,
		HRMT2020.DutyID, HT1102.DutyName, HRMT2020.RecruitQuantity, HRMT2020.PeriodFromDate, HRMT2020.PeriodToDate,
		HRMT2020.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2020.CreateUserID) CreateUserID, HRMT2020.CreateDate, 
		HRMT2020.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2020.LastModifyUserID) LastModifyUserID, HRMT2020.LastModifyDate
	FROM HRMT2020 WITH (NOLOCK)
		LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
		LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
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
