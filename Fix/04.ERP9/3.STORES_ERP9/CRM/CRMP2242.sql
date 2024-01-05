IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2242]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2242]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn 
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Hoài Bảo Date 28/03/2022
-- <Example>
/*	EXEC CRMP2242 @DivisionID=N'DTI',@TxtSearch=N'',@UserID=N'ASOFTADMIN',@PageNumber=N'1',@PageSize=N'25',@ConditionPackageManagement=N'ASOFTADMIN'',''D11001'',''D36001'
*/

 CREATE PROCEDURE CRMP2242 (
    @DivisionID NVARCHAR(2000),
    @TxtSearch NVARCHAR(250),
	@UserID VARCHAR(50),
    @PageNumber INT,
    @PageSize INT,
	@ConditionPackageManagement NVARCHAR(MAX)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)


	SET @sWhere = ''
	SET @sWhere1 = ''
	SET @TotalRow = ''
	SET @OrderBy = ' M.PackageID'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF ISNULL(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
							AND (M.PackageID LIKE N''%'+@TxtSearch+'%'' 
							OR M.PackageName LIKE N''%'+@TxtSearch+'%'' 
							OR M.Description LIKE N''%'+@TxtSearch+'%'')'

	IF ISNULL(@ConditionPackageManagement, '') != ''
		SET @sWhere1 = @sWhere1 + 'AND ISNULL(A16.CreateUserID, '''') IN ('''+@ConditionPackageManagement+''') '

	SET @sSQL = '
				Select  ROW_NUMBER() OVER (ORDER BY M.PackageID) AS RowNum, COUNT(*) OVER () AS TotalRow
				 , M.APK, M.DivisionID, M.PackageID, M.PackageName, M.[Description], M.IsPackage
				From (
				   SELECT A02.APK, A02.DivisionID, A02.InventoryID AS PackageID, A02.InventoryName AS PackageName, NULL AS [Description], ''0'' AS IsPackage
				   FROM AT1302 A02 WITH (NOLOCK)
				   WHERE A02.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND ISNULL(A02.[Disabled], 0) = 0
				   UNION ALL
				   SELECT A16.APK, A16.DivisionID, A16.PackageID, A16.PackageName, A16.[Description], ''1'' AS IsPackage
				   FROM AT0016 A16  WITH (NOLOCK)
				   WHERE A16.DivisionID = ''' + @DivisionID + ''' AND ISNULL(A16.DeleteFlg, 0) = 0 ' +@sWhere1+'
				 ) M
				Where 1=1  '+@sWhere+'
				Order by M.PackageID
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT  '+STR(@PageSize)+' ROWS ONLY'
	--PRINT (@sSQL)
	EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
