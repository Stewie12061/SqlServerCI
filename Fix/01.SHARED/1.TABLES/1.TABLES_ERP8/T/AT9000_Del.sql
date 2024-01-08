-- <Summary>
---- 
-- <History>
---- Create on 02/01/2020 by Kiều Nga
---- Chuyến fix từ Dự án sang STD by Đình Hòa 13/01/2021
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT9000_Del]') AND type in (N'U'))
CREATE TABLE [dbo].[AT9000_Del](
	[APK] [uniqueidentifier] NULL DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[BatchID] [nvarchar](50) NOT NULL DEFAULT ('AT9000_Del'),
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
	[IsStock] [tinyint] NOT NULL DEFAULT ((0)),
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
	[VDescription] [nvarchar](250) NULL,
	[BDescription] [nvarchar](250) NULL,
	[TDescription] [nvarchar](250) NULL,
	[Quantity] [decimal](28, 8) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NOT NULL DEFAULT ((0)),
	[IsAudit] [tinyint] NOT NULL DEFAULT ((0)),
	[IsCost] [tinyint] NOT NULL DEFAULT ((0)),
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
	[ReBatchID] [nvarchar](50) NULL,
	[ReTransactionID] [nvarchar](50) NULL,
	[Parameter01] [varchar](250) NULL,
	[Parameter02] [varchar](250) NULL,
	[Parameter03] [varchar](250) NULL,
	[Parameter04] [varchar](250) NULL,
	[Parameter05] [varchar](250) NULL,
	[Parameter06] [varchar](250) NULL,
	[Parameter07] [varchar](250) NULL,
	[Parameter08] [varchar](250) NULL,
	[Parameter09] [varchar](250) NULL,
	[Parameter10] [varchar](250) NULL,
 CONSTRAINT [PK_AT9000_Del] PRIMARY KEY NONCLUSTERED 
(
	[TransactionID] ASC,
	[TableID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ConvertedQuantity')
		ALTER TABLE AT9000_Del ADD ConvertedQuantity DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ConvertedPrice')
		ALTER TABLE AT9000_Del ADD ConvertedPrice DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ConvertedUnitID')
		ALTER TABLE AT9000_Del ADD ConvertedUnitID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ConversionFactor')
		ALTER TABLE AT9000_Del ADD ConversionFactor DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='UParameter01')
		ALTER TABLE AT9000_Del ADD UParameter01 DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='UParameter02')
		ALTER TABLE AT9000_Del ADD UParameter02 DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='UParameter03')
		ALTER TABLE AT9000_Del ADD UParameter03 DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='UParameter04')
		ALTER TABLE AT9000_Del ADD UParameter04 DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='UParameter05')
		ALTER TABLE AT9000_Del ADD UParameter05 DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='IsLateInvoice')
		ALTER TABLE AT9000_Del ADD IsLateInvoice TINYINT DEFAULT(0) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='MOrderID')
		ALTER TABLE AT9000_Del ADD MOrderID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SOrderID')
		ALTER TABLE AT9000_Del ADD SOrderID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='MTransactionID')
		ALTER TABLE AT9000_Del ADD MTransactionID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='STransactionID')
		ALTER TABLE AT9000_Del ADD STransactionID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='RefVoucherNo')
		ALTER TABLE AT9000_Del ADD RefVoucherNo NVARCHAR(50) NULL
	END
If Exists (Select * From sysobjects Where name = 'AT9000_Del' and xtype ='U') 
Begin 
	If not exists (select * from syscolumns col inner join sysobjects tab 
   On col.id = tab.id where tab.name = 'AT9000_Del' and col.name = 'TBatchID') 
   Alter Table  AT9000_Del Add TBatchID nvarchar(50) Null 
End 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='DParameter01')
		ALTER TABLE AT9000_Del ADD DParameter01 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='DParameter02')
		ALTER TABLE AT9000_Del ADD DParameter02 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='DParameter03')
		ALTER TABLE AT9000_Del ADD DParameter03 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='DParameter04')
		ALTER TABLE AT9000_Del ADD DParameter04 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='DParameter05')
		ALTER TABLE AT9000_Del ADD DParameter05 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='DParameter06')
		ALTER TABLE AT9000_Del ADD DParameter06 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='DParameter07')
		ALTER TABLE AT9000_Del ADD DParameter07 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='DParameter08')
		ALTER TABLE AT9000_Del ADD DParameter08 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='DParameter09')
		ALTER TABLE AT9000_Del ADD DParameter09 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='DParameter10')
		ALTER TABLE AT9000_Del ADD DParameter10 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='InheritTableID')
		ALTER TABLE AT9000_Del ADD InheritTableID NVARCHAR(50) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='InheritVoucherID')
		ALTER TABLE AT9000_Del ADD InheritVoucherID VARCHAR(50) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='InheritTransactionID')
		ALTER TABLE AT9000_Del ADD InheritTransactionID VARCHAR(50) NULL
	END
-- Thuế bảo vệ môi trường - hỗ trợ 20/03/2015
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ETaxVoucherID')
		ALTER TABLE AT9000_Del ADD ETaxVoucherID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ETaxID')
		ALTER TABLE AT9000_Del ADD ETaxID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ETaxConvertedUnit')
		ALTER TABLE AT9000_Del ADD ETaxConvertedUnit DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ETaxConvertedAmount')
		ALTER TABLE AT9000_Del ADD ETaxConvertedAmount DECIMAL(28,8) NULL
	END
---- Modified on 25/03/2015 by Lê Thị Hạnh: Thêm trường ETaxTransactionID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ETaxTransactionID')
		ALTER TABLE AT9000_Del ADD ETaxTransactionID NVARCHAR(50) NULL
	END
---- Modified on 27/05/2015 by Lê Thị Hạnh: Thêm trường thuế tiêu thụ đặc biệt
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='AssignedSET')
		ALTER TABLE AT9000_Del ADD AssignedSET TINYINT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SETID')
		ALTER TABLE AT9000_Del ADD SETID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SETUnitID')
		ALTER TABLE AT9000_Del ADD SETUnitID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SETTaxRate')
		ALTER TABLE AT9000_Del ADD SETTaxRate DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SETConvertedUnit')
		ALTER TABLE AT9000_Del ADD SETConvertedUnit DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SETQuantity')
		ALTER TABLE AT9000_Del ADD SETQuantity DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SETOriginalAmount')
		ALTER TABLE AT9000_Del ADD SETOriginalAmount DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SETConvertedAmount')
		ALTER TABLE AT9000_Del ADD SETConvertedAmount DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SETConsistID')
		ALTER TABLE AT9000_Del ADD SETConsistID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SETTransactionID')
		ALTER TABLE AT9000_Del ADD SETTransactionID NVARCHAR(50) NULL
	END
---- Modified on 01/06/2015 by Lê Thị Hạnh: Thêm trường thuế tiêu tài nguyên
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='AssignedNRT')
		ALTER TABLE AT9000_Del ADD AssignedNRT TINYINT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='NRTTaxAmount')
		ALTER TABLE AT9000_Del ADD NRTTaxAmount DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='NRTClassifyID')
		ALTER TABLE AT9000_Del ADD NRTClassifyID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='NRTUnitID')
		ALTER TABLE AT9000_Del ADD NRTUnitID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='NRTTaxRate')
		ALTER TABLE AT9000_Del ADD NRTTaxRate DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='NRTConvertedUnit')
		ALTER TABLE AT9000_Del ADD NRTConvertedUnit DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='NRTQuantity')
		ALTER TABLE AT9000_Del ADD NRTQuantity DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='NRTOriginalAmount')
		ALTER TABLE AT9000_Del ADD NRTOriginalAmount DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='NRTConvertedAmount')
		ALTER TABLE AT9000_Del ADD NRTConvertedAmount DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='NRTConsistID')
		ALTER TABLE AT9000_Del ADD NRTConsistID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='NRTTransactionID')
		ALTER TABLE AT9000_Del ADD NRTTransactionID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='InvoiceCode')
	ALTER TABLE AT9000_Del ADD InvoiceCode NVARCHAR (50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='InvoiceSign')
	ALTER TABLE AT9000_Del ADD InvoiceSign NVARCHAR (50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ReTableID')
	ALTER TABLE AT9000_Del ADD ReTableID NVARCHAR (50) NULL		
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'TVoucherID')
	Alter Table  AT9000_Del Add TVoucherID NVARCHAR(50) NULL
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'OldCounter')
	Alter Table  AT9000_Del Add OldCounter Decimal(28,8) NULL
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'NewCounter')
	Alter Table  AT9000_Del Add NewCounter Decimal(28,8) NULL
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'OtherCounter')
	Alter Table  AT9000_Del Add OtherCounter Decimal(28,8) NULL	
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'WOrderID')
	Alter Table  AT9000_Del Add WOrderID NVARCHAR(50) NULL
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'WTransactionID')
	Alter Table  AT9000_Del Add WTransactionID NVARCHAR(50) NULL	
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'MarkQuantity')
	Alter Table  AT9000_Del Add MarkQuantity DECIMAL(28,8) NULL
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='RefInfor')
	ALTER TABLE AT9000_Del ADD RefInfor NVARCHAR (250) NULL
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='StandardPrice')
	ALTER TABLE AT9000_Del ADD StandardPrice DECIMAL(28,8) DEFAULT (0) NULL
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='StandardAmount')
	ALTER TABLE AT9000_Del ADD StandardAmount DECIMAL(28,8) DEFAULT (0) NULL
END
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='IsCom')
	ALTER TABLE AT9000_Del ADD IsCom tinyint DEFAULT (0) NULL
END
If Exists (Select * From sysobjects Where name = 'AT9000_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'PriceListID')
           Alter Table  AT9000_Del Add PriceListID nvarchar(50) Null
END
If Exists (Select * From sysobjects Where name = 'AT9000_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'WOrderID')
           Alter Table  AT9000_Del Add WOrderID NVARCHAR(50) NULL
           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'WTransactionID')
           Alter Table  AT9000_Del Add WTransactionID NVARCHAR(50) NULL
           
           --- Bổ sung trường nhận biết kế thừa hợp đồng (Sinolife)
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'ContractDetailID')
           Alter Table  AT9000_Del Add ContractDetailID NVARCHAR(50) NULL
End 
If Exists (Select * From sysobjects Where name = 'AT9000_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'MarkQuantity')
           Alter Table  AT9000_Del Add MarkQuantity DECIMAL(28,8) NULL
END
If Exists (Select * From sysobjects Where name = 'AT9000_Del' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'AT9000_Del'  and col.name = 'Ana06ID')
Alter Table  AT9000_Del Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
END
--Bố sung thêm cột CreditObjectName,
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='CreditObjectName')
		ALTER TABLE AT9000_Del ADD CreditObjectName NVARCHAR(500) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='CreditVATNo')
		ALTER TABLE AT9000_Del ADD CreditVATNo NVARCHAR(500) NULL
	END
---- Alter Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='Parameter01')
		ALTER TABLE AT9000_Del ALTER COLUMN Parameter01 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='Parameter02')
		ALTER TABLE AT9000_Del ALTER COLUMN Parameter02 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='Parameter03')
		ALTER TABLE AT9000_Del ALTER COLUMN Parameter03 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='Parameter04')
		ALTER TABLE AT9000_Del ALTER COLUMN Parameter04 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='Parameter05')
		ALTER TABLE AT9000_Del ALTER COLUMN Parameter05 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='Parameter06')
		ALTER TABLE AT9000_Del ALTER COLUMN Parameter06 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='Parameter07')
		ALTER TABLE AT9000_Del ALTER COLUMN Parameter07 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='Parameter08')
		ALTER TABLE AT9000_Del ALTER COLUMN Parameter08 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='Parameter09')
		ALTER TABLE AT9000_Del ALTER COLUMN Parameter09 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='Parameter10')
		ALTER TABLE AT9000_Del ALTER COLUMN Parameter10 NVARCHAR(250) NULL 
	END
 IF((ISNULL(COL_LENGTH('AT9000_Del', 'OrderID'), 0)/2)<=50)
 ALTER TABLE AT9000_Del ALTER COLUMN OrderID NVARCHAR(500)

 IF((ISNULL(COL_LENGTH('AT9000_Del', 'InheritTransactionID'), 0)/2)<=50)
 ALTER TABLE AT9000_Del ALTER COLUMN InheritTransactionID NVARCHAR(2000)

--- Thêm check chi phí mua hàng IsPOCost[LAVO]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='IsPOCost')
		ALTER TABLE AT9000_Del ADD IsPOCost TINYINT NULL
	END

--- Them truong tri gia tinh thue nha thau
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'TaxBaseAmount')
        ALTER TABLE AT9000_Del ADD TaxBaseAmount DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'WTCExchangeRate')
        ALTER TABLE AT9000_Del ADD WTCExchangeRate DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'WTCOperator')
        ALTER TABLE AT9000_Del ADD WTCOperator TINYINT NULL
    END

--- But toan chi phi hinh thanh TSCD
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsFACost')
        ALTER TABLE AT9000_Del ADD IsFACost TINYINT NULL
    END

--- Phieu tap hop TSCĐ
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsInheritFA')
        ALTER TABLE AT9000_Del ADD IsInheritFA TINYINT NULL
    END

--- Khoa cua phieu tap hop TSCD, luu vao cac but toan hinh thanh
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'InheritedFAVoucherID')
        ALTER TABLE AT9000_Del ADD InheritedFAVoucherID NVARCHAR(50) NULL
    END

--- Modify by Phương Thảo
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'AVRExchangeRate')
        ALTER TABLE AT9000_Del ADD AVRExchangeRate DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'PaymentExchangeRate')
    ALTER TABLE AT9000_Del ADD PaymentExchangeRate DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsMultiExR')
        ALTER TABLE AT9000_Del ADD IsMultiExR TINYINT NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'ExchangeRateDate')
        ALTER TABLE AT9000_Del ADD ExchangeRateDate DATETIME NULL
    END

--- Modify on 11/01/2016 by Bảo Anh: Bổ sung các trường cho Angel
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
		--- Số tiền được hưởng chiết khấu doanh số
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'DiscountSalesAmount')
        ALTER TABLE AT9000_Del ADD DiscountSalesAmount Decimal(28,8) NULL
		--- Check là hàng khuyến mãi
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsProInventoryID')
        ALTER TABLE AT9000_Del ADD IsProInventoryID tinyint NULL
		--- Số lượng yêu cầu
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'InheritQuantity')
        ALTER TABLE AT9000_Del ADD InheritQuantity Decimal(28,8) NULL
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'DiscountPercentSOrder')
        ALTER TABLE AT9000_Del ADD DiscountPercentSOrder Decimal(28,8) NULL, DiscountAmountSOrder Decimal(28,8) NULL
    END	    

---- Modify by Phương Thảo on 01/02/2016
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsWithhodingTax')
        ALTER TABLE AT9000_Del ADD IsWithhodingTax TINYINT NULL
    END
---- Modify by Hoàng Vũ on 17/02/2016: CuatomizeIndex = 51 (Hoàng Trần)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsSaleInvoice')
        ALTER TABLE AT9000_Del ADD IsSaleInvoice TINYINT NULL
    END	
---------------------------Sửa kiểu dữ liệu Decimal -> datetime--> Databsae hoàng trần lỗi
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ExchangeRateDate')
	Alter Table AT9000_Del
		Alter column ExchangeRateDate DateTime NULL
END	
---- Modify by Quốc tuấn thêm 2 cột đủ bảng nâng cáp từ bảng thấp lên thiếu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'VirtualPrice')
        ALTER TABLE AT9000_Del ADD VirtualPrice Decimal(28,8) NULL
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'VirtualAmount')
        ALTER TABLE AT9000_Del ADD VirtualAmount Decimal(28,8) NULL
    END	    

--- Bổ sung trường xử lý thuế nhà thầu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'WTTransID')
        ALTER TABLE AT9000_Del ADD WTTransID NVARCHAR(50) NULL
    END
    
--- Bổ sung trường cho ANGEL
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'DiscountSaleAmountDetail')
        ALTER TABLE AT9000_Del ADD DiscountSaleAmountDetail DECIMAL(28,8) NULL
    END

---- Modified by Hải Long on 18/08/2016: Bổ sung các trường cho ABA
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ABParameter01')
		ALTER TABLE AT9000_Del ADD ABParameter01 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ABParameter02')
		ALTER TABLE AT9000_Del ADD ABParameter02 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ABParameter03')
		ALTER TABLE AT9000_Del ADD ABParameter03 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ABParameter04')
		ALTER TABLE AT9000_Del ADD ABParameter04 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ABParameter05')
		ALTER TABLE AT9000_Del ADD ABParameter05 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ABParameter06')
		ALTER TABLE AT9000_Del ADD ABParameter06 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ABParameter07')
		ALTER TABLE AT9000_Del ADD ABParameter07 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ABParameter08')
		ALTER TABLE AT9000_Del ADD ABParameter08 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ABParameter09')
		ALTER TABLE AT9000_Del ADD ABParameter09 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='ABParameter10')
		ALTER TABLE AT9000_Del ADD ABParameter10 NVARCHAR(100) NULL
	END
	
---- Modified by Hải Long on 09/12/2016: Bổ sung các 5 trường mã phân tích nhân viên cho ANGEL
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SOAna01ID')
		ALTER TABLE AT9000_Del ADD SOAna01ID NVARCHAR(50) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SOAna02ID')
		ALTER TABLE AT9000_Del ADD SOAna02ID NVARCHAR(50) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SOAna03ID')
		ALTER TABLE AT9000_Del ADD SOAna03ID NVARCHAR(50) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SOAna04ID')
		ALTER TABLE AT9000_Del ADD SOAna04ID NVARCHAR(50) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000_Del' AND col.name='SOAna05ID')
		ALTER TABLE AT9000_Del ADD SOAna05ID NVARCHAR(50) NULL
	END	
	
--- Modified by Hải Long on 09/06/2017: Bổ sung trường IsVATWithhodingTax đánh dấu dòng nào là dòng thuế GTGT (thuế nhà thầu), VATWithhodingRate giá trị nhóm thuế 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsVATWithhodingTax')
        ALTER TABLE AT9000_Del ADD IsVATWithhodingTax TINYINT NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'VATWithhodingRate')
        ALTER TABLE AT9000_Del ADD VATWithhodingRate DECIMAL(28,8) NULL        
    END	

--- Modified by Hải Long on 16/08/2017: Bổ sung trường các trường của hóa đơn điện tử
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsEInvoice')
        ALTER TABLE AT9000_Del ADD IsEInvoice TINYINT DEFAULT(0) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'EInvoiceStatus')
        ALTER TABLE AT9000_Del ADD EInvoiceStatus TINYINT DEFAULT(0) NULL            
    END	  
    
--- Modified by Hải Long on 08/09/2017: Bổ sung trường IsAdvancePayment cho Bê Tông Long An
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN      
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsAdvancePayment')
        ALTER TABLE AT9000_Del ADD IsAdvancePayment TINYINT NULL            
    END	
    
--- Modified by Hải Long on 12/10/2017: Bổ sung trường fkey hóa đơn điện tử
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN      
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'Fkey')
        ALTER TABLE AT9000_Del ADD Fkey NVARCHAR(50) NULL            
    END	 
    
--- Modified by Hải Long on 19/10/2017: Bổ sung trường InheritFkey (lưu vết hóa đơn cần điều chỉnh, thay thế), trường EInvoiceType, TypeOfAdjust
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN      
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'InheritFkey')
        ALTER TABLE AT9000_Del ADD InheritFkey NVARCHAR(50) NULL            
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'EInvoiceType')
        ALTER TABLE AT9000_Del ADD EInvoiceType TINYINT DEFAULT(0) NULL        
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'TypeOfAdjust')
        ALTER TABLE AT9000_Del ADD TypeOfAdjust TINYINT NULL           
    END	
	
--- Modified by Thị Phượng on 11/12/2017: Bổ sung trường Kế thừa phiếu bán hàng POS và kế thừa phiếu đề nghị chi POS
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsInheritInvoicePOS') 
   ALTER TABLE AT9000_Del ADD IsInheritInvoicePOS TINYINT NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'InheritInvoicePOS') 
   ALTER TABLE AT9000_Del ADD InheritInvoicePOS VARCHAR(50) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsInheritPayPOS') 
   ALTER TABLE AT9000_Del ADD IsInheritPayPOS TINYINT NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'InheritPayPOS') 
   ALTER TABLE AT9000_Del ADD InheritPayPOS VARCHAR(50) NULL 
END     

--Đề nghị xuất hóa đơn (POS)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsInvoiceSuggest') 
   ALTER TABLE AT9000_Del ADD IsInvoiceSuggest TINYINT NULL 
END
/*===============================================END IsInvoiceSuggest===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'RefVoucherNo') 
   ALTER TABLE AT9000_Del ADD RefVoucherNo VARCHAR(50) NULL 
END

/*===============================================END RefVoucherNo===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'RefVoucherDate') 
   ALTER TABLE AT9000_Del ADD RefVoucherDate DATETIME NULL 
END

/*===============================================END RefVoucherDate===============================================*/


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsDeposit') 
   ALTER TABLE AT9000_Del ADD IsDeposit TINYINT NULL 
END

/*===============================================END IsDeposit===============================================*/ 
--- Modified by Thị Phượng on 11/03/2018: Bổ sung trường lưu vết kế thừa loại chứng từ (Loại bút toán kế thừa)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'ReTransactionTypeID') 
   ALTER TABLE AT9000_Del ADD ReTransactionTypeID VARCHAR(50) NULL 
END

---- Modified on 21/03/2018 by Bảo Anh: Bổ sung cột Chứng từ nhập, Lô nhập, Hạn sử dụng, IsPromotionItem
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'ImVoucherID') 
   ALTER TABLE AT9000_Del ADD ImVoucherID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'ImTransactionID') 
   ALTER TABLE AT9000_Del ADD ImTransactionID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'SourceNo') 
   ALTER TABLE AT9000_Del ADD SourceNo NVARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'LimitDate') 
   ALTER TABLE AT9000_Del ADD LimitDate DATETIME NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsPromotionItem') 
   ALTER TABLE AT9000_Del ADD IsPromotionItem TINYINT NULL DEFAULT(0)

END

--Kế thừa phiếu thu trên POS
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsReceived') 
   ALTER TABLE AT9000_Del ADD IsReceived TINYINT NULL 
END
/*===============================================END IsReceived===============================================*/ 

----Modified on 20/08/2018 by Kim Thư: Bổ sung cột ObjectName1 lưu tên khách vãng lai----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'ObjectName1') 
	ALTER TABLE AT9000_Del ADD ObjectName1 NVARCHAR(250) NULL
END

---- Modified on 07/11/2018 by Kim Thư: Bổ sung cột InvoiceGuid lấy mã từ BKAV trả về khi phát hành hóa đơn----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'InvoiceGuid') 
	ALTER TABLE AT9000_Del ADD InvoiceGuid VARCHAR(MAX) NULL
END

---- Modified on 09/11/2018 by Kim Thư: Bổ sung cột DiscountedUnitPrice và ConvertedDiscountedUnitPrice tính đơn giá sau khi đã chiết khấu----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'DiscountedUnitPrice') 
	ALTER TABLE AT9000_Del ADD DiscountedUnitPrice DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'ConvertedDiscountedUnitPrice') 
	ALTER TABLE AT9000_Del ADD ConvertedDiscountedUnitPrice DECIMAL(28,8) NULL

END
--- Modified  on 01/12/2018: Bổ sung trường IsInheritContract
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsInheritContract') 
   ALTER TABLE AT9000_Del ADD IsInheritContract TINYINT NULL DEFAULT(0)
END

---- Modified on 17/12/2018 by Như Hàn: Bổ sung cột VoucherOrder, PlanID lập phiếu chi từ kế hoạch nhận hàng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'VoucherOrder') 
	ALTER TABLE AT9000_Del ADD VoucherOrder VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'PlanID') 
	ALTER TABLE AT9000_Del ADD PlanID VARCHAR(50) NULL
END



--- Modified  on 10/7/2019 by Hồng Thảo: Chuyển đổi kiểu dữ liệu cột diễn giải vì lưu không đủ dữ liệu 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'VDescription') 
   ALTER TABLE AT9000_Del 
   ALTER COLUMN VDescription NVARCHAR(MAX) NULL
END

---- Modified on 01/08/2019 by Như Hàn: Bổ sung cột 20 cột quy cách của sản phẩm
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'PS01ID')
        ALTER TABLE AT9000_Del ADD	PS01ID NVARCHAR(50) NULL,
								PS02ID NVARCHAR(50) NULL,
								PS03ID NVARCHAR(50) NULL,
								PS04ID NVARCHAR(50) NULL,
								PS05ID NVARCHAR(50) NULL,
								PS06ID NVARCHAR(50) NULL,
								PS07ID NVARCHAR(50) NULL,
								PS08ID NVARCHAR(50) NULL,
								PS09ID NVARCHAR(50) NULL,
								PS10ID NVARCHAR(50) NULL,
								PS11ID NVARCHAR(50) NULL,
								PS12ID NVARCHAR(50) NULL,
								PS13ID NVARCHAR(50) NULL,
								PS14ID NVARCHAR(50) NULL,
								PS15ID NVARCHAR(50) NULL,
								PS16ID NVARCHAR(50) NULL,
								PS17ID NVARCHAR(50) NULL,
								PS18ID NVARCHAR(50) NULL,
								PS19ID NVARCHAR(50) NULL,
								PS20ID NVARCHAR(50) NULL
    END
---- Modified on 12/12/2019 by Tuấn Anh: Bổ sung cột ReVoucherID3386, IsAuto3386: Bút toán tổng hợp => Tự động tạo phiếu bút toán cấn trừ 3386 cho khách hàng BLUESKY
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'ReVoucherID3386') 
	ALTER TABLE AT9000_Del ADD ReVoucherID3386 VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'IsAuto3386') 
	ALTER TABLE AT9000_Del ADD IsAuto3386 bit NULL
END

---- Modified on 23/04/2020 by Lê Hoàng: Bổ sung cột nhóm thuế nhập khẩu cho khách hàng Tân Hòa Lợi để tính chi phí nhập khẩu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000_Del' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000_Del' AND col.name = 'ImTaxConvertedGroupID') 
	ALTER TABLE AT9000_Del ADD ImTaxConvertedGroupID NVARCHAR(50) NULL
END

