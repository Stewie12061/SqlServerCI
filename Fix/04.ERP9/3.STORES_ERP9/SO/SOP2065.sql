IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2065]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2065]
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
----Created by: Văn Tài, Date: 30/06/2021 - Tách ra store mới từ SOP2063.
----Modified by Nhựt Trường on 27/07/2021 - Bổ sung trường InheritCurrencyID và InheritExchangeRate. 
-- <Example> EXEC SOP2065 'AS' , 'VoucherNo' , 'NV01' ,1 ,20

Create PROCEDURE SOP2065
(
    @DivisionID VARCHAR(50), --Biến môi trường
    @QuotationID VARCHAR(MAX),	 --Giá trị chọn trên lưới master
	@APKList VARCHAR(MAX) =''
)
AS

	DECLARE @sSQL NVARCHAR(MAX),
			@sWhere AS NVARCHAR(4000),
			@OrderBy NVARCHAR(500),
			@TotalRow NVARCHAR(50)
	SET @sWhere = ' '
	SET @TotalRow = ''
	SET @OrderBy = ' D.Orders '
	SET @TotalRow = 'COUNT(*) OVER ()' 

	IF Isnull(@DivisionID, '') != ''
		SET @sWhere = @sWhere + ' D.DivisionID ='''+@DivisionID+''''
		
	IF Isnull(@QuotationID, '') != ''
		SET @sWhere = @sWhere + ' And D.QuotationID IN ('''+@QuotationID+''')'

	IF Isnull(@APKList, '') != ''
		SET @sWhere = @sWhere + ' And D.Orders IN ('+@APKList+')'

	SET @sSQL = 'Select ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
						, D.APK, M.APK as APKMaster, D.DivisionID, D.TransactionID, D.QuotationID
						, D.InventoryID, Isnull(D.InventoryCommonName, D1.InventoryName) as InventoryName
						, D.QuoQuantity, D.UnitPrice * D.Coefficient as UnitPrice, D0.OriginalAmount
						, D0.OriginalAmount * ISNULL(D2.ExchangeRate,1) AS ConvertedAmount
						, D.Notes
						, D.VATPercent, D.VATConvertedAmount, D.VATOriginalAmount, D.UnitID, D.Orders, D.DiscountPercent
						, D.DiscountOriginalAmount, D.DiscountConvertedAmount
						, D.Ana03ID, D.Ana02ID, D.Ana01ID, D.Notes01, D.Notes02, D.Ana04ID
						, D.Ana05ID, D.VATGroupID, D.finish, D.ConvertedQuantity, D.ConvertedSalePrice, D.Barcode
						, D.Markup, D.OriginalAmountOutput, D.ConvertedSalepriceInput, D.ReceiveDate, D.Ana06ID
						, D.Ana07ID, D.Ana08ID, D.Ana09ID, D.Ana10ID, D.Parameter01, D.Parameter02, D.Parameter03
						, D.Parameter04, D.Parameter05, D.QuoQuantity01, D.QD01, D.QD02, D.QD03, D.QD04, D.QD05
						, D.QD06, D.QD07, D.QD08, D.QD09, D.QD10, M.ClassifyID,ISNULL(D.Specification,D1.Specification) As Specification
						, D2.CurrencyID, ISNULL(D2.ExchangeRate,1) ExchangeRate
						, M.CurrencyID AS InheritCurrencyID, M.ExchangeRate AS InheritExchangeRate
						from OT2101 M WITH (NOLOCK) 
								inner join OT2102 D  WITH (NOLOCK) On M.DivisionID = D.DivisionID and M.QuotationID = D.QuotationID
								LEFT join OT2102 D0  WITH (NOLOCK) On D.InheritTransactionID = D0.TransactionID 
								Left join AT1302 D1  WITH (NOLOCK) on D.InventoryID = D1.InventoryID
								LEFT JOIN OT2101 D2  WITH (NOLOCK) on D.InheritVoucherID = D2.QuotationID
					WHERE '+@sWhere+'-- AND M.Status = 1
					ORDER BY '+@OrderBy
	Exec (@sSQL)
	PRINT @sSQL	 



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
