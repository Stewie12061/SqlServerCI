IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form Lưới detail xem chi tiết
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 05/05/2017 
----Modify by : Thị Phượng on 28/08/2017 Bổ sung load thêm ghi chú 03 và 20 mã tham số dưới lưới detail
----Modified by Kiều Nga on 27/05/2020 Lấy thêm trường UnitName
----Updated by: Kiều Nga, Date: 07/07/2020: Load thông tin tên mã phân tích
----Updated by: Kiều Nga, Date: 23/11/2021: Load thông tin chiết khấu (DPT)
----Updated by: Kiều Nga, Date: 25/11/2021: Load thêm trường InventoryGroupAnaTypeID
----Updated by: Kiều Nga, Date: 08/12/2021: Load thêm trường MinPrice
----Updated by: Kiều Nga, Date: 30/12/2021: Load thêm trường Barcode
----Updated by: Hoài Bảo, Date: 18/05/2022: Load thêm trường DiscountAmount
----Updated by: Hoài Bảo, Date: 08/06/2022: Bổ sung kiểm tra NULL các trường sử dụng SumOnGrid
----Updated by: Phương Thảo, Date: 25/11/2021: Load thêm trường IsProInventoryID
----Updated by: Tiến Thành, Date: 19/04/2023: [2023/03/IS/0030] - Load thêm mục tiền chiết khấu khuyến mãi để hiển thị
----Updated by: Tiến Thành, Date: 21/04/2023: Chỉnh sửa lại điều kiện để load tiền khuyến mãi
----Updated by: Tiến Thành, Date: 24/04/2023: Chỉnh sửa cách tính tiền chiết khấu KM
----Updated by: Thanh Lượng, Date: 22/05/2023: Merge code Gree
----Updated by: Nhật Thanh, Date: 02/06/2023: Load thông tin mặt hàng chiết khấu ví tích lũy
----Updated by: Văn Tài, 	Date: 13/06/2023: Fix lỗi load dư cột RetailPrice.
----Updated by: Anh Đô,		Date: 14/06/2023: Fix lỗi load lưới Chi tiết đơn hàng bán sỉ/lẻ tại màn hình Xem chi tiết đơn hàng (Trường hợp xét duyệt)
----Updated by: Văn Tài,	Date: 04/07/2023: [2023/07/IS/0033] Fix lỗi trường hợp Sử dụng quy cách thì chưa có group dữ liệu theo.
----Updated by: Văn Tài,	Date: 04/07/2023: [2023/07/IS/0033] Fix bổ sung trường hợp: load edit, load mới, load phân trang xem chi tiết.
----Updated by: Thanh Lượng Date: 30/11/2023: [2023/11/TA/0176] - Customize nghiệp vụ duyệt đồng cấp đơn hàng bán (KH GREE)
-- <Example>
----    EXEC SOP20003 'AS','007c3440-c71f-48a0-92b0-44e9ebe1e8c8'
----
CREATE PROCEDURE SOP20003 ( 
        	@DivisionID nvarchar(50),
			@SOrderID nvarchar(50),
			@APKMaster VARCHAR(50) = '',
			@Type VARCHAR(50) = '',
			@PageNumber INT = 1,
			@PageSize INT = 25,
			@Mode INT = 0
) 
AS 

DECLARE @sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sSQL4 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@sGroup NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow VARCHAR(50),
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@sSQLJon NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLPage NVARCHAR (MAX) = '',
		@sSQL11 NVARCHAR (MAX) = '',
		@sSQL12 NVARCHAR (MAX) = '',
		@sSQL13 NVARCHAR (MAX) = '',
		@sSQL14 NVARCHAR (MAX) = '',
		@SameLevels INT

set @sSQL2 =''
SET @sSQL1 =''
SET @sWhere ='' 
SET @sGroup =''
set @sSQL11 =''
set @sSQL12 =''
set @sSQL13 =''
set @sSQL14 =''
       
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @Mode =1
SET @sSQLPage = @sSQLPage + ' ROW_NUMBER() OVER (ORDER BY OT2002.Orders) AS RowNum, '+@TotalRow+' AS TotalRow ,'

IF ISNULL(@Type, '') = 'DHB'
BEGIN
SET @Swhere = @Swhere + 'where CONVERT(VARCHAR(50),OT2002.APKMaster_9000)= '''+@APKMaster+''''
SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50),APKMaster) = @APKMaster
SELECT @SameLevels = ISNULL(MAX(SameLevels),0) FROM OOT9001 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50),APKMaster) = @APKMaster --số Cấp duyệt đồng cấp

END
ELSE 
BEGIN
SET @Swhere = @Swhere + 'where OT2002.SOrderID = '''+@SOrderID+''''
SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN OT2001 ON CONVERT(VARCHAR(50),OOT9001.APKMaster) = OT2001.APKMaster_9000  WHERE CONVERT(VARCHAR(50), OT2001.SOrderID) = @SOrderID
SELECT @SameLevels = ISNULL(MAX(SameLevels),0) FROM OOT9001 WITH (NOLOCK) LEFT JOIN OT2001 ON OOT9001.APKMaster = OT2001.APKMaster_9000  WHERE CONVERT(VARCHAR(50), OT2001.SOrderID) = @SOrderID --số Cấp duyệt đồng cấp

END

IF @Mode =1
BEGIN
	WHILE @i <= @Level - @SameLevels
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , APP01.APK9001'+@s+', APP01.Status'+@s+', APP01.Approvel'+@s+'Note, APP01.ApprovalDate'+@s+''
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT OOT1.APK APK9001'+@s+', OOT1.APKMaster,OOT1.DivisionID, T94.APKDetail APK2001,
						T94.Status Status'+@s+',
						O99.Description StatusName'+@s+',
						T94.Note Approvel'+@s+'Note,
						T94.ApprovalDate ApprovalDate'+@s+'
						FROM OOT9001 OOT1 WITH (NOLOCK)
						LEFT JOIN OOT9004 T94 WITH (NOLOCK) ON OOT1.APK = T94.APK9001 AND T94.DeleteFlag = 0
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(T94.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK 
						AND CASE WHEN ISNULL(CONVERT(Varchar (50),APP'+@s+'.APK2001),'''') <> '''' THEN APP'+@s+'.APK2001 ELSE OT2002.APK END = OT2002.APK '
		SET @i = @i + 1		
	END	
END

IF ISNULL(@SOrderID, '') = ''
	BEGIN
		SET @sSQL12 = @sSQL12 + ' From OT2001 WITH (NOLOCK)'
	END
ELSE 
	BEGIN 
		SET @sGroup = @sGroup + @sSQLSL
		SET @sSQL11 = @sSQL11 + '
			, SUM(ISNULL(A9.DiscountPercent,0)) AS PromotePercent
			, ISNULL(OT2002.OrderQuantity,0) * ISNULL(OT2002.SalePrice,0) * SUM(ISNULL(A9.DiscountPercent,0)) / 100 AS PromoteAmount
			'
		SET @sSQL12 = @sSQL12 + '
			FROM (
				SELECT O1.APK, O1.DivisionID, O1.SOrderID, 
					SUM(ISNULL(O2.OriginalAmount,0)) AS OriginalAmount,
					SUM(ISNULL(O2.DiscountAmount,0)) AS DiscountAmount,
					SUM(ISNULL(O2.VATOriginalAmount,0)) AS VATOriginalAmount,
					(SUM(ISNULL(O2.OriginalAmount,0)) - SUM(ISNULL(O2.DiscountAmount,0)) + SUM(ISNULL(O2.VATOriginalAmount,0))) AS TotalOrder,
					O1.OrderDate
					FROM OT2001 O1
					LEFT JOIN OT2002 O2 ON O1.SOrderID = O2.SOrderID
					GROUP BY O1.APK, O1.DivisionID, O1.SOrderID , O1.OrderDate
			 ) AS OT2001
			 '
		 SET @sSQL13 = @sSQL13 + '
			LEFT JOIN SOT0088 S88 ON OT2001.APK = S88.APKParent
			LEFT JOIN AT0109 A9 ON S88.BusinessChild = A9.PromoteID
					 AND A9.FromValues < OT2001.TotalOrder 
					 AND OT2001.TotalOrder < A9.ToValues
					 AND A9.FromDate <= OT2001.OrderDate
					 AND OT2001.OrderDate <= A9.ToDate
					 '
		SET @sSQL14 = @sSQL14 + '
		GROUP BY OT2001.TotalOrder
			, OT2002.SOrderID
			, OT2002.TransactionID
			, OT2002.DivisionID
			, OT2002.KITID
			, OT2002.KITQuantity
			, OT2002.InventoryID
			, OT2002.UnitID
			, OT2002.IsProInventoryID
			, OT2002.Orders
			, OT2002.Parameter01
			, OT2002.Parameter02
			, OT2002.Parameter03
			, OT2002.RetailPrice
			, OT2002.SalePrice
			, OT2002.ConvertedSalePrice
			, OT2002.OrderQuantity
			, OT2002.ConvertedQuantity
			, OT2002.OriginalAmount
			, OT2002.IsPicking
			, OT2002.WareHouseID
			, OT2002.ShipDate
			, OT2002.Description
			, OT2002.Finish
			, OT2002.Notes
			, OT2002.Notes01
			, OT2002.Notes02
			, OT2002.StandardPrice
			, OT2002.VATGroupID
			, OT2002.VATOriginalAmount
			, OT2002.VATConvertedAmount
			, OT2002.VATPercent
			, OT2002.ConvertedAmount
			, OT2002.Ana01ID
			, OT2002.Ana02ID
			, OT2002.Ana03ID
			, OT2002.Ana04ID
			, OT2002.Ana05ID
			, OT2002.Ana06ID
			, OT2002.Ana07ID
			, OT2002.Ana08ID
			, OT2002.Ana09ID
			, OT2002.Ana10ID
			, OT2002.IsBorrow
			, OT2002.nvarchar01
			, OT2002.nvarchar02
			, OT2002.nvarchar03
			, OT2002.nvarchar04
			, OT2002.nvarchar05
			, OT2002.nvarchar06
			, OT2002.nvarchar07
			, OT2002.nvarchar08
			, OT2002.nvarchar09
			, OT2002.nvarchar10
			, OT2002.Varchar01
			, OT2002.Varchar02
			, OT2002.Varchar03
			, OT2002.Varchar04
			, OT2002.Varchar05
			, OT2002.Varchar06
			, OT2002.Varchar07
			, OT2002.Varchar08
			, OT2002.Varchar09
			, OT2002.Varchar10
			, OT2002.InheritTableID
			, OT2002.InheritVoucherID
			, OT2002.InheritTransactionID
			, OT2002.APKMaster_9000
			, OT2002.DiscountPercent
			, OT2002.DiscountConvertedAmount
			, OT2002.DiscountOriginalAmount
			, OT2002.InventoryGroupAnaTypeID
			, OT2002.MinPrice
			, OT2002.DeliveryAddressID
			, OT2002.DeliveryAddress
			, OT2002.Weight
			, OT2002.DeliveryDate
			, OT2002.DiscountAmount
			, T01.AnaName
			, T02.AnaName
			, T03.AnaName
			, T004.AnaName
			, T05.AnaName
			, T06.AnaName
			, T07.AnaName
			, T08.AnaName
			, T09.AnaName
			, T10.AnaName
			, AT1302.InventoryName
			, T04.UnitName
			, AT1302.Barcode
			, AT1302.IsDiscount
			, AT1302.IsDiscountWallet
			, OT2002.ConvertedUnitID
			, OT2002.ConvertedRetailPrice
			' + @sGroup
	END
        
SET @OrderBy = 'OT2001.DivisionID, OT2001.OrderDate, OT2001.VoucherNo'

SET @sSQL = 'SELECT '+@sSQLPage+' 
		OT2002.SOrderID
		, OT2002.Parameter01
		, OT2002.Parameter02
		, OT2002.Parameter03
		, OT2002.TransactionID
		, ''' + @DivisionID + ''' AS DivisionID
		, OT2002.KITID
		, OT2002.KITQuantity
		, OT2002.InventoryID
		, AT1302.InventoryName
		, OT2002.UnitID
		, OT2002.IsProInventoryID
		, T04.UnitName
        , OT2002.RetailPrice
		, OT2002.SalePrice
		, OT2002.ConvertedSalePrice
		, ISNULL(OT2002.OrderQuantity, 0) AS OrderQuantity
		, OT2002.ConvertedQuantity
        , ISNULL(OT2002.OriginalAmount, 0) AS OriginalAmount
		, OT2002.IsPicking
		, OT2002.WareHouseID
		, OT2002.ShipDate
		, OT2002.Orders
		, OT2002.Description
        , OT2002.Finish
		, OT2002.Notes
		, OT2002.Notes01
		, OT2002.Notes02
		, OT2002.StandardPrice
		, OT2002.VATGroupID
		, ISNULL(OT2002.VATOriginalAmount, 0) AS VATOriginalAmount
		, ISNULL(OT2002.VATConvertedAmount, 0) AS VATConvertedAmount
		, OT2002.VATPercent
		, ISNULL(OT2002.ConvertedAmount, 0) AS ConvertedAmount
		, OT2002.Ana01ID
		, OT2002.Ana02ID
		, OT2002.Ana03ID
		, OT2002.Ana04ID
		, OT2002.Ana05ID
		, OT2002.Ana06ID
		, OT2002.Ana07ID
		, OT2002.Ana08ID
		, OT2002.Ana09ID
		, OT2002.Ana10ID
		, OT2002.IsBorrow
		, OT2002.nvarchar01
		, OT2002.nvarchar02
		, OT2002.nvarchar03
		, OT2002.nvarchar04
		, OT2002.nvarchar05
		, OT2002.nvarchar06
		, OT2002.nvarchar07
		, OT2002.nvarchar08
		, OT2002.nvarchar09
		, OT2002.nvarchar10
		, OT2002.Varchar01
		, OT2002.Varchar02
		, OT2002.Varchar03
		, OT2002.Varchar04
		, OT2002.Varchar05
		, OT2002.Varchar06
		, OT2002.Varchar07
		, OT2002.Varchar08
		, OT2002.Varchar09
		, OT2002.Varchar10
		, OT2002.InheritTableID
		, OT2002.InheritVoucherID
		, OT2002.InheritTransactionID
		, OT2002.APKMaster_9000
		, T01.AnaName AS Ana01Name
		, T02.AnaName AS Ana02Name
		, T03.AnaName AS Ana03Name
		, T004.AnaName AS Ana04Name
		, T05.AnaName AS Ana05Name
		, T06.AnaName AS Ana06Name
		, T07.AnaName AS Ana07Name
		, T08.AnaName AS Ana08Name
		, T09.AnaName AS Ana09Name
		, T10.AnaName AS Ana10Name
		, OT2002.DiscountPercent
		, OT2002.DiscountConvertedAmount
		, OT2002.DiscountOriginalAmount
		, OT2002.InventoryGroupAnaTypeID
		, OT2002.MinPrice
		, AT1302.Barcode
		, OT2002.DeliveryAddressID
		, OT2002.DeliveryAddress
		, OT2002.Weight
		, OT2002.DeliveryDate
		, ISNULL(OT2002.DiscountAmount, 0) AS DiscountAmount
		, AT1302.IsDiscount
		, AT1302.IsDiscountWallet
		, OT2002.ConvertedUnitID
		, OT2002.ConvertedRetailPrice
		'
		+@sSQL11
		+@sSQLSL

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sSQL1 = @sSQL1 + ',
		O99.S01ID AS STypeS01, O99.SUnitPrice01, O99.S01ID,
		O99.S02ID AS STypeS02, O99.SUnitPrice02, O99.S02ID,
		O99.S03ID AS STypeS03, O99.SUnitPrice03, O99.S03ID,
		O99.S04ID AS STypeS04, O99.SUnitPrice04, O99.S04ID,
		O99.S05ID AS STypeS05, O99.SUnitPrice05, O99.S05ID,
		O99.S06ID AS STypeS06, O99.SUnitPrice06, O99.S06ID,
		O99.S07ID AS STypeS07, O99.SUnitPrice07, O99.S07ID,
		O99.S08ID AS STypeS08, O99.SUnitPrice08, O99.S08ID,
		O99.S09ID AS STypeS09, O99.SUnitPrice09, O99.S09ID,		
		O99.S10ID AS STypeS10, O99.SUnitPrice10, O99.S10ID,
		O99.S11ID AS STypeS11, O99.SUnitPrice11, O99.S11ID,
		O99.S12ID AS STypeS12, O99.SUnitPrice12, O99.S12ID,
		O99.S13ID AS STypeS13, O99.SUnitPrice13, O99.S13ID,
		O99.S14ID AS STypeS14, O99.SUnitPrice14, O99.S14ID,
		O99.S15ID AS STypeS15, O99.SUnitPrice15, O99.S15ID,
		O99.S16ID AS STypeS16, O99.SUnitPrice16, O99.S16ID,
		O99.S17ID AS STypeS17, O99.SUnitPrice17, O99.S17ID,
		O99.S18ID AS STypeS18, O99.SUnitPrice18, O99.S18ID,
		O99.S19ID AS STypeS19, O99.SUnitPrice19, O99.S19ID,
		O99.S20ID AS STypeS20, O99.SUnitPrice20, O99.S20ID
		'

	IF ISNULL(@SOrderID, '') <> ''
	BEGIN
		SET @sSQL14 = '
		GROUP BY OT2001.TotalOrder
			, OT2002.SOrderID
			, OT2002.TransactionID
			, OT2002.DivisionID
			, OT2002.KITID
			, OT2002.KITQuantity
			, OT2002.InventoryID
			, OT2002.UnitID
			, OT2002.IsProInventoryID
			, OT2002.Orders
			, OT2002.Parameter01
			, OT2002.Parameter02
			, OT2002.Parameter03
			, OT2002.RetailPrice
			, OT2002.SalePrice
			, OT2002.ConvertedSalePrice
			, OT2002.OrderQuantity
			, OT2002.ConvertedQuantity
			, OT2002.OriginalAmount
			, OT2002.IsPicking
			, OT2002.WareHouseID
			, OT2002.ShipDate
			, OT2002.Description
			, OT2002.Finish
			, OT2002.Notes
			, OT2002.Notes01
			, OT2002.Notes02
			, OT2002.StandardPrice
			, OT2002.VATGroupID
			, OT2002.VATOriginalAmount
			, OT2002.VATConvertedAmount
			, OT2002.VATPercent
			, OT2002.ConvertedAmount
			, OT2002.Ana01ID
			, OT2002.Ana02ID
			, OT2002.Ana03ID
			, OT2002.Ana04ID
			, OT2002.Ana05ID
			, OT2002.Ana06ID
			, OT2002.Ana07ID
			, OT2002.Ana08ID
			, OT2002.Ana09ID
			, OT2002.Ana10ID
			, OT2002.IsBorrow
			, OT2002.nvarchar01
			, OT2002.nvarchar02
			, OT2002.nvarchar03
			, OT2002.nvarchar04
			, OT2002.nvarchar05
			, OT2002.nvarchar06
			, OT2002.nvarchar07
			, OT2002.nvarchar08
			, OT2002.nvarchar09
			, OT2002.nvarchar10
			, OT2002.Varchar01
			, OT2002.Varchar02
			, OT2002.Varchar03
			, OT2002.Varchar04
			, OT2002.Varchar05
			, OT2002.Varchar06
			, OT2002.Varchar07
			, OT2002.Varchar08
			, OT2002.Varchar09
			, OT2002.Varchar10
			, OT2002.InheritTableID
			, OT2002.InheritVoucherID
			, OT2002.InheritTransactionID
			, OT2002.APKMaster_9000
			, OT2002.DiscountPercent
			, OT2002.DiscountConvertedAmount
			, OT2002.DiscountOriginalAmount
			, OT2002.InventoryGroupAnaTypeID
			, OT2002.MinPrice
			, OT2002.DeliveryAddressID
			, OT2002.DeliveryAddress
			, OT2002.Weight
			, OT2002.DeliveryDate
			, OT2002.DiscountAmount
			, T01.AnaName
			, T02.AnaName
			, T03.AnaName
			, T004.AnaName
			, T05.AnaName
			, T06.AnaName
			, T07.AnaName
			, T08.AnaName
			, T09.AnaName
			, T10.AnaName
			, AT1302.InventoryName
			, T04.UnitName
			, AT1302.Barcode
			, AT1302.IsDiscount
			, AT1302.IsDiscountWallet
			, OT2002.ConvertedUnitID
			, OT2002.ConvertedRetailPrice
			'

		SET @sGroup = @sGroup + '
			, O99.S01ID, O99.SUnitPrice01
			, O99.S02ID, O99.SUnitPrice02
			, O99.S03ID, O99.SUnitPrice03
			, O99.S04ID, O99.SUnitPrice04
			, O99.S05ID, O99.SUnitPrice05
			, O99.S06ID, O99.SUnitPrice06
			, O99.S07ID, O99.SUnitPrice07
			, O99.S08ID, O99.SUnitPrice08
			, O99.S09ID, O99.SUnitPrice09
			, O99.S10ID, O99.SUnitPrice10
			, O99.S11ID, O99.SUnitPrice11
			, O99.S12ID, O99.SUnitPrice12
			, O99.S13ID, O99.SUnitPrice13
			, O99.S14ID, O99.SUnitPrice14
			, O99.S15ID, O99.SUnitPrice15
			, O99.S16ID, O99.SUnitPrice16
			, O99.S17ID, O99.SUnitPrice17
			, O99.S18ID, O99.SUnitPrice18
			, O99.S19ID, O99.SUnitPrice19
			, O99.S20ID, O99.SUnitPrice20
		'
	END
	
	SET @sSQL2 = @sSQL2 + '
		LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2002.DivisionID AND O99.VoucherID = OT2002.SOrderID AND O99.TransactionID = OT2002.TransactionID'
END

SET @sSQL3 = @sSQL12 +'
		INNER JOIN OT2002 WITH (NOLOCK) on OT2001.DivisionID = OT2002.DivisionID and OT2001.SOrderID = OT2002.SOrderID
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OT2002.APKMaster_9000 = OOT90.APK
        LEFT JOIN AT1302 on AT1302.InventoryID = OT2002.InventoryID 
		LEFT JOIN AT1304 T04  With (NOLOCK) on OT2002.UnitID = T04.UnitID
		LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = OT2002.Ana01ID AND T01.AnaTypeID = ''A01''
		LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = OT2002.Ana02ID AND T02.AnaTypeID = ''A02''
		LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = OT2002.Ana03ID AND T03.AnaTypeID = ''A03''
		LEFT JOIN AT1011 T004 WITH (NOLOCK) ON T004.AnaID = OT2002.Ana04ID AND T004.AnaTypeID = ''A04''
		LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = OT2002.Ana05ID AND T05.AnaTypeID = ''A05''
		LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = OT2002.Ana06ID AND T06.AnaTypeID = ''A06''
		LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = OT2002.Ana07ID AND T07.AnaTypeID = ''A07''
		LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = OT2002.Ana08ID AND T08.AnaTypeID = ''A08''
		LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = OT2002.Ana09ID AND T09.AnaTypeID = ''A09''
		LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = OT2002.Ana10ID AND T10.AnaTypeID = ''A10'' 
		'+ 
		@sSQL13 +
		@sSQLJon
SET @sSQL4 = '
       '+@Swhere+' 
		'+@sSQL14+'
		'+ @sGroup +'
		Order By OT2002.Orders
		'

IF @Mode = 1
BEGIN
	SET @sSQL4 = @sSQL4+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END

EXEC (@sSQL+ @sSQL1+ @sSQL3+@sSQL2+ @sSQL4)

print (@sSQL)
print (@sSQL1)
print (@sSQL3)
print (@sSQL2)
print (@sSQL4)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

