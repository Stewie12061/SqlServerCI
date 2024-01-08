IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid: màn hình kế thừa yêu cầu mua hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Như Hàn on 10/12/2018
----Modified by Như Hàn on 18/03/2019: Bổ sung lấy giá từ báo giá nhà cung cấp (nếu có)
----Modified by Bảo Toàn on 25/04/2020: Bổ sung mã phân tích mặt hàng số 03
----Modified by Bảo Toàn on 25/06/2020: Sắp xếp thứ tự kế thừa YÊU CẦU MUA HÀNG theo thứ tự lúc nhập.
----Modified by Hoài Thanh on 23/09/2022: Lấy thêm cột số lượng tồn kho InventoryQuantity.
----Modified by Viết Toàn on 28/04/2023: Cải tiến tốc độ
----Modified by Thanh Lượng on 11/07/2023: [2023/07/IS/0035] - Tính toán lại số lượng khi kế thừa từ màn hình đơn hàng mua PO (Customize GREE).
----Modified by Thanh Lượng on 28/07/2023: [2023/07/IS/0293] - Bổ sung thêm điều kiện trước khi tính toán lại số lượng(Nếu chưa được kế thừa sẽ giữ số lượng cũ)(Customize GREE).
----Modified by Đức Tuyên on 17/08/2023: Bổ sung hiển thị mã phân tích mặt hàng customize INNOTEK.
----Modified by:Hoàng Long on 15/09/2023: Bổ sung trường số PO
----Modified by Hồng Thắm  on 13/10/2023 : fix lấy dữ liệu khi phân trang 
----Modified by Đình Định on 28/11/2023: Đức Tín - Xóa dấu ngoặc kép dư trong trường hợp VoucherNo chứa dấu phẩy.
----Modified by Đức Tuyên on 29/11/2023: Bổ sung quy cách + đơn vị tính quy đổi.
----Modified by Đình Định on 30/11/2023: Đức Tín - Replace ; thành , để phân biệt dấu phẩy ngăn cách list VoucherNo.
-- <Example>
---- 
/*-- <Example>
	POP2006 @DivisionID = 'AIC', @UserID = '', @PageNumber = 1, @PageSize = 25, @ROrderID = 'sfasdf'
	POP2006 @DivisionID, @UserID, @PageNumber, @PageSize, @ROrderID

----*/

CREATE PROCEDURE POP2006
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,	 
	 @ROrderID NVARCHAR(MAX),
	 @Mode INT = 0,
	 @ScreenID NVARCHAR(250) ='',
	 @PriceListID NVARCHAR(MAX) = '',
     @CurrencyID NVARCHAR(50) = '',
	 @VoucherDate NVARCHAR(50) = ''
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sSQL11 NVARCHAR(MAX) = N'',		
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@sSQL2 NVARCHAR(MAX) = N'',
		@sSQLSL NVARCHAR(MAX) =N'',
		@sSQLSL1 NVARCHAR(MAX) =N'',
	    @sJoin NVARCHAR(MAX) =N'',
		@CustomerIndex INT = (SELECT Customername FROM Customerindex WITH (NOLOCK)),
		@RequestPrice  NVARCHAR(MAX) =N'',
		@IsConvertedUnit AS TINYINT,
		@sWhere2 NVARCHAR(MAX) = N'',
		@sHavingSum NVARCHAR(MAX) = N''
--CREATE TABLE #OT3101 (ROrderID VARCHAR(50))
--INSERT INTO #OT3101 (ROrderID)
--SELECT X.Data.query('ROrderID').value('.', 'NVARCHAR(50)') AS ROrderID
--FROM @ROrderID.nodes('//Data') AS X (Data)

SET @OrderBy = 'T1.VoucherNo, T2.InventoryID'

IF @CustomerIndex = 114
BEGIN
	SET @OrderBy = 'T2.Orders'
	SET @ROrderID = REPLACE(@ROrderID, ';', ',')
END

SET @TotalRow = 'COUNT(*) OVER ()' 

IF(@ScreenID = 'POF2001')
BEGIN
	-- Lấy thông tin hợp đồng
	SET @sSQLSL = @sSQLSL +',A20.ContractNo';

	SET @sJoin = @sJoin +' LEFT JOIN AT1031 A31 WITH (NOLOCK) ON T2.TransactionID = A31.InheritTransactionID
	LEFT JOIN AT1020 A20 WITH (NOLOCK) ON A31.ContractID = A20.ContractID'
	
	--SET @sWhere = @sWhere +' 
	---- AND A20.ContractNo IS NOT NULL 
	--'
	-- Lấy thông tin nhà cung câp
	SET @sSQLSL = @sSQLSL +',T12.ObjectID,T12.ObjectName';

	SET @sJoin = @sJoin +'
	LEFT JOIN POT2021 P21 WITH (NOLOCK) ON P21.APK = T22.APKMaster
	LEFT JOIN AT1202 T12 WITH (NOLOCK) ON P21.ObjectID = T12.ObjectID'
	SET @sHavingSum = ''
IF @CustomerIndex = 162
BEGIN
	SET @sHavingSum = @sHavingSum + 'HAVING SUM(CASE WHEN OT22.InheritTableID = ''OT3101''THEN OT22.OrderQuantity ELSE 1 END) < T2.OrderQuantity'
END
	
END
ELSE IF(@ScreenID = 'SOF2021' OR @ScreenID = 'SOF2061A' OR @ScreenID = 'SOF2061C' )
BEGIN
	---Lấy thông tin khách hàng từ Yêu cầu báo giá, cơ hội
	SET @sSQLSL = @sSQLSL +',A.AccountID, A.AccountName,A.OpportunityID,A.OpportunityName';

	SET @sJoin = @sJoin +' LEFT JOIN (
	select PT01.MemberID as AccountID, PT01.MemberName as AccountName,CT51.OpportunityName, CT01.*
	from CRMT20801 CT01
	INNER JOIN CRMT20801_CRMT10101_REL CT02 ON CT02.RequestID = CT01.RequestID
	LEFT JOIN CRMT20501 CT51 ON CT01.OpportunityID = CT51.OpportunityID
	LEFT JOIN POST0011 PT01 ON PT01.APK = CT02.AccountID

	UNION ALL

	select CT51.AccountID, PT01.MemberName ,CT51.OpportunityName,CT01.* 
	from CRMT20801 CT01 
	LEFT JOIN CRMT20501 CT51 ON CT01.OpportunityID = CT51.OpportunityID
	LEFT JOIN POST0011 PT01 ON PT01.MemberID = CT51.AccountID
	where CT01.APK NOT IN (select CT01.APK
						from CRMT20801 CT01 
						INNER JOIN CRMT20801_CRMT10101_REL CT02 ON CT02.RequestID = CT01.RequestID
						LEFT JOIN POST0011 PT01 ON PT01.APK = CT02.AccountID)) A ON T1.RequestID = A.APK'
END
ELSE IF (@ScreenID = 'SOF2061A' OR @ScreenID = 'SOF2061C')
BEGIN  -- đơn giá null lấy theo bảng giá bán
   SET @IsConvertedUnit = (SELECT TOP 1 ISNULL(IsConvertUnit,0) AS IsConvertUnit FROM OT0000 WHERE DivisionID = @DivisionID)

   SET @sSQL11 = @sSQL11 + 'SELECT AT1302.InventoryID , ISNULL((CASE WHEN AV1004.Operator = 0 
			THEN ISNULL((CASE WHEN '''+LTRIM(@IsConvertedUnit)+''' = ''0'' 
							THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
							ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), AT1302.SalePrice01)* ISNULL(AV1004.ExchangeRate, 1) 
			ELSE ISNULL((CASE WHEN '''+LTRIM(@IsConvertedUnit)+''' = ''0'' 
							THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
							ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), AT1302.SalePrice01)/ ISNULL(AV1004.ExchangeRate, 1) END),0)   as SalePrice
						Into #tbSalePrice
						FROM AT1302 WITH (NOLOCK)
						Left join AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
						FULL JOIN OT1302 WITH (NOLOCK) ON AT1302.InventoryID = OT1302.InventoryID AND OT1302.ID = ''' + ISNULL(@PriceListID, '') + '''
						LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.ID = OT1302.DetailID AND OT1312.DivisionID = OT1302.DivisionID AND OT1312.PriceID = ''' + ISNULL(@PriceListID, '') + '''
						LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = ''' + ISNULL(@PriceListID, '') + '''
						LEFT JOIN (
									SELECT AV1004.CurrencyID,AV1004.DivisionID, AV1004.Operator, 
										COALESCE(AT1012.ExchangeRate,AV1004.ExchangeRate) AS ExchangeRate
									FROM AV1004
									LEFT JOIN (
												SELECT Top 1 DivisionID , CurrencyID, ExchangeRate, ExchangeDate
												FROM AT1012 
												WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),@VoucherDate,101) + ''') >= 0
												ORDER BY ExchangeDate DESC
											  )AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
								   ) AV1004 ON AV1004.CurrencyID = '''+@CurrencyID+'''

						WHERE AT1302.DivisionID in ('''+@DivisionID+''' , ''@@@'') and AT1302.Disabled = 0
						ORDER BY AT1302.InventoryID, AT1302.InventoryName'

   SET @sJoin = @sJoin +' 
   LEFT JOIN #tbSalePrice tbsale On tbsale.InventoryID = T2.InventoryID'

   SET @sSQLSL = @sSQLSL + ' ,ISNULL(T2.RequestPrice, tbsale.SalePrice) '
   SET @sSQLSL1 = @sSQLSL1 + ' As RequestPrice'

END

IF(@ScreenID !='POF2031')
BEGIN
	SET @sWhere = @sWhere + '  AND T1.Status = 1  '
END

IF(ISNULL(@Mode,0) = 1)
BEGIN
	SET @sSQLSL = @sSQLSL + ' , T2.RequestPrice '
	SET @sSQLSL1 = @sSQLSL1 + ' As RequestPrice '

	SET @sSQL = @sSQL + N'
	SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
	T1.APK APKMaster,
	T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
	T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
	T2.UnitID, T04.UnitName, T2.Notes, 
	T2.Ana01ID, T11.AnaName As Ana01Name, T2.Ana02ID, T21.AnaName As Ana02Name, 
	T2.Ana03ID, T31.AnaName As Ana03Name, T2.Ana04ID, T41.AnaName As Ana04Name, 
	T2.Ana05ID, T51.AnaName As Ana05Name, T2.Ana06ID, T61.AnaName As Ana06Name, T2.Ana07ID, T71.AnaName As Ana07Name, 
	T2.Ana08ID, T81.AnaName As Ana08Name, T2.Ana09ID, T91.AnaName As Ana09Name, T2.Ana10ID, T10.AnaName As Ana10Name,T2.Specification,T2.Orders
	,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description as DescriptionDetail, T2.Notes01,T2.Notes02,T2.PONumber 
	, T2.UnitID, T04.UnitName, T2.ConvertedQuantity, T2.ConvertedSalePrice
	, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID
	, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
	, T2.Parameter01, T2.Parameter02, T2.Parameter03, T2.Parameter04, T2.Parameter05
	, T2.ConvertedUnitID, WQ09.ConversionFactor, WQ09.DataType, WQ09.Operator, WQ09.FormulaDes
	'
	+@sSQLSL+ @sSQLSL1+'
	FROM OT3101 T1 WITH(NOLOCK)
	INNER JOIN OT3102 T2 WITH(NOLOCK) ON T1.ROrderID = T2.ROrderID AND T1.DivisionID = T2.DivisionID
	LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID 
	LEFT JOIN OT0099 T99 WITH(NOLOCK) ON T1.PriorityID = T99.ID AND T99.CodeMaster = ''PriorityID''
	LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
	LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01'' 
	LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02'' 
	LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03'' 
	LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04'' 
	LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05'' 
	LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06'' 
	LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07'' 
	LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08'' 
	LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09'' 
	LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
	LEFT JOIN AT1010 A11 WITH (NOLOCK) ON T2.VATGroupID = A11.VATGroupID
	LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = T2.DivisionID AND O99.VoucherID = T2.ROrderID AND O99.TransactionID = T2.TransactionID
	LEFT JOIN WQ1309 WQ09 WITH (NOLOCK) ON WQ09.DivisionID IN (T2.DivisionID, ''@@@'') 
													AND WQ09.InventoryID = T2.InventoryID
													AND WQ09.ConvertedUnitID = T2.ConvertedUnitID
													--AND (WQ09.S01ID = O99.S01ID OR (ISNULL(WQ09.S01ID, '''') =  ISNULL(O99.S01ID, '''')))
													--AND (WQ09.S02ID = O99.S02ID OR (ISNULL(WQ09.S02ID, '''') =  ISNULL(O99.S02ID, '''')))
													--AND (WQ09.S03ID = O99.S03ID OR (ISNULL(WQ09.S03ID, '''') =  ISNULL(O99.S03ID, '''')))
													--AND (WQ09.S04ID = O99.S04ID OR (ISNULL(WQ09.S04ID, '''') =  ISNULL(O99.S04ID, '''')))
													--AND (WQ09.S05ID = O99.S05ID OR (ISNULL(WQ09.S05ID, '''') =  ISNULL(O99.S05ID, '''')))
													--AND (WQ09.S06ID = O99.S06ID OR (ISNULL(WQ09.S06ID, '''') =  ISNULL(O99.S06ID, '''')))
													--AND (WQ09.S07ID = O99.S07ID OR (ISNULL(WQ09.S07ID, '''') =  ISNULL(O99.S07ID, '''')))
													--AND (WQ09.S08ID = O99.S08ID OR (ISNULL(WQ09.S08ID, '''') =  ISNULL(O99.S08ID, '''')))
													--AND (WQ09.S09ID = O99.S09ID OR (ISNULL(WQ09.S09ID, '''') =  ISNULL(O99.S09ID, '''')))
													--AND (WQ09.S10ID = O99.S10ID OR (ISNULL(WQ09.S10ID, '''') =  ISNULL(O99.S10ID, '''')))
													--AND (WQ09.S11ID = O99.S11ID OR (ISNULL(WQ09.S11ID, '''') =  ISNULL(O99.S11ID, '''')))
													--AND (WQ09.S12ID = O99.S12ID OR (ISNULL(WQ09.S12ID, '''') =  ISNULL(O99.S12ID, '''')))
													--AND (WQ09.S13ID = O99.S13ID OR (ISNULL(WQ09.S13ID, '''') =  ISNULL(O99.S13ID, '''')))
													--AND (WQ09.S14ID = O99.S14ID OR (ISNULL(WQ09.S14ID, '''') =  ISNULL(O99.S14ID, '''')))
													--AND (WQ09.S15ID = O99.S15ID OR (ISNULL(WQ09.S15ID, '''') =  ISNULL(O99.S15ID, '''')))
													--AND (WQ09.S16ID = O99.S16ID OR (ISNULL(WQ09.S16ID, '''') =  ISNULL(O99.S16ID, '''')))
													--AND (WQ09.S17ID = O99.S17ID OR (ISNULL(WQ09.S17ID, '''') =  ISNULL(O99.S17ID, '''')))
													--AND (WQ09.S18ID = O99.S18ID OR (ISNULL(WQ09.S18ID, '''') =  ISNULL(O99.S18ID, '''')))
													--AND (WQ09.S19ID = O99.S19ID OR (ISNULL(WQ09.S19ID, '''') =  ISNULL(O99.S19ID, '''')))
													--AND (WQ09.S20ID = O99.S20ID OR (ISNULL(WQ09.S20ID, '''') =  ISNULL(O99.S20ID, '''')))

	'+@sJoin+'
	WHERE T1.DivisionID = '''+@DivisionID+''' 
	AND T2.ROrderID IN ('''+@ROrderID+''')                        
	--AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'')
	AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'') 
	'
	+@sWhere +
	'
	    GROUP BY T1.APK,
		T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
		T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
		T2.UnitID, T04.UnitName, T2.Notes, 
		T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
		T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
		T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, T2.Ana07ID, T71.AnaName, 
		T2.Ana08ID, T81.AnaName, T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,T2.OrderQuantity ,T2.Specification,T2.Orders
		,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description, T2.Notes01,T2.Notes02,T2.PONumber
		, T2.UnitID, T2.ConvertedQuantity, T2.ConvertedSalePrice
		, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID
		, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
		, T2.Parameter01, T2.Parameter02, T2.Parameter03, T2.Parameter04, T2.Parameter05
		, T2.ConvertedUnitID, WQ09.ConversionFactor, WQ09.DataType, WQ09.Operator, WQ09.FormulaDes
		'+@sSQLSL+'
	ORDER BY '+@OrderBy+' 
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

	IF @ScreenID <> 'SOF2021'
		SET @sWhere2 = @sWhere2 + ' AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'')'

	IF(@ScreenID ='SOF2021' OR @ScreenID = 'SOF2061A' OR @ScreenID = 'SOF2061C') --Tính toán lại số lượng khi kế thừa
		BEGIN
		SET @sSQL2 = @sSQL2 + ' UNION ALL
		SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.APK APKMaster,
		T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
		T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, (T2.OrderQuantity - SUM(OT21.QuoQuantity)) As OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
		T2.UnitID, T04.UnitName, T2.Notes, 
		T2.Ana01ID, T11.AnaName As Ana01Name, T2.Ana02ID, T21.AnaName As Ana02Name, 
		T2.Ana03ID, T31.AnaName As Ana03Name, T2.Ana04ID, T41.AnaName As Ana04Name, 
		T2.Ana05ID, T51.AnaName As Ana05Name, T2.Ana06ID, T61.AnaName As Ana06Name, T2.Ana07ID, T71.AnaName As Ana07Name, 
		T2.Ana08ID, T81.AnaName As Ana08Name, T2.Ana09ID, T91.AnaName As Ana09Name, T2.Ana10ID, T10.AnaName As Ana10Name ,T2.Specification ,T2.Orders 
		,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description as DescriptionDetail, T2.Notes01,T2.Notes02 '
		+@sSQLSL+ @sSQLSL1 +'
		FROM OT3101 T1 WITH(NOLOCK)
		INNER JOIN OT3102 T2 WITH(NOLOCK) ON T1.ROrderID = T2.ROrderID AND T1.DivisionID = T2.DivisionID
		LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID 
		LEFT JOIN OT0099 T99 WITH(NOLOCK) ON T1.PriorityID = T99.ID AND T99.CodeMaster = ''PriorityID''
		LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
		LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01'' 
		LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02'' 
		LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03'' 
		LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04'' 
		LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05'' 
		LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06'' 
		LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07'' 
		LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08'' 
		LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09'' 
		LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
		LEFT JOIN AT1010 A11 WITH (NOLOCK) ON T2.VATGroupID = A11.VATGroupID
		LEFT JOIN OT2102 OT21 WITH(NOLOCK) ON T2.TransactionID = OT21.InheritTransactionID AND T2.DivisionID = OT21.DivisionID And OT21.InheritTableID = ''OT3101''
		'+@sJoin+'
		WHERE T1.DivisionID = '''+@DivisionID+''' 
		AND T2.ROrderID IN ('''+@ROrderID+''')
		AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'')'
		+@sWhere +
		'
		GROUP BY T1.APK,
		T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
		T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
		T2.UnitID, T04.UnitName, T2.Notes, 
		T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
		T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
		T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, T2.Ana07ID, T71.AnaName, 
		T2.Ana08ID, T81.AnaName, T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,T2.OrderQuantity ,T2.Specification,T2.Orders
		,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description, T2.Notes01,T2.Notes02
		'+@sSQLSL+'
		HAVING SUM(OT21.QuoQuantity) < T2.OrderQuantity
		ORDER BY '+@OrderBy+' 
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
		'
		END

END
ELSE
BEGIN
	SET @sSQLSL = @sSQLSL + ' ,ISNULL(T22.UnitPrice, T2.RequestPrice) '
	SET @sSQLSL1 = @sSQLSL1 + ' As RequestPrice'

	IF @CustomerIndex = 151
	BEGIN
		SET @sSQL = @sSQL + N'
		SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.APK APKMaster,
		T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
		T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
		T2.UnitID, T04.UnitName, T2.Notes, 
		T2.Ana01ID, T11.AnaName As Ana01Name, T2.Ana02ID, T21.AnaName As Ana02Name, 
		T2.Ana03ID, T31.AnaName As Ana03Name, T2.Ana04ID, T41.AnaName As Ana04Name, 
		T2.Ana05ID, T51.AnaName As Ana05Name, T2.Ana06ID, T61.AnaName As Ana06Name, T2.Ana07ID, T71.AnaName As Ana07Name, 
		T2.Ana08ID, T81.AnaName As Ana08Name, T2.Ana09ID, T91.AnaName As Ana09Name, T2.Ana10ID, T10.AnaName As Ana10Name ,T2.Specification,T2.Orders
		,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description as DescriptionDetail, T2.Notes01,T2.Notes02
		'+@sSQLSL+@sSQLSL1+', T2.I03ID, T15.AnaName AS I03Name 
		--,(Select ISNULL(SUM(ISNULL(SignQuantity, 0)), 0) AS Quantity FROM AV7000 
	 --   WHERE AV7000.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AV7000.InventoryID = T2.InventoryID) AS InventoryQuantity
		FROM OT3101 T1 WITH(NOLOCK)
		INNER JOIN OT3102 T2 WITH(NOLOCK) ON T1.ROrderID = T2.ROrderID AND T1.DivisionID = T2.DivisionID
		LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID 
		LEFT JOIN OT0099 T99 WITH(NOLOCK) ON T1.PriorityID = T99.ID AND T99.CodeMaster = ''PriorityID''
		LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
		LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01''
		LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02''
		LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03''
		LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04''
		LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05''
		LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06''
		LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07''
		LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08''
		LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09''
		LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
		LEFT JOIN AT1015 T15 WITH(NOLOCK) ON T15.AnaID = T2.I03ID AND T15.AnaTypeID = ''I03''
		LEFT JOIN AT1010 A11 WITH (NOLOCK) ON T2.VATGroupID = A11.VATGroupID
		LEFT JOIN POT2022 T22 WITH(NOLOCK) ON T22.InheritAPKDetail = T2.APK AND T22.DivisionID = T2.DivisionID AND IsSelectPrice = 1
		'+@sJoin+'
		WHERE T1.DivisionID = '''+@DivisionID+''' 
		AND T2.ROrderID IN ('''+@ROrderID+''')
		--AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'') '
		 + 
		 CASE WHEN @ScreenID ='CIF1361' THEN ''  ----Khi hợp đồng kế thừa yêu cầu mua hàng
			  WHEN @ScreenID ='POF2041'  THEN ''
			  WHEN @ScreenID ='POF2001'  THEN ''
			  WHEN @ScreenID ='SOF2061A'  THEN ''
			  WHEN @ScreenID ='SOF2061C'  THEN ''
			  WHEN @ScreenID ='POF2031'  THEN ''
			ELSE 
		 '
		 AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'') '
		 END	
		+@sWhere +
		'
			GROUP BY T1.APK,
			T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
			T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, 
			T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
			T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
			T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, T2.Ana07ID, T71.AnaName, 
			T2.Ana08ID, T81.AnaName, T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,T2.OrderQuantity ,T2.Specification,T2.Orders
			,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description, T2.Notes01,T2.Notes02
			'+@sSQLSL+', T2.I03ID, T15.AnaName
		--ORDER BY '+@OrderBy+' 
		--OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		--FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
	ELSE IF (@CustomerIndex = 161)
	BEGIN
		SET @sSQL = @sSQL + N'
		---APK
		SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.APK APKMaster,
		T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
		T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, 
		CASE WHEN '''+@ScreenID+''' NOT IN (''SOF2021'',''SOF2061A'',''SOF2061C'') THEN (T2.OrderQuantity - SUM(ISNULL(OT22.OrderQuantity,0)))
		ELSE T2.OrderQuantity END AS OrderQuantity,
		T2.OriginalAmount, T2.ConvertedAmount, 
		T2.UnitID, T04.UnitName, T2.Notes, 
		T2.Ana01ID, T11.AnaName As Ana01Name, T2.Ana02ID, T21.AnaName As Ana02Name, 
		T2.Ana03ID, T31.AnaName As Ana03Name, T2.Ana04ID, T41.AnaName As Ana04Name, 
		T2.Ana05ID, T51.AnaName As Ana05Name, T2.Ana06ID, T61.AnaName As Ana06Name, T2.Ana07ID, T71.AnaName As Ana07Name, 
		T2.Ana08ID, T81.AnaName As Ana08Name, T2.Ana09ID, T91.AnaName As Ana09Name, T2.Ana10ID, T10.AnaName As Ana10Name ,T2.Specification,T2.Orders
		,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description as DescriptionDetail, T2.Notes01,T2.Notes02
		, T02.I01ID, AT01.AnaName As I01Name, T02.I02ID, AT02.AnaName As I02Name, T02.I03ID, AT03.AnaName As I03Name,T02.I04ID, AT04.AnaName As I04Name, T02.I05ID, AT05.AnaName As I05Name
		, T02.I06ID, AT06.AnaName As I06Name, T02.I07ID, AT07.AnaName As I07Name, T02.I08ID, AT08.AnaName As I08Name,T02.I09ID, AT09.AnaName As I09Name , T02.I10ID, AT10.AnaName As I10Name
		'+@sSQLSL+@sSQLSL1+' 
		--,(Select ISNULL(SUM(ISNULL(SignQuantity, 0)), 0) AS Quantity FROM AV7000 
	   -- WHERE AV7000.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AV7000.InventoryID = T2.InventoryID) AS InventoryQuantity
		FROM OT3101 T1 WITH(NOLOCK)
		INNER JOIN OT3102 T2 WITH(NOLOCK) ON T1.ROrderID = T2.ROrderID AND T1.DivisionID = T2.DivisionID
		LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID 
		LEFT JOIN OT0099 T99 WITH(NOLOCK) ON T1.PriorityID = T99.ID AND T99.CodeMaster = ''PriorityID''
		LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
		LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01''
		LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02''
		LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03''
		LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04''
		LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05''
		LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06''
		LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07''
		LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08''
		LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09''
		LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
		LEFT JOIN AT1015 AT01 WITH (NOLOCK) ON AT01.AnaID = T02.I01ID AND AT01.AnaTypeID = ''I01''
		LEFT JOIN AT1015 AT02 WITH (NOLOCK) ON AT02.AnaID = T02.I02ID AND AT02.AnaTypeID = ''I02''
		LEFT JOIN AT1015 AT03 WITH (NOLOCK) ON AT03.AnaID = T02.I03ID AND AT03.AnaTypeID = ''I03''
		LEFT JOIN AT1015 AT04 WITH (NOLOCK) ON AT04.AnaID = T02.I04ID AND AT04.AnaTypeID = ''I04''
		LEFT JOIN AT1015 AT05 WITH (NOLOCK) ON AT05.AnaID = T02.I05ID AND AT05.AnaTypeID = ''I05''
		LEFT JOIN AT1015 AT06 WITH (NOLOCK) ON AT06.AnaID = T02.I06ID AND AT06.AnaTypeID = ''I06''
		LEFT JOIN AT1015 AT07 WITH (NOLOCK) ON AT07.AnaID = T02.I07ID AND AT07.AnaTypeID = ''I07''
		LEFT JOIN AT1015 AT08 WITH (NOLOCK) ON AT08.AnaID = T02.I08ID AND AT08.AnaTypeID = ''I08''
		LEFT JOIN AT1015 AT09 WITH (NOLOCK) ON AT09.AnaID = T02.I09ID AND AT09.AnaTypeID = ''I09''
		LEFT JOIN AT1015 AT10 WITH (NOLOCK) ON AT10.AnaID = T02.I10ID AND AT10.AnaTypeID = ''I10''
		LEFT JOIN AT1010 A11 WITH (NOLOCK) ON T2.VATGroupID = A11.VATGroupID
		LEFT JOIN POT2022 T22 WITH(NOLOCK) ON T22.InheritAPKDetail = T2.APK AND T22.DivisionID = T2.DivisionID AND IsSelectPrice = 1
		LEFT JOIN OT3002 OT22 WITH(NOLOCK) ON T2.TransactionID = OT22.InheritTransactionID AND T2.DivisionID = OT22.DivisionID And OT22.InheritTableID = ''OT3101'' 
		'+@sJoin+'
		WHERE T1.DivisionID = '''+@DivisionID+''' 
		AND T2.ROrderID IN ('''+@ROrderID+''')
		 ' --+ @sWhere2
		 + 
		 CASE WHEN @ScreenID ='CIF1361' THEN ''  ----Khi hợp đồng kế thừa yêu cầu mua hàng
			  WHEN @ScreenID ='POF2041'  THEN ''
			  WHEN @ScreenID ='POF2001'  THEN ''
			  WHEN @ScreenID ='SOF2061A'  THEN ''
			  WHEN @ScreenID ='SOF2061C'  THEN ''
			  WHEN @ScreenID ='POF2031'  THEN ''
			  WHEN @ScreenID='SOF2021' THEN ''
			ELSE 
		 '
		 AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'') '
		 END	
		+@sWhere +
		'
			GROUP BY T1.APK,
			T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
			T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, 
			T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
			T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
			T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, T2.Ana07ID, T71.AnaName, 
			T2.Ana08ID, T81.AnaName, T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,T2.OrderQuantity ,T2.Specification,T2.Orders
			,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description, T2.Notes01,T2.Notes02
			, T02.I01ID, AT01.AnaName, T02.I02ID, AT02.AnaName, T02.I03ID, AT03.AnaName,T02.I04ID, AT04.AnaName, T02.I05ID, AT05.AnaName
			, T02.I06ID, AT06.AnaName, T02.I07ID, AT07.AnaName, T02.I08ID, AT08.AnaName,T02.I09ID, AT09.AnaName, T02.I10ID, AT10.AnaName
			'+@sSQLSL+'
			'+@sHavingSum+'
		--ORDER BY '+@OrderBy+' 
		--OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		--FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
	ELSE
	BEGIN
		SET @sJoin = @sJoin + N'
		LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = T2.DivisionID AND O99.VoucherID = T2.ROrderID AND O99.TransactionID = T2.TransactionID
		LEFT JOIN WQ1309 WQ09 WITH (NOLOCK) ON WQ09.DivisionID IN (T2.DivisionID, ''@@@'') 
														AND WQ09.InventoryID = T2.InventoryID
														AND WQ09.ConvertedUnitID = T2.ConvertedUnitID
														--AND (WQ09.S01ID = O99.S01ID OR (ISNULL(WQ09.S01ID, '''') =  ISNULL(O99.S01ID, '''')))
														--AND (WQ09.S02ID = O99.S02ID OR (ISNULL(WQ09.S02ID, '''') =  ISNULL(O99.S02ID, '''')))
														--AND (WQ09.S03ID = O99.S03ID OR (ISNULL(WQ09.S03ID, '''') =  ISNULL(O99.S03ID, '''')))
														--AND (WQ09.S04ID = O99.S04ID OR (ISNULL(WQ09.S04ID, '''') =  ISNULL(O99.S04ID, '''')))
														--AND (WQ09.S05ID = O99.S05ID OR (ISNULL(WQ09.S05ID, '''') =  ISNULL(O99.S05ID, '''')))
														--AND (WQ09.S06ID = O99.S06ID OR (ISNULL(WQ09.S06ID, '''') =  ISNULL(O99.S06ID, '''')))
														--AND (WQ09.S07ID = O99.S07ID OR (ISNULL(WQ09.S07ID, '''') =  ISNULL(O99.S07ID, '''')))
														--AND (WQ09.S08ID = O99.S08ID OR (ISNULL(WQ09.S08ID, '''') =  ISNULL(O99.S08ID, '''')))
														--AND (WQ09.S09ID = O99.S09ID OR (ISNULL(WQ09.S09ID, '''') =  ISNULL(O99.S09ID, '''')))
														--AND (WQ09.S10ID = O99.S10ID OR (ISNULL(WQ09.S10ID, '''') =  ISNULL(O99.S10ID, '''')))
														--AND (WQ09.S11ID = O99.S11ID OR (ISNULL(WQ09.S11ID, '''') =  ISNULL(O99.S11ID, '''')))
														--AND (WQ09.S12ID = O99.S12ID OR (ISNULL(WQ09.S12ID, '''') =  ISNULL(O99.S12ID, '''')))
														--AND (WQ09.S13ID = O99.S13ID OR (ISNULL(WQ09.S13ID, '''') =  ISNULL(O99.S13ID, '''')))
														--AND (WQ09.S14ID = O99.S14ID OR (ISNULL(WQ09.S14ID, '''') =  ISNULL(O99.S14ID, '''')))
														--AND (WQ09.S15ID = O99.S15ID OR (ISNULL(WQ09.S15ID, '''') =  ISNULL(O99.S15ID, '''')))
														--AND (WQ09.S16ID = O99.S16ID OR (ISNULL(WQ09.S16ID, '''') =  ISNULL(O99.S16ID, '''')))
														--AND (WQ09.S17ID = O99.S17ID OR (ISNULL(WQ09.S17ID, '''') =  ISNULL(O99.S17ID, '''')))
														--AND (WQ09.S18ID = O99.S18ID OR (ISNULL(WQ09.S18ID, '''') =  ISNULL(O99.S18ID, '''')))
														--AND (WQ09.S19ID = O99.S19ID OR (ISNULL(WQ09.S19ID, '''') =  ISNULL(O99.S19ID, '''')))
														--AND (WQ09.S20ID = O99.S20ID OR (ISNULL(WQ09.S20ID, '''') =  ISNULL(O99.S20ID, '''')))
		'
		SET @sSQL = @sSQL + N'
		---APK
		SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.APK APKMaster,
		T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
		T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, 
		CASE WHEN '''+@ScreenID+''' NOT IN (''SOF2021'',''SOF2061A'',''SOF2061C'') THEN (T2.OrderQuantity - SUM(ISNULL(OT22.OrderQuantity,0)))
		ELSE T2.OrderQuantity END AS OrderQuantity,
		T2.OriginalAmount, T2.ConvertedAmount, 
		T2.UnitID, T04.UnitName, T2.Notes, 
		T2.Ana01ID, T11.AnaName As Ana01Name, T2.Ana02ID, T21.AnaName As Ana02Name, 
		T2.Ana03ID, T31.AnaName As Ana03Name, T2.Ana04ID, T41.AnaName As Ana04Name, 
		T2.Ana05ID, T51.AnaName As Ana05Name, T2.Ana06ID, T61.AnaName As Ana06Name, T2.Ana07ID, T71.AnaName As Ana07Name, 
		T2.Ana08ID, T81.AnaName As Ana08Name, T2.Ana09ID, T91.AnaName As Ana09Name, T2.Ana10ID, T10.AnaName As Ana10Name ,T2.Specification,T2.Orders
		,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description as DescriptionDetail, T2.Notes01,T2.Notes02,T2.PONumber
		, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID
		, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
		, T2.Parameter01, T2.Parameter02, T2.Parameter03, T2.Parameter04, T2.Parameter05, T2.ConvertedQuantity, T2.ConvertedSalePrice, T2.RequestPrice
		, T2.ConvertedUnitID, WQ09.ConversionFactor, WQ09.DataType, WQ09.Operator, WQ09.FormulaDes
		'+@sSQLSL+@sSQLSL1+', T2.I03ID, T15.AnaName AS I03Name 
		--,(Select ISNULL(SUM(ISNULL(SignQuantity, 0)), 0) AS Quantity FROM AV7000 
	   -- WHERE AV7000.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AV7000.InventoryID = T2.InventoryID) AS InventoryQuantity
		FROM OT3101 T1 WITH(NOLOCK)
		INNER JOIN OT3102 T2 WITH(NOLOCK) ON T1.ROrderID = T2.ROrderID AND T1.DivisionID = T2.DivisionID
		LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID 
		LEFT JOIN OT0099 T99 WITH(NOLOCK) ON T1.PriorityID = T99.ID AND T99.CodeMaster = ''PriorityID''
		LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
		LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01''
		LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02''
		LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03''
		LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04''
		LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05''
		LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06''
		LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07''
		LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08''
		LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09''
		LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
		LEFT JOIN AT1015 T15 WITH(NOLOCK) ON T15.AnaID = T2.I03ID AND T15.AnaTypeID = ''I03''
		LEFT JOIN AT1010 A11 WITH (NOLOCK) ON T2.VATGroupID = A11.VATGroupID
		LEFT JOIN POT2022 T22 WITH(NOLOCK) ON T22.InheritAPKDetail = T2.APK AND T22.DivisionID = T2.DivisionID AND IsSelectPrice = 1
		LEFT JOIN OT3002 OT22 WITH(NOLOCK) ON T2.TransactionID = OT22.InheritTransactionID AND T2.DivisionID = OT22.DivisionID And OT22.InheritTableID = ''OT3101'' 
		'+@sJoin+'
		WHERE T1.DivisionID = '''+@DivisionID+''' 
		AND T2.ROrderID IN ('''+@ROrderID+''')
		 ' --+ @sWhere2
		 + 
		 CASE WHEN @ScreenID ='CIF1361' THEN ''  ----Khi hợp đồng kế thừa yêu cầu mua hàng
			  WHEN @ScreenID ='POF2041'  THEN ''
			  WHEN @ScreenID ='POF2001'  THEN ''
			  WHEN @ScreenID ='SOF2061A'  THEN ''
			  WHEN @ScreenID ='SOF2061C'  THEN ''
			  WHEN @ScreenID ='POF2031'  THEN ''
			  WHEN @ScreenID='SOF2021' THEN ''
			ELSE 
		 '
		 AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'') '
		 END	
		+@sWhere +
		'
			GROUP BY T1.APK,
			T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
			T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, 
			T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
			T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
			T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, T2.Ana07ID, T71.AnaName, 
			T2.Ana08ID, T81.AnaName, T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,T2.OrderQuantity ,T2.Specification,T2.Orders
			,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description, T2.Notes01,T2.Notes02,T2.PONumber
			, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID
			, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
			, T2.Parameter01, T2.Parameter02, T2.Parameter03, T2.Parameter04, T2.Parameter05, T2.ConvertedQuantity, T2.ConvertedSalePrice, T2.RequestPrice
			, T2.ConvertedUnitID, WQ09.ConversionFactor, WQ09.DataType, WQ09.Operator, WQ09.FormulaDes
			'+@sSQLSL+', T2.I03ID, T15.AnaName
			'+@sHavingSum+'
		ORDER BY '+@OrderBy+' 
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END

	

	IF(@ScreenID ='SOF2021' OR @ScreenID ='SOF2061A' OR @ScreenID = 'SOF2061C') --Tính toán lại số lượng khi kế thừa
		BEGIN
		IF (@CustomerIndex = 161)
		BEGIN
			SET @sSQL2 = @sSQL2 +' 
			UNION ALL
			SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
			T1.APK APKMaster,
			T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
			T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, (T2.OrderQuantity - SUM(OT21.QuoQuantity)) As OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, 
			T2.Ana01ID, T11.AnaName As Ana01Name, T2.Ana02ID, T21.AnaName As Ana02Name, 
			T2.Ana03ID, T31.AnaName As Ana03Name, T2.Ana04ID, T41.AnaName As Ana04Name, 
			T2.Ana05ID, T51.AnaName As Ana05Name, T2.Ana06ID, T61.AnaName As Ana06Name, T2.Ana07ID, T71.AnaName As Ana07Name, 
			T2.Ana08ID, T81.AnaName As Ana08Name, T2.Ana09ID, T91.AnaName As Ana09Name, T2.Ana10ID, T10.AnaName As Ana10Name,T2.Specification,T2.Orders
			,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description as DescriptionDetail, T2.Notes01,T2.Notes02
			, T02.I01ID, AT01.AnaName As I01Name, T02.I02ID, AT02.AnaName As I02Name, T02.I03ID, AT03.AnaName As I03Name,T02.I04ID, AT04.AnaName As I04Name, T02.I05ID, AT05.AnaName As I05Name
			, T02.I06ID, AT06.AnaName As I06Name, T02.I07ID, AT07.AnaName As I07Name, T02.I08ID, AT08.AnaName As I08Name,T02.I09ID, AT09.AnaName As I09Name , T02.I10ID, AT10.AnaName As I10Name
			'+@sSQLSL + @sSQLSL1+'
			FROM OT3101 T1 WITH(NOLOCK)
			INNER JOIN OT3102 T2 WITH(NOLOCK) ON T1.ROrderID = T2.ROrderID AND T1.DivisionID = T2.DivisionID
			LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID 
			LEFT JOIN OT0099 T99 WITH(NOLOCK) ON T1.PriorityID = T99.ID AND T99.CodeMaster = ''PriorityID''
			LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
			LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01''
			LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02''
			LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03''
			LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04''
			LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05''
			LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06''
			LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07''
			LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08''
			LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09''
			LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
			LEFT JOIN AT1015 AT01 WITH (NOLOCK) ON AT01.AnaID = T02.I01ID AND AT01.AnaTypeID = ''I01''
			LEFT JOIN AT1015 AT02 WITH (NOLOCK) ON AT02.AnaID = T02.I02ID AND AT02.AnaTypeID = ''I02''
			LEFT JOIN AT1015 AT03 WITH (NOLOCK) ON AT03.AnaID = T02.I03ID AND AT03.AnaTypeID = ''I03''
			LEFT JOIN AT1015 AT04 WITH (NOLOCK) ON AT04.AnaID = T02.I04ID AND AT04.AnaTypeID = ''I04''
			LEFT JOIN AT1015 AT05 WITH (NOLOCK) ON AT05.AnaID = T02.I05ID AND AT05.AnaTypeID = ''I05''
			LEFT JOIN AT1015 AT06 WITH (NOLOCK) ON AT06.AnaID = T02.I06ID AND AT06.AnaTypeID = ''I06''
			LEFT JOIN AT1015 AT07 WITH (NOLOCK) ON AT07.AnaID = T02.I07ID AND AT07.AnaTypeID = ''I07''
			LEFT JOIN AT1015 AT08 WITH (NOLOCK) ON AT08.AnaID = T02.I08ID AND AT08.AnaTypeID = ''I08''
			LEFT JOIN AT1015 AT09 WITH (NOLOCK) ON AT09.AnaID = T02.I09ID AND AT09.AnaTypeID = ''I09''
			LEFT JOIN AT1015 AT10 WITH (NOLOCK) ON AT10.AnaID = T02.I10ID AND AT10.AnaTypeID = ''I10''
			LEFT JOIN AT1010 A11 WITH (NOLOCK) ON T2.VATGroupID = A11.VATGroupID
			LEFT JOIN POT2022 T22 WITH(NOLOCK) ON T22.InheritAPKDetail = T2.APK AND T22.DivisionID = T2.DivisionID AND IsSelectPrice = 1
			LEFT JOIN OT2102 OT21 WITH(NOLOCK) ON T2.TransactionID = OT21.InheritTransactionID AND T2.DivisionID = OT21.DivisionID And OT21.InheritTableID = ''OT3101''
			'+@sJoin+'
			WHERE T1.DivisionID = '''+@DivisionID+''' 
			AND T2.ROrderID IN ('''+@ROrderID+''')
			AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'')'
			+@sWhere +'
			GROUP BY T1.APK,
			T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
			T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, 
			T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
			T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
			T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, T2.Ana07ID, T71.AnaName, 
			T2.Ana08ID, T81.AnaName, T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,T2.OrderQuantity ,T2.Specification,T2.Orders
			,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description, T2.Notes01,T2.Notes02
			, T02.I01ID, AT01.AnaName, T02.I02ID, AT02.AnaName, T02.I03ID, AT03.AnaName,T02.I04ID, AT04.AnaName, T02.I05ID, AT05.AnaName
			, T02.I06ID, AT06.AnaName, T02.I07ID, AT07.AnaName, T02.I08ID, AT08.AnaName,T02.I09ID, AT09.AnaName, T02.I10ID, AT10.AnaName
			'+@sSQLSL+'
			HAVING SUM(OT21.QuoQuantity) < T2.OrderQuantity
			ORDER BY '+@OrderBy+' 
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
			'
		END
		ELSE
				BEGIN
			SET @sSQL2 = @sSQL2 +' 
			UNION ALL
			SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
			T1.APK APKMaster,
			T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
			T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, (T2.OrderQuantity - SUM(OT21.QuoQuantity)) As OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, 
			T2.Ana01ID, T11.AnaName As Ana01Name, T2.Ana02ID, T21.AnaName As Ana02Name, 
			T2.Ana03ID, T31.AnaName As Ana03Name, T2.Ana04ID, T41.AnaName As Ana04Name, 
			T2.Ana05ID, T51.AnaName As Ana05Name, T2.Ana06ID, T61.AnaName As Ana06Name, T2.Ana07ID, T71.AnaName As Ana07Name, 
			T2.Ana08ID, T81.AnaName As Ana08Name, T2.Ana09ID, T91.AnaName As Ana09Name, T2.Ana10ID, T10.AnaName As Ana10Name,T2.Specification,T2.Orders
			,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description as DescriptionDetail, T2.Notes01,T2.Notes02
			'+@sSQLSL + @sSQLSL1+', T2.I03ID, T15.AnaName AS I03Name
			FROM OT3101 T1 WITH(NOLOCK)
			INNER JOIN OT3102 T2 WITH(NOLOCK) ON T1.ROrderID = T2.ROrderID AND T1.DivisionID = T2.DivisionID
			LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID 
			LEFT JOIN OT0099 T99 WITH(NOLOCK) ON T1.PriorityID = T99.ID AND T99.CodeMaster = ''PriorityID''
			LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
			LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01''
			LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02''
			LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03''
			LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04''
			LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05''
			LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06''
			LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07''
			LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08''
			LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09''
			LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
			LEFT JOIN AT1015 T15 WITH(NOLOCK) ON T15.AnaID = T2.I03ID AND T15.AnaTypeID = ''I03''
			LEFT JOIN AT1010 A11 WITH (NOLOCK) ON T2.VATGroupID = A11.VATGroupID
			LEFT JOIN POT2022 T22 WITH(NOLOCK) ON T22.InheritAPKDetail = T2.APK AND T22.DivisionID = T2.DivisionID AND IsSelectPrice = 1
			LEFT JOIN OT2102 OT21 WITH(NOLOCK) ON T2.TransactionID = OT21.InheritTransactionID AND T2.DivisionID = OT21.DivisionID And OT21.InheritTableID = ''OT3101''
			'+@sJoin+'
			WHERE T1.DivisionID = '''+@DivisionID+''' 
			AND T2.ROrderID IN ('''+@ROrderID+''')
			AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'')'
			+@sWhere +'
			GROUP BY T1.APK,
			T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
			T2.TransactionID, T2.ROrderID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, 
			T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
			T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
			T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, T2.Ana07ID, T71.AnaName, 
			T2.Ana08ID, T81.AnaName, T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,T2.OrderQuantity ,T2.Specification,T2.Orders
			,T2.VATGroupID,A11.VATGroupName,T2.VATPercent, T2.VATConvertedAmount, T2.VATOriginalAmount,T2.Description, T2.Notes01,T2.Notes02
			'+@sSQLSL+', T2.I03ID, T15.AnaName
			HAVING SUM(OT21.QuoQuantity) < T2.OrderQuantity
			ORDER BY '+@OrderBy+' 
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
			'
		END
	END
END

Print (@sSQL11 + @sSQL +@sSQL2)
EXEC (@sSQL11 + @sSQL +@sSQL2)
--DROP TABLE #OT3101

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
