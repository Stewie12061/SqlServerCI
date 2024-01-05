IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
--- Load form OOF2100 - Danh mục dự án/nhóm công việc
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thị Phượng ON 16/10/2017
-- Modified by : Truong lam on 22/07/2019
-- Modified by : Vĩnh Tâm on 08/08/2019 - Bổ sung phân quyền xem dự án
-- Modified by : Đình Hòa on 17/11/2020 - Xóa các column NetSales, CommissionCost, BonusSales(không sử dụng)
-- Modified by : Đoàn Duy on 25/01/2021 - Bổ xung điều kiện join để lấy được tên các trạng thái dùng chung
-- Modified by : Hoài Thanh on 06/01/2023 - Bổ xung điều kiện lọc kỳ lấy thêm ngày kết thúc EndDate
-- Modified by : Hoài Thanh on 10/01/2023: Bổ sung luồng load dữ liệu từ dashboard
-- Modified by : Hoài Thanh on 03/02/2023: Bổ sung thêm params @ProjectIDList
-- Modified by : Hoài Bảo on 07/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example>
/*
 EXEC OOP2100 'KY', '', '', '', '', '', '', '', '', '', '', 2, 'NV01', 1, 10
*/

CREATE PROCEDURE [dbo].[OOP2100]
(
	@DivisionID VARCHAR(50) = '',
	@DivisionIDList NVARCHAR(MAX) = '',
	@FromDate DATETIME = NULL,
	@ToDate DATETIME = NULL,
	@IsPeriod INT = 0,
	@PeriodList VARCHAR(MAX) = '',
	@ProjectID NVARCHAR(50) = '',
	@ProjectName NVARCHAR(250) = '',
	@ContractID NVARCHAR(50) = '',
	@LeaderID NVARCHAR(50) = '',
	@DepartmentID VARCHAR(MAX) = '',
	@StatusID VARCHAR(MAX) = '',
	@AssignedToUserID NVARCHAR(250) = '',
	@Mode INT = 2,
	@UserID VARCHAR(50) = '',
	@ConditionProjectID VARCHAR(MAX) = '',
	@PageNumber INT = 1,
	@PageSize INT = 25,
	@Type INT = 2, -- Type = 6: từ dashboard -> danh mục
	@ProjectType INT = 0, -- 1: dự án trễ - 2: dự án hoàn thành - 3: dự án theo tiến độ
	@ProjectIDList VARCHAR(MAX) = NULL,
	@RelAPK NVARCHAR(250) = '',
	@RelTable NVARCHAR(250) = ''
)
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX),
		@sWhere2 NVARCHAR(MAX) = '',
		@sWhereDashboard NVARCHAR(MAX) = '',
		@sJoin NVARCHAR(MAX) = '',
		@sSQLPermission NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
		
SET @sWhere = ''
SET @sWhere1 = ''
SET @sJoin = ''
SET @OrderBy = ' M.CreateDate DESC'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

-- Check Para DivisionIDList null then get DivisionID
IF ISNULL(@DivisionIDList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''') '
		SET @sWhereDashboard = @sWhereDashboard + ' M.DivisionID IN (''' + @DivisionIDList + ''') '
	END
ELSE
	SET @sWhere = @sWhere + ' (M.DivisionID = ''' + @DivisionID + ''') '

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.StartDate >= ''' + @FromDateText + '''
											OR M.EndDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.StartDate <= ''' + @ToDateText + ''' 
											OR M.EndDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.StartDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										OR M.EndDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND ((SELECT FORMAT(M.StartDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') or FORMAT(M.EndDate, ''MM/yyyy'') IN ( ''' + @PeriodList + '''))'
		SET @sWhereDashboard = @sWhereDashboard + ' AND ((SELECT FORMAT(M.StartDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') or FORMAT(M.EndDate, ''MM/yyyy'') IN ( ''' + @PeriodList + '''))'
	END

IF ISNULL(@ProjectID, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(M.ProjectID, '''') LIKE N''%' + @ProjectID + '%'' OR ISNULL(M.ProjectName, '''') LIKE N''%' + @ProjectID + '%'') '

IF ISNULL(@ProjectName, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.ProjectName, '''') LIKE N''%' + @ProjectName + '%'' '
	
IF ISNULL(@ContractID, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(M.ContractID, '''') LIKE N''%' + @ContractID + '%'' OR ISNULL(B.ContractNo, '''') LIKE N''%' + @ContractID + '%'') '

IF ISNULL(@LeaderID, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(M.LeaderID, '''') LIKE N''%' + @LeaderID + '%'' OR ISNULL(D.FullName, '''') LIKE N''%' + @LeaderID + '%'') '

IF ISNULL(@StatusID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND ISNULL(M.StatusID, '''') IN (''' + @StatusID + ''') '
		SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.StatusID, '''') IN (''' + @StatusID + ''') '
	END

IF ISNULL(@DepartmentID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(O1.DepartmentID, '''') IN (''' + @DepartmentID + ''') '

IF ISNULL(@AssignedToUserID, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(O2.UserID, '''') LIKE N''%' + @AssignedToUserID + '%'' OR ISNULL(A2.FullName, '''') LIKE N''%' + @AssignedToUserID + '%'') '

IF @Type = 6
	BEGIN
		IF ISNULL(@ProjectIDList, '') != ''
			SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.ProjectID, '''') IN (''' + @ProjectIDList + ''') '

		IF @ProjectType = 1
			SET @sWhereDashboard = @sWhereDashboard + ' AND M.EndDate < GetDate() and M.StatusID NOT IN (''TTDA0006'', ''TTDA0003'', ''TTDA0010'')'
		ELSE IF @ProjectType = 2
			SET @sWhereDashboard = @sWhereDashboard + ' AND M.StatusID = ''TTDA0003'' '
		ELSE IF @ProjectType = 3
            BEGIN
                SET @sJoin = 'LEFT JOIN OOT2110 O WITH (NOLOCK) ON M.ProjectID = O.ProjectID'
                SET @sWhereDashboard = @sWhereDashboard + ' AND O.StatusID IN (''TTCV0003'', ''TTCV0002'') '
            END

		SET @sWhere2 = @sWhere2 + 'WHERE ' + @sWhereDashboard + ''
	END
ELSE --Type = 2
BEGIN
	IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
	BEGIN
		SET @sJoin = 
		CASE
			WHEN @RelTable = 'OOT2110' THEN 'LEFT JOIN ' +@RelTable+ ' E WITH (NOLOCK) ON E.APKMaster = M.APK'
			WHEN @RelTable = 'OOT0088' THEN 'LEFT JOIN ' +@RelTable+ ' E WITH (NOLOCK) ON E.APKParent = M.APK'
			WHEN @RelTable = 'OOT2160' THEN 'LEFT JOIN ' +@RelTable+ ' E WITH (NOLOCK) ON E.ProjectID = M.ProjectID'
			WHEN @RelTable = 'OOT2190' THEN 'LEFT JOIN ' +@RelTable+ ' E WITH (NOLOCK) ON E.ProjectID = M.ProjectID'
			WHEN @RelTable = 'CRMT20501' THEN 'LEFT JOIN ' +@RelTable+ ' E WITH (NOLOCK) ON E.OpportunityID = M.OpportunityID'
			ELSE @sJoin
		END

		SET @sWhere2 = 
		CASE
			WHEN @RelTable = 'OOT2110' THEN 'WHERE M.DivisionID = ''' + @DivisionID + ''' AND E.APK = ''' + @RelAPK + ''' AND ISNULL(M.DeleteFlg, 0) = 0'
			WHEN @RelTable = 'OOT0088' THEN 'WHERE M.DivisionID = ''' + @DivisionID + ''' AND E.APKChild = ''' + @RelAPK + ''' AND ISNULL(M.DeleteFlg, 0) = 0'
			WHEN @RelTable = 'OOT2160' THEN 'WHERE M.DivisionID = ''' + @DivisionID + ''' AND E.APK = ''' + @RelAPK + ''' AND ISNULL(M.DeleteFlg, 0) = 0'
			WHEN @RelTable = 'OOT2190' THEN 'WHERE M.DivisionID = ''' + @DivisionID + ''' AND E.APK = ''' + @RelAPK + ''' AND ISNULL(M.DeleteFlg, 0) = 0'
			WHEN @RelTable = 'CRMT20501' THEN 'WHERE M.DivisionID = ''' + @DivisionID + ''' AND E.APK = ''' + @RelAPK + ''' AND ISNULL(M.DeleteFlg, 0) = 0'
			ELSE 'WHERE ' + @sWhere + ''
		END
	END
	ELSE
		SET @sWhere2 = @sWhere2 + 'WHERE ' + @sWhere + ''
END

-- Dạng Kanban
IF @Mode = 1
BEGIN
	SET @sSQL = N'SELECT M.APK, M.DivisionID, M.ProjectID, M.ProjectName, M.StatusID, F.StatusName, F.Color, M.StartDate, M.EndDate
					, M.LeaderID, D.FullName AS LeaderName, D.Image01ID, A.SumHours, A.TotalWork, M.ContractID
					, B.ContractNo, B.ContractName, M.RelatedToTypeID, STUFF(ISNULL((SELECT '', '' + x.DepartmentID
				FROM OOT2101 x WITH (NOLOCK)
					LEFT JOIN AT1102 c WITH (NOLOCK) ON c.DepartmentID = x.DepartmentID
				WHERE x.RelatedToID = CONVERT(VARCHAR(50), M.APK) AND x.RelatedToTypeID = M.RelatedToTypeID
				GROUP BY x.DepartmentID, C.DepartmentName, X.RelatedToTypeID
				ORDER BY x.DepartmentID
				FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX) ''), ''''), 1, 1, '''') AS DepartmentID
				, STUFF(ISNULL((SELECT '', '' + C.DepartmentName
				FROM OOT2101 x WITH (NOLOCK)
					LEFT JOIN AT1102 c WITH (NOLOCK) ON c.DepartmentID = x.DepartmentID
				WHERE x.RelatedToID = CONVERT(VARCHAR(50), M.APK) AND x.RelatedToTypeID = M.RelatedToTypeID
				GROUP BY X.DepartmentID, C.DepartmentName, X.RelatedToTypeID
				ORDER BY x.DepartmentID
				FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX) ''), ''''), 1, 1, '''') AS DepartmentName
				, STUFF(ISNULL((SELECT '', '' + x.UserID FROM AT1103_REL x WITH (NOLOCK)
				LEFT JOIN AT1103 c WITH (NOLOCK) ON c.EmployeeID = x.UserID
				WHERE x.RelatedToID = CONVERT(VARCHAR(50), M.APK) AND x.RelatedToTypeID = M.RelatedToTypeID
				GROUP BY UserID, FullName, RelatedToTypeID
				ORDER BY x.UserID
				FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX) ''), ''''), 1, 1, '''') AS AssignedToUserID
				, STUFF(ISNULL((SELECT '', '' + C.FullName FROM AT1103_REL x WITH (NOLOCK)
				LEFT JOIN AT1103 c WITH (NOLOCK) ON c.EmployeeID = x.UserID
				WHERE x.RelatedToID = CONVERT(VARCHAR(50), M.APK) AND x.RelatedToTypeID = M.RelatedToTypeID
				GROUP BY UserID, FullName, RelatedToTypeID
				ORDER BY x.UserID
				FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX) ''), ''''), 1, 1, '''') AS AssignedToUserName
				INTO #TempOOT2100
				FROM OOT2100 M WITH (NOLOCK)
					LEFT JOIN AT1020 B WITH (NOLOCK) ON M.DivisionID = B.DivisionID AND M.ContractID = B.ContractID
					LEFT JOIN OOT1040 F WITH (NOLOCK) ON M.StatusID = F.StatusID
					LEFT JOIN AT1103 D WITH (NOLOCK) ON D.EmployeeID = M.LeaderID
					LEFT JOIN (SELECT A.DivisionID, A.ProjectID, SUM(A.PlanTime) AS SumHours, COUNT(WorkID) AS TotalWork FROM OOT2110 A WITH (NOLOCK)
				GROUP BY A.DivisionID, A.ProjectID) A ON A.DivisionID = M.DivisionID AND A.ProjectID = M.ProjectID
				WHERE ' + @sWhere + '

				SELECT A.TotalRow, M.APK, M.DivisionID, M.ProjectID, M.ProjectName, M.StatusID, M.StatusName, M.Color, M.StartDate, M.EndDate, M.LeaderID, M.LeaderName, M.Image01ID
				, M.ContractID, M.ContractNo, M.ContractName, M.RelatedToTypeID
				, M.SumHours, M.TotalWork, M.AssignedToUserID, M.AssignedToUserName FROM #TempOOT2100 M
				LEFT JOIN (SELECT DivisionID, StatusID, COUNT(StatusID) AS TotalRow FROM #TempOOT2100 GROUP BY StatusID, DivisionID) A ON A.DivisionID = M.DivisionID AND A.StatusID = M.StatusID
				WHERE 1 = 1 ' + @sWhere1 + '
				ORDER BY M.StatusID '
	EXEC (@sSQL)
	PRINT (@sSQL)
END

-- Dạng List
IF @Mode = 2
BEGIN
	
	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2100'') IS NOT NULL DROP TABLE #PermissionOOT2100
								
							SELECT Value
							INTO #PermissionOOT2100
							FROM STRINGSPLIT(''' + ISNULL(@ConditionProjectID, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterProjectAPK'') IS NOT NULL DROP TABLE #FilterProjectAPK

							SELECT DISTINCT M.APK
							INTO #FilterProjectAPK
							FROM OOT2100 M WITH (NOLOCK)
								LEFT JOIN OOT2101 O1 WITH (NOLOCK) ON O1.RelatedToID = M.ProjectID
								LEFT JOIN OOT2103 O2 WITH (NOLOCK) ON O2.RelatedToID = M.ProjectID
								LEFT JOIN AT1102 A1 WITH (NOLOCK) ON A1.DepartmentID = O1.DepartmentID
								LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = O2.UserID
								LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = A1.ContactPerson
								INNER JOIN #PermissionOOT2100 T1 ON T1.Value IN (M.LeaderID, M.CreateUserID, O2.UserID, A1.ContactPerson)
								LEFT JOIN AT1020 B WITH (NOLOCK) ON M.DivisionID = B.DivisionID AND M.ContractID = B.ContractID
								LEFT JOIN AT1103 D WITH (NOLOCK) ON D.EmployeeID = M.LeaderID
								' + @sJoin + '
							' + @sWhere2 + '
					'

	SET @sSQL = N' SELECT M.APK, M.DivisionID, M.ProjectID, M.ProjectName, M.ProjectType
					, C.Description AS ProjectTypeName, M.StartDate, M.EndDate, M.CheckingDate
					, M.LeaderID, D.FullName AS LeaderName
					, M.ContractID, B.ContractNo, B.ContractName, M.StatusID, F.StatusName
					, STUFF((
						SELECT '','' + A1.DepartmentName
						FROM OOT2101 O1 WITH (NOLOCK)
							LEFT JOIN AT1102 A1 WITH (NOLOCK) ON A1.DepartmentID = O1.DepartmentID
						WHERE O1.RelatedToID = M.ProjectID
						FOR XML PATH('''')
						), 1, 1, '''') AS DepartmentName
					, STUFF((
						SELECT '','' + A1.FullName
						FROM OOT2103 O1 WITH (NOLOCK)
							LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O1.UserID
						WHERE O1.RelatedToID = M.ProjectID
						FOR XML PATH('''')
						), 1, 1, '''') AS AssignedToUserName
					---, M.NetSales
					---, M.CommissionCost
					, M.GuestCost
					---, M.BonusSales
					, M.CreateDate
					, M.LastModifyDate
					, O1.Color
				INTO #TempOOT2100
				
				FROM OOT2100 M WITH (NOLOCK)
					INNER JOIN #FilterProjectAPK T1 ON M.APK = T1.APK
					LEFT JOIN OOT1040 F WITH (NOLOCK) ON F.DivisionID IN (M.DivisionID, ''@@@'') AND M.StatusID = F.StatusID
					LEFT JOIN AT1020 B WITH (NOLOCK) ON M.DivisionID = B.DivisionID AND M.ContractID = B.ContractID
					LEFT JOIN AT0099 C WITH (NOLOCK) ON C.ID = M.ProjectType AND C.CodeMaster = ''AT00000046''
					LEFT JOIN AT1103 D WITH (NOLOCK) ON D.EmployeeID = M.LeaderID
					LEFT JOIN OOT1040 O1 WITH (NOLOCK) ON O1.StatusID = M.StatusID

				DECLARE @count INT
				SELECT @count = COUNT(ProjectID) FROM #TempOOT2100

				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
					, M.APK, M.DivisionID, M.ProjectID, M.ProjectName, M.ProjectType, M.ProjectTypeName, M.DepartmentName
					, M.StartDate, M.EndDate, M.CheckingDate, M.LeaderID, M.LeaderName, M.ContractNo, M.ContractName AS ContractID
					, M.StatusID, M.StatusName, M.AssignedToUserName, M.Color
				FROM #TempOOT2100 M
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQLPermission + @sSQL)
	PRINT(@sSQLPermission + @sSQL)
END

-- Dạng Gantt
IF @Mode = 3
BEGIN
	SET @sSQL = N'SELECT M.APK, M.DivisionID, M.ProjectID, M.ProjectName, M.StatusID, F.StatusName, F.Color, M.StartDate, M.EndDate
				, STUFF(ISNULL((SELECT '', '' + x.DepartmentID
				FROM OOT2101 x WITH (NOLOCK)
				LEFT JOIN AT1102 c WITH (NOLOCK) ON c.DepartmentID = x.DepartmentID
				WHERE x.RelatedToID = CONVERT(VARCHAR(50), M.APK) AND x.RelatedToTypeID = M.RelatedToTypeID
				GROUP BY x.DepartmentID, C.DepartmentName, X.RelatedToTypeID
				ORDER BY x.DepartmentID
				FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX) ''), ''''), 1, 1, '''') AS DepartmentID
				, STUFF(ISNULL((SELECT '', '' + C.DepartmentName
				FROM OOT2101 x WITH (NOLOCK)
				LEFT JOIN AT1102 c WITH (NOLOCK) ON c.DepartmentID = x.DepartmentID
				WHERE x.RelatedToID = CONVERT(VARCHAR(50), M.APK) AND x.RelatedToTypeID = M.RelatedToTypeID
				GROUP BY X.DepartmentID, C.DepartmentName, X.RelatedToTypeID
				ORDER BY x.DepartmentID
				FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX) ''), ''''), 1, 1, '''') AS DepartmentName
				, STUFF(ISNULL((SELECT '', '' + x.UserID FROM AT1103_REL x WITH (NOLOCK)
				LEFT JOIN AT1103 c WITH (NOLOCK) ON c.EmployeeID = x.UserID
				WHERE x.RelatedToID = CONVERT(VARCHAR(50), M.APK) AND x.RelatedToTypeID = M.RelatedToTypeID
				GROUP BY UserID, FullName, RelatedToTypeID
				ORDER BY x.UserID
				FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX) ''), ''''), 1, 1, '''') AS AssignedToUserID
				, STUFF(ISNULL((SELECT '', '' + C.FullName FROM AT1103_REL x WITH (NOLOCK)
				LEFT JOIN AT1103 c WITH (NOLOCK) ON c.EmployeeID = x.UserID
				WHERE x.RelatedToID = CONVERT(VARCHAR(50), M.APK) AND x.RelatedToTypeID = M.RelatedToTypeID
				GROUP BY UserID, FullName, RelatedToTypeID
				ORDER BY x.UserID
				FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX) ''), ''''), 1, 1, '''') AS AssignedToUserName
				INTO #TempOOT2100
				FROM OOT2100 M WITH (NOLOCK)
				LEFT JOIN OOT1040 F WITH (NOLOCK) ON M.StatusID = F.StatusID
				WHERE ' + @sWhere + '

			SELECT M.APK, M.DivisionID, M.ProjectID, M.ProjectName, M.StatusID, M.StatusName, M.Color, M.StartDate, M.EndDate
				, M.AssignedToUserID, M.AssignedToUserName FROM #TempOOT2100 M
				WHERE 1 = 1 ' + @sWhere1 + '
				ORDER BY M.StatusID '
	--PRINT (@sSQL)
	EXEC (@sSQL)
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
