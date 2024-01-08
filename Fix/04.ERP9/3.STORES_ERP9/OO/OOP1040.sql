IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1040]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1040]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[OOP1040]
(
		@DivisionID VARCHAR(50), 
		@DivisionIDList NVARCHAR(MAX), 
		@StatusID VARCHAR(50), 
		@StatusName NVARCHAR(250), 
		@StatusType NVARCHAR(100), 
		@IsCommon NVARCHAR(100), 
		@Disabled NVARCHAR(100), 
		@UserID VARCHAR(50), 
		@PageNumber INT, 
		@PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX), 
		@OrderBy NVARCHAR(500)

SET @sWhere = ''
SET @OrderBy = ' M.DivisionID, M.StatusID, M.Orders '

-- Check Para DivisionIDList null then get DivisionID
IF ISNULL(@DivisionIDList, '')!= ''
	SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
ELSE
	SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionID + ''', ''@@@'') '

IF ISNULL(@StatusID, '')!= ''
	SET @sWhere = @sWhere + ' AND M.StatusID LIKE N''%' + @StatusID + '%'''

IF ISNULL(@Disabled, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, ''0'') LIKE N''%' + @Disabled + '%'' '

IF ISNULL(@IsCommon, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, ''0'') LIKE N''%' + @IsCommon + '%'' '

IF ISNULL(@StatusName, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.StatusName, '''') LIKE N''%' + @StatusName + '%'''

IF ISNULL(@StatusType, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.StatusType, '''') LIKE N''%' + @StatusType + '%'''

SET @sSQL = 	'SELECT M.APK, M.DivisionID, M.StatusID, M.StatusName, M.Orders
					, M.Color, A1.Description AS StatusType, M.Disabled, M.IsCommon, M.StatusNameE
				INTO #TempOOT1040
				FROM OOT1040 M WITH (NOLOCK)
					LEFT JOIN OOT0099 A1 WITH (NOLOCK) ON A1.ID = M.StatusType AND A1.CodeMaster = ''OOT00000001''
				WHERE ' + @sWhere + '

				DECLARE @Count INT
				SELECT @Count = COUNT(Orders) FROM #TempOOT1040

				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
					, M.APK, M.DivisionID, M.StatusID, M.StatusName, M.StatusType
					, M.Color, M.Orders, M.Disabled, M.IsCommon, M.StatusNameE
				FROM #TempOOT1040 M
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
PRINT (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
