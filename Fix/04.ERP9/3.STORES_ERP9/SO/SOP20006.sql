IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Load giá bán cho màn hình chọn mặt hàng
---- Created by: Kiều Nga, date: 11/11/2021
---- Update by: Kiều Nga, date: 25/11/2021 Bổ sung xử lý load đơn giá theo số lượng nhóm hàng (bảng giá theo nhóm hàng)
---- Update by: Kiều Nga Date: 11/12/2021 : Bổ sung load cột MinPrice
---- 	EXEC SOP20006 @DivisionID=N'AS',@ObjectID=N'',@VoucherDate='2017-07-13 00:00:00',@PriceListID=N'BG002',@CurrencyID=N'VND', @InventoryID='VT00001'  

CREATE PROCEDURE [dbo].[SOP20006] 
@DivisionID NVARCHAR(50),
@ObjectID NVARCHAR(50)='',
@VoucherDate DATETIME,
@PriceListID NVARCHAR(50) = '',
@CurrencyID NVARCHAR(50) = '',
@InventoryID NVARCHAR(50) = '',
@OrderQuantity NVARCHAR(50) = '',
@InventoryGroupAnaTypeID NVARCHAR(50) = '',
@TotalOrderQuantity NVARCHAR(50) = ''
AS

DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@CustomizeName int,
		@IsConvertedUnit AS TINYINT,
		@Price NVARCHAR(MAX)
 
	Set @CustomizeName = (Select CustomerName from CustomerIndex)
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @Price = ''
	SET @OrderBy = 'AT1302.InventoryID, AT1302.InventoryName'
--có thiết lập đơn vị chuyển đổi	
SET @IsConvertedUnit = (SELECT TOP 1 ISNULL(IsConvertUnit,0) AS IsConvertUnit FROM OT0000 WHERE DivisionID = @DivisionID)

	--If isnull(@InventoryID,'')!='' 
		--set @sWhere=@sWhere+'AND (AT1302.InventoryID like N''%'+@InventoryID+'%'' OR  AT1302.InventoryName like N''%'+@InventoryID+'%'')'
	If isnull(@PriceListID,'') !='' 
		Set @Price =@Price + ' ISNULL((CASE WHEN AV1004.Operator = 0 
			THEN ISNULL((CASE WHEN ''' + LTRIM(@IsConvertedUnit) + ''' = ''0'' 
							THEN ISNULL(OT1312.UnitPrice,CT0153.UnitPrice)
							ELSE ISNULL(OT1312.UnitPrice,CT0153.ConvertedUnitPrice) END), AT1302.SalePrice01)* ISNULL(AV1004.ExchangeRate, 1) 
			ELSE ISNULL((CASE WHEN ''' + LTRIM(@IsConvertedUnit) + ''' = ''0'' 
							THEN ISNULL(OT1312.UnitPrice,CT0153.UnitPrice)
							ELSE ISNULL(OT1312.UnitPrice,CT0153.ConvertedUnitPrice) END), AT1302.SalePrice01)/ ISNULL(AV1004.ExchangeRate, 1) END),0)  '
	Else 
		Set @Price =@Price + ' AT1302.SalePrice01'

	IF (@CustomizeName = 73)
	BEGIN
	SET @sSQL = '
				SELECT  Top 50 AT1302.DivisionID, AT1302.InventoryID, AT1302.InventoryName
							, AT1302.UnitID, AT1304.UnitName, AT1302.IsCommon, AT1302.Disabled
							, '+@Price+' as SalePrice, AT1302.VATGroupID,
							CT0153.[AddCost01],	CT0153.[AddCost02],	CT0153.[AddCost03],
							CT0153.[AddCost04],	CT0153.[AddCost05],	CT0153.[AddCost06],
							CT0153.[AddCost07],	CT0153.[AddCost08],	CT0153.[AddCost09],
							CT0153.[AddCost10],	CT0153.[AddCost11], CT0153.[AddCost12],	
							CT0153.[AddCost13],	CT0153.[AddCost14],	CT0153.[AddCost15]
							,CT0153.MinPrice
				Into #OV1302
				FROM AT1302 WITH (NOLOCK)
				Left join AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
				FULL JOIN CT0153 WITH (NOLOCK) ON AT1302.InventoryID = CT0153.InventoryID AND CT0153.ID = ''' + ISNULL(@PriceListID, '') + '''
				LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.ID = CT0153.DetailID AND OT1312.DivisionID = CT0153.DivisionID AND OT1312.PriceID = ''' + ISNULL(@PriceListID, '') + '''
				LEFT JOIN CT0152 WITH (NOLOCK) ON CT0152.ID = ''' + @PriceListID + ''' 
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
							) AV1004 ON AV1004.CurrencyID = CT0152.CurrencyID
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
					, AT1302.UnitID, AT1302.UnitName, AT1302.IsCommon, AT1302.Disabled, AT1302.SalePrice, AT1302.VATGroupID
					, AT1302.InventoryID+''_''+AT1302.InventoryName as InventorySearch,AT1302.MinPrice
		 from  #OV1302 AT1302
		 ORDER BY '+@OrderBy+'
		'
	END
Else
Begin
	SET @sSQL = '
						SELECT Top 50 AT1302.DivisionID, AT1302.InventoryID, AT1302.InventoryName
									, AT1302.UnitID, AT1304.UnitName, AT1302.IsCommon, AT1302.Disabled
									, '+@Price+' as SalePrice, AT1302.VATGroupID, AT1302.InventoryID+''_''+AT1302.InventoryName as InventorySearch
									,CT0153.MinPrice
						FROM AT1302 WITH (NOLOCK)
						Left join AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
						FULL JOIN CT0153 WITH (NOLOCK) ON AT1302.InventoryID = CT0153.InventoryID AND CT0153.ID = ''' + ISNULL(@PriceListID, '') + '''
						LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.ID = CT0153.DetailID AND OT1312.DivisionID = CT0153.DivisionID AND OT1312.PriceID = ''' + ISNULL(@PriceListID, '') + '''
						LEFT JOIN CT0152 WITH (NOLOCK) ON CT0152.ID = ''' + @PriceListID + ''' 
						INNER JOIN CT0154 WITH (NOLOCK) ON CT0154.APK = CT0153.APKValue
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

						WHERE AT1302.DivisionID in ('''+@DivisionID+''', ''@@@'') and AT1302.Disabled = 0  '+@sWhere+'
						AND  (('+@OrderQuantity+' between CT0154.FromValues AND CT0154.ToValues AND CT0154.InventoryTypeID ='''+ @InventoryGroupAnaTypeID+''') 
						       OR ('+@TotalOrderQuantity+' between CT0154.FromValues AND CT0154.ToValues AND CT0154.InventoryTypeID=''%''))

						ORDER BY '+@OrderBy+''
End
EXEC (@sSQL)
PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
