IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP90041]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CMNP90041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load giá bán cho màn hình chọn mặt hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Thị Phượng Date: 13/07/2017
----Update by: Kiều Nga Date: 11/12/2021 : Bổ sung load cột MinPrice
----Update by: Kiều Nga Date: 14/01/2022 : Bổ sung load cột Barcode
----Update by: Hoài Bảo Date: 16/08/2022 : Bổ sung load cột DiscountPercent
----Update by: Nhật Thanh Date: 30/05/2023 : Bổ sung load cột RetailPrice
----Update by: Nhật Thanh Date: 03/08/2023 : Bổ sung load cột InventoryTypeID
----Update by: Nhật Thanh Date: 07/08/2023 : Bổ sung load cột UnitPrice
----Update by Đức Tuyên Date  17/08/2023: Bổ sung hiển thị mã phân tích mặt hàng customize INNOTEK.
---- Updated by Nhật Thanh on 17/11/2023 : Customize Nệm Kim Cương lấy loại mặt hàng từ mã phân tích mặt hàng I06
----Update by Min Dũng Date: 13/11/2023: Bổ sung selet TOP
----Update by Thanh Nguyên Date  01/12/2023: Bổ sung hiển thị cột % thuế VAT khi đơn hàng Sell in kế thừa từ Phiếu báo giá.
----Modify on 
-- <Example>
/*
	EXEC CMNP90041 @DivisionID=N'AS',@ObjectID=N'',@VoucherDate='2017-07-13 00:00:00',@PriceListID=N'BG002',@CurrencyID=N'VND', @InventoryID='VT00001'

*/

 CREATE PROCEDURE CMNP90041 (
    @DivisionID NVARCHAR(50),
	@ObjectID NVARCHAR(50)='',
    @VoucherDate DATETIME,
    @PriceListID NVARCHAR(50) = '',
    @CurrencyID NVARCHAR(50) = '',
	@InventoryID NVARCHAR(50) = ''
	)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@CustomizeName int,
		@IsConvertedUnit AS TINYINT,
		@Price NVARCHAR(MAX),
		@TOP NVARCHAR (MAX) = 'TOP 50'
 
	Set @CustomizeName = (Select CustomerName from CustomerIndex)
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @Price = ''
	SET @OrderBy = 'AT1302.InventoryID, AT1302.InventoryName'
--có thiết lập đơn vị chuyển đổi	
SET @IsConvertedUnit = (SELECT TOP 1 ISNULL(IsConvertUnit,0) AS IsConvertUnit FROM OT0000 WHERE DivisionID = @DivisionID)

	If isnull(@InventoryID,'')!='' 
		--set @sWhere=@sWhere+'AND (AT1302.InventoryID like N''%'+@InventoryID+'%'' OR  AT1302.InventoryName like N''%'+@InventoryID+'%'' OR  AT1302.Barcode like N''%'+@InventoryID+'%'' )'
		set @sWhere=@sWhere+'AND AT1302.InventoryID = N'''+@InventoryID+''''
	If isnull(@PriceListID,'') !='' 
		Set @Price =@Price + CASE WHEN @CustomizeName = 166 THEN 'OT1302.UnitPrice' ELSE ' ISNULL((CASE WHEN AV1004.Operator = 0 
			THEN ISNULL((CASE WHEN ''' + LTRIM(@IsConvertedUnit) + ''' = ''0'' 
							THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
							ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), AT1302.SalePrice01)* ISNULL(AV1004.ExchangeRate, 1) 
			ELSE ISNULL((CASE WHEN ''' + LTRIM(@IsConvertedUnit) + ''' = ''0'' 
							THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
							ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), AT1302.SalePrice01)/ ISNULL(AV1004.ExchangeRate, 1) END),0)  ' END
	Else 
		Set @Price =@Price + ' AT1302.SalePrice01'

IF (@CustomizeName = 73)
	BEGIN
SET @sSQL = '
			SELECT  Top 50 AT1302.DivisionID, AT1302.InventoryID, AT1302.InventoryName
						, AT1302.UnitID, AT1304.UnitName, AT1302.IsCommon, AT1302.Disabled
						, '+@Price+' as SalePrice, AT1302.VATGroupID, AT1302.VATPercent,
						OT1302.[AddCost01],	OT1302.[AddCost02],	OT1302.[AddCost03],
						OT1302.[AddCost04],	OT1302.[AddCost05],	OT1302.[AddCost06],
						OT1302.[AddCost07],	OT1302.[AddCost08],	OT1302.[AddCost09],
						OT1302.[AddCost10],	OT1302.[AddCost11], OT1302.[AddCost12],	
						OT1302.[AddCost13],	OT1302.[AddCost14],	OT1302.[AddCost15]
						,OT1302.MinPrice,AT1302.Barcode,OT1302.DiscountPercent
			Into #OV1302
			FROM AT1302 WITH (NOLOCK)
			Left join AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
			FULL JOIN OT1302 WITH (NOLOCK) ON AT1302.InventoryID = OT1302.InventoryID AND OT1302.ID = ''' + ISNULL(@PriceListID, '') + '''
			LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.ID = OT1302.DetailID AND OT1312.DivisionID = OT1302.DivisionID AND OT1312.PriceID = ''' + ISNULL(@PriceListID, '') + '''
			LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = ''' + @PriceListID + ''' 
			LEFT JOIN (
						SELECT AV1004.CurrencyID,AV1004.DivisionID, AV1004.Operator,
							COALESCE(AT1012.ExchangeRate,AV1004.ExchangeRate) AS ExchangeRate
						FROM AV1004
						LEFT JOIN (
									SELECT Top 1 DivisionID , CurrencyID, ExchangeRate, ExchangeDate 
									FROM AT1012 
									WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),GETDATE(),101) + ''') >= 0
									ORDER BY ExchangeDate DESC
									)AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
						) AV1004 ON AV1004.CurrencyID = OT1301.CurrencyID
								WHERE AT1302.DivisionID in ('''+@DivisionID+''', ''@@@'') and AT1302.Disabled = 0  '+@sWhere+'
						
		UPDATE #OV1302
		SET		SalePrice =  SalePrice 
							+ SalePrice*Isnull([AddCost01],0)/100 
							+ SalePrice* Isnull([AddCost02],0)/100 
							+ SalePrice*Isnull([AddCost03],0)/100 
							+ SalePrice*Isnull([AddCost04],0)/100 
							+ SalePrice*Isnull([AddCost05],0)/100
							+ SalePrice*Isnull([AddCost06],0)/100 
							+ SalePrice*Isnull([AddCost07],0)/100 
							+ SalePrice*Isnull([AddCost08],0)/100 
							+ SalePrice*Isnull([AddCost09],0)/100 
							+ SalePrice*Isnull([AddCost10],0)/100
							+ SalePrice*Isnull([AddCost11],0)/100
							+ SalePrice*Isnull([AddCost12],0)/100
							+ SalePrice*Isnull([AddCost13],0)/100
							+ SalePrice*Isnull([AddCost14],0)/100
							+ SalePrice*Isnull([AddCost15],0)/100
	
	Select Top 50 AT1302.DivisionID, AT1302.InventoryID, AT1302.InventoryName
				, AT1302.UnitID, AT1302.UnitName, AT1302.IsCommon, AT1302.Disabled, AT1302.SalePrice, AT1302.VATGroupID, AT1302.VATPercent
				, AT1302.InventoryID+''_''+AT1302.InventoryName as InventorySearch,AT1302.MinPrice,AT1302.Barcode,AT1302.DiscountPercent
	 from  #OV1302 AT1302
	 ORDER BY '+@OrderBy+'
	'
	END
Else
BEGIN
	IF (@CustomizeName = 161)
	BEGIN
		SET @sSQL = '
							SELECT Top 50 AT1302.DivisionID, AT1302.InventoryID, AT1302.InventoryName, AT1302.InventoryTypeID
										, AT1302.UnitID, AT1304.UnitName, AT1302.IsCommon, AT1302.Disabled, OT1302.UnitPrice
										,OT1302.RetailPrice, '+@Price+' as SalePrice, AT1302.VATGroupID, AT1302.VATPercent, AT1302.InventoryID+''_''+AT1302.InventoryName as InventorySearch
										,OT1302.MinPrice,AT1302.Barcode,OT1302.DiscountPercent
										, AT1302.I01ID, AT01.AnaName As I01Name, AT1302.I02ID, AT02.AnaName As I02Name, AT1302.I03ID, AT03.AnaName As I03Name,AT1302.I04ID, AT04.AnaName As I04Name, AT1302.I05ID, AT05.AnaName As I05Name
										, AT1302.I06ID, AT06.AnaName As I06Name, AT1302.I07ID, AT07.AnaName As I07Name, AT1302.I08ID, AT08.AnaName As I08Name,AT1302.I09ID, AT09.AnaName As I09Name , AT1302.I10ID, AT10.AnaName As I10Name
							FROM AT1302 WITH (NOLOCK)
							Left join AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
							FULL JOIN OT1302 WITH (NOLOCK) ON AT1302.InventoryID = OT1302.InventoryID AND OT1302.ID = ''' + ISNULL(@PriceListID, '') + '''
							LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.ID = OT1302.DetailID AND OT1312.DivisionID = OT1302.DivisionID AND OT1312.PriceID = ''' + ISNULL(@PriceListID, '') + '''
							LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = ''' + @PriceListID + ''' 
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
												   WHERE AV1004.DivisionID in ('''+@DivisionID+''', ''@@@'')
									   ) AV1004 ON AV1004.CurrencyID = '''+@CurrencyID+''' 
							LEFT JOIN AT1015 AT01 WITH (NOLOCK) ON AT01.AnaID = AT1302.I01ID AND AT01.AnaTypeID = ''I01''
							LEFT JOIN AT1015 AT02 WITH (NOLOCK) ON AT02.AnaID = AT1302.I02ID AND AT02.AnaTypeID = ''I02''
							LEFT JOIN AT1015 AT03 WITH (NOLOCK) ON AT03.AnaID = AT1302.I03ID AND AT03.AnaTypeID = ''I03''
							LEFT JOIN AT1015 AT04 WITH (NOLOCK) ON AT04.AnaID = AT1302.I04ID AND AT04.AnaTypeID = ''I04''
							LEFT JOIN AT1015 AT05 WITH (NOLOCK) ON AT05.AnaID = AT1302.I05ID AND AT05.AnaTypeID = ''I05''
							LEFT JOIN AT1015 AT06 WITH (NOLOCK) ON AT06.AnaID = AT1302.I06ID AND AT06.AnaTypeID = ''I06''
							LEFT JOIN AT1015 AT07 WITH (NOLOCK) ON AT07.AnaID = AT1302.I07ID AND AT07.AnaTypeID = ''I07''
							LEFT JOIN AT1015 AT08 WITH (NOLOCK) ON AT08.AnaID = AT1302.I08ID AND AT08.AnaTypeID = ''I08''
							LEFT JOIN AT1015 AT09 WITH (NOLOCK) ON AT09.AnaID = AT1302.I09ID AND AT09.AnaTypeID = ''I09''
							LEFT JOIN AT1015 AT10 WITH (NOLOCK) ON AT10.AnaID = AT1302.I10ID AND AT10.AnaTypeID = ''I10''

							WHERE AT1302.DivisionID in ('''+@DivisionID+''', ''@@@'') and AT1302.Disabled = 0  '+@sWhere+'
							ORDER BY '+@OrderBy+''
	END
	ELSE
	BEGIN
	If (@CustomizeName = 166) -- NKC
	BEGIN
		SET @TOP = ''
	END
		SET @sSQL = '
							SELECT '+@TOP+' AT1302.DivisionID, AT1302.InventoryID, AT1302.InventoryName,' +CASE WHEN @CustomizeName = 166 then 'AT1302.I06ID' else 'AT1302.InventoryTypeID' end + ' InventoryTypeID
										, AT1302.UnitID, AT1304.UnitName, AT1302.IsCommon, AT1302.Disabled, OT1302.UnitPrice
										,OT1302.RetailPrice, '+@Price+' as SalePrice, AT1302.VATGroupID, AT1302.VATPercent, AT1302.InventoryID+''_''+AT1302.InventoryName as InventorySearch
										,OT1302.MinPrice,AT1302.Barcode,OT1302.DiscountPercent
							FROM AT1302 WITH (NOLOCK)
							Left join AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
							FULL JOIN OT1302 WITH (NOLOCK) ON AT1302.InventoryID = OT1302.InventoryID AND OT1302.ID = ''' + ISNULL(@PriceListID, '') + '''
							LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.ID = OT1302.DetailID AND OT1312.DivisionID = OT1302.DivisionID AND OT1312.PriceID = ''' + ISNULL(@PriceListID, '') + '''
							LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = ''' + @PriceListID + ''' 
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
												   WHERE AV1004.DivisionID in ('''+@DivisionID+''', ''@@@'')
									   ) AV1004 ON AV1004.CurrencyID = '''+@CurrencyID+''' 

							WHERE AT1302.DivisionID in ('''+@DivisionID+''', ''@@@'') and AT1302.Disabled = 0  '+@sWhere+'
							ORDER BY '+@OrderBy+''
	END
End
EXEC (@sSQL)
PRINT(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
