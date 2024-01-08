IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3411_THL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3411_THL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





--Create by: Dang Le Bao Quynh; Date 10/12/2008
--Purpose: Tinh nang ban hang nhieu nhom thue
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [29/07/2010]
'**************************************************************/
---- Modified on 01/07/2014 by Lê Thi Thu Hien : Bổ sung thêm 1 số trường
-- Modify by Phương Thảo on 29/02/2016: Bổ sung lưu thành nhiều dòng thuế nếu check chọn Nhiều tỷ giá
-- Modify by Tấn Phú on 09/01/2019: Bổ sung lưu dòng thuế các thông tin InvoiceSign, InvoiceCode
-- Modify by Hoàng Vũ on 25/01/2019: Bổ sung trường IsInvoiceSuggest để quản lý thuế kế thừa từ đề ngị xuất hóa đơn
-- Modify by Hoài Phong on 25/11/2020: Bổ sung Tách nhiều nhóm thuế cho THL
-- Modify by Nhựt Trường on 28/12/2020: Bổ sung thêm điều kiện nếu mã phân tích null.

CREATE PROCEDURE [dbo].[AP3411_THL]  
				@DivisionID nvarchar(50),
				@TranMonth int,
				@TranYear int,
				@VoucherID nvarchar(50),
				@BatchID nvarchar(50),
				@TaxObjectID nvarchar(50),
				@TaxDebitAccountID nvarchar(50),
				@TaxCreditAccountID nvarchar(50),
				@TaxDescription nvarchar(250),
				@Type as int -- 1 Add, 2 Edit
AS
Declare 
		@cur as cursor,
		@VATGroupID as nvarchar(50),
		@TransactionID as nvarchar(50),
		@OriginalAmount as decimal(28,8),
		@ConvertedAmount as decimal(28,8),
		@ReTableID AS NVARCHAR(50),
		@ReVoucherID AS NVARCHAR(50),
		@Anas AS NVARCHAR(MAX),
		@AnaTemp AS NVARCHAR(MAX)


If @Type = 2
Begin
	Delete AT9000 Where 	VoucherID = @VoucherID And 
				--BatchID = @BatchID And
				TransactionTypeID = 'T14' AND DivisionID = @DivisionID
End

Set @cur = cursor static for
		Select VATGroupID,BatchID ,Sum(isnull(VATOriginalAmount,0)), Sum(isnull(VATConvertedAmount,0)) 
		,CONCAT(Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID) AS Anas		
		From AT9000 
		Where 	VoucherID = @VoucherID And 
			--BatchID = @BatchID And
			TransactionTypeID = 'T04'
			And DivisionID=@DivisionID
		Group By VATGroupID,BatchID,CONCAT(Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID)
		ORDER BY CONCAT(Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID)
open @cur
Fetch Next From @cur Into @VATGroupID, @BatchID, @OriginalAmount, @ConvertedAmount, @Anas
While @@Fetch_Status = 0
BEGIN
	IF(ISNULL(@Anas, '') = '')
	BEGIN
	Insert Into AT9000 
		(
			VoucherID, BatchID, TransactionID, TableID, 
			DivisionID, TranMonth, TranYear, TransactionTypeID, 
			CurrencyID, ObjectID, 
			VATNo, VATObjectID, VATObjectName, VATObjectAddress, 
			DebitAccountID, CreditAccountID, ExchangeRate, 
			OriginalAmount, ConvertedAmount,
			VoucherDate, InvoiceDate, VoucherTypeID, VATTypeID, 
			VATGroupID, VoucherNo, Serial, InvoiceNo, 
			EmployeeID, SenderReceiver, SRDivisionName, SRAddress,
			VDescription, BDescription, TDescription, 
			CreateDate, CreateUserID, LastModifyDate, LastModifyUserID,
			OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, DueDays, PaymentID, DueDate, OrderID ,
			ReVoucherID, ReTableID, IsStock, InvoiceSign,InvoiceCode, IsInvoiceSuggest,
			Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,IsMultiTax
		)
		Select Top 1 
			VoucherID, BatchID, NEWID(), 'AT9000', 
			DivisionID, TranMonth, TranYear, 'T14',
			CurrencyID, @TaxObjectID, 
			VATNo, VATObjectID, VATObjectName, VATObjectAddress, 
			@TaxDebitAccountID, @TaxCreditAccountID, ExchangeRate, 
			@OriginalAmount, @ConvertedAmount, 
			VoucherDate, InvoiceDate, VoucherTypeID, VATTypeID, 
			@VATGroupID, VoucherNo, Serial, InvoiceNo, 
			EmployeeID, SenderReceiver, SRDivisionName, SRAddress,
			VDescription, BDescription, @TaxDescription, 
			CreateDate, CreateUserID, LastModifyDate, LastModifyUserID,
			@OriginalAmount, ExchangeRateCN, CurrencyIDCN, DueDays, PaymentID, DueDate, OrderID ,
			ReVoucherID, ReTableID, IsStock, InvoiceSign,InvoiceCode, IsInvoiceSuggest,
			Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,IsMultiTax

		From AT9000 
		Where DivisionID=@DivisionID And	VoucherID = @VoucherID And 
			BatchID = @BatchID
	END

	ELSE IF(ISNULL (@AnaTemp ,'') <> ISNULL(@Anas,''))
	BEGIN
		Insert Into AT9000 
		(
			VoucherID, BatchID, TransactionID, TableID, 
			DivisionID, TranMonth, TranYear, TransactionTypeID, 
			CurrencyID, ObjectID, 
			VATNo, VATObjectID, VATObjectName, VATObjectAddress, 
			DebitAccountID, CreditAccountID, ExchangeRate, 
			OriginalAmount, ConvertedAmount,
			VoucherDate, InvoiceDate, VoucherTypeID, VATTypeID, 
			VATGroupID, VoucherNo, Serial, InvoiceNo, 
			EmployeeID, SenderReceiver, SRDivisionName, SRAddress,
			VDescription, BDescription, TDescription, 
			CreateDate, CreateUserID, LastModifyDate, LastModifyUserID,
			OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, DueDays, PaymentID, DueDate, OrderID ,
			ReVoucherID, ReTableID, IsStock, InvoiceSign,InvoiceCode, IsInvoiceSuggest,
			Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,IsMultiTax
		)
		Select Top 1 
			VoucherID, BatchID, NEWID(), 'AT9000', 
			DivisionID, TranMonth, TranYear, 'T14',
			CurrencyID, @TaxObjectID, 
			VATNo, VATObjectID, VATObjectName, VATObjectAddress, 
			@TaxDebitAccountID, @TaxCreditAccountID, ExchangeRate, 
			@OriginalAmount, @ConvertedAmount, 
			VoucherDate, InvoiceDate, VoucherTypeID, VATTypeID, 
			@VATGroupID, VoucherNo, Serial, InvoiceNo, 
			EmployeeID, SenderReceiver, SRDivisionName, SRAddress,
			VDescription, BDescription, @TaxDescription, 
			CreateDate, CreateUserID, LastModifyDate, LastModifyUserID,
			@OriginalAmount, ExchangeRateCN, CurrencyIDCN, DueDays, PaymentID, DueDate, OrderID ,
			ReVoucherID, ReTableID, IsStock, InvoiceSign,InvoiceCode, IsInvoiceSuggest,
			Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,IsMultiTax

		From AT9000 
		Where DivisionID=@DivisionID And	VoucherID = @VoucherID And 
			BatchID = @BatchID And
			CONCAT(Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID) = @Anas
			
	END 	
	SET @AnaTemp = @Anas
	Fetch Next From @cur Into @VATGroupID, @BatchID, @OriginalAmount, @ConvertedAmount, @Anas
	
END
CLOSE @cur 




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
