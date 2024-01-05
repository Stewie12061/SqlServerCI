IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20301]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20301]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form CRMP20301 Danh muc đầu mối
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 14/03/2017
--- Modify by Thị Phượng, Date 24/04/2017: Cải tiến tốc độ
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
--- Modify by Thị Phượng, Date 09/05/2017: Ẩn đi 2 cột loại chuyển đổi và mã KH
--- Modify by Thị Phượng, Date 30/08/2017: Thay đổi cách sắp xếp order by theo CreateDate
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
--- Modify by Vĩnh Tâm,	  Date 06/04/2019: Bổ sung CampaignID
--- Modify by Đoàn Duy,	  Date 27/11/2020: Bổ sung TradeMarkID mặc đinh là NULL
--- Modify by Vĩnh Tâm,	  Date 05/01/2021: Cập nhật điều kiện search nhiều cho Chiến dịch, Tình trạng và Nguồn đầu mối
--- Modify by Vĩnh Tâm,	  Date 08/01/2021: Fix lỗi không sử dụng được search nâng cao cho source chuẩn.
--- Modify by Vĩnh Tâm,	  Date 12/01/2021: Fix lỗi mất phân quyền dữ liệu khi dùng search nâng cao
--- Modify by Ngọc Long,  Date 30/06/2021: Bổ sung cột Color để hiển thị màu cho grid
--- Modify by Anh Tuấn,   Date 31/12/2021: Bổ sung điều kiện chỉ lấy những phiếu có DeleteFlg = 0
--- Modify by Hoài Thanh, Date 10/01/2023: Bổ sung luồng load dữ liệu từ dashboard
--- Modify by Hoài Bảo, Date 06/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example>
/*
EXEC CRMP20301 'AS' ,'','' ,'' ,'' ,'' ,'' ,'' ,'' ,'' ,'','','', 'NV01',N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU' ,1 , 100,''
*/

CREATE PROCEDURE CRMP20301 (
		@DivisionID VARCHAR(50) = '',	-- Biến môi trường
		@DivisionIDList NVARCHAR(2000) = '',	-- Chọn trong DropdownChecklist DivisionID
		@FromDate DATETIME = NULL,
		@ToDate DATETIME = NULL,
		@IsPeriod INT = 0,
		@PeriodList VARCHAR(MAX) = '',
		@LeadID NVARCHAR(50) = '',
		@LeadName NVARCHAR(250) = '',
		@AssignedToUserID NVARCHAR(250) = '',
		@Address NVARCHAR(250) = '',
		@Phone NVARCHAR(250) = '',
		@Email NVARCHAR(250) = '',
		@LeadTypeID NVARCHAR(250) = '',
		@CampaignID NVARCHAR(MAX) = '',
		@LeadStatusID NVARCHAR(MAX) = '',
		@LeadSourceID NVARCHAR(MAX) = '',
		@IsCommon NVARCHAR(100) = '',
		@Disabled NVARCHAR(100) = '',
		@TradeMarkID NVARCHAR(50) = NULL,
		@UserID VARCHAR(50) = '',
		@ConditionLeadID NVARCHAR(MAX),
		@PageNumber INT = 1,
		@PageSize INT = 25,
		@SearchWhere NVARCHAR(MAX) = NULL,
		@Type INT = 2, -- Type = 6: từ dashboard -> danh mục
		@IsNoComunicateLead INT = 0,-- 1: lấy dữ liệu đầu mối lâu không tương tác
		@CompareDate SMALLINT = 0,
		@RelAPK VARCHAR(50) = '', -- APK liên kết nghiệp vụ
		@RelTable VARCHAR(50) = '' -- Bảng liên kết nghiệp vụ
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX) = '',
		@sWhereDashboard NVARCHAR(MAX) = '',
		@OrderBy NVARCHAR(500),
		@CustomerIndex INT,
		@sWhereSearch NVARCHAR(MAX),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
		@DayCompare VARCHAR(10)

SET @sWhere = ''
SET @OrderBy = 'M.CreateDate DESC, M.LeadID DESC'
SET @sWhereSearch = ''
SET @sSQL1 = ''
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

SELECT @CustomerIndex = CustomerName FROM CustomerIndex

IF ISNULL(@SearchWhere,'') = ''
BEGIN
	-- Check Parameter DivisionIDList NULL then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		BEGIN
			SET @sWhere = ' M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
			SET @sWhereDashboard = ' M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
		END
	ELSE
		SET @sWhere = ' M.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'

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
		SET @sWhereDashboard = @sWhereDashboard + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	IF ISNULL(@LeadID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.LeadID, '''') LIKE N''%' + @LeadID + '%'' '
	IF ISNULL(@LeadName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.LeadName, '''') LIKE N''%' + @LeadName + '%'' '
	IF ISNULL(@AssignedToUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.AssignedToUserID, '''') LIKE N''%' + @AssignedToUserID + '%'' OR ISNULL(D4.FullName, '''') LIKE N''%' + @AssignedToUserID + '%'' )'
	IF ISNULL(@Phone, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.LeadMobile, '''') LIKE N''%' + @Phone + '%'' OR ISNULL(LeadTel, '''') LIKE N''%' + @Phone + '%'') '
	IF ISNULL(@Address, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Address, '''') LIKE N''%' + @Address + '%'' '
	IF ISNULL(@Email, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Email, '''') LIKE N''%' + @Email + '%'' '
	IF ISNULL(@LeadTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.LeadTypeID, '''') IN (''' + @LeadTypeID + ''') '
	IF ISNULL(@CampaignID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.CampaignID, '''') IN (''' + @CampaignID + ''') '
	IF ISNULL(@LeadStatusID, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND ISNULL(M.LeadStatusID, '''') IN (''' + @LeadStatusID + ''') '
			SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.LeadStatusID, '''') IN (''' + @LeadStatusID + ''') '
		END
	IF ISNULL(@LeadSourceID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.LeadSourceID, '''') LIKE N''%' + @LeadSourceID + '%'' '
	IF ISNULL(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, '''') LIKE N''%' + @IsCommon + '%'' '
	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, '''') LIKE N''%' + @Disabled + '%'' '
	IF ISNULL(@TradeMarkID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TradeMarkID, '''') LIKE N''%' + @TradeMarkID + '%'' '
	IF ISNULL(@ConditionLeadID,'') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.AssignedToUserID, '''') IN (''' + @ConditionLeadID + ''' ) OR ISNULL(M.CreateUserID, '''') IN (''' + @ConditionLeadID + ''' ))'
END

IF ISNULL(@SearchWhere, '') != ''
	BEGIN
		SET @sWhere = '1 = 1'
		IF ISNULL(@ConditionLeadID,'') != ''
			SET @sWhere = @sWhere + ' AND (ISNULL(M.AssignedToUserID, '''') IN (''' + @ConditionLeadID + ''' ) OR ISNULL(M.CreateUserID, '''') IN (''' + @ConditionLeadID + ''' ))'

		SET @sWhereSearch = @SearchWhere
	
		-- Customize search nâng cao cho CBD
		IF (@CustomerIndex = 130)
		BEGIN
			SET @sSQL1 = 'SELECT M.APK, M.DivisionID, M.LeadID, M.LeadName, ISNULL(M.LeadMobile, M.LeadTel) AS LeadMobile
							, M.Address, M.Email, M.LeadTypeID, B.LeadTypeName, M.LeadStatusID
							, M.AssignedToUserID, D4.FullName AS AssignedToUserName
							, D8.Description AS TradeMarkID, M.Disabled, M.IsCommon
							, D.CampaignDetailID, D7.CampaignName AS CampaignDetailName, D.StatusDetailID, D11.StageName AS StatusDetailName
							, S.Value AS SerminarID, D9.Description AS SerminarName
							, T.Value AS ThematicID, D10.Description AS ThematicName
						INTO #TempCRMT20301_02
						FROM CRMT20301 M WITH (NOLOCK)
							LEFT JOIN CRMT10201 B WITH (NOLOCK) ON B.LeadTypeID = M.LeadTypeID
							LEFT JOIN AT1103 D4 WITH (NOLOCK) ON M.AssignedToUserID = D4.EmployeeID
							LEFT JOIN CRMT10401 D1 WITH (NOLOCK) ON M.LeadStatusID = D1.StageID
							LEFT JOIN CRMT0099 D6 WITH (NOLOCK) ON M.LeadSourceID = D6.ID AND D6.CodeMaster = ''CRMT00000008''
							LEFT JOIN CRMT0099 D8 WITH (NOLOCK) ON M.TradeMarkID = D8.ID AND D8.CodeMaster = ''CRMT00000028''
							LEFT JOIN CRMT20302 D WITH (NOLOCK) ON M.APK = D.APKMaster
							LEFT JOIN (SELECT S1.*, D1.APK FROM CRMT20302 D1 WITH (NOLOCK) 
									   CROSS APPLY StringSplit(D1.SerminarID, '','') S1) S ON S.APK = D.APK
							LEFT JOIN (SELECT T1.*, D1.APK FROM CRMT20302 D1 WITH (NOLOCK)
										CROSS APPLY StringSplit(D1.ThematicID, '','') T1) T ON T.APK = D.APK
							LEFT JOIN CRMT20401 D7 WITH (NOLOCK) ON D.CampaignDetailID = D7.CampaignID
							LEFT JOIN CRMT0099 D9 WITH (NOLOCK) ON D9.ID = S.Value
							LEFT JOIN CRMT0099 D10 WITH (NOLOCK) ON D10.ID = T.Value
							LEFT JOIN CRMT10401 D11 WITH (NOLOCK) ON D.StatusDetailID = D11.StageID

						SELECT DISTINCT APK
						INTO #TempCRMT20301_APK
						FROM #TempCRMT20301_02
						' + ISNULL(@SearchWhere,'') + '

					SELECT @Count = COUNT(APK) FROM #TempCRMT20301_APK'

			SET @sWhereSearch = 'WHERE M.APK IN (SELECT APK FROM #TempCRMT20301_APK)'
		END
	END
SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg,0) = 0 '
SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.DeleteFlg,0) = 0 '

IF @Type = 6
	BEGIN
		IF @IsNoComunicateLead = 1 
			BEGIN
				SET @DayCompare = CONVERT(NVARCHAR(10), DATEADD(DAY,-@CompareDate, GETDATE()), 111)
				SET @sWhereDashboard = @sWhereDashboard + ' AND CONVERT(NVARCHAR(10), M.LastModifyDate, 111) < ''' + @DayCompare + ''' AND (CONVERT(NVARCHAR(10), C3.LastModifyDate, 111) < ''' + @DayCompare + ''' OR C3.LastModifyDate IS NULL)'
			END
		SET @sWhere1 = 'WHERE ' + @sWhereDashboard + ' '
	END
ELSE --@Type = 2
BEGIN
	IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
	BEGIN
		SET @sWhere1 = 
		CASE
			WHEN @RelTable = 'CRMT0088' THEN 'LEFT JOIN ' +@RelTable+ ' C4 WITH (NOLOCK) ON M.APK = C4.APKParent
										WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C4.APKChild = ''' +@RelAPK+ ''' AND M.DeleteFlg = 0'
			WHEN @RelTable = 'OOT0088' THEN 'LEFT JOIN ' +@RelTable+ ' C4 WITH (NOLOCK) ON C4.APKChild = M.APK
										WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C4.APKParent = ''' +@RelAPK+ ''' AND M.DeleteFlg = 0'
			WHEN @RelTable = 'CRMT20501_CRMT20301_REL' THEN 'LEFT JOIN ' +@RelTable+ ' C4 WITH (NOLOCK) ON C4.LeadID = M.APK
										WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C4.OpportunityID = ''' +@RelAPK+ ''' AND M.DeleteFlg = 0'
			WHEN @RelTable = 'CRMT20301_CRMT10001_REL' THEN 'INNER JOIN ' +@RelTable+ ' C4 WITH (NOLOCK) ON C4.LeadID = M.APK
										WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C4.ContactID = ''' +@RelAPK+ ''' AND M.DeleteFlg = 0'
			ELSE ' WHERE  ' + @sWhere + ' '
		END
	END
	ELSE
		SET @sWhere1 = ' WHERE ' + @sWhere + ' '
END

SET @sSQL = N'
	SELECT DISTINCT M.APK, M.DivisionID, M.LeadID, M.LeadName, ISNULL(M.LeadMobile, M.LeadTel) AS LeadMobile
			, M.Address, M.Email, M.LeadTypeID, B.LeadTypeName, M.LeadStatusID, D1.StageName AS LeadStatusName
			, M.LeadSourceID, B.LeadTypeName AS LeadSourceName, M.AssignedToUserID, D4.FullName AS AssignedToUserName
			, M.JobID, M.Disabled, M.IsCommon, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate
			, NULL AS IsConvert, NULL AS InheritAccountID, D7.CampaignName, D8.Description AS TradeMarkID, M.Description
			, D1.Color, M.CompanyName
	INTO #TempCRMT20301
	FROM CRMT20301 M WITH (NOLOCK)
		LEFT JOIN CRMT10201 B WITH (NOLOCK) ON B.LeadTypeID = M.LeadTypeID
		LEFT JOIN AT1103 D4 WITH (NOLOCK) ON M.AssignedToUserID = D4.EmployeeID AND D4.DivisionID = M.DivisionID
		LEFT JOIN CRMT10401 D1 WITH (NOLOCK) ON M.LeadStatusID = D1.StageID
		LEFT JOIN CRMT0099 D6 WITH (NOLOCK) ON M.LeadSourceID = D6.ID AND D6.CodeMaster = ''CRMT00000008''
		LEFT JOIN CRMT20401 D7 WITH (NOLOCK) ON M.CampaignID = D7.CampaignID
		LEFT JOIN CRMT0099 D8 WITH (NOLOCK) ON M.TradeMarkID = D8.ID AND D8.CodeMaster = ''CRMT00000028''
		LEFT JOIN CRMT90031_REL C2 ON M.APK = C2.RelatedToID
		LEFT JOIN CRMT90031 C3 ON C2.NotesID = C3.NotesID
	' + @sWhere1 + '

	DECLARE @Count INT
	SELECT @Count = COUNT(LeadID) FROM #TempCRMT20301

	' + @sSQL1 + '

	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow,
		  M.APK, IIF(ISNULL(M.IsCommon, 0) = 1, '''', M.DivisionID) AS DivisionID
		, M.LeadID, M.LeadName, M.LeadMobile, M.Address, M.Email, M.LeadTypeID, M.LeadTypeName
		, M.LeadStatusID, M.LeadStatusName, M.LeadSourceID, M.LeadSourceName, M.AssignedToUserID, M.AssignedToUserName
		, M.JobID, M.Disabled, M.IsCommon, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
		, M.IsConvert, M.InheritAccountID, M.CampaignName, M.TradeMarkID, M.Description, M.Color, M.CompanyName
	FROM #TempCRMT20301 M
	' + ISNULL(@sWhereSearch, '') + '
	ORDER BY ' + @OrderBy + '
	OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
--PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
