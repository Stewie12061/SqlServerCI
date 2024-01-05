IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2150]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2150]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













-- <Summary>
---- Load dữ liệu cho grid màn hình đánh giá dự án 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
-- Create on 30/10/2019 by Đắc Luân
-- Updated on 14/11/2019 by Đình Ly

CREATE PROCEDURE OOP2150
(
	@DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(MAX),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsPeriod INT,
	@PeriodList VARCHAR(MAX),
	@ProjectID VARCHAR(25),
	@ProjectName NVARCHAR(250),
	@ProjectType VARCHAR(250),
	@LeaderID NVARCHAR(500),
	@StatusID VARCHAR(50),
	@UserID VARCHAR(50), 
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

	SET @ProjectType = CAST(@ProjectType AS INT)
	SET @OrderBy = 'O.AssessOrder, O.TargetsGroupID '
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(10), @ToDate, 111) + ' 00:00:00'

	 -- Check Param DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' O.DivisionID IN (''' + @DivisionIDList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' O.DivisionID IN (''' + @DivisionID + ''')'
	
	 -- Lọc các phiếu cần đánh giá của user đang đăng nhập
	SET @sWhere = @sWhere + ' AND ISNULL(O.AssessUserID, '''') = ''' + @UserID + ''''

	 -- Check Param FromDate và ToDate
IF @IsPeriod = 0
BEGIN
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') != '')
	BEGIN
		SET @sWhere = @sWhere + ' AND (O1.StartDate <= ''' + @ToDateText + '''
									OR O1.EndDate <= ''' + @ToDateText + ''' ) '
	END
	ELSE IF (ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') = '')
	BEGIN
		SET @sWhere = @sWhere + ' AND (O1.StartDate >= ''' + @FromDateText + '''
									OR O1.EndDate >= ''' + @FromDateText + ''' ) '
	END
	ELSE IF (ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
	BEGIN
		SET @sWhere = @sWhere + ' AND (O1.StartDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
									OR O1.EndDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''' ) '
	END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	-- Check param trưởng dự án
	IF ISNULL(@LeaderID, '') != ''
		SET @sWhere = @sWhere + ' AND A1.FullName LIKE N''%' + @LeaderID + '%''';

	-- Check param mã dự án
	IF ISNULL(@ProjectID, '') != ''
		SET @sWhere = @sWhere + ' AND O.ProjectID LIKE N''%' + @ProjectID + '%''';

	-- Check param tên dự án
	IF ISNULL(@ProjectName, '') != ''
		SET @sWhere = @sWhere + ' AND O1.ProjectName LIKE N''%' + @ProjectName + '%''';

	-- Check param loại dự án
	--IF ISNULL(@ProjectType,'') != ''
	--	SET @sWhere = @sWhere + ' AND O.ProjectType LIKE N''%' + @ProjectType + '%'' '
	
	-- Check param trạng thái đánh giá
	IF ISNULL(@StatusID,'') != ''
		SET @sWhere = @sWhere + ' AND O.StatusID LIKE N''%' + @StatusID + '%''';

	SET @sSQL1 = '
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
					ELSE ISNULL(MaxNotConfirm, 1)
				END AS Level
			INTO #OOT2150Temp
			FROM
			(
				SELECT APKMaster, MAX(AssessOrder) AS Level, ''MaxConfirmed'' AS Type
				FROM OOT2150 WITH (NOLOCK)
				WHERE StatusID = 1
				GROUP BY APKMaster
				UNION ALL
				SELECT APKMaster, MIN(AssessOrder) AS Level, ''MinRequiredNotConfirmed'' AS Type
				FROM OOT2150 WITH (NOLOCK)
				WHERE StatusID = 0 AND AssessRequired = 1
				GROUP BY APKMaster
				UNION ALL
				SELECT APKMaster, MAX(AssessOrder) AS Level, ''MaxNotConfirm'' AS Type
				FROM OOT2150 WITH (NOLOCK)
				WHERE StatusID = 0
				GROUP BY APKMaster
				UNION ALL
				SELECT APKMaster, MAX(AssessOrder) AS Level, ''MaxReject'' AS Type
				FROM OOT2150 WITH (NOLOCK)
				WHERE StatusID = 2
				GROUP BY APKMaster
			) AS T1
			PIVOT 
			(
				SUM(Level)
				FOR Type IN (MaxConfirmed, MinRequiredNotConfirmed, MaxNotConfirm, MaxReject)
			) AS T2'

	SET @sSQL2 = '
			SELECT O.APK
				 , O.DivisionID
				 , O.APKMaster
				 , O.ProjectID
				 , O1.ProjectName
				 , O.AssessUserID
				 , O.AssessOrder
				 , O3.Description AS ProjectType
				 , O1.StartDate
				 , O1.EndDate
				 , A1.FullName AS LeaderID
				 , O.TargetsGroupID
				 , K1.TargetsGroupName
				 , O2.Description as StatusID
			INTO #TempOOT2150
			FROM OOT2150 O WITH (NOLOCK)
				LEFT JOIN #OOT2150Temp O4 ON O.APKMaster = O4.APKMaster AND ISNULL(O.AssessOrder, 1) <= O4.Level
				LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O.ProjectID = O1.ProjectID AND ISNULL(O1.DeleteFlg, 0) = 0 --AND O1.StatusID IN (''TTDA0003'', ''TTDA0005'')
				LEFT JOIN OOT0099 O2 WITH (NOLOCK) ON O.StatusID = O2.ID AND O2.CodeMaster = ''OOF2130.StatusID'' AND ISNULL(O2.Disabled, 0) = 0
				LEFT JOIN OOT0099 O3 WITH (NOLOCK) ON O1.ProjectType = O3.ID AND O3.CodeMaster = ''A00.ProjectType'' AND ISNULL(O3.Disabled, 0) = 0
				LEFT JOIN AT1103 A1 WITH (NOLOCK) ON O.LeaderID = A1.EmployeeID AND ISNULL(A1.Disabled, 0) = 0
				LEFT JOIN KPIT10101 K1 WITH (NOLOCK) ON O.TargetsGroupID = K1.TargetsGroupID AND ISNULL(K1.Disabled, 0) = 0
			WHERE ' + @sWhere + '

			DECLARE @count INT
			SELECT @count = COUNT(*) FROM #TempOOT2150

			SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
				, O.APKMaster, O.APK
				, O.ProjectID
				, O.LeaderID
				, O.ProjectType
				, O.ProjectName
				, O.AssessUserID
				, O.AssessOrder
				, O.StartDate
				, O.EndDate
				, O.TargetsGroupID
				, O.TargetsGroupName
				, O.StatusID
			FROM #TempOOT2150 O
			ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	PRINT (@sSQL1 + @sSQL2)
	EXEC (@sSQL1 + @sSQL2)
END














GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
