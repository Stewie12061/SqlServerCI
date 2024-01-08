-- <Summary>
---- 
-- <History>
---- Create   on 06/08/2010 by Tố Oanh
---- Modified on 26/10/2020 by Đức Thông: Mở rộng số kí tự từ 250 lên 500 ở 2 cột VDescription và BDescription
-- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0402]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0402](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[GiveUpID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[BatchID] [nvarchar](50) NOT NULL,
	[TableID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[ObjectID] [nvarchar](50) NULL,
	[CreditAccountID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[CurrencyIDCN] [nvarchar](50) NULL,
	[ObjectName] [nvarchar](250) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[OriginalAmountCN] [decimal](28, 8) NULL,
	[GivedOriginalAmount] [decimal](28, 8) NULL,
	[GivedConvertedAmount] [decimal](28, 8) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[ExchangeRateCN] [decimal](28, 8) NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[InvoiceDate] [datetime] NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[Serial] [nvarchar](50) NULL,
	[VDescription] [nvarchar](500) NULL,
	[BDescription] [nvarchar](500) NULL,
	[Status] [nvarchar](50) NOT NULL,
	[PaymentID] [nvarchar](50) NULL,
	[DueDays] [int] NULL,
	[DueDate] [datetime] NULL,
	CONSTRAINT [PK_AT0402] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON
	)
) ON [PRIMARY]
END



IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0402' AND xtype='U')
	BEGIN
		IF  EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0402' AND col.name='VDescription')
		ALTER TABLE AT0402 ALTER COLUMN VDescription NVARCHAR(500) 
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0402' AND xtype='U')
	BEGIN
		IF  EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0402' AND col.name='BDescription')
		ALTER TABLE AT0402 ALTER COLUMN BDescription NVARCHAR(500) 
	END