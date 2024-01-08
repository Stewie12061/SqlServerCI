-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Tố Oanh
---- Modified on 24/08/2022 by Nhật Thanh: Tăng độ rộng VDescription BDescription 
-- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0401]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0401](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[GiveUpID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[BatchID] [nvarchar](50) NOT NULL,
	[TableID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[ObjectID] [nvarchar](50) NULL,
	[DebitAccountID] [nvarchar](50) NULL,
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
	CONSTRAINT [PK_AT0401] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON
	)
) ON [PRIMARY]
END

If Exists (Select * From sysobjects Where name = 'AT0401' and xtype ='U') 
Begin
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0401'  and col.name = 'VDescription')
           Alter Table  AT0401 ALTER COLUMN VDescription NVARCHAR(500) NULL

           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0401'  and col.name = 'BDescription')
           Alter Table  AT0401 ALTER COLUMN BDescription NVARCHAR(500) NULL
END