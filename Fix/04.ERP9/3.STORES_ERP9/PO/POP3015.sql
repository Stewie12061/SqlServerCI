IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP3015]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP3015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo dự trù chi phí
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 24/11/2020 by Trọng Kiên
-- <Example>
---- 


CREATE PROCEDURE [dbo].[POP3015] 
				@DivisionID as nvarchar(50),
				@FromMonth as int,
				@ToMonth as int,
				@FromYear as int,
				@ToYear as int,
				@FromDate as datetime,
				@ToDate as datetime,
				@FromObjectID as nvarchar(50),
				@ToObjectID as nvarchar(50),				
				@IsDate as tinyint,
				@IsGroup as tinyint,
				@GroupID nvarchar(50), -- GroupID: OB, CI1, CI2, CI3, I01, I02, I03, I04, I05		
				@CurrencyID as nvarchar(50),
				@Ana01ID as nvarchar(50) ='',
				@ListInventoryID as nvarchar(max) ='',
				@ObjectID as nvarchar(50) ='',
				@ListObjectID as nvarchar(max) =''
 AS
DECLARE 	@sSQL nvarchar(MAX),
			@sSQL1 nvarchar(MAX),
			@sSQL2 nvarchar(MAX),
			@GroupField nvarchar(20),
			@sFROM nvarchar(MAX),
			@sSELECT nvarchar(MAX), 
    @FromMonthYearText NVARCHAR(20), 
    @ToMonthYearText NVARCHAR(20), 
    @FromDateText NVARCHAR(20), 
    @ToDateText NVARCHAR(20),
	@sWhere nvarchar(max) =''
    
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'


Select @sFROM = '',  @sSELECT = ''
IF @IsGroup  = 1 
	BEGIN
	Exec AP4700  	@GroupID,	@GroupField OUTPUT
	Select @sFROM = @sFROM + ' left join AV6666 V1 on V1.SelectionType = ''' + @GroupID + ''' and V1.DivisionID = OV2400.DivisionID and V1.SelectionID = OV2400.' + @GroupField,
		@sSELECT = @sSELECT + ', 
		V1.SelectionID as GroupID, V1.SelectionName as GroupName'
				
	END
ELSE
	Set @sSELECT = @sSELECT +  ', 
		'''' as GroupID, '''' as GroupName'	

IF dbo.GetCustomizeIndex() = 114  AND IsNULL(@Ana01ID,'') <> ''
BEGIN
	SET  @sFROM = @sFROM + ' Left join OOT2100 WITH(NOLOCK) on OV2400.Ana01ID = OOT2100.ProjectID'
	SET  @sWhere = @sWhere + '  and OOT2100.StatusID not in (''TTDA0003'', ''TTDA0010'',''TTDA0004'')'
END

Set @sSQL =  '
Select  OV2400.DivisionID,
		OV2400.OrderID as POrderID,  
		OV2400.VoucherNo,           
		OV2400.VoucherDate as OrderDate,
		OV2400.CurrencyID,
		OV2400.ObjectID,
		OV2400.ObjectName,
		OV2400.Orders,
		OV2400.OrderStatus,
		OV2400.Ana01ID, OV2400.Ana02ID, OV2400.Ana03ID, OV2400.Ana04ID, OV2400.Ana05ID,
		OV2400.Ana06ID, OV2400.Ana07ID, OV2400.Ana08ID, OV2400.Ana09ID, OV2400.Ana10ID,
		OV2400.AnaName01,OV2400.AnaName02,OV2400.AnaName03,OV2400.AnaName04,OV2400.AnaName05,
		OV2400.AnaName06,OV2400.AnaName07,OV2400.AnaName08,OV2400.AnaName09,OV2400.AnaName10,
		OV2400.Parameter01,OV2400.Parameter02,OV2400.Parameter03,OV2400.Parameter04,OV2400.Parameter05,
		OV2400.Parameter06,OV2400.Parameter07,OV2400.Parameter08,OV2400.Parameter09,OV2400.Parameter10, OV2400.Notes, OV2400.Notes01, OV2400.Notes02,OV2400.Notes03,
		OV2400.Notes04, OV2400.Notes05, OV2400.Notes06,OV2400.Notes07, OV2400.Notes08,	OV2400.Notes09,
		OV2400.InventoryID, 
		OV2400.InventoryName, 
		OV2400.UnitName,
		OV2400.Specification,
		OV2400.InventoryTypeID,
		OV2400.OrderQuantity,
		OV2400.PurchasePrice,
		OV2400.VATPercent,
		OV2400.VATConvertedAmount,
		OV2400.DiscountPercent,
		isnull(OV2400.PurchasePrice, 0)* isnull(OV2400.ExchangeRate, 0) as ConvertedPrice,	
		OV2400.TotalOriginalAmount as TOriginalAmount,
		OV2400.TotalConvertedAmount as TConvertedAmount,
		ISNULL(OV2400.S01ID,'''') AS S01ID, ISNULL(OV2400.S02ID,'''') AS S02ID, ISNULL(OV2400.S03ID,'''') AS S03ID, ISNULL(OV2400.S04ID,'''') AS S04ID, 
		ISNULL(OV2400.S05ID,'''') AS S05ID, ISNULL(OV2400.S06ID,'''') AS S06ID, ISNULL(OV2400.S07ID,'''') AS S07ID, ISNULL(OV2400.S08ID,'''') AS S08ID, 
		ISNULL(OV2400.S09ID,'''') AS S09ID, ISNULL(OV2400.S10ID,'''') AS S10ID, ISNULL(OV2400.S11ID,'''') AS S11ID, ISNULL(OV2400.S12ID,'''') AS S12ID, 
		ISNULL(OV2400.S13ID,'''') AS S13ID, ISNULL(OV2400.S14ID,'''') AS S14ID, ISNULL(OV2400.S15ID,'''') AS S15ID, ISNULL(OV2400.S16ID,'''') AS S16ID, 
		ISNULL(OV2400.S17ID,'''') AS S17ID, ISNULL(OV2400.S18ID,'''') AS S18ID, ISNULL(OV2400.S19ID,'''') AS S19ID, ISNULL(OV2400.S20ID,'''') AS S20ID,
		A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
		A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
		A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
		A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
		A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20 ' + 
		@sSELECT  + '
		, OT3101.ROrderID, OV2400.PriceListID, OV2400.ConfirmUserID,OV2400.ConfirmDate ,OV2400.ConfirmUserName, OV2400.RequestID,OT31.OrderDate as ROrderDate
		, OV2400.TDescription
		, OT02.OAna01ID, OT02.OAna02ID, OT02.OAna03ID, OT02.OAna04ID, OT02.OAna05ID
        , OT02.Varchar01, OT02.Varchar02, OT02.Varchar03, OT02.Varchar04, OT02.Varchar05
        , OT02.Varchar06, OT02.Varchar07, OT02.Varchar08, OT02.Varchar09, OT02.Varchar10
        , OT02.Varchar11, OT02.Varchar12, OT02.Varchar13, OT02.Varchar14, OT02.Varchar15
        , OT02.Varchar16, OT02.Varchar17, OT02.Varchar18, OT02.Varchar19, OT02.Varchar20
From OV2400 '
SET @sSQL1 = '
LEFT JOIN AT0128 A01 WITH (NOLOCK) ON A01.DivisionID = OV2400.DivisionID AND OV2400.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
LEFT JOIN AT0128 A02 WITH (NOLOCK) ON A02.DivisionID = OV2400.DivisionID AND OV2400.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
LEFT JOIN AT0128 A03 WITH (NOLOCK) ON A03.DivisionID = OV2400.DivisionID AND OV2400.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
LEFT JOIN AT0128 A04 WITH (NOLOCK) ON A04.DivisionID = OV2400.DivisionID AND OV2400.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
LEFT JOIN AT0128 A05 WITH (NOLOCK) ON A05.DivisionID = OV2400.DivisionID AND OV2400.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
LEFT JOIN AT0128 A06 WITH (NOLOCK) ON A06.DivisionID = OV2400.DivisionID AND OV2400.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
LEFT JOIN AT0128 A07 WITH (NOLOCK) ON A07.DivisionID = OV2400.DivisionID AND OV2400.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
LEFT JOIN AT0128 A08 WITH (NOLOCK) ON A08.DivisionID = OV2400.DivisionID AND OV2400.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
LEFT JOIN AT0128 A09 WITH (NOLOCK) ON A09.DivisionID = OV2400.DivisionID AND OV2400.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
LEFT JOIN AT0128 A10 WITH (NOLOCK) ON A10.DivisionID = OV2400.DivisionID AND OV2400.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
LEFT JOIN AT0128 A11 WITH (NOLOCK) ON A11.DivisionID = OV2400.DivisionID AND OV2400.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
LEFT JOIN AT0128 A12 WITH (NOLOCK) ON A12.DivisionID = OV2400.DivisionID AND OV2400.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
LEFT JOIN AT0128 A13 WITH (NOLOCK) ON A13.DivisionID = OV2400.DivisionID AND OV2400.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
LEFT JOIN AT0128 A14 WITH (NOLOCK) ON A14.DivisionID = OV2400.DivisionID AND OV2400.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
LEFT JOIN AT0128 A15 WITH (NOLOCK) ON A15.DivisionID = OV2400.DivisionID AND OV2400.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
LEFT JOIN AT0128 A16 WITH (NOLOCK) ON A16.DivisionID = OV2400.DivisionID AND OV2400.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
LEFT JOIN AT0128 A17 WITH (NOLOCK) ON A17.DivisionID = OV2400.DivisionID AND OV2400.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
LEFT JOIN AT0128 A18 WITH (NOLOCK) ON A18.DivisionID = OV2400.DivisionID AND OV2400.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
LEFT JOIN AT0128 A19 WITH (NOLOCK) ON A19.DivisionID = OV2400.DivisionID AND OV2400.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
LEFT JOIN AT0128 A20 WITH (NOLOCK) ON A20.DivisionID = OV2400.DivisionID AND OV2400.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
LEFT JOIN OT3102 WITH (NOLOCK) ON OT3102.TransactionID = OV2400.RefTransactionID
LEFT JOIN OT3101 WITH (NOLOCK) ON OT3101.ROrderID = OT3102.ROrderID
LEFT JOIN OT3101 OT31 WITH(NOLOCK) ON OT31.DivisionID = OV2400.DivisionID AND OT31.ROrderID = OV2400.RequestID'
SET @sSQL2 = '
LEFT JOIN (SELECT DISTINCT
           ISNULL(OT01.Ana01ID, '''') AS OAna01ID, ISNULL(OT01.Ana02ID, '''') AS OAna02ID, ISNULL(OT01.Ana03ID, '''') AS OAna03ID
		   , ISNULL(OT01.Ana04ID, '''') AS OAna04ID, ISNULL(OT01.Ana05ID, '''') AS OAna05ID
           , ISNULL(OT01.Varchar01, '''') AS Varchar01, ISNULL(OT01.Varchar02, '''') AS Varchar02, ISNULL(OT01.Varchar03, '''') AS Varchar03
		   , ISNULL(OT01.Varchar04, '''') AS Varchar04, ISNULL(OT01.Varchar05, '''') AS Varchar05, ISNULL(OT01.Varchar06, '''') AS Varchar06
           , ISNULL(OT01.Varchar07, '''') AS Varchar07, ISNULL(OT01.Varchar08, '''') AS Varchar08, ISNULL(OT01.Varchar09, '''') AS Varchar09
		   , ISNULL(OT01.Varchar10, '''') AS Varchar10, ISNULL(OT01.Varchar11, '''') AS Varchar11, ISNULL(OT01.Varchar12, '''') AS Varchar12
           , ISNULL(OT01.Varchar13, '''') AS Varchar13, ISNULL(OT01.Varchar14, '''') AS Varchar14, ISNULL(OT01.Varchar15, '''') AS Varchar15
		   , ISNULL(OT01.Varchar16, '''') AS Varchar16, ISNULL(OT01.Varchar17, '''') AS Varchar17, ISNULL(OT01.Varchar18, '''') AS Varchar18
           , ISNULL(OT01.Varchar19, '''') AS Varchar19, ISNULL(OT01.Varchar20, '''') AS Varchar20, OT02.Ana01ID
           FROM OT2001 OT01
		   LEFT JOIN OT2002 OT02 WITH (NOLOCK) ON OT01.SOrderID= OT02.SOrderID) OT02 ON OT02.Ana01ID = OV2400.Ana01ID
 
' + @sFROM + '
Where OV2400.DivisionID = ''' + @DivisionID + '''' +
		 case when IsNULL(@FromObjectID,'') <> '' OR IsNULL(@ToObjectID,'') <> '' then ' AND OV2400.ObjectID between N''' + @FromObjectID + ''' and N''' + @ToObjectID + '''' else '' end + 
		 case when @IsDate = 1 then ' AND CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101),101) between ''' +  @FromDateText + ''' and ''' +  @ToDateText  + ''''
		 else ' AND OV2400.TranMonth + OV2400.TranYear*100 between ' +  @FromMonthYearText +  ' and ' +  @ToMonthYearText  end  + 
		 case when IsNULL(@CurrencyID,'') <> '' then ' AND OV2400.CurrencyID like ''' + @CurrencyID + '''' else '' end +
	     case when IsNULL(@Ana01ID,'') <> '' AND IsNULL(@Ana01ID,'') <> '%' then ' AND OV2400.Ana01ID =''' + @Ana01ID + '''' else '' end +
		 case when IsNULL(@ListInventoryID,'') <> '' then ' AND OV2400.InventoryID IN (''' + @ListInventoryID + ''')' else '' end +
		 case when IsNULL(@ObjectID,'') <> '' then ' AND OV2400.ObjectID =''' + @ObjectID + '''' else '' end +
		 case when IsNULL(@ListObjectID,'') <> '' then ' AND OV2400.ObjectID IN (''' + @ListObjectID + ''')' else '' end 
		 + @sWhere

PRINT(@sSQL)
PRINT(@sSQL1)

If exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'OV3021')
	Drop view OV3021
EXEC('Create view OV3021---tao boi POP3015
		as ' + @sSQL + @sSQL1 + @sSQL2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
