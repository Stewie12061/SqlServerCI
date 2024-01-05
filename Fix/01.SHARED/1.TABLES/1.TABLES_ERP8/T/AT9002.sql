﻿-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Việt Khánh
---- Modified on 10/07/2014 by Trần Quốc Tuấn: thêm trường InvoiceCode và InvoiceSign của AT9002
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT9002]') AND type in (N'U'))
CREATE TABLE [dbo].[AT9002](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] [nvarchar] (3) NOT NULL,
	[TemplateTransactionID] [nvarchar](50) NOT NULL,
	[TemplateID] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IsStockVoucher] [tinyint] NOT NULL,
	[TableID] [nvarchar](50) NOT NULL,
	[TransactionTypeID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ObjectID] [nvarchar](50) NULL,
	[VATObjectID] [nvarchar](50) NULL,
	[VATObjectName] [nvarchar](250) NULL,
	[DebitAccountID] [nvarchar](50) NULL,
	[CreditAccountID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[DiscountRate] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VATTypeID] [nvarchar](50) NULL,
	[VATGroupID] [nvarchar](50) NULL,
	[Orders] [int] NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[SenderReceiver] [nvarchar](250) NULL,
	[SRDivisionName] [nvarchar](250) NULL,
	[SRAddress] [nvarchar](250) NULL,
	[VDescription] [nvarchar](250) NULL,
	[BDescription] [nvarchar](250) NULL,
	[TDescription] [nvarchar](250) NULL,
	[WareHouseID] [nvarchar](50) NULL,
	[WareHouseID2] [nvarchar](50) NULL,
	[Quantity] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,
	[SourceNo] [nvarchar](50) NULL,
	[LocationID] [nvarchar](50) NULL,
	[LimitDate] [datetime] NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[ProductID] [nvarchar](50) NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[TemplateVoucherID] [nvarchar](50) NULL,
	[TemplateBatchID] [nvarchar](50) NULL,
	[CreditObjectID] [nvarchar](50) NULL,
	[CommissionPercent] [decimal](28, 8) NULL,
	[DebitBankAccountID] [nvarchar](50) NULL,
	[CreditBankAccountID] [nvarchar](50) NULL,
	[Serial] [nvarchar](50) NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[VATNo] [nvarchar](50) NULL,
	[VATObjectAddress] [nvarchar](250) NULL,
	[VoucherDate] [datetime] NULL,
	[InvoiceDate] [datetime] NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[RefNo01] [nvarchar](100) NULL,
	[RefNo02] [nvarchar](100) NULL,
	[DueDate] [datetime] NULL,
	[InventoryName1] [nvarchar](50) NULL,
	[AirportAmount] [decimal](28, 8) NULL,
	[VATAmount] [decimal](28, 8) NULL,
	[PeriodID] [nvarchar](50) NULL,
CONSTRAINT [PK_AT9002] PRIMARY KEY CLUSTERED 
(
	[TemplateTransactionID] ASC,
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9002' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9002' AND col.name='InvoiceCode')
	ALTER TABLE AT9002 ADD InvoiceCode NVARCHAR (50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9002' AND col.name='InvoiceSign')
	ALTER TABLE AT9002 ADD InvoiceSign NVARCHAR (50) NULL
END
If Exists (Select * From sysobjects Where name = 'AT9002' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'AT9002'  and col.name = 'Ana06ID')
Alter Table  AT9002 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End