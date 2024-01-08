IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30018]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30018]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






---Created by : Trọng Kiên, date: 01/12/2020
---Modified by : Hoài Bảo, date: 10/10/2022 - Cập nhật param truyền vào theo dạng danh sách
---Purpose: In báo cáo tổng hợp tình hình giao hàng
---- Modified by Xuân Nguyên on 02/03/2023: Bổ sung EmployeeID, Finish, WareHouseID
---LƯU Ý: KHI CHỈNH SỬA PHẦN NÀY TRÊN ERP9 THÌ PHẢI SỬA STORED OP0301
---- EXEC SOP30018 'mk',0,5,5,2016,2016,'2016/05/21','2016/05/21','','',1,'CI1'

CREATE PROCEDURE [dbo].[SOP30018]  
		@DivisionID NVARCHAR(50),
		@DivisionIDList NVARCHAR(MAX),
		@IsDate TINYINT,
		@PeriodIDList NVARCHAR(2000),
		@FromDate DATETIME,
		@ToDate DATETIME,				
		@InventoryID NVARCHAR(MAX),
		@IsGroup AS TINYINT = 0,
		@GroupID NVARCHAR(50) -- GroupID: OB, CI1, CI2, CI3, I01, I02, I03, I04, I05
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX) = '',
		@sSQL2 NVARCHAR(MAX) = '',
		@GroupField NVARCHAR(50),
		@sFROM NVARCHAR(MAX),
		@sSELECT NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX)= '',
		@sWhere2 NVARCHAR(MAX)= '',
		@sWhere3 NVARCHAR(MAX)= '',
		@sWhere4 NVARCHAR(MAX)= '',
		@sWhere5 NVARCHAR(MAX)= '',
		@CustomerName AS INT

	----Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	--IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
	--	SET @sWhere = @sWhere + ' AND Isnull(OV2300.InventoryID, '''') > = N'''+@FromInventoryID +''''
	--ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
	--	SET @sWhere = @sWhere + ' AND Isnull(OV2300.InventoryID, '''') < = N'''+@ToInventoryID +''''
	--ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
	--	SET @sWhere = @sWhere + ' AND Isnull(OV2300.InventoryID, '''') Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''

SELECT @CustomerName = CustomerName FROM CustomerIndex

IF @CustomerName = 66
BEGIN
	EXEC SOP30018_DV @DivisionID,@DivisionIDList,@IsDate,@PeriodIDList,@FromDate,@ToDate,@InventoryID,@IsGroup,@GroupID
END
ELSE
BEGIN
	SELECT @sFROM = '',  @sSELECT = ''


--Search theo điều điện thời gian
IF @IsDate = 1	
BEGIN
	SET @sWhere = @sWhere + '  CONVERT(VARCHAR,OT2001.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	SET @sWhere2 = @sWhere2 + ' CONVERT(VARCHAR,OT200101.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	SET @sWhere3 = @sWhere3 + ' CONVERT(VARCHAR,ExportVoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	SET @sWhere4 = @sWhere4 + ' CONVERT(VARCHAR,SaleOrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	SET @sWhere5 = @sWhere5 + ' CONVERT(VARCHAR,OV2300.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''

END
ELSE
BEGIN
	SET @sWhere = @sWhere + ' (CASE WHEN OT2001.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(OT2001.TranMonth))) + ''/''
									+ LTRIM(RTRIM(STR(OT2001.TranYear))) ELSE RTRIM(LTRIM(STR(OT2001.TranMonth))) + ''/''
									+ lTRIM(RTRIM(STR(OT2001.TranYear))) END) IN ('''+@PeriodIDList+''')'
	SET @sWhere2 = @sWhere2 + ' (CASE WHEN OT200101.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(OT200101.TranMonth))) + ''/''
									+ LTRIM(RTRIM(STR(OT200101.TranYear))) ELSE RTRIM(LTRIM(STR(OT200101.TranMonth))) + ''/''
									+ LTRIM(RTRIM(STR(OT200101.TranYear))) END) IN ('''+@PeriodIDList+''')'
	SET @sWhere3 = @sWhere3 + ' (CASE WHEN ExportTranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(ExportTranMonth))) + ''/''
									+ LTRIM(RTRIM(STR(ExportTranYear))) ELSE RTRIM(LTRIM(STR(ExportTranYear))) + ''/''
									+ LTRIM(RTRIM(STR(ExportTranYear))) END) IN ('''+@PeriodIDList+''')'
	SET @sWhere4 = @sWhere4 + ' (CASE WHEN SaleTranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(SaleTranMonth))) + ''/''
									+ LTRIM(RTRIM(STR(SaleTranYear))) ELSE RTRIM(LTRIM(STR(SaleTranYear))) + ''/''
									+ LTRIM(RTRIM(STR(SaleTranYear))) END) IN ('''+@PeriodIDList+''')'
	SET @sWhere5 = @sWhere5 + ' (CASE WHEN OV2300.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(OV2300.TranMonth))) + ''/''
									+ LTRIM(RTRIM(STR(OV2300.TranYear))) ELSE RTRIM(LTRIM(STR(OV2300.TranYear))) + ''/''
									+ LTRIM(RTRIM(STR(OV2300.TranYear))) END) IN ('''+@PeriodIDList+''')'
END
	
----- Do đặc thù quy trình của khách hàng nên ko thể lưu vết như cũ mà tách ra ở AT3266_AG
IF @CustomerName = 57 
BEGIN
SET @sSQL = N'
	SELECT DISTINCT 
			AT3206_AG.DivisionID, 
			AT3206_AG.OrderID, 
			OT2002.TransactionID, 
			OT2002.InventoryID,
			OT2002.Parameter01, OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04, OT2002.Parameter05,
			SUM(ActualQuantity) AS ActualQuantity, 
			MAX(AT2006.VoucherDate) AS ActualDate, 
			SUM(CASE WHEN ' 
				+ @sWhere
				+ 'THEN AT3206_AG.ActualQuantity ELSE 0 END) AS ActualQuantity0,
			AT2006.VoucherDate AS ExportVoucherDate,
			AT2006.TranMonth AS ExportTranMonth,
			AT2006.TranYear AS ExportTranYear,
			OT2001.OrderDate AS SaleOrderDate,
			OT2001.TranMonth AS SaleTranMonth,
			OT2001.TranYear AS SaleTranYear
	FROM AT3206_AG WITH (NOLOCK) 
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT3206_AG.DivisionID AND AT3206_AG.VoucherID = AT2006.VoucherID AND AT2006.KindVoucherID IN (2, 4, 3)
	INNER JOIN OT2002 WITH (NOLOCK) ON OT2002.DivisionID = AT3206_AG.DivisionID AND OT2002.TransactionID = AT3206_AG.OTransactionID
	INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = AT3206_AG.DivisionID AND OT2001.SOrderID = OT2002.SOrderID AND OT2001.OrderType = 0 AND OT2001.OrderStatus NOT IN (9) 
	WHERE AT3206_AG.DivisionID IN (''' + CASE WHEN ISNULL(@DivisionIDList, '') != '' THEN @DivisionIDList ELSE @DivisionID END + ''')
		AND ISNULL(AT3206_AG.ActualQuantity,0) <> 0	'
	----Modified on 14/11/2011
	+ ' AND '
	-- + CASE WHEN @IsDate = 1 
	--			THEN 'CONVERT(DATETIME,CONVERT(VARCHAR(10),AT2006.VoucherDate ,101),101)< ''' + @ToDateText + ''' '
	--			ELSE 'AT2006.TranMonth + AT2006.TranYear * 100 <= ' + @ToMonthYearText END 
	--+ ' AND ' 
	+ @sWhere + '
	GROUP BY AT3206_AG.DivisionID, AT3206_AG.OrderID, OT2002.InventoryID, 
			OT2002.Parameter01, OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04, OT2002.Parameter05,
			OT2002.TransactionID, 
			AT2006.VoucherDate, AT2006.TranMonth, AT2006.TranYear,
			OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear
	'	
END ---------- ANGEL
ELSE
BEGIN 
	SET @sSQL = N'
	SELECT DivisionID, 
			OrderID, 
			TransactionID, 
			InventoryID,
			Parameter01, Parameter02, Parameter03, Parameter04, Parameter05,
			SUM(ActualQuantity) AS ActualQuantity, 
			MAX(ActualDate) as ActualDate, 
			SUM(ActualQuantity0) AS ActualQuantity0,
			SaleOrderDate,
			SaleTranMonth,
			SaleTranYear,
			UnitIDWarehouse,
			EmployeeID, Finish, WareHouseID
	FROM
	(
	SELECT DISTINCT 
			AT2007.DivisionID, 
			AT2007.OrderID, 
			OT2002.TransactionID, 
			AT2007.InventoryID,
			AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
			SUM(ActualQuantity) AS ActualQuantity, 
			AT2007.UnitID AS UnitIDWarehouse,
			MAX(AT2006.VoucherDate) AS ActualDate, 
			SUM(CASE WHEN ' 
				+ @sWhere
				+ 'THEN AT2007.ActualQuantity ELSE 0 END) AS ActualQuantity0,
			AT2006.VoucherDate AS ExportVoucherDate,
			AT2006.TranMonth AS ExportTranMonth,
			AT2006.TranYear AS ExportTranYear,
			OT2001.OrderDate AS SaleOrderDate,
			OT2001.TranMonth AS SaleTranMonth,
			OT2001.TranYear AS SaleTranYear,
			OT2001.EmployeeID,OT2002.Finish ,OT2002.WareHouseID 
	FROM AT2007 WITH (NOLOCK) 
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2007.VoucherID = AT2006.VoucherID AND AT2006.KindVoucherID IN (2, 4, 3) 
	INNER JOIN OT2002 WITH (NOLOCK) ON OT2002.DivisionID = AT2007.DivisionID AND OT2002.TransactionID = AT2007.OTransactionID
	INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = AT2007.DivisionID AND OT2001.SOrderID = OT2002.SOrderID AND OT2001.OrderType = 0 AND OT2001.OrderStatus NOT IN (9) 
	GROUP BY AT2007.DivisionID, AT2007.OrderID, AT2007.InventoryID, 
			AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, AT2007.UnitID, OT2002.TransactionID, 
			AT2006.VoucherDate, AT2006.TranMonth, AT2006.TranYear,
			OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear,OT2001.EmployeeID,OT2002.Finish ,OT2002.WareHouseID
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
			AT2007.UnitID AS UnitIDWarehouse,
			MAX(AT2006.VoucherDate) AS ActualDate, 
			SUM(CASE WHEN ' 
				+ @sWhere2
				+ ' THEN AT2007.ActualQuantity ELSE 0 END) AS ActualQuantity0,
			AT2006.VoucherDate AS ExportVoucherDate,
			AT2006.TranMonth AS ExportTranMonth,
			AT2006.TranYear AS ExportTranYear,
			OT200102.OrderDate AS SaleOrderDate,
			OT200102.TranMonth AS SaleTranMonth,
			OT200102.TranYear AS SaleTranYear,
			OT200102.EmployeeID,OT200202.Finish ,OT200202.WareHouseID 
	FROM AT2007  WITH (NOLOCK)
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID AND AT2006.KindVoucherID IN (2, 4, 3) 
	INNER JOIN OT2002 OT200201 WITH (NOLOCK) ON OT200201.DivisionID = AT2007.DivisionID AND OT200201.TransactionID = AT2007.OTransactionID 
	INNER JOIN OT2001 OT200101 WITH (NOLOCK) ON OT200101.DivisionID = AT2007.DivisionID AND OT200101.SOrderID = OT200201.SOrderID AND OT200101.OrderType = 1 AND OT200101.OrderStatus NOT IN (9) 
	INNER JOIN OT2001 OT200102 WITH (NOLOCK) ON OT200102.DivisionID = AT2007.DivisionID AND OT200102.SOrderID = OT200201.RefSOrderID AND OT200102.OrderType = 0 AND OT200102.OrderStatus NOT IN (9) 
	INNER JOIN OT2002 OT200202 WITH (NOLOCK) ON OT200202.DivisionID = AT2007.DivisionID AND OT200202.SOrderID = OT200102.SOrderID AND OT200202.InventoryID = OT200201.InventoryID
	GROUP BY AT2007.DivisionID, OT200102.SOrderID, AT2007.InventoryID,
			AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, AT2007.UnitID, OT200202.TransactionID, 
			AT2006.VoucherDate, AT2006.TranMonth, AT2006.TranYear,
			OT200102.OrderDate, OT200102.TranMonth, OT200102.TranYear,OT200102.EmployeeID,OT200202.Finish ,OT200202.WareHouseID 
	) TEMP
	WHERE DivisionID IN (''' + CASE WHEN ISNULL(@DivisionIDList, '') != '' THEN @DivisionIDList ELSE @DivisionID END + ''')'
	----Modified on 14/11/2011
	+ ' AND ' + @sWhere3+' AND '+@sWhere4+''
	+ '
	GROUP BY DivisionID, 
			OrderID, 
			TransactionID, 
			InventoryID,
			Parameter01, Parameter02, Parameter03, Parameter04, Parameter05,
			SaleOrderDate,
			SaleTranMonth,
			SaleTranYear,
			UnitIDWarehouse,EmployeeID,Finish ,WareHouseID 
	'
END 
	--PRINT(@sSQL)
	IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE = 'V' AND NAME = 'OV0306')
		DROP VIEW OV0306
	
	PRINT @sSQL
	PRINT @sSQL2
	EXEC('CREATE VIEW OV0306 ---tao boi SOP30018
			AS ' + @sSQL+@sSQL2)
 
	IF @IsGroup  = 1 
		BEGIN
		EXEC AP4700  	@GroupID,	@GroupField OUTPUT
		SET @sFROM = @sFROM + '
	LEFT JOIN AV6666 V1 ON V1.SelectionType = ''' + @GroupID + ''' AND CAST(V1.SelectionID AS NVARCHAR(50)) = CAST(OV2300.' + @GroupField + ' AS NVARCHAR(50))'
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
			OV2300.TransactionID,
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
			OV2300.ConversionUnitName,
			AT1304.UnitName AS WarehouseUnitName,
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
			OV2300.VDescription, 
			CASE WHEN (OV2300.FOrderQuantity - ISNULL(OV0306.ActualQuantity,0) + ISNULL(OV2300.AdjustQuantity, 0)) = 0 THEN 0
			WHEN ISNULL(OV0306.ActualQuantity,0) = 0 then 1
			WHEN (ISNULL(OV0306.ActualQuantity,0) > 0 AND 
					(OV2300.FOrderQuantity - ISNULL(OV0306.ActualQuantity,0) + ISNULL(OV2300.AdjustQuantity, 0)) > 0) THEN 2
			end AS Status, '''' AS StatusInword,
		
			---OV0306.RefNo01, OV0306.RefNo02
			OV2300.Parameter01 as OParameter01, OV2300.Parameter02 as OParameter02, OV2300.Parameter03 as OParameter03, OV2300.Parameter04 as OParameter04, OV2300.Parameter05 as OParameter05,
			OV0306.Parameter01 as WParameter01, OV0306.Parameter02 as WParameter02, OV0306.Parameter03 as WParameter03, OV0306.Parameter04 as WParameter04, OV0306.Parameter05 as WParameter05
			, OV2300.DeliveryAddress, OV2300.ObjectAddress, OV2300.SalesManID, OV2300.SalesManName,
			OV2300.S01ID, OV2300.S02ID, OV2300.S03ID, OV2300.S04ID, OV2300.S05ID, OV2300.S06ID, OV2300.S07ID, OV2300.S08ID, OV2300.S09ID, OV2300.S10ID,
			OV2300.S11ID, OV2300.S12ID, OV2300.S13ID, OV2300.S14ID, OV2300.S15ID, OV2300.S16ID, OV2300.S17ID, OV2300.S18ID, OV2300.S19ID, OV2300.S20ID,
			OV2300.S01Name, OV2300.S02Name, OV2300.S03Name, OV2300.S04Name, OV2300.S05Name,
			OV2300.S06Name, OV2300.S07Name, OV2300.S08Name, OV2300.S09Name, OV2300.S10Name,
			OV2300.S11Name, OV2300.S12Name, OV2300.S13Name, OV2300.S14Name, OV2300.S15Name,
			OV2300.S16Name, OV2300.S17Name, OV2300.S18Name, OV2300.S19Name, OV2300.S20Name, 
			OV2300.SalePrice01, OV2300.SalePrice02, OV2300.SalePrice03, OV2300.SalePrice04, OV2300.SalePrice05,		
			OV2300.nvarchar01, OV2300.nvarchar02, OV2300.nvarchar03, OV2300.nvarchar04, OV2300.nvarchar05,
			OV2300.nvarchar06, OV2300.nvarchar07, OV2300.nvarchar08, OV2300.nvarchar09, OV2300.nvarchar10,
			OV2300.I01ID, OV2300.I02ID, OV2300.I03ID, OV2300.I04ID, OV2300.I05ID, OV2300.I06ID, OV2300.I07ID, OV2300.I08ID, OV2300.I09ID, OV2300.I10ID,
			OV2300.I01Name, OV2300.I02Name, OV2300.I03Name, OV2300.I04Name, OV2300.I05Name, OV2300.I06Name, OV2300.I07Name, OV2300.I08Name, OV2300.I09Name, OV2300.I10Name,OV0306.EmployeeID, ISNULL(OV0306.Finish,0) as Finish, OV0306.WareHouseID '
		
	Set @sSQL1 =  @sSELECT  + N'
	FROM		OV2300 
	LEFT JOIN	OV0306  
		ON		OV0306.OrderID = OV2300.OrderID 
				AND OV0306.InventoryID = OV2300.InventoryID 
				AND OV0306.TransactionID = OV2300.TransactionID 
				AND OV0306.DivisionID = OV2300.DivisionID
	LEFT JOIN	AT1304 ON OV0306.UnitIDWarehouse = AT1304.UnitID
	' + @sFROM + '
	LEFT JOIN	OV1101
		ON		OV2300.OrderStatus = OV1101.OrderStatus 
				AND OV2300.DivisionID = OV1101.DivisionID 
				AND OV1101.TypeID = ''SO''
	WHERE	OV2300.OrderType = 0 AND OV2300.DivisionID IN (''' + CASE WHEN ISNULL(@DivisionIDList, '') != '' THEN @DivisionIDList ELSE @DivisionID END + ''') AND ' +
			@sWHERE4 +  
			  ' AND  OV2300.InventoryID ' + CASE WHEN ISNULL(@InventoryID,'%') = '%' THEN ' LIKE ''%'''
			ELSE ' IN (''' + @InventoryID + ''')' END
			

	IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME = 'OV0301' AND XTYPE ='V') 
		DROP VIEW OV0301

	EXEC ('CREATE VIEW OV0301  --tao boi SOP30018
			AS '+@sSQL+@sSQL1)

    SELECT ROW_NUMBER() OVER (ORDER BY OV0301.VoucherNo) AS RowNum,* FROM OV0301
	
END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
