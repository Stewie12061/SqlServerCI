IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20303]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20303]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- In/xuất excel CRMP20303 Danh muc đầu mối
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 14/03/2017
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
--- Modify by Đình Hòa, Date 23/12/2020: Bổ sung hiển thị các cột trong tab Định vị(CBD)
--- Modify by Đình Ly, Date 24/06/2021: Sửa điều kiện join để load dữ liệu Tình trạng đầu mối và Tên chiến dịch.
--- Modify by Anh Đô, Date 16/12/2022: Bổ sung lọc theo ListAPK, EmployeeName
-- <Example>
/*
--Lưu y chưa xử lý: Phân quyền xem dữ liệu người khác, phân quyền chi tiết dữ liệu
EXEC CRMP20303 'AS' ,'','' ,'' ,'' ,'' ,'' ,'' ,'' ,'' ,'','','', 'NV01' ,N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU' 
*/
CREATE PROCEDURE CRMP20303 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @LeadID nvarchar(50),
        @LeadName nvarchar(250),
		@CampaignName nvarchar(MAX),
		@AssignedToUserID nvarchar(250),
		@Address nvarchar(250),
		@Phone nvarchar(250),
		@Email nvarchar(250),
		@LeadTypeID nvarchar(250),
		@LeadStatusID nvarchar(250),
		@LeadSourceID nvarchar(250),
		@IsCommon nvarchar(100),
		@Disabled nvarchar(100),
		@UserID  VARCHAR(50),
		@ConditionLeadID nvarchar(max),
		@FilterDynamic nvarchar(max) = '',
		@ListAPK VARCHAR(MAX) = '',
		@EmployeeName NVARCHAR(250)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@sSQL1 NVARCHAR (MAX)
		
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'M.LeadID'
	SET @sSQL1 = ''

	IF Isnull(@FilterDynamic, '') != ''
	BEGIN
		SET @sSQL1= 'SELECT M.APK, M.DivisionID, M.LeadID, M.LeadName, ISNULL(M.LeadMobile, M.LeadTel) AS LeadMobile
				, M.Address, M.Email, M.LeadTypeID, B.LeadTypeName, M.LeadStatusID
				, M.AssignedToUserID, D4.FullName AS AssignedToUserName
				, D8.Description AS TradeMarkID, M.Disabled, M.IsCommon
				, D.CampaignDetailID,D7.CampaignName AS CampaignDetailName, D.StatusDetailID, D11.StageName AS StatusDetailName
				, S.Value AS SerminarID, D9.Description AS SerminarName
				, T.Value AS ThematicID, D10.Description AS ThematicName
				, M.CompanyName, M.TitleID, M.BirthDate, M.Description
				INTO #TempCRMT20301_02
				FROM CRMT20301 M WITH (NOLOCK)
				LEFT JOIN CRMT10201 B WITH (NOLOCK) ON B.LeadTypeID = M.LeadTypeID
				LEFT JOIN AT1103 D4 WITH (NOLOCK) ON M.AssignedToUserID = D4.EmployeeID
				LEFT JOIN CRMT10401 D1 WITH (NOLOCK) ON M.LeadStatusID = D1.StageID
				LEFT JOIN CRMT0099 D6 WITH (NOLOCK) ON M.LeadSourceID = D6.ID AND D6.CodeMaster = ''CRMT00000008''
				LEFT JOIN CRMT0099 D8 WITH (NOLOCK) ON M.TradeMarkID = D8.ID AND D8.CodeMaster = ''CRMT00000028''
				lEFT JOIN CRMT20302 D ON M.APK = D.APKMaster
				CROSS APPLY StringSplit(D.SerminarID, '','') S
				CROSS APPLY StringSplit(D.ThematicID, '','') T
				LEFT JOIN CRMT20401 D7 WITH (NOLOCK) ON D.CampaignDetailID = D7.CampaignID
				LEFT JOIN CRMT0099 D9  With (NOLOCK) ON D9.ID = S.Value
				LEFT JOIN CRMT0099 D10  With (NOLOCK) ON D10.ID = T.Value
				LEFT JOIN CRMT10401 D11 With (NOLOCK) on D.StatusDetailID = D11.StageID
			
				SELECT DISTINCT APK
				INTO #TempCRMT20301_APK
				FROM #TempCRMT20301_02
				' + ISNULL(@FilterDynamic,'''') + ''

		SET @sWhere = ' M.APK IN (SELECT APK FROM #TempCRMT20301_APK)'
	END

	IF Isnull(@FilterDynamic, '') = ''
	BEGIN
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')'
	Else 
		SET @sWhere = @sWhere + ' M.DivisionID IN (N'''+ @DivisionID+''', ''@@@'')'
		
	IF Isnull(@LeadID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.LeadID, '''') LIKE N''%'+@LeadID+'%'' '
	IF Isnull(@LeadName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.LeadName,'''') LIKE N''%'+@LeadName+'%''  '
	IF Isnull(@AssignedToUserID, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(M.AssignedToUserID,'''') LIKE N''%'+@AssignedToUserID+'%'' '
	IF Isnull(@Phone, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(M.LeadMobile, LeadTel) LIKE N''%'+@Phone+'%'' '
	IF Isnull(@Address, '') != '' 
		SET @sWhere = @sWhere +  'AND ISNULL(M.Address,'''') LIKE N''%'+@Address+'%'' '
	IF Isnull(@Email, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Email,'''') LIKE N''%'+@Email+'%''  '
	IF Isnull(@LeadTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.LeadTypeID,'''') IN ('''+ @LeadTypeID +''') '
	IF Isnull(@LeadStatusID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.LeadStatusID,'''') in ('''+@LeadStatusID+''' )  '
	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
	IF Isnull(@CampaignName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.CampaignID,'''') in ('''+@CampaignName+''' )  '
	IF ISNULL(@ListAPK, '') != ''
		SET @sWhere = @sWhere + ' AND M.APK IN ('''+ @ListAPK +''') '
	IF Isnull(@EmployeeName, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(D4.FullName,'''') LIKE N''%'+@EmployeeName+'%'' '
	END

	IF Isnull(@ConditionLeadID,'')!=''
		SET @sWhere = @sWhere + ' AND M.AssignedToUserID in ('''+@ConditionLeadID+''' )'
				
SET @sSQL = '
			' + @sSQL1 + '

			 SELECT M.APK, M.DivisionID, M.LeadID, M.LeadName, M.LeadMobile, M.CompanyName, M.TitleID, M.BirthDate, M.Description
			, M.Address, M.Email, M.LeadTypeID, B.LeadTypeName as LeadSourceName, M.LeadStatusID, D1.StageName as LeadStatusName
			, M.LeadSourceID, M.AssignedToUserID, D4.FullName as AssignedToUserName
			, M.JobID, M.Disabled, M.IsCommon, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate
			,isnull(stuff(isnull((select '', '' + C99.Description as Name
			from StringSplit(D.SerminarID,'','') X
			left join CRMT0099 C99  With (NOLOCK) ON C99.ID = X.Value
			order by C99.OrderNo
			 FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, ''''), D.SerminarID)  AS SerminarName
			, isnull(stuff(isnull((select '', '' + C99.Description as Name
			from StringSplit(D.ThematicID,'','') X
			left join CRMT0099 C99  With (NOLOCK) ON C99.ID = X.Value
			order by C99.OrderNo
			FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, ''''), D.ThematicID) AS ThematicName
			, C41.CampaignName AS CampaignName
			into #TempCRMT20301
			FROM CRMT20301 M With (NOLOCK)   
			left join CRMT20302 D WITH(NOLOCK) ON M.APK = D.APKMAster
			Left join CRMT10201 B With (NOLOCK) ON B.LeadTypeID = M.LeadTypeID
			left join AT1103 D4 With (NOLOCK) ON M.AssignedToUserID = D4.EmployeeID
			left join CRMT10401 D1 With (NOLOCK) ON M.LeadStatusID = D1.StageID
			left join CRMT20401 C41 WITH(NOLOCK) ON M.CampaignID = C41.CampaignID											 
			WHERE '+@sWhere+'
	

	 SELECT M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID 
		, M.LeadID, M.LeadName, M.LeadMobile, M.LeadSourceName, M.Address, M.Email, M.LeadTypeID
		, M.LeadStatusID, M.LeadStatusName, M.LeadSourceID, M.AssignedToUserID, M.AssignedToUserName
		, M.JobID, M.Disabled, M.IsCommon, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
		, M.SerminarName, M.ThematicName, M.CampaignName, M.CompanyName, M.TitleID, M.BirthDate, M.Description
		FROM #TempCRMT20301 M
		ORDER BY '+@OrderBy+''
Print (@sSQL)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
