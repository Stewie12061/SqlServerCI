IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22501]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22501]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form WMP22501 Điều chỉnh kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 10/03/2022
----Modified by: Hoài Bảo, Date: 14/12/2022 - Bổ sung load dữ liệu theo biến phân quyền ConditionInventoryWarehouseAdjust
----Modified by: Hoài Bảo, Date: 15/02/2023 - Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example>
/*
EXEC [WMP22501] 
	@DivisionID = N'DTI', @DivisionIDList = N'', @FromDate = NULL, @ToDate = NULL, @IsPeriod = 0, 
	@PeriodList = N'', @VoucherNo = N'', @ObjectID = N'', @EmployeeID = N'', @KindVoucherID = N'', 
	@PageNumber = 1, @PageSize = 100
*/

CREATE PROCEDURE WMP22501 (
		@DivisionID VARCHAR(50) = '',	-- Biến môi trường
		@DivisionIDList NVARCHAR(2000) = '',	-- Chọn trong DropdownChecklist DivisionID
		@FromDate DATETIME = NULL,
		@ToDate DATETIME = NULL,
		@IsPeriod INT = 0,
		@PeriodList VARCHAR(MAX) = '',
		@VoucherNo NVARCHAR(250) = '',
		@ObjectID NVARCHAR(50) = '',
		@EmployeeID NVARCHAR(50) = '',
		@KindVoucherID VARCHAR(50) = '',
		@UserID VARCHAR(50) = '',
		@PageNumber INT = 1,
		@PageSize INT = 25,
		@ConditionInventoryWarehouseAdjust NVARCHAR(MAX) = '',
		@RelAPK NVARCHAR(250) = '',
		@RelTable NVARCHAR(250) = ''
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@sJoin NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @sWhere = ''
SET @sJoin = ''
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
											OR M.CreateDate >= ''' + @FromDateText + '''
											OR M.VoucherDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CreateDate <= ''' + @ToDateText + ''' 
											OR M.CreateDate <= ''' + @ToDateText + '''
											OR M.VoucherDate >= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND ((M.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') OR (M.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''')) '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

-- Kiểm tra điều kiện lọc
IF ISNULL(@VoucherNo, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '
IF ISNULL(@ObjectID, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(M.ObjectID, '''') LIKE N''%' + @ObjectID + '%'' OR ISNULL(A2.ObjectName, '''') LIKE N''%' + @ObjectID + '%'') '
IF ISNULL(@EmployeeID, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(A1.FullName, '''') LIKE N''%' + @EmployeeID + '%'' OR ISNULL(A1.EmployeeID, '''') LIKE N''%' + @EmployeeID + '%'') '
IF ISNULL(@KindVoucherID, '') != ''
	SET @sWhere = @sWhere + ' AND M.KindVoucherID IN (''' + @KindVoucherID + ''') '
ELSE
	SET @sWhere = @sWhere + ' AND M.KindVoucherID IN (''8'',''9'') '
IF ISNULL(@ConditionInventoryWarehouseAdjust, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(M.EmployeeID, '''') IN (''' + @ConditionInventoryWarehouseAdjust + ''' ) OR ISNULL(M.CreateUserID, '''') IN (''' + @ConditionInventoryWarehouseAdjust + ''' ))'

IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
BEGIN
	SET @sJoin = 
	CASE
		WHEN @RelTable = 'WMT2250' THEN 'LEFT JOIN ' +@RelTable+ ' C1 WITH (NOLOCK) ON C1.VoucherID = M.VoucherID
										 INNER JOIN AT2036 C2 WITH (NOLOCK) ON C2.VoucherID = C1.VoucherID_Temp'
		ELSE @sJoin
	END
	
	SET @sWhere = 
	CASE
		WHEN @RelTable = 'WMT2250' THEN 'C2.APK = ''' +@RelAPK+ ''' AND M.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') '
		ELSE @sWhere
	END
END

SET @sSQL = N'
	SELECT	M.APK, M.DivisionID, M.VoucherID, M.TableID, M.TranMonth, M.TranYear, M.VoucherTypeID, M.VoucherDate
			, M.VoucherNo, A2.ObjectName AS ObjectID, A3.WareHouseName AS WareHouseID, M.[Status], A1.FullName AS EmployeeID
			, M.[Description], M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
			, IIF(ISNULL(M.KindVoucherID, '''') = ''8'', N''Giảm'', N''Tăng'') AS KindVoucherID
	INTO #TempAT2006
	FROM AT2006 M WITH (NOLOCK)
	LEFT JOIN AT1301 A WITH (NOLOCK) ON M.InventoryTypeID = A.InventoryTypeID
	LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.EmployeeID
	LEFT JOIN AT1202 A2 WITH (NOLOCK) ON A2.ObjectID = M.ObjectID
	LEFT JOIN AT1303 A3 WITH (NOLOCK) ON A3.WareHouseID = M.WareHouseID '
	+@sJoin+
	'
	WHERE ' + @sWhere + '

	DECLARE @Count INT
	SELECT @Count = COUNT(Voucherno) FROM #TempAT2006

	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow,
		  M.APK, M.DivisionID, M.VoucherID, M.TableID, M.TranMonth, M.TranYear, M.VoucherTypeID, M.VoucherDate
		, M.VoucherNo, M.ObjectID, WareHouseID, M.KindVoucherID, M.[Status], M.EmployeeID
		, M.[Description], M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
	FROM #TempAT2006 M
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
