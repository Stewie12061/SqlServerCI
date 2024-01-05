IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20501]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20501]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form CRMP20501 Danh muc cơ hội
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phan thanh hoàng vũ, Date: 08/03/2017
----Edited by: Phan thanh hoàng vũ, Date: 05/05/2017: Bổ sung điều kiện search phân quyền xem
--- Modify by Thị Phượng, Date 30/08/2017: Thay đổi cách sắp xếp order by theo CreateDate
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
--- Modify by Bảo Toàn, Date 20/02/2020: Bổ sung thông tin đầu mối [Customize DTI]
--- Modify by Tấn Thành, Date 16/09/2020: Bổ sung load dữ liệu AT1103 bao gồm Division dùng chung.
--- Modify by Vĩnh Tâm, Date 12/01/2021: Fix lỗi mất phân quyền dữ liệu khi dùng search nâng cao
--- Modify by Ngọc Long,  Date 30/06/2021: Bổ sung cột Color để hiển thị màu cho grid
--- Modify by Hoài Bảo,  Date 15/07/2021: Thay đổi cách lọc dữ kiệu @FromDate, @ToDate theo ngày tạo (CreateDate) thành ngày dự kiến kết thúc (ExpectedCloseDate)
--- Modify by Anh Tuấn,   Date 31/12/2021: Bổ sung điều kiện chỉ lấy những phiếu có DeleteFlg = 0
--- Modify by Hoài Thanh, Date 10/01/2023: Bổ sung luồng load dữ liệu từ dashboard
--- Modify by Hoài Bảo, Date 09/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example> EXEC CRMP20501 'CAAN' , '', '' , '' , '' , '' , '' , '' , '' , '' , 'NV01' , N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU', 1 , 20, ''

CREATE PROCEDURE CRMP20501 ( 
        @DivisionID VARCHAR(50) = '', --Biến môi trường
		@DivisionIDList NVARCHAR(2000) = '', --Chọn trong DropdownChecklist DivisionID
		@FromDate DATETIME = NULL,
		@ToDate DATETIME = NULL,
		@IsPeriod INT = 0,
		@PeriodList VARCHAR(MAX) = '',
        @OpportunityID NVARCHAR(50) = '',
        @OpportunityName NVARCHAR(250) = '',
		@StageID NVARCHAR(MAX) = '',
		@NextActionID NVARCHAR(250) = '',
		@PriorityID NVARCHAR(MAX) = '',
		@AssignedToUserID NVARCHAR(250) = '',
		@IsCommon NVARCHAR(100) = '',
		@Disabled NVARCHAR(100) = '',
		@UserID  VARCHAR(50) = '',
		@ConditionOpportunityID NVARCHAR(MAX) = '',
		@PageNumber INT = 1,
		@PageSize INT = 25,
		@SearchWhere NVARCHAR(MAX) = null,
		@S1 NVARCHAR(250) = '',
		@Address NVARCHAR(250) = '',
		@AccountName NVARCHAR(250) = '',
		@Type INT = 2, -- Type = 6: từ dashboard -> danh mục
		@IsNoComunicateOpp INT = 0,-- 1: lấy dữ liệu cơ hội lâu không tương tác
		@CompareDate SMALLINT = 0,
		@EmployeeIDList NVARCHAR(MAX) = NULL,
		@RelAPK NVARCHAR(250) = '',
		@RelTable NVARCHAR(250) = ''
)
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX) = '',
		@sWhereDashboard NVARCHAR(MAX) = '1 = 1',
		@OrderBy NVARCHAR(500),
		@sSql_Join NVARCHAR(MAX) = '',
		@sSql_Select_LeadName_Join NVARCHAR(MAX) = ''''' AS LeadName, ',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
		@DayCompare VARCHAR(10)

SET @sWhere = '1 = 1'
SET @OrderBy = 'M.CreateDate DESC'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
DECLARE @CustomizeIndex INT = (SELECT TOP 1 CustomerName FROM CustomerIndex)

IF ISNULL(@SearchWhere, '') =''
Begin
	--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionIDList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
			SET @sWhereDashboard = @sWhereDashboard + ' AND M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
		END
	ELSE
		SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'

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

	IF ISNULL(@OpportunityID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityID, '''') LIKE N''%' + @OpportunityID + '%'' '
	IF ISNULL(@OpportunityName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityName, '''') LIKE N''%' + @OpportunityName + '%''  '
	IF ISNULL(@StageID, '') != ''
		BEGIN
			SET @sWhere = @sWhere + 'AND (ISNULL(M.StageID, '''') IN (''' + @StageID + ''') OR ISNULL(D1.StageName, '''') IN (''' + @StageID + ''')) '
			SET @sWhereDashboard = @sWhereDashboard + 'AND (ISNULL(M.StageID, '''') IN (''' + @StageID + ''') OR ISNULL(D1.StageName, '''') IN (''' + @StageID + ''')) '
		END
	IF ISNULL(@NextActionID, '') != ''
		SET @sWhere = @sWhere + 'AND (ISNULL(M.NextActionID, '''') LIKE N''%' + @NextActionID + '%'' OR ISNULL(D7.NextActionName, '''') LIKE N''%' + @NextActionID + '%'')'
	IF ISNULL(@PriorityID, '') != '' 
		SET @sWhere = @sWhere + 'AND ISNULL(M.PriorityID, '''') IN (''' + @PriorityID + ''') '
	IF ISNULL(@AssignedToUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.AssignedToUserID, '''') LIKE N''%' + @AssignedToUserID + '%'' OR ISNULL(D4.FullName, '''') LIKE N''%' + @AssignedToUserID + '%'' )'
	IF ISNULL(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, '''') LIKE N''%' + @IsCommon + '%'' '
	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, '''') LIKE N''%' + @Disabled + '%'' '
	IF ISNULL(@ConditionOpportunityID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.AssignedToUserID, '''') IN (''' + @ConditionOpportunityID + ''' ) OR ISNULL(M.CreateUserID, '''') IN (''' + @ConditionOpportunityID + ''' ))'
	IF ISNULL(@S1, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.S1, '''') LIKE N''%' + @S1 + '%''  '
	IF ISNULL(@Address, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(D8.Address, '''') LIKE N''%' + @Address + '%''  '
	IF ISNULL(@AccountName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(D8.ObjectName, '''') LIKE N''%' + @AccountName + '%''  '
END
IF ISNULL(@SearchWhere, '') !=''
BEGIN
	SET  @sWhere = '1 = 1'
	IF ISNULL(@ConditionOpportunityID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.AssignedToUserID, M.CreateUserID) IN (N''' + @ConditionOpportunityID + ''' )'
END
--CustomizeIndex Đức Tín - bổ sung thông tin tên đầu mối
IF @CustomizeIndex = 114
BEGIN
	SET @sSql_Select_LeadName_Join = 'CRMT20301.LeadName, '
	SET @sSql_Join = '
		LEFT JOIN (
			SELECT MM.OpportunityID, DD.DivisionID, 
				STUFF((
				SELECT '', '' + DD1.LeadName
				FROM CRMT20501_CRMT20301_REL MM1 WITH (NOLOCK)
							INNER JOIN CRMT20301 DD1 WITH (NOLOCK) ON MM1.LeadID = DD1.APK
				WHERE MM.OpportunityID + DD.DivisionID = MM1.OpportunityID + DD1.DivisionID
				FOR XML PATH(''''), TYPE).value(''(./text())[1]'', ''NVARCHAR(MAX)'')
				, 1, 2, '''') AS LeadName
			FROM CRMT20501_CRMT20301_REL MM WITH (NOLOCK)
					INNER JOIN CRMT20301 DD WITH (NOLOCK) ON MM.LeadID = DD.APK
					GROUP BY MM.OpportunityID, DD.DivisionID
			) AS CRMT20301 ON M.APK = CRMT20301.OpportunityID AND M.DivisionID = CRMT20301.DivisionID
	'
END
SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg,0) = 0 '
SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.DeleteFlg,0) = 0 '

IF @Type = 6
	BEGIN
		IF @IsNoComunicateOpp = 1 
			BEGIN
				SET @DayCompare = CONVERT(NVARCHAR(10), DATEADD(DAY,-@CompareDate, GETDATE()), 111)
				SET @sWhereDashboard = @sWhereDashboard + ' AND CONVERT(NVARCHAR(10), M.LastModifyDate, 111) < ''' + @DayCompare + ''' AND (CONVERT(NVARCHAR(10), C3.LastModifyDate, 111) < ''' + @DayCompare + ''' OR C3.LastModifyDate IS NULL)'
			END

		IF ISNULL(@EmployeeIDList, '') != ''
			SET @sWhereDashboard = @sWhereDashboard + ' AND (ISNULL(M.AssignedToUserID, '''') IN (N''' + @EmployeeIDList + ''' ) OR ISNULL(M.CreateUserID, '''') IN (N''' + @EmployeeIDList + ''' ))'
		SET @sWhere1 = 'WHERE ' + @sWhereDashboard + ' '
	END
ELSE --@Type = 2
BEGIN
	IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
	BEGIN
		SET @sSql_Join = 
		CASE
			WHEN @RelTable = 'CRMT20501_CRMT20301_REL' THEN 'LEFT JOIN ' +@RelTable+ ' C4 WITH (NOLOCK) ON M.APK = C4.OpportunityID '
			WHEN @RelTable = 'CRMT20501_CRMT10101_REL' THEN 'LEFT JOIN ' +@RelTable+ ' C4 WITH (NOLOCK) ON M.APK = C4.OpportunityID '
			WHEN @RelTable = 'CRMT0088' THEN 'LEFT JOIN ' +@RelTable+ ' C4 WITH (NOLOCK) ON M.APK = C4.APKParent '
			WHEN @RelTable = 'OOT2100' THEN 'LEFT JOIN ' +@RelTable+ ' C4 WITH (NOLOCK) ON M.OpportunityID = C4.OpportunityID '
			WHEN @RelTable = 'CRMT20501_CRMT10001_REL' THEN 'LEFT JOIN ' +@RelTable+ ' C4 WITH (NOLOCK) ON C4.OpportunityID = M.APK '
			WHEN @RelTable IN ('OT2101', 'CRMT20801') THEN 'LEFT JOIN ' +@RelTable+ ' C4 WITH (NOLOCK) ON C4.OpportunityID = M.OpportunityID '
			ELSE @sSql_Join
		END

		SET @sWhere1 = 
		CASE
			WHEN @RelTable = 'CRMT20501_CRMT20301_REL' THEN 'WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C4.LeadID = ''' +@RelAPK+''' AND M.DeleteFlg = 0'
			WHEN @RelTable = 'CRMT20501_CRMT10101_REL' THEN 'WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C4.AccountID = ''' +@RelAPK+''' AND M.DeleteFlg = 0'
			WHEN @RelTable = 'CRMT0088' THEN 'WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C4.APKChild = ''' +@RelAPK+''' AND M.DeleteFlg = 0'
			WHEN @RelTable = 'OOT2100' THEN 'WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C4.APK = ''' +@RelAPK+''' AND M.DeleteFlg = 0'
			WHEN @RelTable = 'CRMT20501_CRMT10001_REL' THEN 'WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C4.ContactID = ''' +@RelAPK+''' AND M.DeleteFlg = 0'
			WHEN @RelTable IN ('OT2101', 'CRMT20801') THEN 'WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C4.APK = ''' +@RelAPK+''' AND M.DeleteFlg = 0'
			ELSE 'WHERE ' + @sWhere + ' '
		END
	END
	ELSE
		SET @sWhere1 = 'WHERE ' + @sWhere + ' '
END

SET @sSQL = ' SELECT DISTINCT M.APK, M.DivisionID, M.OpportunityID, M.OpportunityName, ' + @sSql_Select_LeadName_Join + ' M.StageID, D1.StageName, D1.Color
					, M.CampaignID, M.AccountID, M.ExpectAmount, M.PriorityID, D6.Description AS PriorityName, M.CauseID
					, M.Notes, M.AssignedToUserID, D4.FullName AS AssignedToUserName, M.SourceID, M.StartDate, M.ExpectedCloseDate, M.Rate
					, M.NextActionID, D7.NextActionName, M.NextActionDate, M.Disabled, M.IsCommon, M.CreateUserID, M.CreateDate, D8.ObjectName AS AccountName
					, M.LastModifyUserID, M.LastModifyDate, B.Description AS StatusName INTO #TempCRMT2051
			FROM CRMT20501 M WITH (NOLOCK)   LEFT JOIN CRMT10401 D1 WITH (NOLOCK) ON M.StageID = D1.StageID
											 LEFT JOIN AT1103 D4 WITH (NOLOCK) ON M.AssignedToUserID = D4.EmployeeID AND D4.DivisionID IN (N''' + @DivisionID + ''', ''@@@'')
											 LEFT JOIN CRMT0099 D6 WITH (NOLOCK) ON M.PriorityID = D6.ID AND D6.CodeMaster = ''CRMT00000006''
											 LEFT JOIN CRMT10801 D7 WITH (NOLOCK) ON M.NextActionID = D7.NextActionID
											 LEFT JOIN AT1202 D8 WITH (NOLOCK) ON M.AccountID = D8.ObjectID
											 LEFT JOIN OOT0099 B WITH (NOLOCK) ON ISNULL(M.Status, 0) = B.ID AND B.CodeMaster = ''Status'' AND B.Disabled = 0
											 LEFT JOIN CRMT90031_REL C2 ON M.APK = C2.RelatedToID
											 LEFT JOIN CRMT90031 C3 ON C2.NotesID = C3.NotesID
											 ' + @sSql_Join + '
			' + @sWhere1 + '

			DECLARE @count INT
			SELECT @count = COUNT(OpportunityID) FROM #TempCRMT2051
			' + ISNULL(@SearchWhere, '') + '
			SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
					, M.APK, CASE WHEN M.IsCommon = 1 THEN '''' ELSE M.DivisionID END DivisionID
					, M.OpportunityID, M.OpportunityName, M.LeadName, M.StageID, M.StageName
					, M.CampaignID, M.AccountID, M.ExpectAmount, M.PriorityID, M.PriorityName, M.CauseID
					, M.Notes, M.AssignedToUserID, M.AssignedToUserName, M.SourceID, M.StartDate, M.ExpectedCloseDate, M.Rate
					, M.NextActionID, M.NextActionName, M.NextActionDate, M.Disabled, M.IsCommon, M.CreateUserID, M.CreateDate
					, M.LastModifyUserID, M.LastModifyDate, M.AccountName, M.StatusName, M.Color
			FROM #TempCRMT2051 M
			' + ISNULL(@SearchWhere, '') + '
			ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
--PRINT (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
