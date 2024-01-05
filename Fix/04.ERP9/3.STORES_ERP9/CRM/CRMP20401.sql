IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20401]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20401]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form CRMP20401 Danh mục chiến dịch
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 16/03/2017
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
--- Modify by Thị Phượng, Date 30/08/2017: Thay đổi cách sắp xếp order by theo CreateDate
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
--- Modify by Đình Hòa, Date 04/11/2020: Bổ sung thêm xử lý search PlaceDate
--- Modify by Đình Hòa, Date 19/11/2020: Chỉnh sửa điều kiện CampaignStatus 
--- Modify by Đình Hòa, Date 16/12/2020: Edit lấy loại chiến dịch the dự án(CBD)
--- Modify by Tấn Lộc, Date 26/07/2021: Thay đổi bảng join từ CRMT0099 sang bảng CRMT10401 để lấy tên trạng thái hiển thị lên lưới
--- Modify by Anh Tuấn, Date 31/12/2021: Bổ sung điều kiện chỉ lấy những phiếu có DeleteFlg = 0
--- Modify by Hoài Bảo, Date 13/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example>
/*
--Lưu y chưa xử lý: Phân quyền xem dữ liệu người khác, phân quyền chi tiết dữ liệu

EXEC CRMP20401 'AS' ,'','' ,'' ,'' ,'' ,'' ,'' ,'' ,'' ,'', 'NV01',N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU' ,1 ,20

*/
CREATE PROCEDURE CRMP20401 ( 
        @DivisionID VARCHAR(50) = '',  --Biến môi trường
		@DivisionIDList NVARCHAR(2000) = '',  --Chọn trong DropdownChecklist DivisionID
		@FromDate DATETIME = NULL,
		@ToDate DATETIME = NULL,
		@IsPeriod INT = 0,
		@PeriodList VARCHAR(MAX) = '',
        @CampaignID NVARCHAR(50) = '',
        @CampaignName NVARCHAR(250) = '',
		@AssignedToUserID NVARCHAR(250) = '',
		@CampaignType NVARCHAR(250) = '',
		@ExpectOpenDate DATETIME = NULL,
		@ExpectCloseDate DATETIME = NULL,
		@PlaceDate DATETIME = NULL,
		@CampaignStatus NVARCHAR(250) = '',
		@IsCommon NVARCHAR(100) = '',
		@Disabled NVARCHAR(100) = '',
		@UserID  VARCHAR(50) = '',
		@ConditionCampainID NVARCHAR(MAX) = '',
		@PageNumber INT = 1,
		@PageSize INT = 25,
		@SearchWhere NVARCHAR(MAX) = NULL,
		@RelAPK NVARCHAR(250) = '',
		@RelTable NVARCHAR(250) = ''
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sJoin NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@CodeMaster VARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
		
SET @sWhere = '1 = 1'
SET @sJoin = ''
SET @OrderBy = 'M.CreateDate DESC'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CreateDate >= ''' + @FromDateText + '''
											OR M.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CreateDate <= ''' + @ToDateText + ''' 
											OR M.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

IF isnull(@SearchWhere,'') =''
Begin
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')'
	Else 
		SET @sWhere = @sWhere + ' AND M.DivisionID IN (N'''+ @DivisionID+''',''@@@'')'				
	IF Isnull(@CampaignID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.CampaignID, '''') LIKE N''%'+@CampaignID+'%'') '
	IF Isnull(@CampaignName, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.CampaignName,'''') LIKE N''%'+@CampaignName+'%'' ) '
	IF Isnull(@AssignedToUserID, '') != ''
		SET @sWhere = @sWhere +  'AND (ISNULL(M.AssignedToUserID,'''') LIKE N''%'+@AssignedToUserID+'%'') '
	IF Isnull(@CampaignType, '') != ''
		SET @sWhere = @sWhere +  'AND (ISNULL(M.CampaignType,'''') LIKE N''%'+@CampaignType+'%'') '
	IF Isnull(@ExpectOpenDate, '') != '' 
		SET @sWhere = @sWhere +  'AND (CONVERT(VARCHAR(10),M.ExpectOpenDate,112) = '''+ CONVERT(VARCHAR(20),@ExpectOpenDate,112)+''')'
	IF Isnull(@ExpectCloseDate, '') != ''
		SET @sWhere = @sWhere + 'AND (CONVERT(VARCHAR(10),M.ExpectCloseDate,112) = '''+ CONVERT(VARCHAR(20),@ExpectCloseDate,112)+''')'
	IF Isnull(@CampaignStatus, '') != ''
		SET @sWhere = @sWhere + 'AND (ISNULL(M.CampaignStatus,'''') = N'''+@CampaignStatus+''' ) '
	IF Isnull(@IsCommon, '') != ''	 
		SET @sWhere = @sWhere + 'AND (ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' )'
	IF Isnull(@Disabled, '') != ''	 
		SET @sWhere = @sWhere + 'AND (ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'') '
	IF Isnull(@ConditionCampainID, '') != ''	 
		SET @sWhere = @sWhere + 'AND ISNULL(B.UserID, M.CreateUserID) In ('''+@ConditionCampainID+''') '
	IF Isnull(@PlaceDate, '') != ''
		SET @sWhere = @sWhere + 'AND (CONVERT(VARCHAR(10),M.PlaceDate,112) = '''+ CONVERT(VARCHAR(20),@PlaceDate,112)+''')'
End
IF isnull(@SearchWhere,'') !=''
Begin
	SET  @sWhere='1 = 1'
End

IF EXISTS(SELECT * FROM CustomerIndex WHERE CustomerName = 130)
BEGIN
    SET @CodeMaster = 'CRMT00000032'
END
ELSE 
BEGIN
    SET @CodeMaster = 'CRMT00000011'
END

IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
BEGIN
	SET @sJoin = 
	CASE
		WHEN @RelTable = 'CRMT20301_CRMT20401_REL' THEN 'LEFT JOIN ' +@RelTable+ ' D8 WITH (NOLOCK) ON D8.CampaignID = CONVERT(NVARCHAR(50), M.APK) '
		WHEN @RelTable IN ('CRMT2140', 'CRMT2190') THEN 'LEFT JOIN ' +@RelTable+ ' D8 WITH (NOLOCK) ON D8.CampaignID = M.CampaignID '
		ELSE @sJoin
	END

	SET @sWhere = 
	CASE
		WHEN @RelTable = 'CRMT20301_CRMT20401_REL' THEN ' D8.LeadID = ''' +@RelAPK+ ''' '
		WHEN @RelTable IN ('CRMT2140', 'CRMT2190') THEN ' D8.APK = ''' +@RelAPK+ ''' '
		ELSE @sWhere
	END
END

SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg,0) = 0'
SET @sSQL = ' SELECT Distinct M.APK, Case When isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID
					, M.CampaignID, M.CampaignName
					, M.CampaignType, D5.Description as CampaignTypeName
					, M.CampaignStatus, D7.StageName as CampaignStatusName
					, stuff(isnull((Select '', '' +  B.UserID From AT1103 A WITH (NOLOCK) 
						Left join AT1103_REL B WITH (NOLOCK) ON A.EmployeeID = B.UserID 
						where B.RelatedToID =convert(Varchar(50),M.APK) 
						Group by B.UserID
						FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as AssignedToUserID
					, stuff(isnull((Select '', '' + FullName From AT1103 A WITH (NOLOCK) 
						Left join AT1103_REL B WITH (NOLOCK) ON A.EmployeeID = B.UserID 
						where B.RelatedToID =convert(Varchar(50),M.APK) 
						Group by B.UserID, A.FullName
						FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as AssignedToUserName
					, M.Disabled, M.IsCommon
					, M.ExpectOpenDate, M.ExpectCloseDate, M.PlaceDate, M.Description
					, M.InventoryID, M.Sponsor
					, M.BudgetCost, M.ExpectedRevenue, M.ExpectedSales, M.ExpectedROI, M.ExpectedResponse
					, M.ActualCost, M.ActualSales, M.ActualROI, M.RelatedToTypeID
					, M.CreateUserID, M.CreateDate
					, M.LastModifyUserID, M.LastModifyDate, D7.Color
					into #CRMT20401Temp
			FROM CRMT20401 M With (NOLOCK) 
			Left join AT1103_REL B WITH (NOLOCK) ON B.RelatedToID =convert(Varchar(50),M.APK)
			left join CRMT0099 D5 With (NOLOCK) on M.CampaignType = D5.ID and D5.CodeMaster = '''+ @CodeMaster +'''
			--left join CRMT0099 D6 With (NOLOCK) on M.CampaignStatus = D6.ID and (D6.CodeMaster = ''CRMT00000012'' OR D6.CodeMaster = ''CRMT00000013'')
			LEFT JOIN CRMT10401 D7 WITH (NOLOCK) ON D7.StageID = M.CampaignStatus '
			+@sJoin+
			'					 
			WHERE '+@sWhere+'

	DECLARE @count int
			Select @count = Count(CampaignID) From #CRMT20401Temp
				'+Isnull(@SearchWhere,'')+'
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow, M.APK, M.DivisionID
			, M.CampaignID, M.CampaignName
			, M.CampaignType, M.CampaignTypeName
			, M.CampaignStatus, M.CampaignStatusName
			, M.AssignedToUserName AssignedToUserID
			, M.Disabled, M.IsCommon
			, M.ExpectOpenDate, M.ExpectCloseDate,M.PlaceDate, M.Description
			, M.InventoryID, M.Sponsor
			, M.BudgetCost, M.ExpectedRevenue, M.ExpectedSales, M.ExpectedROI, M.ExpectedResponse
			, M.ActualCost, M.ActualSales, M.ActualROI, M.RelatedToTypeID
			, M.CreateUserID, M.CreateDate
			, M.LastModifyUserID, M.LastModifyDate, M.Color
	FROM #CRMT20401Temp M
		'+Isnull(@SearchWhere,'')+'
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)
print (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
