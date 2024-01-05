IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2062]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2062]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load Grid: Lấy dữ liệu kế thừa yêu cầu mua hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 04/11/2019
----Modified by Bảo Toàn on 25/06/2020: Insert phiếu báo giá sắp xếp thứ tự kế thừa YÊU CẦU MUA HÀNG theo thứ tự lúc nhập.
----Modified by Nhựt Trường on 09/08/2021: Bổ sung trường trường CurrencyID, ExchangeRate.

-- <Example>
---- 
/*-- <Example>
	SOP2062 @DivisionID = 'AIC', @UserID = '', @PageNumber = 1, @PageSize = 25, @ROrderID = 'sfasdf'

----*/

CREATE PROCEDURE SOP2062
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @ROrderID NVARCHAR(MAX),
	 @Mode INT = 0,
	 @ScreenID NVARCHAR(250) ='',
	 @PriceListID NVARCHAR(MAX) = '',
     @CurrencyID NVARCHAR(50) = '',
	 @VoucherDate Datetime,
	 @APKlist NVARCHAR(MAX) = '',
	 @QuotationID VARCHAR(50) ='',
	 @CheckInherit INT = 0
)
AS 
DECLARE @sSQL VARCHAR(MAX) = '',
		@sSQL11 VARCHAR(MAX) = '',		
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@sSQL2 VARCHAR(MAX) = N'',
		@sSQLSL VARCHAR(MAX) =N'',
		@sSQLSL1 VARCHAR(MAX) =N'',
	    @sJoin VARCHAR(MAX) =N'',
		@CustomerIndex INT =-1,
		@RequestPrice  NVARCHAR(MAX) =N'',
		@IsConvertedUnit AS TINYINT

SET @CustomerIndex = (select top 1 Customername from Customerindex) 
print @QuotationID

SET @OrderBy = 'T1.VoucherNo, T2.InventoryID'
SET @TotalRow = 'COUNT(*) OVER ()'

IF(@ScreenID = 'POF2001')
BEGIN
	SET @sSQLSL = @sSQLSL +',A20.ContractNo';

	SET @sJoin = @sJoin +' LEFT JOIN AT1031 A31 WITH (NOLOCK) ON T2.TransactionID = A31.InheritTransactionID
	LEFT JOIN AT1020 A20 WITH (NOLOCK) ON A31.ContractID = A20.ContractID'
	
	SET @sWhere = @sWhere +' 
	-- AND A20.ContractNo IS NOT NULL 
	'
END

IF(@ScreenID = 'SOF2021' OR @ScreenID = 'SOF2061A' OR @ScreenID = 'SOF2061C' )
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

IF (@ScreenID = 'SOF2061A' OR @ScreenID = 'SOF2061C')
BEGIN  -- đơn giá null lấy theo bảng giá bán
   SET @IsConvertedUnit = (SELECT TOP 1 ISNULL(IsConvertUnit,0) AS IsConvertUnit FROM OT0000 WHERE DivisionID = @DivisionID)

   SET @sSQL11 = @sSQL11 + 'SELECT AT1302.InventoryID 
			--, ISNULL((CASE WHEN AV1004.Operator = 0 
			--THEN ISNULL((CASE WHEN '''+LTRIM(@IsConvertedUnit)+''' = ''0'' 
			--				THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
			--				ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), AT1302.SalePrice01)* ISNULL(AV1004.ExchangeRate, 1) 
			--ELSE ISNULL((CASE WHEN '''+LTRIM(@IsConvertedUnit)+''' = ''0'' 
			--				THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
			--				ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), AT1302.SalePrice01)/ ISNULL(AV1004.ExchangeRate, 1) END),0)   as SalePrice
						,OT1302.UnitPrice as SalePrice
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

   SET @sSQLSL = @sSQLSL + ' ,ISNULL(case when T2.RequestPrice = 0 then NULL ELSE T2.RequestPrice END, tbsale.SalePrice) '
   --SET @sSQLSL = @sSQLSL + ' ,tbsale.SalePrice '
   SET @sSQLSL1 = @sSQLSL1 + ' As RequestPrice'

END
ELSE IF(ISNULL(@Mode,0) = 1)
BEGIN
	SET @sSQLSL = @sSQLSL + ' , T2.RequestPrice '
	SET @sSQLSL1 = @sSQLSL1 + ' As RequestPrice '
END
ELSE IF(ISNULL(@Mode,0) = 0)
BEGIN
	SET @sSQLSL = @sSQLSL + ' ,ISNULL(T22.UnitPrice, T2.RequestPrice) '
	SET @sSQLSL1 = @sSQLSL1 + ' As RequestPrice'
END

IF(ISNULL(@APKlist,'') <>'')
BEGIN
	--fix! nếu chọn dòng dữ liệu có Orders là  NULL
	IF LEFT(@APKlist,1) = ','
	BEGIN	
		SET @APKlist = right(@APKlist,len(@APKlist)-1)	
		SET @sWhere = @sWhere +' 
		AND (T2.Orders IS NULL OR T2.Orders IN ('+ @APKlist +')) '
	END
	ELSE IF RIGHT(@APKlist,1) = ','
	BEGIN		
		SET @APKlist = left(@APKlist,len(@APKlist)-1)	
		SET @sWhere = @sWhere +' 
		AND (T2.Orders IS NULL OR T2.Orders IN ('+ @APKlist +')) '
	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere +' 
		AND T2.Orders IN ('+ @APKlist +') '
	END
	
END


IF ISNULL(@Mode,0) = 1
	BEGIN 
	SET @sSQL = @sSQL + N'
	SELECT ROW_NUMBER() OVER (ORDER BY T2.Orders, T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
	T1.APK APKMaster,
	T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
	T2.TransactionID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
	T2.UnitID, T04.UnitName, T2.Notes, 
	T2.Ana01ID, T11.AnaName As Ana01Name, T2.Ana02ID, T21.AnaName As Ana02Name, 
	T2.Ana03ID, T31.AnaName As Ana03Name, T2.Ana04ID, T41.AnaName As Ana04Name, 
	T2.Ana05ID, T51.AnaName As Ana05Name, T2.Ana06ID, T61.AnaName As Ana06Name, T2.Ana07ID, T71.AnaName As Ana07Name, 
	T2.Ana08ID, T81.AnaName As Ana08Name, T2.Ana09ID, T91.AnaName As Ana09Name, T2.Ana10ID, T10.AnaName As Ana10Name,T2.Specification, T1.CurrencyID, T1.ExchangeRate '
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
	'+@sJoin+'
	WHERE T1.DivisionID = '''+@DivisionID+''' 
	AND T2.ROrderID IN ('''+@ROrderID+''')
	AND T1.Status = 1                          
	--AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'')
	AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'') 
	'
	+@sWhere +
	'
	    GROUP BY T1.APK,
		T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
		T2.TransactionID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
		T2.UnitID, T04.UnitName, T2.Notes, 
		T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
		T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
		T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, T2.Ana07ID, T71.AnaName, 
		T2.Ana08ID, T81.AnaName, T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,T2.OrderQuantity ,T2.Specification, T1.CurrencyID, T1.ExchangeRate'+@sSQLSL +', T2.Orders '

	IF(@ScreenID ='SOF2021' OR @ScreenID = 'SOF2061A' OR @ScreenID = 'SOF2061C') --Tính toán lại số lượng khi kế thừa
		BEGIN
		SET @sSQL2 = @sSQL2 + ' 
		UNION ALL
		SELECT ROW_NUMBER() OVER (ORDER BY T2.Orders, T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.APK APKMaster,
		T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
		T2.TransactionID, T2.InventoryID, InventoryName, (T2.OrderQuantity - SUM(OT21.QuoQuantity)) As OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
		T2.UnitID, T04.UnitName, T2.Notes, 
		T2.Ana01ID, T11.AnaName As Ana01Name, T2.Ana02ID, T21.AnaName As Ana02Name, 
		T2.Ana03ID, T31.AnaName As Ana03Name, T2.Ana04ID, T41.AnaName As Ana04Name, 
		T2.Ana05ID, T51.AnaName As Ana05Name, T2.Ana06ID, T61.AnaName As Ana06Name, T2.Ana07ID, T71.AnaName As Ana07Name, 
		T2.Ana08ID, T81.AnaName As Ana08Name, T2.Ana09ID, T91.AnaName As Ana09Name, T2.Ana10ID, T10.AnaName As Ana10Name ,T2.Specification, T1.CurrencyID, T1.ExchangeRate '
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
		LEFT JOIN OT2102 OT21 WITH(NOLOCK) ON T2.TransactionID = OT21.InheritTransactionID AND T2.DivisionID = OT21.DivisionID And OT21.InheritTableID = ''OT3101''
		'+@sJoin+'
		WHERE T1.DivisionID = '''+@DivisionID+''' 
		AND T2.ROrderID IN ('''+@ROrderID+''')
		AND T1.Status = 1                          
		AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'')'
		+@sWhere +
		'
		GROUP BY T1.APK,
		T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
		T2.TransactionID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
		T2.UnitID, T04.UnitName, T2.Notes, 
		T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
		T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
		T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, T2.Ana07ID, T71.AnaName, 
		T2.Ana08ID, T81.AnaName, T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,T2.OrderQuantity ,T2.Specification, T1.CurrencyID, T1.ExchangeRate'+@sSQLSL+' , T2.Orders
		HAVING SUM(OT21.QuoQuantity) < T2.OrderQuantity
		ORDER BY '+@OrderBy
		END
	END
ELSE 
	BEGIN
	SET @sSQL = @sSQL + N'
	SELECT ROW_NUMBER() OVER (ORDER BY T2.Orders, T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
	T1.APK APKMaster,
	T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
	T2.TransactionID,T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
	T2.UnitID, T04.UnitName, T2.Notes, 
	T2.Ana01ID, T11.AnaName As Ana01Name, T2.Ana02ID, T21.AnaName As Ana02Name, 
	T2.Ana03ID, T31.AnaName As Ana03Name, T2.Ana04ID, T41.AnaName As Ana04Name, 
	T2.Ana05ID, T51.AnaName As Ana05Name, T2.Ana06ID, T61.AnaName As Ana06Name, T2.Ana07ID, T71.AnaName As Ana07Name, 
	T2.Ana08ID, T81.AnaName As Ana08Name, T2.Ana09ID, T91.AnaName As Ana09Name, T2.Ana10ID, T10.AnaName As Ana10Name ,T2.Specification, T1.CurrencyID, T1.ExchangeRate
	'+@sSQLSL+@sSQLSL1+'
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
	LEFT JOIN POT2022 T22 WITH(NOLOCK) ON T22.InheritAPKDetail = T2.APK AND T22.DivisionID = T2.DivisionID AND IsSelectPrice = 1
	'+@sJoin+'
	WHERE T1.DivisionID = '''+@DivisionID+''' 
	AND T2.ROrderID IN ('''+@ROrderID+''')
	AND T1.Status = 1
	--AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'') '
	 + 
	 CASE WHEN @ScreenID ='CIF1361' OR @CheckInherit =0  THEN '' ----Khi hợp đồng kế thừa yêu cầu mua hàng
		  WHEN @ScreenID ='POF2001' OR @CheckInherit =0 THEN ''
		  WHEN @ScreenID ='POF2041' OR @CheckInherit =0 THEN ''
		  WHEN @ScreenID ='SOF2061A' OR @CheckInherit =0 THEN ''
		  WHEN @ScreenID ='SOF2061C' OR @CheckInherit =0 THEN ''
		ELSE 
	 '
	 AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'' AND QuotationID <> '''+@QuotationID+''') '
	 END	
	+@sWhere +
	'
	    GROUP BY T1.APK,
		T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
		T2.TransactionID,T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
		T2.UnitID, T04.UnitName, T2.Notes, 
		T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
		T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
		T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, T2.Ana07ID, T71.AnaName, 
		T2.Ana08ID, T81.AnaName, T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,T2.OrderQuantity ,T2.Specification, T1.CurrencyID, T1.ExchangeRate'+@sSQLSL+ ', T2.Orders '


	IF(@ScreenID ='SOF2021' OR @ScreenID ='SOF2061A' OR @ScreenID = 'SOF2061C') --Tính toán lại số lượng khi kế thừa
		BEGIN
		
		SET @sSQL2 = @sSQL2 +' 
		UNION ALL
		SELECT ROW_NUMBER() OVER (ORDER BY T2.Orders, T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.APK APKMaster,
		T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
		T2.TransactionID,T2.InventoryID, InventoryName, (T2.OrderQuantity - SUM(OT21.QuoQuantity)) As OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
		T2.UnitID, T04.UnitName, T2.Notes, 
		T2.Ana01ID, T11.AnaName As Ana01Name, T2.Ana02ID, T21.AnaName As Ana02Name, 
		T2.Ana03ID, T31.AnaName As Ana03Name, T2.Ana04ID, T41.AnaName As Ana04Name, 
		T2.Ana05ID, T51.AnaName As Ana05Name, T2.Ana06ID, T61.AnaName As Ana06Name, T2.Ana07ID, T71.AnaName As Ana07Name, 
		T2.Ana08ID, T81.AnaName As Ana08Name, T2.Ana09ID, T91.AnaName As Ana09Name, T2.Ana10ID, T10.AnaName As Ana10Name,T2.Specification, T1.CurrencyID, T1.ExchangeRate
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
		LEFT JOIN POT2022 T22 WITH(NOLOCK) ON T22.InheritAPKDetail = T2.APK AND T22.DivisionID = T2.DivisionID AND IsSelectPrice = 1
		LEFT JOIN OT2102 OT21 WITH(NOLOCK) ON T2.TransactionID = OT21.InheritTransactionID AND T2.DivisionID = OT21.DivisionID And OT21.InheritTableID = ''OT3101''
		'+@sJoin+'
		WHERE T1.DivisionID = '''+@DivisionID+''' 
		AND T2.ROrderID IN ('''+@ROrderID+''')
		AND T1.Status = 1
		AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'')'
		+@sWhere +'
		GROUP BY T1.APK,
		T2.APK, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate, T1.PriorityID, T1.Description,
		T2.TransactionID, T2.InventoryID, InventoryName, T2.OrderQuantity, T2.OriginalAmount, T2.ConvertedAmount, 
		T2.UnitID, T04.UnitName, T2.Notes, 
		T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
		T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
		T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, T2.Ana07ID, T71.AnaName, 
		T2.Ana08ID, T81.AnaName, T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,T2.OrderQuantity ,T2.Specification, T1.CurrencyID, T1.ExchangeRate'+@sSQLSL+', T2.Orders
		HAVING SUM(OT21.QuoQuantity) < T2.OrderQuantity
		'
	
		END
	END

PRINT (@sSQL11)	 	
PRINT (@sSQL)
PRINT (@sSQL2)

EXEC (@sSQL11 + @sSQL +@sSQL2)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
