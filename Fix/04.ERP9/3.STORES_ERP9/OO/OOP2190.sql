IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2190]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2190]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load grid danh mục Quản lý Milestone/Release 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
---- Create on 25/10/2019 by Tấn Lộc
---- Modified on 10/01/2023 by Hoài Thanh - Bổ sung luồng load dữ liệu từ dashboard.
---- Modified on 13/02/2023 by Hoài Bảo : Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược

-- <Example> EXEC KPIP2030 @DivisionID = 'DTI', @DivisionIDList = '', @UserID = 'TANLOC', @PageNumber='1', @PageSize='25','VANTOAI',0,0

CREATE PROCEDURE [dbo].[OOP2190]
( 
	 @DivisionID VARCHAR(50) = '',
	 @DivisionIDList NVARCHAR(MAX) = '',
	 @FromDate DATETIME = NULL,
	 @ToDate DATETIME = NULL,
	 @IsPeriod INT = 0,
	 @PeriodList VARCHAR(MAX) = '',
	 @MilestoneID NVARCHAR(250) = '',
	 @MilestoneName NVARCHAR(250) = '',
	 @StatusID NVARCHAR(250) = '',
	 @PriorityID NVARCHAR(250) = '',
	 @ReleaseVerion NVARCHAR(250) = '',
	 @ProjectID NVARCHAR(250) = '',
	 @AssignedToUserID NVARCHAR(250) = '',
	 @TypeOfMilestone VARCHAR(250) = '',
	 @IsCommon NVARCHAR(100) = '', 
	 @Disabled NVARCHAR(100) = '',
	 @ConditionMilestoneManagement VARCHAR(MAX) = '',
	 @UserID VARCHAR(50) = '', 
	 @PageNumber INT = 1,
	 @PageSize INT = 25,
	 @Type INT = 2, -- Type = 6: từ dashboard -> danh mục
	 @IsLate INT = 0, -- 1: lấy dữ liệu milestone trễ
	 @EmployeeIDList VARCHAR(MAX) = NULL,
	 @ProjectIDList NVARCHAR(MAX) = NULL,
	 @RelAPK NVARCHAR(250) = '',
	 @RelTable NVARCHAR(250) = ''
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@sWhere1 NVARCHAR(MAX) = '',
			@sWhereDashboard NVARCHAR(MAX) = '',
			@sSQLPermission NVARCHAR(MAX),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20)

	SET @OrderBy = 'M.CreateDate DESC'
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''')'
			SET @sWhereDashboard = @sWhereDashboard + ' M.DivisionID IN (''' + @DivisionIDList + ''')'
		END
	ELSE 
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionID + ''')'

	SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg, 0) = 0'
	SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.DeleteFlg, 0) = 0'

	-- Check Para FromDate và ToDate
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.TimeRequest >= ''' + @FromDateText + '''
											OR M.DeadlineRequest >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.TimeRequest <= ''' + @ToDateText + ''' 
											OR M.DeadlineRequest <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.TimeRequest BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
									OR M.DeadlineRequest BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.TimeRequest, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
		SET @sWhereDashboard = @sWhereDashboard + ' AND (SELECT FORMAT(M.TimeRequest, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	IF ISNULL(@MilestoneID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.MilestoneID, '''') LIKE N''%' + @MilestoneID + '%'' '

	IF ISNULL(@MilestoneName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.MilestoneName, '''') LIKE N''%' + @MilestoneName + '%'' '

	IF ISNULL(@ProjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ProjectID, '''') LIKE N''%' + @ProjectID + '%'' '

	IF ISNULL(@StatusID,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND ISNULL(M.StatusID, '''') IN (''' + @StatusID + ''') '
			SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.StatusID, '''') IN (''' + @StatusID + ''') '
		END

	IF ISNULL(@PriorityID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.PriorityID, '''') IN (''' + @PriorityID + ''') '

	IF ISNULL(@AssignedToUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (A1.FullName LIKE N''%' + @AssignedToUserID + '%'' OR M.AssignedToUserID LIKE N''%' + @AssignedToUserID + '%'') '

	IF ISNULL(@ReleaseVerion, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ReleaseVerion, '''') LIKE N''%' + @ReleaseVerion + '%'' '

	IF ISNULL(@TypeOfMilestone,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TypeOfMilestone, '''') IN (''' + @TypeOfMilestone + ''') '

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	IF @Type = 6
		BEGIN
			IF @IsLate = 1
				SET @sWhereDashboard = @sWhereDashboard + ' AND M.StatusID != ''TTMS0006'' AND M.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111)'

			IF ISNULL(@EmployeeIDList, '') != ''
				SET @sWhereDashboard = @sWhereDashboard + ' AND M.AssignedToUserID IN ( ''' + @EmployeeIDList + ''')'

			IF ISNULL(@ProjectIDList, '') != ''
				SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.ProjectID, '''') IN ( ''' + @ProjectIDList + ''')'

			SET @sWhere1 = 'WHERE ' + @sWhereDashboard + ' '

		END
	ELSE --Type = 2
	BEGIN
		IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
		BEGIN
			SET @sWhere1 = 
			CASE
				WHEN @RelTable = 'CRMT0088' THEN 'LEFT JOIN ' +@RelTable+ ' C9 WITH (NOLOCK) ON C9.APKChild = M.APK 
											WHERE ''' +@RelAPK+''' IN (CONVERT(VARCHAR(50), C8.APK),CONVERT(VARCHAR(50), C9.APKParent))
											AND M.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') 
											AND ISNULL(M.DeleteFlg, 0) = 0'
				WHEN @RelTable = 'OOT2100' THEN 'LEFT JOIN ' +@RelTable+ ' C9 WITH (NOLOCK) ON C9.ProjectID = M.ProjectID 
										   WHERE C9.APK = ''' +@RelAPK+ '''
										   AND M.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') 
										   AND ISNULL(M.DeleteFlg, 0) = 0'
				WHEN @RelTable = 'OOT0098' THEN 'LEFT JOIN ' +@RelTable+ ' C9 WITH (NOLOCK) ON C9.APKRel = M.APK
										   WHERE C9.APKObject = ''' +@RelAPK+ '''
										   AND M.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') 
										   AND ISNULL(M.DeleteFlg, 0) = 0'
				ELSE 'WHERE ' + @sWhere + ' '
			END
		END
		ELSE
			SET @sWhere1 = 'WHERE ' + @sWhere + ' '
	END

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2190'') IS NOT NULL DROP TABLE #PermissionOOT2190
								
							SELECT Value
							INTO #PermissionOOT2190
							FROM STRINGSPLIT(''' + ISNULL(@ConditionMilestoneManagement, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterMilestoneAPK'') IS NOT NULL DROP TABLE #FilterMilestoneAPK

							SELECT DISTINCT M.APK
							INTO #FilterMilestoneAPK
							FROM OOT2190 M WITH (NOLOCK)
									LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = M.ProjectID
									LEFT JOIN OOT2101 O2 WITH (NOLOCK) ON O2.RelatedToID = M.ProjectID
									LEFT JOIN OOT2103 O3 WITH (NOLOCK) ON O3.RelatedToID = M.ProjectID
									LEFT JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = O2.DepartmentID
									LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.AssignedToUserID
									INNER JOIN #PermissionOOT2190 T1 ON T1.Value IN (M.AssignedToUserID, M.CreateUserID,
																						O1.LeaderID, A2.ContactPerson, O3.UserID, O1.CreateUserID)
							' + @sWhere1 + ' '


	SET @sSQL = @sSQL + N'
		SELECT M.APK, M.DivisionID, M.MilestoneID, M.MilestoneName, M.PriorityID, M.StatusID
		, M.TimeRequest, M.DeadlineRequest, M.ProjectID, M.AssignedToUserID, M.CreateDate
		, A1.FullName AS AssignedToUserName
		, O1.ProjectName AS ProjectName
		, C1.Description AS PriorityName
		, C2.Description AS TypeOfMilestone
		, O2.StatusName AS StatusName
		, O2.Color
		INTO #TempOOT2190
		FROM OOT2190 M 
			INNER JOIN #FilterMilestoneAPK T1 ON T1.APK = M.APK
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.AssignedToUserID
			LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = M.ProjectID
			LEFT JOIN OOT1040 O2 WITH (NOLOCK) ON M.StatusID = O2.StatusID
			LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON M.PriorityID = C1.ID AND C1.CodeMaster = N''CRMT00000006''
			LEFT JOIN OOT0099 C2 WITH (NOLOCK) ON C2.ID = M.TypeOfMilestone AND C2.CodeMaster = N''OOF2190.TypeOfMilestone''

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempOOT2190
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , M.APK
			  , M.DivisionID
			  , M.MilestoneID
			  , M.MilestoneName
			  ,	M.PriorityID
			  , M.StatusID
			  , M.TimeRequest
			  , M.DeadlineRequest
			  , M.ProjectID
			  , M.AssignedToUserID
			  , M.CreateDate
			  , M.AssignedToUserName
			  , M.ProjectName
			  , M.StatusName
			  , M.PriorityName
			  , M.TypeOfMilestone
			  , M.Color
		FROM #TempOOT2190 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQLPermission + @sSQL)
	--PRINT(@sSQLPermission + @sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
