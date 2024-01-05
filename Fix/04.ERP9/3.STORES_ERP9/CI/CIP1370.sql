IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1370]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1370]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
--- Load dữ liệu danh mục nguồn lực
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đình Ly on: 26/12/2021
-- <Example>

CREATE PROCEDURE CIP1370
(
	@DivisionIDList NVARCHAR(2000),
	@DivisionID VARCHAR(50),
	@ResourceTypeID VARCHAR(50)= '',
	@MachineID VARCHAR(50) = '',
	@MachineName NVARCHAR(500) = '',
	@MachineNameE NVARCHAR(500) = '',
	@UnitID VARCHAR(50) = '',
	@DepartmentID VARCHAR(50),
	@Model NVARCHAR(MAX) = '',
	@Year VARCHAR(50) = '',
	@Notes NVARCHAR(250) = '',
	@IsCommon NVARCHAR(50) = '',
	@Disabled VARCHAR(50) = '',
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
SET @OrderBy = ' M.DivisionID, M.MachineID'

IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
ELSE 
	SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionID + ''', ''@@@'') '

IF ISNULL(@ResourceTypeID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.ResourceTypeID, '''') LIKE N''%' + @ResourceTypeID + '%'' '

IF ISNULL(@MachineID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.MachineID, '''') LIKE N''%' + @MachineID + '%'' '

IF ISNULL(@MachineName, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.MachineName, '''') LIKE N''%' + @MachineName + '%'' '

IF ISNULL(@MachineNameE, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.MachineNameE, '''') LIKE N''%' + @MachineNameE + '%'' '

IF ISNULL(@DepartmentID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.DepartmentID, '''') = ''' + @DepartmentID + ''''
	
IF ISNULL(@UnitID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.UnitID, '''') = ''' + @UnitID + ''''

IF ISNULL(@Model, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.Model, '''') = ''' + @Model + ''''

IF ISNULL(@Disabled, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, '''') = ' + @Disabled

IF ISNULL(@IsCommon, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, '''') = ' + @IsCommon

SET @sSQL = 'SELECT M.APK
			, M.DivisionID
			, M.MachineID
			, M.MachineName
			, M.MachineNameE
			, DepartmentID
			, M.Model
			, M.Year
			, CONVERT(NVARCHAR(50), M.StartDate, 101) AS StartDate
			, M.Notes
			, M.Efficiency
			, M.LinedUpTime
			, M.SettingTime
			, M.WaittingTime
			, M.TransferTime
			, M.MaxTime
			, M.MinTime
			, M.Disabled
			--, M.IsCommon
			, M.CreateUserID
			, M.CreateDate
			, M.LastModifyUserID
			, M.LastModifyDate
			, M3.Description AS ResourceTypeID 
			, M2.Description AS UnitID, M.GoldLimit INTO #CIT1150
        FROM CIT1150 M WITH(NOLOCK)
			LEFT JOIN MT0099 M2 WITH (NOLOCK) ON M2.ID = M.UnitID AND ISNULL(M2.Disabled, 0)= 0 AND M2.CodeMaster = ''RoutingUnit''
			LEFT JOIN MT0099 M3 WITH (NOLOCK) ON M3.ID = M.ResourceTypeID AND ISNULL(M3.Disabled, 0)= 0 AND M3.CodeMaster = ''ResourcesType''
		WHERE ' + @sWhere + ' 

		DECLARE @Count INT
		SELECT @Count = COUNT(MachineID)
		FROM #CIT1150

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow, M.*
		FROM #CIT1150 M WITH (NOLOCK)
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
