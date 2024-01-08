IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2200]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2200]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form HRMF2200: Kết quả thử việc
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo on 18/10/2023
---- 
/*-- <Example>
	

	exec HRMP2200 @DivisionID=N'BBA-SI',@DivisionList=N''
	,@UserID=N'ADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1
	,@RecruitPeriodID=N'',@EmployeeID=N'',@DutyID=N''
	,@FromDate=NULL,@ToDate=NULL,@IsPeriod=1,@PeriodList=N'07/2023'
	,@ConditionRecruitPeriodID=N'ADMIN'',''ANGI-SS001'',''BBA-SELLIN'',''BRVT-SS001'',''HCQ12-SS001''
	,''MTA1-ASM001'',''NM-NV01'',''NM-NV02'',''NM-NV03'',''NMT-ASM001'',''QUNG-SS001'',''UNASSIGNED'',''VP-ADMIN'',''VP-KT04'',''VP-KT05'',''VP-KT06'',''VP-SO01'',''VP-SO02'',''VP-SO03'',''VP-SO04'',''VP-SO05'',''VP-SO06'',''VP-SO07'',''VP-SO08'',''VP-SO09'',''VP-SO10'',''VP-TGD'

----*/

CREATE PROCEDURE HRMP2200
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @ResultNo NVARCHAR(250),
	 @ResultDate VARCHAR(50),
	 @ContractNo NVARCHAR(250),
	 @EmployeeID NVARCHAR(250),
	 @ReviewPerson NVARCHAR(250),
	 @DecidePerson NVARCHAR(250),
	 @ResultID NVARCHAR(250),
	 @ConditionProbationResults VARCHAR(MAX) = '',
	 @FromDate DATETIME = NULL,
	 @ToDate DATETIME = NULL,
	 @IsPeriod INT = 0,
	 @PeriodList VARCHAR(MAX) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'',
		@sSQLPermission NVARCHAR(MAX),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @OrderBy = 'HT34.CreateDate DESC'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionList, '') != ''
		SET @sWhere = @sWhere + ' HT34.DivisionID IN (''' + @DivisionList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' HT34.DivisionID IN (''' + @DivisionID + ''')'

	--Bổ sung điều kiện cờ xóa = 0
    SET @sWhere = @sWhere + ' AND ISNULL(HT34.DeleteFlg,0) = 0 '


IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (HT34.TestFromDate >= ''' + @FromDateText + '''
												OR HT34.TestToDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (HT34.TestFromDate <= ''' + @ToDateText + ''' 
												OR HT34.TestToDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (HT34.TestFromDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										OR HT34.TestToDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HT34.TestFromDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	IF ISNULL(@ResultNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HT34.ResultNo, '''') LIKE N''%' + @ResultNo + '%'' '

	IF ISNULL(@EmployeeID, '') != ''
		SET @sWhere = @sWhere + ' AND (HT34.EmployeeID LIKE N''%' + @EmployeeID + '%'' OR AT03.FullName LIKE N''%' + @EmployeeID + '%'') '

	IF ISNULL(@ContractNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HT34.ContractNo, '''') LIKE N''%' + @ContractNo + '%'' '

	IF ISNULL(@ReviewPerson, '') != ''
		SET @sWhere = @sWhere + ' AND (HT34.ReviewPerson LIKE N''%' + @ReviewPerson + '%'' OR AT031.FullName LIKE N''%' + @ReviewPerson + '%'') '

	IF ISNULL(@DecidePerson, '') != ''
		SET @sWhere = @sWhere + ' AND (HT34.DecidePerson LIKE N''%' + @DecidePerson + '%'' OR AT032.FullName LIKE N''%' + @DecidePerson + '%'') '
	
	IF ISNULL(@ResultID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HT34.ResultID, '''') IN (''' + @ResultID + ''') '


	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionHRMT2200'') IS NOT NULL DROP TABLE #PermissionHRMT2200
								
							SELECT Value
							INTO #PermissionHRMT2200
							FROM STRINGSPLIT(''' + ISNULL(@ConditionProbationResults, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterProbationResultsAPK'') IS NOT NULL DROP TABLE #FilterProbationResultsAPK

							SELECT DISTINCT HT34.APK
							INTO #FilterProbationResultsAPK
							FROM HT0534 HT34 WITH (NOLOCK)
								LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON AT03.DivisionID = HT34.DivisionID AND AT03.EmployeeID = HT34.EmployeeID
								LEFT JOIN HT0099 HT09 WITH (NOLOCK) ON  HT09.ID = HT34.Status  AND HT09.CodeMaster = ''Status''
								LEFT JOIN HT0099 HT99 WITH (NOLOCK) on HT34.ResultID = HT99.ID and HT99.CodeMaster = ''ResultID''
								LEFT JOIN AT1103 AT031 WITH (NOLOCK) ON AT031.DivisionID IN ( HT34.DivisionID, ''@@@'') AND AT031.EmployeeID = HT34.ReviewPerson
								LEFT JOIN AT1103 AT032 WITH (NOLOCK) ON AT032.DivisionID IN ( HT34.DivisionID, ''@@@'') AND AT032.EmployeeID = HT34.DecidePerson
								INNER JOIN #PermissionHRMT2200 T1 ON T1.Value IN (HT34.CreateUserID, HT34.ReviewPerson, HT34.DecidePerson, HT34.EmployeeID)
							WHERE ' + @sWhere + ''

	

SET @sSQL = N'
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		HT34.APK
		, HT34.DivisionID
        , HT34.ResultNo
		, HT34.ResultDate
		, HT34.ContractNo
		, HT34.EmployeeID
		, AT03.FullName AS EmployeeName
		, HT34.Status
		, HT09.Description AS StatusName  
		, HT34.TestFromDate
		, HT34.TestToDate
		, HT99.Description AS ResultName
		, AT031.FullName AS ReviewPersonName---Người đánh giá
		, AT032.FullName AS DecidePersonName---Người duyệt 
		, HT34.Notes
		, HT34.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT34.CreateUserID) CreateUserID
		, HT34.CreateDate
		, HT34.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT34.LastModifyUserID) LastModifyUserID
		, HT34.LastModifyDate
	FROM HT0534  HT34 WITH (NOLOCK)
	INNER JOIN #FilterProbationResultsAPK T1 ON T1.APK = HT34.APK
	LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON AT03.DivisionID = HT34.DivisionID AND AT03.EmployeeID = HT34.EmployeeID
	LEFT JOIN HT0099 HT09 WITH (NOLOCK) ON  HT09.ID = HT34.Status  AND HT09.CodeMaster = ''Status''
	LEFT JOIN HT0099 HT99 WITH (NOLOCK) on HT34.ResultID = HT99.ID and HT99.CodeMaster = ''ResultID''
	LEFT JOIN AT1103 AT031 WITH (NOLOCK) ON AT031.DivisionID IN ( HT34.DivisionID, ''@@@'') AND AT031.EmployeeID = HT34.ReviewPerson
	LEFT JOIN AT1103 AT032 WITH (NOLOCK) ON AT032.DivisionID IN ( HT34.DivisionID, ''@@@'') AND AT032.EmployeeID = HT34.DecidePerson
	WHERE '+@sWhere +'
	ORDER BY '+@OrderBy+'
	
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

PRINT(@sSQLPermission + @sSQL)
EXEC (@sSQLPermission + @sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
