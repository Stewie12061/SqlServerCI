IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2320]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2320]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh mục phiếu lắp ráp
-- <Param>
---- 
-- <Return>
---- 
-- <History>
----Created by: Hoàng Long, Date: 10/11/2023
----Update : Fix lỗi không lọc được kho nhập
-- <Example>
/*
EXEC [WMP2320]
	@DivisionID = N'DTI', @DivisionIDList = N'', @FromDate = NULL, @ToDate = NULL, @IsPeriod = 0, 
	@PeriodList = N'', @VoucherNo = N'', @ObjectID = N'', @WareHouseID = N'', @ImWareHouseID = N'', 
	@PageNumber = 1, @PageSize = 100
*/

CREATE PROCEDURE WMP2320 (
	@DivisionID VARCHAR(50),	-- Biến môi trường
	@DivisionIDList NVARCHAR(2000),	-- Chọn trong DropdownChecklist DivisionID
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsPeriod INT,
	@PeriodList VARCHAR(MAX),
	@VoucherNo NVARCHAR(50)=N'',
	@ObjectID NVARCHAR(50)=N'',
	@WareHouseID NVARCHAR(50)=N'',
	@ImWareHouseID NVARCHAR(50)=N'',
	@CreateUserID NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
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
	SET @sWhere = 'AND M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
ELSE
	SET @sWhere = 'AND M.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'

	IF ISNULL(@WareHouseID, '') != ''
	SET @sWhere = 'AND A03.WareHouseID IN (''' + @WareHouseID + ''', ''@@@'')'

IF ISNULL(@VoucherNo, '') != ''
	SET @sWhere = 'AND M.VoucherNo IN (''' + @VoucherNo + ''', ''@@@'')'

	IF ISNULL(@ObjectID, '') != ''
	SET @sWhere = 'AND M.ObjectID IN (''' + @ObjectID + ''', ''@@@'')'


-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(M.VoucherDate, GETDATE()) >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(M.VoucherDate, GETDATE()) <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(M.VoucherDate, GETDATE()) BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (CASE WHEN Month(M.VoucherDate) < 10 THEN ''0'' + RTRIM(LTRIM(Month(M.VoucherDate))) + ''/'' + LTRIM(RTRIM(Year(M.VoucherDate)))
									ELSE RTRIM(LTRIM(Month(M.VoucherDate))) + ''/'' + LTRIM(RTRIM(Year(M.VoucherDate))) END) IN ( ''' + @PeriodList + ''') '
	END

-- Kiểm tra điều kiện lọc
IF ISNULL(@WareHouseID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.WareHouseID, '''') IN (''' + @WareHouseID + ''')'
	-- Kiểm tra điều kiện lọc
IF ISNULL(@ImWareHouseID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(A03.ImWareHouseID, '''') IN (''' + @ImWareHouseID + ''')'

IF ISNULL(@CreateUserID, '') != ''
	SET @sWhere = @sWhere + ' AND ((ISNULL(M.CreateUserID, '''') LIKE N''%' + @CreateUserID + '%'') OR (ISNULL(M.EmployeeID, '''') LIKE N''%' + @CreateUserID + '%''))'


SET @sSQL = N'
		SELECT DISTINCT
		M.APK, M.DivisionID,M.TranMonth, M.TranYear, M.VoucherNo , M.VoucherTypeID,M.VoucherID,M.VoucherDate, M.ObjectID, A02.ObjectName,M.[Description],A03.ImWareHouseID,A04.WareHouseName as ImWareHouseName,M.EmployeeID,A05.UserName as EmployeeName
	INTO #TempAT0112
	FROM   AT0112 M WITH (NOLOCK)
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', '''+@DivisionID+''') AND A02.ObjectID = M.ObjectID 
			LEFT JOIN AT0113 A03 WITH (NOLOCK) ON A03.DivisionID = M.DivisionID AND A03.VoucherID = M.VoucherID AND A03.KindVoucherID= 1
			LEFT JOIN AT1303 A04 WITH (NOLOCK) ON A04.DivisionID IN (''@@@'', '''+@DivisionID+''') AND A04.WareHouseID = A03.ImWareHouseID
			LEFT JOIN AT1405 A05 WITH (NOLOCK) ON A05.DivisionID IN (''@@@'', '''+@DivisionID+''') AND A05.UserID = M.EmployeeID
	WHERE 1=1 ' + @sWhere + ' and M.Type = 0 
	DECLARE @Count INT
	SELECT @Count = COUNT(*) FROM #TempAT0112

	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
		  , M.APK, M.DivisionID, M.VoucherNo , M.VoucherTypeID,M.VoucherID,M.VoucherDate, M.ObjectID, ObjectName,M.[Description],ImWareHouseID,ImWareHouseName,M.EmployeeID,EmployeeName
	FROM #TempAT0112 M
		--CROSS APPLY (SELECT TOP 1 APK FROM BT1002 A08 WITH (NOLOCK) WHERE M.TranMonth = A08.TranMonth AND M.TranYear = A08.TranYear AND M.WareHouseID = A08.WareHouseID) x
	ORDER BY ' + @OrderBy + '
	OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

		PRINT (@sSQL)
		EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
