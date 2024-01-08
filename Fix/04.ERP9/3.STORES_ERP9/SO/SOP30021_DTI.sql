IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30021_DTI]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30021_DTI]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In chi tiet don hang ban
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 26/05/2017 by Phan thanh hoàng vũ
--- Modify by Thị Phượng Date 14/07/2017: Chỉ lấy những trường cần thiết trong báo cáo
--- Modify by Trọng Kiên Date 27/11/2020: Bổ sung 10 trường MPT và 20 trường tham số detail.
--- Modify by Văn Tài 	 Date 26/08/2021: Tách store DUCTIN.
--- Modify by Hoài Bảo	 Date 30/09/2022: Cập nhật truyền dữ liệu lọc Mặt hàng, khách hàng, nhân viên theo dạng danh sách
-- <Example> EXEC SOP30021_DTI 'AS', '', 0, '2017-01-01', '2017-05-30', '04/2017'',''05/2017', '', '', 'HOANG', 'HOANG','', '', 'VND', 'A09', ''

CREATE PROCEDURE [dbo].[SOP30021_DTI] (
			@DivisionID			NVARCHAR(50),	--Biến môi trường
			@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
			@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
			@FromDate			DATETIME, 
			@ToDate				DATETIME, 
			@PeriodIDList		NVARCHAR(2000),
			@ObjectID			NVARCHAR(MAX),
			@EmployeeID		    NVARCHAR(MAX),
			@InventoryID		NVARCHAR(MAX),
			@CurrencyID			NVARCHAR(50),
			@GroupID			NVARCHAR(50),	--Nhóm mã phân tích
			@UserID				NVARCHAR(50)	--Biến môi trường
			)
 AS
DECLARE 	@sSQL nvarchar(MAX),
            @sSQL1 nvarchar(MAX),
			@sSQL2 nvarchar(MAX),
			@sWhere VARCHAR(MAX),
			@GroupField nvarchar(20),
			@sFROM nvarchar(500),
			@sSELECT nvarchar(500)
			
	Set @sFROM = ''
	Set @sSELECT = ''
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
	
	--Search theo khách hàng (thay đổi control chọn nhiều)
	IF ISNULL(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ObjectID, '''') IN ('''+@ObjectID +''')'

	--Search theo người bán hàng (thay đổi control chọn nhiều)
	IF ISNULL(@EmployeeID, '')!= ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SalesManID, '''') IN ('''+@EmployeeID +''')'

	--Search theo vật tư (thay đổi control chọn nhiều)
	IF ISNULL(@InventoryID, '')!= '' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.InventoryID, '''') IN ('''+@InventoryID +''')'
	
	--Search theo loại tiền
	IF ISNULL(@CurrencyID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.CurrencyID, '''') = N'''+@CurrencyID+''''

	IF ISNULL(@GroupID, '')!= ''
	BEGIN
		Exec AP4700  	@GroupID,	@GroupField OUTPUT
		Select @sFROM = @sFROM + ' LEFT JOIN AV6666 V1 ON V1.DivisionID = M.DivisionID AND V1.SelectionType = ''' + @GroupID + ''' AND V1.SelectionID = M.' + @GroupField,
			   @sSELECT = @sSELECT + ', V1.SelectionID AS GroupID, V1.SelectionName AS GroupName'
	END
	ELSE
		Set @sSELECT = @sSELECT +  ', '''' AS GroupID, '''' AS GroupName'	

    Set @sSQL = 'SELECT AnaTypeID,UserName,IsUsed FROM OT1005 WITH (NOLOCK) WHERE AnaTypeID like ''%S%'' AND IsUsed = 1 AND DivisionID = ''' + @DivisionID + '''
                 UNION ALL
                 SELECT TypeID AS AnaTypeID,UserName,IsUsed FROM OT0005 WITH (NOLOCK) WHERE TypeID like ''%SD%'' AND IsUsed = 1 AND DivisionID = ''' + @DivisionID + ''''

	Set @sSQL1 = ' Select
				M.DivisionID
				, M.DivisionName
				, M.MonthYear
				, M.OrderID AS SOrderID
				, M.VoucherNo
				, M.VoucherDate AS OrderDate
				, M.ObjectID
				, M.ObjectName
				, ISNULL(ISNULL(O02.CurrencyID, O12.CurrencyID), O22.CurrencyID) CurrencyID
				, M.Orders
				, M.OrderStatus
				, M.InventoryID
				, M.InventoryName
				, M.UnitName
				, M.OrderQuantity
				, -- So luong don hang
				  M.ActualQuantity
				, -- So luong xuat kho
				  (M.OrderQuantity - M.ActualQuantity) AS QuantityEnd
				, --So luong con lai
				  M.ConversionUnitID
				, ConversionUnitName
				, M.Ana01ID
				, A01.Ananame AS Ana01name
				, M.Ana02ID
				, A02.Ananame AS Ana02name
				, M.Ana03ID
				, A03.Ananame AS Ana03name
				, M.Ana04ID
				, A04.Ananame AS Ana04name
				, M.Ana05ID
				, A05.Ananame AS Ana05name
				, M.Ana06ID
				, A06.Ananame AS Ana06name
				, M.Ana07ID
				, A07.Ananame AS Ana07name
				, M.Ana08ID
				, A08.Ananame AS Ana08name
				, M.Ana09ID
				, A09.Ananame AS Ana09name
				, M.Ana10ID
				, A10.Ananame AS Ana10name
				, M.Ana01ID AS S01
				, M.Ana02ID AS S02
				, M.Ana03ID AS S03
				, M.Ana04ID AS S04
				, M.Ana05ID AS S05
				, M.nvarchar01 AS SD01
				, M.nvarchar02 AS SD02
				, M.nvarchar03 AS SD03
				, M.nvarchar04 AS SD04
				, M.nvarchar05 AS SD05
				, M.nvarchar06 AS SD06
				, M.nvarchar07 AS SD07
				, M.nvarchar08 AS SD08
				, M.nvarchar09 AS SD09
				, M.nvarchar10 AS SD10
				, M.nvarchar11 AS SD11
				, M.nvarchar12 AS SD12
				, M.nvarchar13 AS SD13
				, M.nvarchar14 AS SD14
				, M.nvarchar15 AS SD15
				, M.nvarchar16 AS SD16
				, M.nvarchar17 AS SD17
				, M.nvarchar18 AS SD18
				, M.nvarchar19 AS SD19
				, M.nvarchar20 AS SD20
				, M.nvarchar01
				, M.nvarchar02
				, M.nvarchar03
				, M.nvarchar04
				, M.nvarchar05
				, M.nvarchar06
				, M.nvarchar07
				, M.nvarchar08
				, M.nvarchar09
				, M.nvarchar10
				, M.nvarchar11
				, M.nvarchar12
				, M.nvarchar13
				, M.nvarchar14
				, M.nvarchar15
				, M.nvarchar16
				, M.nvarchar17
				, M.nvarchar18
				, M.nvarchar19
				, M.nvarchar20
				, ISNULL(M.ConvertedQuantity, 0)  AS ConvertedQuantity
				, M.VATPercent
				, M.DiscountPercent
				, M.CommissionPercent
				, M.SalePrice
				, ISNULL(M.SalePrice, 0) * ISNULL(M.ExchangeRate, 0) AS ConvertedPrice
				, M.OriginalAmount
				, M.ConvertedAmount
				, M.VATOriginalAmount
				, M.VATConvertedAmount
				, ISNULL(M.OriginalAmount, 0) + ISNULL(M.VATOriginalAmount, 0) AS SumOriginalAmount
				, ISNULL(M.ConvertedAmount,0) + ISNULL(M.VATConvertedAmount, 0) AS SumConvertedAmount
				, M.DiscountOriginalAmount
				, M.DiscountConvertedAmount
				, ISNULL(M.DiscountAmount, 0) * ISNULL(M.ExchangeRate, 0) AS DiscountAmount
				, M.CommissionOAmount
				, M.CommissionCAmount
				, M.SalesManID
				, M.SalesManName
				, M.WareHouseID
				, M.WareHouseName
				, ISNULL(M.ETaxConvertedUnit,0) AS ETaxConvertedUnit
				, M.TotalOriginalAmount AS TOriginalAmount
				, ROUND(M.TotalConvertedAmount, 0, 0) AS TConvertedAmount ' + ISNULL(@sSELECT,'')


	SET @sSQL2 = '
				FROM OV2300 M
				LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = M.DivisionID AND O02.SOrderID = M.OrderID AND O02.TransactionID = M.TransactionID
				LEFT JOIN OT2102 O12 WITH (NOLOCK) ON O12.DivisionID = M.DivisionID AND O12.TransactionID = O02.InheritTransactionID
				LEFT JOIN OT2102 O22 WITH (NOLOCK) ON O22.DivisionID = M.DivisionID AND O12.TransactionID = O12.InheritTransactionID
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
				' + ISNULL(@sFROM,'') + '
				WHERE '+ @sWhere + ' AND M.OrderType = 0 
				Order by M.VoucherDate, M.VoucherNo, M.InventoryID
				'

	PRINT (@sSQL)
	PRINT (@sSQL1) 
	PRINT (@sSQL2)
	EXEC (@sSQL + @sSQL1 + @sSQL2)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
