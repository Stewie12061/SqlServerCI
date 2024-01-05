IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22402]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22402]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Load các phiếu kiểm kê để lên màn hình truy vấn
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoài Bảo. Date: 13/05/2022
----Modified by: Hoài Bảo. Date: 14/12/2022 - Bổ sung load dữ liệu theo biến phân quyền ConditionInventoryWarehouse
----Modified by: Hoài Bảo. Date: 15/02/2023 - Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example>
/*
    EXEC WMP22402 'AS', 'ASOFTADMIN', 1,2014,'','','',''
*/

CREATE PROCEDURE WMP22402
(
    @DivisionID VARCHAR(50) = '',	-- Biến môi trường
	@DivisionIDList NVARCHAR(2000) = '',	-- Chọn trong DropdownChecklist DivisionID
	@FromDate DATETIME = NULL,
	@ToDate DATETIME = NULL,
	@IsPeriod INT = 0,
	@PeriodList VARCHAR(MAX) = '',
	@VoucherNo NVARCHAR(250) = '',
	@EmployeeID NVARCHAR(250) = '',
	@WarehouseID NVARCHAR(250) = '',
    @UserID VARCHAR(50) = '',
    @ConditionVT NVARCHAR(MAX) = '',
	@IsUsedConditionVT NVARCHAR(20) = '',	
	@ConditionWA NVARCHAR(MAX) = '',
	@IsUsedConditionWA NVARCHAR(20) = '',
	@PageNumber INT = 1,
	@PageSize INT = 25,
	@ConditionInventoryWarehouse NVARCHAR(MAX) = '',
	@RelAPK NVARCHAR(250) = '',
	@RelTable NVARCHAR(250) = ''
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @sWhere = ''
SET @OrderBy = 'A36.VoucherNo DESC'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

-- Kiểm tra DivisionIDList nếu null sẽ lấy Division hiện tại
IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = ' A36.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
ELSE
	SET @sWhere = ' A36.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'

-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (A36.CreateDate >= ''' + @FromDateText + '''
											OR A36.CreateDate >= ''' + @FromDateText + '''
											OR A36.VoucherDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (A36.CreateDate <= ''' + @ToDateText + ''' 
											OR A36.CreateDate <= ''' + @ToDateText + '''
											OR A36.VoucherDate >= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND ((A36.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') OR (A36.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''')) '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND ((SELECT FORMAT(A36.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''')
								  OR (SELECT FORMAT(A36.VoucherDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + '''))'
	END

-- Kiểm tra điều kiện lọc
IF ISNULL(@VoucherNo, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(A36.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '
IF ISNULL(@EmployeeID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(A36.EmployeeID, '''') LIKE N''%' + @EmployeeID + '%'' '
IF ISNULL(@WarehouseID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A36.WarehouseID, '''') IN (''' + @WarehouseID + ''') '
	
	----------------->>>>>> Phân quyền xem chứng từ của người dùng khác
		DECLARE @sSQLPer AS NVARCHAR(MAX),
				@sWHEREPer AS NVARCHAR(MAX)
		SET @sSQLPer = ''
		SET @sWHEREPer = ''		

		IF EXISTS (SELECT TOP 1 1 FROM WT0000 WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
			BEGIN
				SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = A36.DivisionID 
													AND AT0010.AdminUserID = '''+@UserID+''' 
													AND AT0010.UserID = A36.CreateUserID '
				SET @sWHEREPer = ' AND (A36.CreateUserID = AT0010.UserID
										OR  A36.CreateUserID = '''+@UserID+''') '		
			END
		-- Load theo biến phân quyền dữ liệu
		IF ISNULL(@ConditionInventoryWarehouse, '') != ''
			SET @sWHEREPer = @sWHEREPer + ' AND (ISNULL(A36.EmployeeID, '''') IN (''' + @ConditionInventoryWarehouse + ''' ) OR ISNULL(A36.CreateUserID, '''') IN (''' + @ConditionInventoryWarehouse + ''' ))'
	-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác		

IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
BEGIN
	SET @sSQLPer = 
	CASE
		WHEN @RelTable = 'WMT2250' THEN @sSQLPer + '
										LEFT JOIN ' +@RelTable+ ' C1 WITH (NOLOCK) ON C1.VoucherID_Temp = A36.VoucherID'
		ELSE @sSQLPer
	END
	
	SET @sWhere = 
	CASE
		WHEN @RelTable = 'WMT2250' THEN 'C1.APK = ''' +@RelAPK+ ''' AND A36.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') '
		ELSE @sWhere
	END
END

SET @sSQL = '
SELECT A36.APK, A36.VoucherTypeID, A36.VoucherNo, A36.VoucherDate, 
	ConvertedAmount = (SELECT SUM(ConvertedAmount) FROM AT2037 WHERE VoucherID = A36.VoucherID And DivisionID = '''+@DivisionID+'''), 
	A36.EmployeeID, A03.FullName AS EmployeeName, A36.WareHouseID,  A33.WarehouseName As WareHouseName, A36.[Description], A36.VoucherID, A36.[Status], 
	A36.DivisionID, A36.TranMonth, A36.TranYear, A36.CreateDate, A36.CreateUserID, A36.LastModifyDate, A36.LastModifyUserID
INTO #TempAT2036
FROM AT2036 A36
	LEFT JOIN AT1303 A33 WITH (NOLOCK) ON A36.WarehouseID = A33.WareHouseID AND A33.DivisionID IN (A36.DivisionID,''@@@'')
	LEFT JOIN AT1103 A03 ON A03.EmployeeID = A36.EmployeeID
	' + @sSQLPer+ '
WHERE ' + @sWhere + @sWHEREPer + ' 

DECLARE @Count INT
SELECT @Count = COUNT(Voucherno) FROM #TempAT2036

SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow, A36.*
	FROM #TempAT2036 A36
	ORDER BY ' + @OrderBy + '
	OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

EXEC (@sSQL)
--Print @sSQL





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
