IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1430]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1430]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
--- Load dữ liệu danh mục tuyến
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Kiều Nga on: 20/09/2022
---  Updated by: Minh Dũng on: 24/10/2023
-- <Example>

CREATE PROCEDURE CIP1430
(
	@DivisionIDList NVARCHAR(MAX),
	@DivisionID VARCHAR(50),
	@RouteID VARCHAR(50)= '',
	@RouteName NVARCHAR(MAX) = '',
	@EmployeeID NVARCHAR(MAX) = '',
	@WareHouseName NVARCHAR(MAX) = '',
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
DECLARE @Select NVARCHAR(MAX)=''
DECLARE @Join NVARCHAR(MAX)=''
DECLARE @TotalRow NVARCHAR(50)
DECLARE @CustomerName INT =(SELECT CustomerName From CustomerIndex )
        
SET @sWhere = '1=1'
SET @TotalRow = ''
SET @OrderBy = ' T1.DivisionID, T1.RouteID'

IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' AND T1.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
ELSE 
	SET @sWhere = @sWhere + ' AND T1.DivisionID IN (''' + @DivisionID + ''', ''@@@'') '

IF ISNULL(@RouteID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(T1.RouteID, '''') LIKE N''%' + @RouteID + '%'' '

IF ISNULL(@RouteName, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(T1.RouteName, '''') LIKE N''%' + @RouteName + '%'' '

IF ISNULL(@EmployeeID, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(T1.EmployeeID, '''') LIKE N''%' + @EmployeeID + '%'' OR ISNULL(T2.FullName, '''') LIKE N''%' + @EmployeeID + '%'') '

IF ISNULL(@WareHouseName, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(T1.WareHouseID, '''') LIKE N''%' + @WareHouseName + '%'' OR ISNULL(T3.WareHouseName, '''') LIKE N''%' + @WareHouseName + '%'') '

IF ISNULL(@Disabled, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(T1.Disabled, '''') = ' + @Disabled

IF ISNULL(@IsCommon, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(T1.IsCommon, '''') = ' + @IsCommon

IF (@CustomerName = 166) -- Nệm Kim Cương
BEGIN
	SET @Select = @Select + ',H20.ShiftName'
	SET @Join = @Join + 'LEFT JOIN HT1020 H20 WITH (NOLOCK) ON T1.ShiftID = H20.ShiftID'
END

SET @sSQL = N'SELECT T1.APK,T1.DivisionID,T1.RouteID,T1.RouteName,T1.[Description],T1.EmployeeID,T2.FullName as EmployeeName, T1.[Disabled]
		,T1.CreateUserID,T1.CreateDate,T1.LastModifyUserID,T1.LastModifyDate,T1.IsCommon,T1.WareHouseID, T3.WareHouseName
		' + @Select +'
		INTO #TemCIP1430
		FROM CT0143 T1 WITH (NOLOCK)
		LEFT JOIN AT1103 T2 WITH (NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T2.EmployeeID = T1.EmployeeID
		LEFT JOIN AT1303 T3 WITH (NOLOCK) ON T3.DivisionID IN (''@@@'',T1.DivisionID) AND T3.WareHouseID = T1.WareHouseID
		' + @Join + '
		WHERE ' + @sWhere + ' 

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, COUNT(*) OVER () AS TotalRow, T1.*
		FROM #TemCIP1430 T1 WITH (NOLOCK)
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
