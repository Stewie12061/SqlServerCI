IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2270]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2270]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load grid danh mục Quản lý file (User)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 27/01/2021 by Tấn Lộc
----Modified on 15/05/2023 by Anh Đô: Fix lỗi "Conversion failed when converting from a character string to uniqueidentifier."

CREATE PROCEDURE [dbo].[OOP2270]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @FileName NVARCHAR(250),
	 @CreateUserID NVARCHAR (250),
	 @IsCommon NVARCHAR(100), 
	 @Disabled NVARCHAR(100),
	 @ConditionFileUserManagement NVARCHAR(MAX),
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

	IF ISNULL(@FileName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.FileName, '''') LIKE N''%' + @FileName + '%'' '

	IF ISNULL(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.CreateUserID LIKE N''%' + @CreateUserID + '%'' OR A1.FullName LIKE N''%' + @CreateUserID + '%'') '


	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2270'') IS NOT NULL DROP TABLE #PermissionOOT2270
								
							SELECT Value
							INTO #PermissionOOT2270
							FROM STRINGSPLIT(''' + ISNULL(@ConditionFileUserManagement, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterFileUserAPK'') IS NOT NULL DROP TABLE #FilterFileUserAPK

							SELECT DISTINCT M.APK
							INTO #FilterFileUserAPK
							FROM OOT2270 M WITH (NOLOCK)
									LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
									LEFT JOIN CRMT00002_REL C1 WITH (NOLOCK) ON C1.RelatedToID = M.APK
									LEFT JOIN CRMT00002 C2 WITH (NOLOCK) ON C2.AttachID = C1.AttachID
									INNER JOIN #PermissionOOT2270 T1 ON T1.Value IN (M.CreateUserID)
							WHERE ' + @sWhere + ' '

	SET @sSQL = @sSQL + N'
		SELECT M.APK, M.DivisionID, M.FileID, M.FileName, M.CreateDate
			   , M.CreateUserID, A1.FullName AS CreateUserName, C2.APK AS FieldAPKCRMT00002
		INTO #TempOOT2270
		FROM OOT2270 M WITH (NOLOCK)
			INNER JOIN #FilterFileUserAPK T1 ON T1.APK = M.APK
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
			LEFT JOIN CRMT00002_REL C1 WITH (NOLOCK) ON C1.RelatedToID = CONVERT(VARCHAR(50), M.APK)
			LEFT JOIN CRMT00002 C2 WITH (NOLOCK) ON C2.AttachID = C1.AttachID
		WHERE  ' + @sWhere +   ' AND M.DivisionID = ''' + @DivisionID + ''' 
		AND ISNULL(M.DeleteFlg, 0) = 0 
			

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempOOT2270
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , M.APK
			  , M.DivisionID
			  , M.FileID
			  , M.FileName
			  , M.CreateDate
			  , M.CreateUserID
			  , M.CreateUserName
			  , M.FieldAPKCRMT00002
		FROM #TempOOT2270 M
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
