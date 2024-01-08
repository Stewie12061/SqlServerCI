IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30018_DV]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30018_DV]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---Created by : Hoài Bảo, date: 10/10/2022
---Purpose: In báo cáo tổng hợp tình hình giao hàng - Clone từ store OP0301_DV
---- EXEC SOP30018_DV 'mk',0,5,5,2016,2016,'2016/05/21','2016/05/21','','',1,'CI1'
CREATE PROCEDURE [dbo].[SOP30018_DV]
		@DivisionID NVARCHAR(50),
		@DivisionIDList NVARCHAR(MAX),
		@IsDate TINYINT,
		@PeriodIDList NVARCHAR(2000),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@InventoryID NVARCHAR(MAX),
		@IsGroup AS TINYINT,
		@GroupID NVARCHAR(50) -- GroupID: OB, CI1, CI2, CI3, I01, I02, I03, I04, I05	
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@GroupField NVARCHAR(50),
		@sFROM NVARCHAR(MAX),
		@sSELECT NVARCHAR(MAX),
		@sWHERE NVARCHAR(MAX),
    --@FromMonthYearText NVARCHAR(20), 
    --@ToMonthYearText NVARCHAR(20),
    @FromDateText NVARCHAR(20), 
    @ToDateText NVARCHAR(20)
    
--SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
--SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

Select @sFROM = '',  @sSELECT = ''

SET @sSQL = N'
SELECT * FROM
(
SELECT DISTINCT 
		AT2007.DivisionID, 
		AT2007.OrderID, 
		OT2002.TransactionID, 
		AT2007.InventoryID,
		AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
		SUM(ActualQuantity) AS ActualQuantity, 
		MAX(AT2006.VoucherDate) AS ActualDate, 
		SUM(CASE WHEN ' 
			+ CASE WHEN @IsDate = 1 
				THEN ' CONVERT(DATETIME,CONVERT(VARCHAR(10),OT2001.OrderDate,101),101) < ''' + @FromDateText + ''''
				ELSE '(CASE WHEN OT2001.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(OT2001.TranMonth))) + ''/''
										+ LTRIM(RTRIM(STR(OT2001.TranYear))) ELSE RTRIM(LTRIM(STR(OT2001.TranMonth))) + ''/''
										+ lTRIM(RTRIM(STR(OT2001.TranYear))) END) IN ('''+@PeriodIDList+''')' END
			+ 'THEN AT2007.ActualQuantity ELSE 0 END) AS ActualQuantity0,
		AT2006.VoucherDate AS ExportVoucherDate,
		AT2006.TranMonth AS ExportTranMonth,
		AT2006.TranYear AS ExportTranYear,
		OT2001.OrderDate AS SaleOrderDate,
		OT2001.TranMonth AS SaleTranMonth,
		OT2001.TranYear AS SaleTranYear
FROM AT2007 WITH (NOLOCK) 
INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2007.VoucherID = AT2006.VoucherID AND AT2006.KindVoucherID IN (2, 4, 3) 
INNER JOIN OT2002 WITH (NOLOCK) ON OT2002.DivisionID = AT2007.DivisionID AND OT2002.TransactionID = AT2007.OTransactionID
INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = AT2007.DivisionID AND OT2001.SOrderID = OT2002.SOrderID AND OT2001.OrderType = 0 AND OT2001.OrderStatus NOT IN (9) 
GROUP BY AT2007.DivisionID, AT2007.OrderID, AT2007.InventoryID, 
		AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, OT2002.TransactionID, 
        AT2006.VoucherDate, AT2006.TranMonth, AT2006.TranYear,
		OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear
'

SET @sSQL2 ='
UNION ALL

SELECT DISTINCT 
		AT2007.DivisionID, 
		OT200102.SOrderID AS OrderID, 
		OT200202.TransactionID, 
		AT2007.InventoryID,
		AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
		SUM(ActualQuantity) AS ActualQuantity, 
		MAX(AT2006.VoucherDate) AS ActualDate, 
		SUM(CASE WHEN ' 
			+ CASE WHEN @IsDate = 1 
				THEN 'CONVERT(DATETIME,CONVERT(VARCHAR(10),OT200101.OrderDate,101),101) < ''' + @FromDateText + ''''
				ELSE '(CASE WHEN OT2001.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(OT2001.TranMonth))) + ''/''
										+ LTRIM(RTRIM(STR(OT2001.TranYear))) ELSE RTRIM(LTRIM(STR(OT2001.TranMonth))) + ''/''
										+ lTRIM(RTRIM(STR(OT2001.TranYear))) END) IN ('''+@PeriodIDList+''')' END
			+ ' THEN AT2007.ActualQuantity ELSE 0 END) AS ActualQuantity0,
		AT2006.VoucherDate AS ExportVoucherDate,
		AT2006.TranMonth AS ExportTranMonth,
		AT2006.TranYear AS ExportTranYear,
		OT200102.OrderDate AS SaleOrderDate,
		OT200102.TranMonth AS SaleTranMonth,
		OT200102.TranYear AS SaleTranYear
FROM AT2007  WITH (NOLOCK)
INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID AND AT2006.KindVoucherID IN (2, 4, 3) 
INNER JOIN OT2002 OT200201 WITH (NOLOCK) ON OT200201.DivisionID = AT2007.DivisionID AND OT200201.TransactionID = AT2007.OTransactionID 
INNER JOIN OT2001 OT200101 WITH (NOLOCK) ON OT200101.DivisionID = AT2007.DivisionID AND OT200101.SOrderID = OT200201.SOrderID AND OT200101.OrderType = 1 AND OT200101.OrderStatus NOT IN (9) 
INNER JOIN OT2001 OT200102 WITH (NOLOCK) ON OT200102.DivisionID = AT2007.DivisionID AND OT200102.SOrderID = OT200201.RefSOrderID AND OT200102.OrderType = 0 AND OT200102.OrderStatus NOT IN (9) 
INNER JOIN OT2002 OT200202 WITH (NOLOCK) ON OT200202.DivisionID = AT2007.DivisionID AND OT200202.SOrderID = OT200102.SOrderID AND OT200202.InventoryID = OT200201.InventoryID
GROUP BY AT2007.DivisionID, OT200102.SOrderID, AT2007.InventoryID,
		AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, OT200202.TransactionID, 
        AT2006.VoucherDate, AT2006.TranMonth, AT2006.TranYear,
		OT200102.OrderDate, OT200102.TranMonth, OT200102.TranYear
) TEMP
WHERE DivisionID IN (''' + CASE WHEN ISNULL(@DivisionIDList, '') != '' THEN @DivisionIDList ELSE @DivisionID END + ''')'
----Modified on 14/11/2011
+ ' AND ' + CASE WHEN @IsDate = 1 
            THEN 'CONVERT(DATETIME,CONVERT(VARCHAR(10),ExportVoucherDate ,101),101) < ''' + @ToDateText + ''' '
			ELSE '(CASE WHEN ExportTranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(ExportTranMonth))) + ''/''
										+ LTRIM(RTRIM(STR(ExportTranYear))) ELSE RTRIM(LTRIM(STR(ExportTranMonth))) + ''/''
										+ lTRIM(RTRIM(STR(ExportTranYear))) END) IN ('''+@PeriodIDList+''')' END 
+ ' AND ' + CASE WHEN @IsDate = 1 
            THEN 'CONVERT(DATETIME,CONVERT(VARCHAR(10),SaleOrderDate,101),101) < ''' + @ToDateText + ''''
			ELSE '(CASE WHEN SaleTranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(SaleTranMonth))) + ''/''
										+ LTRIM(RTRIM(STR(SaleTranYear))) ELSE RTRIM(LTRIM(STR(SaleTranMonth))) + ''/''
										+ lTRIM(RTRIM(STR(SaleTranYear))) END) IN ('''+@PeriodIDList+''')' END + '
'
--PRINT(@sSQL)
IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE = 'V' AND NAME = 'OV0306')
	DROP VIEW OV0306
EXEC('CREATE VIEW OV0306 ---tao boi OP0301
		AS ' + @sSQL+@sSQL2)
 
IF @IsGroup  = 1 
	BEGIN
	EXEC AP4700 @GroupID, @GroupField OUTPUT
	SET @sFROM = @sFROM + '
LEFT JOIN AV6666 V1 on V1.SelectionType = ''' + @GroupID + ''' AND CAST(V1.SelectionID AS NVARCHAR(50)) = CAST(OV2300.' + @GroupField + ' AS NVARCHAR(50))'
	SET @sSELECT = @sSELECT + ', V1.SelectionID AS GroupID, V1.SelectionName AS GroupName'
				
	END
ELSE
	SET @sSELECT = @sSELECT +  ', 
		'''' AS GroupID, '''' AS GroupName'	

SET @sSQL =  N'
SELECT  DISTINCT OV2300.DivisionID ,  
		OV2300.OrderID AS SOrderID,  
		OV2300.VoucherNo,           
		OV2300.QuotationID,
		OV2300.VoucherDate AS OrderDate,
		OV2300.ObjectID,
		OV2300.ObjectName,
		OV2300.Orders,
		OV2300.InventoryID, 
		OV2300.InventoryName, 
		OV2300.InNotes01,
		OV2300.InNotes02,
		OV2300.Specification,
		OV2300.SName1,
		OV2300.SName2,
		OV2300.UnitName,
		OV2300.OrderQuantity,
		OV2300.SalePrice,
		ISNULL(OV2300.SalePrice, 0)* ISNULL(OV2300.ExchangeRate, 0) AS ConvertedPrice,	
		OV2300.OriginalAmount,
		OV2300.ConvertedAmount,
		OV2300.VATPercent, 
		OV2300.VATOriginalAmount,
		OV2300. VATConvertedAmount,
		OV2300.DiscountPercent, 
		OV2300.DiscountOriginalAmount,
		OV2300.DiscountConvertedAmount,
		OV2300.CommissionPercent, 
		OV2300.CommissionOAmount, 
		OV2300.CommissionCAmount,
		OV2300.TotalOriginalAmount AS TOriginalAmount,
		OV2300.TotalConvertedAmount AS TConvertedAmount,
		OV2300.ShipDate,
		OV2300.RefInfor,
		OV2300.Varchar01,
        OV2300.Varchar02,
        OV2300.Varchar03,
        OV2300.Varchar04,
        OV2300.Varchar05,
        OV2300.Varchar06,
        OV2300.Varchar07,
        OV2300.Varchar08,
        OV2300.Varchar09,
        OV2300.Varchar10,
        OV2300.Varchar11,
        OV2300.Varchar12,
        OV2300.Varchar13,
        OV2300.Varchar14,
        OV2300.Varchar15,
        OV2300.Varchar16,
        OV2300.Varchar17,
        OV2300.Varchar18,
        OV2300.Varchar19,
        OV2300.Varchar20,
		OV0306.ActualQuantity,
		OV0306.ActualDate,
		VAna01ID, VAna02ID,  VAna03ID, VAna04ID, VAna05ID,
		VAna01Name,VAna02Name, VAna03name,VAna04Name,VAna05Name,
		CASE WHEN ISNULL(OV2300.ShipDate, '''') = '''' OR ISNULL(OV0306.ActualDate, '''') = '''' THEN 0 ELSE 
		DATEDIFF(day, OV2300.ShipDate, OV0306.ActualDate) END AS AfterDayAmount,
		(OV2300.FOrderQuantity - (	SELECT	SUM(ISNULL(B.ActualQuantity,0))
		                            FROM	OV0306 B 
		                          	WHERE	B.ExportVoucherDate <= OV0306.ExportVoucherDate 
 											AND B.OrderID = OV0306.OrderID )
 								 + ISNULL(OV2300.AdjustQuantity, 0)) AS RemainQuantity,
		OV2300.OrderStatus, OV1101.Description AS OrderStatusName,
		OV2300.Ana01ID, OV2300.Ana02ID, OV2300.Ana03ID, OV2300.Ana04ID, OV2300.Ana05ID,
		OV2300.Ana06ID, OV2300.Ana07ID, OV2300.Ana08ID, OV2300.Ana09ID, OV2300.Ana10ID,
		OV2300.AnaName01, OV2300.AnaName02, OV2300.AnaName03, OV2300.AnaName04, OV2300.AnaName05,
		OV2300.AnaName06, OV2300.AnaName07, OV2300.AnaName08, OV2300.AnaName09, OV2300.AnaName10, 
		OV2300.VDescription, 
		CASE WHEN (OV2300.FOrderQuantity - (	SELECT	SUM(ISNULL(B.ActualQuantity,0))
		                            FROM	OV0306 B 
		                          	WHERE	B.ExportVoucherDate <= OV0306.ExportVoucherDate 
 											AND B.OrderID = OV0306.OrderID ) + ISNULL(OV2300.AdjustQuantity, 0)) = 0 THEN 0
		when ISNULL(OV0306.ActualQuantity,0) = 0 THEN 1
		when (ISNULL(OV0306.ActualQuantity,0) > 0 AND 
				(OV2300.FOrderQuantity - (	SELECT	SUM(ISNULL(B.ActualQuantity,0))
		                            FROM	OV0306 B 
		                          	WHERE	B.ExportVoucherDate <= OV0306.ExportVoucherDate 
 											AND B.OrderID = OV0306.OrderID ) + ISNULL(OV2300.AdjustQuantity, 0)) > 0) THEN 2
		END AS Status, '''' AS StatusInword,
		
		---OV0306.RefNo01, OV0306.RefNo02
		OV2300.Parameter01 as OParameter01, OV2300.Parameter02 as OParameter02, OV2300.Parameter03 as OParameter03, OV2300.Parameter04 as OParameter04, OV2300.Parameter05 as OParameter05,
		OV0306.Parameter01 as WParameter01, OV0306.Parameter02 as WParameter02, OV0306.Parameter03 as WParameter03, OV0306.Parameter04 as WParameter04, OV0306.Parameter05 as WParameter05
		'  
		
SET @sSQL1 =  @sSELECT  + N'
FROM		OV2300 
LEFT JOIN	OV0306  
	ON		OV0306.OrderID = OV2300.OrderID 
			AND OV0306.InventoryID = OV2300.InventoryID 
			AND OV0306.TransactionID = OV2300.TransactionID 
			AND OV0306.DivisionID = OV2300.DivisionID
' + @sFROM + '
LEFT JOIN	OV1101 
	ON		OV2300.OrderStatus = OV1101.OrderStatus 
			AND OV2300.DivisionID = OV1101.DivisionID 
			AND OV1101.TypeID = ''SO''
WHERE	OV2300.OrderType = 0 AND OV2300.DivisionID IN (''' + CASE WHEN ISNULL(@DivisionIDList, '') != '' THEN @DivisionIDList ELSE @DivisionID END + ''') AND ' + 
		CASE WHEN @IsDate = 1 THEN ' ((OV2300.OrderStatus NOT IN ( 3, 4) AND
		CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2300.VoucherDate,101),101) BETWEEN ''' + 					
		@FromDateText + ''' AND ''' +  @ToDateText  + ''' AND
		(OV2300.OrderQuantity - ISNULL(OV0306.ActualQuantity0, 0) + ISNULL(OV2300.AdjustQuantity, 0)) > 0) OR
		CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2300.VoucherDate,101),101)  BETWEEN ''' +
		@FromDateText + ''' AND ''' +  @ToDateText  + ''') '
		ELSE ' ((OV2300.OrderStatus NOT IN (2, 3, 4) AND
		(CASE WHEN OV2300.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(OV2300.TranMonth))) + ''/''
										+ LTRIM(RTRIM(STR(OV2300.TranYear))) ELSE RTRIM(LTRIM(STR(OV2300.TranMonth))) + ''/''
										+ lTRIM(RTRIM(STR(OV2300.TranYear))) END) IN ('''+@PeriodIDList+''')'
		
		  + ' AND
		(OV2300.OrderQuantity - ISNULL(OV0306.ActualQuantity0, 0) + ISNULL(OV2300.AdjustQuantity, 0)) > 0) OR 
		(CASE WHEN OV2300.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(OV2300.TranMonth))) + ''/''
										+ LTRIM(RTRIM(STR(OV2300.TranYear))) ELSE RTRIM(LTRIM(STR(OV2300.TranMonth))) + ''/''
										+ lTRIM(RTRIM(STR(OV2300.TranYear))) END) IN ('''+@PeriodIDList+''')' +
		 
		' AND OV2300.InventoryID ' + CASE WHEN ISNULL(@InventoryID, '%') = '%' THEN ' LIKE ''%'''
		ELSE ' IN (''' + @InventoryID + ''')' END
		END

IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME = 'OV0301' AND XTYPE ='V') 
	DROP VIEW OV0301
EXEC ('CREATE VIEW OV0301  --tao boi OP0301
		AS '+@sSQL+@sSQL1)

SELECT ROW_NUMBER() OVER (ORDER BY OV0301.VoucherNo) AS RowNum,* FROM OV0301

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON