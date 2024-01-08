IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2060]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2060]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Xử lý tính toán các giá trị PBG khi thay đổi bảng giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 01/11/2019
-- <Example>
---- 
/*-- <Example>
	SOP2060 @DivisionID = 'AIC', @PriceListID = '', @CurrencyID = '', @VoucherDate = '',@VoucherDate='',@Coefficient=0,@ExchangeRate=1,@QuotationID=''
----*/

CREATE PROCEDURE SOP2060
( 
	 @DivisionID VARCHAR(50),
	 @PriceListID NVARCHAR(MAX) = '',
     @CurrencyID NVARCHAR(50) = '',
	 @VoucherDate DateTime,
	 @QuotationID NVARCHAR(50) = ''
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
        @sSQL1 NVARCHAR(MAX) = N'',
		@IsConvertedUnit AS TINYINT

-- Lấy bảng giá
SET @IsConvertedUnit = (SELECT TOP 1 ISNULL(IsConvertUnit,0) AS IsConvertUnit FROM OT0000 WHERE DivisionID = @DivisionID)

SELECT AT1302.InventoryID 
			--, ISNULL((CASE WHEN AV1004.Operator = 0 
			--THEN ISNULL((CASE WHEN LTRIM(@IsConvertedUnit) = '0'
			--				THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
			--				ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), AT1302.SalePrice01)* ISNULL(AV1004.ExchangeRate, 1) 
			--ELSE ISNULL((CASE WHEN LTRIM(@IsConvertedUnit) = '0' 
			--				THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
			--				ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), AT1302.SalePrice01)/ ISNULL(AV1004.ExchangeRate, 1) END),0)   as SalePrice
						,OT1302.UnitPrice	as SalePrice
						Into #tbSalePrice
						FROM AT1302 WITH (NOLOCK)
						Left join AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
						INNER JOIN OT1302 WITH (NOLOCK) ON AT1302.InventoryID = OT1302.InventoryID AND OT1302.ID = ISNULL(@PriceListID, '')
						LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.ID = OT1302.DetailID AND OT1312.DivisionID = OT1302.DivisionID AND OT1312.PriceID = ISNULL(@PriceListID, '')
						LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = ISNULL(@PriceListID, '') 
						--LEFT JOIN (
						--			SELECT AV1004.CurrencyID,AV1004.DivisionID, AV1004.Operator, 
						--				COALESCE(AT1012.ExchangeRate,AV1004.ExchangeRate) AS ExchangeRate
						--			FROM AV1004
						--			LEFT JOIN (
						--						SELECT Top 1 DivisionID , CurrencyID, ExchangeRate, ExchangeDate
						--						FROM AT1012 
						--						WHERE DATEDIFF(dd, ExchangeDate,CONVERT(VARCHAR(10),@VoucherDate,101)) >= 0
						--						ORDER BY ExchangeDate DESC
						--					  )AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
						--		   ) AV1004 ON AV1004.CurrencyID =@CurrencyID

						WHERE AT1302.DivisionID in (@DivisionID ,'@@@') and AT1302.Disabled = 0
						ORDER BY AT1302.InventoryID, AT1302.InventoryName

select * from #tbSalePrice
-- Xử lý tính toán lại Phiếu báo giá
Update OT2102 
set UnitPrice = tbsale.SalePrice,
    OriginalAmount =  tbsale.SalePrice * ISNULL(T2.Coefficient,1) * QuoQuantity,
    VATOriginalAmount =(tbsale.SalePrice * ISNULL(T2.Coefficient,1) *QuoQuantity) * (VATPercent / 100) ,
    ConvertedAmount = (tbsale.SalePrice * ISNULL(T2.Coefficient,1) * QuoQuantity) * T1.ExchangeRate ,
    VATConvertedAmount = ((tbsale.SalePrice * ISNULL(T2.Coefficient,1) * QuoQuantity) * T1.ExchangeRate) * (VATPercent / 100)
FROM OT2102 T2
LEFT JOIN OT2101 T1 ON T1.QuotationID = T2.QuotationID
LEFT JOIN #tbSalePrice tbsale ON tbsale.InventoryID = T2.InventoryID
where T2.QuotationID = @QuotationID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
