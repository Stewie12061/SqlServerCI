IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP1830]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP1830]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
--- Load dữ liệu nguyên vật liệu thay thế.
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Kiều Nga on: 05/12/2023
-- <Example>

CREATE PROCEDURE MP1830
(
	@DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(2000),
	@MaterialGroupID VARCHAR(50) = '',
	@GroupName NVARCHAR(500) = '',
	@InventoryTypeID VARCHAR(50) = '',
	@MaterialID VARCHAR(50) = '',
	@IsCommon NVARCHAR(50) = '',
	@Disabled VARCHAR(50) = '',
	@UserID VARCHAR(50) = '',
	@PageNumber INT,
	@PageSize INT,
	@ConditionRawMaterialsAlternative NVARCHAR(MAX) =''
)
AS
DECLARE @sSQL NVARCHAR (MAX)=''
DECLARE @sSQL1 NVARCHAR (MAX)=''
DECLARE @sWhere NVARCHAR(MAX)=''
DECLARE @OrderBy NVARCHAR(500)
DECLARE @TotalRow NVARCHAR(50)
DECLARE @SQLPermission NVARCHAR(MAX)=''
        
SET @sWhere = '1=1'
SET @TotalRow = ''
SET @OrderBy = ' M.DivisionID, M.MaterialGroupID, M.GroupName'

IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
ELSE 
	SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionID + ''', ''@@@'') '

IF ISNULL(@MaterialGroupID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.MaterialGroupID, '''') LIKE N''%' + @MaterialGroupID + '%'' '

IF ISNULL(@GroupName, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.GroupName, '''') LIKE N''%' + @GroupName + '%'' '

IF ISNULL(@InventoryTypeID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.InventoryTypeID, '''') LIKE N''%' + @InventoryTypeID + '%'' '

IF ISNULL(@MaterialID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.MaterialID, '''') LIKE N''%' + @MaterialID + '%'' '

IF ISNULL(@Disabled, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, '''') = ' + @Disabled

IF ISNULL(@IsCommon, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, '''') = ' + @IsCommon

IF ISNULL(@ConditionRawMaterialsAlternative, '') != '' AND ISNULL(@ConditionRawMaterialsAlternative, '') != 'UNASSIGNED'
	SET @SQLPermission = @SQLPermission + ' INNER JOIN #PermissionMT0006 T1 ON M.CreateUserID = T1.Value  '

SET @sSQL = '
		SELECT Value
		INTO #PermissionMT0006
		FROM STRINGSPLIT(''' + ISNULL(@ConditionRawMaterialsAlternative, '') + ''', '','')

		SELECT M.APK
		,M.DivisionID
		,M.MaterialGroupID
		,M.GroupName
		,M.Disabled
		,M.InventoryTypeID
		,M.MaterialID
		,M.CreateDate
		,M.CreateUserID
		,M.LastModifyDate
		,M.LastModifyUserID
		,M.IsCommon
		,M.MaterialName INTO #MT0006
        FROM MT0006 M WITH(NOLOCK)
		'+@SQLPermission+' 
		WHERE ' + @sWhere + ' 

		DECLARE @Count INT
		SELECT @Count = COUNT(MaterialGroupID)
		FROM #MT0006

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow, M.*
		FROM #MT0006 M WITH (NOLOCK)
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
