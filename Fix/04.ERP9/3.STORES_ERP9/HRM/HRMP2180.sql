IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2180]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2180]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRMF2180: Hợp đồng lao động 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo on 07/08/2023
----Modify  by: Phương Thảo on 24/10/2023 -- Update load Trạng thái hợp dồng và Tên nhân viên 
---- 
/*-- <Example>
	

	exec HRMP2180 @DivisionID=N'BBA-SI',@DivisionList=N''
	,@UserID=N'ADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1
	,@RecruitPeriodID=N'',@DepartmentID=N'',@DutyID=N''
	,@FromDate=NULL,@ToDate=NULL,@IsPeriod=1,@PeriodList=N'07/2023'
	,@ConditionRecruitPeriodID=N'ADMIN'',''ANGI-SS001'',''BBA-SELLIN'',''BRVT-SS001'',''HCQ12-SS001''
	,''MTA1-ASM001'',''NM-NV01'',''NM-NV02'',''NM-NV03'',''NMT-ASM001'',''QUNG-SS001'',''UNASSIGNED'',''VP-ADMIN'',''VP-KT04'',''VP-KT05'',''VP-KT06'',''VP-SO01'',''VP-SO02'',''VP-SO03'',''VP-SO04'',''VP-SO05'',''VP-SO06'',''VP-SO07'',''VP-SO08'',''VP-SO09'',''VP-SO10'',''VP-TGD'

----*/

CREATE PROCEDURE HRMP2180
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @ContractTypeID VARCHAR(50),
	 @ContractID VARCHAR(50),
	 @ContractNo VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @TeamID VARCHAR(50),
	 @Fullname VARCHAR(250),
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
	
	IF ISNULL(@ContractTypeID,'') <> '' SET @sWhere = @sWhere + '
	   AND HT60.ContractTypeID LIKE ''%'+@ContractTypeID+'%'' '
	IF ISNULL(@ContractID,'') <> '' SET @sWhere = @sWhere + '
	   AND HT60.ContractID = '''+@ContractID+''' '
	IF ISNULL(@ContractNo,'') <> '' SET @sWhere = @sWhere + '
	   AND HT60.ContractNo LIKE ''%'+@ContractNo+'%'' '
	IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
	   AND HT60.DepartmentID LIKE ''%'+@DepartmentID+'%'' '
	IF ISNULL(@TeamID,'') <> '' SET @sWhere = @sWhere + '
	   AND HT60.TeamID LIKE ''%'+@TeamID+'%'' '
	IF ISNULL(@Fullname,'') <> '' SET @sWhere = @sWhere + '
	   AND HT60.Fullname LIKE ''%'+@Fullname+'%'' '
    -- Check Para FromDate và ToDate _ Begin add
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (HT60.WorkDate >= ''' + @FromDateText + '''
												OR HT60.WorkEndDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (HT60.WorkDate <= ''' + @ToDateText + ''' 
												OR HT60.WorkEndDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (HT60.WorkDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										OR HT60.WorkEndDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HT60.WorkDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END
	-- Check Para FromDate và ToDate _ End add
	
	IF Isnull(@ConditionRecruitPeriodID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HT60.CreateUserID,'''') in (N'''+@ConditionRecruitPeriodID+''', '''+@UserID+''' )'
END

SET @sSQL = N'
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		HT60.APK
		, HT60.DivisionID
        , HT60.ContractID
		, HT05.ContractTypeName
		, AT031.FullName AS EmployeeName
		, HT60.ContractNo
		, HT60.DepartmentID
		, AT02.DepartmentName
		, HT01.TeamName AS TeamName
		, HT60.SignDate
		, AT032.FullName AS SignPersonName
		, HT02.DutyName
		, HT99.Description AS StatusRecieveName 
		, HT60.WorkDate
		, HT60.WorkEndDate
		, HT60.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT60.CreateUserID) CreateUserID
		, HT60.CreateDate
		, HT60.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT60.LastModifyUserID) LastModifyUserID
		, HT60.LastModifyDate
	FROM HT1360  HT60 WITH (NOLOCK)
	    LEFT JOIN HT1105 HT05	WITH (NOLOCK) ON HT05.DivisionID in ( HT60.DivisionID,''@@@'') AND HT05.ContractTypeID = HT60.ContractTypeID 
		LEFT JOIN AT1102 AT02	WITH (NOLOCK) ON AT02.DivisionID = HT60.DivisionID AND AT02.DepartmentID = HT60.DepartmentID
		LEFT JOIN HT1102 HT02	WITH (NOLOCK) ON HT02.DivisionID = HT60.DivisionID AND HT02.DutyID = HT60.DutyID
		LEFT JOIN HT1101 HT01	WITH (NOLOCK) ON HT01.DivisionID = HT60.DivisionID AND HT01.TeamID = HT60.TeamID
		LEFT JOIN AT1103 AT031	WITH (NOLOCK) ON AT031.DivisionID in ( HT60.DivisionID,''@@@'') AND AT031.EmployeeID = HT60.EmployeeID
		LEFT JOIN AT1103 AT032	WITH (NOLOCK) ON AT032.DivisionID in ( HT60.DivisionID,''@@@'') AND AT032.EmployeeID = HT60.SignPersonID
		LEFT JOIN HT0099 HT99   WITH (NOLOCK) ON HT99.ID = HT60.StatusRecieve AND  HT99.CodeMaster = ''TrainingType''
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
