IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP30081]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP30081]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-----Purpose: Lấy dữ liệu Báo cáo Nhật ký kiểm kê hàng hóa. (Copy từ store WP2047)
-----Created by Hoài Bảo, Date 06/03/2023
-----Modified on 02/06/2023 by Anh Đô: Select thêm các cột DivisionID, DivisionName, EmployeeID, EmployeeName; Cập nhật điều kiện lọc theo @DivisionIDList
-----Modified on 06/06/2023 by Anh Đô: Select thêm cột UnitName; Bổ sung ISNULL
-----Modified on 28/06/2023 by Anh Đô: Cập nhật điều kiện lọc, điều kiện join
-----Modified by ..., Date ...

CREATE PROCEDURE [dbo].[WMP30081] 
    @DivisionID		  AS NVARCHAR(50),
	@DivisionIDList	  AS NVARCHAR(MAX),
    @WareHouseID      AS NVARCHAR(MAX),
    @InventoryID	  AS NVARCHAR(MAX),
    @FromDate         AS DATETIME,
    @ToDate           AS DATETIME,
	@PeriodList		  AS NVARCHAR(2000),
    @IsPeriod           AS TINYINT, -- 0: Theo ngày, 1: Theo kỳ
	@IsSearchStandard TINYINT = 0,
	@StandardList XML = ''
AS

SET NOCOUNT ON
DECLARE @sSQL VARCHAR(MAX),
	@sWhere1 VARCHAR(MAX),
	@sWhere2 VARCHAR(MAX),
	@sSQLa VARCHAR(MAX), 
	@sSQL1 VARCHAR(MAX), 
	@sSQL2 VARCHAR(MAX), 
	@sSQL3 VARCHAR(MAX) = '',
    @FromDateText NVARCHAR(20), 
    @ToDateText NVARCHAR(20)
    
SET @sWhere1 = ''
SET @sWhere2 = ''
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

-- Kiểm tra DivisionIDList nếu null sẽ lấy Division hiện tại
IF ISNULL(@DivisionIDList, '') != ''
BEGIN
	SET @sWhere1 = ' AT2006.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
	SET @sWhere2 = ' AT2036.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
END
ELSE
BEGIN
	SET @sWhere1 = ' AT2006.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'
	SET @sWhere2 = ' AT2036.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'
END

-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere1 = @sWhere1 + ' AND (AT2006.VoucherDate >= ''' + @FromDateText + ''')'
			SET @sWhere2 = @sWhere2 + ' AND (AT2036.VoucherDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere1 = @sWhere1 + ' AND (AT2006.VoucherDate <= ''' + @ToDateText + ''')'
			SET @sWhere2 = @sWhere2 + ' AND (AT2036.VoucherDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere1 = @sWhere1 + ' AND (AT2006.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			SET @sWhere2 = @sWhere2 + ' AND (AT2036.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere1 = @sWhere1 + ' AND (SELECT FORMAT(AT2006.VoucherDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
		SET @sWhere2 = @sWhere2 + ' AND (SELECT FORMAT(AT2036.VoucherDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

IF ISNULL(@IsSearchStandard,0) = 1
BEGIN
	CREATE TABLE #StandardList_WMP30081 (InventoryID VARCHAR(50), StandardTypeID VARCHAR(50), StandardID VARCHAR(50))
	
	INSERT INTO #StandardList_WMP30081 (InventoryID, StandardTypeID, StandardID)
	SELECT	X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
			X.Data.query('StandardTypeID').value('.','VARCHAR(50)') AS StandardTypeID,
			X.Data.query('StandardID').value('.','VARCHAR(50)') AS StandardID
	FROM @StandardList.nodes('//Data') AS X (Data)
END

IF @IsPeriod = 0 -- Theo ngay
BEGIN
    SET @sSQL = '
    SELECT ROW_NUMBER() OVER (ORDER BY AT2036.WareHouseID) AS RowNum, COUNT(*) OVER () AS TotalRow,
	AT2037.DivisionID, AT2036.WareHouseID, AT1303.WareHouseName, AT2036.VoucherID, AT2037.TransactionID,
	CAST(DAY(AT2036.VoucherDate) + MONTH(AT2036.VoucherDate)* 100 + YEAR(AT2036.VoucherDate)*10000 AS NCHAR(8)) + CAST(AT2036.VoucherNo AS NCHAR(50)) + CAST(AT2037.TransactionID AS NCHAR(50)) + CAST(AT2037.InventoryID AS NCHAR(50)) AS Orders, 
	AT2036.VoucherDate, AT2036.VoucherNo, AT2037.SourceNo, AT2037.Quantity, AT2037.UnitPrice, AT2037.OriginalAmount, AT2037.AdjustQuantity, AT2037.AdjustUnitPrice, 
	AT2037.AdjutsOriginalAmount, AT2036.VoucherTypeID, AT2036.Description, AT2037.InventoryID, AT1302.InventoryName, AT2037.UnitID
	, ISNULL(T07.ACCQuantity, 0) AS ACCQuantity
	, ISNULL(T07.ACCOriginalAmount, 0) AS ACCOriginalAmount
	, ISNULL(T07.ACCConvertedAmount, 0) AS ACCConvertedAmount
	, ISNULL(T08.DesQuantity, 0) AS DesQuantity
	, ISNULL(T08.DesOriginalAmount, 0) AS DesOriginalAmount
	, ISNULL(T08.DesConvertedAmount, 0) AS DesConvertedAmount
	, CONCAT(AT2037.InventoryID, '' - '', AT1302.InventoryName) AS InventoryNameTemp,
	ABS(AT2037.Quantity - AT2037.AdjustQuantity) AS DiffQuantity, ABS(AT2037.OriginalAmount - AT2037.AdjutsOriginalAmount) AS DiffAmount,
	ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, 
	ISNULL(W89.S05ID,'''') AS S05ID, ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, 
	ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID, ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, 
	ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, ISNULL(W89.S16ID,'''') AS S16ID, 
	ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID,
	A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
	A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
	A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
	A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
	A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20,
	AT2037.InventoryID + CASE WHEN ISNULL(W89.S01ID,'''')<>'''' THEN ''.''+W89.S01ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S02ID,'''')<>'''' THEN ''.''+W89.S02ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S03ID,'''')<>'''' THEN ''.''+W89.S03ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S04ID,'''')<>'''' THEN ''.''+W89.S04ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S05ID,'''')<>'''' THEN ''.''+W89.S05ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S06ID,'''')<>'''' THEN ''.''+W89.S06ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S07ID,'''')<>'''' THEN ''.''+W89.S07ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S08ID,'''')<>'''' THEN ''.''+W89.S08ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S09ID,'''')<>'''' THEN ''.''+W89.S09ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S10ID,'''')<>'''' THEN ''.''+W89.S10ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S11ID,'''')<>'''' THEN ''.''+W89.S11ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S12ID,'''')<>'''' THEN ''.''+W89.S12ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S13ID,'''')<>'''' THEN ''.''+W89.S13ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S14ID,'''')<>'''' THEN ''.''+W89.S14ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S15ID,'''')<>'''' THEN ''.''+W89.S15ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S16ID,'''')<>'''' THEN ''.''+W89.S16ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S17ID,'''')<>'''' THEN ''.''+W89.S17ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S18ID,'''')<>'''' THEN ''.''+W89.S18ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S19ID,'''')<>'''' THEN ''.''+W89.S19ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S20ID,'''')<>'''' THEN ''.''+W89.S20ID ELSE '''' END AS InventoryID_QC
	, AT2036.DivisionID
	, A21.DivisionName
	, AT2036.EmployeeID
	, A22.UserName AS EmployeeName
	, A23.UnitName'

	SET @sSQLa = '
	'+CASE WHEN ISNULL(@IsSearchStandard,0) = 1 THEN N'INTO #WMP30081_Report' ELSE '' END+'
	FROM AT2037 WITH (NOLOCK) 
	INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT2037.DivisionID) AND AT1302.InventoryID = AT2037.InventoryID 
	INNER JOIN AT2036 WITH (NOLOCK) ON AT2036.VoucherID = AT2037.VoucherID and AT2036.DivisionID = AT2037.DivisionID
	LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2037.DivisionID = W89.DivisionID AND AT2037.TransactionID = W89.TransactionID AND AT2037.VoucherID = W89.VoucherID
	INNER JOIN AT1303 WITH (NOLOCK) ON AT1303.WarehouseID = AT2036.WarehouseID
	LEFT JOIN (
		SELECT AT2007.DivisionID, AT2007.InventoryID, SUM(ISNULL(ActualQuantity, 0)) AS ACCQuantity, UnitPrice AS ACCUnitPrice, SUM(ISNULL(OriginalAmount, 0)) AS ACCOriginalAmount, 
		SUM(ISNULL(ConvertedAmount, 0)) AS ACCConvertedAmount, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
		S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
		FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID and AT2007.DivisionID = AT2006.DivisionID
		LEFT JOIN WT8899 WITH (NOLOCK) ON AT2007.DivisionID = WT8899.DivisionID AND AT2007.TransactionID = WT8899.TransactionID AND WT8899.VoucherID = AT2007.VoucherID
		WHERE '+@sWhere1+' AND KindVoucherID = 9 AND AT2006.WareHouseID IN (''' +@WareHouseID+ ''')
		GROUP BY AT2007.DivisionID, AT2007.InventoryID, UnitPrice, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
		S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
	) AS T07 ON T07.InventoryID = AT2037.InventoryID  and T07.DivisionID = AT2037.DivisionID'

	SET @sSQL1 = '
	AND ISNULL(W89.S01ID,'''') = ISNULL(T07.S01ID,'''') AND ISNULL(W89.S02ID,'''') = ISNULL(T07.S02ID,'''')
	AND ISNULL(W89.S03ID,'''') = ISNULL(T07.S03ID,'''') AND ISNULL(W89.S04ID,'''') = ISNULL(T07.S04ID,'''') 
	AND ISNULL(W89.S05ID,'''') = ISNULL(T07.S05ID,'''') AND ISNULL(W89.S06ID,'''') = ISNULL(T07.S06ID,'''') 
	AND ISNULL(W89.S07ID,'''') = ISNULL(T07.S07ID,'''') AND ISNULL(W89.S08ID,'''') = ISNULL(T07.S08ID,'''') 
	AND ISNULL(W89.S09ID,'''') = ISNULL(T07.S09ID,'''') AND ISNULL(W89.S10ID,'''') = ISNULL(T07.S10ID,'''') 
	AND ISNULL(W89.S11ID,'''') = ISNULL(T07.S11ID,'''') AND ISNULL(W89.S12ID,'''') = ISNULL(T07.S12ID,'''') 
	AND ISNULL(W89.S13ID,'''') = ISNULL(T07.S13ID,'''') AND ISNULL(W89.S14ID,'''') = ISNULL(T07.S14ID,'''') 
	AND ISNULL(W89.S15ID,'''') = ISNULL(T07.S15ID,'''') AND ISNULL(W89.S16ID,'''') = ISNULL(T07.S16ID,'''') 
	AND ISNULL(W89.S17ID,'''') = ISNULL(T07.S17ID,'''') AND ISNULL(W89.S18ID,'''') = ISNULL(T07.S18ID,'''') 
	AND ISNULL(W89.S19ID,'''') = ISNULL(T07.S19ID,'''') AND ISNULL(W89.S20ID,'''') = ISNULL(T07.S20ID,'''')
	LEFT JOIN (
		SELECT AT2007.DivisionID, AT2007.InventoryID, SUM(ISNULL(ActualQuantity, 0)) AS DesQuantity, CASE WHEN SUM(ISNULL(ActualQuantity, 0)) = 0 THEN 0 ELSE SUM(ISNULL(OriginalAmount, 0))/SUM(ISNULL(ActualQuantity, 0)) END AS DesUnitPrice, SUM(ISNULL(OriginalAmount, 0)) AS DesOriginalAmount, 
		SUM(ISNULL(ConvertedAmount, 0)) AS DesConvertedAmount, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
		S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
		FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID and AT2007.DivisionID = AT2006.DivisionID
		LEFT JOIN WT8899 WITH (NOLOCK) ON AT2007.DivisionID = WT8899.DivisionID AND AT2007.TransactionID = WT8899.TransactionID AND WT8899.VoucherID = AT2007.VoucherID
		WHERE '+@sWhere1+' AND KindVoucherID = 8 AND AT2006.WareHouseID IN (''' +@WareHouseID+ ''')
		GROUP BY AT2007.DivisionID, AT2007.InventoryID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
		S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
	) AS T08 ON T08.InventoryID = AT2037.InventoryID and T08.DivisionID = AT2037.DivisionID 
	AND ISNULL(W89.S01ID,'''') = ISNULL(T08.S01ID,'''') AND ISNULL(W89.S02ID,'''') = ISNULL(T08.S02ID,'''')
	AND ISNULL(W89.S03ID,'''') = ISNULL(T08.S03ID,'''') AND ISNULL(W89.S04ID,'''') = ISNULL(T08.S04ID,'''') 
	AND ISNULL(W89.S05ID,'''') = ISNULL(T08.S05ID,'''') AND ISNULL(W89.S06ID,'''') = ISNULL(T08.S06ID,'''') 
	AND ISNULL(W89.S07ID,'''') = ISNULL(T08.S07ID,'''') AND ISNULL(W89.S08ID,'''') = ISNULL(T08.S08ID,'''') 
	AND ISNULL(W89.S09ID,'''') = ISNULL(T08.S09ID,'''') AND ISNULL(W89.S10ID,'''') = ISNULL(T08.S10ID,'''') 
	AND ISNULL(W89.S11ID,'''') = ISNULL(T08.S11ID,'''') AND ISNULL(W89.S12ID,'''') = ISNULL(T08.S12ID,'''') 
	AND ISNULL(W89.S13ID,'''') = ISNULL(T08.S13ID,'''') AND ISNULL(W89.S14ID,'''') = ISNULL(T08.S14ID,'''') 
	AND ISNULL(W89.S15ID,'''') = ISNULL(T08.S15ID,'''') AND ISNULL(W89.S16ID,'''') = ISNULL(T08.S16ID,'''') 
	AND ISNULL(W89.S17ID,'''') = ISNULL(T08.S17ID,'''') AND ISNULL(W89.S18ID,'''') = ISNULL(T08.S18ID,'''') 
	AND ISNULL(W89.S19ID,'''') = ISNULL(T08.S19ID,'''') AND ISNULL(W89.S20ID,'''') = ISNULL(T08.S20ID,'''')'

	SET @sSQL2 = '
	LEFT JOIN AT0128 A01 WITH (NOLOCK) ON W89.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
	LEFT JOIN AT0128 A02 WITH (NOLOCK) ON W89.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
	LEFT JOIN AT0128 A03 WITH (NOLOCK) ON W89.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
	LEFT JOIN AT0128 A04 WITH (NOLOCK) ON W89.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
	LEFT JOIN AT0128 A05 WITH (NOLOCK) ON W89.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
	LEFT JOIN AT0128 A06 WITH (NOLOCK) ON W89.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
	LEFT JOIN AT0128 A07 WITH (NOLOCK) ON W89.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
	LEFT JOIN AT0128 A08 WITH (NOLOCK) ON W89.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
	LEFT JOIN AT0128 A09 WITH (NOLOCK) ON W89.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
	LEFT JOIN AT0128 A10 WITH (NOLOCK) ON W89.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
	LEFT JOIN AT0128 A11 WITH (NOLOCK) ON W89.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
	LEFT JOIN AT0128 A12 WITH (NOLOCK) ON W89.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
	LEFT JOIN AT0128 A13 WITH (NOLOCK) ON W89.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
	LEFT JOIN AT0128 A14 WITH (NOLOCK) ON W89.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
	LEFT JOIN AT0128 A15 WITH (NOLOCK) ON W89.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
	LEFT JOIN AT0128 A16 WITH (NOLOCK) ON W89.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
	LEFT JOIN AT0128 A17 WITH (NOLOCK) ON W89.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
	LEFT JOIN AT0128 A18 WITH (NOLOCK) ON W89.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
	LEFT JOIN AT0128 A19 WITH (NOLOCK) ON W89.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
	LEFT JOIN AT0128 A20 WITH (NOLOCK) ON W89.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
	LEFT JOIN AT1101 A21 WITH (NOLOCK) ON A21.DivisionID = AT2036.DivisionID
	LEFT JOIN AT1405 A22 WITH (NOLOCK) ON A22.UserID = AT2036.EmployeeID AND A22.DivisionID IN (AT2037.DivisionID, ''@@@'')
	LEFT JOIN AT1304 A23 WITH (NOLOCK) ON A23.UnitID = AT2037.UnitID AND A23.DivisionID IN (AT2037.DivisionID, ''@@@'')
	WHERE '+@sWhere2+'
	AND AT2037.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
	AND AT2036.WareHouseID IN (''' +@WareHouseID+ ''')
	'
END
ELSE
BEGIN --@IsDate = 0 Theo ky 
	SET @sSQL = '
	SELECT ROW_NUMBER() OVER (ORDER BY AT2036.WareHouseID) AS RowNum, COUNT(*) OVER () AS TotalRow, 
	AT2037.DivisionID,AT2036.WareHouseID, AT1303.WareHouseName, AT2036.VoucherID, AT2037.TransactionID, 
	CAST(DAY(AT2036.VoucherDate) + MONTH(AT2036.VoucherDate)* 100 + YEAR(AT2036.VoucherDate)*10000 AS NCHAR(8)) + CAST(AT2036.VoucherNo AS NCHAR(50)) + CAST(AT2037.TransactionID AS NCHAR(50)) + CAST(AT2037.InventoryID AS NCHAR(50)) AS Orders, 
	AT2036.VoucherDate, AT2036.VoucherNo, AT2037.SourceNo, AT2037.Quantity, AT2037.UnitPrice, AT2037.OriginalAmount, AT2037.AdjustQuantity, AT2037.AdjustUnitPrice, 
	AT2037.AdjutsOriginalAmount, AT2036.VoucherTypeID, AT2036.Description, AT2037.InventoryID, AT1302.InventoryName, AT2037.UnitID
	, ISNULL(T07.ACCQuantity, 0) AS ACCQuantity
	, ISNULL(T07.ACCOriginalAmount, 0) AS ACCOriginalAmount
	, ISNULL(T07.ACCConvertedAmount, 0) AS ACCConvertedAmount
	, ISNULL(T08.DesQuantity, 0) AS DesQuantity
	, ISNULL(T08.DesOriginalAmount, 0) AS DesOriginalAmount
	, ISNULL(T08.DesConvertedAmount, 0) AS DesConvertedAmount
	, CONCAT(AT2037.InventoryID, '' - '', AT1302.InventoryName) AS InventoryNameTemp,
	ABS(AT2037.Quantity - AT2037.AdjustQuantity) AS DiffQuantity, ABS(AT2037.OriginalAmount - AT2037.AdjutsOriginalAmount) AS DiffAmount,
	ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, 
	ISNULL(W89.S05ID,'''') AS S05ID, ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, 
	ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID, ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, 
	ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, ISNULL(W89.S16ID,'''') AS S16ID, 
	ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID,
	A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
	A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
	A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
	A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
	A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20,
	AT2037.InventoryID + CASE WHEN ISNULL(W89.S01ID,'''')<>'''' THEN ''.''+W89.S01ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S02ID,'''')<>'''' THEN ''.''+W89.S02ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S03ID,'''')<>'''' THEN ''.''+W89.S03ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S04ID,'''')<>'''' THEN ''.''+W89.S04ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S05ID,'''')<>'''' THEN ''.''+W89.S05ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S06ID,'''')<>'''' THEN ''.''+W89.S06ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S07ID,'''')<>'''' THEN ''.''+W89.S07ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S08ID,'''')<>'''' THEN ''.''+W89.S08ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S09ID,'''')<>'''' THEN ''.''+W89.S09ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S10ID,'''')<>'''' THEN ''.''+W89.S10ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S11ID,'''')<>'''' THEN ''.''+W89.S11ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S12ID,'''')<>'''' THEN ''.''+W89.S12ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S13ID,'''')<>'''' THEN ''.''+W89.S13ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S14ID,'''')<>'''' THEN ''.''+W89.S14ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S15ID,'''')<>'''' THEN ''.''+W89.S15ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S16ID,'''')<>'''' THEN ''.''+W89.S16ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S17ID,'''')<>'''' THEN ''.''+W89.S17ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S18ID,'''')<>'''' THEN ''.''+W89.S18ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S19ID,'''')<>'''' THEN ''.''+W89.S19ID ELSE '''' END+
	CASE WHEN ISNULL(W89.S20ID,'''')<>'''' THEN ''.''+W89.S20ID ELSE '''' END AS InventoryID_QC
	, AT2036.DivisionID
	, A21.DivisionName
	, AT2036.EmployeeID
	, A22.UserName AS EmployeeName
	, A23.UnitName'

	SET @sSQLa = '
	'+CASE WHEN ISNULL(@IsSearchStandard,0) = 1 THEN N'INTO #WMP30081_Report' ELSE '' END+'
	FROM AT2037 WITH (NOLOCK) 
	INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT2037.DivisionID) AND AT1302.InventoryID = AT2037.InventoryID
	INNER JOIN AT2036 WITH (NOLOCK) ON AT2036.VoucherID = AT2037.VoucherID and  AT2036.DivisionID = AT2037.DivisionID
	INNER JOIN AT1303 WITH (NOLOCK) ON AT1303.WarehouseID = AT2036.WarehouseID
	LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2037.DivisionID = W89.DivisionID AND AT2037.TransactionID = W89.TransactionID AND W89.VoucherID = AT2037.VoucherID
	LEFT JOIN (
		SELECT AT2007.DivisionID, AT2007.InventoryID, SUM(ISNULL(ActualQuantity, 0)) AS ACCQuantity, SUM(ISNULL(OriginalAmount, 0))/SUM(ISNULL(ActualQuantity, 0)) AS ACCUnitPrice, SUM(ISNULL(OriginalAmount, 0)) AS ACCOriginalAmount, 
		SUM(ISNULL(ConvertedAmount, 0)) AS ACCConvertedAmount, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
		S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
		FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID and  AT2007.DivisionID = AT2006.DivisionID
		LEFT JOIN WT8899 WITH (NOLOCK) ON AT2007.DivisionID = WT8899.DivisionID AND AT2007.TransactionID = WT8899.TransactionID AND WT8899.VoucherID = AT2007.VoucherID
		WHERE '+@sWhere1+' AND KindVoucherID = 9 AND AT2006.WareHouseID IN (''' +@WareHouseID+ ''')
		GROUP BY AT2007.DivisionID, AT2007.InventoryID,S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
		S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
	) AS T07 ON T07.InventoryID = AT2037.InventoryID  and  T07.DivisionID = AT2037.DivisionID'

	SET @sSQL1 = '
	AND ISNULL(W89.S01ID,'''') = ISNULL(T07.S01ID,'''') AND ISNULL(W89.S02ID,'''') = ISNULL(T07.S02ID,'''')
	AND ISNULL(W89.S03ID,'''') = ISNULL(T07.S03ID,'''') AND ISNULL(W89.S04ID,'''') = ISNULL(T07.S04ID,'''') 
	AND ISNULL(W89.S05ID,'''') = ISNULL(T07.S05ID,'''') AND ISNULL(W89.S06ID,'''') = ISNULL(T07.S06ID,'''') 
	AND ISNULL(W89.S07ID,'''') = ISNULL(T07.S07ID,'''') AND ISNULL(W89.S08ID,'''') = ISNULL(T07.S08ID,'''') 
	AND ISNULL(W89.S09ID,'''') = ISNULL(T07.S09ID,'''') AND ISNULL(W89.S10ID,'''') = ISNULL(T07.S10ID,'''') 
	AND ISNULL(W89.S11ID,'''') = ISNULL(T07.S11ID,'''') AND ISNULL(W89.S12ID,'''') = ISNULL(T07.S12ID,'''') 
	AND ISNULL(W89.S13ID,'''') = ISNULL(T07.S13ID,'''') AND ISNULL(W89.S14ID,'''') = ISNULL(T07.S14ID,'''') 
	AND ISNULL(W89.S15ID,'''') = ISNULL(T07.S15ID,'''') AND ISNULL(W89.S16ID,'''') = ISNULL(T07.S16ID,'''') 
	AND ISNULL(W89.S17ID,'''') = ISNULL(T07.S17ID,'''') AND ISNULL(W89.S18ID,'''') = ISNULL(T07.S18ID,'''') 
	AND ISNULL(W89.S19ID,'''') = ISNULL(T07.S19ID,'''') AND ISNULL(W89.S20ID,'''') = ISNULL(T07.S20ID,'''')
	LEFT JOIN (
		SELECT AT2007.DivisionID, AT2007.InventoryID, SUM(ISNULL(ActualQuantity, 0)) AS DesQuantity, CASE WHEN SUM(ISNULL(ActualQuantity, 0)) = 0 THEN 0 ELSE (SUM(ISNULL(OriginalAmount, 0)) / SUM(ISNULL(ActualQuantity, 0))) END AS DesUnitPrice, SUM(ISNULL(OriginalAmount, 0)) AS DesOriginalAmount, 
		SUM(ISNULL(ConvertedAmount, 0)) AS DesConvertedAmount, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
		S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
		FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID and  AT2007.DivisionID = AT2006.DivisionID
		LEFT JOIN WT8899 WITH (NOLOCK) ON AT2007.DivisionID = WT8899.DivisionID AND AT2007.TransactionID = WT8899.TransactionID AND WT8899.VoucherID = AT2007.VoucherID
		WHERE '+@sWhere1+' AND KindVoucherID = 8 AND AT2006.WareHouseID IN (''' +@WareHouseID+ ''')
		GROUP BY AT2007.DivisionID, AT2007.InventoryID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
		S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
	) AS T08 ON T08.InventoryID = AT2037.InventoryID  and  T08.DivisionID = AT2037.DivisionID
	AND ISNULL(W89.S01ID,'''') = ISNULL(T08.S01ID,'''') AND ISNULL(W89.S02ID,'''') = ISNULL(T08.S02ID,'''')
	AND ISNULL(W89.S03ID,'''') = ISNULL(T08.S03ID,'''') AND ISNULL(W89.S04ID,'''') = ISNULL(T08.S04ID,'''') 
	AND ISNULL(W89.S05ID,'''') = ISNULL(T08.S05ID,'''') AND ISNULL(W89.S06ID,'''') = ISNULL(T08.S06ID,'''') 
	AND ISNULL(W89.S07ID,'''') = ISNULL(T08.S07ID,'''') AND ISNULL(W89.S08ID,'''') = ISNULL(T08.S08ID,'''') 
	AND ISNULL(W89.S09ID,'''') = ISNULL(T08.S09ID,'''') AND ISNULL(W89.S10ID,'''') = ISNULL(T08.S10ID,'''') 
	AND ISNULL(W89.S11ID,'''') = ISNULL(T08.S11ID,'''') AND ISNULL(W89.S12ID,'''') = ISNULL(T08.S12ID,'''') 
	AND ISNULL(W89.S13ID,'''') = ISNULL(T08.S13ID,'''') AND ISNULL(W89.S14ID,'''') = ISNULL(T08.S14ID,'''') 
	AND ISNULL(W89.S15ID,'''') = ISNULL(T08.S15ID,'''') AND ISNULL(W89.S16ID,'''') = ISNULL(T08.S16ID,'''') 
	AND ISNULL(W89.S17ID,'''') = ISNULL(T08.S17ID,'''') AND ISNULL(W89.S18ID,'''') = ISNULL(T08.S18ID,'''') 
	AND ISNULL(W89.S19ID,'''') = ISNULL(T08.S19ID,'''') AND ISNULL(W89.S20ID,'''') = ISNULL(T08.S20ID,'''')'

	SET @sSQL2 = '
	LEFT JOIN AT0128 A01 WITH (NOLOCK) ON W89.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
	LEFT JOIN AT0128 A02 WITH (NOLOCK) ON W89.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
	LEFT JOIN AT0128 A03 WITH (NOLOCK) ON W89.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
	LEFT JOIN AT0128 A04 WITH (NOLOCK) ON W89.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
	LEFT JOIN AT0128 A05 WITH (NOLOCK) ON W89.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
	LEFT JOIN AT0128 A06 WITH (NOLOCK) ON W89.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
	LEFT JOIN AT0128 A07 WITH (NOLOCK) ON W89.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
	LEFT JOIN AT0128 A08 WITH (NOLOCK) ON W89.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
	LEFT JOIN AT0128 A09 WITH (NOLOCK) ON W89.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
	LEFT JOIN AT0128 A10 WITH (NOLOCK) ON W89.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
	LEFT JOIN AT0128 A11 WITH (NOLOCK) ON W89.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
	LEFT JOIN AT0128 A12 WITH (NOLOCK) ON W89.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
	LEFT JOIN AT0128 A13 WITH (NOLOCK) ON W89.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
	LEFT JOIN AT0128 A14 WITH (NOLOCK) ON W89.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
	LEFT JOIN AT0128 A15 WITH (NOLOCK) ON W89.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
	LEFT JOIN AT0128 A16 WITH (NOLOCK) ON W89.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
	LEFT JOIN AT0128 A17 WITH (NOLOCK) ON W89.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
	LEFT JOIN AT0128 A18 WITH (NOLOCK) ON W89.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
	LEFT JOIN AT0128 A19 WITH (NOLOCK) ON W89.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
	LEFT JOIN AT0128 A20 WITH (NOLOCK) ON W89.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
	LEFT JOIN AT1101 A21 WITH (NOLOCK) ON A21.DivisionID = AT2036.DivisionID
	LEFT JOIN AT1405 A22 WITH (NOLOCK) ON A22.UserID = AT2036.EmployeeID AND A22.DivisionID IN (AT2037.DivisionID, ''@@@'')
	LEFT JOIN AT1304 A23 WITH (NOLOCK) ON A23.UnitID = AT2037.UnitID AND A23.DivisionID IN (AT2037.DivisionID, ''@@@'')
	WHERE '+@sWhere2+'
	AND AT2037.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
	AND AT2036.WareHouseID IN (''' +@WareHouseID+ ''')
	'
END

IF ISNULL(@IsSearchStandard,0) = 1
BEGIN
	SET @sSQL3 = '
	SELECT * 
	FROM
	(
		SELECT T1.*
		FROM #WMP30081_Report AS T1
		INNER JOIN #StandardList_WMP30081 T2 ON T1.InventoryID = T2.InventoryID
		WHERE 
		(	T2.StandardTypeID = ''S01'' AND ISNULL(T1.S01ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S02'' AND ISNULL(T1.S02ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S03'' AND ISNULL(T1.S03ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S04'' AND ISNULL(T1.S04ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S05'' AND ISNULL(T1.S05ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S06'' AND ISNULL(T1.S06ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S07'' AND ISNULL(T1.S07ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S08'' AND ISNULL(T1.S08ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S09'' AND ISNULL(T1.S09ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S10'' AND ISNULL(T1.S10ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S11'' AND ISNULL(T1.S11ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S12'' AND ISNULL(T1.S12ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S13'' AND ISNULL(T1.S13ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S14'' AND ISNULL(T1.S14ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S15'' AND ISNULL(T1.S15ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S16'' AND ISNULL(T1.S16ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S17'' AND ISNULL(T1.S17ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S18'' AND ISNULL(T1.S18ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S19'' AND ISNULL(T1.S19ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S20'' AND ISNULL(T1.S20ID,'''') = T2.StandardID)
		UNION ALL
		SELECT  T1.*
		FROM #WMP30081_Report AS T1
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #StandardList_WMP30081 T2 WHERE T1.InventoryID = T2.InventoryID)
		AND ISNULL(T1.S01ID,'''') = '''' AND ISNULL(T1.S02ID,'''') = '''' AND ISNULL(T1.S03ID,'''') = ''''
		AND ISNULL(T1.S04ID,'''') = '''' AND ISNULL(T1.S05ID,'''') = '''' AND ISNULL(T1.S06ID,'''') = '''' 
		AND ISNULL(T1.S07ID,'''') = '''' AND ISNULL(T1.S08ID,'''') = '''' AND ISNULL(T1.S09ID,'''') = '''' 
		AND ISNULL(T1.S10ID,'''') = '''' AND ISNULL(T1.S11ID,'''') = '''' AND ISNULL(T1.S12ID,'''') = '''' 
		AND ISNULL(T1.S13ID,'''') = '''' AND ISNULL(T1.S14ID,'''') = '''' AND ISNULL(T1.S15ID,'''') = '''' 
		AND ISNULL(T1.S16ID,'''') = '''' AND ISNULL(T1.S17ID,'''') = '''' AND ISNULL(T1.S18ID,'''') = '''' 
		AND ISNULL(T1.S19ID,'''') = '''' AND ISNULL(T1.S20ID,'''') = '''' 
	)Temp'
END

PRINT (@sSQL)
PRINT (@sSQLa)
PRINT (@sSQL1)
PRINT (@sSQL2)
PRINT (@sSQL3)

EXEC (@sSQL+@sSQLa+@sSQL1+@sSQL2+@sSQL3)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
