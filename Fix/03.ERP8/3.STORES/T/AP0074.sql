IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0074]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0074]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Lấy dữ liệu phiếu mua hàng để lập phiếu trả hàng mua (AF073)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tieu Mai on 16/12/2015: Thay câu query load chi tiết hóa đơn mua hàng hiện tại 
---- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Thy on 11/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Thy on 06/09/2017: Chỉ cho kế thừa mặt hàng không phải loại mặt hàng chi phí (chuẩn)
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
-- <Example>
---- 
CREATE PROCEDURE [DBO].[AP0074]
(
	@DivisionID AS NVARCHAR(50),	
	@VoucherID AS NVARCHAR(50) 
) 
AS

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP0074_QC @DivisionID, @VoucherID

ELSE
	SELECT AT9000.VoucherID,AT9000.BatchID,AT9000.TransactionID,AT9000.TableID,AT9000.DivisionID,AT9000.TranMonth,AT9000.TranYear,AT9000.TransactionTypeID,AT9000.CurrencyID,
		AT9000.ObjectID,AT9000.VATObjectID,AT9000.VATObjectName,AT9000.VATNo,AT9000.VATObjectAddress,AT9000.SRDivisionName,AT9000.SRAddress,AT9000.SenderReceiver,AT9000.CreditAccountID,
		AT9000.DebitAccountID,AT9000.ExchangeRate,AT9000.OriginalAmount,AT9000.ConvertedAmount,AT9000.IsMultiTax,AT9000.VATGroupID,AT9000.VATOriginalAmount,AT9000.VATConvertedAmount,
		AT9000.VoucherDate,AT9000.DueDate,AT9000.OriginalAmountCN,AT9000.ExchangeRateCN,AT9000.CurrencyIDCN,AT9000.InvoiceDate,AT9000.VoucherTypeID,AT9000.VATTypeID,AT9000.VoucherNo,AT9000.Serial,
		AT9000.InvoiceNo,AT9000.Orders,AT9000.EmployeeID,AT9000.RefNo01,AT9000.RefNo02,AT9000.VDescription,AT9000.BDescription,AT9000.TDescription,AT9000.Quantity,
		AT9000.UnitPrice,AT9000.DiscountRate,AT9000.InventoryID,AT9000.UnitID,AT9000.Status,AT9000.IsAudit,AT9000.ImTaxOriginalAmount,AT9000.ImTaxConvertedAmount,AT9000.ExpenseOriginalAmount,
		AT9000.ExpenseConvertedAmount,AT9000.Ana01ID,AT9000.Ana02ID,AT9000.Ana03ID,AT9000.Ana04ID,AT9000.Ana05ID,AT9000.Ana06ID,AT9000.Ana07ID,AT9000.Ana08ID,AT9000.Ana09ID,
		AT9000.Ana10ID,AT9000.CreateDate,AT9000.CreateUserID,AT9000.LastModifyDate,AT9000.LastModifyUserID,AT9000.ReVoucherID,AT9000.IsStock, AT1302.InventoryName,AT1302.IsSource,AT1302.IsLimitDate,
		AT1302.IsLocation,AT1302.IsStocked,AT1302.AccountID AS IsDebitAccountID,AT1302.Barcode,AT1302.MethodID,'' AS InventoryName1,
		CAST(Isnull(WQ1309.ConversionFactor,0) AS DECIMAL) AS ConversionFactor,
		AT9000.ConvertedUnitID, AT9000.ConvertedQuantity, AT9000.ConvertedPrice, AT9000.MarkQuantity,
		AT9000.UParameter01, AT9000.UParameter02, AT9000.UParameter03, AT9000.UParameter04, AT9000.UParameter05,
		WQ1309.Operator, WQ1309.DataType, WQ1309.FormulaDes,AT9000.InvoiceCode,AT9000.InvoiceSign
      
		FROM AT9000 WITH (NOLOCK) LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,'@@@') AND AT9000.InventoryID = AT1302.InventoryID
		Left join WQ1309 On WQ1309.DivisionID IN (AT9000.DivisionID, '@@@') And AT9000.InventoryID = WQ1309.InventoryID
		And AT9000.ConvertedUnitID = WQ1309.ConvertedUnitID
	WHERE AT9000.VoucherID = @VoucherID	
      AND AT9000.TransactionTypeID IN ('T03')
      AND AT9000.TableID = 'AT9000'
      AND AT9000.DivisionID = @DivisionID
	  AND ISNULL(AT1302.IsExpense,0) <> 1
      ORDER BY Orders
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


