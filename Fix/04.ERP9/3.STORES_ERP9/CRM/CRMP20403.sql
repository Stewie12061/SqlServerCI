IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20403]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20403]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- In/xuất excel CRMP20303 Danh mục chiến dịch
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 16/03/2017
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
--- Modify by Anh Đô, Date 09/12/2022: Bổ sung lọc theo list apk
-- <Example>
/*
--Lưu y chưa xử lý: Phân quyền xem dữ liệu người khác, phân quyền chi tiết dữ liệu

EXEC CRMP20403 'AS' ,'','' ,'' ,'' ,'' ,'' ,'' ,'' ,'' ,'', 'NV01',N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU' 

*/
CREATE PROCEDURE CRMP20403 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @CampaignID nvarchar(50),
        @CampaignName nvarchar(250),
		@AssignedToUserID nvarchar(250),
		@CampaignType nvarchar(250),
		@ExpectOpenDate Datetime,
		@ExpectCloseDate Datetime,
		@CampaignStatus nvarchar(250),
		@IsCommon nvarchar(100),
		@Disabled nvarchar(100),
		@UserID  VARCHAR(50),
		@ConditionCampainID nvarchar(max),
		@ListAPK NVARCHAR(MAX) = ''
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
	SET @sWhere = ''
	SET @OrderBy = 'M.CampaignID'
	
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''',''@@@'')'
	Else 
		SET @sWhere = @sWhere + ' M.DivisionID IN (N'''+ @DivisionID+''',''@@@'')'
		
		
	IF Isnull(@CampaignID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.CampaignID, '''') LIKE N''%'+@CampaignID+'%'') '
	IF Isnull(@CampaignName, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.CampaignName,'''') LIKE N''%'+@CampaignName+'%'' ) '
	IF Isnull(@AssignedToUserID, '') != ''
		SET @sWhere = @sWhere +  'AND (ISNULL(M.AssignedToUserID,'''') LIKE N''%'+@AssignedToUserID+'%'') '
	IF Isnull(@CampaignType, '') != ''
		SET @sWhere = @sWhere +  'AND (ISNULL(M.CampaignType,'''') LIKE N''%'+@CampaignType+'%'' )'
	IF Isnull(@ExpectOpenDate, '') != '' 
		SET @sWhere = @sWhere +  'AND (CONVERT(VARCHAR(10),M.ExpectOpenDate,112) = '''+ CONVERT(VARCHAR(20),@ExpectOpenDate,112)+''')'
	IF Isnull(@ExpectCloseDate, '') != ''
		SET @sWhere = @sWhere + 'AND (CONVERT(VARCHAR(10),M.ExpectCloseDate,112) = '''+ CONVERT(VARCHAR(20),@ExpectCloseDate,112)+''')'
	IF Isnull(@CampaignStatus, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.CampaignStatus,'''') = N'''+@CampaignStatus+''' ) '
	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' )'
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
	IF Isnull(@ConditionCampainID, '') != ''	 
		SET @sWhere = @sWhere + 'AND ISNULL(B.UserID, M.CreateUserID) In ('''+@ConditionCampainID+''') '
	IF ISNULL(@ListAPK, '') != ''
		SET @sWhere = @sWhere + 'AND M.APK IN ('''+ @ListAPK +''') '

SET @sSQL = ' SELECT Distinct M.APK, Case When isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID
					, M.CampaignID, M.CampaignName
					, M.CampaignType, D5.Description as CampaignTypeName
					, M.CampaignStatus, D6.Description as CampaignStatusName
					, stuff(isnull((Select '', '' + FullName From AT1103 A WITH (NOLOCK) 
						Left join AT1103_REL B WITH (NOLOCK) ON A.EmployeeID = B.UserID 
						where B.RelatedToID =convert(Varchar(50),M.APK) 
						Group by B.UserID, A.FullName
						FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as AssignedToUserID
					, M.Disabled, M.IsCommon
					, M.ExpectOpenDate, M.ExpectCloseDate, M.Description
					, M.InventoryID, M.Sponsor
					, M.BudgetCost, M.ExpectedRevenue, M.ExpectedSales, M.ExpectedROI, M.ExpectedResponse
					, M.ActualCost, M.ActualSales, M.ActualROI, M.RelatedToTypeID
					, M.CreateUserID, M.CreateDate
					, M.LastModifyUserID, M.LastModifyDate, D4.FullName as AssignedToUserName, D7.InventoryName
					, CASE WHEN M.Disabled = 0 THEN N''Không'' ELSE N''Có'' END DisabledName
					, CASE WHEN M.IsCommon = 0 THEN N''Không'' ELSE N''Có'' END IsCommonName
					into #CRMT20401Temp
			FROM CRMT20401 M With (NOLOCK) 
			Left join AT1103_REL B WITH (NOLOCK) ON B.RelatedToID =convert(Varchar(50),M.APK)
			left join CRMT0099 D5 With (NOLOCK) on M.CampaignType = D5.ID and D5.CodeMaster = ''CRMT00000011''
			left join CRMT0099 D6 With (NOLOCK) on M.CampaignStatus = D6.ID and (D6.CodeMaster = ''CRMT00000012'' OR D6.CodeMaster = ''CRMT00000013'')
			left join AT1103 D4 With (NOLOCK) on M.AssignedToUserID = D4.EmployeeID
			left join AT1302 D7 With (NOLOCK) on M.InventoryID = D7.InventoryID									 
			WHERE '+@sWhere+'

	SELECT  M.APK, M.DivisionID
			, M.CampaignID, M.CampaignName
			, M.CampaignType, M.CampaignTypeName
			, M.CampaignStatus, M.CampaignStatusName
			, M.AssignedToUserID
			, M.Disabled, M.IsCommon
			, M.ExpectOpenDate, M.ExpectCloseDate, M.Description
			, M.InventoryID, M.Sponsor
			, M.BudgetCost, M.ExpectedRevenue, M.ExpectedSales, M.ExpectedROI, M.ExpectedResponse
			, M.ActualCost, M.ActualSales, M.ActualROI, M.RelatedToTypeID
			, M.CreateUserID, M.CreateDate
			, M.LastModifyUserID, M.LastModifyDate, M.AssignedToUserName, M.InventoryName
			, M.IsCommonName, M.DisabledName
	FROM #CRMT20401Temp M
			ORDER BY '+@OrderBy+''
EXEC (@sSQL)
print (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
