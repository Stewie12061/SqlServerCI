IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2280]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2280]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
--- Load màn hình chọn phiếu nghiệp vụ
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Tấn Lộc Date 09/10/2020
-- <Example>
/*
	EXEC OOP2280 @DivisionID=N'KY',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[OOP2280] (
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @ModuleID NVARCHAR(250),
	 @ScreenID NVARCHAR(250),
	 @TableID NVARCHAR(250),
	 @VoucherBusiness NVARCHAR(MAX),
	 @VoucherBusinessName NVARCHAR(MAX),
	 @CreateUserID NVARCHAR (250),
	 @LastModifyUserID NVARCHAR(250),
	 @IsCommon NVARCHAR(100), 
	 @Disabled NVARCHAR(100),
	 @UserID VARCHAR(50), 
	 @PageNumber INT,
	 @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	 @sWhere NVARCHAR(MAX),
	 @OrderBy NVARCHAR(500),
	 @TotalRow NVARCHAR(50),
	 @FromDateText NVARCHAR(20),
	 @ToDateText NVARCHAR(20)

SET @sWhere = '1 = 1'
SET @OrderBy = 'M.CreateDate DESC'

-- Load phiếu công việc
IF (@TableID = 'OOT2110')
BEGIN
	SET @sSQL = 'SELECT M.APK, M.TaskID AS VoucherBusiness , M.TaskName AS VoucherBusinessName, M.CreateDate
		INTO #TemOOT2110
		FROM OOT2110 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0 AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2110 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemOOT2110 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load phiếu dự án
IF (@TableID = 'OOT2100')
BEGIN
	
	SET @sSQL = 'SELECT M.APK, M.ProjectID AS VoucherBusiness , M.ProjectName AS VoucherBusinessName, M.CreateDate
		INTO #TemOOT2100
		FROM OOT2100 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0 AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2100 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemOOT2100 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load phiếu Milestone
IF (@TableID = 'OOT2190')
BEGIN
	
	SET @sSQL = 'SELECT M.APK, M.MilestoneID AS VoucherBusiness , M.MilestoneName AS VoucherBusinessName, M.CreateDate
		INTO #TemOOT2190
		FROM OOT2190 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0 AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2190 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemOOT2190 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load phiếu Release
IF (@TableID = 'OOT2210')
BEGIN
	SET @sSQL = 'SELECT M.APK, M.ReleaseID AS VoucherBusiness , M.ReleaseName AS VoucherBusinessName, M.CreateDate
		INTO #TemOOT2210
		FROM OOT2210 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0 AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2210 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemOOT2210 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- load phiếu vấn đề
IF (@TableID = 'OOT2160')
BEGIN
	SET @sSQL = 'SELECT M.APK, M.IssuesID AS VoucherBusiness , M.IssuesName AS VoucherBusinessName, M.CreateDate
		INTO #TemOOT2160
		FROM OOT2160 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0 AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2160 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemOOT2160 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load phiếu Yêu cầu hỗ trợ
IF (@TableID = 'OOT2170')
BEGIN
	
	SET @sSQL = 'SELECT M.APK, M.SupportRequiredID AS VoucherBusiness , M.SupportRequiredName AS VoucherBusinessName, M.CreateDate
		INTO #TemOOT2170
		FROM OOT2170 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0 AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2170 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemOOT2170 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- load phiếu đầu mối
IF (@TableID = 'CRMT20301')
BEGIN
	
	SET @sSQL = 'SELECT M.APK, M.LeadID AS VoucherBusiness , M.LeadName AS VoucherBusinessName, M.CreateDate
		INTO #TemCRMT20301
		FROM CRMT20301 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemCRMT20301 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemCRMT20301 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load phiếu cơ hội
IF (@TableID = 'CRMT20501')
BEGIN
	
	SET @sSQL = 'SELECT M.APK, M.OpportunityID AS VoucherBusiness , M.OpportunityName AS VoucherBusinessName, M.CreateDate
		INTO #TemCRMT20501
		FROM CRMT20501 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemCRMT20501 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemCRMT20501 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load phiếu yêu cầu
IF (@TableID = 'CRMT20801')
BEGIN
	
	SET @sSQL = 'SELECT M.APK, M.RequestCustomerID AS VoucherBusiness , M.RequestSubject AS VoucherBusinessName, M.CreateDate
		INTO #TemCRMT20801
		FROM CRMT20801 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemCRMT20801 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemCRMT20801 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load phiếu khách hàng
IF (@TableID = 'CRMT10001')
BEGIN
	SET @sSQL = 'SELECT M.APK, M.ContactID AS VoucherBusiness , M.ContactName AS VoucherBusinessName, M.CreateDate
		INTO #TemCRMT10001
		FROM CRMT10001 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemCRMT10001 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemCRMT10001 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load phiếu Liên hệ
IF (@TableID = 'CRMT10101')
BEGIN
	
	SET @sSQL = 'SELECT M.APK, M.MemberID AS VoucherBusiness , M.MemberName AS VoucherBusinessName, M.CreateDate
		INTO #TemPOST0011
		FROM POST0011 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemPOST0011 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemPOST0011 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load phiếu chiến dịch
IF (@TableID = 'CRMT20401')
BEGIN
	
	SET @sSQL = 'SELECT M.APK, M.CampaignID AS VoucherBusiness , M.CampaignName AS VoucherBusinessName, M.CreateDate
		INTO #TemCRMT20401
		FROM CRMT20401 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemCRMT20401 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemCRMT20401 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load phiéu hợp đồng
IF (@TableID = 'CIFT1360')
BEGIN
	
	SET @sSQL = 'SELECT M.APK, M.ContractNo AS VoucherBusiness , M.ContractName AS VoucherBusinessName, M.CreateDate
		INTO #TemAT1020
		FROM AT1020 M WITH (NOLOCK)
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemAT1020 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.VoucherBusiness, M.VoucherBusinessName, M.CreateDate
		FROM #TemAT1020 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load danh sách folder (Public)
IF (@TableID = 'OOT2250')
BEGIN
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	SET @sWhere = ''

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionID + ''')'

	SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg, 1) = 1'

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

	IF ISNULL(@VoucherBusiness, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.FolderID, '''') LIKE N''%' + @VoucherBusiness + '%'' '

	IF ISNULL(@VoucherBusinessName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.FolderName, '''') LIKE N''%' + @VoucherBusinessName + '%'' '

	IF ISNULL(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.CreateUserID LIKE N''%' + @CreateUserID + '%'' OR A1.FullName LIKE N''%' + @CreateUserID + '%'') '

	IF ISNULL(@LastModifyUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.LastModifyUserID LIKE N''%' + @LastModifyUserID + '%'' OR A1.FullName LIKE N''%' + @LastModifyUserID + '%'') '

	SET @sSQL = 'SELECT M.APK, M.APK AS APKBusiness, M.DivisionID, M.FolderID AS VoucherBusiness, M.FolderName AS VoucherBusinessName
						, M.CreateUserID, A1.FullName AS CreateUserName, M.CreateDate
						, M.LastModifyUserID, A2.FullName AS LastModifyUserName, M.LastModifyDate
						, ''OOT2250'' AS sysTable
		INTO #TemOOT2250
		FROM OOT2250 M WITH (NOLOCK)
		LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
		LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = M.CreateUserID
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2250 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.APKBusiness, M.DivisionID, M.VoucherBusiness, M.VoucherBusinessName
		  , M.CreateUserID, M.CreateUserName, M.CreateDate
		  , M.LastModifyUserID, M.LastModifyUserName, M.LastModifyDate
		  , M.sysTable
		FROM #TemOOT2250 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load danh sách file (Public)
IF (@TableID = 'OOT2260')
BEGIN
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	SET @sWhere = ''

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionID + ''')'

	SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg, 1) = 1'

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

	IF ISNULL(@VoucherBusiness, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.FileID, '''') LIKE N''%' + @VoucherBusiness + '%'' '

	IF ISNULL(@VoucherBusinessName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.FileName, '''') LIKE N''%' + @VoucherBusinessName + '%'' '

	IF ISNULL(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.CreateUserID LIKE N''%' + @CreateUserID + '%'' OR A1.FullName LIKE N''%' + @CreateUserID + '%'') '

	IF ISNULL(@LastModifyUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.LastModifyUserID LIKE N''%' + @LastModifyUserID + '%'' OR A1.FullName LIKE N''%' + @LastModifyUserID + '%'') '

	SET @sSQL = 'SELECT M.APK, M.APK AS APKBusiness, M.DivisionID, M.FileID AS VoucherBusiness, M.FileName AS VoucherBusinessName
						, M.CreateUserID, A1.FullName AS CreateUserName, M.CreateDate
						, M.LastModifyUserID, A2.FullName AS LastModifyUserName, M.LastModifyDate
						, ''OOT2260'' AS sysTable, M.APKMaster_OOT2250
		INTO #TemOOT2260
		FROM OOT2260 M WITH (NOLOCK)
		LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
		LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = M.CreateUserID
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2260 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow,
			M.APK, M.APKBusiness, M.DivisionID, M.VoucherBusiness, M.VoucherBusinessName
		  , M.CreateUserID, M.CreateUserName, M.CreateDate
		  , M.LastModifyUserID, M.LastModifyUserName, M.LastModifyDate
		  , M.sysTable, M.APKMaster_OOT2250
		FROM #TemOOT2260 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

-- Load danh sách file (Cá nhân)
IF (@TableID = 'OOT2270')
BEGIN
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	SET @sWhere = ''

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionID + ''')'

	SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg, 1) = 1'

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

	IF ISNULL(@VoucherBusiness, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.FileID, '''') LIKE N''%' + @VoucherBusiness + '%'' '

	IF ISNULL(@VoucherBusinessName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.FileName, '''') LIKE N''%' + @VoucherBusinessName + '%'' '

	IF ISNULL(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.CreateUserID LIKE N''%' + @CreateUserID + '%'' OR A1.FullName LIKE N''%' + @CreateUserID + '%'') '

	IF ISNULL(@LastModifyUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.LastModifyUserID LIKE N''%' + @LastModifyUserID + '%'' OR A1.FullName LIKE N''%' + @LastModifyUserID + '%'') '

	SET @sSQL = 'SELECT M.APK, M.APK AS APKBusiness, M.DivisionID, M.FileID AS VoucherBusiness, M.FileName AS VoucherBusinessName
						, M.CreateUserID, A1.FullName AS CreateUserName, M.CreateDate
						, M.LastModifyUserID, A2.FullName AS LastModifyUserName, M.LastModifyDate
						, ''OOT2270'' AS sysTable
		INTO #TemOOT2270
		FROM OOT2270 M WITH (NOLOCK)
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
			LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = M.CreateUserID
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2270 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			, M.APK, M.APKBusiness, M.DivisionID, M.VoucherBusiness, M.VoucherBusinessName
			, M.CreateUserID, M.CreateUserName, M.CreateDate
			, M.LastModifyUserID, M.LastModifyUserName, M.LastModifyDate
			, M.sysTable
		FROM #TemOOT2270 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END



EXEC (@sSQL)
PRINT(@sSQL)









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
