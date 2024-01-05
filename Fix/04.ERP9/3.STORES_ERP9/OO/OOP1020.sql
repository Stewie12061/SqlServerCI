IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load form TMF101 - Danh mục quy trình
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thị Phượng on 02/10/2017
-- <Example>
/*
 EXEC OOP1020 'KY', '', '', '', '', '', 'NV01', 1, 10
*/

CREATE PROCEDURE [dbo].[OOP1020]
(
		@DivisionID VARCHAR(50),
		@DivisionIDList NVARCHAR(MAX),
		@ProcessID VARCHAR(50),
		@ProcessName NVARCHAR(250),
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
SET @OrderBy = ' M.DivisionID, M.ProcessID '
-- Check Para DivisionIDList null then get DivisionID
IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
ELSE
	SET @sWhere = @sWhere + ' (M.DivisionID IN (''' + @DivisionID + ''', ''@@@'')) '

IF ISNULL(@ProcessID, '') != ''
	SET @sWhere = @sWhere + ' AND M.ProcessID LIKE N''%' + @ProcessID + '%'' '
	
IF ISNULL(@Disabled, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, ''0'') LIKE N''%' + @Disabled + '%'' '

IF ISNULL(@IsCommon, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, ''0'') LIKE N''%' + @IsCommon + '%'' '

IF ISNULL(@ProcessName, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.ProcessName, '''') LIKE N''%' + @ProcessName + '%'' '

SET @sSQL = 	'SELECT M.APK, M.DivisionID, M.ProcessID, M.ProcessName, M.Description, M.Disabled, M.IsCommon
					, M.CreateDate, A1.Fullname AS CreateUserID, M.CreateUserID + ''_'' + ISNULL(A1.FullName, '''') AS CreateUserName
					, M.LastModifyDate, M.LastModifyUserID, M.LastModifyUserID + ''_'' + ISNULL(A2.FullName, '''') AS LastModifyUserName
				INTO #TempOOT1020
				FROM OOT1020 M WITH (NOLOCK)
					LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
					LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = M.LastModifyUserID
				WHERE ' + @sWhere + '

				DECLARE @count INT
				SELECT @count = COUNT(*) FROM #TempOOT1020

				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
					, M.APK, M.DivisionID, M.ProcessID, M.ProcessName, M.Description, M.Disabled, M.IsCommon
					, M.CreateDate, M.CreateUserID, M.CreateUserName, M.LastModifyDate, M.LastModifyUserID, M.LastModifyUserName
				FROM #TempOOT1020 M
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
