IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0352]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0352]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Sổ chi tiết bán hàng phân theo nhóm thuế suất thuế TNDN (ANGEL)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 21/11/2016 by Hải Long
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
-- <Example>
---- EXEC AP0352 @DivisionID = 'ANG', @FromPeriod = 201601, @ToPeriod = 201601

CREATE PROCEDURE [dbo].[AP0352]
( 
		@DivisionID AS VARCHAR(50),
		@FromPeriod  AS int, 
		@ToPeriod  AS int
) 
AS 

DECLARE @sSQL1 NVARCHAR(4000),
		@sSQL2 NVARCHAR(4000),
		@sSQL3 NVARCHAR(4000),
		@sSQL4 NVARCHAR(4000),
		@sSQL5 NVARCHAR(4000),
		@sWhere NVARCHAR(4000)
		
SET @sWhere = '
AND AT9000.TranMonth + AT9000.TranYear * 100 BETWEEN '+ Convert(nvarchar(10), @FromPeriod) +' AND ' + Convert(nvarchar(10), @ToPeriod)
	
SET @sSQL1 = '
SELECT AT9000.DivisionID, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.InventoryID, AT1302.InventoryName, AT1302.I05ID, AT1015.AnaName, 
AT9000.UnitID, AT1304.UnitName, AT9000.DebitAccountID AS CorAccountID,
SUM(ISNULL(AT9000.Quantity, 0)) AS Quantity,
SUM(CASE WHEN AT9000.IsProInventoryID = 1 THEN ISNULL(A1.UnitPrice, 0) ELSE ISNULL(AT9000.UnitPrice, 0) END) AS UnitPrice,
SUM(CASE WHEN AT9000.IsProInventoryID = 1 THEN ISNULL(A1.UnitPrice, 0)*ISNULL(AT9000.Quantity, 0) - ISNULL(AT9000.DiscountAmount, 0) - ISNULL(AT9000.DiscountSaleAmountDetail, 0)
ELSE ISNULL(AT9000.ConvertedAmount, 0) END) AS ConvertedAmount1, NULL AS ConvertedAmount2, NULL AS ConvertedAmount3, NULL AS ConvertedAmount4,
SUM(ISNULL(AT1010.VATRate, 0))*SUM(ISNULL(AT9000.ConvertedAmount, 0))/100 AS VATConvertedAmount
INTO #TEMP1
FROM AT9000 WITH (NOLOCK)
LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1302.InventoryID = AT9000.InventoryID
LEFT JOIN AT1015 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1015.DivisionID,''@@@'') AND AT1015.AnaID = AT1302.I05ID AND AT1015.AnaTypeID = ''I05''
LEFT JOIN 
(
	SELECT AT0266_AG.DivisionID, AT0266_AG.VoucherID, MAX(AT2007.UnitPrice) AS UnitPrice, AT2007.InventoryID, MAX(AT2007.ExchangeRate) AS ExchangeRate
	FROM AT0266_AG WITH (NOLOCK) 
	LEFT JOIN AT2007 WITH (NOLOCK) ON AT2007.VoucherID = AT0266_AG.InheritVoucherID AND AT2007.TransactionID = AT0266_AG.InheritTransactionID
	GROUP BY AT0266_AG.DivisionID, AT0266_AG.VoucherID, AT2007.InventoryID
) A1 ON A1.DivisionID = AT9000.DivisionID AND A1.VoucherID = AT9000.VoucherID AND A1.InventoryID = AT9000.InventoryID
where AT9000.DivisionID = '''+@DivisionID+'''
and AT9000.TransactionTypeID in (''T04'',''T40'')' + @sWhere + '
GROUP BY AT9000.DivisionID, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.InventoryID, AT1302.InventoryName, AT1302.I05ID, AT1015.AnaName, 
AT9000.UnitID, AT1304.UnitName, AT9000.DebitAccountID, A1.UnitPrice, AT9000.UnitPrice
'

SET @sSQL2 = '
SELECT AT9000.DivisionID, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.InventoryID, AT1302.InventoryName, AT1302.I05ID, AT1015.AnaName, 
AT9000.UnitID, AT1304.UnitName, AT9000.DebitAccountID AS CorAccountID,
SUM(ISNULL(AT9000.Quantity, 0)) AS Quantity, AT9000.UnitPrice,
NULL AS ConvertedAmount1, SUM(ISNULL(AT9000.ConvertedAmount, 0)) AS ConvertedAmount2, NULL AS ConvertedAmount3, NULL AS ConvertedAmount4,
SUM(ISNULL(AT1010.VATRate, 0))*SUM(ISNULL(AT9000.ConvertedAmount, 0))/100*-1 AS VATConvertedAmount
INTO #TEMP2
FROM AT9000 WITH (NOLOCK)
LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1302.InventoryID = AT9000.InventoryID
LEFT JOIN AT1015 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1015.DivisionID,''@@@'') AND AT1015.AnaID = AT1302.I05ID AND AT1015.AnaTypeID = ''I05''
where AT9000.DivisionID = '''+@DivisionID+'''
and AT9000.TransactionTypeID = ''T24''' + @sWhere + '
GROUP BY AT9000.DivisionID, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.InventoryID, AT1302.InventoryName, AT1302.I05ID, AT1015.AnaName, 
AT9000.UnitID, AT1304.UnitName, AT9000.DebitAccountID, AT9000.UnitPrice
'

SET @sSQL3 = '
SELECT AT9000.DivisionID, ISNULL(AT9000.InvoiceNo, AT9000.VoucherNo) AS InvoiceNo, ISNULL(AT9000.InvoiceDate, AT9000.VoucherDate) AS InvoiceDate, 
AT9000.InventoryID, AT1302.InventoryName, AT1302.I05ID, AT1015.AnaName, AT9000.UnitID, AT1304.UnitName, AT9000.CreditAccountID AS CorAccountID,
SUM(ISNULL(AT9000.Quantity, 0)) AS Quantity, AT9000.UnitPrice, 
NULL AS ConvertedAmount1, NULL AS ConvertedAmount2, SUM(ISNULL(AT9000.ConvertedAmount, 0)) AS ConvertedAmount3, NULL AS ConvertedAmount4,
SUM(ISNULL(AT1010.VATRate, 0))*SUM(ISNULL(AT9000.ConvertedAmount, 0))/100*-1 AS VATConvertedAmount
INTO #TEMP3
FROM AT9000 WITH (NOLOCK)
LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1302.InventoryID = AT9000.InventoryID
LEFT JOIN AT1015 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1015.DivisionID,''@@@'') AND AT1015.AnaID = AT1302.I05ID AND AT1015.AnaTypeID = ''I05''
where AT9000.DivisionID = '''+@DivisionID+'''
AND AT9000.DebitAccountID LIKE ''5213%''' + @sWhere + '
GROUP BY AT9000.DivisionID, AT9000.InvoiceNo, AT9000.VoucherNo, AT9000.InvoiceDate, AT9000.VoucherDate, AT9000.InventoryID, AT1302.InventoryName, 
AT1302.I05ID, AT1015.AnaName, AT1015.AnaName, AT9000.UnitID, AT1304.UnitName, AT9000.CreditAccountID, AT9000.UnitPrice
'

SET @sSQL4 = '
SELECT AT9000.DivisionID, ISNULL(AT9000.InvoiceNo, AT9000.VoucherNo) AS InvoiceNo, ISNULL(AT9000.InvoiceDate, AT9000.VoucherDate) AS InvoiceDate, 
AT9000.InventoryID, AT1302.InventoryName, AT1302.I05ID, AT1015.AnaName, AT9000.UnitID, AT1304.UnitName, AT9000.CreditAccountID AS CorAccountID,
SUM(ISNULL(AT9000.Quantity, 0)) AS Quantity, AT9000.UnitPrice,
NULL AS ConvertedAmount1, NULL AS ConvertedAmount2, NULL AS ConvertedAmount3, SUM(ISNULL(AT9000.ConvertedAmount, 0)) AS ConvertedAmount4,
SUM(ISNULL(AT1010.VATRate, 0))*SUM(ISNULL(AT9000.ConvertedAmount, 0))/100*-1 AS VATConvertedAmount
INTO #TEMP4
FROM AT9000 WITH (NOLOCK)
LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1302.InventoryID = AT9000.InventoryID
LEFT JOIN AT1015 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1015.DivisionID,''@@@'') AND AT1015.AnaID = AT1302.I05ID AND AT1015.AnaTypeID = ''I05''
where AT9000.DivisionID = '''+@DivisionID+'''
AND AT9000.DebitAccountID LIKE ''5211%''' + @sWhere + '
GROUP BY AT9000.DivisionID, AT9000.InvoiceNo, AT9000.VoucherNo, AT9000.InvoiceDate, AT9000.VoucherDate, AT9000.InventoryID, AT1302.InventoryName, 
AT1302.I05ID, AT1015.AnaName, AT9000.UnitID, AT1304.UnitName, AT9000.CreditAccountID, AT9000.UnitPrice
'

SET @sSQL5 = '
SELECT * 
FROM #TEMP1
UNION ALL
SELECT * 
FROM #TEMP2
UNION ALL
SELECT * 
FROM #TEMP3
UNION ALL
SELECT *
FROM #TEMP4
ORDER BY I05ID, InvoiceDate, InvoiceNo
'
EXEC (@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4 + @sSQL5)
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3
PRINT @sSQL4
PRINT @sSQL5

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
