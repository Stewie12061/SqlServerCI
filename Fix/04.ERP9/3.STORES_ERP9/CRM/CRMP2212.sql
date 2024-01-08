IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2212]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2212]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn dữ liệu nguồn online
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Hoài Bảo Date 28/03/2022
-- <Example>
/*	EXEC CRMP2212 @DivisionID=N'DTI',@TxtSearch=N'',@UserID=N'ASOFTADMIN',@PageNumber=N'1',@PageSize=N'25',@ConditionSourceDataOnline=N'ASOFTADMIN'',''D11001'',''D36001'
*/

 CREATE PROCEDURE CRMP2212 (
    @DivisionID NVARCHAR(2000),
    @TxtSearch NVARCHAR(250),
	@UserID VARCHAR(50),
    @PageNumber INT,
    @PageSize INT,
	@ConditionSourceDataOnline nvarchar(max)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
DECLARE @CustomerName INT
IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#CustomerName')) 
DROP TABLE #CustomerName
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

	SET @sWhere = ''
	SET @sWhere1 = ''
	SET @TotalRow = ''
	SET @OrderBy = ' M.SourceID'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	
	IF ISNULL(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
							AND (M.SourceID LIKE N''%'+@TxtSearch+'%'' 
							OR M.SourceName LIKE N''%'+@TxtSearch+'%'' 
							OR M.Tel LIKE N''%'+@TxtSearch+'%'' 
							OR M.[Address] LIKE N''%'+@TxtSearch+'%'' 
							OR M.Email LIKE N''%'+@TxtSearch + '%'' 
							OR M.CompanyName LIKE N''%'+@TxtSearch + '%'' 
							OR M.JobTitle LIKE N''%'+@TxtSearch + '%'' 
							OR M.StatusName LIKE N''%'+@TxtSearch + '%'' 
							OR M.TypeOfSourceName LIKE N''%'+@TxtSearch + '%''  
							OR M.ProductInfoName LIKE N''%'+@TxtSearch+'%'')'

	IF ISNULL(@ConditionSourceDataOnline, '') != ''	 
		SET @sWhere1 = @sWhere1 + 'AND ISNULL(A2.EmployeeID, C1.CreateUserID) In ('''+@ConditionSourceDataOnline+''') '

	SET @sSQL = '
				Select  ROW_NUMBER() OVER (ORDER BY M.SourceID) AS RowNum, COUNT(*) OVER () AS TotalRow
				 , M.APK, M.DivisionID, M.SourceID, M.SourceName
				 , M.Tel, M.[Address], M.Email, M.CompanyName, M.JobTitle, M.StatusName, M.TypeOfSourceName, M.ProductInfoName
				From (
				   SELECT C1.APK, C1.DivisionID, C1.SourceID, C1.SourceName, C1.Tel, C1.[Address], C1.Email
				   , C1.JobTitle, C1.CompanyName, C2.StageName AS StatusName, C3.[Description] AS TypeOfSourceName
				   , STUFF((SELECT '','' + '' '' + A1.InventoryName
					FROM CRMT0088 C4
					    LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = C4.BusinessChild
					WHERE C4.APKParent = C1.APK
				    FOR XML PATH('''')), 1, 1, '''') AS ProductInfoName
				  FROM CRMT2210 C1  WITH (NOLOCK)
					LEFT JOIN CRMT10401 C2 WITH (NOLOCK) ON C2.StageID = C1.StatusID
					LEFT JOIN CRMT0099 C3 WITH (NOLOCK) ON C3.ID = C1.TypeOfSource AND C3.CodeMaster = ''CRMF2210.TypeOfSource''
					LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = C1.CreateUserID
					LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = C1.LastModifyUserID
				  Where C1.DivisionID in ( ''' + @DivisionID + ''', ''@@@'') and C1.[Disabled] = 0 '+@sWhere1+'
				 ) M
				Where 1=1  '+@sWhere+'
				Order by M.SourceID
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT  '+STR(@PageSize)+' ROWS ONLY'
	--PRINT (@sSQL)
	EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
