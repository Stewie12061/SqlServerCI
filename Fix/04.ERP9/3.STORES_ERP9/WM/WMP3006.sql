IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP3006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP3006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---WMF3006_BC nhập kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Như Hàn, Date: 27/11/2018
-- <Example>
---- 
/*<Example>
	
EXEC WMP3006 'VF', 'VF'',''AS', 11, 2018, 11, 2018, '2018-11-27 00:00:00', '2018-11-27 00:00:00', 'IPHONE'',''APPLE', 
	'PB'',''NM'',''BBTH', 0, 'IPHONE'',''B', 'VN661-05786', 'AWB001', '%', '%', 1
EXEC WMP3006 @DivisionID, @DivisionList, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, 
@FromWareHouseID, @ToWareHouseID, @FromInventoryID, @ToInventoryID, @ListFirmID, @ListVoucherTypeID, @IsDate, @LstProductTypeID, @AWBNo, @OrderNo, @HAWBNo, @IsDetail

*/


CREATE PROCEDURE [WMP3006]
( 
		@DivisionID			NVARCHAR(50),
		@DivisionList		NVARCHAR(MAX),
		@FromMonth			INT,
		@FromYear			INT,
		@ToMonth			INT,
		@ToYear				INT,
		@FromDate			DATETIME,
		@ToDate				DATETIME,
		@FromWareHouseID	NVARCHAR(50),
		@ToWareHouseID		NVARCHAR(50),
		@FromInventoryID	NVARCHAR(50),
		@ToInventoryID		NVARCHAR(50),
		@ListFirmID			NVARCHAR(MAX), 	 
		@ListVoucherTypeID	NVARCHAR(MAX), 
		@IsDate				TINYINT, ----0 theo kỳ, 1 theo ngày
		@LstProductTypeID NVARCHAR(MAX), 
		@AWBNo				NVARCHAR(MAX), 
		@OrderNo			NVARCHAR(MAX),
		@HAWBNo				NVARCHAR(MAX),
		@IsDetail			TINYINT ----0 Hiển thị số lượng, 1 Hiển thị chi tiết
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
		@PeriodFrom INT,	
		@PeriodTo INT

SET @PeriodFrom = @FromMonth+@FromYear*100
SET @PeriodTo = @ToMonth+@ToYear*100


IF ISNULL(@DivisionList, '') <> '' 
	SET @sWhere = @sWhere + ' AND D07.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' AND D07.DivisionID = '''+@DivisionID+''''

IF ISNULL(@FromWareHouseID,'') <> '' AND ISNULL(@ToWareHouseID,'') <>''
	SET @sWhere = @sWhere + ' AND D06.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND '''+@ToWareHouseID+''' '

IF ISNULL(@FromInventoryID,'') <> '' AND ISNULL(@ToInventoryID,'') <>''
	SET @sWhere = @sWhere + ' AND D07.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''' '

----Search theo hãng 
IF (ISNULL(@ListFirmID,'') = '' OR ISNULL(@ListFirmID,'') = '%')
	SET @sWhere = @sWhere + ' AND D02.I01ID LIKE ''%'' '
ELSE 
	SET @sWhere = @sWhere + ' AND D02.I01ID IN ('''+@ListFirmID+''') '

---- Search theo loại chứng từ
IF (ISNULL(@ListVoucherTypeID,'') = '' OR ISNULL(@ListVoucherTypeID,'') = '%')
	SET @sWhere = @sWhere + ' AND D06.VoucherTypeID LIKE ''%'' '
ELSE 
	SET @sWhere = @sWhere + ' AND D06.VoucherTypeID IN ('''+@ListVoucherTypeID+''') '

---- Search theo loại hàng (I02 mã phân tích mặt hàng)
IF (ISNULL(@LstProductTypeID,'') = '' OR ISNULL(@LstProductTypeID,'') = '%')
	SET @sWhere = @sWhere + ' AND D02.I02ID LIKE ''%'' '
ELSE 
	SET @sWhere = @sWhere + ' AND D02.I02ID IN ('''+@LstProductTypeID+''') '

---- Search theo số AWB
IF (ISNULL(@AWBNo,'') <> '' OR ISNULL(@AWBNo,'') = '%')
SET @sWhere = @sWhere +'AND ISNULL(WT07.AWBNo,'''') LIKE ''%'+@AWBNo+'%'''

---- Search theo số đơn hàng
IF (ISNULL(@OrderNo,'') <> '' OR ISNULL(@OrderNo,'') = '%')
SET @sWhere = @sWhere +'AND ISNULL(WT07.OrderNo,'''') LIKE ''%'+@OrderNo+'%'''

---- Search theo số giao nhận
IF (ISNULL(@HAWBNo,'') <> '' OR ISNULL(@HAWBNo,'') = '%')
SET @sWhere = @sWhere +'AND ISNULL(WT07.HAWBNo,'''') LIKE ''%'+@HAWBNo+'%'''

IF @IsDate = 1
	BEGIN	
		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),D06.VoucherDate, 112) >= '''+CONVERT(VARCHAR(10),@FromDate,112)+''' '
		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),D06.VoucherDate, 112) <= '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),D06.VoucherDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+'''  '
	END
ELSE	
	BEGIN
		IF (@FromMonth IS NOT NULL AND @ToMonth IS NULL) SET @sWhere = @sWhere + '
			AND D06.TranMonth + D06.TranYear * 100 >= '+Ltrim(@PeriodFrom)+''
		IF (@FromMonth IS NULL AND @ToMonth IS NOT NULL) SET @sWhere = @sWhere + '
			AND D06.TranMonth + D06.TranYear * 100 <= '+Ltrim(@PeriodTo)+''
		IF (@FromMonth IS NOT NULL AND @ToMonth IS NOT NULL) SET @sWhere = @sWhere + '
			AND D06.TranMonth + D06.TranYear * 100 BETWEEN '+Ltrim(@PeriodFrom)+' AND '+LTrim(@PeriodTo)+''
	END	
		
IF @IsDetail = 1
BEGIN
	SET @sSQL = @sSQL +'
	SELECT  
		D06.VoucherNo, D06.VoucherTypeID, D06.VoucherDate, D07.DivisionID, D06.ObjectID, AT1202.ObjectName, 
		WT07.AWBNo, WT07.OrderNo, WT07.HAWBNo, WT07.ConfirmStatus, WT07.ConfirmDate, WT08.SerialNo, WT08.LocationID, WT08.IMEINo,
		D06.WareHouseID, D03.WareHouseName, '''' As WareHouseType, D07.ActualQuantity As Quantity, 
		D02.I01ID, D02.I02ID, D02.I03ID,
		I1.AnaName AS  Firm, 
		I2.AnaName AS  ProductTypeName, 
		I3.AnaName AS  Model,  
		D07.InventoryID, D02.InventoryName, 
		D07.CurrencyID, 
		D07.ExchangeRate, 
		D07.UnitPrice, 
		D06.EmployeeID, 
		T13.FullName,
		D06.Description, 
		D06.RefNo01 As Ref01, D06.RefNo02 As Ref02,	
		(Case WT06.IsConsignment
		when 0 then N''NO''
		when 1 then N''YES''
		else '''' end) as IsConsignment,
		D07.ConvertedAmount As CAmount,
		D07.OriginalAmount As Oamount
	FROM AT2007 AS D07 WITH (NOLOCK)
	INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.InventoryID = D07.InventoryID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D06.WareHouseID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D06.ObjectID
	LEFT JOIN AT1015 I1 WITH (NOLOCK) ON I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID
	LEFT JOIN AT1015 I2 WITH (NOLOCK) ON I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID
	LEFT JOIN AT1015 I3 WITH (NOLOCK) ON I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID
	LEFT JOIN WMT2007 WT07 WITH (NOLOCK) ON WT07.ERP8VoucherID = D07.VoucherID
	LEFT JOIN WMT2006 WT06 WITH (NOLOCK) ON WT06.APK = WT07.APKMaster
	LEFT JOIN WMT2008 WT08 WITH (NOLOCK) ON WT07.APK = WT08.APKDetail
	LEFT JOIN AT1103 T13 WITH (NOLOCK) ON T13.EmployeeID = D06.EmployeeID
	WHERE D06.KindVoucherID in (1,3,5,7,9,15,17) 
	'+@sWhere+'
	'
END
ELSE
BEGIN
SET @sSQL = @sSQL +'
	SELECT  
		D06.VoucherNo, D06.VoucherTypeID, D06.VoucherDate, D07.DivisionID, D06.ObjectID, AT1202.ObjectName, 
		WT07.AWBNo, WT07.OrderNo, WT07.HAWBNo, WT07.ConfirmStatus, WT07.ConfirmDate,
		D06.WareHouseID, D03.WareHouseName, '''' As WareHouseType, 
		D02.I01ID, D02.I02ID, D02.I03ID,
		I1.AnaName AS  Firm, 
		I2.AnaName AS  ProductTypeName, 
		I3.AnaName AS  Model,  
		D07.InventoryID, D02.InventoryName, 
		D07.CurrencyID, 
		D07.ExchangeRate, 
		D07.UnitPrice, 
		D06.EmployeeID, T13.FullName,
		D06.Description, 
		D06.RefNo01 As Ref01, D06.RefNo02 As Ref02,	
		(Case WT06.IsConsignment
		when 0 then N''NO''
		when 1 then N''YES''
		else '''' end) as IsConsignment,
		SUM(D07.ConvertedAmount) As CAmount,
		SUM(D07.OriginalAmount) As Oamount,
		SUM(D07.ActualQuantity) As Quantity
	FROM AT2007 AS D07 WITH (NOLOCK)
	INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.InventoryID = D07.InventoryID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D06.WareHouseID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D06.ObjectID
	LEFT JOIN AT1015 I1 WITH (NOLOCK) ON I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID
	LEFT JOIN AT1015 I2 WITH (NOLOCK) ON I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID
	LEFT JOIN AT1015 I3 WITH (NOLOCK) ON I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID
	LEFT JOIN WMT2007 WT07 WITH (NOLOCK) ON WT07.ERP8VoucherID = D07.VoucherID
	LEFT JOIN WMT2006 WT06 WITH (NOLOCK) ON WT06.APK = WT07.APKMaster
	LEFT JOIN WMT2008 WT08 WITH (NOLOCK) ON WT07.APK = WT08.APKDetail
	LEFT JOIN AT1103 T13 WITH (NOLOCK) ON T13.EmployeeID = D06.EmployeeID
	WHERE D06.KindVoucherID in (1,3,5,7,9,15,17) 
	'+@sWhere+'
	GROUP BY 
		D06.VoucherNo, D06.VoucherTypeID, D06.VoucherDate, D07.DivisionID, D06.ObjectID, AT1202.ObjectName, 
		WT07.AWBNo, WT07.OrderNo, WT07.HAWBNo, WT07.ConfirmStatus, WT07.ConfirmDate,
		D06.WareHouseID, D03.WareHouseName,
		D02.I01ID, D02.I02ID, D02.I03ID,
		I1.AnaName,
		I2.AnaName,
		I3.AnaName,
		D07.InventoryID, D02.InventoryName, 
		D06.DivisionID, 
		D07.CurrencyID, 
		D07.ExchangeRate, 
		D07.UnitPrice, 
		D06.EmployeeID, D06.Description, 
		D06.RefNo01, D06.RefNo02
	'
END
--PRINT (@sSQL)
--PRINT (@sWhere)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
