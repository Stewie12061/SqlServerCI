IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0301]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0301]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---Created by : Vo Thanh Huong, date: 02/01/2005
---purpose: In bao cao Tong hop tinh hinh giao hang
---Last Update : Nguyen thi thuy Tuyen, date 27/08/2008,
-- Last Edit Thuy Tuyen, them ma phan tich OP , date:12/11/2009
---Edit by B.Anh, date 05/12/2009	Lay them truong OrderStatus, OrderStatusName
--- Edit Tuyen, date 11/02/2009 xu ly khi Finish = 1
--Edit by, Tuyen, date 22/03/2010- bosung theo themphan chuyen kho
--Edit Tuyen, bo sung them cac ma phan tich ngiep vu , date 10/05/2010
---- Modified on 14/11/2011 by Le Thi Thu Hien : Chinh sua 
---- Modified on 20/11/2011 by Le Thi Thu Hien : Chinh sua RemainQuantity
---- Modified on 31/01/2012 by Le Thi Thu Hien : Sua dieu kien CONVERT theo ngay
/********************************************
'* Edited by: [GS] [Mỹ Tuyền] [16/12/2010]
'********************************************/
---- Modified on 06/09/2012 by Bao Anh : Bo sung tham so Parameter01 -> 05
---- Modified on 14/05/2015 by Bao Anh : Trả ra 1 dòng dữ liệu nếu đơn hàng được giao trong nhiều ngày
---- Modified on 31/05/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified on 16/06/2016 by Bảo Anh : Bổ sung store customize cho Đồng Việt
---- Modified by Tiểu Mai on 15/07/2016: Sửa lại cách lấy dữ liệu cho Angel (CustomizeIndex = 57)
---- Modified by Bảo Thy on 12/09/2017: Bổ sung OV2300.DeliveryAddress, OV2300.ObjectAddress, OV2300.SalesManID, OV2300.SalesManName
---- Modified on 05/10/2017 by Hải Long: Bố sung từ tên 20 quy cách
---- Modified by Khả Vi on 07/11/2017: Bồ sung trường giá bán: SalePrice01 --> SalePrice05
---- Modified by bảo Anh on 19/12/2017: Bổ sung cột Tham số 1 của Đơn hàng bán nvarchar01 -> nvarchar10
---- Modified by Bảo Anh on 06/03/2018: Bổ sung I01ID -> I10ID, I01Name -> I10Name
---- Modified by Đức Thông on 26/10/2020: + Bổ sung trường ConversionUnitName (ĐVT trong OT2002)
----									  + Bổ sung trường WarehouseUnitName (ĐVT trong AT2007)
---- Modified by Xuân Nguyên on 02/03/2023: Bổ sung EmployeeID, Finish, WareHouseID
---- Modified by Thành Sang on 30/03/2023: Sửa cách load UnitID, WareHouseID
---- Modified by Xuân Nguyên on 18/05/2023: Điều chỉnh lấy EmployeeID từ OV2300 không lấy từ OV0306
---- LƯU Ý: KHI CHỈNH SỬA STORED NÀY CẦN CHỈNH SỬA LUÔN STORED SOP30018 TRÊN ERP9
---- exec op0301 'mk',0,5,5,2016,2016,'2016/05/21','2016/05/21','','',1,'CI1'

CREATE PROCEDURE [dbo].[OP0301]  
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
				@IsGroup AS tinyint,
				@GroupID nvarchar(50) -- GroupID: OB, CI1, CI2, CI3, I01, I02, I03, I04, I05	
AS
DECLARE @sSQL nvarchar(max),
		@sSQL1 nvarchar(max) = '',
		@sSQL2 nvarchar(max) = '',
		@GroupField nvarchar(50),
		@sFROM nvarchar(max),
		@sSELECT nvarchar(max),
		@sWHERE nvarchar(max), 
		@FromMonthYearText NVARCHAR(20), 
		@ToMonthYearText NVARCHAR(20), 
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20),
		@CustomerName as int
    
SELECT @CustomerName = CustomerName FROM CustomerIndex

IF @CustomerName = 66
BEGIN
	EXEC OP0301_DV @DivisionID,@IsDate,@FromMonth,@ToMonth,@FromYear,@ToYear,@FromDate,@ToDate,@FromInventoryID,@ToInventoryID,@IsGroup,@GroupID
END

ELSE
BEGIN
	SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
	SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	Select @sFROM = '',  @sSELECT = ''
	
----- Do đặc thù quy trình của khách hàng nên ko thể lưu vết như cũ mà tách ra ở AT3266_AG
IF @CustomerName = 57 
BEGIN
Set @sSQL = N'
	SELECT DISTINCT 
			AT3206_AG.DivisionID, 
			AT3206_AG.OrderID, 
			OT2002.TransactionID, 
			OT2002.InventoryID,
			OT2002.Parameter01, OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04, OT2002.Parameter05,
			SUM(ActualQuantity) AS ActualQuantity, 
			MAX(AT2006.VoucherDate) AS ActualDate, 
			SUM(CASE WHEN ' 
				+ CASE WHEN @IsDate = 1 
					THEN ' CONVERT(DATETIME,CONVERT(VARCHAR(10),OT2001.OrderDate,101),101) < ''' + @FromDateText + ''''
					ELSE ' OT2001.TranMonth + OT2001.TranYear * 100 <= ' + @FromMonthYearText END
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
	WHERE AT3206_AG.DivisionID = ''' + @DivisionID +  '''
		AND Isnull(AT3206_AG.ActualQuantity,0) <> 0	'
	----Modified on 14/11/2011
	+ ' AND '
	-- + CASE WHEN @IsDate = 1 
	--			THEN 'CONVERT(DATETIME,CONVERT(VARCHAR(10),AT2006.VoucherDate ,101),101)< ''' + @ToDateText + ''' '
	--			ELSE 'AT2006.TranMonth + AT2006.TranYear * 100 <= ' + @ToMonthYearText END 
	--+ ' AND ' 
	+ CASE WHEN @IsDate = 1 
				THEN 'CONVERT(DATETIME,CONVERT(VARCHAR(10),OT2001.OrderDate,101),101) < ''' + @ToDateText + ''''
				ELSE 'OT2001.TranMonth + OT2001.TranYear * 100 <= ' + @ToMonthYearText END + '
	GROUP BY AT3206_AG.DivisionID, AT3206_AG.OrderID, OT2002.InventoryID, 
			OT2002.Parameter01, OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04, OT2002.Parameter05,
			OT2002.TransactionID, 
			AT2006.VoucherDate, AT2006.TranMonth, AT2006.TranYear,
			OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear
	'	
END ---------- ANGEL
ELSE
BEGIN 
	Set @sSQL = N'
	SELECT DivisionID, 
			OrderID, 
			TransactionID, 
			InventoryID,
			Parameter01, Parameter02, Parameter03, Parameter04, Parameter05,
			SUM(ActualQuantity) as ActualQuantity, 
			MAX(ActualDate) as ActualDate, 
			SUM(ActualQuantity0) as ActualQuantity0,
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
				+ CASE WHEN @IsDate = 1 
					THEN ' CONVERT(DATETIME,CONVERT(VARCHAR(10),OT2001.OrderDate,101),101) < ''' + @FromDateText + ''''
					ELSE ' OT2001.TranMonth + OT2001.TranYear * 100 <= ' + @FromMonthYearText END
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
				+ CASE WHEN @IsDate = 1 
					THEN 'CONVERT(DATETIME,CONVERT(VARCHAR(10),OT200101.OrderDate,101),101) < ''' + @FromDateText + ''''
					ELSE 'OT200101.TranMonth + OT200101.TranYear * 100 <= ' + @FromMonthYearText END
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
	WHERE DivisionID = ''' + @DivisionID +  ''''
	----Modified on 14/11/2011
	+ ' AND ' + CASE WHEN @IsDate = 1 
				THEN 'CONVERT(DATETIME,CONVERT(VARCHAR(10),ExportVoucherDate ,101),101)< ''' + @ToDateText + ''' '
				ELSE 'ExportTranMonth + ExportTranYear * 100 <= ' + @ToMonthYearText END 
	+ ' AND ' + CASE WHEN @IsDate = 1 
				THEN 'CONVERT(DATETIME,CONVERT(VARCHAR(10),SaleOrderDate,101),101) < ''' + @ToDateText + ''''
				ELSE 'SaleTranMonth + SaleTranYear * 100 <= ' + @ToMonthYearText END + '
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
	
	print @sSQL
	print @sSQL2
	EXEC('CREATE VIEW OV0306 ---tao boi OP0301
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
			CASE WHEN (OV2300.FOrderQuantity - ISNULL(OV0306.ActualQuantity,0) + ISNULL(OV2300.AdjustQuantity, 0)) = 0 then 0
			when ISNULL(OV0306.ActualQuantity,0) = 0 then 1
			when (ISNULL(OV0306.ActualQuantity,0) > 0 AND 
					(OV2300.FOrderQuantity - ISNULL(OV0306.ActualQuantity,0) + ISNULL(OV2300.AdjustQuantity, 0)) > 0) then 2
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
			OV2300.I01Name, OV2300.I02Name, OV2300.I03Name, OV2300.I04Name, OV2300.I05Name, OV2300.I06Name, OV2300.I07Name, OV2300.I08Name,
			OV2300.I09Name, OV2300.I10Name,OV2300.EmployeeID, ISNULL(OV0306.Finish,0) as Finish, OV2300.WareHouseID '
		
	Set @sSQL1 =  @sSELECT  + N'
	FROM		OV2300 
	LEFT JOIN	OV0306  
		ON		OV0306.OrderID = OV2300.OrderID 
				AND OV0306.InventoryID = OV2300.InventoryID 
				AND OV0306.TransactionID = OV2300.TransactionID 
				AND OV0306.DivisionID = OV2300.DivisionID
	LEFT JOIN	AT1304 ON OV2300.UnitID = AT1304.UnitID
	' + @sFROM + '
	LEFT JOIN	OV1101 
		ON		OV2300.OrderStatus = OV1101.OrderStatus 
				AND OV2300.DivisionID = OV1101.DivisionID 
				AND OV1101.TypeID = ''SO''
	WHERE	OV2300.OrderType = 0 AND OV2300.DivisionID = ''' + @DivisionID + ''' AND ' +   
			CASE WHEN @IsDate = 1 then  ' ((OV2300.OrderStatus not in ( 3,  4)   AND 
			CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2300.VoucherDate,101),101)  BETWEEN ''' + 					
			@FromDateText + ''' AND ''' +  @ToDateText  + '''  AND  
			(OV2300.OrderQuantity - ISNULL(OV0306.ActualQuantity0, 0) + ISNULL(OV2300.AdjustQuantity, 0)) > 0) or
			CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2300.VoucherDate,101),101)  BETWEEN ''' + 					
			@FromDateText + ''' AND ''' +  @ToDateText  + ''') '
			else 	' ((OV2300.OrderStatus not in (2, 3,  4)   AND  
			OV2300.TranMonth + OV2300.TranYear*100 BETWEEN ' +  cast(@FromMonth + @FromYear*100 AS nvarchar(10)) +  ' AND ' + 
			cast(@ToMonth + @ToYear*100 AS nvarchar(10))  + '  AND  
			(OV2300.OrderQuantity - ISNULL(OV0306.ActualQuantity0, 0) + ISNULL(OV2300.AdjustQuantity, 0)) > 0) OR 
			OV2300.TranMonth + OV2300.TranYear*100 BETWEEN ' +  cast(@FromMonth + @FromYear*100 AS nvarchar(10)) +  ' AND ' + 
			cast(@ToMonth + @ToYear*100 AS nvarchar(10))  + ') ' end +  
			  ' AND  OV2300.InventoryID ' + CASE WHEN @FromInventoryID = '%' then ' like ''%''' 
			else ' BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''''   end 

--PRINT(@sSQL)
--PRINT(@sSQL1)

	IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME = 'OV0301' AND XTYPE ='V') 
		DROP VIEW OV0301
	print @sSQL
	print @sSQL1
	
	EXEC ('CREATE VIEW OV0301  --tao boi OP0301
			AS '+@sSQL+@sSQL1)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
