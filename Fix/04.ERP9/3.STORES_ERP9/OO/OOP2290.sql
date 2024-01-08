IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2290]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2290]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---<summary>
--- Load dữ liệu master màn hình Danh mục chỉ tiêu/công việc
---<history>
--- Created by Anh Đô on 27/06/2023
--- Modified by Anh Đô on 06/07/2023: Select thêm cột StatusName, Color; Cập nhật điều kiện lọc
--- Modified by Trung Hiếu on 28/07/2023: Select thêm cột StatusID.
----Modified by: Phương Thảo on 10/04/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược

CREATE PROC OOP2290
(
	  @DivisionID VARCHAR(50) = '',
	  @DivisionIDList NVARCHAR(MAX) = '',
	  @FromDate DATETIME = NULL,
	  @ToDate DATETIME = NULL,
	  @IsPeriod INT = 0,
	  @PeriodList VARCHAR(MAX) = '',
	  @TargetTaskID NVARCHAR(250) = '',
	  @TargetTaskName NVARCHAR(500) = '',
	  @TypeID NVARCHAR(250) = '',
	  @StatusID NVARCHAR(250) = '',
	  @AssignedDepartmentID	NVARCHAR(250) = '',
	  @AssignedTeamID NVARCHAR(250) = '',
	  @RequestUserID NVARCHAR(250) = '',
	  @AssignedUserID NVARCHAR(250) = '',
	  @IsCommon NVARCHAR(100) = '',
	  @Disabled NVARCHAR(100) = '',
	  @ConditionTargetTaskManagement VARCHAR(MAX) = '',
	  @UserID VARCHAR(50) = '',
	  @PageNumber INT = 1,
	  @PageSize INT = 25,
	  @RelAPK NVARCHAR(250) = '',
	  @RelTable NVARCHAR(250) = ''
	 
)
AS
BEGIN
	DECLARE	  @sSql			NVARCHAR(MAX) = ''
			, @sSql1		NVARCHAR(MAX) = ''
			, @sSql2		NVARCHAR(MAX) = ''
			, @TotalRow     NVARCHAR(50) = N''
			, @sSQLPermission NVARCHAR(MAX)
			, @Join NVARCHAR(MAX) = ''
			, @sWhere		NVARCHAR(MAX) = ''
			, @OrderBy NVARCHAR(MAX) = N''
			, @FromDateText NVARCHAR(20)
			, @ToDateText NVARCHAR(20)

    SET @OrderBy = 'M.CreateDate DESC'
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

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
				SET @sWhere = @sWhere + ' AND (M.BeginDate >= ''' + @FromDateText + '''
												OR M.EndDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (M.BeginDate <= ''' + @ToDateText + ''' 
												OR M.EndDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (M.BeginDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
												OR M.EndDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
				END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.BeginDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
		END

	IF ISNULL(@TargetTaskID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TargetTaskID, '''') LIKE N''%' + @TargetTaskID + '%'' '

	IF ISNULL(@TargetTaskName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TargetTaskName, '''') LIKE N''%' + @TargetTaskName + '%'' '

	IF ISNULL(@TypeID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TypeID, '''') IN (''' + @TypeID + ''') '

	IF ISNULL(@StatusID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.StatusID, '''') IN (''' + @StatusID + ''') '
	
	IF ISNULL(@AssignedUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (A2.FullName LIKE N''%' + @AssignedUserID + '%'' OR M.AssignedUserID LIKE N''%' + @AssignedUserID + '%'') '

	IF ISNULL(@RequestUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (A3.FullName LIKE N''%' + @RequestUserID + '%'' OR M.RequestUserID LIKE N''%' + @RequestUserID + '%'') '
	
	IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
		BEGIN
		    SET @Join =
			CASE
			    WHEN @RelTable = 'OOT2110' THEN 'LEFT JOIN CRMT0088 C88 WITH (NOLOCK) ON M.APK = C88.APKParent'
				ELSE @Join
			END
		
			SET @sWhere = 
			CASE
				WHEN @RelTable = 'OOT2110' THEN ' M.DivisionID = ''' +@DivisionID+ ''' AND C88.APKChild = ''' +@RelAPK+ ''' AND M.DeleteFlg = 0'
				ELSE @sWhere
			END
		
		END


	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2290'') IS NOT NULL DROP TABLE #PermissionOOT2290
								
						SELECT Value
						INTO #PermissionOOT2290
						FROM STRINGSPLIT(''' + ISNULL(@ConditionTargetTaskManagement, '') + ''', '','')

						IF OBJECT_ID(''tempdb..#FilterTargetTaskAPK'') IS NOT NULL DROP TABLE #FilterTargetTaskAPK

						SELECT DISTINCT M.APK
						INTO #FilterTargetTaskAPK
						FROM OOT2290 M WITH (NOLOCK)
								LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = M.AssignedUserID AND A2.DivisionID IN (M.DivisionID, ''@@@'')
								LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = M.RequestUserID AND A3.DivisionID IN (M.DivisionID, ''@@@'')
								INNER JOIN #PermissionOOT2290 T1 ON T1.Value IN (M.CreateUserID, M.AssignedUserID, M.RequestUserID)
						' + @Join + '
						WHERE ' + @sWhere + ' '

	SET @sSql = N'
		SELECT
			  M.APK
			, M.DivisionID
			, A1.DivisionName
			, M.TypeID
			, O1.Description AS TypeName
			, M.TargetTaskID
			, M.TargetTaskName
			, M.PriorityID
			, C1.Description AS PriorityName
			, M.BeginDate
			, M.EndDate
			, M.RequestUserID
			, A3.FullName AS RequestUserName
			, M.AssignedUserID
			, A2.FullName AS AssignedUserName
			, M.Description
			, M.CreateDate
			, O2.StatusName
			, O2.Color
			, M.StatusID
		INTO #OOF2290_Master
		FROM OOT2290 M WITH (NOLOCK)
		INNER JOIN #FilterTargetTaskAPK T1 ON T1.APK = M.APK
		LEFT JOIN AT1101 A1 WITH (NOLOCK) ON A1.DivisionID = M.DivisionID
		LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = M.AssignedUserID AND A2.DivisionID IN (M.DivisionID, ''@@@'')
		LEFT JOIN OOT0099 O1 WITH (NOLOCK) ON O1.CodeMaster = ''OOF2290.Type'' AND O1.ID = M.TypeID
		LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.CodeMaster = ''CRMT00000006'' AND C1.ID = M.PriorityID
		LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = M.RequestUserID AND A3.DivisionID IN (M.DivisionID, ''@@@'')
		LEFT JOIN OOT1040 O2 WITH (NOLOCK) ON O2.StatusID = M.StatusID
		' + @Join + '
		WHERE '+ @sWhere

	-- Lấy số lượng task đã hoàn thành của mỗi chỉ tiêu/công việc
	SET @sSql1 = N'
		SELECT
			  M.APKParent
			, COUNT(CASE WHEN O1.StatusID = ''TTCV0003'' THEN 1 ELSE NULL END) AS DoneTask
			, CONVERT(DECIMAL, COUNT(*)) AS TotalTask
		INTO #OOF2290_DoneTasks
		FROM CRMT0088 M WITH (NOLOCK)
		INNER JOIN OOT2110 O1 WITH (NOLOCK) ON O1.APK = M.APKChild
		WHERE M.TableBusinessParent =''OOT2290'' AND M.TableBusinessChild = ''OOT2110'' AND M.APKParent IN (SELECT APK FROM #OOF2290_Master)
		GROUP BY M.APKParent
	'

	SET @sSql2 = N'
		SELECT
			  ROW_NUMBER() OVER (ORDER BY M.CreateDate DESC) AS RowNum
			, (SELECT COUNT(*) FROM #OOF2290_Master) AS TotalRow
			, M.*
			, CASE WHEN DT.TotalTask != 0 THEN DT.DoneTask / DT.TotalTask * 100 ELSE 0 END AS Progress
		FROM #OOF2290_Master M WITH (NOLOCK)
		LEFT JOIN #OOF2290_DoneTasks DT WITH (NOLOCK) ON DT.APKParent = M.APK
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	
	EXEC(@sSQLPermission + @sSql + @sSql1 + @sSql2)
	PRINT(@sSQLPermission + @sSql + @sSql1 + @sSql2)
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
