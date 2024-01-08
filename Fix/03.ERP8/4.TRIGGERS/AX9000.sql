IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AX9000]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[AX9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--CREATE  TRIGGER AX9000 ON AT9000 
--FOR DELETE 
--AS

--Declare		@hostname		as nvarchar(128),
--		@appname		as nvarchar(128)

--	Select @hostname = hostname, @appname = program_name 
--	from master..sysprocesses where spid = @@spid

--	Insert Into AT0911
--	Select
--	[VoucherID],
--	[BatchID],
--	[TransactionID],
--	[TableID],
--	[DivisionID],
--	[TranMonth],
--	[TranYear],
--	[TransactionTypeID],
--	[CurrencyID],
--	[ObjectID],
--	[CreditObjectID],
--	[VATNo],
--	[VATObjectID],
--	[VATObjectName],
--	[VATObjectAddress],
--	[DebitAccountID],
--	[CreditAccountID],
--	[ExchangeRate],
--	[UnitPrice],
--	[OriginalAmount],
--	[ConvertedAmount],
--	[ImTaxOriginalAmount],
--	[ImTaxConvertedAmount],
--	[ExpenseOriginalAmount],
--	[ExpenseConvertedAmount],
--	[IsStock],
--	[VoucherDate],
--	[InvoiceDate],
--	[VoucherTypeID],
--	[VATTypeID],
--	[VATGroupID],
--	[VoucherNo],
--	[Serial],
--	[InvoiceNo],
--	[Orders],
--	[EmployeeID],
--	[SenderReceiver],
--	[SRDivisionName],
--	[SRAddress],
--	[RefNo01],
--	[RefNo02],
--	[VDescription],
--	[BDescription],
--	[TDescription],
--	[Quantity],
--	[InventoryID],
--	[UnitID],
--	[Status],
--	[IsAudit],
--	[IsCost],
--	[Ana01ID],
--	[Ana02ID],
--	[Ana03ID],
--	[PeriodID],
--	[ExpenseID],
--	[MaterialTypeID],
--	[ProductID],
--	[CreateDate],
--	[CreateUserID],
--	[LastModifyDate],
--	[LastModifyUserID],
--	[OriginalAmountCN],
--	[ExchangeRateCN],
--	[CurrencyIDCN],
--	[DueDays],
--	[PaymentID],
--	[DueDate],
--	[DiscountRate],
--	[OrderID],
--	[CreditBankAccountID],
--	[DebitBankAccountID],
--	[CommissionPercent],
--	[InventoryName1],
--	[Ana04ID],
--	[Ana05ID],
--	[PaymentTermID],
--	[DiscountAmount],
--	@hostname,
--	@appname,
--	2,
--	getdate()
--	from deleted



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
