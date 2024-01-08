IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP1810]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP1810]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
--- Load dữ liệu Công đoạn sản xuất.
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đình Ly on: 23/10/2020
---- Modified by: Kiều Nga on: 04/12/2023 Bổ sung phân quyền dữ liệu @ConditionProductionStep
-- <Example>

CREATE PROCEDURE MP1810
(
	@DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(2000),
	@PhaseID VARCHAR(50) = '',
	@PhaseName NVARCHAR(500) = '',
	@IsCommon NVARCHAR(50) = '',
	@Disabled VARCHAR(50) = '',
	@UserID VARCHAR(50) = '',
	@PageNumber INT,
	@PageSize INT,
	@ConditionProductionStep NVARCHAR(MAX) =''
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
SET @OrderBy = ' M.DivisionID, M.PhaseID, M.PhaseName'

IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
ELSE 
	SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionID + ''', ''@@@'') '

IF ISNULL(@PhaseID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.PhaseID, '''') LIKE N''%' + @PhaseID + '%'' '

IF ISNULL(@PhaseName, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.PhaseName, '''') LIKE N''%' + @PhaseName + '%'' '

IF ISNULL(@Disabled, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, '''') = ' + @Disabled

IF ISNULL(@IsCommon, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, '''') = ' + @IsCommon

IF ISNULL(@ConditionProductionStep, '') != '' AND ISNULL(@ConditionProductionStep, '') != 'UNASSIGNED'
	SET @SQLPermission = @SQLPermission + ' INNER JOIN #PermissionAT0126 T1 ON M.CreateUserID = T1.Value  '

SET @sSQL = '
		SELECT Value
		INTO #PermissionAT0126
		FROM STRINGSPLIT(''' + ISNULL(@ConditionProductionStep, '') + ''', '','')

		SELECT M.APK
		   , M.DivisionID
           , M.PhaseID
           , M.PhaseName
           , M.Notes
           , M.Disabled
           , M.IsCommon
           , M.CreateUserID
           , M.CreateDate
           , M.LastModifyUserID
           , M.LastModifyDate INTO #AT0126
        FROM AT0126 M WITH(NOLOCK)
		'+@SQLPermission+' 
		WHERE ' + @sWhere + ' 

		DECLARE @Count INT
		SELECT @Count = COUNT(PhaseID)
		FROM #AT0126

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow, M.*
		FROM #AT0126 M WITH (NOLOCK)
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
