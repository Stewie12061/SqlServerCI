IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2340]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2340]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load grid danh mục Quản lý văn bản / Văn bản đến
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
--
-- <History>
---- Created  on 10/05/2022 by Văn Tài
---- Modified on 10/05/2022 by Văn Tài  - Bổ sung điều kiện phân quyền xem Quản lý văn bản.
---- Modified on 01/06/2022 by Văn Tài  - Xử lý điều kiện phân quyền dữ liệu.
---- Modified on 23/06/2022 by Văn Tài  - Xử lý điều kiện phân quyền dữ liệu: Người theo dõi.
---- Modified on 13/07/2022 by Văn Tài  - Xử lý điều kiện phân quyền dữ liệu: Người theo dõi có APKMaster của Văn bản.
---- Modified on 08/07/2022 by Đức Tuyên- Bổ sung dữ liệu cho các trường.
---- Modified on 15/07/2022 by Đức Tuyên- Load danh sách theo ngày tạo văn bản lên hệ thống.
---- MEditted by: Nhật Quang , Date: 04/08/2022: Bổ sung thêm số lượng người theo dõi từ 20 lên 50.
---- Modified on 10/01/2023 by Hoài Thanh - Bổ sung luồng load dữ liệu từ dashboard.
---- Modified on 31/08/2023 by Thanh Lượng - [2023/08/TA/0176]: Customize bổ sung param tìm kiếm theo Summary (Trích yếu) cho CSG.
-- <Example> EXEC KPIP2030 @DivisionID = 'DTI', @DivisionIDList = '', @UserID = 'TANLOC', @PageNumber='1', @PageSize='25','VANTOAI',0,0

CREATE PROCEDURE [dbo].[OOP2340]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @ScreenID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @UserID VARCHAR(50), 
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @DocumentID NVARCHAR(250),
	 @DocumentTypeID NVARCHAR(250),	 
	 @Status VARCHAR(250),
	 @SignedStatus VARCHAR(250),	 
	 @ReceivedDate DATETIME = NULL,
	 @SentDate	DATETIME = NULL,
	 @DocumentMode VARCHAR(MAX) = NULL,
	 @ConditionDocumentManagement  VARCHAR(MAX) = NULL,
	 @DocumentNumberInto VARCHAR(50)= NULL,
	 @Type INT = 2, -- Type = 6: từ dashboard -> danh mục
	 @EmployeeIDList VARCHAR(MAX) = NULL,
	 @Summary NVARCHAR(MAX) = NULL
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
			@sSQL01 NVARCHAR (MAX) = N'',
			@sSQL02 NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@sWhere1 NVARCHAR(MAX) = '',
			@sWhereDashboard VARCHAR(MAX) = '',
			@sSQLPermission NVARCHAR(MAX) = '',
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20),
			@sJoin VARCHAR(MAX) = ''

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

	-- Từ ngày.
	IF @IsPeriod = 0
		BEGIN
			IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
				BEGIN
					SET @sWhere = @sWhere + ' AND 
					(
						M.CreateDate >= ''' + @FromDateText + '''
					)'
				END
			ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
				BEGIN
					SET @sWhere = @sWhere + ' AND (
						M.CreateDate <= ''' + @ToDateText + ''')'
				END
			ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
				BEGIN
					SET @sWhere = @sWhere + ' AND (
					M.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
				END
		END
	ELSE 
	-- Chọn kỳ
	IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (SELECT FORMAT(ISNULL(M.ReceivedDate,  M.SentDate), ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
			SET @sWhereDashboard = @sWhereDashboard + ' AND (SELECT FORMAT(ISNULL(M.ReceivedDate, M.SentDate), ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
		END

	IF ISNULL(@DocumentMode, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND M.DocumentMode IN ( ''' + @DocumentMode + ''') '
			SET @sWhereDashboard = @sWhereDashboard + ' AND M.DocumentMode IN ( ''' + @DocumentMode + ''')'
		END

	IF ISNULL(@DocumentTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND M.DocumentTypeID IN ( ''' + @DocumentTypeID + ''') '

	IF ISNULL(@DocumentID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.DocumentID, '''') LIKE N''%' + @DocumentID + '%'' '

	IF ISNULL(@DocumentNumberInto, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.DocumentNumberInto, '''') LIKE N''%' + @DocumentNumberInto + '%'' '

	IF ISNULL(@ReceivedDate, '') != ''
		SET @sWhere = @sWhere + ' AND M.ReceivedDate >= ' + CONVERT(NVARCHAR(20), @ReceivedDate, 111)

	IF ISNULL(@SentDate, '') != ''
		SET @sWhere = @sWhere + ' AND M.SentDate >= ' + CONVERT(NVARCHAR(20), @SentDate, 111)

	IF ISNULL(@Status, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND ISNULL(M.Status, 0) IN (''' + @Status + ''') '
		SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.Status, 0) IN (''' + @Status + ''') '
	END

	IF ISNULL(@SignedStatus, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SignedStatus, 1) IN ( ''' + @SignedStatus + ''') '

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	IF ISNULL(@EmployeeIDList, '') != ''
		SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.AssignedToUserID, '''') IN ( ''' + @EmployeeIDList + ''') '

	IF ISNULL(@Summary, '') != ''
	BEGIN
		IF ISNULL(@Summary, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Summary, '''') LIKE N''%' + @Summary + '%'' '
	END

	IF @Type = 6
		SET @sWhere1 = 'WHERE  ' + @sWhereDashboard + ' '
	ELSE
		SET @sWhere1 = 'WHERE  ' + @sWhere + ' '

	IF (ISNULL(@ConditionDocumentManagement, '') != '')
		BEGIN
			SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2340'') IS NOT NULL DROP TABLE #PermissionOOT2340
								
								SELECT UserID Value
								INTO #PermissionOOT2340
								FROM AT1405
								WHERE 
								UserID IN (''' + ISNULL(@ConditionDocumentManagement, '') + ''')

								SELECT DISTINCT M.APK
								INTO #FilterIssuesAPK
								FROM OOT2340 M WITH (NOLOCK)
								LEFT JOIN #PermissionOOT2340 T1 ON M.AssignedToUserID = T1.Value 
																		OR M.CreateUserID = T1.Value
																		OR M.DecidedToUserID = T1.Value
								LEFT JOIN OOT2341 OT41 WITH (NOLOCK) ON OT41.DivisionID = M.DivisionID 
																		AND OT41.DocumentID = M.DocumentID
																		AND OT41.FollowerID = ''' + @UserID + '''
								LEFT JOIN OOT9020 OT92 WITH (NOLOCK) ON OT92.DivisionID = M.DivisionID
																		AND ''' + @UserID + '''
																			IN
																			(
																				FollowerID01
																				, FollowerID02
																				, FollowerID03
																				, FollowerID04
																				, FollowerID05
																				, FollowerID06
																				, FollowerID07
																				, FollowerID08
																				, FollowerID09
																				, FollowerID10
																				, FollowerID11
																				, FollowerID12
																				, FollowerID13
																				, FollowerID14
																				, FollowerID15
																				, FollowerID16
																				, FollowerID17
																				, FollowerID18
																				, FollowerID19
																				, FollowerID20
																				, FollowerID21
																				, FollowerID22
																				, FollowerID23
																				, FollowerID24
																				, FollowerID25
																				, FollowerID26
																				, FollowerID27
																				, FollowerID28
																				, FollowerID29
																				, FollowerID30
																				, FollowerID31
																				, FollowerID32
																				, FollowerID33
																				, FollowerID34
																				, FollowerID35
																				, FollowerID36
																				, FollowerID37
																				, FollowerID38
																				, FollowerID39
																				, FollowerID40
																				, FollowerID41
																				, FollowerID42
																				, FollowerID43
																				, FollowerID44
																				, FollowerID45
																				, FollowerID46
																				, FollowerID47
																				, FollowerID48
																				, FollowerID49
																				, FollowerID50
																			)
																		AND OT92.APKMaster = M.APK

								'+@sWhere1+' 
								AND (
										OT41.APK IS NOT NULL
										OR
										OT92.APK IS NOT NULL
										OR
										ISNULL(T1.Value, '''')  <> ''''
									)
								AND ISNULL(M.DeleteFlg, 0) = 0'
		
			SET @sJoin = 'INNER JOIN #FilterIssuesAPK T1 ON CONVERT(VARCHAR(50), T1.APK) = CONVERT(VARCHAR(50), M.APK)'
		END
	ELSE
		BEGIN
			SET @sSQLPermission = N'
								SELECT '''' AS APK
								INTO #FilterIssuesAPK
								'
		END

	SET @sSQL = @sSQL + N' SELECT
								    M.APK
								  , M.APKMaster_9000
								  , M.DivisionID
								  , M.TranYear
								  , M.TranMonth
								  , M.DocumentID
								  , M.DocumentNumberInto
								  , M.DocumentName
								  , M.DocumentMode
								  , M.UseDocumentTypeName
								  , M.DocumentTypeID
								  , M.IsInternal
								  , M.Status
								  , M.SignedStatus
								  , M.ComposePlace
								  , M.PublishPlace
								  , CASE WHEN (M.DocumentMode = ''VBDEN'') 
										 THEN M.ReceivedDate
										 ELSE M.SentDate
										END
										AS ReceivedDate
								  ,  CASE WHEN (M.DocumentMode = ''VBDEN'') 
										 THEN M.SentPlace
										 ELSE M.ReceivedPlace
										END
										AS ReceivedPlace
								 , CASE WHEN (M.DocumentMode = ''VBDEN'') 
										 THEN M.ReceivedDate
										 ELSE M.SentDate
										END
										AS SentDate
								  ,  CASE WHEN (M.DocumentMode = ''VBDEN'') 
										 THEN M.SentPlace
										 ELSE M.ReceivedPlace
										END
										AS SentPlace
								  , M.DocumentSignDate
								  , M.UseSignerName
								  , M.UseSignerDutyName
								  , M.UseSignerAuthority
								  , M.OutOfDate
								  , M.Summary
								  , M.AssignedToUserID
								  , M.DecidedToUserID
								  , M.HardStoreDepartmentID
								  , M.DeleteFlg
								  , M.CreateUserID
								  , M.CreateDate
								  , M.LastModifyUserID
								  , M.LastModifyDate
								  , OT90.Description AS DocumentTypeName
								  , OT92.Description AS StatusName
								  , OT91.Description AS SignedStatusName								  
								  , CONCAT(M.AssignedToUserID, '' - '', A1.FullName) AS AssignedToUserName
								  , CONCAT(M.DecidedToUserID, '' - '' , A2.FullName) AS DecidedToUserName
		INTO #TempOOT2340
		FROM OOT2340 M WITH (NOLOCK)
			' + @sJoin + '
			LEFT JOIN OOT0099 OT90 WITH (NOLOCK) ON OT90.CodeMaster = N''OOF2340.DocumentType'' AND OT90.ID = M.DocumentTypeID
			LEFT JOIN OOT0099 OT91 WITH (NOLOCK) ON OT91.CodeMaster = N''OOF2340.SignedStatus'' AND OT91.ID = M.SignedStatus
			LEFT JOIN OOT0099 OT92 WITH (NOLOCK) ON OT92.CodeMaster = N''Status'' AND OT92.ID = M.Status
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.AssignedToUserID
			LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = M.DecidedToUserID
		'+@sWhere1+' 
	'
 SET @sSQL02 = N'
		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempOOT2340
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			, M.APK
			, M.APKMaster_9000
			, M.DivisionID
			, M.TranYear
			, M.TranMonth
			, M.DocumentID
			, M.DocumentNumberInto
			, M.DocumentName
			, M.DocumentMode
			, M.UseDocumentTypeName
			, M.DocumentTypeID
			, M.DocumentTypeName
			, M.Status
			, M.StatusName
			, M.SignedStatus
			, M.SignedStatusName
			, M.ReceivedDate
			, M.ReceivedPlace
			, M.SentDate
			, M.SentPlace
			, M.DocumentSignDate
			, M.UseSignerName
			, M.UseSignerDutyName
			, M.UseSignerAuthority
			, M.OutOfDate
			, M.Summary
			, M.AssignedToUserID
			, M.AssignedToUserName
			, M.DecidedToUserID
			, M.HardStoreDepartmentID
			, M.DeleteFlg
			, M.CreateUserID
			, M.CreateDate
			, M.LastModifyUserID
			, M.LastModifyDate
		FROM #TempOOT2340 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY 
		'
		
	--PRINT(@sSQLPermission)
	--PRINT (@sSQL)
	--PRINT (@sSQL02)
	EXEC (@sSQLPermission + @sSQL + @sSQL02)
	PRINT (@sSQLPermission + @sSQL + @sSQL02)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
