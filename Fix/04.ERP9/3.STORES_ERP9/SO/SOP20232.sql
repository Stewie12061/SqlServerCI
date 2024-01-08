IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20232]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20232]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load Grid Detail Form SOF2023 Kế thừa phiếu báo giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phan thanh hoàng vũ, Date: 23/03/2017
----Updated by: Bảo Toàn, Date: 05/12/2019 | Customize MAITHU
----Updated by: Bảo Toàn, Date: 25/05/2020 | Customize Đức Tín. Tính lại tiền qui đổi (bổ sung nhân tỷ giá)
----Updated by: Kiều Nga, Date: 01/07/2020: Load thông tin quy cách
----Updated by: Kiều Nga, Date: 07/07/2020: Load thông tin tên mã phân tích
----Updated by: Đình Hòa, Date: 12/01/2021: Load trường ngày ký hợp đồng để hiển thị khi kế thừa
----Updated by: Văn Tài , Date: 29/06/2021: Customize [DUCTIN] Kế thừa tính tại thành tiền, quy đối.
----Updated by Đình Hòa, Date 07/07/2021 : Kiểm tra số lượng mặt hàng của phiếu báo giá đã được kế thừa hết thì không hiển thị.
----Updated by Nhựt Trường, Date 10/08/2021: Điều chỉnh cách lấy thành tiền và thành tiền quy đổi.
----Updated by Kiều Nga, Date 17/01/2022: Fix Lỗi phiếu báo giá có mặt hàng không được duyệt nhưng vẫn kế thừa qua đơn hàng bán được
----Updated by Hoài Bảo, Date 08/04/2022: Fix Lỗi phiếu báo giá cấp duyệt = 0 không lưu thông tin chi tiết dữ liệu duyệt vào bảng OOT9004 -> không kế thừa qua đơn hàng bán được
----Updated by Hoàng Long, Date 20/06/2023: Fix Lỗi phiếu báo giá không giảm số lượng mặt hàng khi kế thừa
----Updated by Hoàng Long, Date 11/07/2023: Fix Lỗi phiếu báo giá số lượng mặt hàng khi kế thừa bị sai

-- <Example> EXEC SOP20232 'AS' , 'VoucherNo' , 'NV01' ,1 ,20

Create PROCEDURE SOP20232
(
    @DivisionID VARCHAR(50), --Biến môi trường
    @APKList VARCHAR(MAX),	 --Giá trị chọn trên lưới master
	@UserID  VARCHAR(50),	 --Biến môi trường
	@PageNumber INT,		
	@PageSize INT			 --Biến môi trường
)
AS

	DECLARE @sSQL NVARCHAR(MAX) =N'',
			@sSQL2 NVARCHAR(MAX) =N'',
			@sWhere AS NVARCHAR(4000),
			@OrderBy NVARCHAR(500),
			@TotalRow NVARCHAR(50),
			@sSQLSL NVARCHAR(MAX) =N'',
			@sJoin NVARCHAR(MAX) =N'',
			@CustomerIndex INT = -1

	SET @CustomerIndex = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK))

	SET @sWhere = ' '
	SET @TotalRow = ''
	SET @OrderBy = ' D.Orders '

	IF @PageNumber = 1 
		SET @TotalRow = 'COUNT(*) OVER ()' 
	ELSE 
		SET @TotalRow = 'NULL'


	IF Isnull(@DivisionID, '') != ''
		SET @sWhere = @sWhere + ' D.DivisionID ='''+@DivisionID+''''
		
	IF Isnull(@APKList, '') != ''
		SET @sWhere = @sWhere + ' And D.QuotationID IN ('+@APKList+')'

	-- Lấy thông tin hợp đồng
	SET @sSQLSL = @sSQLSL +',A20.ContractNo, A20.SignDate, CONVERT(VARCHAR(50),A20.SignDate,103) AS ContractDate ';

	SET @sJoin = @sJoin +' LEFT JOIN AT1031 A31 WITH (NOLOCK) ON D.TransactionID = A31.InheritTransactionID
	LEFT JOIN AT1020 A20 WITH (NOLOCK) ON A31.ContractID = A20.ContractID'
		
    IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	BEGIN
		SET @sSQLSL = @sSQLSL + ',
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
	
		SET @sJoin = @sJoin + '
			LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = D.DivisionID AND O99.VoucherID = D.QuotationID AND O99.TransactionID = D.TransactionID'
	END

	-- Khách hàng DUCTIN + MAITHU
	IF(@CustomerIndex = 114 OR @CustomerIndex = 117)
	BEGIN
		SET @sSQL = N'Select ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, 0 AS RowNum
							, D.APK
							, M.APK AS APKMaster
							, D.DivisionID
							, D.TransactionID
							, D.QuotationID
							, D.InventoryID
							, ISNULL(D.InventoryCommonName, D1.InventoryName) AS InventoryName
							, D.QuoQuantity
							, D.UnitPrice * ISNULL(D.Coefficient,1) AS UnitPrice
							, CASE WHEN M.CurrencyID = ''VND'' THEN D.OriginalAmount ELSE D.QuoQuantity * D.UnitPrice * ISNULL(D.Coefficient,1) END AS OriginalAmount
							, CASE WHEN M.CurrencyID = ''VND'' THEN D.ConvertedAmount ELSE D.QuoQuantity * D.UnitPrice * ISNULL(M.ExchangeRate, 1) * ISNULL(D.Coefficient, 1) END AS ConvertedAmount
							, D.Notes
							, D.VATPercent
							, D.VATConvertedAmount
							, D.VATOriginalAmount
							, D.UnitID
							, T04.UnitName
							, D.Orders
							, D.DiscountPercent
							, D.DiscountAmount
							, D.DiscountOriginalAmount
							, D.DiscountConvertedAmount
							, T1010.VATGroupName
							, D.Ana03ID
							, D.Ana02ID
							, D.Ana01ID
							, D.Notes01
							, D.Notes02
							, D.Ana04ID
							, D.Ana05ID
							, D.VATGroupID
							, D.Finish
							, D.ConvertedQuantity
							, D.ConvertedSalePrice
							, D.Barcode
							, D.Markup
							, D.OriginalAmountOutput
							, D.ConvertedSalepriceInput
							, D.ReceiveDate
							, D.Ana06ID
							, D.Ana07ID
							, D.Ana08ID
							, D.Ana09ID
							, D.Ana10ID
							, D.Parameter01
							, D.Parameter02
							, D.Parameter03
							, D.Parameter04
							, D.Parameter05
							, D.QuoQuantity01
							, D.QD01
							, D.QD02
							, D.QD03
							, D.QD04
							, D.QD05
							, D.QD06
							, D.QD07
							, D.QD08
							, D.QD09
							, D.QD10
							, M.ClassifyID
							, ISNULL(D.Specification, D1.Specification) AS Specification
							--, D.Orders
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
							' +@sSQLSL +''


		SET @sSQL2 = N'
						FROM OT2101 M WITH (NOLOCK) 
							inner join OT2102 D  WITH (NOLOCK) On M.DivisionID = D.DivisionID 
																	AND M.QuotationID = D.QuotationID
								Left join AT1302 D1  WITH (NOLOCK) on D1.DivisionID IN (''@@@'', M.DivisionID) 
																	AND D1.InventoryID = D.InventoryID
								LEFT JOIN AT1010 T1010  With (NOLOCK) on T1010.VATGroupID = D.VATGroupID
								LEFT JOIN AT1304 T04 WITH (NOLOCK) on D.UnitID = T04.UnitID
								LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = D.Ana01ID AND T01.AnaTypeID = ''A01''
								LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = D.Ana02ID AND T02.AnaTypeID = ''A02''
								LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = D.Ana03ID AND T03.AnaTypeID = ''A03''
								LEFT JOIN AT1011 T004 WITH (NOLOCK) ON T004.AnaID = D.Ana04ID AND T004.AnaTypeID = ''A04''
								LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = D.Ana05ID AND T05.AnaTypeID = ''A05''
								LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = D.Ana06ID AND T06.AnaTypeID = ''A06''
								LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = D.Ana07ID AND T07.AnaTypeID = ''A07''
								LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = D.Ana08ID AND T08.AnaTypeID = ''A08''
								LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = D.Ana09ID AND T09.AnaTypeID = ''A09''
								LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = D.Ana10ID AND T10.AnaTypeID = ''A10'' 
								LEFT JOIN OOT9004 OT94 WITH (NOLOCK) ON D.APK = OT94.APKDetail AND D.ApproveLevel = OT94.Level
								'
								+@sJoin+
					'
					WHERE '+@sWhere+' AND M.Status = 1 AND ISNULL(OT94.Status,1) = 1 AND D.ApproveLevel = D.ApprovingLevel
					ORDER BY '+@OrderBy+'
					OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
					FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
	ELSE 
	BEGIN
		SET @sSQL = 'Select ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, 0 AS RowNum
							, D.APK
							, M.APK AS APKMaster
							, D.DivisionID
							, D.TransactionID
							, D.QuotationID
							, D.InventoryID
							, ISNULL(D.InventoryCommonName, D1.InventoryName) AS InventoryName
							, (D.QuoQuantity - ISNULL(O2.OrderQuantity, 0)) AS QuoQuantity
							, D.UnitPrice * ISNULL(D.Coefficient, 1) AS UnitPrice
							, CASE WHEN M.CurrencyID = ''VND'' THEN D.OriginalAmount ELSE D.QuoQuantity * D.UnitPrice * ISNULL(D.Coefficient,1) END AS OriginalAmount
							, CASE WHEN M.CurrencyID = ''VND'' THEN D.ConvertedAmount ELSE D.QuoQuantity * D.UnitPrice * ISNULL(M.ExchangeRate, 1) * ISNULL(D.Coefficient, 1) END AS ConvertedAmount
							, D.Notes
							, D.VATPercent
							, D.VATConvertedAmount
							, D.VATOriginalAmount
							, D.UnitID
							, T04.UnitName
							, D.Orders
							, D.DiscountPercent
							, D.DiscountAmount
							, D.DiscountOriginalAmount
							, D.DiscountConvertedAmount
							, T1010.VATGroupName
							, D.Ana03ID
							, D.Ana02ID
							, D.Ana01ID
							, D.Notes01
							, D.Notes02
							, D.Ana04ID
							, D.Ana05ID
							, D.VATGroupID
							, D.Finish
							, D.ConvertedQuantity
							, D.ConvertedSalePrice
							, D.Barcode
							, D.Markup
							, D.OriginalAmountOutput
							, D.ConvertedSalepriceInput
							, D.ReceiveDate
							, D.Ana06ID
							, D.Ana07ID
							, D.Ana08ID
							, D.Ana09ID
							, D.Ana10ID
							, D.Parameter01
							, D.Parameter02
							, D.Parameter03
							, D.Parameter04
							, D.Parameter05
							, D.QuoQuantity01
							, D.QD01
							, D.QD02
							, D.QD03
							, D.QD04
							, D.QD05
							, D.QD06
							, D.QD07
							, D.QD08
							, D.QD09
							, D.QD10
							, M.ClassifyID
							, ISNULL(D.Specification, D1.Specification) AS Specification
							--, D.Orders
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
							' +@sSQLSL +''

		SET @sSQL2 = N'
						FROM OT2101 M WITH (NOLOCK) 
									inner join OT2102 D  WITH (NOLOCK) On M.DivisionID = D.DivisionID AND M.QuotationID = D.QuotationID
									Left join (
						 				SELECT	InheritVoucherID, InventoryID,DivisionID, Sum(OrderQuantity) as OrderQuantity FROM OT2002
						 				WHERE InheritVoucherID = ('+@APKList+')
						 				GROUP BY InheritVoucherID, InventoryID, DivisionID 
						 				) 
						 			AS O2 ON D.DivisionID = O2.DivisionID		
								 	AND D.QuotationID = O2.InheritVoucherID 
								  	AND D.InventoryID = O2.InventoryID 
									Left join AT1302 D1  WITH (NOLOCK) on D1.DivisionID IN (''@@@'', M.DivisionID) AND D1.InventoryID = D.InventoryID
									LEFT JOIN AT1010 T1010  With (NOLOCK) on T1010.VATGroupID = D.VATGroupID
									LEFT JOIN AT1304 T04 WITH (NOLOCK) on D.UnitID = T04.UnitID
									LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = D.Ana01ID AND T01.AnaTypeID = ''A01''
									LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = D.Ana02ID AND T02.AnaTypeID = ''A02''
									LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = D.Ana03ID AND T03.AnaTypeID = ''A03''
									LEFT JOIN AT1011 T004 WITH (NOLOCK) ON T004.AnaID = D.Ana04ID AND T004.AnaTypeID = ''A04''
									LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = D.Ana05ID AND T05.AnaTypeID = ''A05''
									LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = D.Ana06ID AND T06.AnaTypeID = ''A06''
									LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = D.Ana07ID AND T07.AnaTypeID = ''A07''
									LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = D.Ana08ID AND T08.AnaTypeID = ''A08''
									LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = D.Ana09ID AND T09.AnaTypeID = ''A09''
									LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = D.Ana10ID AND T10.AnaTypeID = ''A10'' 
									LEFT JOIN OOT9004 OT94 WITH (NOLOCK) ON D.APK = OT94.APKDetail AND D.ApproveLevel = OT94.Level
									'
									+@sJoin+
						'
						WHERE '+@sWhere+' AND M.Status = 1 AND ISNULL(OT94.Status,1) = 1 AND D.ApproveLevel = D.ApprovingLevel AND ISNULL(O2.OrderQuantity,0) < D.QuoQuantity
						ORDER BY '+@OrderBy+'
						OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
						FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

	END

	PRINT (@sSQL)
	PRINT (@sSQL2)

	Exec (@sSQL + @sSQL2)
	




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
