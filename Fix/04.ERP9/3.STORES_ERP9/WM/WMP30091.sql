IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP30091]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP30091]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Create by Hoài Bảo, Date 08/03/2023
---- Purpose: In thông tin thẻ kho (Copy từ store AP3018)
---- Modified on 12/05/2023 by Anh Đô: Cập nhật điều kiện lọc thời gian ở query load số dư đầu kỳ
---- Modified on 13/06/2023 by Anh Đô: Select thêm các cột DivisionName, VoucherTypeName
---- Modified on 17/11/2023 by Nhật Thanh: Fix lỗi gán cứng và join

CREATE PROCEDURE [dbo].[WMP30091]
(
    @DivisionID		  AS NVARCHAR(50) = '',
	@DivisionIDList	  AS NVARCHAR(MAX) = '',
    @WareHouseID      AS NVARCHAR(MAX) = '',
    @InventoryID	  AS NVARCHAR(MAX) = '',
    @FromDate         AS DATETIME = NULL,
    @ToDate           AS DATETIME = NULL,
	@PeriodList		  AS NVARCHAR(MAX) = '',
    @IsPeriod         AS TINYINT = 0 -- 0: Theo ngày, 1: Theo kỳ
)
AS

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC WMP30091_QC @DivisionID, @DivisionIDList, @WareHouseID, @InventoryID, @FromDate, @ToDate, @PeriodList, @IsPeriod
ELSE
BEGIN
	DECLARE 
		@SQL1 NVARCHAR(MAX), 
		@SQL2 NVARCHAR(MAX), 
		@SQL3 NVARCHAR(MAX), 
		@SQL4 NVARCHAR(MAX), 
		@WareHouseName NVARCHAR(250), 
		@KindVoucherListIm NVARCHAR(200), 
		@KindVoucherListEx1 NVARCHAR(200), 
		@KindVoucherListEx2 NVARCHAR(200),
		@FromMonthYearText NVARCHAR(20), 
		@ToMonthYearText NVARCHAR(20), 
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20),
		@sWhere NVARCHAR(MAX) = ''

	SET @WareHouseName = (SELECT TOP 1 WareHouseName FROM AT1303 WHERE WareHouseID = @WareHouseID)

	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	SET @KindVoucherListEx1 = ' (2, 4, 3, 6, 8, 10, 14, 20) '
	SET @KindVoucherListEx2 = ' (2, 4, 6, 8, 10, 14, 20) '
	SET @KindVoucherListIm = ' (1, 3, 5, 7, 9, 15, 17) '

	-- Kiểm tra DivisionIDList nếu null sẽ lấy Division hiện tại
	IF ISNULL(@DivisionIDList, '') != ''
	BEGIN
		SET @sWhere = ' AND AT2007.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
	END
	ELSE
	BEGIN
		SET @sWhere = ' AND AT2007.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'
	END

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (AT2006.VoucherDate >= ''' + @FromDateText + '''
											   OR AT2006.CreateDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (AT2006.VoucherDate <= ''' + @ToDateText + '''
											   OR AT2006.CreateDate <= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (AT2006.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
											   OR AT2006.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND ((SELECT FORMAT(AT2006.VoucherDate, ''MM/yyyy'')) IN (''' + @PeriodList + ''')
											OR (SELECT FORMAT(AT2006.CreateDate, ''MM/yyyy'')) IN (''' + @PeriodList + ''')) '
		END

	--- Tạo bảng tạm thay cho AV7000 - cải thiện tốc độ
	--- So du No cua tai khoan ton kho
	SELECT  D17.DivisionID, D16.TranMonth, D16.TranYear, D16.WareHouseID, D17.InventoryID, D02.InventoryName, 'BD' AS D_C,  --- So du No
		D17.Notes, D16.VoucherDate, D02.UnitID, D04.UnitName,
		ActualQuantity AS SignQuantity, ConvertedAmount AS SignAmount,	
		D17.Notes01, D17.Notes02, D17.Notes03, D02.Specification, D16.ObjectID, AT1.DivisionName
	INTO #AV7000
	From AT2017 AS D17 WITH (NOLOCK)
	INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,'@@@') AND D02.InventoryID = D17.InventoryID
	LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID
	LEFT JOIN AT1101 AS AT1 WITH (NOLOCK) ON AT1.DivisionID IN (D17.DivisionID,'@@@')
	Where D16.DivisionID LIKE @DivisionID AND D16.WareHouseID LIKE @WareHouseID
			AND D17.InventoryID IN (SELECT Value FROM dbo.StringSplit(@InventoryID, ','))
			AND  ISNULL(D17.DebitAccountID,'') <>''

	UNION ALL --- So du co hang ton kho

	SELECT  D17.DivisionID, D16.TranMonth, D16.TranYear, D16.WareHouseID, D17.InventoryID, D02.InventoryName, 'BC' AS D_C,  --- So du Co
		D17.Notes, D16.VoucherDate, D02.UnitID, D04.UnitName,
		-ActualQuantity AS SignQuantity, -ConvertedAmount AS SignAmount,	
		D17.Notes01, D17.Notes02, D17.Notes03, D02.Specification, D16.ObjectID, AT1.DivisionName
	FROM AT2017 AS D17 WITH (NOLOCK) 
	INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID 
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,'@@@') AND D02.InventoryID = D17.InventoryID
	LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID
	LEFT JOIN AT1101 AS AT1 WITH (NOLOCK) ON AT1.DivisionID IN (D17.DivisionID,'@@@')
	WHERE D16.DivisionID LIKE @DivisionID AND D16.WareHouseID LIKE @WareHouseID 
		  AND D17.InventoryID IN (SELECT Value FROM dbo.StringSplit(@InventoryID, ','))
		  AND ISNULL(D17.CreditAccountID,'') <>''

	UNION ALL  -- Nhap kho

	SELECT  D07.DivisionID, D06.TranMonth, D06.TranYear, D06.WareHouseID, D07.InventoryID, D02.InventoryName, 'D' AS D_C,  --- Phat sinh No
		D07.Notes, D06.VoucherDate, D02.UnitID, D04.UnitName,
		ActualQuantity AS SignQuantity,	ConvertedAmount AS SignAmount,	
		D07.Notes01, D07.Notes02, D07.Notes03, D02.Specification, D06.ObjectID, AT1.DivisionName
	FROM AT2007 AS D07 WITH (NOLOCK)
	INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,'@@@') AND D02.InventoryID = D07.InventoryID
	LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID
	LEFT JOIN AT1101 AS AT1 WITH (NOLOCK) ON AT1.DivisionID IN (D07.DivisionID,'@@@')
	WHERE D06.DivisionID LIKE @DivisionID AND D06.KindVoucherID in (1,3,5,7,9,15,17) AND D06.WareHouseID LIKE @WareHouseID
		  AND D07.InventoryID IN (SELECT Value FROM dbo.StringSplit(@InventoryID, ','))
		  AND ISNULL(D06.TableID,'') <> 'AT0114' ------- Phiếu nhập bù của ANGEL

	UNION ALL  -- xuat kho

	SELECT  D07.DivisionID, D06.TranMonth, D06.TranYear, CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End AS WareHouseID, 
		D07.InventoryID, D02.InventoryName, 'C' AS D_C,  --- So du Co
		D07.Notes, D06.VoucherDate, D02.UnitID, D04.UnitName,
		-ActualQuantity AS SignQuantity, -ConvertedAmount AS SignAmount,	
		D07.Notes01, D07.Notes02, D07.Notes03, D02.Specification, D06.ObjectID, AT1.DivisionName
	From AT2007 AS D07 WITH (NOLOCK)
	INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,'@@@') AND D02.InventoryID = D07.InventoryID
	LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID
	LEFT JOIN AT1101 AS AT1 WITH (NOLOCK) ON AT1.DivisionID IN (D07.DivisionID,'@@@')
	Where D06.DivisionID LIKE @DivisionID AND D06.KindVoucherID in (2,3,4,6,8,10,14,20) 
			AND CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End LIKE @WareHouseID
			AND D07.InventoryID IN (SELECT Value FROM dbo.StringSplit(@InventoryID, ','))


	-- Lấy số dư đầu
	IF @IsPeriod = 1 
	BEGIN
			SET @SQL1 = N'
	SELECT 
	AT2008.InventoryID, 
	AT1302.InventoryName, 
	AT1302.UnitID, 
	AT1304.UnitName, 
	AT1302.Specification, 
	AT1302.Notes01,
	AT1302.Notes02, 
	AT1302.Notes03, 
	SUM(AT2008.BeginQuantity) AS BeginQuantity, 
	SUM(AT2008.EndQuantity) AS EndQuantity, 
	SUM(AT2008.BeginAmount) AS BeginAmount, 
	SUM(AT2008.EndAmount) AS EndAmount, 
	AT2008.DivisionID,
	AT1.DivisionName
	INTO #AV7005
	FROM AT2008  WITH (NOLOCK)
	INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1302.InventoryID = AT2008.InventoryID
	INNER JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1304.UnitID = AT1302.UnitID
	LEFT JOIN AT1101 AS AT1 WITH (NOLOCK) ON AT1.DivisionID IN (AT2008.DivisionID,''@@@'')
	WHERE AT2008.DivisionID LIKE ''' + @DivisionID + ''' 
	AND (CASE WHEN AT2008.TranMonth < 10 THEN CONCAT(''0'', AT2008.TranMonth, ''/'', AT2008.TranYear) ELSE CONCAT(AT2008.TranMonth, ''/'', AT2008.TranYear) END) IN ( ''' + @PeriodList + ''')
	AND AT2008.WareHouseID IN (N''' + @WareHouseID + ''')
	AND AT2008.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))

	GROUP BY AT2008.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName, AT1302.Specification,
			 AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, AT2008.DivisionID, AT1.DivisionName
	HAVING SUM(AT2008.BeginQuantity) <> 0 OR SUM(AT2008.EndQuantity) <> 0
	'
	END
	ELSE
	BEGIN
			SET @SQL1 = N'
	SELECT 
	InventoryID, 
	InventoryName, 
	UnitID, 
	UnitName, 
	Specification, 
	Notes01, 
	Notes02, 
	Notes03, 
	SUM(SignQuantity) AS BeginQuantity, 
	SUM(SignAmount) AS BeginAmount, 
	0 AS EndQuantity, 
	0 AS EndAmount, 
	DivisionID,
	DivisionName
	INTO #AV7005
	FROM #AV7000 AV7000
	WHERE  ((D_C IN (''D'', ''C'') AND VoucherDate < ''' + @FromDateText + ''') OR D_C = ''BD'' ) 
	GROUP BY 
	InventoryID, InventoryName, UnitID, UnitName, Specification, Notes01, Notes02, Notes03, DivisionID, DivisionName

	HAVING SUM(SignQuantity) <> 0 ---OR SUM(SignAmount) <> 0
	'
	END

	---- Lay so phat sinh 
	IF @IsPeriod = 1 
		BEGIN
			SET @SQL2 = N'
	-- Phần nhập kho
	SELECT 
	AT2007.VoucherID, 
	''T05'' AS TransactionTypeID, 
	AT2007.TransactionID, 
	AT2007.Orders, 
	AT2006.VoucherDate, 
	AT2006.VoucherNo, 
	AT2006.VoucherDate AS ImVoucherDate, 
	AT2006.VoucherNo AS ImVoucherNo, 
	AT2007.SourceNo AS ImSourceNo, 
	AT2007.LimitDate AS ImLimitDate, 
	AT2006.WareHouseID AS ImWareHouseID, 
	AT2007.ActualQuantity AS ImQuantity, 
	AT2007.UnitPrice AS ImUnitPrice, 
	AT2007.ConvertedAmount AS ImConvertedAmount, 
	AT2007.OriginalAmount AS ImOriginalAmount, 
	ISNULL(AT2007.ConversionFactor, 1) * AT2007.ActualQuantity AS ImConvertedQuantity, 
	NULL AS ExVoucherDate, 
	NULL AS ExVoucherNo, 
	NULL AS ExSourceNo, 
	NULL AS ExLimitDate, 
	NULL AS ExWareHouseID, 
	NULL AS ExQuantity, 
	NULL AS ExUnitPrice, 
	NULL AS ExConvertedAmount, 
	NULL AS ExOriginalAmount, 
	NULL AS ExConvertedQuantity, 
	AT2006.VoucherTypeID, 
	AT2006.Description, 
	AT2007.Notes, 
	AT2007.InventoryID, 
	AT1302.InventoryName, 
	AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
	AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, 
	AT2007.UnitID, AT1304.UnitName, 
	ISNULL(AT2007.ConversionFactor, 1) AS ConversionFactor, AT2006.ObjectID, AT1202.ObjectName, AT2007.DivisionID 
	,AT2006.RefNo01,
	AT2006.RefNo02,
	AT2007.RefInfor,
	AT1101.DivisionName,
	AT1007.VoucherTypeName
	INTO #AV3028
	FROM AT2007  WITH (NOLOCK)
	INNER JOIN AT2006  WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
	INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT2007.UnitID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT2006.ObjectID----------------
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT2007.DivisionID
	LEFT JOIN AT1007 WITH (NOLOCK) ON AT1007.VoucherTypeID = AT2006.VoucherTypeID AND AT1007.DivisionID IN (AT2006.DivisionID, ''@@@'')

	WHERE AT2006.KindVoucherID IN ' + @KindVoucherListIm + ' 
	AND AT2006.WareHouseID IN (N''' + @WareHouseID + ''')
	AND AT2007.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
	'+@sWhere+'

	UNION ALL
	'
			SET @SQL3 = N'
	-- Phần xuất kho
	SELECT 
	AT2007.VoucherID, 
	''T06'' AS TransactionTypeID, 
	AT2007.TransactionID, 
	AT2007.Orders, 
	AT2006.VoucherDate, 
	AT2006.VoucherNo, 
	Null AS ImVoucherDate, 
	Null AS ImVoucherNo, 
	Null AS ImSourceNo, 
	Null AS ImLimitDate, 
	Null AS ExWareHouseID, 
	Null AS ImQuantity, 
	Null AS ImUnitPrice, 
	Null AS ImConvertedAmount, 
	Null AS ImOriginalAmount, 
	Null AS ImConvertedQuantity, 
	AT2006.VoucherDate AS ExVoucherDate, 
	AT2006.VoucherNo AS ExVoucherNo, 
	AT2007.SourceNo AS ExSourceNo, 
	AT2007.LimitDate AS ExLimitDate, 
	(CASE WHEN AT2006.KindVoucherID = 3 THEN AT2006.WareHouseID2 ELSE AT2006.WareHouseID END) AS ExWareHouseID, 
	AT2007.ActualQuantity AS ExQuantity, 
	AT2007.UnitPrice AS ExUnitPrice, 
	AT2007.ConvertedAmount AS ExConvertedAmount, 
	AT2007.OriginalAmount AS ExOriginalAmount, 
	ISNULL(AT2007.ConversionFactor, 1) * AT2007.ActualQuantity AS ExConvertedQuantity, 
	AT2006.VoucherTypeID, 
	AT2006.Description, 
	AT2007.Notes, 
	AT2007.InventoryID, 
	AT1302.InventoryName, 
	AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
	AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, 
	AT2007.UnitID, AT1304.UnitName, 
	ISNULL(AT2007.ConversionFactor, 1) AS ConversionFactor, AT2006.ObjectID, AT1202.ObjectName, AT2007.DivisionID 
	,AT2006.RefNo01,
	AT2006.RefNo02,
	AT2007.RefInfor,
	AT1101.DivisionName,
	AT1007.VoucherTypeName
	FROM AT2007 WITH (NOLOCK) 
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
	INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT2007.UnitID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = AT2006.ObjectID
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT2007.DivisionID
	LEFT JOIN AT1007 WITH (NOLOCK) ON AT1007.VoucherTypeID = AT2006.VoucherTypeID AND AT1007.DivisionID IN (AT2006.DivisionID, ''@@@'')

	WHERE AT2006.KindVoucherID IN ' + @KindVoucherListEx1 + '  
	AND ((AT2006.KindVoucherID IN ' + @KindVoucherListEx2 + ' AND AT2006.WareHouseID IN (''' + @WareHouseID + ''')) 
		OR (KindVoucherID = 3 AND WareHouseID2 IN (''' + @WareHouseID + '''))) 
	AND AT2007.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
	'+@sWhere+'
	'
		END
	ELSE
		BEGIN
		SET @SQL2 = N'
	-- Phần nhập kho
	SELECT 
	AT2007.VoucherID, 
	''T05'' AS TransactionTypeID, 
	AT2007.TransactionID, 
	AT2007.Orders, 
	AT2006.VoucherDate, 
	AT2006.VoucherNo, 
	AT2006.VoucherDate AS ImVoucherDate, 
	AT2006.VoucherNo AS ImVoucherNo, 
	AT2007.SourceNo AS ImSourceNo, 
	AT2007.LimitDate AS ImLimitDate, 
	AT2006.WareHouseID AS ImWareHouseID, 
	AT2007.ActualQuantity AS ImQuantity, 
	AT2007.UnitPrice AS ImUnitPrice, 
	AT2007.ConvertedAmount AS ImConvertedAmount, 
	AT2007.OriginalAmount AS ImOriginalAmount, 
	ISNULL(AT2007.ConversionFactor, 1) * AT2007.ActualQuantity AS ImConvertedQuantity, 
	Null AS ExVoucherDate, 
	Null AS ExVoucherNo, 
	Null AS ExSourceNo, 
	Null AS ExLimitDate, 
	Null AS ExWareHouseID, 
	Null AS ExQuantity, 
	Null AS ExUnitPrice, 
	Null AS ExConvertedAmount, 
	Null AS ExOriginalAmount, 
	Null AS ExConvertedQuantity, 
	AT2006.VoucherTypeID, 
	AT2006.Description, 
	AT2007.Notes, 
	AT2007.InventoryID, 
	AT1302.InventoryName, 
	AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
	AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, 
	AT2007.UnitID, AT1304.UnitName, 
	ISNULL(AT2007.ConversionFactor, 1) AS ConversionFactor, AT2006.ObjectID, AT1202.ObjectName, AT2007.DivisionID 
	,AT2006.RefNo01,
	AT2006.RefNo02,
	AT2007.RefInfor,
	AT1101.DivisionName,
	AT1007.VoucherTypeName
	INTO #AV3028
	FROM AT2007 WITH (NOLOCK) 
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
	INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT2007.UnitID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT2006.ObjectID --------------
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT2007.DivisionID
	LEFT JOIN AT1007 WITH (NOLOCK) ON AT1007.VoucherTypeID = AT2006.VoucherTypeID AND AT1007.DivisionID IN (AT2006.DivisionID, ''@@@'')

	WHERE AT2006.KindVoucherID IN ' + @KindVoucherListIm + ' 
	AND AT2006.WareHouseID IN (N''' + @WareHouseID + ''')
	AND AT2007.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
	'+@sWhere+'

	UNION ALL
	'
		SET @SQL3 = N'
	-- Phần xuất kho
	SELECT
	AT2007.VoucherID, 
	''T06'' AS TransactionTypeID, 
	AT2007.TransactionID, 
	AT2007.Orders, 
	AT2006.VoucherDate, 
	AT2006.VoucherNo, 
	Null AS ImVoucherDate, 
	Null AS ImVoucherNo, 
	Null AS ImSourceNo, 
	Null AS ImLimitDate, 
	Null AS ExWareHouseID, 
	Null AS ImQuantity, 
	Null AS ImUnitPrice, 
	Null AS ImConvertedAmount, 
	Null AS ImOriginalAmount, 
	Null AS ImConvertedQuantity, 
	AT2006.VoucherDate AS ExVoucherDate, 
	AT2006.VoucherNo AS ExVoucherNo, 
	AT2007.SourceNo AS ExSourceNo, 
	AT2007.LimitDate AS ExLimitDate, 
	(CASE WHEN AT2006.KindVoucherID = 3 THEN AT2006.WareHouseID2 ELSE AT2006.WareHouseID END) AS ExWareHouseID, 
	AT2007.ActualQuantity AS ExQuantity, 
	AT2007.UnitPrice AS ExUnitPrice, 
	AT2007.ConvertedAmount AS ExConvertedAmount, 
	AT2007.OriginalAmount AS ExOriginalAmount, 
	ISNULL(AT2007.ConversionFactor, 1) * AT2007.ActualQuantity AS ExConvertedQuantity, 
	AT2006.VoucherTypeID, 
	AT2006.Description, 
	AT2007.Notes, 
	AT2007.InventoryID, 
	AT1302.InventoryName,
	AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
	AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, 
	AT2007.UnitID, AT1304.UnitName, 
	ISNULL(AT2007.ConversionFactor, 1) AS ConversionFactor, AT2006.ObjectID, AT1202.ObjectName, AT2007.DivisionID
	,AT2006.RefNo01,
	AT2006.RefNo02,
	AT2007.RefInfor,
	AT1101.DivisionID,
	AT1007.VoucherTypeName
	FROM AT2007 WITH (NOLOCK) 
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
	INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT2007.UnitID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT2006.ObjectID
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT2007.DivisionID
	LEFT JOIN AT1007 WITH (NOLOCK) ON AT1007.VoucherTypeID = AT2006.VoucherTypeID AND AT1007.DivisionID IN (AT2006.DivisionID, ''@@@'')

	WHERE KindVoucherID IN ' + @KindVoucherListEx1 + ' 
	AND ((KindVoucherID IN ' + @KindVoucherListEx2 + ' AND AT2006.WareHouseID IN (''' + @WareHouseID + '''))
		OR (KindVoucherID = 3 AND WareHouseID2 IN (''' + @WareHouseID + ''')))
	AND AT2007.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
	'+@sWhere+'
	'
		END

	--- Lay du su va phat sinh
	SET @SQL4 = N'
	SELECT ROW_NUMBER() OVER (ORDER BY AV3028.InventoryID, AV3028.VoucherDate ) AS RowNum, COUNT(*) OVER () AS TotalRow,
	''' + @WareHouseID + ''' AS WareHouseID,
	N''' + @WareHouseName + ''' AS WareHouseName,
	AV3028.VoucherID,
	AV3028.TransactionTypeID,
	AV3028.TransactionID,
	AV3028.Orders,
	AV3028.VoucherDate,
	AV3028.VoucherNo,
	AV3028.ImVoucherDate,
	AV3028.ImVoucherNo,
	AV3028.ImSourceNo,
	AV3028.ImLimitDate,
	ISNULL(AV3028.ImQuantity, 0) AS ImQuantity,
	AV3028.ImUnitPrice,
	ISNULL(AV3028.ImConvertedAmount, 0) AS ImConvertedAmount,
	ISNULL(AV3028.ImOriginalAmount, 0) AS ImOriginalAmount,
	ISNULL(AV3028.ImConvertedQuantity, 0) AS ImConvertedQuantity,
	AV3028.ExVoucherDate,
	AV3028.ExVoucherNo,
	AV3028.ExSourceNo,
	AV3028.ExLimitDate,
	ISNULL(AV3028.ExQuantity, 0) AS ExQuantity,
	AV3028.ExUnitPrice,
	ISNULL(AV3028.ExConvertedAmount, 0) AS ExConvertedAmount,
	AV3028.ExOriginalAmount,
	AV3028.ExConvertedQuantity,
	AV3028.VoucherTypeID,
	AV3028.Description,
	AV3028.Notes,
	ISNULL(AV3028.InventoryID, AV7005.InventoryID) AS InventoryID,
	ISNULL(AV3028.InventoryName, AV7005.InventoryName) AS InventoryName,
	ISNULL(AV3028.Specification, AV7005.Specification) AS Specification,
	ISNULL(AV3028.Notes01, AV7005.Notes01) AS Notes01,
	ISNULL(AV3028.Notes02, AV7005.Notes02) AS Notes02,
	ISNULL(AV3028.Notes03, AV7005.Notes03) AS Notes03,
	AV3028.Ana01ID, AV3028.Ana02ID, AV3028.Ana03ID, AV3028.Ana04ID, AV3028.Ana05ID,
	ISNULL(AV3028.UnitID, AV7005.UnitID) AS UnitID,
	ISNULL(AV3028.UnitName, AV7005.UnitName) AS UnitName,
	ISNULL(AV7005.BeginQuantity, 0) AS BeginQuantity,
	AV3028. ConversionFactor, AV3028.ObjectID, AV3028.ObjectName, ISNULL(AV3028.DivisionID, AV7005.DivisionID) AS DivisionID
	,AV3028.RefNo01,
	AV3028.RefNo02,
	AV3028.RefInfor,
	ISNULL(AV3028.DivisionName, AV7005.DivisionName) AS DivisionName,
	AV3028.VoucherTypeName
	FROM #AV3028  AV3028
	FULL JOIN #AV7005 AV7005 ON AV7005.InventoryID = AV3028.InventoryID AND AV7005.DivisionID = AV3028.DivisionID
	WHERE  ISNULL(AV3028.ImQuantity, 0) <> 0 
	OR ISNULL(AV3028.ImConvertedAmount, 0) <> 0
	OR ISNULL(AV3028.ExQuantity, 0) <> 0
	OR ISNULL(AV3028.ExConvertedAmount, 0) <> 0
	OR ISNULL(AV7005.BeginQuantity, 0) <> 0
	OR ISNULL(AV7005.BeginAmount, 0) <> 0
	ORDER BY AV3028.InventoryID, AV3028.VoucherDate
	'

	PRINT @SQL1
	PRINT @SQL2
	PRINT @SQL3
	PRINT @SQL4
	EXEC (@SQL1+@SQL2+@SQL3+@SQL4)
END	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
