IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2220]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2220]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Load grid danh sách Server
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 23/03/2022 by Hoài Bảo----Modified on 31/03/2022 by Hoài Bảo - Bổ sung load dữ liệu cột IsTrial----Modified on 26/04/2022 by Hoài Bảo - Bổ sung kiểm tra đơn vị dùng chung-- <Example>
/*	EXEC CRMP2220 @DivisionID=N'DTI',@DivisionIDList=N'',@FromDate='2022-03-31 00:00:00',@ToDate='2022-03-31 00:00:00',@IsPeriod=0,@PeriodList=N'',@ServerID=N'',@ServerName=N'',@ServerIP=N'',@MainAPIPort=N'',@MaximumRegister=N'',@Disabled=N'',@IsTrial=N'',@ConditionServerManagement=N'ASOFTADMIN'',''D11001'',''D36001'
*/

CREATE PROCEDURE [dbo].[CRMP2220]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @ServerID NVARCHAR(250),
	 @ServerName NVARCHAR(250),
	 @ServerIP VARCHAR(250),
	 @MainAPIPort VARCHAR(50),
	 @MaximumRegister VARCHAR(50),
	 @IsTrial NVARCHAR(100),
	 @Disabled NVARCHAR(100),
	 @ConditionServerManagement VARCHAR(MAX),
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

	SET @OrderBy = 'C1.CreateDate DESC'
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' C1.DivisionID IN (''' + @DivisionIDList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' C1.DivisionID IN (''' + @DivisionID + ''')'

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

	IF ISNULL(@ServerID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.ServerID, '''') LIKE N''%' + @ServerID + '%'' '

	IF ISNULL(@ServerName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.ServerName, '''') LIKE N''%' + @ServerName + '%'' '

	IF ISNULL(@ServerIP, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.ServerIP, '''') LIKE N''%' + @ServerIP + '%'' '

	IF ISNULL(@MainAPIPort, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.MainAPIPort, '''') LIKE N''%' + @MainAPIPort + '%'' '

	IF ISNULL(@MaximumRegister, '') != ''
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(50),C1.MaximumRegister) = ' + @MaximumRegister + ' '

	IF ISNULL(@IsTrial, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.IsTrial, '''') LIKE N''%' + @IsTrial + '%'' '

	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.Disabled, '''') LIKE N''%' + @Disabled + '%'' '

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionCRMT2220'') IS NOT NULL DROP TABLE #PermissionCRMT2220
								
							SELECT Value
							INTO #PermissionCRMT2220
							FROM STRINGSPLIT(''' + ISNULL(@ConditionServerManagement, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterServerManagementAPK'') IS NOT NULL DROP TABLE #FilterServerManagementAPK

							SELECT DISTINCT C1.APK
							INTO #FilterServerManagementAPK
							FROM AT0015 C1 WITH (NOLOCK)
										INNER JOIN #PermissionCRMT2220 T1 ON T1.Value IN (C1.CreateUserID)
							WHERE ' + @sWhere + ' '

	SET @sSQL = @sSQL + N'
		SELECT C1.APK, C1.DivisionID, C1.[Disabled], C1.IsTrial, C1.[Description], C1.ServerID, C1.ServerName, C1.ServerIP
		, C1.MainAPIPort, C1.MaximumRegister, C1.CreateDate, C1.CreateUserID, C1.LastModifyDate, C1.LastModifyUserID
		INTO #TempAT0015
		FROM AT0015 C1 WITH (NOLOCK)
		    INNER JOIN #FilterServerManagementAPK T1 ON T1.APK = C1.APK
		WHERE  ' + @sWhere +   ' AND C1.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND ISNULL(C1.DeleteFlg, 0) = 0

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempAT0015
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , C1.APK
			  , C1.DivisionID
			  , C1.[Disabled]
			  , C1.IsTrial
			  , C1.[Description]
			  , C1.ServerID
			  , C1.ServerName
			  , C1.ServerIP
			  , C1.MainAPIPort
			  , C1.MaximumRegister
			  , C1.CreateDate
			  , C1.CreateUserID
			  , C1.LastModifyDate
			  , C1.LastModifyUserID
		FROM #TempAT0015 C1
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
