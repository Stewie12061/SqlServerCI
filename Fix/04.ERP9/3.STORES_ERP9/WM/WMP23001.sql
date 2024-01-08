IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP23001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP23001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh mục chuyển kho mã vạch
-- <Param>
---- 
-- <Return>
---- 
-- <History>
----Created by: Thanh Lượng, Date: 19/10/2023
-- <Example>
/*
EXEC [WMP23001]
	@DivisionID = N'DTI', @DivisionIDList = N'', @FromDate = NULL, @ToDate = NULL, @IsPeriod = 0, 
	@PeriodList = N'', @VoucherNo = N'', @ObjectID = N'', @WareHouseID = N'', @ImWareHouseID = N'', 
	@PageNumber = 1, @PageSize = 100
*/

CREATE PROCEDURE WMP23001 (
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
	SET @sWhere = 'AND M.WareHouseID IN (''' + @WareHouseID + ''', ''@@@'')'

	IF ISNULL(@ImWareHouseID, '') != ''
	SET @sWhere = 'AND M.WareHouseID2 IN (''' + @ImWareHouseID + ''', ''@@@'')'

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
	SET @sWhere = @sWhere + ' AND ISNULL(M.ImWareHouseID, '''') IN (''' + @ImWareHouseID + ''')'

IF ISNULL(@CreateUserID, '') != ''
	SET @sWhere = @sWhere + ' AND ((ISNULL(M.CreateUserID, '''') LIKE N''%' + @CreateUserID + '%'') OR (ISNULL(A1.FullName, '''') LIKE N''%' + @CreateUserID + '%''))'


SET @sSQL = N'
		SELECT DISTINCT
		M.VoucherTypeID, M.VoucherID, M.VoucherNo, M.VoucherDate, M.Description,
		M.ObjectID,AT1202.ObjectName, M.WareHouseID, AT1303.WareHouseName, M.RDAddress, M.DivisionID,
		M.TranMonth, M.TranYear, M.CreateUserID,	M.LastModifyUserID,
		T04.VoucherNo As SalesNo, T04.VoucherDate As SalesDate,
		M.KindVoucherID, T03.VoucherNo As PurchaseNo, T03.VoucherDate As PurchaseDate, M.ReVoucherID,
		M.WarehouseID2
	INTO #TempBT1002
	FROM   BT1002 M WITH (NOLOCK)
	LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
	Left Join AT1202 WITH (NOLOCK) On AT1202.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND M.ObjectID = AT1202.ObjectID
	Left Join AT1303 WITH (NOLOCK) On AT1303.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND M.WareHouseID = AT1303.WareHouseID
	Left Join BT1000 WITH (NOLOCK) On M.DivisionID = BT1000.DivisionID And M.TransactionID = BT1000.TransactionID
	Left Join (Select Distinct DivisionID, VoucherID, VoucherNo, VoucherDate From AT9000 WITH (NOLOCK) Where DivisionID = '''+ @DivisionID +''' And TransactionTypeID = ''T04''
				) T04 On BT1000.DivisionID = T04.DivisionID And BT1000.VoucherID = T04.VoucherID 
	Left Join (Select Distinct DivisionID, VoucherID, VoucherNo, VoucherDate From AT9000 WITH (NOLOCK) Where DivisionID = '''+ @DivisionID +''' And TransactionTypeID = ''T03''
				) T03 On BT1000.DivisionID = T03.DivisionID And BT1000.VoucherID = T03.VoucherID 
	WHERE 1=1 ' + @sWhere + ' and KindVoucherID = 3 
	DECLARE @Count INT
	SELECT @Count = COUNT(*) FROM #TempBT1002

	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
		  , x.APK, M.VoucherTypeID, M.VoucherID, M.VoucherNo, M.VoucherDate, M.Description,
		M.ObjectID, M.ObjectName, M.WareHouseID, M.WareHouseName, M.RDAddress, M.DivisionID,
		M.TranMonth, M.TranYear, M.CreateUserID,	M.LastModifyUserID, M.KindVoucherID, M.VoucherNo As PurchaseNo, M.VoucherDate As PurchaseDate, M.ReVoucherID,
		M.WarehouseID2
	FROM #TempBT1002 M
		CROSS APPLY (SELECT TOP 1 APK FROM BT1002 A08 WITH (NOLOCK) WHERE M.TranMonth = A08.TranMonth AND M.TranYear = A08.TranYear AND M.WareHouseID = A08.WareHouseID) x
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
