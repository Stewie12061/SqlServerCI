IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2240]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2240]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Load grid danh sách thuê bao
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 28/03/2022 by Hoài Bảo
----Modified on 26/04/2022 by Hoài Bảo - Bổ sung kiểm tra đơn vị dùng chung-- <Example>
/*	EXEC [CRMP2240] @DivisionID = N'DTI', @DivisionIDList = N'', @FromDate = N'2022-04-26 00:00:00', @ToDate = N'2022-04-26 00:00:00', @IsPeriod = 0, @PeriodList = N'', 					@SubscriberID = N'', @ServerName = N'', @URL_Web = N'', @URL_API = N'', @Subdomain = N'', @SourceName = N'', @CustomerName = N'', @StatusID = N'', 					@MemoryStorage = N'', @MaxUser = N'', @IsTrail = N'', @Disabled = N'', @ConditionSubscriberManagement = N'ASOFTADMIN,D11001,D16001,D21001,D26001,UNASSIGNED', @PageNumber = 1, @PageSize = 25
*/

CREATE PROCEDURE [dbo].[CRMP2240]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @SubscriberID NVARCHAR(250),
	 @ServerName NVARCHAR(250),
	 @URL_Web NVARCHAR(250),
	 @URL_API NVARCHAR(250),
	 @Subdomain NVARCHAR(250),
	 @SourceName NVARCHAR(250),
	 @CustomerName NVARCHAR(250),
	 @StatusID NVARCHAR(250),
	 @MemoryStorage NVARCHAR(250),
	 @MaxUser NVARCHAR(250),
	 @IsTrail NVARCHAR(100),
	 @Disabled NVARCHAR(100),
	 @ConditionSubscriberManagement VARCHAR(MAX),
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

	SET @OrderBy = 'C1.SubscriberID DESC'
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' C1.DivisionID IN (''@@@'',''' + @DivisionIDList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' C1.DivisionID IN (''@@@'',''' + @DivisionID + ''')'

	SET @sWhere = @sWhere + ' AND ISNULL(C1.DeleteFlg, 0) = 0'

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (C1.CreateDate >= ''' + @FromDateText + '''
											OR C1.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (C1.CreateDate <= ''' + @ToDateText + ''' 
											OR C1.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (C1.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(C1.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	IF ISNULL(@SubscriberID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.SubscriberID, '''') LIKE N''%' + @SubscriberID + '%'' '

	IF ISNULL(@ServerName, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(C1.ServerID, '''') LIKE N''%' + @ServerName + '%'' OR ISNULL(C2.ServerName, '''') LIKE N''%' + @ServerName + '%'') '

	IF ISNULL(@URL_Web, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.URL_Web, '''') LIKE N''%' + @URL_Web + '%'' '

	IF ISNULL(@URL_API, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.URL_API, '''') LIKE N''%' + @URL_API + '%'' '

	IF ISNULL(@Subdomain, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.Subdomain, '''') LIKE N''%' + @Subdomain + '%'' '

	IF ISNULL(@SourceName, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(C1.SourceID, '''') LIKE N''%' + @SourceName + '%'' OR ISNULL(C3.SourceName, '''') LIKE N''%' + @SourceName + '%'') '

	IF ISNULL(@CustomerName, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(C1.CustomerID, '''') LIKE N''%' + @CustomerName + '%'' OR ISNULL(C4.MemberName, '''') LIKE N''%' + @CustomerName + '%'') '

	IF ISNULL(@StatusID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.StatusID, '''') LIKE N''%' + @StatusID + '%'' '

	IF ISNULL(@MemoryStorage, '') != ''
		SET @sWhere = @sWhere + ' AND CONVERT(varchar(50), ISNULL(C1.MemoryStorage, 0)) LIKE N''%' + @MemoryStorage + '%'' '

	IF ISNULL(@MaxUser, '') != ''
		SET @sWhere = @sWhere + ' AND CONVERT(varchar(50), ISNULL(C1.MaxUser, 0)) LIKE N''%' + @MaxUser + '%'' '

	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.Disabled, '''') LIKE N''%' + @Disabled + '%'' '

	IF ISNULL(@IsTrail, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.IsTrail, '''') LIKE N''%' + @IsTrail + '%'' '

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionAT0014'') IS NOT NULL DROP TABLE #PermissionAT0014
								
							SELECT Value
							INTO #PermissionAT0014
							FROM STRINGSPLIT(''' + ISNULL(@ConditionSubscriberManagement, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterSubscriberManagementAPK'') IS NOT NULL DROP TABLE #FilterSubscriberManagementAPK

							SELECT DISTINCT C1.APK
							INTO #FilterSubscriberManagementAPK
							FROM AT0014 C1 WITH (NOLOCK)
										INNER JOIN #PermissionAT0014 T1 ON T1.Value IN (C1.CreateUserID)
							WHERE ' + @sWhere + ' '

	SET @sSQL = @sSQL + N'
		SELECT C1.APK, C1.DivisionID, C1.[Disabled], C1.[Description], C1.DisplayID as SubscriberID, C3.SourceName, C4.MemberName AS CustomerName
		, C2.ServerName, C1.Subdomain, C1.URL_Web, C1.URL_API, C1.EndDate, C5.[Description] AS StatusID, C1.MemoryStorage, C1.MaxUser, C1.IsTrial
		, C1.CreateDate AS CreateSubscriberDate, C1.CreateUserID, C1.LastModifyDate, C1.LastModifyUserID, C1.IsOfficial, C1.LeadID, C1.OpportunityID
		, A7.LeadName,  A8.OpportunityName
		INTO #TempAT0014
		FROM AT0014 C1 WITH (NOLOCK)
			INNER JOIN #FilterSubscriberManagementAPK T1 ON T1.APK = C1.APK
			LEFT JOIN AT0015 C2 WITH (NOLOCK) ON C2.ServerID = C1.ServerID
			LEFT JOIN CRMT2210 C3 WITH (NOLOCK) ON C3.SourceID = C1.SourceID
			LEFT JOIN POST0011 C4 WITH (NOLOCK) ON C4.MemberID = C1.CustomerID
			LEFT JOIN CRMT0099 C5 WITH (NOLOCK) ON C1.StatusID = C5.ID AND C5.CodeMaster = ''AT0014.StatusID''
			LEFT JOIN CRMT20301 A7 WITH (NOLOCK) ON A7.LeadID =  C1.LeadID
			LEFT JOIN CRMT20501 A8 WITH (NOLOCK) ON A8.OpportunityID =  C1.OpportunityID
		WHERE  ' + @sWhere +   ' AND C1.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND ISNULL(C1.DeleteFlg, 0) = 0

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempAT0014
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , C1.APK
			  , C1.DivisionID
			  , C1.[Disabled]
			  , C1.[Description]
			  , C1.SubscriberID
			  , C1.SourceName
			  , C1.CustomerName
			  , C1.ServerName
			  , C1.Subdomain
			  , C1.URL_Web AS UrlWeb
			  , C1.URL_API AS UrlAPI
			  , C1.EndDate
			  , C1.StatusID
			  , C1.MemoryStorage
			  , C1.MaxUser
			  , C1.IsTrial
			  , C1.CreateSubscriberDate
			  , C1.CreateUserID
			  , C1.LastModifyDate
			  , C1.LastModifyUserID
			  , C1.IsOfficial
			  , C1.LeadID
			  , C1.OpportunityID
			  , C1.LeadName
			  , C1.OpportunityName
		FROM #TempAT0014 C1
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
