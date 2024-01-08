IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load grid danh mục Quản lý vấn đề
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 02/10/2020 by Tấn Lộc
/* <Example>
	EXEC SP0012 @DivisionID = 'MK', @DivisionIDList = '', @UserID = '', @UserName = '', @Type = '', @Status = '', @IPLogin = '', @PageNumber='1', @PageSize='25'
 */

CREATE PROCEDURE [dbo].[SP0012]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @UserID VARCHAR(50),
	 @UserName NVARCHAR(250),
	 @Type NVARCHAR(250),
	 @Status NVARCHAR(250),
	 @IPLogin NVARCHAR(250),
	 @LanguageID VARCHAR(10) = 'vi-VN',
	 @PageNumber INT,
	 @PageSize INT
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20)

	SET @OrderBy = ' A1.ServerTime DESC'
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' ISNULL(A1.DivisionID, '''') IN (''' + @DivisionIDList + ''', '''')'
	ELSE 
		SET @sWhere = @sWhere + ' ISNULL(A1.DivisionID, '''') IN (''' + @DivisionID + ''', '''')'

	-- Check Para FromDate và ToDate

	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
	BEGIN
		SET @sWhere = @sWhere + ' AND (A1.ServerTime >= ''' + @FromDateText + '''
										OR A1.ClientTime >= ''' + @FromDateText + ''')'
	END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
	BEGIN
		SET @sWhere = @sWhere + ' AND (A1.ServerTime <= ''' + @ToDateText + ''' 
										OR A1.ClientTime <= ''' + @ToDateText + ''')'
	END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
	BEGIN
		SET @sWhere = @sWhere + ' AND (A1.ServerTime BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
								OR A1.ClientTime BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
	END
	
	IF ISNULL(@UserID, '') != ''
		SET @sWhere = @sWhere + ' AND A1.UserID LIKE N''%' + @UserID + '%'' '
	
	IF ISNULL(@UserName, '') != ''
		SET @sWhere = @sWhere + ' AND A1.UserName LIKE N''%' + @UserName + '%'' '

	IF ISNULL(@Type,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A1.Type, '''') IN (''' + @Type + ''') '

	IF ISNULL(@Status,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A1.Status, '''') IN (''' + @Status + ''') '

	IF ISNULL(@IPLogin, '') != ''
		SET @sWhere = @sWhere + ' AND (A1.IPLogin LIKE N''%' + @IPLogin + '%'' OR (''localhost'' LIKE N''%' + @IPLogin + '%'' AND A1.IPLogin = ''::1'')) '

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQL = @sSQL + N'
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, COUNT(*) OVER () AS TotalRow
			, A1.APK
			, A1.APKMaster
			, ISNULL(A1.DivisionID, '''') AS DivisionID
			, A1.UserID
			, A1.UserName
			-- 0: Login, 1: Logout, 2: ForcedLogout
			, CASE A1.Type
				WHEN 0 THEN A3.Name
				WHEN 1 THEN A4.Name
				WHEN 2 THEN A5.Name
			  END AS Type
			, A1.ServerTime
			, A1.ClientTime
			-- 0: Thất bại, 1: Thành công
			, IIF(A1.Status = 1, A6.Name, A7.Name) AS Status
			, IIF(A1.IPLogin != ''::1'', A1.IPLogin, ''localhost'') AS IPLogin
			, A1.BrowserName
			, A1.BrowserVersion
			, A1.Note
		FROM AT0013 A1 WITH (NOLOCK)
			LEFT JOIN AT0012 A2 WITH (NOLOCK) ON A1.APKMaster = A2.APK
			LEFT JOIN A00001 A3 WITH (NOLOCK) ON A3.LanguageID = ''' + @LanguageID + ''' AND A3.ID = ''A00.btnLogin''
			LEFT JOIN A00001 A4 WITH (NOLOCK) ON A4.LanguageID = ''' + @LanguageID + ''' AND A4.ID = ''A00.Logout''
			LEFT JOIN A00001 A5 WITH (NOLOCK) ON A5.LanguageID = ''' + @LanguageID + ''' AND A5.ID = ''A00.ForcedLogout''
			LEFT JOIN A00001 A6 WITH (NOLOCK) ON A6.LanguageID = ''' + @LanguageID + ''' AND A6.ID = ''A00.Success''
			LEFT JOIN A00001 A7 WITH (NOLOCK) ON A7.LanguageID = ''' + @LanguageID + ''' AND A7.ID = ''A00.Failure''
		WHERE ' + @sWhere +   '
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL)
	PRINT(@sSQL)

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
