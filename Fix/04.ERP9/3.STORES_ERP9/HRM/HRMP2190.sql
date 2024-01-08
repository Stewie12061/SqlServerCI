IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2190]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2190]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRMF2190: Hồ sơ bảo hiểm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo on 17/08/2023
---- 
/*-- <Example>
	exec HRMP2190 @DivisionID=N'BBA-SI',@DivisionList=N'',@UserID=N'ADMIN'
,@PageNumber=1,@PageSize=25,@IsSearch=1,@InsurFileID=N'',@DepartmentID=N'BGD'
,@TeamID=N'BGD',@DutyID=N'',@FromDate=NULL,@ToDate=NULL,@IsPeriod=1,@PeriodList=N'08/2023'
,@ConditionRecruitPeriodID=N'ADMIN'',''ANGI-SS001'',''BBA-SELLIN'',''BRVT-SS001''
,''HCQ12-SS001'',''MTA1-ASM001'',''NM-NV01'',''NM-NV02'',''NM-NV03'',''NMT-ASM001''
,''QUNG-SS001'',''UNASSIGNED'',''VP-ADMIN'',''VP-KT04'',''VP-KT05'',''VP-KT06''
,''VP-SO01'',''VP-SO02'',''VP-SO03'',''VP-SO04'',''VP-SO05'',''VP-SO06'',''VP-SO07''
,''VP-SO08'',''VP-SO09'',''VP-SO10'',''VP-TGD'----*/
CREATE PROCEDURE HRMP2190
(
		@DivisionID VARCHAR(50),
		@DivisionList VARCHAR(MAX),
		@UserID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@IsSearch TINYINT,
		@InsurFileID VARCHAR(50),
		@DepartmentID VARCHAR(50),
		@TeamID VARCHAR(50),
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

SET @OrderBy = 'HT60.DepartmentID, HT60.DutyID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HT60.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HT60.DivisionID = '''+@DivisionID+''' '

IF  @IsSearch = 1
BEGIN
	
	IF ISNULL(@InsurFileID,'') <> '' SET @sWhere = @sWhere + '
	   AND HT60.InsurFileID LIKE ''%'+@InsurFileID+'%'' '
	IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
	   AND HT60.DepartmentID LIKE ''%'+@DepartmentID+'%'' '
	IF ISNULL(@TeamID,'') <> '' SET @sWhere = @sWhere + '
	   AND HT60.TeamID LIKE ''%'+@TeamID+'%'' '
	IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
	   AND HT60.DutyID LIKE ''%'+@DutyID+'%'' '
    -- Check Para FromDate và ToDate _ Begin add
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (HT60.HFromDate >= ''' + @FromDateText + '''
										  OR HT60.HToDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (HT60.HFromDate <= ''' + @ToDateText + ''' 
										  OR HT60.HToDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (HT60.HFromDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										  OR HT60.HToDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HT60.HFromDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END
	-- Check Para FromDate và ToDate _ End add
	
	IF Isnull(@ConditionRecruitPeriodID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HT60.CreateUserID,'''') in (N'''+@ConditionRecruitPeriodID+''', '''+@UserID+''' )'
END

SET @sSQL = N'
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		 HT60.APK
		,HT60.DivisionID
		,HT60.InsurFileID
		,HT60.EmployeeID
		,AT051.UserName AS EmployeeName
		,HT60.DepartmentID
		,AT02.DepartmentName AS DepartmentName
		,HT01.TeamName AS TeamName
		,HT02.DutyName AS DutyName
		,HT60.SNo
		,HT60.HNo
		,HT99.Description AS HospitalName 
		,HT60.HFromDate
		,HT60.HToDate
		,HT60.Notes
		,HT60.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT60.CreateUserID) CreateUserID
		,HT60.CreateDate
		,HT60.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT60.LastModifyUserID) LastModifyUserID
		,HT60.LastModifyDate
	FROM HT2460  HT60 WITH (NOLOCK)
	    LEFT JOIN AT1405 AT051 WITH (NOLOCK) ON AT051.DivisionID in ( HT60.DivisionID,''@@@'') AND AT051.UserID = HT60.EmployeeID
		LEFT JOIN AT1102 AT02 WITH (NOLOCK) ON AT02.DivisionID = HT60.DivisionID AND HT60.DepartmentID = AT02.DepartmentID
		LEFT JOIN HT1101 HT01 WITH (NOLOCK) ON HT01.DivisionID = HT60.DivisionID AND HT01.TeamID = HT60.TeamID
		LEFT JOIN HT1102 HT02 WITH (NOLOCK) ON HT02.DivisionID = HT60.DivisionID AND HT60.DutyID = HT02.DutyID
		LEFT JOIN HT0099 HT99 WITH (NOLOCK) ON  HT99.ID = HT60.HospitalID AND  HT99.CodeMaster = ''HospitalID''
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
