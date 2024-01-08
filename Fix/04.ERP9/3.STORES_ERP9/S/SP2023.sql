IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP2023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP2023]
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
	EXEC SP2023 @DivisionID=N'KY',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[SP2023] (
	 @DivisionID NVARCHAR(2000),
	 @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @TableID NVARCHAR(250),
	 @PageNumber INT,
	 @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	 @sWhere NVARCHAR(MAX),
	 @OrderBy NVARCHAR(500),
	 @TotalRow NVARCHAR(50)

SET @sWhere = '1 = 1'
SET @OrderBy = 'M.CreateDate DESC'

-- Load phiếu công việc
IF (@TableID = 'OOT2110')
BEGIN
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.TaskID LIKE N''%' + @TxtSearch + '%'' 
				OR M.TaskName LIKE N''%' + @TxtSearch + '%'')'

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
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.ProjectID LIKE N''%' + @TxtSearch + '%'' 
				OR M.ProjectName LIKE N''%' + @TxtSearch + '%'')'

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
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.MilestoneID LIKE N''%' + @TxtSearch + '%'' 
				OR M.MilestoneName LIKE N''%' + @TxtSearch + '%'')'

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
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.ReleaseID LIKE N''%' + @TxtSearch + '%'' 
				OR M.ReleaseName LIKE N''%' + @TxtSearch + '%'')'

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
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.IssuesID LIKE N''%' + @TxtSearch + '%'' 
				OR M.IssuesName LIKE N''%' + @TxtSearch + '%'')'

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
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.SupportRequiredID LIKE N''%' + @TxtSearch + '%'' 
				OR M.SupportRequiredName LIKE N''%' + @TxtSearch + '%'')'

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
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.LeadID LIKE N''%' + @TxtSearch + '%'' 
				OR M.LeadName LIKE N''%' + @TxtSearch + '%'')'

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
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.OpportunityID LIKE N''%' + @TxtSearch + '%'' 
				OR M.OpportunityName LIKE N''%' + @TxtSearch + '%'')'

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
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.RequestCustomerID LIKE N''%' + @TxtSearch + '%'' 
				OR M.RequestSubject LIKE N''%' + @TxtSearch + '%'')'

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
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.ContactID LIKE N''%' + @TxtSearch + '%'' 
				OR M.ContactName LIKE N''%' + @TxtSearch + '%'')'

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
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.MemberID LIKE N''%' + @TxtSearch + '%'' 
				OR M.MemberName LIKE N''%' + @TxtSearch + '%'')'

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
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.CampaignID LIKE N''%' + @TxtSearch + '%'' 
				OR M.CampaignName LIKE N''%' + @TxtSearch + '%'')'

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
	IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + '
				 AND (M.ContractNo LIKE N''%' + @TxtSearch + '%'' 
				OR M.ContractName LIKE N''%' + @TxtSearch + '%'')'

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



EXEC (@sSQL)
PRINT(@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
