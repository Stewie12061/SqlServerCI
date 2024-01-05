IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[OOP1050]
(
		@DivisionID VARCHAR(50),
		@DivisionIDList NVARCHAR(MAX),
		@ProjectSampleID VARCHAR(50),
		@ProjectSampleName NVARCHAR(250),
		@IsCommon NVARCHAR(100),
		@Disabled NVARCHAR(100),
		@UserID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)

SET @sWhere = ''
SET @OrderBy = ' M.DivisionID, M.ProjectSampleID '
-- Check Para DivisionIDList null then get DivisionID
IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
ELSE
	SET @sWhere = @sWhere + ' (M.DivisionID IN (''' + @DivisionID + ''', ''@@@'')) '

IF ISNULL(@ProjectSampleID, '') != ''
	SET @sWhere = @sWhere + ' AND M.ProjectSampleID LIKE N''%' + @ProjectSampleID + '%'' '

IF ISNULL(@IsCommon, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, ''0'') LIKE N''%' + @IsCommon + '%'' '

IF ISNULL(@Disabled, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, ''0'') LIKE N''%' + @Disabled + '%'' '

IF ISNULL(@ProjectSampleName, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.ProjectSampleName, '''') LIKE N''%' + @ProjectSampleName + '%'' '

SET @sSQL =	'SELECT M.APK, M.DivisionID, M.ProjectSampleID, M.ProjectSampleName, M.Description, M.IsCommon, M.Disabled
				, M.CreateDate, M.CreateUserID, M.CreateUserID + ''_'' + ISNULL(A1.FullName, '''') AS CreateUserName
				, M.LastModifyDate, M.LastModifyUserID, M.LastModifyUserID + ''_'' + ISNULL(A2.FullName, '''') AS LastModifyUserName
				INTO #OOT1050Temp
				FROM OOT1050 M WITH (NOLOCK)
					LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
					LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = M.LastModifyUserID
				WHERE ' + @sWhere + '

				DECLARE @count INT
				SELECT @count = COUNT(ProjectSampleID) FROM #OOT1050Temp

				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
					 M.APK, M.DivisionID, M.ProjectSampleID, M.ProjectSampleName, M.Description, M.IsCommon, M.Disabled
					, M.CreateDate, M.CreateUserID, M.CreateUserName, M.LastModifyDate, M.LastModifyUserID, M.LastModifyUserName
				FROM #OOT1050Temp M
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
--PRINT (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
