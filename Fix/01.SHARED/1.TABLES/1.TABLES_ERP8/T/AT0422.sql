﻿-- <Summary>
---- 
-- <History>
---- Create on 18/04/2022 by Kiều Nga
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0422]') AND type in (N'U'))
CREATE TABLE [dbo].[AT0422](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[DepreciationID] [nvarchar](50) NOT NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[JobID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[Status] [tinyint] NULL,
	[CreditAccountID] [nvarchar](50) NULL,
	[DebitAccountID] [nvarchar](50) NULL,
	[DepAmount] [decimal](28, 8) NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[D_C] [nvarchar](100) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[ObjectID] [nvarchar](50) NULL,
	[SerialNo] [nvarchar](50) NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[InvoiceDate] [datetime] NULL,
	[TransactionID] [nvarchar](50) NULL,
	[PeriodID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[DepOriginalAmount] [decimal](28, 8) NULL,
 CONSTRAINT [PK_AT0422] PRIMARY KEY CLUSTERED 
(
	[DepreciationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT0422' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT0422' AND col.name='AdvanceID')
		ALTER TABLE AT0422 ADD AdvanceID nvarchar(50) NULL
END
If Exists (Select * From sysobjects Where name = 'AT0422' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'AT0422'  and col.name = 'Ana06ID')
Alter Table  AT0422 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End