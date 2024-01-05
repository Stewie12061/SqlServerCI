IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20205]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20205]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Load Grid Form Lưới detail xem chi tiết báo giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 05/05/2017 
----Modified by Tấn Phú on 04/07/2019: bổ sung Lập báo giá kế thừa từ yêu cầu mua hàng (Đức Tin)
----Modified by Kiều Nga on 08/07/2019: bổ sung Duyệt báo giá
----Modified by Kiều Nga on 13/04/2020: Lấy thêm trường tỷ giá cho báo giá Sale (DTI)
----Modified by Bảo Toàn on 26/04/2020: Lấy đơn giá từ bảng giá (DTI)
----Modified by Nhựt Trường on 09/08/2021: Điều chỉnh lấy ExchangeRate từ OT2102 thay vì OT2101 khi tính toán giá trị cột ConvertedAmount.
----Modified by Nhựt Trường on 09/08/2021: Bỏ số lẻ phần thập phân ở trường ConvertedAmount.
----Modified by Nhật Thanh on 17/08/2022: DTI load mọi loại phiếu báo giá điều lấy dữ liệu từ detail phiếu, không lấy từ bảng giá
----Modified by Thanh Lượng on 20/09/2022: Bổ sung thêm một số điều kiện để load lưới tính tổng thông tin phiếu báo giá không bị lỗi (DTI)
-- <Example>
----    EXEC SOP20205 'DTI','2977ed14-c8b7-478f-abf8-ede2ff241a94','b964c015-c496-494b-8cb8-33818d32a7ca','PBG'
----
CREATE PROCEDURE SOP20205 ( 
        	@DivisionID nvarchar(50),
			@QuotationID nvarchar(50),
			@APKMaster VARCHAR(50) = '',
			@Type VARCHAR(50) = '',
			@Mode INT = 0, ---- 0 Edit, 1 view
			@PageNumber INT = 1,
			@PageSize INT = 25) 
AS 

DECLARE @sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sSQL4 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@TotalRow VARCHAR(50),
		@OrderBy NVARCHAR(500),
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@sSQLJon NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@CustomerName int

select @CustomerName = CustomerName from CustomerIndex
set @sSQL2 =''
SET @sSQL1 =''
SET @sWhere ='' 
       
--SET @sWhere = ' 1 = 1 '
--SET @OrderBy = 'OT2001.DivisionID, OT2001.OrderDate, OT2001.VoucherNo'

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@Type, '') = 'PBG' 
BEGIN
SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),OT2102.APKMaster_9000)= '''+@APKMaster+''''
--SELECT  @Level = MAX(ApproveLevel) FROM OT2102 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster AND DivisionID = @DivisionID
SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50),APKMaster) = @APKMaster
END
ELSE 
BEGIN
SET @Swhere = @Swhere + 'AND OT2102.QuotationID = '''+@QuotationID+''''
--SELECT  @Level = MAX(ApproveLevel) FROM OT2102 WITH (NOLOCK) WHERE QuotationID = @QuotationID AND DivisionID = @DivisionID
SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN OT2101 ON CONVERT(VARCHAR(50),OOT9001.APKMaster) = OT2101.APKMaster_9000  WHERE CONVERT(VARCHAR(50), OT2101.APK) = @QuotationID
END

	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , APK9001'+@s+', Status'+@s+', Approvel'+@s+'Note, ApprovalDate'+@s+''
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
						AND CASE WHEN ISNULL(CONVERT(Varchar (50),APP'+@s+'.APK2001),'''') <> '''' THEN APP'+@s+'.APK2001 ELSE OT2102.APK END = OT2102.APK '
		SET @i = @i + 1		
	END	

SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY OT2102.Orders) AS RowNum, '+@TotalRow+' AS TotalRow,OT2102.APK,OT2102.QuotationID, 
 OT2102.TransactionID,  
 AT1302.InventoryName, 
 OT2102.InventoryID, 
 Isnull(OT2102.UnitID,AT1302.UnitID) as  UnitID,
 ISNULL(OT2102.QuoQuantity,0) as QuoQuantity,  
 CASE WHEN '+ Cast(@CustomerName as varchar(20)) +'=114 OR OT2101.ClassifyID = ''SALE''
		THEN 
			OT2102.UnitPrice
		ELSE
			T1302.UnitPrice 
		END AS UnitPrice,
 CASE WHEN '+ Cast(@CustomerName as varchar(20)) +'=114 OR OT2101.ClassifyID = ''SALE''
		THEN 
			(Case when ISNULL(OT2102.Coefficient,0) > 0 then OT2102.UnitPrice * OT2102.Coefficient else OT2102.UnitPrice end)
		ELSE
			(Case when ISNULL(OT2102.Coefficient,0) > 0 then T1302.UnitPrice * OT2102.Coefficient else T1302.UnitPrice end)
		END AS  UnitPriceCof, 
 CASE WHEN '+ Cast(@CustomerName as varchar(20)) +'=114 OR OT2101.ClassifyID = ''SALE''
		THEN 
			(OT2102.UnitPrice * OT2102.QuoQuantity * ISNULL(OT2102.Coefficient,1))
		ELSE
			(T1302.UnitPrice * OT2102.QuoQuantity * ISNULL(OT2102.Coefficient,1))
		END AS OriginalAmount, 
 OT2102.VATPercent,  
 OT2102.Notes, 
 ISNULL(OT2102.VATOriginalAmount,0) VATOriginalAmount, 
 ISNULL(OT2102.DiscountPercent,0) DiscountPercent, 
 ISNULL(OT2102.DiscountOriginalAmount,0) DiscountOriginalAmount, 
 OT2102.Orders, 
 CASE WHEN '+ Cast(@CustomerName as varchar(20)) +'=114 OR OT2101.ClassifyID = ''SALE''
		THEN 
			ROUND((Case when ISNULL(OT2102.Coefficient,0) > 0 then OT2102.UnitPrice * OT2102.Coefficient else OT2102.UnitPrice end) * ISNULL(OT2102.ExchangeRate, OT2101.ExchangeRate) * OT2102.QuoQuantity,0,0)
		ELSE
			ROUND((Case when ISNULL(OT2102.Coefficient,0) > 0 then T1302.UnitPrice * OT2102.Coefficient else T1302.UnitPrice end) * ISNULL(OT2102.ExchangeRate, OT2101.ExchangeRate) * OT2102.QuoQuantity,0,0)
		END AS ConvertedAmount,
 ISNULL(OT2102.VATConvertedAmount,0) VATConvertedAmount, 
 ISNULL(OT2102.DiscountConvertedAmount,0) DiscountConvertedAmount, 
 OT2102.Notes01,   
 OT2102.Notes02,
 OT2102.VATGroupID,
 T1010.VATGroupName,
 OT2102.finish ,
 OT2102.ConvertedQuantity, 
 OT2102.ConvertedSalepriceInput,
 OT2102.Markup,
 OT2102.DivisionID,
 OT2102.Barcode,
 OT2102.ReceiveDate,
 OT2102.Parameter01, OT2102.Parameter02, OT2102.Parameter03, OT2102.Parameter04, OT2102.Parameter05,
 OT2102.RequestPrice,
 OT2102.InheritTableID,
 OT2102.InheritVoucherID,
 OT2102.InheritTransactionID,
 OT2102.Ana01ID, T01.AnaName As Ana01Name, OT2102.Ana02ID, T02.AnaName As Ana02Name, OT2102.Ana03ID, T03.AnaName As Ana03Name,
 OT2102.Ana04ID, T004.AnaName As Ana04Name, OT2102.Ana05ID, T05.AnaName As Ana05Name,
 OT2102.Ana06ID, T06.AnaName As Ana06Name, OT2102.Ana07ID, T07.AnaName As Ana07Name, OT2102.Ana08ID, T08.AnaName As Ana08Name,
 OT2102.Ana09ID, T09.AnaName As Ana09Name, OT2102.Ana10ID, T10.AnaName As Ana10Name, OT2102.Coefficient, ISNULL(OT2102.Specification,AT1302.Specification) AS Specification,
 ISNULL(OT21.ExchangeRate,1) As ExchangeRate, 0 AS DiscountAmount
 '

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sSQL1 = @sSQL1 + ',
		O99.S01ID As STypeS01, O99.SUnitPrice01,
		O99.S02ID As STypeS02, O99.SUnitPrice02,
		O99.S03ID As STypeS03, O99.SUnitPrice03,
		O99.S04ID As STypeS04, O99.SUnitPrice04,
		O99.S05ID As STypeS05, O99.SUnitPrice05,
		O99.S06ID As STypeS06, O99.SUnitPrice06,
		O99.S07ID As STypeS07, O99.SUnitPrice07,
		O99.S08ID As STypeS08, O99.SUnitPrice08,
		O99.S09ID As STypeS09, O99.SUnitPrice09,		
		O99.S10ID As STypeS10, O99.SUnitPrice10,
		O99.S11ID As STypeS11, O99.SUnitPrice11,
		O99.S12ID As STypeS12, O99.SUnitPrice12,
		O99.S13ID As STypeS13, O99.SUnitPrice13,
		O99.S14ID As STypeS14, O99.SUnitPrice14,
		O99.S15ID As STypeS15, O99.SUnitPrice15,
		O99.S16ID As STypeS16, O99.SUnitPrice16,
		O99.S17ID As STypeS17, O99.SUnitPrice17,
		O99.S18ID As STypeS18, O99.SUnitPrice18,
		O99.S19ID As STypeS19, O99.SUnitPrice19,
		O99.S20ID As STypeS20, O99.SUnitPrice20 '
	
	SET @sSQL2 = @sSQL2 + '
		LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2102.DivisionID AND O99.VoucherID = OT2102.QuotationID AND O99.TransactionID = OT2102.TransactionID'
END

SET @sSQL3 = + @sSQLSL+'
		FROM OT2102 With (NOLOCK)
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OT2102.APKMaster_9000 = OOT90.APK
		LEFT JOIN AT1302  With (NOLOCK) on AT1302.InventoryID= OT2102.InventoryID
		INNER JOIN OT2101 With (NOLOCK) on OT2101.QuotationID = OT2102.QuotationID 
		LEFT JOIN AT1004  With (NOLOCK) ON AT1004.CurrencyID = OT2101.CurrencyID 
		LEFT JOIN AT1301  With (NOLOCK) on AT1301.InventoryTypeID = OT2101.InventoryTypeID 
		LEFT JOIN AT1304  With (NOLOCK) on AT1304.UnitID = AT1302.UnitID
		LEFT JOIN AT1304 T04  With (NOLOCK) on T04.UnitID = OT2102.UnitID
		LEFT JOIN AT1010 T1010  With (NOLOCK) on T1010.VATGroupID = OT2102.VATGroupID
		LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = OT2102.Ana01ID AND T01.AnaTypeID = ''A01''
		LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = OT2102.Ana02ID AND T02.AnaTypeID = ''A02''
		LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = OT2102.Ana03ID AND T03.AnaTypeID = ''A03''
		LEFT JOIN AT1011 T004 WITH (NOLOCK) ON T004.AnaID = OT2102.Ana04ID AND T004.AnaTypeID = ''A04''
		LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = OT2102.Ana05ID AND T05.AnaTypeID = ''A05''
		LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = OT2102.Ana06ID AND T06.AnaTypeID = ''A06''
		LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = OT2102.Ana07ID AND T07.AnaTypeID = ''A07''
		LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = OT2102.Ana08ID AND T08.AnaTypeID = ''A08''
		LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = OT2102.Ana09ID AND T09.AnaTypeID = ''A09''
		LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = OT2102.Ana10ID AND T10.AnaTypeID = ''A10'' 
		LEFT JOIN OT2101 OT21 With (NOLOCK) ON OT21.QuotationID = OT2102.InheritVoucherID 
		LEFT JOIN OT1302 T1302 With (NOLOCK) ON OT2101.PriceListID = T1302.ID AND OT2102.InventoryID = T1302.InventoryID		
		'
		+@sSQLJon

SET @sSQL4 = '
       Where OT2102.DivisionID = '''+@DivisionID+'''' + @sWhere+'
	   Order By OT2102.Orders'
IF @Mode = 1
BEGIN
	SET @sSQL4 = @sSQL4+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END

print @sSQL
print @sSQL1
print @sSQL3
print @sSQL2
print @sSQL4
EXEC (@sSQL+ @sSQL1+ @sSQL3+@sSQL2+ @sSQL4)









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
