IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2130]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2130]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Load dữ liệu quy trình sản xuất
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đình Ly on: 23/10/2020
---- Modified by: Kiều Nga on: 04/12/2023 Bổ sung phân quyền dữ liệu @ConditionProductionProcess
-- <Example>

CREATE PROCEDURE MP2130
(
	@DivisionIDList NVARCHAR(2000),
	@DivisionID VARCHAR(50),
	@RoutingID VARCHAR(50)='',
	@RoutingName VARCHAR(50) ='',
	@UnitID VARCHAR(50) ='',
	@RoutingTime VARCHAR(50),
	@IsCommon NVARCHAR(50) ='',
	@Disabled VARCHAR(50) ='',
	@UserID VARCHAR(50) = '',
	@PageNumber INT,
	@PageSize INT,
	@ConditionProductionProcess NVARCHAR(MAX) =''
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
SET @OrderBy = ' M.DivisionID, M.RoutingID'

IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
ELSE 
	SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionID + ''', ''@@@'') '

IF ISNULL(@RoutingID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.RoutingID, '''') LIKE N''%' + @RoutingID + '%'' '

IF ISNULL(@RoutingName, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.RoutingName, '''') LIKE N''%' + @RoutingName + '%'' '

IF ISNULL(@UnitID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.UnitID, '''') LIKE N''%' + @UnitID + '%'' '

IF ISNULL(@RoutingTime, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(CONVERT(VARCHAR(10), M.RoutingTime), '''') LIKE N''%' + @RoutingTime + '%'' '

IF ISNULL(@Disabled, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, '''') = ' + @Disabled

IF ISNULL(@IsCommon, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, '''') = ' + @IsCommon

IF ISNULL(@ConditionProductionProcess, '') != '' AND ISNULL(@ConditionProductionProcess, '') != 'UNASSIGNED'
	SET @SQLPermission = @SQLPermission + ' INNER JOIN #PermissionMT2130 T1 ON M.CreateUserID = T1.Value  '

SET @sSQL = N'
		SELECT Value
		INTO #PermissionMT2130
		FROM STRINGSPLIT(''' + ISNULL(@ConditionProductionProcess, '') + ''', '','')

		SELECT M.APK
			 , M.DivisionID
			 , M.RoutingID
			 , M.RoutingName
			 , M.RoutingTypeID
			 , M.Notes
			 , M.RoutingTime
			 , M.Disabled
			 , M.CreateUserID
			 , M.CreateDate
			 , M.LastModifyUserID
			 , M.LastModifyDate
			 , M2.Description AS UnitID INTO #MT2130
        FROM MT2130 M WITH(NOLOCK)
			INNER JOIN MT0099 M2 WITH (NOLOCK) ON M2.ID = M.UnitID AND ISNULL(M2.Disabled, 0)= 0 AND M2.CodeMaster = ''RoutingUnit''
			'+@SQLPermission+'
		WHERE ' + @sWhere + ' 

		DECLARE @Count INT
		SELECT @Count = COUNT(RoutingID)
		FROM #MT2130

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow, M.*
		FROM #MT2130 M WITH (NOLOCK)
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
