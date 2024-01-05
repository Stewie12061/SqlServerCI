IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22301]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22301]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form WMP22301 Yêu cầu chuyển kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 23/02/2022
----Created by: Hoài Bảo, Date: 13/12/2022 - Bổ sung load dữ liệu theo biến phân quyền ConditionTransferWareHouse
-- <Example>
/*
EXEC [WMP22301] 
	@DivisionID = N'DTI', @DivisionIDList = N'', @FromDate = NULL, @ToDate = NULL, @IsPeriod = 0, 
	@PeriodList = N'', @VoucherNo = N'', @ObjectID = N'', @EmployeeID = N'', @InventoryTypeID = N'', 
	@PageNumber = 1, @PageSize = 100
*/

CREATE PROCEDURE WMP22301 (
		@DivisionID VARCHAR(50),	-- Biến môi trường
		@DivisionIDList NVARCHAR(2000),	-- Chọn trong DropdownChecklist DivisionID
		@FromDate DATETIME,
		@ToDate DATETIME,
		@IsPeriod INT,
		@PeriodList VARCHAR(MAX),
		@VoucherNo NVARCHAR(250),
		@ObjectID NVARCHAR(50),
		@EmployeeID NVARCHAR(50),
		@InventoryTypeID NVARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@ConditionTransferWareHouse NVARCHAR(MAX)
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
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

-- Kiểm tra điều kiện lọc
IF ISNULL(@VoucherNo, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '
IF ISNULL(@ObjectID, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(M.ObjectID, '''') LIKE N''%' + @ObjectID + '%'' OR ISNULL(A2.ObjectName, '''') LIKE N''%' + @ObjectID + '%'') '
IF ISNULL(@EmployeeID, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(A1.FullName, '''') LIKE N''%' + @EmployeeID + '%'' OR ISNULL(A1.EmployeeID, '''') LIKE N''%' + @EmployeeID + '%'') '
IF ISNULL(@InventoryTypeID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.InventoryTypeID, '''') LIKE N''%' + @InventoryTypeID + '%'' '
IF ISNULL(@ConditionTransferWareHouse, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(M.EmployeeID, '''') IN (''' + @ConditionTransferWareHouse + ''' ) OR ISNULL(M.CreateUserID, '''') IN (''' + @ConditionTransferWareHouse + ''' ))'

SET @sSQL = N'
	SELECT	M.APK, M.DivisionID, M.VoucherID, M.TableID, M.TranMonth, M.TranYear, M.VoucherTypeID, M.VoucherDate
			, M.VoucherNo, A2.ObjectName AS ObjectID, M.KindVoucherID, M.[Status], A1.FullName AS EmployeeID
			, (SELECT AT1303.WareHouseName FROM AT1303 WITH (NOLOCK) WHERE AT1303.WareHouseID = M.WareHouseID) AS WareHouseID
			, (SELECT AT1303.WareHouseName FROM AT1303 WITH (NOLOCK) WHERE AT1303.WareHouseID = M.WareHouseID2) AS WareHouseID2
			, M.[Description], M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
			, IIF(M.InventoryTypeID = ''%'', N''Tất Cả'', A.InventoryTypeName) AS InventoryTypeID
	INTO #TempAT2006
	FROM AT2006 M WITH (NOLOCK)
	LEFT JOIN AT1301 A WITH (NOLOCK) ON M.InventoryTypeID = A.InventoryTypeID
	LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.EmployeeID
	LEFT JOIN AT1202 A2 WITH (NOLOCK) ON A2.ObjectID = M.ObjectID
	WHERE ' + @sWhere + ' AND M.KindVoucherID = 3

	DECLARE @Count INT
	SELECT @Count = COUNT(Voucherno) FROM #TempAT2006

	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow,
		  M.APK, M.DivisionID, M.VoucherID, M.TableID, M.TranMonth, M.TranYear, M.VoucherTypeID, M.VoucherDate
		, M.VoucherNo, M.ObjectID, M.WareHouseID AS ImWareHouseID, M.KindVoucherID, M.WareHouseID2 AS ExWareHouseID, M.[Status], M.EmployeeID
		, M.[Description], M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID, M.InventoryTypeID
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
