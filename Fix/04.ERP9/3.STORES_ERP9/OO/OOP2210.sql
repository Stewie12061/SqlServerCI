IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2210]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2210]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load grid danh mục Quản lý Release 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 02/01/2019 by Tấn Lộc
-- <Example> EXEC KPIP2030 @DivisionID = 'DTI', @DivisionIDList = '', @UserID = 'TANLOC', @PageNumber='1', @PageSize='25','VANTOAI',0,0

CREATE PROCEDURE [dbo].[OOP2210]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @ReleaseID NVARCHAR(250),
	 @ReleaseName NVARCHAR(250),
	 @ReleaseVersion NVARCHAR(250),
	 @ProjectID NVARCHAR(250),
	 @MilestoneID NVARCHAR(250),
	 @TypeOfRelease VARCHAR(250),
	 @CreateUserID NVARCHAR (250),
	 @IsCommon NVARCHAR(100), 
	 @Disabled NVARCHAR(100),
	 @ConditionReleaseManagement VARCHAR(MAX),
	 @UserID VARCHAR(50), 
	 @PageNumber INT,
	 @PageSize INT
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@sSQLPermission NVARCHAR(MAX),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20)

	SET @OrderBy = 'M.CreateDate DESC'
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionID + ''')'

	SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg, 0) = 0'

	-- Check Para FromDate và ToDate
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CreateDate >= ''' + @FromDateText + '''
											OR M.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CreateDate <= ''' + @ToDateText + ''' 
											OR M.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	IF ISNULL(@ReleaseID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ReleaseID, '''') LIKE N''%' + @ReleaseID + '%'' '

	IF ISNULL(@ReleaseName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ReleaseName, '''') LIKE N''%' + @ReleaseName + '%'' '

	IF ISNULL(@ProjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ProjectID, '''') LIKE N''%' + @ProjectID + '%'' '

	IF ISNULL(@MilestoneID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.MilestoneID LIKE N''%' + @MilestoneID + '%'' OR O2.MilestoneName LIKE N''%' + @MilestoneID + '%'') '

	IF ISNULL(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.CreateUserID LIKE N''%' + @CreateUserID + '%'' OR A1.FullName LIKE N''%' + @CreateUserID + '%'') '

	IF ISNULL(@ReleaseVersion, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ReleaseVersion, '''') LIKE N''%' + @ReleaseVersion + '%'' '

	IF ISNULL(@TypeOfRelease,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TypeOfRelease, '''') IN (''' + @TypeOfRelease + ''') '

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2210'') IS NOT NULL DROP TABLE #PermissionOOT2210
								
							SELECT Value
							INTO #PermissionOOT2210
							FROM STRINGSPLIT(''' + ISNULL(@ConditionReleaseManagement, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterReleaseAPK'') IS NOT NULL DROP TABLE #FilterReleaseAPK

							SELECT DISTINCT M.APK
							INTO #FilterReleaseAPK
							FROM OOT2210 M WITH (NOLOCK)
									LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = M.ProjectID
									LEFT JOIN OOT2190 O2 WITH (NOLOCK) ON O2.MilestoneID = M.MilestoneID
									LEFT JOIN OOT2101 O3 WITH (NOLOCK) ON O3.RelatedToID = M.ProjectID
									LEFT JOIN OOT2103 O4 WITH (NOLOCK) ON O4.RelatedToID = M.ProjectID
									LEFT JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = O3.DepartmentID
									LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
									INNER JOIN #PermissionOOT2210 T1 ON T1.Value IN (M.CreateUserID, 
																						O1.LeaderID, A2.ContactPerson, O4.UserID, O1.CreateUserID)
							WHERE ' + @sWhere + ' '


	SET @sSQL = @sSQL + N'
		SELECT M.APK, M.DivisionID, M.ReleaseID, M.ReleaseName
			  , M.ProjectID, M.MilestoneID, M.CreateDate, M.CreateUserID, M.ReleaseVersion
			  , O1.ProjectName AS ProjectName
			  , O2.MilestoneName AS MilestoneName
			  , A1.FullName AS CreateUserName
			  , C2.Description AS TypeOfRelease
			  , M.AssignedToUserID
			  , A2.FullName AS AssignedToUserName
		INTO #TempOOT2210
		FROM OOT2210 M 
			INNER JOIN #FilterReleaseAPK T1 ON T1.APK = M.APK
			LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = M.ProjectID
			LEFT JOIN OOT2190 O2 WITH (NOLOCK) ON O2.MilestoneID = M.MilestoneID
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
			LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = M.AssignedToUserID
			LEFT JOIN OOT0099 C2 WITH (NOLOCK) ON C2.ID = M.TypeOfRelease AND C2.CodeMaster = N''OOF2210.TypeOfRelease''
		WHERE  ' + @sWhere +   ' AND M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempOOT2210
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , M.APK
			  , M.DivisionID
			  , M.ReleaseID
			  , M.ReleaseName
			  , M.ProjectID
			  , M.ProjectName
			  , M.MilestoneID
			  , M.MilestoneName
			  , M.CreateDate
			  , M.CreateUserName
			  , M.TypeOfRelease
			  , M.ReleaseVersion
			  , M.AssignedToUserID
			  , M.AssignedToUserName
		FROM #TempOOT2210 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQLPermission + @sSQL)
	PRINT(@sSQLPermission + @sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
