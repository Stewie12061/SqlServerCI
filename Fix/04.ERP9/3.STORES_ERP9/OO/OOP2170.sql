IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2170]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2170]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load grid danh mục Yêu cầu hỗ trợ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 07/11/2019 by Tấn Lộc
----Edit by: Hoài Phong, Date: 22/03/2021 Bổ sung cột trạng thái chất lượng công việc
--- Modify by Hoài Thanh, Date 10/01/2023: Bổ sung luồng load dữ liệu từ dashboard
--- Modified by Hoài Bảo, Date 13/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example> EXEC KPIP2030 @DivisionID = 'DTI', @DivisionIDList = '', @UserID = 'TANLOC', @PageNumber='1', @PageSize='25','VANTOAI',0,0

CREATE PROCEDURE [dbo].[OOP2170]
( 
	 @DivisionID VARCHAR(50) = '',
	 @DivisionIDList NVARCHAR(MAX) = '',
	 @FromDate DATETIME = NULL,
	 @ToDate DATETIME = NULL,
	 @IsPeriod INT = 0,
	 @PeriodList VARCHAR(MAX) = '',
	 @SupportRequiredID NVARCHAR(250) = '',
	 @SupportRequiredName NVARCHAR(250) = '',
	 @AccountID NVARCHAR(250) = '',
	 @ContactID NVARCHAR(250) = '',
	 @AssignedToUserID NVARCHAR(250) = '',
	 @InventoryID NVARCHAR(250) = '',
	 @StatusID NVARCHAR(250) = '',
	 @ReleaseVerion NVARCHAR(250) = '',
	 @TypeOfRequest VARCHAR(50) = '',
	 @IsCommon NVARCHAR(100) = '', 
	 @Disabled NVARCHAR(100) = '',
	 @ConditionHelpDesk VARCHAR(MAX) = '',
	 @UserID VARCHAR(50) = '', 
	 @PageNumber INT = 1,
	 @PageSize INT = 25,
	 @Type INT = 2, -- Type = 6: từ dashboard -> danh mục
	 @IsLate INT = 0,-- 1: lấy dữ liệu yêu cầu hỗ trợ bị trễ
	 @EmployeeIDList NVARCHAR(MAX) = NULL,
	 @CustomerIDList NVARCHAR(MAX) = NULL,
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
			SET @sWhere = @sWhere + 'AND (M.TimeRequest BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										OR M.DeadlineRequest BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''')'
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
		SET @sWhereDashboard = @sWhereDashboard + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	IF ISNULL(@SupportRequiredID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SupportRequiredID, '''') LIKE N''%' + @SupportRequiredID + '%'' '

	IF ISNULL(@SupportRequiredName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SupportRequiredName, '''') LIKE N''%' + @SupportRequiredName + '%'' '

	IF ISNULL(@AccountID, '') != ''
		SET @sWhere = @sWhere + ' AND (C1.ObjectName LIKE N''%' + @AccountID + '%'' OR M.AccountID LIKE N''%' + @AccountID + '%'') '

	IF ISNULL(@ContactID, '') != ''
		SET @sWhere = @sWhere + ' AND (C2.ContactName LIKE N''%' + @ContactID + '%'' OR M.ContactID LIKE N''%' + @ContactID + '%'') '

	IF ISNULL(@AssignedToUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (C4.FullName LIKE N''%' + @AssignedToUserID + '%'' OR M.AssignedToUserID LIKE N''%' + @AssignedToUserID + '%'') '

	IF ISNULL(@InventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND (C3.InventoryName LIKE N''%' + @InventoryID + '%'' OR M.InventoryID LIKE N''%' + @InventoryID + '%'') '

	IF ISNULL(@StatusID,'') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND ISNULL(M.StatusID, '''') IN (''' + @StatusID + ''') '
		SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.StatusID, '''') IN (''' + @StatusID + ''') '
	END

	IF ISNULL(@ReleaseVerion, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ReleaseVerion, '''') LIKE N''%' + @ReleaseVerion + '%'' '

	IF ISNULL(@TypeOfRequest, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TypeOfRequest, '''') LIKE N''%' + @TypeOfRequest + '%'' '

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	IF @Type = 6
		BEGIN
			IF @IsLate = 1
				SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(O.SystemStatus,0) != 3 AND GETDATE() > M.DeadlineRequest AND (FORMAT(M.TimeRequest, ''MM/yyyy'') IN ( ''' + @PeriodList + ''') OR FORMAT(M.DeadlineRequest, ''MM/yyyy'') IN ( ''' + @PeriodList + '''))'
			
			IF ISNULL(@EmployeeIDList, '') != ''
				SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.AssignedToUserID, '''') IN (''' + @EmployeeIDList + ''') '

			IF ISNULL(@CustomerIDList, '') != ''
				SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.AccountID, '''') IN (''' + @CustomerIDList + ''') '

			SET @sWhere1 = ' WHERE ' + @sWhereDashboard + ' '
		END
	ELSE --Type = 2
	BEGIN
		IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
		BEGIN
			SET @sWhere1 = 
			CASE
				WHEN @RelTable = 'OOT2160' THEN 'LEFT JOIN ' +@RelTable+ ' C9 WITH (NOLOCK) ON C9.SupportRequiredID = M.SupportRequiredID 
											WHERE C9.APK = ''' +@RelAPK+ '''
											AND M.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') 
											AND ISNULL(M.DeleteFlg, 0) = 0'
				WHEN @RelTable = 'POST0011' THEN 'INNER JOIN ' +@RelTable+ ' C9 WITH (NOLOCK) ON C9.MemberID = M.AccountID AND M.DivisionID = C9.DivisionID
											WHERE C9.APK = ''' +@RelAPK+ '''
											AND M.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') 
											AND ISNULL(M.DeleteFlg, 0) = 0'
				WHEN @RelTable = 'CRMT10001' THEN 'INNER JOIN ' +@RelTable+ ' C9 WITH (NOLOCK) ON C9.ContactID = M.ContactID AND M.DivisionID = C9.DivisionID
											WHERE C9.APK = ''' +@RelAPK+ '''
											AND M.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') 
											AND ISNULL(M.DeleteFlg, 0) = 0'
				WHEN @RelTable = 'OOT2180' THEN 'INNER JOIN ' +@RelTable+ ' C9 WITH (NOLOCK) ON C9.RequestSupportID = M.SupportRequiredID
											WHERE C9.APK = ''' +@RelAPK+ '''
											AND M.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') 
											AND ISNULL(M.DeleteFlg, 0) = 0'
				ELSE ' WHERE ' + @sWhere + ' '
			END
		END
		ELSE
			SET @sWhere1 = ' WHERE ' + @sWhere + ' '
	END

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2170'') IS NOT NULL DROP TABLE #PermissionOOT2170
								
							SELECT Value
							INTO #PermissionOOT2170
							FROM STRINGSPLIT(''' + ISNULL(@ConditionHelpDesk, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterRequestAPK'') IS NOT NULL DROP TABLE #FilterRequestAPK

							SELECT DISTINCT M.APK
							INTO #FilterRequestAPK
							FROM OOT2170 M WITH (NOLOCK)
									LEFT JOIN AT1202 C1 WITH (NOLOCK) ON C1.ObjectID = M.AccountID AND M.DivisionID = C1.DivisionID	
									LEFT JOIN CRMT10001 C2 WITH (NOLOCK) ON C2.ContactID = M.ContactID AND M.DivisionID = C2.DivisionID
									LEFT JOIN AT1302 C3 WITH (NOLOCK) ON C3.InventoryID = M.InventoryID AND M.DivisionID = C3.DivisionID
									LEFT JOIN AT1103 C4 WITH (NOLOCK) ON C4.EmployeeID = M.AssignedToUserID AND M.DivisionID = C4.DivisionID
									INNER JOIN #PermissionOOT2170 T1 ON T1.Value IN (M.AssignedToUserID, M.CreateUserID)
									LEFT JOIN OOT1040 O On M.StatusID = O.StatusID
							' + @sWhere1 + ' 
						'


	SET @sSQL = @sSQL + N'
	SELECT M.APK, M.DivisionID, M.SupportRequiredID, M.SupportRequiredName, M.PriorityID, M.StatusID, M.TimeRequest, M.DeadlineRequest, M.ReleaseVerion, M.CreateDate
			, M.AccountID
			, M.ContactID
			, M.InventoryID
			, M.AssignedToUserID  
			, C1.ObjectName AS AccountName
			, C2.ContactName AS ContactName
			, C3.InventoryName AS InventoryName
			, C4.FullName AS AssignedToUserName
			, C5.StatusName AS StatusName
			, (CASE WHEN [dbo].GetStatusQualityOfWork(M.DeadlineRequest,M.ActualEndDate,'''',M.AccountID,C5.StatusName) = ''0'' THEN N''Ðạt'' 
					 WHEN [dbo].GetStatusQualityOfWork(M.DeadlineRequest,M.ActualEndDate,'''',M.AccountID,C5.StatusName) = ''1'' THEN N''Không đạt'' 
					 ELSE N''''END) AS StatusQualityOfWork
			, C6.Description AS PriorityName
			, C7.Description AS TypeOfRequest
			, C5.Color
		INTO #TempOOT2170
		FROM OOT2170 M WITH (NOLOCK)
		INNER JOIN #FilterRequestAPK T1 ON T1.APK = M.APK
		LEFT JOIN AT1202 C1 WITH (NOLOCK) ON C1.ObjectID = M.AccountID AND M.DivisionID = C1.DivisionID								-- Khách hàng
		LEFT JOIN CRMT10001 C2 WITH (NOLOCK) ON C2.ContactID = M.ContactID AND M.DivisionID = C2.DivisionID							-- Liên hệ
		LEFT JOIN AT1302 C3 WITH (NOLOCK) ON C3.InventoryID = M.InventoryID AND M.DivisionID = C3.DivisionID						-- Mặt hàng
		LEFT JOIN AT1103 C4 WITH (NOLOCK) ON C4.EmployeeID = M.AssignedToUserID	AND M.DivisionID = C4.DivisionID					-- nhân viên
		LEFT JOIN OOT1040 C5 WITH (NOLOCK) ON C5.StatusID = M.StatusID										-- Trạng thái 
		LEFT JOIN CRMT0099 C6 WITH (NOLOCK) ON M.PriorityID = C6.ID AND C6.CodeMaster = N''CRMT00000006''   -- Độ ưu tiên
		LEFT JOIN CRMT0099 C7 WiTH (NOLOCK) ON C7.ID = M.TypeOfRequest AND C7.CodeMaster = ''CRMF2160.TypeOfRequest''

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempOOT2170
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , M.APK
			  , M.DivisionID
			  , M.SupportRequiredID
			  , M.SupportRequiredName
			  , M.TypeOfRequest
			  ,	M.PriorityID
			  , M.StatusID
			  , M.TimeRequest
			  , M.DeadlineRequest
			  , M.ReleaseVerion
			  , M.CreateDate
			  , M.AccountID
			  , M.ContactID
			  , M.InventoryID
			  , M.AssignedToUserID
			  , M.AccountName
			  , M.ContactName
			  , M.InventoryName
			  , M.PriorityName
			  , M.AssignedToUserName
			  , M.StatusName
			  , M.StatusQualityOfWork
			  , M.PriorityName
			  , M.Color
		FROM #TempOOT2170 M
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
