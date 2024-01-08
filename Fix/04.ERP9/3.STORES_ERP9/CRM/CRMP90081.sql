IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90081]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP90081]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load màn hình chọn chiến dịch
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Thị Phượng Date 31/03/2017
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
-- <Example>
/*
	exec CRMP90081 @DivisionID=N'AS',@TxtSearch=N'',@UserID=N'CALL002',@PageNumber=N'1',@PageSize=N'100',
	@ConditionCampainID =N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU' 
*/

 CREATE PROCEDURE CRMP90081 (
    @DivisionID NVARCHAR(2000),
    @TxtSearch NVARCHAR(250),
	@UserID VARCHAR(50),
    @PageNumber INT,
    @PageSize INT,
	@ConditionCampainID nvarchar(max)
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
	SET @OrderBy = ' M.CampaignID'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	
	IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
							AND (M.CampaignID LIKE N''%'+@TxtSearch+'%'' 
							OR M.CampaignName LIKE N''%'+@TxtSearch+'%'' 
							OR M.ExpectCloseDate LIKE N''%'+@TxtSearch+'%'' 
							OR M.CampaignStatus LIKE N''%'+@TxtSearch+'%'' 
							OR M.ExpectedRevenue LIKE N''%'+@TxtSearch + '%'' 
							OR M.AssignedToUserID LIKE N''%'+@TxtSearch+'%'')'

	IF Isnull(@ConditionCampainID, '') != ''	 
		SET @sWhere1 = @sWhere1 + 'AND ISNULL(B.UserID, D.CreateUserID) In ('''+@ConditionCampainID+''') '

	SET @sSQL = '
				Select  ROW_NUMBER() OVER (ORDER BY M.CampaignID) AS RowNum, COUNT(*) OVER () AS TotalRow
				 , M.APK, M.DivisionID, M.CampaignID, M.CampaignName
				 , M.ExpectCloseDate, M.CampaignStatus,  M.ExpectedRevenue
				From (
				   Select  Distinct D.APK, D.DivisionID, D.CampaignID, D.CampaignName, D.CampaignType, D.AssignedToUserID
				   , D.Description, D.ExpectOpenDate, D.ExpectCloseDate, C.Description CampaignStatus, D.InventoryID
				   , D.Sponsor, D.IsCommon, D.Disabled, D.BudgetCost, D.ExpectedRevenue, D.ExpectedSales
				   , D.ExpectedROI, D.ExpectedResponse, D.ActualSales, D.CreateDate, D.ActualROI
				   , D.CreateUserID, D.RelatedToTypeID
				  from CRMT20401 D  WITH (NOLOCK)
				  Left join AT1103_REL B WITH (NOLOCK) ON B.RelatedToID =convert(Varchar(50),D.APK)
				  Left join CRMT0099 C WITH (NOLOCK) ON D.CampaignStatus =C.ID and C.CodeMaster =''CRMT00000012''
				  Where D.DivisionID in ( '''+@DivisionID+''', ''@@@'') and D.DeleteFlg = 0 '+@sWhere1+'
				 ) M
				Where 1=1  '+@sWhere+'
				Order by M.CampaignID
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT  '+STR(@PageSize)+' ROWS ONLY'
	EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
