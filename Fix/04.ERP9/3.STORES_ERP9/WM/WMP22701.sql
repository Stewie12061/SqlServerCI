IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22701]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22701]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form WMF2270 Kết chuyển số dư cuối kỳ
-- <Param>
---- 
-- <Return>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 19/07/2022
----Modified by: Hoài Bảo, Date: 13/12/2022 - Bổ sung load dữ liệu theo biến phân quyền ConditionTransferBalance
----Modified by: Hoài Bảo, Date: 20/02/2023 - Không load CreateDate,LastModifyUserID,LastModifyDate
----Modified by: Tiến Thành, Date: 24/03/2023 - Chỉnh sửa chức năng tìm kiếm bằng kho
-- <Example>
/*
EXEC [WMP22701]
	@DivisionID = N'DTI', @DivisionIDList = N'', @FromDate = NULL, @ToDate = NULL, @IsPeriod = 0, 
	@PeriodList = N'', @VoucherNo = N'', @ObjectID = N'', @EmployeeID = N'', @KindVoucherID = N'', 
	@PageNumber = 1, @PageSize = 100
*/

CREATE PROCEDURE WMP22701 (
	@DivisionID VARCHAR(50),	-- Biến môi trường
	@DivisionIDList NVARCHAR(2000),	-- Chọn trong DropdownChecklist DivisionID
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsPeriod INT,
	@PeriodList VARCHAR(MAX),
	@WareHouseID NVARCHAR(50),
	@CreateUserID NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@ConditionTransferBalance NVARCHAR(MAX)
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @sWhere = ''
SET @OrderBy = ' M.TranYear DESC, M.TranMonth DESC'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

-- Kiểm tra DivisionIDList nếu null sẽ lấy Division hiện tại
IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = ' M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
ELSE
	SET @sWhere = ' M.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'

-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(M.CreateDate, GETDATE()) >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(M.CreateDate, GETDATE()) <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(M.CreateDate, GETDATE()) BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (CASE WHEN M.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(M.TranMonth)) + ''/'' + LTRIM(RTRIM(M.TranYear))
									ELSE RTRIM(LTRIM(M.TranMonth)) + ''/'' + LTRIM(RTRIM(M.TranYear)) END) IN ( ''' + @PeriodList + ''') '
	END

-- Kiểm tra điều kiện lọc
IF ISNULL(@WareHouseID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.WareHouseID, '''') IN (''' + @WareHouseID + ''')'
IF ISNULL(@CreateUserID, '') != ''
	SET @sWhere = @sWhere + ' AND ((ISNULL(M.CreateUserID, '''') LIKE N''%' + @CreateUserID + '%'') OR (ISNULL(A1.FullName, '''') LIKE N''%' + @CreateUserID + '%''))'
IF ISNULL(@ConditionTransferBalance, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.CreateUserID, '''') IN (''' + @ConditionTransferBalance + ''')'

SET @sSQL = N'
	SELECT DISTINCT M.DivisionID, M.TranMonth, M.TranYear, M.WareHouseID AS WareHouseIID, A3.WareHouseName AS WareHouseID
		   , (CASE WHEN M.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(M.TranMonth)) + ''/'' + LTRIM(RTRIM(M.TranYear))
			  ELSE RTRIM(LTRIM(M.TranMonth)) + ''/'' + LTRIM(RTRIM(M.TranYear)) END) AS PeriodID
		   , A1.FullName AS CreateUserID--, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
	INTO #TempAT2008
	FROM AT2008 M WITH (NOLOCK)
	LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
	LEFT JOIN AT1303 A3 WITH (NOLOCK) ON A3.WareHouseID = M.WareHouseID
	WHERE ' + @sWhere + '

	DECLARE @Count INT
	SELECT @Count = COUNT(*) FROM #TempAT2008

	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
		  , x.APK, M.DivisionID, M.TranMonth, M.TranYear, M.WareHouseID, M.PeriodID
		  , M.CreateUserID--, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
	FROM #TempAT2008 M
		CROSS APPLY (SELECT TOP 1 APK FROM AT2008 A08 WITH (NOLOCK) WHERE M.TranMonth = A08.TranMonth AND M.TranYear = A08.TranYear AND M.WareHouseIID = A08.WareHouseID) x
	ORDER BY ' + @OrderBy + '
	OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

SET @sSQL1 = N'
	SELECT DISTINCT M.DivisionID, M.TranMonth, M.TranYear, M.WareHouseID AS WareHouseIID, A3.WareHouseName AS WareHouseID
		   , (CASE WHEN M.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(M.TranMonth)) + ''/'' + LTRIM(RTRIM(M.TranYear))
			  ELSE RTRIM(LTRIM(M.TranMonth)) + ''/'' + LTRIM(RTRIM(M.TranYear)) END) AS PeriodID
		   , A1.FullName AS CreateUserID--, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
	INTO #TempAT2008_QC
	FROM AT2008_QC M WITH (NOLOCK)
	LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
	LEFT JOIN AT1303 A3 WITH (NOLOCK) ON A3.WareHouseID = M.WareHouseID
	WHERE ' + @sWhere + '

	DECLARE @Count INT
	SELECT @Count = COUNT(*) FROM #TempAT2008_QC

	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
		  , x.APK, M.DivisionID, M.TranMonth, M.TranYear, M.WareHouseID, M.PeriodID
		  , M.CreateUserID--, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
	FROM #TempAT2008_QC M
		CROSS APPLY (SELECT TOP 1 APK FROM AT2008_QC A08 WITH (NOLOCK) WHERE M.TranMonth = A08.TranMonth AND M.TranYear = A08.TranYear AND M.WareHouseIID = A08.WareHouseID) x
	ORDER BY ' + @OrderBy + '
	OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '


IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	BEGIN
		PRINT (@sSQL1)
		EXEC (@sSQL1)
	END
ELSE
	BEGIN
		PRINT (@sSQL)
		EXEC (@sSQL)
	END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
