IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2160]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2160]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load grid danh mục Quản lý vấn đề
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 25/10/2019 by Tấn Lộc
----Create on 21/03/2021 by  Hoài Phong  bố sung Trạng thái chất lượng công việc
----Modified by: Hoài Thanh on 10/01/2023: Bổ sung luồng load dữ liệu từ dashboard
----Modified by: Hoài Bảo on 07/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
----Modified by: Thu Hà on 08/11/2023: Bổ sung điều kiện lọc "chỉ tiêu/công việc" 
-- <Example> EXEC KPIP2030 @DivisionID = 'DTI', @DivisionIDList = '', @UserID = 'TANLOC', @PageNumber='1', @PageSize='25','VANTOAI',0,0

CREATE PROCEDURE [dbo].[OOP2160]
( 
	 @DivisionID VARCHAR(50) = '',
	 @DivisionIDList NVARCHAR(MAX) = '',
	 @FromDate DATETIME = NULL,
	 @ToDate DATETIME = NULL,
	 @IsPeriod INT = 0,
	 @PeriodList VARCHAR(MAX) = '',
	 @IssuesID NVARCHAR(250) = '',
	 @IssuesName NVARCHAR(250) = '',
	 @RequestID NVARCHAR(250) = '',
	 @StatusID NVARCHAR(250) = '',
	 @PriorityID NVARCHAR(250) = '',
	 @ReleaseVerion NVARCHAR(250) = '',
	 @ProjectID NVARCHAR(250) = '',
	 @TargetTaskName NVARCHAR(250) = '',
	 @TaskID NVARCHAR(250) = '',
	 @AssignedToUserID NVARCHAR(250) = '',
	 @SupportRequiredID VARCHAR(250) = '',
	 @TypeOfIssues VARCHAR(250) = '',
	 @IsCommon NVARCHAR(100) = '',
	 @Disabled NVARCHAR(100) = '',
	 @ConditionIssueManagement VARCHAR(MAX) = '',
	 @UserID VARCHAR(50) = '',
	 @PageNumber INT = 1,
	 @PageSize INT = 25,
	 @Type INT = 2, -- Type = 6: từ dashboard -> danh mục
	 @IssueType INT = 0, -- 1: vấn đề trễ, 2: vấn đề tồn đọng (dự án)
	 @DepartmentIDList VARCHAR(MAX) = NULL,
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
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

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

	IF ISNULL(@IssuesID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IssuesID, '''') LIKE N''%' + @IssuesID + '%'' '

	IF ISNULL(@IssuesName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IssuesName, '''') LIKE N''%' + @IssuesName + '%'' '

	IF ISNULL(@RequestID, '') != ''
		SET @sWhere = @sWhere + ' AND (C1.RequestSubject LIKE N''%' + @RequestID + '%'' OR M.RequestID LIKE N''%' + @RequestID + '%'') '

	IF ISNULL(@TaskID, '') != ''
		SET @sWhere = @sWhere + ' AND (C2.TaskName LIKE N''%' + @TaskID + '%'' OR M.TaskID LIKE N''%' + @TaskID + '%'') '

	IF ISNULL(@ProjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ProjectID, '''') LIKE N''%' + @ProjectID + '%'' '

	IF ISNULL(@TargetTaskName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C8.TargetTaskName, '''') LIKE N''%' + @TargetTaskName + '%'' '

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

	IF ISNULL(@TypeOfIssues,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TypeOfIssues, '''') IN (''' + @TypeOfIssues + ''') '

	IF ISNULL(@SupportRequiredID, '') != ''
		SET @sWhere = @sWhere + ' AND (C5.SupportRequiredName LIKE N''%' + @SupportRequiredID + '%'' OR M.SupportRequiredID LIKE N''%' + @SupportRequiredID + '%'') '
	
	IF @Type = 6
		BEGIN
			IF @IssueType = 1
				SET @sWhereDashboard = @sWhereDashboard + ' AND M.StatusID NOT IN(''TTIS0004'') AND M.DeadlineRequest < GETDATE()'
			ELSE IF @IssueType = 2
				SET @sWhereDashboard = @sWhereDashboard + ' AND M.StatusID NOT IN (''TTIS0004'',''TTIS0006'')'

			IF ISNULL(@DepartmentIDList, '') != ''
				SET @sWhereDashboard = @sWhereDashboard + ' AND A02.DepartmentName IS NOT NULL AND A02.DepartmentID IN ( ''' + @DepartmentIDList + ''')'

			IF ISNULL(@EmployeeIDList, '') != ''
				SET @sWhereDashboard = @sWhereDashboard + ' AND M.AssignedToUserID IN ( ''' + @EmployeeIDList + ''')'

			IF ISNULL(@ProjectIDList, '') != ''
				SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.ProjectID, '''') IN ( ''' + @ProjectIDList + ''')'

			SET @sWhere1 = 'WHERE  ' + @sWhereDashboard + ' '
		END
	ELSE --Type = 2
	BEGIN
		IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
		BEGIN
		  SET @sWhere1 = 
		  CASE
			WHEN @RelTable = 'OOT2110' THEN 'WHERE M.DivisionID = ''' + @DivisionID + ''' AND M.DeleteFlg = 0 AND C2.APK = ''' + @RelAPK + ''' '
			WHEN @RelTable = 'CRMT20801' THEN 'WHERE M.DivisionID = ''' + @DivisionID + ''' AND M.DeleteFlg = 0 AND C1.APK = ''' + @RelAPK + ''' '
			WHEN @RelTable = 'OOT0088' THEN 'LEFT JOIN ' + @RelTable + ' C7 WITH (NOLOCK) ON M.APK = C7.APKChild AND C7.TableBusinessChild = ''OOT2160''
									   WHERE M.DivisionID = ''' + @DivisionID + ''' AND M.DeleteFlg = 0 AND C7.APKParent = ''' + @RelAPK + ''' '
			WHEN @RelTable = 'OOT0098' THEN 'LEFT JOIN ' + @RelTable + ' C7 WITH (NOLOCK) ON M.APK = C7.APKObject AND C7.ObjectBusiness = ''OOT2160''
									   WHERE M.DivisionID = ''' + @DivisionID + ''' AND M.DeleteFlg = 0 AND C7.APKRel = ''' + @RelAPK + ''' '
			WHEN @RelTable = 'OOT2170' THEN 'LEFT JOIN ' +@RelTable + ' C7 WITH (NOLOCK) ON C7.SupportRequiredID = M.SupportRequiredID
									   WHERE M.DivisionID = ''' + @DivisionID + ''' AND M.DeleteFlg = 0 AND C7.APK = ''' + @RelAPK + ''' '
			ELSE 'WHERE  ' + @sWhere + ' '
		  END
		END
		ELSE
		  SET @sWhere1 = 'WHERE  ' + @sWhere + ' '
	END

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

		SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2160'') IS NOT NULL DROP TABLE #PermissionOOT2160
								
							SELECT Value
							INTO #PermissionOOT2160
							FROM STRINGSPLIT(''' + ISNULL(@ConditionIssueManagement, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterIssuesAPK'') IS NOT NULL DROP TABLE #FilterIssuesAPK

							SELECT DISTINCT M.APK
							INTO #FilterIssuesAPK
							FROM OOT2160 M WITH (NOLOCK)
								LEFT JOIN CRMT20801 C1 WITH (NOLOCK) ON M.RequestID = C1.RequestCustomerID
								LEFT JOIN OOT2290 C8 WITH (NOLOCK) ON C8.TargetTaskID = M.TargetTaskID
								LEFT JOIN OOT2110 C2 WITH (NOLOCK) ON M.TaskID = C2.TaskID
								LEFT JOIN OOT2100 C3 WITH (NOLOCK) ON C3.ProjectID = M.ProjectID AND M.TaskID IS NULL
								LEFT JOIN OOT2101 O1 WITH (NOLOCK) ON O1.RelatedToID = M.ProjectID
								LEFT JOIN OOT2103 O2 WITH (NOLOCK) ON O2.RelatedToID = M.ProjectID
								LEFT JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = O1.DepartmentID
								LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.AssignedToUserID
								LEFT JOIN OOT2170 C5 WITH (NOLOCK) ON C5.SupportRequiredID = M.SupportRequiredID
								LEFT JOIN CRMT0099 C6 WITH (NOLOCK) ON M.PriorityID = C6.ID AND C6.CodeMaster = N''CRMT00000006''
								LEFT JOIN AT1102 A02 WITH (NOLOCK) ON A02.DepartmentID = A1.DepartmentID
								INNER JOIN #PermissionOOT2160 T1 ON T1.Value IN (M.AssignedToUserID, M.CreateUserID,
																				C1.AssignedToUserID, C1.CreateUserID,
																				C2.AssignedToUserID, C2.SupportUserID, C2.ReviewerUserID, C2.CreateUserID,
																				C3.LeaderID, A2.ContactPerson, O2.UserID, C3.CreateUserID)
							' + @sWhere1 + ' 
						'

	SET @sSQL = @sSQL + N'
		SELECT M.APK, M.DivisionID, M.IssuesID, M.IssuesName, M.PriorityID, M.StatusID, M.RequestID,
					M.TimeRequest, M.DeadlineRequest, M.ProjectID, M.TaskID, C1.RequestSubject AS RequestName, M.AssignedToUserID, M.ReleaseVerion, M.CreateDate, M.SupportRequiredID
					,A1.FullName AS AssignedToUserName
					,C3.ProjectName AS ProjectName
					,M.TargetTaskID
					,C8.TargetTaskName AS TargetTaskName
					,TM13.StatusName
				    ,(CASE WHEN [dbo].GetStatusQualityOfWork(M.DeadlineRequest,M.ActualEndDate,'''',C5.AccountID,TM13.StatusName) = ''0'' THEN N''Đạt'' 
					 WHEN [dbo].GetStatusQualityOfWork(M.DeadlineRequest,M.ActualEndDate,'''',C5.AccountID,TM13.StatusName) = ''1'' THEN N''Không đạt'' 
					 ELSE N''''END) AS StatusQualityOfWork
					,A3.Description AS PriorityName
					, C2.TaskName AS TaskName
					, C4.Description AS TypeOfIssues
					, C5.SupportRequiredName AS SupportRequiredName
					, TM13.Color
					, M.TimeConfirm
		INTO #TempOOT2160
		FROM OOT2160 M WITH (NOLOCK)
			INNER JOIN #FilterIssuesAPK T1 ON T1.APK = M.APK
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.AssignedToUserID
			LEFT JOIN OOT2100 C3 WITH (NOLOCK) ON C3.ProjectID = M.ProjectID
			LEFT JOIN OOT2290 C8 WITH (NOLOCK) ON C8.TargetTaskID = M.TargetTaskID
			LEFT JOIN OOT1040 TM13 WITH (NOLOCK) ON M.StatusID = TM13.StatusID
			LEFT JOIN CRMT0099 A3 WITH (NOLOCK) ON M.PriorityID = A3.ID AND A3.CodeMaster = N''CRMT00000006''
			LEFT JOIN OOT2110 C2 WITH (NOLOCK) ON M.TaskID = C2.TaskID
			LEFT JOIN CRMT20801 C1 WITH (NOLOCK) ON C1.RequestCustomerID = M.RequestID
			LEFT JOIN OOT0099 C4 WITH (NOLOCK) ON C4.ID = M.TypeOfIssues AND C4.CodeMaster = N''OOF2160.TypeOfIssues''
			LEFT JOIN OOT2170 C5 WITH (NOLOCK) ON C5.SupportRequiredID = M.SupportRequiredID
			LEFT JOIN CRMT0099 C6 WITH (NOLOCK) ON M.PriorityID = C6.ID AND C6.CodeMaster = N''CRMT00000006''
			LEFT JOIN AT1102 A02 WITH (NOLOCK) ON A02.DepartmentID = A1.DepartmentID
		' + @sWhere1 +   '

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempOOT2160
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
				, M.APK
				, M.DivisionID
				, M.IssuesID
				, M.IssuesName
				,	M.PriorityID
				, M.StatusID
				, M.TimeRequest
				, M.DeadlineRequest
				, M.ProjectID
				, M.TargetTaskID
				, M.TargetTaskName
				, M.TaskID
				, M.RequestID
				, M.AssignedToUserID
				, M.ReleaseVerion
				, M.CreateDate
				, M.AssignedToUserName
				, M.ProjectName
				, M.StatusName
				, M.StatusQualityOfWork
				, M.PriorityName
				, M.TaskName
				, M.RequestName
				, M.TypeOfIssues
				, M.SupportRequiredName
				, M.Color
				, M.TimeConfirm
		FROM #TempOOT2160 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
		
	--PRINT(@sSQL)
	EXEC (@sSQLPermission + @sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
