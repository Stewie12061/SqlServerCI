IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2260]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2260]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load grid danh mục Quản lý file (public)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 21/01/2021 by Tấn Lộc
----Modified on 15/05/2023 by Anh Đô: Fix lỗi "Conversion failed when converting from a character string to uniqueidentifier."

CREATE PROCEDURE [dbo].[OOP2260]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @FileName NVARCHAR(250),
	 @FolderID NVARCHAR(250),
	 @APKMaster_OOT2250 NVARCHAR(250),
	 @CreateUserID NVARCHAR (250),
	 @IsCommon NVARCHAR(100), 
	 @Disabled NVARCHAR(100),
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

	SET @sSQL = @sSQL + N'
		SELECT M.APK, M.DivisionID, M.APKMaster_OOT2250, M.FolderID
			   , M.FileID, M.FileName, M.CreateDate
			   , M.CreateUserID, A1.FullName AS CreateUserName, C2.APK AS FieldAPKCRMT00002
		INTO #TempOOT2260
		FROM OOT2260 M WITH (NOLOCK)
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
			LEFT JOIN CRMT00002_REL C1 WITH (NOLOCK) ON C1.RelatedToID = CONVERT(VARCHAR(50), M.APK)
			LEFT JOIN CRMT00002 C2 WITH (NOLOCK) ON C2.AttachID = C1.AttachID
			LEFT JOIN OOT2250 O1 WITH (NOLOCK) ON O1.APK = M.APKMaster_OOT2250
		WHERE  ' + @sWhere +   ' AND M.DivisionID = ''' + @DivisionID + ''' 
		AND ISNULL(M.DeleteFlg, 0) = 0 
		AND CONVERT(NVARCHAR(250), O1.APK) = '''+@APKMaster_OOT2250+'''
		AND O1.FolderID = '''+@FolderID+'''
			

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempOOT2260
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , M.APK
			  , M.DivisionID
			  , M.APKMaster_OOT2250
			  , M.FolderID
			  , M.FileID
			  , M.FileName
			  , M.CreateDate
			  , M.CreateUserID
			  , M.CreateUserName
			  , M.FieldAPKCRMT00002
		FROM #TempOOT2260 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL)
	PRINT(@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
