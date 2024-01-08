IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2130]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2130]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Delete master và detail định mức dự án
-- <Param>
----
-- <Return>
----
-- <Reference>

-- <History>
----Create on 09/08/2019 by Đình Ly

CREATE PROCEDURE [dbo].[OOP2130]
(
	@DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(MAX),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsPeriod INT,
	@PeriodList VARCHAR(MAX),
	@AssessUserName NVARCHAR(250),
	@AssignedToUserID NVARCHAR(250),
	@TaskID VARCHAR(50),
	@TaskName NVARCHAR(250),
	@TaskTypeID VARCHAR(50),
	@StatusID VARCHAR(50),
	@UserID VARCHAR(50),
	@ConditionAssessTask VARCHAR(MAX),
	@PageNumber INT,
	@PageSize INT
)

AS
BEGIN
	DECLARE @sSQL1 NVARCHAR (MAX),
			@sSQL2 NVARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@OrderBy NVARCHAR(500),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20)

	SET @OrderBy = 'O.AssessOrder, O.TargetsGroupID '
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(10), @ToDate, 111) + ' 23:59:59'

	-- Check Param DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' O.DivisionID IN (''' + @DivisionIDList + ''')'
	ELSE
		SET @sWhere = @sWhere + ' O.DivisionID = ''' + @DivisionID + ''''
	
	-- Lọc các phiếu cần đánh giá của user đang đăng nhập
	SET @sWhere = @sWhere + ' AND ISNULL(O.AssessUserID, '''') IN (''' + @ConditionAssessTask + ''')'

	-- Check Param FromDate và ToDate
IF @IsPeriod = 0
BEGIN
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') != '')
	BEGIN
		SET @sWhere = @sWhere + ' AND (O1.ActualStartDate <= ''' + @ToDateText + '''
									OR O1.ActualEndDate <= ''' + @ToDateText + ''' ) '
	END
	ELSE IF (ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') = '')
	BEGIN
		SET @sWhere = @sWhere + ' AND (O1.ActualStartDate >= ''' + @FromDateText + '''
									OR O1.ActualEndDate >= ''' + @FromDateText + ''' ) '
	END
	ELSE IF (ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
	BEGIN
		SET @sWhere = @sWhere + ' AND (O1.ActualStartDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
									OR O1.ActualEndDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''' ) '
	END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(O1.ActualStartDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	IF ISNULL(@TaskID, '') != ''
		SET @sWhere = @sWhere + ' AND O.TaskID LIKE N''%' + @TaskID + '%''';
		
	IF ISNULL(@TaskName, '') != ''
		SET @sWhere = @sWhere + ' AND O1.TaskName LIKE N''%' + @TaskName + '%''';

	IF ISNULL(@AssignedToUserID, '') != ''
		SET @sWhere = @sWhere + ' AND A1.FullName LIKE N''%' + @AssignedToUserID + '%'' '

	IF ISNULL(@StatusID,'') != ''
		SET @sWhere = @sWhere + ' AND O.StatusID LIKE N''%' + @StatusID + '%'' '

	IF ISNULL(@TaskTypeID,'') != ''
		SET @sWhere = @sWhere + ' AND O1.TaskTypeID LIKE N''%' + @TaskTypeID + '%'' '
	
	IF ISNULL(@AssessUserName, '') != ''
		SET @sWhere = @sWhere + ' AND (A2.FullName LIKE N''%' + @AssessUserName + '%'' OR O.AssessUserID LIKE N''%' + @AssessUserName + '%'') '

	SET @sSQL1 = N'
			SELECT T2.APKMaster,
				MaxConfirmed,
				MinRequiredNotConfirmed,
				MaxNotConfirm,
				MaxReject,
				CASE
					WHEN ISNULL(MaxReject, 0) > 0
						THEN MaxReject
					WHEN ISNULL(MinRequiredNotConfirmed, 1) >= ISNULL(MaxConfirmed, 1)
						THEN ISNULL(MinRequiredNotConfirmed, 1)
					WHEN ISNULL(MaxNotConfirm, 0) > 0
						THEN MaxNotConfirm
					ELSE ISNULL(MaxConfirmed, 1)
				END AS Level
			INTO #OOT2130Temp
			FROM
			(
				SELECT APKMaster, MAX(AssessOrder) AS Level, ''MaxConfirmed'' AS Type
				FROM OOT2130 WITH (NOLOCK)
				WHERE StatusID = 1
				GROUP BY APKMaster
				UNION ALL
				SELECT APKMaster, MIN(AssessOrder) AS Level, ''MinRequiredNotConfirmed'' AS Type
				FROM OOT2130 WITH (NOLOCK)
				WHERE StatusID = 0 AND AssessRequired = 1
				GROUP BY APKMaster
				UNION ALL
				SELECT APKMaster, MAX(AssessOrder) AS Level, ''MaxNotConfirm'' AS Type
				FROM OOT2130 WITH (NOLOCK)
				WHERE StatusID = 0
				GROUP BY APKMaster
				UNION ALL
				SELECT APKMaster, MAX(AssessOrder) AS Level, ''MaxReject'' AS Type
				FROM OOT2130 WITH (NOLOCK)
				WHERE StatusID = 2
				GROUP BY APKMaster
			) AS T1
			PIVOT
			(
				SUM(Level)
				FOR Type IN (MaxConfirmed, MinRequiredNotConfirmed, MaxNotConfirm, MaxReject)
			) AS T2'

	SET @sSQL2 = N'
			SELECT O.APKMaster, O.APK, O.DivisionID, O.TaskID, O1.TaskName, O.AssessUserID, O.AssessOrder
				, O1.PlanStartDate, O1.PlanEndDate, O1.ActualStartDate, O1.ActualEndDate, O3.Description AS TaskTypeID
				, A1.FullName AS AssignedToUserID, O.TargetsGroupID, K1.TargetsGroupName, O2.Description AS StatusID
				, A2.FullName AS AssessUserName
			INTO #TempOOT2130
			FROM OOT2130 O WITH (NOLOCK)
				INNER JOIN #OOT2130Temp O4 ON O.APKMaster = O4.APKMaster AND ISNULL(O.AssessOrder, 1) <= O4.Level
				LEFT JOIN OOT2110 O1 WITH (NOLOCK) ON O.TaskID = O1.TaskID AND ISNULL(O1.DeleteFlg, 0) = 0 AND O1.StatusID IN (''TTCV0003'', ''TTCV0005'')
				LEFT JOIN OOT0099 O2 WITH (NOLOCK) ON O.StatusID = O2.ID AND O2.CodeMaster = ''OOF2130.StatusID'' AND ISNULL(O2.Disabled, 0) = 0
				LEFT JOIN OOT0099 O3 WITH (NOLOCK) ON O1.TaskTypeID = O3.ID AND O3.CodeMaster = ''OOF1060.TaskType'' AND ISNULL(O3.Disabled, 0) = 0
				LEFT JOIN AT1103 A1 WITH (NOLOCK) ON O1.AssignedToUserID = A1.EmployeeID AND ISNULL(A1.Disabled, 0) = 0
				LEFT JOIN KPIT10101 K1 WITH (NOLOCK) ON O.TargetsGroupID = K1.TargetsGroupID AND ISNULL(K1.Disabled, 0) = 0
				LEFT JOIN AT1103 A2 WITH (NOLOCK) ON O.AssessUserID = A2.EmployeeID AND ISNULL(A2.Disabled, 0) = 0
			WHERE ' + @sWhere + '

			DECLARE @count INT
			SELECT @count = COUNT(*) FROM #TempOOT2130

			SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
				, O.APKMaster, O.APK, O.DivisionID, O.TaskID, O.TaskName, O.AssessUserID, O.AssessUserName, O.AssessOrder
				, O.PlanStartDate, O.PlanEndDate, O.ActualStartDate, O.ActualEndDate, O.TaskTypeID
				, O.AssignedToUserID, O.TargetsGroupID, O.TargetsGroupName, O.StatusID
			FROM #TempOOT2130 O
			ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL1 + @sSQL2)
	--PRINT (@sSQL1 + @sSQL2)
END








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
