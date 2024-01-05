IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Lấy danh sách các phiếu tạm chi liên quan đến Phiếu đề nghị
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by: Vĩnh Tâm on 24/07/2020
/* Example

 */
CREATE PROCEDURE BEMP2009
( 
    @DivisionID VARCHAR(50),
	@InheritType VARCHAR(50),
    @VoucherNo VARCHAR(MAX)
) 
AS 
BEGIN

	-- Trường hợp phiếu đề nghị kế thừa phiếu DNCT - Thanh toán phí đi lại
	IF (@InheritType = 'DNCT')
	BEGIN
		SELECT DISTINCT B4.APK AS InheritVoucherID, B5.APK AS InheritTransactionID
		INTO #TEMP_DNCT
		FROM BEMT2000 B2 WITH (NOLOCK)
			INNER JOIN BEMT2001 B3 WITH (NOLOCK) ON B2.APK = B3.APKMaster AND ISNULL(B3.DeleteFlg, 0) = 0
			INNER JOIN BEMT2000 B4 WITH (NOLOCK) ON B2.APKInherited = B4.APKInherited AND B2.InheritVoucherNo = B4.InheritVoucherNo
													AND ISNULL(B4.DeleteFlg, 0) = 0 AND B4.TypeID = 'DNTU'
			INNER JOIN BEMT2001 B5 WITH (NOLOCK) ON B4.APK = B5.APKMaster AND ISNULL(B5.DeleteFlg, 0) = 0
		WHERE B2.VoucherNo = @VoucherNo AND ISNULL(B2.DeleteFlg, 0) = 0

		SELECT A1.*, A1.DebitAccountID AS MediumAccountID
		FROM AT9010 A1 WITH (NOLOCK)
			INNER JOIN #TEMP_DNCT T1 ON A1.InheritVoucherID = T1.InheritVoucherID AND A1.InheritTransactionID = T1.InheritTransactionID

	END
	-- Trường hợp phiếu đề nghị kế thừa phiếu Đề nghị tạm ứng tạo tay
	ELSE IF (@InheritType = 'DNTU')
	BEGIN
		SELECT DISTINCT B5.APK AS InheritTransactionID
		INTO #TEMP_DNTU
		FROM BEMT2000 B2 WITH (NOLOCK)
			INNER JOIN BEMT2001 B3 WITH (NOLOCK) ON B2.APK = B3.APKMaster AND ISNULL(B3.DeleteFlg, 0) = 0
			INNER JOIN BEMT2000 B4 WITH (NOLOCK) ON B3.InheritVoucherNo = B4.VoucherNo AND ISNULL(B4.DeleteFlg, 0) = 0
			INNER JOIN BEMT2001 B5 WITH (NOLOCK) ON B3.InheritVoucherNo = B4.VoucherNo AND B5.APK = B3.APKDInherited AND ISNULL(B5.DeleteFlg, 0) = 0
		WHERE B2.VoucherNo = @VoucherNo AND ISNULL(B2.DeleteFlg, 0) = 0

		SELECT A1.APK, A1.DivisionID, A1.VoucherID, A1.BatchID, A1.TransactionID, A1.TableID, A1.TranMonth, A1.TranYear, A1.TransactionTypeID
			   , A1.CurrencyID, A1.ObjectID, A1.CreditObjectID, A1.VATNo, A1.VATObjectID, A1.VATObjectName, A1.VATObjectAddress, A1.DebitAccountID
			   , A1.CreditAccountID, A1.ExchangeRate, A1.UnitPrice, A1.OriginalAmount, A1.ConvertedAmount, A1.ImTaxOriginalAmount, A1.ImTaxConvertedAmount
			   , A1.ExpenseOriginalAmount, A1.ExpenseConvertedAmount, A1.IsStock, A1.VoucherDate, A1.InvoiceDate, A1.VoucherTypeID, A1.VATTypeID, A1.VATGroupID
			   , A1.VoucherNo, A1.Serial, A1.InvoiceNo, A1.Orders, A1.EmployeeID, A1.SenderReceiver, A1.SRDivisionName, A1.SRAddress, A1.RefNo01, A1.RefNo02
			   , A1.VDescription, A1.BDescription, A1.TDescription, A1.Quantity, A1.InventoryID, A1.UnitID, A1.Status, A1.IsAudit, A1.IsCost, A1.Ana01ID
			   , A1.Ana02ID, A1.Ana03ID, A1.PeriodID, A1.ExpenseID, A1.MaterialTypeID, A1.ProductID, A1.CreateDate, A1.CreateUserID, A1.LastModifyDate
			   , A1.LastModifyUserID, A1.OriginalAmountCN, A1.ExchangeRateCN, A1.CurrencyIDCN, A1.DueDays, A1.PaymentID, A1.DueDate, A1.DiscountRate
			   , A1.OrderID, A1.CreditBankAccountID, A1.DebitBankAccountID, A1.CommissionPercent, A1.InventoryName1, A1.Ana04ID, A1.Ana05ID, A1.PaymentTermID
			   , A1.DiscountAmount, A1.OTransactionID, A1.IsMultiTax, A1.VATOriginalAmount, A1.VATConvertedAmount, A1.ReVoucherID, A1.Ana06ID, A1.Ana07ID, A1.Ana08ID
			   , A1.Ana09ID, A1.Ana10ID, A1.InvoiceCode, A1.InvoiceSign, A1.InheritVoucherID, A1.InheritTransactionID, A1.InheritTypeID, A1.InheritTableID
			   , A1.TVoucherID, A1.TBatchID, A1.PaymentExchangeRate, B1.MediumAccountID
		FROM AT9010 A1 WITH (NOLOCK)
			INNER JOIN #TEMP_DNTU T1 ON A1.InheritTransactionID = T1.InheritTransactionID
			INNER JOIN BEMT2001 B1 WITH (NOLOCK) ON B1.APKDInherited = T1.InheritTransactionID
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
