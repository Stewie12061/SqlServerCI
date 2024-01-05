IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP1820]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP1820]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Load dữ liệu nguồn lực sản xuất
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đình Ly on: 23/10/2020
-- <Example>

CREATE PROCEDURE MP1820
(
	@DivisionIDList NVARCHAR(2000),
	@DivisionID VARCHAR(50),
	@ResourceTypeID VARCHAR(50)='',
	@ResourceID VARCHAR(50) ='',
	@ResourceName NVARCHAR(500) ='',
	@UnitID VARCHAR(50) ='',
	@IsCommon NVARCHAR(50) ='',
	@Disabled VARCHAR(50) ='',
	@UserID VARCHAR(50) = '',
	@PageNumber INT,
	@PageSize INT
)
AS

DECLARE @sSQL NVARCHAR (MAX)=''
DECLARE @sSQL1 NVARCHAR (MAX)=''
DECLARE @sWhere NVARCHAR(MAX)=''
DECLARE @OrderBy NVARCHAR(500)
DECLARE @TotalRow NVARCHAR(50)
        
SET @sWhere = '1=1'
SET @TotalRow = ''
SET @OrderBy = ' M.DivisionID, M.ResourceID'

IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
ELSE 
	SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionID + ''', ''@@@'') '

IF ISNULL(@ResourceTypeID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.ResourceTypeID, '''') LIKE N''%' + @ResourceTypeID + '%'' '

IF ISNULL(@ResourceID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.ResourceID, '''') LIKE N''%' + @ResourceID + '%'' '

IF ISNULL(@ResourceName, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.ResourceName, '''') LIKE N''%' + @ResourceName + '%'' '

IF ISNULL(@UnitID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.UnitID, '''') = ''' + @UnitID + ''''

IF ISNULL(@Disabled, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, '''') = ' + @Disabled

IF ISNULL(@IsCommon, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, '''') = ' + @IsCommon

SET @sSQL = 'SELECT M.APK
		   , M.DivisionID
           , M.ResourceID
           , M.ResourceName
           , M.Notes
           , M.Efficiency
           , M.LinedUpTime
           , M.SettingTime
           , M.WaittingTime
           , M.TransferTime
           , M.MaxTime
           , M.MinTime
           , M.Disabled
           , M.IsCommon
           , M.CreateUserID
           , M.CreateDate
           , M.LastModifyUserID
           , M.LastModifyDate
		   , M3.Description AS ResourceTypeID 
           , M2.Description AS UnitID INTO #MT1820
        FROM MT1820 M WITH(NOLOCK)
			INNER JOIN MT0099 M2 WITH (NOLOCK) ON M2.ID = M.UnitID AND ISNULL(M2.Disabled, 0)= 0 AND M2.CodeMaster = ''RoutingUnit''
			INNER JOIN MT0099 M3 WITH (NOLOCK) ON M3.ID = M.ResourceTypeID AND ISNULL(M3.Disabled, 0)= 0 AND M3.CodeMaster = ''ResourcesType''
		WHERE ' + @sWhere + ' 

		DECLARE @Count INT
		SELECT @Count = COUNT(ResourceID)
		FROM #MT1820

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow, M.*
		FROM #MT1820 M WITH (NOLOCK)
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
