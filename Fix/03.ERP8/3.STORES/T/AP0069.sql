IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0069]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0069]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Lấy dữ liệu hóa đơn bán hàng để lập hàng bán trả lại (AF0069)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tieu Mai on 16/12/2015: Thay câu query load chi tiết hóa đơn bán hàng hiện tại 
---- Modify by Kim Vũ on 18/02/2016: Bo sung Load ReSalseAccoutID as DebitAccountID
---- Modify by Hải Long on 09/12/2016: Bổ sung trường IsProInventoryID, DiscountSaleAmountDetail, và 5 mã phân tích nhân viên cho ANGEL
---- Modified by Bảo Thy on 11/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
-- <Example> EXEC AP0069 'HT', 'd75d10f9-6ae1-4464-b70f-5382adc330db'
---- 
CREATE PROCEDURE [DBO].[AP0069]
(
	@DivisionID AS NVARCHAR(50),	
	@VoucherID AS NVARCHAR(50) 
) 
AS
DECLARE @sSQL NVARCHAR(MAX),
		@CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang ANGEL khong (CustomerName = 57)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP0069_QC @DivisionID, @VoucherID

ELSE
IF @CustomerName = 57 
	BEGIN
		SET @sSQL = '
		Select AT9000.APK ,AT9000.DivisionID ,AT9000.VoucherID ,AT9000.BatchID ,AT9000.TransactionID AS ReTransactionID, AT9000.TableID ,AT9000.TranMonth ,
		AT9000.TranYear ,AT9000.TransactionTypeID ,AT9000.CurrencyID ,AT9000.ObjectID ,AT9000.CreditObjectID ,AT9000.VATNo ,AT9000.VATObjectID ,
		AT9000.VATObjectName ,AT9000.VATObjectAddress ,AT9000.DebitAccountID as CreditAccountID ,AT9000.ExchangeRate ,AT9000.UnitPrice ,
		AT9000.OriginalAmount ,AT9000.ConvertedAmount ,AT9000.ImTaxOriginalAmount ,AT9000.ImTaxConvertedAmount ,AT9000.ExpenseOriginalAmount ,
		AT9000.ExpenseConvertedAmount ,AT9000.IsStock ,AT9000.VoucherDate ,AT9000.InvoiceDate ,AT9000.VoucherTypeID ,AT9000.VATTypeID ,
		AT9000.VATGroupID ,AT9000.VoucherNo ,AT9000.Serial ,AT9000.InvoiceNo ,AT9000.Orders ,AT9000.EmployeeID ,AT9000.SenderReceiver ,
		AT9000.SRDivisionName ,AT9000.SRAddress ,AT9000.RefNo01 ,AT9000.RefNo02 ,AT9000.VDescription ,AT9000.BDescription ,AT9000.TDescription ,
		AT9000.Quantity ,AT9000.InventoryID ,AT9000.UnitID ,AT9000.Status ,AT9000.IsAudit ,AT9000.IsCost ,
		AT9000.Ana01ID ,AT9000.Ana02ID ,AT9000.Ana03ID ,AT9000.Ana04ID ,AT9000.Ana05ID ,
		AT9000.Ana06ID ,AT9000.Ana07ID ,AT9000.Ana08ID ,AT9000.Ana09ID ,AT9000.Ana10ID ,
		AT9000.PeriodID ,AT9000.ExpenseID ,AT9000.MaterialTypeID ,AT9000.ProductID ,AT9000.CreateDate ,AT9000.CreateUserID ,AT9000.LastModifyDate ,
		AT9000.LastModifyUserID ,AT9000.OriginalAmountCN ,AT9000.ExchangeRateCN ,AT9000.CurrencyIDCN ,AT9000.DueDays ,AT9000.PaymentID ,
		AT9000.DueDate ,AT9000.DiscountRate ,AT9000.OrderID ,AT9000.CreditBankAccountID ,AT9000.DebitBankAccountID ,AT9000.CommissionPercent ,
		AT9000.InventoryName1 ,AT9000.PaymentTermID ,AT9000.DiscountAmount ,AT9000.OTransactionID ,
		AT9000.IsMultiTax ,AT9000.VATOriginalAmount ,AT9000.VATConvertedAmount ,AT9000.ReVoucherID ,AT9000.ReBatchID ,AT9000.ReTransactionID ,
		AT9000.Parameter01 ,AT9000.Parameter02 ,AT9000.Parameter03 ,AT9000.Parameter04 ,AT9000.Parameter05 ,AT9000.Parameter06 ,
		AT9000.Parameter07 ,AT9000.Parameter08 ,AT9000.Parameter09 ,AT9000.Parameter10 ,AT1302.InventoryName, AT1302.IsSource,AT1302.IsLimitDate,
		AT1302.IsLocation, AT1302.IsStocked,AT1302.AccountID as IsDebitAccountID, AT1302.IsDiscount, AT1302.Barcode,
		AT9000.ConvertedUnitID, AT9000.ConvertedQuantity,
		AT9000.ConvertedPrice, AT9000.MarkQuantity,
		AT9000.UParameter01, AT9000.UParameter02, AT9000.UParameter03, AT9000.UParameter04, AT9000.UParameter05, WQ1309.Operator, WQ1309.ConversionFactor, WQ1309.DataType, WQ1309.FormulaDes
		,AT9000.InvoiceCode,AT9000.InvoiceSign, 
		AT1302.ReSalesAccountID as DebitAccountID, AT9000.IsProInventoryID, AT9000.DiscountSaleAmountDetail,
		OT2001.Ana01ID AS SOAna01ID, OT2001.Ana02ID AS SOAna02ID, OT2001.Ana03ID AS SOAna03ID, OT2001.Ana04ID AS SOAna04ID, OT2001.Ana05ID AS SOAna05ID
		From AT9000 WITH (NOLOCK) Left Join AT1302 WITH (NOLOCK) On AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.InventoryID = AT1302.InventoryID
		Left join WQ1309 WITH (NOLOCK) ON WQ1309.DivisionID IN (AT9000.DivisionID, ''@@@'') And AT9000.InventoryID = WQ1309.InventoryID And AT9000.ConvertedUnitID = WQ1309.ConvertedUnitID	
		LEFT JOIN OT2001 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.OrderID = OT2001.SOrderID	
		Where AT9000.VoucherID = ''' + @VoucherID + ''' And TransactionTypeID In (''T04'',''T64'')  And AT9000.TableID =''AT9000''
		And AT9000.DivisionID = ''' + @DivisionID + '''
		Order by Orders'		
	END
ELSE
	BEGIN
		SET @sSQL = '
		Select AT9000.APK ,AT9000.DivisionID ,AT9000.VoucherID ,AT9000.BatchID ,AT9000.TransactionID AS ReTransactionID, AT9000.TableID ,AT9000.TranMonth ,
		AT9000.TranYear ,AT9000.TransactionTypeID ,AT9000.CurrencyID ,AT9000.ObjectID ,AT9000.CreditObjectID ,AT9000.VATNo ,AT9000.VATObjectID ,
		AT9000.VATObjectName ,AT9000.VATObjectAddress ,AT9000.DebitAccountID as CreditAccountID ,AT9000.ExchangeRate ,AT9000.UnitPrice ,
		AT9000.OriginalAmount ,AT9000.ConvertedAmount ,AT9000.ImTaxOriginalAmount ,AT9000.ImTaxConvertedAmount ,AT9000.ExpenseOriginalAmount ,
		AT9000.ExpenseConvertedAmount ,AT9000.IsStock ,AT9000.VoucherDate ,AT9000.InvoiceDate ,AT9000.VoucherTypeID ,AT9000.VATTypeID ,
		AT9000.VATGroupID ,AT9000.VoucherNo ,AT9000.Serial ,AT9000.InvoiceNo ,AT9000.Orders ,AT9000.EmployeeID ,AT9000.SenderReceiver ,
		AT9000.SRDivisionName ,AT9000.SRAddress ,AT9000.RefNo01 ,AT9000.RefNo02 ,AT9000.VDescription ,AT9000.BDescription ,AT9000.TDescription ,
		AT9000.Quantity ,AT9000.InventoryID ,AT9000.UnitID ,AT9000.Status ,AT9000.IsAudit ,AT9000.IsCost ,
		AT9000.Ana01ID ,AT9000.Ana02ID ,AT9000.Ana03ID ,AT9000.Ana04ID ,AT9000.Ana05ID ,
		AT9000.Ana06ID ,AT9000.Ana07ID ,AT9000.Ana08ID ,AT9000.Ana09ID ,AT9000.Ana10ID ,
		AT9000.PeriodID ,AT9000.ExpenseID ,AT9000.MaterialTypeID ,AT9000.ProductID ,AT9000.CreateDate ,AT9000.CreateUserID ,AT9000.LastModifyDate ,
		AT9000.LastModifyUserID ,AT9000.OriginalAmountCN ,AT9000.ExchangeRateCN ,AT9000.CurrencyIDCN ,AT9000.DueDays ,AT9000.PaymentID ,
		AT9000.DueDate ,AT9000.DiscountRate ,AT9000.OrderID ,AT9000.CreditBankAccountID ,AT9000.DebitBankAccountID ,AT9000.CommissionPercent ,
		AT9000.InventoryName1 ,AT9000.PaymentTermID ,AT9000.DiscountAmount ,AT9000.OTransactionID ,
		AT9000.IsMultiTax ,AT9000.VATOriginalAmount ,AT9000.VATConvertedAmount ,AT9000.ReVoucherID ,AT9000.ReBatchID ,AT9000.ReTransactionID ,
		AT9000.Parameter01 ,AT9000.Parameter02 ,AT9000.Parameter03 ,AT9000.Parameter04 ,AT9000.Parameter05 ,AT9000.Parameter06 ,
		AT9000.Parameter07 ,AT9000.Parameter08 ,AT9000.Parameter09 ,AT9000.Parameter10 ,AT1302.InventoryName, AT1302.IsSource,AT1302.IsLimitDate,
		AT1302.IsLocation, AT1302.IsStocked,AT1302.AccountID as IsDebitAccountID, AT1302.IsDiscount, AT1302.Barcode,
		AT9000.ConvertedUnitID, AT9000.ConvertedQuantity,
		AT9000.ConvertedPrice, AT9000.MarkQuantity,
		AT9000.UParameter01, AT9000.UParameter02, AT9000.UParameter03, AT9000.UParameter04, AT9000.UParameter05, WQ1309.Operator, WQ1309.ConversionFactor, WQ1309.DataType, WQ1309.FormulaDes
		,AT9000.InvoiceCode,AT9000.InvoiceSign, 
		AT1302.ReSalesAccountID as DebitAccountID
		From AT9000 WITH (NOLOCK) Left Join AT1302 WITH (NOLOCK) On AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.InventoryID = AT1302.InventoryID
		Left join WQ1309
		On WQ1309.DivisionID IN (AT9000.DivisionID,''@@@'')
		And AT9000.InventoryID = WQ1309.InventoryID
		And AT9000.ConvertedUnitID = WQ1309.ConvertedUnitID		
		Where AT9000.VoucherID = ''' + @VoucherID + ''' And TransactionTypeID In (''T04'',''T64'')  And AT9000.TableID =''AT9000''
		And AT9000.DivisionID = ''' + @DivisionID + '''
		Order by Orders'			
	END		

--PRINT @sSQL
EXEC (@sSQL)
		
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON		
