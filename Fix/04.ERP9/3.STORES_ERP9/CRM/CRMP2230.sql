IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2230]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2230]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Load grid danh sách gói sản phẩm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 23/03/2022 by Hoài Bảo----Modified on 26/04/2022 by Hoài Bảo - Bổ sung kiểm tra đơn vị dùng chung-- <Example>
/*	EXEC [CRMP2230] @DivisionID = N'DTI', @DivisionIDList = N'', @FromDate = NULL, @ToDate = NULL, @IsPeriod = 0, @PeriodList = N'', @PackageID = N'', 					@PackageName = N'', @Disabled = N'', @ConditionPackageManagement = N'ASOFTADMIN,D41001,D41002,DKS001,T000010,UNASSIGNED', @PageNumber = 1, @PageSize = 25
*/

CREATE PROCEDURE [dbo].[CRMP2230]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @PackageID NVARCHAR(250),
	 @PackageName NVARCHAR(250),
	 @Disabled NVARCHAR(100),
	 @ConditionPackageManagement VARCHAR(MAX),
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

	IF ISNULL(@PackageID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.PackageID, '''') LIKE N''%' + @PackageID + '%'' '

	IF ISNULL(@PackageName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.ServerName, '''') LIKE N''%' + @PackageName + '%'' '

	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.Disabled, '''') LIKE N''%' + @Disabled + '%'' '

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionAT0016'') IS NOT NULL DROP TABLE #PermissionAT0016
								
							SELECT Value
							INTO #PermissionAT0016
							FROM STRINGSPLIT(''' + ISNULL(@ConditionPackageManagement, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterPackageManagementAPK'') IS NOT NULL DROP TABLE #FilterPackageManagementAPK

							SELECT DISTINCT C1.APK
							INTO #FilterPackageManagementAPK
							FROM AT0016 C1 WITH (NOLOCK)
										INNER JOIN #PermissionAT0016 T1 ON T1.Value IN (C1.CreateUserID)
							WHERE ' + @sWhere + ' '

	SET @sSQL = @sSQL + N'
		SELECT C1.APK, C1.DivisionID, C1.[Disabled], C1.[Description], C1.PackageID, C1.PackageName
		, C1.CreateDate, C1.CreateUserID, C1.LastModifyDate, C1.LastModifyUserID
		INTO #TempAT0016
		FROM AT0016 C1 WITH (NOLOCK)
		    INNER JOIN #FilterPackageManagementAPK T1 ON T1.APK = C1.APK
		WHERE  ' + @sWhere +   ' AND C1.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND ISNULL(C1.DeleteFlg, 0) = 0

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempAT0016
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , C1.APK
			  , C1.DivisionID
			  , C1.[Disabled]
			  , C1.[Description]
			  , C1.PackageID
			  , C1.PackageName
			  , C1.CreateDate
			  , C1.CreateUserID
			  , C1.LastModifyDate
			  , C1.LastModifyUserID
		FROM #TempAT0016 C1
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
