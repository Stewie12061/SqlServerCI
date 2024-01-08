-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Việt Khánh
---- Modified on 18/02/2014 by Thanh Sơn
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on 07/12/2021 by Nhật Thanh: Tăng độ dài VDescription BDescription TDescription lên 500
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT9010]') AND type in (N'U'))
CREATE TABLE [dbo].[AT9010](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] [nvarchar] (3) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[BatchID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[TableID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[TransactionTypeID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ObjectID] [nvarchar](50) NULL,
	[CreditObjectID] [nvarchar](50) NULL,
	[VATNo] [nvarchar](50) NULL,
	[VATObjectID] [nvarchar](50) NULL,
	[VATObjectName] [nvarchar](250) NULL,
	[VATObjectAddress] [nvarchar](250) NULL,
	[DebitAccountID] [nvarchar](50) NULL,
	[CreditAccountID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[ImTaxOriginalAmount] [decimal](28, 8) NULL,
	[ImTaxConvertedAmount] [decimal](28, 8) NULL,
	[ExpenseOriginalAmount] [decimal](28, 8) NULL,
	[ExpenseConvertedAmount] [decimal](28, 8) NULL,
	[IsStock] [tinyint] NOT NULL,
	[VoucherDate] [datetime] NULL,
	[InvoiceDate] [datetime] NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VATTypeID] [nvarchar](50) NULL,
	[VATGroupID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[Serial] [nvarchar](50) NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[Orders] [int] NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[SenderReceiver] [nvarchar](250) NULL,
	[SRDivisionName] [nvarchar](250) NULL,
	[SRAddress] [nvarchar](250) NULL,
	[RefNo01] [nvarchar](100) NULL,
	[RefNo02] [nvarchar](100) NULL,
	[VDescription] [nvarchar](500) NULL,
	[BDescription] [nvarchar](500) NULL,
	[TDescription] [nvarchar](500) NULL,
	[Quantity] [decimal](28, 8) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NOT NULL,
	[IsAudit] [tinyint] NOT NULL,
	[IsCost] [tinyint] NOT NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[PeriodID] [nvarchar](50) NULL,
	[ExpenseID] [nvarchar](50) NULL,
	[MaterialTypeID] [nvarchar](50) NULL,
	[ProductID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[OriginalAmountCN] [decimal](28, 8) NULL,
	[ExchangeRateCN] [decimal](28, 8) NULL,
	[CurrencyIDCN] [nvarchar](50) NULL,
	[DueDays] [int] NULL,
	[PaymentID] [nvarchar](50) NULL,
	[DueDate] [datetime] NULL,
	[DiscountRate] [decimal](28, 8) NULL,
	[OrderID] [nvarchar](50) NULL,
	[CreditBankAccountID] [nvarchar](50) NULL,
	[DebitBankAccountID] [nvarchar](50) NULL,
	[CommissionPercent] [decimal](28, 8) NULL,
	[InventoryName1] [nvarchar](250) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[PaymentTermID] [nvarchar](50) NULL,
	[DiscountAmount] [decimal](28, 8) NULL,
	[OTransactionID] [nvarchar](50) NULL,
	[IsMultiTax] [tinyint] NULL,
	[VATOriginalAmount] [decimal](28, 8) NULL,
	[VATConvertedAmount] [decimal](28, 8) NULL,
	[ReVoucherID] [nvarchar](50) NULL,
CONSTRAINT [PK_AT9010] PRIMARY KEY NONCLUSTERED 
(
	[TransactionID] ASC,
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT9010_BatchID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT9010] ADD  CONSTRAINT [DF_AT9010_BatchID]  DEFAULT ('AT9010') FOR [BatchID]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT9010_IsStock]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT9010] ADD  CONSTRAINT [DF_AT9010_IsStock]  DEFAULT ((0)) FOR [IsStock]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT9010_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT9010] ADD  CONSTRAINT [DF_AT9010_Status]  DEFAULT ((0)) FOR [Status]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT9010_IsAudit]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT9010] ADD  CONSTRAINT [DF_AT9010_IsAudit]  DEFAULT ((0)) FOR [IsAudit]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT9010_IsCost]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT9010] ADD  CONSTRAINT [DF_AT9010_IsCost]  DEFAULT ((0)) FOR [IsCost]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT9010__IsMultiT__7A7D0802]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT9010] ADD  CONSTRAINT [DF__AT9010__IsMultiT__7A7D0802]  DEFAULT ((0)) FOR [IsMultiTax]
END
---- Add Columns
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9010' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9010' AND col.name='InvoiceCode')
	ALTER TABLE AT9010 ADD InvoiceCode NVARCHAR (50) NULL
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9010' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9010' AND col.name='InvoiceSign')
	ALTER TABLE AT9010 ADD InvoiceSign NVARCHAR (50) NULL
END
If Exists (Select * From sysobjects Where name = 'AT9010' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'AT9010'  and col.name = 'Ana06ID')
Alter Table  AT9010 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End

--- Modified by Bảo Thy on 20/06/2017: Add column kế thừa từ AF0107 (GODREJ)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9010' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'InheritVoucherID') 
   ALTER TABLE AT9010 ADD InheritVoucherID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'InheritTransactionID') 
   ALTER TABLE AT9010 ADD InheritTransactionID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'InheritTypeID') 
   ALTER TABLE AT9010 ADD InheritTypeID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'InheritTableID') 
   ALTER TABLE AT9010 ADD InheritTableID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'TVoucherID') 
   ALTER TABLE AT9010 ADD TVoucherID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'TBatchID') 
   ALTER TABLE AT9010 ADD TBatchID VARCHAR(50) NULL 
END

---- Modified on 03/02/2021 by Vĩnh Tâm: Bổ sung cột PaymentExchangeRate
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'PaymentExchangeRate')
BEGIN
	ALTER TABLE AT9010 ADD PaymentExchangeRate DECIMAL(28,8) NULL
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9010' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9010' AND col.name='IsConfirm01')
	ALTER TABLE AT9010 ADD IsConfirm01 TINYINT NULL
	
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9010' AND col.name='IsConfirm02')
	ALTER TABLE AT9010 ADD IsConfirm02 TINYINT NULL
	
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9010' AND col.name='DescriptionConfirm01')
	ALTER TABLE AT9010 ADD DescriptionConfirm01 NVARCHAR(250) NULL
	
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9010' AND col.name='DescriptionConfirm02')
	ALTER TABLE AT9010 ADD DescriptionConfirm02 NVARCHAR(250) NULL
END

---- Modified on 24/08/2022 by Đức Tuyên:
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9010' AND xtype='U')
BEGIN

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'APKMaster_9000')
		ALTER TABLE AT9010 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'ApproveLevel') 
		ALTER TABLE AT9010 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'ApprovingLevel') 
		ALTER TABLE AT9010 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'TransactionMode')
		ALTER TABLE AT9010 ADD TransactionMode [nvarchar](50) NULL

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'DeleteFlag')
    ALTER TABLE AT9010 ADD DeleteFlag TINYINT DEFAULT 0

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'BDescription')
    ALTER TABLE AT9010 ALTER COLUMN BDescription [nvarchar](500) NULL

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'TDescription')
    ALTER TABLE AT9010 ALTER COLUMN TDescription [nvarchar](500) NULL

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'VDescription')
    ALTER TABLE AT9010 ALTER COLUMN VDescription [nvarchar](500) NULL

END

---- Modified on 03/02/2023 by Nhật Quang: Bổ sung cột OrderVoucherNo
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT9010' AND col.name = 'OrderVoucherNo')
BEGIN
	ALTER TABLE AT9010 ADD OrderVoucherNo nvarchar(50) NULL
END