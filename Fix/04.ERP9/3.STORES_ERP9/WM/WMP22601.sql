IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22601]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22601]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form WMP22601 Số dư đầu hàng tồn kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 20/04/2022
----Modified by: Hoài Bảo, Date: 20/07/2022 - Xóa điều kiện thừa
----Modified by: Hoài Bảo, Date: 13/12/2022 - Bổ sung load dữ liệu theo biến phân quyền ConditionInventoryBalance
-- <Example>
/*
EXEC [WMP22601]
	@DivisionID = N'DTI', @DivisionIDList = N'', @FromDate = NULL, @ToDate = NULL, @IsPeriod = 0, 
	@PeriodList = N'', @VoucherNo = N'', @ObjectID = N'', @EmployeeID = N'', @KindVoucherID = N'', 
	@PageNumber = 1, @PageSize = 100
*/

CREATE PROCEDURE WMP22601 (
		@DivisionID VARCHAR(50),	-- Biến môi trường
		@DivisionIDList NVARCHAR(2000),	-- Chọn trong DropdownChecklist DivisionID
		@FromDate DATETIME,
		@ToDate DATETIME,
		@IsPeriod INT,
		@PeriodList VARCHAR(MAX),
		@VoucherNo NVARCHAR(250),
		@WareHouseID NVARCHAR(50),
		@EmployeeName NVARCHAR(50),
		@ObjectName NVARCHAR(MAX),
		@PageNumber INT,
		@PageSize INT,
		@ConditionInventoryBalance NVARCHAR(MAX)
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @sWhere = ''
SET @OrderBy = ' M.CreateDate DESC'
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
			SET @sWhere = @sWhere + ' AND (M.CreateDate >= ''' + @FromDateText + '''
											OR M.VoucherDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CreateDate <= ''' + @ToDateText + ''' 
											OR M.VoucherDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND ((M.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') OR (M.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''')) '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.VoucherDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

-- Kiểm tra điều kiện lọc
IF ISNULL(@VoucherNo, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '
IF ISNULL(@ObjectName, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(M.ObjectID, '''') LIKE N''%' + @ObjectName + '%'' OR ISNULL(A2.ObjectName, '''') LIKE N''%' + @ObjectName + '%'') '
IF ISNULL(@EmployeeName, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(A1.FullName, '''') LIKE N''%' + @EmployeeName + '%'' OR ISNULL(A1.EmployeeID, '''') LIKE N''%' + @EmployeeName + '%'') '
IF ISNULL(@WareHouseID, '') != ''
	SET @sWhere = @sWhere + ' AND M.WareHouseID IN (''' + @WareHouseID + ''') '
IF ISNULL(@ConditionInventoryBalance, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(M.EmployeeID, '''') IN (''' + @ConditionInventoryBalance + ''' ) OR ISNULL(M.CreateUserID, '''') IN (''' + @ConditionInventoryBalance + ''' ))'

SET @sSQL = N'
	SELECT	M.APK, M.DivisionID, M.VoucherID, M.TranMonth, M.TranYear, M.VoucherTypeID, M.VoucherDate
			, M.VoucherNo, A2.ObjectName, A3.WareHouseName AS WareHouseID, M.[Status], A1.FullName AS EmployeeName
			, M.[Description], M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
	INTO #TempAT2016
	FROM AT2016 M WITH (NOLOCK)
	LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.EmployeeID
	LEFT JOIN AT1202 A2 WITH (NOLOCK) ON A2.ObjectID = M.ObjectID
	LEFT JOIN AT1303 A3 WITH (NOLOCK) ON A3.WareHouseID = M.WareHouseID
	WHERE ' + @sWhere + '

	DECLARE @Count INT
	SELECT @Count = COUNT(Voucherno) FROM #TempAT2016

	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow,
		  M.APK, M.DivisionID, M.VoucherID, M.TranMonth, M.TranYear, M.VoucherTypeID, M.VoucherDate
		, M.VoucherNo, M.ObjectName, WareHouseID, M.[Status], M.EmployeeName
		, M.[Description], M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
	FROM #TempAT2016 M
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
