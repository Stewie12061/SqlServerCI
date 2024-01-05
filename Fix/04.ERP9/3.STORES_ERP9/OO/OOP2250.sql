IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2250]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2250]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load grid danh mục Quản lý thư mục (public)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 21/01/2021 by Tấn Lộc

CREATE PROCEDURE [dbo].[OOP2250]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @FolderName NVARCHAR(250),
	 @UserGroup NVARCHAR(250),
	 @CreateUserID NVARCHAR (250),
	 @IsCommon NVARCHAR(100), 
	 @Disabled NVARCHAR(100),
	 @ConditionFolderPublicManagement VARCHAR(MAX),
	 @UserID VARCHAR(50), 
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


	SET @OrderBy = 'M.CreateDate DESC'
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'


	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionID + ''')'

	SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg, 0) = 0'

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CreateDate >= ''' + @FromDateText + '''
											OR M.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CreateDate <= ''' + @ToDateText + ''' 
											OR M.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	IF ISNULL(@FolderName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.FolderName, '''') LIKE N''%' + @FolderName + '%'' '

	IF ISNULL(@UserGroup, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.UserGroup, '''') LIKE N''%' + @UserGroup + '%'' '

	IF ISNULL(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.CreateUserID LIKE N''%' + @CreateUserID + '%'' OR A1.FullName LIKE N''%' + @CreateUserID + '%'') '


	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2250'') IS NOT NULL DROP TABLE #PermissionOOT2250
								
						SELECT Value
						INTO #PermissionOOT2250
						FROM STRINGSPLIT(''' + ISNULL(@ConditionFolderPublicManagement, '') + ''', '','')

						IF OBJECT_ID(''tempdb..#FilterFolderAPK'') IS NOT NULL DROP TABLE #FilterFolderAPK

						SELECT DISTINCT M.APK
						INTO #FilterFolderAPK
						FROM OOT2250 M WITH (NOLOCK)
								LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
								LEFT JOIN AT1401 A2 WITH (NOLOCK) ON A2.GroupID = M.UserGroup AND A2.DivisionID = M.DivisionID
								LEFT JOIN OOT0088 O1 WITH (NOLOCK) ON O1.APKParent = M.APK
								LEFT JOIN AT1402 A3 WITH (NOLOCK) ON A3.GroupID = O1.BusinessChild AND A3.UserID = '''+@UserID+''' AND A3.DivisionID = M.DivisionID
								INNER JOIN #PermissionOOT2250 T1 ON T1.Value IN (M.CreateUserID, A3.UserID)
						WHERE ' + @sWhere + ' '

	SET @sSQL = @sSQL + N'
		SELECT M.APK, M.DivisionID, M.FolderID, M.FolderName
			   , M.ParentNode, M.UserGroup, M.CreateDate
			   , M.CreateUserID, A1.FullName AS CreateUserName, M.UserGroup AS FieldUserGroup
			   , STUFF((SELECT '','' + '' '' + C2.GroupName
						FROM OOT0088 C1
							LEFT JOIN AT1401 C2 WITH (NOLOCK) ON C2.GroupID = C1.BusinessChild AND M.DivisionID = C2.DivisionID
						WHERE C1.APKParent = M.APK
				FOR XML PATH('''')), 1, 1, '''') AS UserGroupName
		INTO #TempOOT2250
		FROM OOT2250 M WITH (NOLOCK)
			INNER JOIN #FilterFolderAPK T1 ON T1.APK = M.APK
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
			LEFT JOIN AT1401 A2 WITH (NOLOCK) ON A2.GroupID = M.UserGroup AND A2.DivisionID = M.DivisionID
		WHERE  ' + @sWhere +   ' AND M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0 
			

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempOOT2250
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , M.APK
			  , M.DivisionID
			  , M.FolderID
			  , M.FolderName
			  , M.ParentNode
			  , M.UserGroup
			  , M.UserGroupName
			  , M.CreateDate
			  , M.CreateUserID
			  , M.CreateUserName
		FROM #TempOOT2250 M
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
