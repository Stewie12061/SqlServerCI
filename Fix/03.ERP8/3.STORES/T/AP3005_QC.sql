IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP3005_QC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP3005_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Lay du lieu in bao cao nhap xuat ton FIFO theo quy cách
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Bảo Thy on 22/01/2018
----Modified by Bảo Thy on 04/04/2018: bổ sung InventoryID_QC
----Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
-- <Example>
/*
    AP3005_QC 'HT',4,4,2012,2012,'01/01/2012','04/25/2012','K01','K99','0000000001','0000000001',0
*/


CREATE PROCEDURE AP3005_QC
(
	@DivisionID VARCHAR(50),		
	@FromMonth INT,
	@ToMonth INT,
	@FromYear INT,
	@ToYear INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@FromWareHouseID NVARCHAR(50),
	@ToWareHouseID VARCHAR(50),
	@FromInventoryID NVARCHAR(50),
	@ToInventoryID NVARCHAR(50),		
	@IsDate TINYINT,
	@IsSearchStandard TINYINT,
	@StandardList XML
)
AS
IF ISNULL(@IsSearchStandard,0) = 1
BEGIN
	CREATE TABLE #StandardList_AP3005_QC (InventoryID VARCHAR(50), StandardTypeID VARCHAR(50), StandardID VARCHAR(50))
	
	INSERT INTO #StandardList_AP3005_QC (InventoryID, StandardTypeID, StandardID)
	SELECT	X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
			X.Data.query('StandardTypeID').value('.','VARCHAR(50)') AS StandardTypeID,
			X.Data.query('StandardID').value('.','VARCHAR(50)') AS StandardID
	FROM @StandardList.nodes('//Data') AS X (Data)
END

DECLARE @sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sSQL4 NVARCHAR(MAX), 
		@FromMonthYearText NVARCHAR(20), 
		@ToMonthYearText NVARCHAR(20), 
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20)
		    
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

IF @IsDate = 0 --- theo ky 
BEGIN
--Tao view AV3001- So du dau ky
	SET   @sSQL1 = N'
SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, ReVoucherNo VoucherNo, ReVoucherDate VoucherDate, 
ReQuantity = AT0114.ReQuantity - ISNULL((SELECT SUM(PriceQuantity) FROM AT0115 WITH(NOLOCK)
                                         WHERE TranMonth + TranYear*100   < '+@FromMonthYearText+'
										 AND ReTransactionID = AT0114.ReTransactionID And DivisionID = AT0115.DivisionID), 0),
ReAmount = Av3004.ConvertedAmount  - ISNULL((SELECT SUM(ConvertedAmount) FROM AT0115 WITH(NOLOCK)
                                             WHERE TranMonth + TranYear*100   < '+@FromMonthYearText+'
											 AND ReTransactionID = AT0114.ReTransactionID And DivisionID = AT0114.DivisionID), 0),
AT0114.UnitPrice ReUnitPrice, NULL DeQuantity, NULL DeUnitPice, NULL FromVoucherNo , NULL FromVoucherDate,
AT0114.WareHouseID, AV3004.UnitID,  AV3004.CurrencyID, AV3004.ExchangeRate, AT1302.Specification, AT1302.Notes01,
AT1302.Notes02, AT1302.Notes03, Notes, AT0114.ReTransactionID TransactionID, AT0114.DivisionID,
AT0114.S01ID, AT0114.S02ID, AT0114.S03ID, AT0114.S04ID, AT0114.S05ID, AT0114.S06ID, AT0114.S07ID, AT0114.S08ID, AT0114.S09ID, AT0114.S10ID, 
AT0114.S11ID, AT0114.S12ID, AT0114.S13ID, AT0114.S14ID, AT0114.S15ID, AT0114.S16ID, AT0114.S17ID, AT0114.S18ID, AT0114.S19ID, AT0114.S20ID'
	
	SET @sSQL2 = N'
FROM AT0114 WITH(NOLOCK)
LEFT JOIN AV3004 ON AV3004.VoucherID = AT0114.ReVoucherID AND AV3004.TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID
INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
WHERE AT0114.DivisionID ='''+@DivisionID+'''
	AND (AT0114.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
	AND (ReTranMonth + ReTranYear*100 < ''' + @FromMonthYearText +''' OR TransactionTypeID =''T00'')
	AND (AT0114.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND ''' + @ToWareHouseID + ''')'
		
END
ELSE
BEGIN
	SET @sSQL1 = N'
SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, ReVoucherNo VoucherNo, ReVoucherDate VoucherDate, 
ReQuantity = ReQuantity - ISNULL((SELECT SUM(PriceQuantity) FROM AT0115 WITH(NOLOCK) 
                                  WHERE VoucherDate  < '''+ @FromDateText +''' 
								  AND ReTransactionID = AT0114.ReTransactionID And DivisionID = AT0115.DivisionID), 0),
ReAmount = AV3004.ConvertedAmount  - ISNULL((SELECT SUM(ConvertedAmount) FROM AT0115 WITH(NOLOCK) 
                                             WHERE VoucherDate  < '''+ @FromDateText +''' 
											 AND ReTransactionID = AT0114.ReTransactionID AND DivisionID = AT0114.DivisionID), 0),
AT0114.UnitPrice ReUnitPrice, NULL DeQuantity, NULL DeUnitPice, NULL FromVoucherNo, NULL FromVoucherDate,
AT0114.WareHouseID, AV3004.UnitID, AV3004.CurrencyID, AV3004.ExchangeRate, AT1302.Specification, AT1302.Notes01,
AT1302.Notes02, AT1302.Notes03, Notes, AT0114.ReTransactionID TransactionID, AT0114.DivisionID,
AT0114.S01ID, AT0114.S02ID, AT0114.S03ID, AT0114.S04ID, AT0114.S05ID, AT0114.S06ID, AT0114.S07ID, AT0114.S08ID, AT0114.S09ID, AT0114.S10ID, 
AT0114.S11ID, AT0114.S12ID, AT0114.S13ID, AT0114.S14ID, AT0114.S15ID, AT0114.S16ID, AT0114.S17ID, AT0114.S18ID, AT0114.S19ID, AT0114.S20ID '
			
	SET @sSQL2 = N'
FROM AT0114 WITH(NOLOCK)
LEFT JOIN AV3004 ON AV3004.VoucherID = AT0114.ReVoucherID AND AV3004.TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID
INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
WHERE AT0114.DivisionID ='''+@DivisionID+'''
AND (AT0114.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
AND (AT0114.ReVoucherDate <'''+@FromDateText+''' or TransactionTypeID =''T00'' )
AND (AT0114.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND ''' + @ToWareHouseID + ''')'
END
			
IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype ='V' AND Name ='AV3001') 
	EXEC ('CREATE VIEW AV3001 AS '+ @sSQL1+  @sSQL2)----tao boi AP3005_QC
ELSE 
	EXEC('ALTER VIEW AV3001 AS '+@sSQL1+  @sSQL2) ----tao boi AP3005_QC

-----------Tao View AV3002 -Phat sinh trong ky
IF @Isdate = 0    -- theo ngày
BEGIN
	SET @sSQL1 = N'
SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, AT0114.ReVoucherNo VoucherNo, AT0114.ReVoucherDate VoucherDate,
ReQuantity, AT0114.UnitPrice ReUnitPrice, PriceQuantity DeQuantity, AT0115.UnitPrice DeUnitPice, AT2007.OriginalAmount,
AT2007.ConvertedAmount, NULL FromVoucherNo, NULL FromVoucherDate, AT0114.WareHouseID, AT2007.UnitID,CurrencyID,ExchangeRate,
AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes,  AT0114.ReTransactionID TransactionID, AT0114.DivisionID,
AT0114.S01ID, AT0114.S02ID, AT0114.S03ID, AT0114.S04ID, AT0114.S05ID, AT0114.S06ID, AT0114.S07ID, AT0114.S08ID, AT0114.S09ID, AT0114.S10ID, 
AT0114.S11ID, AT0114.S12ID, AT0114.S13ID, AT0114.S14ID, AT0114.S15ID, AT0114.S16ID, AT0114.S17ID, AT0114.S18ID, AT0114.S19ID, AT0114.S20ID '		
		
	SET @sSQL2= N'
FROM AT0114 WITH(NOLOCK)
	LEFT JOIN AT0115 WITH(NOLOCK) ON AT0115.TransactionID = AT0114.ReTransactionID AND AT0115.DivisionID = AT0114.DivisionID
	INNER JOIN AT2007 WITH(NOLOCK) ON AT2007.VoucherID = AT0114.ReVoucherID AND AT2007.DivisionID = AT0114.DivisionID AND AT2007.TransactionID = AT0114.ReTransactionID 
	INNER JOIN AT1302 WITH(NOLOCK) on AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
WHERE AT0114.DivisionID = '''+@DivisionID+'''
	AND (AT0114.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
	AND (ReTranMonth + ReTranYear*100 BETWEEN ''' + @FromMonthYearText + ''' AND ''' +	@ToMonthYearText + ''')
	AND (AT0114.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND ''' + @ToWareHouseID + ''')	
UNION ALL'
	SET @sSQL3 = N'
SELECT DISTINCT	AT0115.InventoryID, AT1302.InventoryName, VoucherNo DeVoucherNo, VoucherDate DeVoucherDate, NULL ReQuantity,
NULL ReUnitPrice, PriceQuantity DeQuantity, AT0115.UnitPrice DeUnitPice, NULL OriginalAmount, NULL ConvertedAmount,
AT0115.ReVoucherNo FromVoucherNo, AT0115.ReVoucherDate FromVoucherDate, AT0115.WareHouseID, AT2007. UnitID,CurrencyID,
ExchangeRate, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes,  AT0115.TransactionID, AT0115.DivisionID,
AT0115.S01ID, AT0115.S02ID, AT0115.S03ID, AT0115.S04ID, AT0115.S05ID, AT0115.S06ID, AT0115.S07ID, AT0115.S08ID, AT0115.S09ID, AT0115.S10ID, 
AT0115.S11ID, AT0115.S12ID, AT0115.S13ID, AT0115.S14ID, AT0115.S15ID, AT0115.S16ID, AT0115.S17ID, AT0115.S18ID, AT0115.S19ID, AT0115.S20ID  '
	SET @sSQL4 = N'
FROM AT0115 WITH(NOLOCK)
LEFT JOIN AT2007 WITH(NOLOCK) ON AT2007.VoucherID = AT0115.ReVoucherID AND AT2007.TransactionID = AT0115.ReTransactionID AND AT2007.DivisionId = AT0115.DivisionID
INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0115.DivisionID,''@@@'') AND AT1302.InventoryID = AT0115.InventoryID
WHERE AT0115.DivisionID = '''+@DivisionID+'''
AND (AT0115.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
AND (AT0115.TranMonth + AT0115.TranYear*100 BETWEEN '''+ @FromMonthYearText + ''' AND ''' + @ToMonthYearText + ''') 
AND (AT0115.WareHouseID between '''+@FromWareHouseID+'''  AND ''' + @ToWareHouseID + ''')'
END
ELSE
BEGIN
	SET @sSQL1 = N'
SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, AT0114.ReVoucherNo VoucherNo, AT0114.ReVoucherDate VoucherDate,
ReQuantity, AT0114.UnitPrice ReUnitPrice, PriceQuantity DeQuantity, AT0115.UnitPrice DeUnitPice, AT2007.OriginalAmount,
AT2007.ConvertedAmount, NULL FromVoucherNo, NULL FromVoucherDate, AT0114.WareHouseID, AT2007.UnitID, CurrencyID,ExchangeRate,
AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes, AT0114.ReTransactionID as TransactionID, AT0114.DivisionID,
AT0114.S01ID, AT0114.S02ID, AT0114.S03ID, AT0114.S04ID, AT0114.S05ID, AT0114.S06ID, AT0114.S07ID, AT0114.S08ID, AT0114.S09ID, AT0114.S10ID, 
AT0114.S11ID, AT0114.S12ID, AT0114.S13ID, AT0114.S14ID, AT0114.S15ID, AT0114.S16ID, AT0114.S17ID, AT0114.S18ID, AT0114.S19ID, AT0114.S20ID '
	SET @sSQL2 = N'
FROM AT0114 WITH(NOLOCK)
LEFT JOIN AT0115 WITH(NOLOCK) ON AT0115.TransactionID = AT0114.ReTransactionID AND AT0115.DivisionID = AT0114.DivisionID
INNER JOIN AT2007 WITH(NOLOCK) ON AT2007.VoucherID = AT0114.ReVoucherID AND AT2007.DivisionID = AT0114.DivisionID AND AT2007.TransactionID = AT0114.ReTransactionID 
INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
WHERE AT0114.DivisionID = '''+@DivisionID+'''
	AND (AT0114.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
	AND (AT0114.ReVoucherDate BETWEEN '''+@FromDateText+'''  AND '''+@ToDateText+''')
	AND (AT0114.WareHouseID between '''+@FromWareHouseID+''' AND ''' + @ToWareHouseID + ''')	 
UNION ALL'
	SET @sSQL3 = N'
SELECT AT0115.InventoryID, AT1302.InventoryName, VoucherNo DeVoucherNo, VoucherDate DeVoucherDate, NULL ReQuantity,
NULL ReUnitPrice, PriceQuantity DeQuantity, AT0115.UnitPrice DeUnitPice, NULL OriginalAmount, NULL ConvertedAmount,
AT0115.ReVoucherNo FromVoucherNo, AT0115.ReVoucherDate FromVoucherDate, AT0115.WareHouseID, AT2007.UnitID, CurrencyID,
ExchangeRate, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes, AT0115.TransactionID, AT0115.DivisionID,
AT0115.S01ID, AT0115.S02ID, AT0115.S03ID, AT0115.S04ID, AT0115.S05ID, AT0115.S06ID, AT0115.S07ID, AT0115.S08ID, AT0115.S09ID, AT0115.S10ID, 
AT0115.S11ID, AT0115.S12ID, AT0115.S13ID, AT0115.S14ID, AT0115.S15ID, AT0115.S16ID, AT0115.S17ID, AT0115.S18ID, AT0115.S19ID, AT0115.S20ID '
	SET @sSQL4 = N'
FROM AT0115 WITH(NOLOCK)
	LEFT JOIN AT2007 WITH(NOLOCK) ON AT2007.VoucherID = AT0115.ReVoucherID AND AT2007.TransactionID = AT0115.RETransactionID AND AT2007.DivisionID = AT0115.DivisionID
	INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0115.DivisionID,''@@@'') AND AT1302.InventoryID = AT0115.InventoryID
WHERE AT0115.DivisionID = '''+@DivisionID+'''
	AND (AT0115.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
	AND (AT0115.VoucherDate Between '''+@FromDateText+'''  AND  '''+@ToDateText+''')
	AND (AT0115.WareHouseID between '''+@FromWareHouseID+'''  AND ''' + @ToWareHouseID + ''')'			
END
--Print @sSQL1
--Print @sSQL2
--Print @sSQL3
--Print @sSQL4
		
IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' and Name = 'AV3002') 
	EXEC ('CREATE VIEW AV3002 AS '+ @sSQL1+@sSQL2+@sSQL3+@sSQL4 ) ----tao boi AP3005_QC
ELSE 
	EXEC ('ALTER VIEW AV3002 AS ' + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4) ----tao boi AP3005_QC

-----Tao Veiw AV3003 --Ton cuoi ky
IF @IsDate = 0
BEGIN
	SET @sSQL1= N'
SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, ReVoucherNo VoucherNo, ReVoucherDate VoucherDate,
ReQuantity = ReQuantity - ISNULL((SELECT SUM(PriceQuantity) FROM AT0115 WITH(NOLOCK)
                                  WHERE TranMonth + TranYear * 100 <= '+@ToMonthYearText+'
                                  AND ReTransactionID = AT0114.ReTransactionID 
                                  AND DivisionID = AT0115.DivisionID), 0),
AT0114.UnitPrice ReUnitPrice, ReAmount = AV3004.ConvertedAmount  - ISNULL((SELECT SUM(ConvertedAmount) FROM AT0115 WITH(NOLOCK)
                                                                           WHERE TranMonth + TranYear * 100 <= '+@ToMonthYearText+'
																		   AND ReTransactionID = AT0114.ReTransactionID
																		   AND DivisionID = AT0115.DivisionID), 0),			
NULL DeQuantity, NULL DeUnitPice, NULL FromVoucherNo, NULL FromVoucherDate, AT0114.WareHouseID, AV3004.UnitID, AV3004.CurrencyID,
AV3004.ExchangeRate, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes, AT0114.ReTransactionID as TransactionID, AT0114.DivisionID,
AT0114.S01ID, AT0114.S02ID, AT0114.S03ID, AT0114.S04ID, AT0114.S05ID, AT0114.S06ID, AT0114.S07ID, AT0114.S08ID, AT0114.S09ID, AT0114.S10ID, 
AT0114.S11ID, AT0114.S12ID, AT0114.S13ID, AT0114.S14ID, AT0114.S15ID, AT0114.S16ID, AT0114.S17ID, AT0114.S18ID, AT0114.S19ID, AT0114.S20ID '
	SET @sSQL2 = N'
FROM AT0114 WITH(NOLOCK)
LEFT JOIN AV3004 ON AV3004.VoucherID = AT0114.ReVoucherID AND TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID
INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID =AT0114.InventoryID
WHERE AT0114.DivisionID = '''+@DivisionID+'''
AND (AT0114.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
AND (ReTranMonth + ReTranYear*100 <= ''' +	@ToMonthYearText + ''' OR TransactionTypeID =''T00'')
AND (AT0114.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND ''' + @ToWareHouseID + ''')'		
END
ELSE
BEGIN
	SET @sSQL1 = N'
SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, ReVoucherNo VoucherNo, ReVoucherDate VoucherDate,
ReQuantity = ReQuantity - ISNULL((SELECT SUM(PriceQuantity) FROM AT0115 WITH(NOLOCK)
                                  WHERE VoucherDate <= '''+ @ToDateText +'''
                                  AND ReTransactionID = AT0114.ReTransactionID And DivisionID = AT0115.DivisionID), 0),
AT0114.UnitPrice ReUnitPrice, ReAmount = AV3004.ConvertedAmount  - ISNULL((SELECT SUM(ConvertedAmount) FROM AT0115 WITH(NOLOCK)
                                                                           WHERE VoucherDate <= '''+ @ToDateText +'''
                                                                           AND ReTransactionID = AT0114.ReTransactionID
                                                                           AND DivisionID = AT0115.DivisionID), 0),
NULL DeQuantity, NULL DeUnitPice, NULL FromVoucherNo, NULL FromVoucherDate, AT0114.WareHouseID, AV3004.UnitID,
AV3004.CurrencyID, AV3004.ExchangeRate, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
Notes, AT0114.ReTransactionID TransactionID, AT0114.DivisionID,
AT0114.S01ID, AT0114.S02ID, AT0114.S03ID, AT0114.S04ID, AT0114.S05ID, AT0114.S06ID, AT0114.S07ID, AT0114.S08ID, AT0114.S09ID, AT0114.S10ID, 
AT0114.S11ID, AT0114.S12ID, AT0114.S13ID, AT0114.S14ID, AT0114.S15ID, AT0114.S16ID, AT0114.S17ID, AT0114.S18ID, AT0114.S19ID, AT0114.S20ID '			
	 SET @sSQL2 = N'
FROM AT0114 WITH(NOLOCK)
LEFT JOIN AV3004 ON AV3004.VoucherID = AT0114.ReVoucherID AND TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID
INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
WHERE AT0114.DivisionID ='''+@DivisionID+'''
	AND (AT0114.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
	AND ( AT0114.ReVoucherDate <= '''+@ToDateText+''' OR TransactionTypeID = ''T00'' )
	AND (AT0114.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND  ''' + @ToWareHouseID + ''')' 
END

IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV3003')
	EXEC ('CREATE VIEW AV3003 AS '+ @sSQL1+@sSQL2 ) ----tao boi AP3005_QC
ELSE
	EXEC ('ALTER VIEW AV3003 AS ' + @sSQL1 + @sSQL2) ----tao boi AP3005_QC
---Print  @sSQL1+@sSQL2

SET @sSQL4 = N''

SET @sSQL1 = N'
'+CASE WHEN ISNULL(@IsSearchStandard,0) = 1 THEN N'SELECT * INTO #AP3005_QC_Report FROM (' ELSE '' END+'
SELECT 1 [Type], InventoryID, InventoryName, VoucherNo, VoucherDate, ReQuantity, ReUnitPrice, NULL OriginalAmount, 
	ReAmount ConvertedAmount, DeQuantity, DeUnitPice, CAST(FromVoucherNo AS NVARCHAR(20)) AS FromVoucherNo, FromVoucherDate, 
	WareHouseID, UnitID, CurrencyID, ExchangeRate, Specification, Notes01, Notes02, Notes03, Notes, TransactionID, DivisionID,
	S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID,
	InventoryID + CASE WHEN ISNULL(S01ID,'''')<>'''' THEN ''.''+S01ID ELSE '''' END+
	CASE WHEN ISNULL(S02ID,'''')<>'''' THEN ''.''+S02ID ELSE '''' END+
	CASE WHEN ISNULL(S03ID,'''')<>'''' THEN ''.''+S03ID ELSE '''' END+
	CASE WHEN ISNULL(S04ID,'''')<>'''' THEN ''.''+S04ID ELSE '''' END+
	CASE WHEN ISNULL(S05ID,'''')<>'''' THEN ''.''+S05ID ELSE '''' END+
	CASE WHEN ISNULL(S06ID,'''')<>'''' THEN ''.''+S06ID ELSE '''' END+
	CASE WHEN ISNULL(S07ID,'''')<>'''' THEN ''.''+S07ID ELSE '''' END+
	CASE WHEN ISNULL(S08ID,'''')<>'''' THEN ''.''+S08ID ELSE '''' END+
	CASE WHEN ISNULL(S09ID,'''')<>'''' THEN ''.''+S09ID ELSE '''' END+
	CASE WHEN ISNULL(S10ID,'''')<>'''' THEN ''.''+S10ID ELSE '''' END+
	CASE WHEN ISNULL(S11ID,'''')<>'''' THEN ''.''+S11ID ELSE '''' END+
	CASE WHEN ISNULL(S12ID,'''')<>'''' THEN ''.''+S12ID ELSE '''' END+
	CASE WHEN ISNULL(S13ID,'''')<>'''' THEN ''.''+S13ID ELSE '''' END+
	CASE WHEN ISNULL(S14ID,'''')<>'''' THEN ''.''+S14ID ELSE '''' END+
	CASE WHEN ISNULL(S15ID,'''')<>'''' THEN ''.''+S15ID ELSE '''' END+
	CASE WHEN ISNULL(S16ID,'''')<>'''' THEN ''.''+S16ID ELSE '''' END+
	CASE WHEN ISNULL(S17ID,'''')<>'''' THEN ''.''+S17ID ELSE '''' END+
	CASE WHEN ISNULL(S18ID,'''')<>'''' THEN ''.''+S18ID ELSE '''' END+
	CASE WHEN ISNULL(S19ID,'''')<>'''' THEN ''.''+S19ID ELSE '''' END+
	CASE WHEN ISNULL(S20ID,'''')<>'''' THEN ''.''+S20ID ELSE '''' END As InventoryID_QC'
	
SET @sSQL2 = N'
FROM AV3001
WHERE ReQuantity > 0
UNION ALL
SELECT 2 [Type], InventoryID, InventoryName, VoucherNo,VoucherDate, ReQuantity, ReUnitPrice,  OriginalAmount,ConvertedAmount, 
	DeQuantity, DeUnitPice ,FromVoucherNo , FromVoucherDate, WareHouseID, UnitID, CurrencyID, ExchangeRate, Specification,
	Notes01, Notes02, Notes03, Notes, TransactionID, DivisionID,	S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID,	InventoryID + CASE WHEN ISNULL(S01ID,'''')<>'''' THEN ''.''+S01ID ELSE '''' END+
	CASE WHEN ISNULL(S02ID,'''')<>'''' THEN ''.''+S02ID ELSE '''' END+
	CASE WHEN ISNULL(S03ID,'''')<>'''' THEN ''.''+S03ID ELSE '''' END+
	CASE WHEN ISNULL(S04ID,'''')<>'''' THEN ''.''+S04ID ELSE '''' END+
	CASE WHEN ISNULL(S05ID,'''')<>'''' THEN ''.''+S05ID ELSE '''' END+
	CASE WHEN ISNULL(S06ID,'''')<>'''' THEN ''.''+S06ID ELSE '''' END+
	CASE WHEN ISNULL(S07ID,'''')<>'''' THEN ''.''+S07ID ELSE '''' END+
	CASE WHEN ISNULL(S08ID,'''')<>'''' THEN ''.''+S08ID ELSE '''' END+
	CASE WHEN ISNULL(S09ID,'''')<>'''' THEN ''.''+S09ID ELSE '''' END+
	CASE WHEN ISNULL(S10ID,'''')<>'''' THEN ''.''+S10ID ELSE '''' END+
	CASE WHEN ISNULL(S11ID,'''')<>'''' THEN ''.''+S11ID ELSE '''' END+
	CASE WHEN ISNULL(S12ID,'''')<>'''' THEN ''.''+S12ID ELSE '''' END+
	CASE WHEN ISNULL(S13ID,'''')<>'''' THEN ''.''+S13ID ELSE '''' END+
	CASE WHEN ISNULL(S14ID,'''')<>'''' THEN ''.''+S14ID ELSE '''' END+
	CASE WHEN ISNULL(S15ID,'''')<>'''' THEN ''.''+S15ID ELSE '''' END+
	CASE WHEN ISNULL(S16ID,'''')<>'''' THEN ''.''+S16ID ELSE '''' END+
	CASE WHEN ISNULL(S17ID,'''')<>'''' THEN ''.''+S17ID ELSE '''' END+
	CASE WHEN ISNULL(S18ID,'''')<>'''' THEN ''.''+S18ID ELSE '''' END+
	CASE WHEN ISNULL(S19ID,'''')<>'''' THEN ''.''+S19ID ELSE '''' END+
	CASE WHEN ISNULL(S20ID,'''')<>'''' THEN ''.''+S20ID ELSE '''' END As InventoryID_QCFROM AV3002
UNION ALL'
SET @sSQL3 = N'
SELECT 3 [Type], InventoryID, InventoryName, VoucherNo, VoucherDate, ReQuantity, ReUnitPrice, NULL OriginalAmount, ReAmount ConvertedAmount,  
	DeQuantity, DeUnitPice, CAST(FromVoucherNo AS NVARCHAR(20)) AS FromVoucherNo , FromVoucherDate, WareHouseID, UnitID, CurrencyID, ExchangeRate, 
	Specification, Notes01, Notes02, Notes03, Notes ,TransactionID, DivisionID,
	S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID,
	InventoryID + CASE WHEN ISNULL(S01ID,'''')<>'''' THEN ''.''+S01ID ELSE '''' END+
	CASE WHEN ISNULL(S02ID,'''')<>'''' THEN ''.''+S02ID ELSE '''' END+
	CASE WHEN ISNULL(S03ID,'''')<>'''' THEN ''.''+S03ID ELSE '''' END+
	CASE WHEN ISNULL(S04ID,'''')<>'''' THEN ''.''+S04ID ELSE '''' END+
	CASE WHEN ISNULL(S05ID,'''')<>'''' THEN ''.''+S05ID ELSE '''' END+
	CASE WHEN ISNULL(S06ID,'''')<>'''' THEN ''.''+S06ID ELSE '''' END+
	CASE WHEN ISNULL(S07ID,'''')<>'''' THEN ''.''+S07ID ELSE '''' END+
	CASE WHEN ISNULL(S08ID,'''')<>'''' THEN ''.''+S08ID ELSE '''' END+
	CASE WHEN ISNULL(S09ID,'''')<>'''' THEN ''.''+S09ID ELSE '''' END+
	CASE WHEN ISNULL(S10ID,'''')<>'''' THEN ''.''+S10ID ELSE '''' END+
	CASE WHEN ISNULL(S11ID,'''')<>'''' THEN ''.''+S11ID ELSE '''' END+
	CASE WHEN ISNULL(S12ID,'''')<>'''' THEN ''.''+S12ID ELSE '''' END+
	CASE WHEN ISNULL(S13ID,'''')<>'''' THEN ''.''+S13ID ELSE '''' END+
	CASE WHEN ISNULL(S14ID,'''')<>'''' THEN ''.''+S14ID ELSE '''' END+
	CASE WHEN ISNULL(S15ID,'''')<>'''' THEN ''.''+S15ID ELSE '''' END+
	CASE WHEN ISNULL(S16ID,'''')<>'''' THEN ''.''+S16ID ELSE '''' END+
	CASE WHEN ISNULL(S17ID,'''')<>'''' THEN ''.''+S17ID ELSE '''' END+
	CASE WHEN ISNULL(S18ID,'''')<>'''' THEN ''.''+S18ID ELSE '''' END+
	CASE WHEN ISNULL(S19ID,'''')<>'''' THEN ''.''+S19ID ELSE '''' END+
	CASE WHEN ISNULL(S20ID,'''')<>'''' THEN ''.''+S20ID ELSE '''' END As InventoryID_QC
FROM AV3003
WHERE ReQuantity > 0
'+CASE WHEN ISNULL(@IsSearchStandard,0) = 1 THEN N')Temp' ELSE '' END+''

IF ISNULL(@IsSearchStandard,0) = 1
BEGIN
	SET @sSQL4 = N'
	SELECT * 
	FROM
	(
		SELECT T1.*
		FROM #AP3005_QC_Report AS T1
		INNER JOIN #StandardList_AP3005_QC T2 ON T1.InventoryID = T2.InventoryID
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
		FROM #AP3005_QC_Report AS T1
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #StandardList_AP3005_QC T2 WHERE T1.InventoryID = T2.InventoryID)
		AND ISNULL(T1.S01ID,'''') = '''' AND ISNULL(T1.S02ID,'''') = '''' AND ISNULL(T1.S03ID,'''') = ''''
		AND ISNULL(T1.S04ID,'''') = '''' AND ISNULL(T1.S05ID,'''') = '''' AND ISNULL(T1.S06ID,'''') = '''' 
		AND ISNULL(T1.S07ID,'''') = '''' AND ISNULL(T1.S08ID,'''') = '''' AND ISNULL(T1.S09ID,'''') = '''' 
		AND ISNULL(T1.S10ID,'''') = '''' AND ISNULL(T1.S11ID,'''') = '''' AND ISNULL(T1.S12ID,'''') = '''' 
		AND ISNULL(T1.S13ID,'''') = '''' AND ISNULL(T1.S14ID,'''') = '''' AND ISNULL(T1.S15ID,'''') = '''' 
		AND ISNULL(T1.S16ID,'''') = '''' AND ISNULL(T1.S17ID,'''') = '''' AND ISNULL(T1.S18ID,'''') = '''' 
		AND ISNULL(T1.S19ID,'''') = '''' AND ISNULL(T1.S20ID,'''') = '''' 
	)Temp'
END

--PRINT(@sSQL1)
--PRINT(@sSQL2)
--PRINT(@sSQL3)
--PRINT(@sSQL4)

EXEC (@sSQL1+ @sSQL2 + @sSQL3 + @sSQL4)
		
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
