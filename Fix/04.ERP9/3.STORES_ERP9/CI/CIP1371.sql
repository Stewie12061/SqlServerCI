IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1371]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1371]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
--- Load dữ liệu màn hình chọn danh mục máy (CIF1373)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Lê Hoàng on: 09/03/2021
---- Modified by Lê Hoàng on 10/05/2021 : bổ sung biến phòng ban
---- Modified by ... on ...
-- <Example>

CREATE PROCEDURE CIP1371
(
	@DivisionID VARCHAR(50),
	@TxtSearch NVARCHAR(MAX)= '',
	@UserID VARCHAR(50) = '',
	@PageNumber INT,
	@PageSize INT,
	@LstDepartmentID VARCHAR(MAX) = ''
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

SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionID + ''', ''@@@'') '

IF ISNULL(@LstDepartmentID,'') <> '' 
BEGIN
	SET @sWhere = @sWhere + ' AND M.DepartmentID IN (''' + REPLACE(@LstDepartmentID,',',''',''') + ''') '
END

IF ISNULL(@TxtSearch,'') != ''  
BEGIN
	SET @sWhere = @sWhere +'
	AND (M.MachineID LIKE N''%'+@TxtSearch+'%'' 
	OR M.MachineName LIKE N''%'+@TxtSearch+'%'' 
	OR M.MachineNameE LIKE N''%'+@TxtSearch+'%'' 
	OR M.DepartmentID LIKE N''%'+@TxtSearch+'%'' 
	OR M.Notes LIKE N''%'+@TxtSearch+'%'') '
END

SET @sSQL = 'SELECT M.APK
			, M.DivisionID
			, M.MachineID
			, M.MachineName
			, M.MachineNameE
			, DepartmentID
			, M.Model
			, M.Year
			, M.StartDate
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
