IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP30091]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP30091]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Báo cáo phân tích bán hàng chạy
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 15/06/2021 by Tấn Lộc
-- <Example> EXEC SOP30021 'AS', '', 0, '2017-01-01', '2017-05-30', '04/2017'',''05/2017', '', '', 'HOANG', 'HOANG','', '', 'VND', 'A09', ''

CREATE PROCEDURE [dbo].BP30091 (
			@DivisionID			NVARCHAR(50),	--Biến môi trường
			@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
			@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
			@FromDate			DATETIME, 
			@ToDate				DATETIME, 
			@PeriodIDList		NVARCHAR(2000),
			@GroupID1			NVARCHAR(50),
			@GroupID			NVARCHAR(50),	--Nhóm mã phân tích ()
			@UserID				NVARCHAR(50),	--Biến môi trường
			@ValueID            NVARCHAR(MAX)
			)
 AS
DECLARE 	@sSQL varchar(MAX),
            @sSQL1 varchar(MAX),
			@sWhere NVARCHAR(MAX),
			@GroupField nvarchar(20),
			@sFROM nvarchar(500),
			@sSELECT nvarchar(500),
			@sFrom1 NVARCHAR (500),
			@sSELECT1 nvarchar(500),
			@GroupField1 nvarchar(20)
	
	Set @sFROM = ''
	Set @sSELECT = ''
	SET @sFrom1 = ''
	SET @sSELECT1 = ''
	Set @sWhere = ''

	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = @sWhere + ' M.DivisionID = '''+@DivisionID+''''

	--Search theo điều điện thời gian
	IF @IsDate = 1	
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	ELSE
		SET @sWhere = @sWhere + ' AND M.MonthYear IN ('''+@PeriodIDList+''')'
	

	IF ISNULL(@GroupID, '')!= ''
	BEGIN
		Exec AP4700  	@GroupID,	@GroupField OUTPUT
		Select @sFROM = @sFROM + ' LEFT JOIN AV6666 V1 ON V1.DivisionID = M.DivisionID AND V1.SelectionType = ''' + @GroupID + ''' AND V1.SelectionID = M.' + @GroupField,
			   @sSELECT = @sSELECT + ', V1.SelectionID AS GroupID, V1.SelectionName AS GroupName'
	END

	IF ISNULL(@GroupID1, '') != ''
	BEGIN
		Exec AP4700  	@GroupID1,	@GroupField1 OUTPUT
		Select @sFROM1 = @sFROM1 + ' LEFT JOIN AV6666 V2 ON V2.DivisionID = M.DivisionID AND V2.SelectionType = ''' + @GroupID1 + ''' AND V2.SelectionID = M.' + @GroupField1,
			   @sSELECT1 = @sSELECT1 + ', V2.SelectionID AS GroupID1, V2.SelectionName AS GroupName1'
	END

	IF ISNULL(@GroupID, '') = '' AND ISNULL(@GroupID1, '') = ''
	BEGIN
		Set @sSELECT = @sSELECT +  ', '''' AS GroupID, '''' AS GroupName'
		SET @sSELECT = @sSELECT + ', '''' AS GroupID1, '''' AS GroupName'
	END

	
	IF ISNULL(@ValueID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(V2.SelectionID, '''') IN (''' + @ValueID + ''') '


	Set @sSQL1 = ' Select
				M.DivisionID, M.DivisionName, M.MonthYear, M.OrderID AS SOrderID, M.VoucherNo, M.VoucherDate AS OrderDate,
					 M.ObjectID, M.ObjectName, M.CurrencyID, M.Orders, M.OrderStatus, M.InventoryID,  M.InventoryName,
					 M.UnitName, M.OrderQuantity, -- So luong don hang
					 M.ActualQuantity, -- So luong xuat kho
					 (M.OrderQuantity - M.ActualQuantity) AS QuantityEnd, --So luong con lai
					 M.ConversionUnitID, ConversionUnitName,
					 ISNULL(M.ConvertedQuantity,0)  AS ConvertedQuantity,
					 M.VATPercent, M.DiscountPercent, M.CommissionPercent, M.SalePrice,
					 ISNULL(M.SalePrice, 0) * ISNULL(M.ExchangeRate, 0) AS ConvertedPrice,
					 M.OriginalAmount, M.ConvertedAmount, M.VATOriginalAmount, M.VATConvertedAmount,
					 ISNULL (M.OriginalAmount ,0) + ISNULL(M.VATOriginalAmount,0) AS SumOriginalAmount,
					 ISNULL (M.ConvertedAmount ,0) + ISNULL(M.VATConvertedAmount,0) AS SumConvertedAmount,
					 M.DiscountOriginalAmount, M.DiscountConvertedAmount, M.CommissionOAmount, M.CommissionCAmount,
					 M.SalesManID, M.SalesManName, M.WareHouseID, M.WareHouseName, ISNULL(M.ETaxConvertedUnit,0) AS ETaxConvertedUnit,
					 M.TotalOriginalAmount AS TOriginalAmount,
					 M.TotalConvertedAmount AS TConvertedAmount ' + ISNULL(@sSELECT,'')  + ISNULL(@sSELECT1,'') +
					 '
				FROM OV2300 M 
				LEFT JOIN AT1011 A01 WITH (NOLOCK) ON M.Ana01ID = A01.anaID AND A01.AnaTypeID = ''A01''
				LEFT JOIN AT1011 A02 WITH (NOLOCK) ON M.Ana02ID = A02.anaID AND A02.AnaTypeID = ''A02''
				LEFT JOIN AT1011 A03 WITH (NOLOCK) ON M.Ana03ID = A03.anaID AND A03.AnaTypeID = ''A03''
				LEFT JOIN AT1011 A04 WITH (NOLOCK) ON M.Ana04ID = A04.anaID AND A04.AnaTypeID = ''A04''
				LEFT JOIN AT1011 A05 WITH (NOLOCK) ON M.Ana05ID = A05.anaID AND A05.AnaTypeID = ''A05''
				LEFT JOIN AT1011 A06 WITH (NOLOCK) ON M.Ana06ID = A06.anaID AND A06.AnaTypeID = ''A06''
				LEFT JOIN AT1011 A07 WITH (NOLOCK) ON M.Ana07ID = A07.anaID AND A07.AnaTypeID = ''A07''
				LEFT JOIN AT1011 A08 WITH (NOLOCK) ON M.Ana08ID = A08.anaID AND A08.AnaTypeID = ''A08''
				LEFT JOIN AT1011 A09 WITH (NOLOCK) ON M.Ana09ID = A09.anaID AND A09.AnaTypeID = ''A09''
				LEFT JOIN AT1011 A10 WITH (NOLOCK) ON M.Ana10ID = A10.anaID AND A10.AnaTypeID = ''A10''
				' + ISNULL(@sFROM,'') + ISNULL(@sFROM1,'') +'
				WHERE '+ @sWhere + ' AND M.OrderType = 0 
				
				Order by M.VoucherDate, M.VoucherNo, M.InventoryID
				'

	Print (@sSQL + @sSQL1)
	EXEC (@sSQL + @sSQL1)
	




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
