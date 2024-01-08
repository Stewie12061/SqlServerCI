IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0306_AP]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0306_AP]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung

CREATE PROCEDURE [dbo].[OP0306_AP]  
				@DivisionID nvarchar(50),
				@IsDate tinyint,
				@FromMonth int,				
				@ToMonth int,
				@FromYear int,
				@ToYear int,
				@FromDate datetime,
				@ToDate datetime,				
				@FromInventoryID nvarchar(50),
				@ToInventoryID nvarchar(50),
				@FromObjectID nvarchar(50),
				@ToObjectID nvarchar(50),
				@IsGroup AS tinyint,
				@GroupID nvarchar(50) -- GroupID: OB, CI1, CI2, CI3, I01, I02, I03, I04, I05	
AS
DECLARE @sSQL nvarchar(max),
		@sSQL1 nvarchar(max),
		@sSQL2 nvarchar(max),
		@GroupField nvarchar(50),
		@sFROM nvarchar(max),
		@sSELECT nvarchar(max),
		@sWHERE nvarchar(max), 
		@FromMonthYearText NVARCHAR(20), 
		@ToMonthYearText NVARCHAR(20),
		@LastDateMonth NVARCHAR(20),  
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20),
		@CustomerName as int
    
SELECT @CustomerName = CustomerName FROM CustomerIndex

	SET @FromMonthYearText = Convert(varchar(50), @FromMonth) + '/01/' + Convert(varchar(50), @FromYear)
	SET @ToMonthYearText = Convert(varchar(50), @ToMonth) + '/01/' + Convert(varchar(50), @ToYear)
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	
	SET @LastDateMonth = SUBSTRING(CONVERT(NVARCHAR(20), (DATEADD(d,-1,DATEADD(mm, DATEDIFF(m,0,@ToMonthYearText)+1,0))), 101),4,2)
	SET @ToMonthYearText = Convert(varchar(50), @ToMonth) + '/' + @LastDateMonth + '/' + Convert(varchar(50), @ToYear)

Select @sFROM = '',  @sSELECT = ''

Set @sSQL = N'
SELECT DivisionID, 
		OrderID, 
		TransactionID, 
		InventoryID,
		Parameter01, Parameter02, Parameter03, Parameter04, Parameter05,
		SUM(ActualQuantity) as ActualQuantity, 
		MAX(ActualDate) as ActualDate, 
		SaleOrderDate,
		SaleTranMonth,
		SaleTranYear,Ana02IDAP, ExportType, NotesAP
FROM
(
SELECT DISTINCT 
		AT2007.DivisionID, 
		AT2007.OrderID, 
		OT2002.TransactionID, 
		AT2007.InventoryID,
		AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
		SUM(ActualQuantity) AS ActualQuantity, 
		MAX(AT2006.VoucherDate) AS ActualDate, 
		AT2006.VoucherDate AS ExportVoucherDate,
		AT2006.TranMonth AS ExportTranMonth,
		AT2006.TranYear AS ExportTranYear,
		OT2001.OrderDate AS SaleOrderDate,
		OT2001.TranMonth AS SaleTranMonth,
		OT2001.TranYear AS SaleTranYear,
		OT2002.Ana02IDAP, OT2002.ExportType, OT2002.NotesAP
FROM AT2007 WITH (NOLOCK) 
INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2007.VoucherID = AT2006.VoucherID AND AT2006.KindVoucherID IN (2, 4, 3) 
INNER JOIN OT2002 WITH (NOLOCK) ON OT2002.DivisionID = AT2007.DivisionID AND OT2002.TransactionID = AT2007.OTransactionID
INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = AT2007.DivisionID AND OT2001.SOrderID = OT2002.SOrderID AND OT2001.OrderType = 0 AND OT2001.OrderStatus NOT IN (9) 
GROUP BY AT2007.DivisionID, AT2007.OrderID, AT2007.InventoryID, 
		AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, OT2002.TransactionID, 
		AT2006.VoucherDate, AT2006.TranMonth, AT2006.TranYear,
		OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear,
		OT2002.Ana02IDAP, OT2002.ExportType, OT2002.NotesAP
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
		AT2006.VoucherDate AS ExportVoucherDate,
		AT2006.TranMonth AS ExportTranMonth,
		AT2006.TranYear AS ExportTranYear,
		OT200102.OrderDate AS SaleOrderDate,
		OT200102.TranMonth AS SaleTranMonth,
		OT200102.TranYear AS SaleTranYear,
		OT200201.Ana02IDAP, OT200201.ExportType, OT200201.NotesAP
FROM AT2007  WITH (NOLOCK)
INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID AND AT2006.KindVoucherID IN (2, 4, 3) 
INNER JOIN OT2002 OT200201 WITH (NOLOCK) ON OT200201.DivisionID = AT2007.DivisionID AND OT200201.TransactionID = AT2007.OTransactionID 
INNER JOIN OT2001 OT200101 WITH (NOLOCK) ON OT200101.DivisionID = AT2007.DivisionID AND OT200101.SOrderID = OT200201.SOrderID AND OT200101.OrderType = 1 AND OT200101.OrderStatus NOT IN (9) 
INNER JOIN OT2001 OT200102 WITH (NOLOCK) ON OT200102.DivisionID = AT2007.DivisionID AND OT200102.SOrderID = OT200201.RefSOrderID AND OT200102.OrderType = 0 AND OT200102.OrderStatus NOT IN (9) 
INNER JOIN OT2002 OT200202 WITH (NOLOCK) ON OT200202.DivisionID = AT2007.DivisionID AND OT200202.SOrderID = OT200102.SOrderID AND OT200202.InventoryID = OT200201.InventoryID
GROUP BY AT2007.DivisionID, OT200102.SOrderID, AT2007.InventoryID,
		AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, OT200202.TransactionID, 
		AT2006.VoucherDate, AT2006.TranMonth, AT2006.TranYear,
		OT200102.OrderDate, OT200102.TranMonth, OT200102.TranYear,
		OT200201.Ana02IDAP, OT200201.ExportType, OT200201.NotesAP
) TEMP
WHERE DivisionID = ''' + @DivisionID +  ''''
----Modified on 14/11/2011
 + '
GROUP BY DivisionID, 
		OrderID, 
		TransactionID, 
		InventoryID,
		Parameter01, Parameter02, Parameter03, Parameter04, Parameter05,
		SaleOrderDate,
		SaleTranMonth,
		SaleTranYear, Ana02IDAP, ExportType, NotesAP
'
--PRINT(@sSQL)
--print(@sSQL+@sSQL2)

IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE = 'V' AND NAME = 'OV0306_AP')
	DROP VIEW OV0306_AP
EXEC('CREATE VIEW OV0306_AP ---tao boi OP0301
		as ' + @sSQL+@sSQL2)
 
IF @IsGroup  = 1 
	BEGIN
	Exec AP4700  	@GroupID,	@GroupField OUTPUT
	SET @sFROM = @sFROM + '
LEFT JOIN AV6666 V1 on V1.SelectionType = ''' + @GroupID + ''' AND CAST(V1.SelectionID AS NVARCHAR(50)) = CAST(OV2300.' + @GroupField + ' AS NVARCHAR(50))'
	SET @sSELECT = @sSELECT + ', V1.SelectionID AS GroupID, V1.SelectionName AS GroupName'
				
	END
ELSE
	Set @sSELECT = @sSELECT +  ', 
		'''' AS GroupID, '''' AS GroupName'	

Set @sSQL =  N'
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
		CASE WHEN ISNULL(OV2300.ShipDate, '''') = '''' or ISNULL(OV0306.ActualDate, '''') = '''' then 0 else 
		DATEDIFF(day, OV2300.ShipDate, OV0306.ActualDate) end AS AfterDayAmount,
		(OV2300.FOrderQuantity - ISNULL(OV0306.ActualQuantity,0) + ISNULL(OV2300.AdjustQuantity, 0)) AS RemainQuantity,
		OV2300.OrderStatus, OV1101.Description AS OrderStatusName,
		OV2300.Ana01ID, OV2300.Ana02ID, OV2300.Ana03ID, OV2300.Ana04ID, OV2300.Ana05ID,
		OV2300.Ana06ID, OV2300.Ana07ID, OV2300.Ana08ID, OV2300.Ana09ID, OV2300.Ana10ID,
		OV2300.AnaName01, OV2300.AnaName02, OV2300.AnaName03, OV2300.AnaName04, OV2300.AnaName05,
		OV2300.AnaName06, OV2300.AnaName07, OV2300.AnaName08, OV2300.AnaName09, OV2300.AnaName10, 
		OV2300.VDescription, OV2300.InventoryTypeName,
		CASE WHEN (OV2300.FOrderQuantity - ISNULL(OV0306.ActualQuantity,0) + ISNULL(OV2300.AdjustQuantity, 0)) = 0 then 0
		when ISNULL(OV0306.ActualQuantity,0) = 0 then 1
		when (ISNULL(OV0306.ActualQuantity,0) > 0 AND 
				(OV2300.FOrderQuantity - ISNULL(OV0306.ActualQuantity,0) + ISNULL(OV2300.AdjustQuantity, 0)) > 0) then 2
		end AS Status, '''' AS StatusInword,
		OV2300.S2,
		---OV0306.RefNo01, OV0306.RefNo02
		OV2300.Parameter01 as OParameter01, OV2300.Parameter02 as OParameter02, OV2300.Parameter03 as OParameter03, OV2300.Parameter04 as OParameter04, OV2300.Parameter05 as OParameter05,
		OV0306.Parameter01 as WParameter01, OV0306.Parameter02 as WParameter02, OV0306.Parameter03 as WParameter03, OV0306.Parameter04 as WParameter04, OV0306.Parameter05 as WParameter05,
		OV2300.Ana02IDAP, OV2300.ExportType, OV2300.NotesAP,
		OV2300.S01ID, OV2300.S02ID, OV2300.S03ID, OV2300.S04ID, OV2300.S05ID, OV2300.S06ID, OV2300.S07ID, OV2300.S08ID, OV2300.S09ID, OV2300.S10ID,
		OV2300.S11ID, OV2300.S12ID, OV2300.S13ID, OV2300.S14ID, OV2300.S15ID, OV2300.S16ID, OV2300.S17ID, OV2300.S18ID, OV2300.S19ID, OV2300.S20ID,
		AT01.StandardName as StandardName01, AT02.StandardName as StandardName02, AT03.StandardName as StandardName03, AT04.StandardName as StandardName04, AT05.StandardName as StandardName05,
		AT06.StandardName as StandardName06, AT07.StandardName as StandardName07, AT08.StandardName as StandardName08, AT09.StandardName as StandardName09, AT10.StandardName as StandardName10,
		AT11.StandardName as StandardName11, AT12.StandardName as StandardName12, AT13.StandardName as StandardName13, AT14.StandardName as StandardName14, AT15.StandardName as StandardName15,
		AT16.StandardName as StandardName16, AT17.StandardName as StandardName17, AT18.StandardName as StandardName18, AT19.StandardName as StandardName19, AT11.StandardName as StandardName20,
		OV2300.Quantity01, OV2300.Quantity02, OV2300.Quantity03, OV2300.Quantity04, OV2300.Quantity05, OV2300.Quantity06, OV2300.Quantity07, OV2300.Quantity08, OV2300.Quantity09, OV2300.Quantity10,
		OV2300.Quantity11, OV2300.Quantity12, OV2300.Quantity13, OV2300.Quantity14, OV2300.Quantity15, OV2300.Quantity16, OV2300.Quantity17, OV2300.Quantity18, OV2300.Quantity19, OV2300.Quantity20,
		OV2300.Quantity21, OV2300.Quantity22, OV2300.Quantity23, OV2300.Quantity24, OV2300.Quantity25, OV2300.Quantity26, OV2300.Quantity27, OV2300.Quantity28, OV2300.Quantity29, OV2300.Quantity30
		'  
		
Set @sSQL1 =  @sSELECT  + N'
FROM		OV2300 
LEFT JOIN	OV0306_AP OV0306  
	ON		OV0306.OrderID = OV2300.OrderID 
			AND OV0306.InventoryID = OV2300.InventoryID 
			AND OV0306.TransactionID = OV2300.TransactionID 
			AND OV0306.DivisionID = OV2300.DivisionID
LEFT JOIN AT0128 AT01 WITH (NOLOCK) ON AT01.StandardID = OV2300.S01ID AND AT01.StandardTypeID = ''S01''
LEFT JOIN AT0128 AT02 WITH (NOLOCK) ON AT02.StandardID = OV2300.S02ID AND AT02.StandardTypeID = ''S02''
LEFT JOIN AT0128 AT03 WITH (NOLOCK) ON AT03.StandardID = OV2300.S03ID AND AT03.StandardTypeID = ''S03''
LEFT JOIN AT0128 AT04 WITH (NOLOCK) ON AT04.StandardID = OV2300.S04ID AND AT04.StandardTypeID = ''S04''
LEFT JOIN AT0128 AT05 WITH (NOLOCK) ON AT05.StandardID = OV2300.S05ID AND AT05.StandardTypeID = ''S05''
LEFT JOIN AT0128 AT06 WITH (NOLOCK) ON AT06.StandardID = OV2300.S06ID AND AT06.StandardTypeID = ''S06''
LEFT JOIN AT0128 AT07 WITH (NOLOCK) ON AT07.StandardID = OV2300.S07ID AND AT07.StandardTypeID = ''S07''
LEFT JOIN AT0128 AT08 WITH (NOLOCK) ON AT08.StandardID = OV2300.S08ID AND AT08.StandardTypeID = ''S08''
LEFT JOIN AT0128 AT09 WITH (NOLOCK) ON AT09.StandardID = OV2300.S09ID AND AT09.StandardTypeID = ''S09''
LEFT JOIN AT0128 AT10 WITH (NOLOCK) ON AT10.StandardID = OV2300.S10ID AND AT10.StandardTypeID = ''S10''
LEFT JOIN AT0128 AT11 WITH (NOLOCK) ON AT11.StandardID = OV2300.S11ID AND AT11.StandardTypeID = ''S11''
LEFT JOIN AT0128 AT12 WITH (NOLOCK) ON AT12.StandardID = OV2300.S12ID AND AT12.StandardTypeID = ''S12''
LEFT JOIN AT0128 AT13 WITH (NOLOCK) ON AT13.StandardID = OV2300.S13ID AND AT13.StandardTypeID = ''S13''
LEFT JOIN AT0128 AT14 WITH (NOLOCK) ON AT14.StandardID = OV2300.S15ID AND AT14.StandardTypeID = ''S14''
LEFT JOIN AT0128 AT15 WITH (NOLOCK) ON AT15.StandardID = OV2300.S15ID AND AT15.StandardTypeID = ''S15''
LEFT JOIN AT0128 AT16 WITH (NOLOCK) ON AT16.StandardID = OV2300.S16ID AND AT16.StandardTypeID = ''S16''
LEFT JOIN AT0128 AT17 WITH (NOLOCK) ON AT17.StandardID = OV2300.S17ID AND AT17.StandardTypeID = ''S17''
LEFT JOIN AT0128 AT18 WITH (NOLOCK) ON AT18.StandardID = OV2300.S18ID AND AT18.StandardTypeID = ''S18''
LEFT JOIN AT0128 AT19 WITH (NOLOCK) ON AT19.StandardID = OV2300.S19ID AND AT19.StandardTypeID = ''S19''
LEFT JOIN AT0128 AT20 WITH (NOLOCK) ON AT20.StandardID = OV2300.S20ID AND AT20.StandardTypeID = ''S20''
' + @sFROM + '
LEFT JOIN	OV1101 
	ON		OV2300.OrderStatus = OV1101.OrderStatus 
			AND OV2300.DivisionID = OV1101.DivisionID 
			AND OV1101.TypeID = ''SO''
WHERE	OV2300.OrderType = 0 AND OV2300.DivisionID = ''' + @DivisionID + ''' AND ' +   
		'OV2300.InventoryID ' + CASE WHEN @FromInventoryID = '%' then ' like ''%''' 
		else ' BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''' '   end 
	
print(@sSQL)
print(@sSQL1)
IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME = 'OV0301_AP' AND XTYPE ='V') 
	DROP VIEW OV0301_AP
EXEC ('CREATE VIEW OV0301_AP  --tao boi OP0301_AP
		AS '+@sSQL+@sSQL1)




	Set @sSQL =  N'
SELECT A.DeliverDate, B.*, A.ObjectID_OT2003, A.Date FROM (SELECT DivisionID, Date, ObjectID AS ObjectID_OT2003, SOrderID, DeliverDate, 
					 (Case When Date = ''Date01'' then ''Quantity01''
						   When Date = ''Date02'' then ''Quantity02''
						   When Date = ''Date03'' then ''Quantity03''
						   When Date = ''Date04'' then ''Quantity04''
						   When Date = ''Date05'' then ''Quantity05''
						   When Date = ''Date06'' then ''Quantity06''
						   When Date = ''Date07'' then ''Quantity07''
						   When Date = ''Date08'' then ''Quantity08''
						   When Date = ''Date09'' then ''Quantity09''
						   When Date = ''Date10'' then ''Quantity10''
						   When Date = ''Date11'' then ''Quantity11''
						   When Date = ''Date12'' then ''Quantity12''
						   When Date = ''Date13'' then ''Quantity13''
						   When Date = ''Date14'' then ''Quantity14''
						   When Date = ''Date15'' then ''Quantity15''
						   When Date = ''Date16'' then ''Quantity16''
						   When Date = ''Date17'' then ''Quantity17''
						   When Date = ''Date18'' then ''Quantity18''
						   When Date = ''Date19'' then ''Quantity19''
						   When Date = ''Date20'' then ''Quantity20''
						   When Date = ''Date21'' then ''Quantity11''
						   When Date = ''Date22'' then ''Quantity12''
						   When Date = ''Date23'' then ''Quantity13''
						   When Date = ''Date24'' then ''Quantity14''
						   When Date = ''Date25'' then ''Quantity15''
						   When Date = ''Date26'' then ''Quantity16''
						   When Date = ''Date27'' then ''Quantity17''
						   When Date = ''Date28'' then ''Quantity18''
						   When Date = ''Date29'' then ''Quantity19''
						   When Date = ''Date30'' then ''Quantity30'' End) QuantityNum
FROM OT2003
UNPIVOT
(
       DeliverDate
       FOR [Date] IN ([Date01], [Date02], [Date03], [Date04], [Date05], [Date06], [Date07], [Date08], [Date09], [Date10],
					  [Date11], [Date12], [Date13], [Date14], [Date15], [Date16], [Date17], [Date18], [Date19], [Date20],
					  [Date21], [Date22], [Date23], [Date24], [Date25], [Date26], [Date27], [Date28], [Date29], [Date30])
) AS P ) A

INNER JOIN

(SELECT SOrderID, Orders, S2, SName2, InventoryID, InventoryName, S04ID, Quantity, QuantityNum, ObjectID, ObjectName, StandardName01, Ana02IDAP, ExportType, NotesAP, DivisionID, InventoryTypeName, GroupID, GroupName
FROM OV0301_AP
UNPIVOT
(
       Quantity
       FOR [QuantityNum] IN ([Quantity01], [Quantity02], [Quantity03], [Quantity04], [Quantity05], [Quantity06], [Quantity07], [Quantity08], [Quantity09], [Quantity10],
							 [Quantity11], [Quantity12], [Quantity13], [Quantity14], [Quantity15], [Quantity16], [Quantity17], [Quantity18], [Quantity19], [Quantity20],
							 [Quantity21], [Quantity22], [Quantity23], [Quantity24], [Quantity25], [Quantity26], [Quantity27], [Quantity28], [Quantity29], [Quantity30])
) AS Q ) B 
ON A.DivisionID = B.DivisionID AND A.SOrderID = B.SOrderID AND A.QuantityNum = B.QuantityNum
WHERE 
Quantity > 0 
AND ObjectID_OT2003 BETWEEN ''' + @FromObjectID + ''' AND ''' +  @ToObjectID  + '''
AND'
+ CASE WHEN @IsDate = 1 
			THEN ' CONVERT(DATETIME,CONVERT(VARCHAR(10), DeliverDate ,101),101) BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''' '
			ELSE ' CONVERT(DATETIME,CONVERT(VARCHAR(10), DeliverDate ,101),101) BETWEEN ''' + @FromMonthYearText + ''' AND ''' + @ToMonthYearText + ''' ' END



EXEC (@sSQL)
--PRINT (@sSQL)
--PRINT @FromDateText
--PRINT @ToMonthYearText


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
