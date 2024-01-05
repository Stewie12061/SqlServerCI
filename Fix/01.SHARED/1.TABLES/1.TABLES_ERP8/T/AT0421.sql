-- <Summary>
---- 
-- <History>
---- Create on 13/04/2022 by Kiều Nga
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0421]') AND type in (N'U'))
CREATE TABLE [dbo].[AT0421](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[JobID] [nvarchar](50) NOT NULL,
	[JobName] [nvarchar](250) NULL,
	[SerialNo] [nvarchar](50) NULL,
	[CreditAccountID] [nvarchar](50) NULL,
	[DebitAccountID] [nvarchar](50) NULL,
	[Periods] [int] NULL,
	[APercent] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[BeginMonth] [int] NULL,
	[BeginYear] [int] NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[ObjectID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherID] [nvarchar](50) NULL,
	[D_C] [nvarchar](100) NOT NULL,
	[UseStatus] [int] NOT NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[DepMonths] [int] NULL,
	[ResidualMonths] [int] NULL,
	[DepValue] [decimal](28, 8) NULL,
	[ResidualValue] [decimal](28, 8) NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[InvoiceDate] [datetime] NULL,
	[TransactionID] [nvarchar](50) NULL,
	[PeriodID] [nvarchar](50) NULL,
	[ApportionAmount] [decimal](28, 8) NULL,
	[IsMultiAccount] [tinyint] NOT NULL,
 CONSTRAINT [PK_AT0421] PRIMARY KEY CLUSTERED 
(
	[JobID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT0421__IsMultiA__0E6206AD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0421] ADD  CONSTRAINT [DF__AT0421__IsMultiA__0E6206AD]  DEFAULT ((0)) FOR [IsMultiAccount]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'AT0421' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'AT0421'  and col.name = 'Ana06ID')
Alter Table  AT0421 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End

---- Modified by Kiều Nga : Bổ sung trường BeginDate
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0421' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0421' AND col.name = 'BeginDate') 
   ALTER TABLE AT0421 ADD BeginDate datetime NULL 
END

---- Modified by Kiều Nga : Bổ sung trường SignDate
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0421' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0421' AND col.name = 'SignDate') 
   ALTER TABLE AT0421 ADD SignDate datetime NULL 
END

---- Modified by Kiều Nga : Bổ sung trường InheritTableID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0421' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0421' AND col.name = 'InheritTableID') 
   ALTER TABLE AT0421 ADD InheritTableID nvarchar(50) Null
END

---- Modified by Kiều Nga : Bổ sung trường ContractNo
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0421' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0421' AND col.name = 'ContractNo') 
   ALTER TABLE AT0421 ADD ContractNo nvarchar(50) Null
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0421' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0421' AND col.name = 'BeginMonth') 
   ALTER TABLE AT0421 ALTER COLUMN BeginMonth [int] NULL

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0421' AND col.name = 'BeginYear') 
   ALTER TABLE AT0421 ALTER COLUMN BeginYear [int] NULL

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0421' AND col.name = 'VoucherID') 
   ALTER TABLE AT0421 ALTER COLUMN VoucherID [nvarchar](50) NULL
END

---- Modified by Kiều Nga : Bổ sung trường FirstMonthValue
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0421' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0421' AND col.name = 'FirstMonthValue') 
   ALTER TABLE AT0421 ADD FirstMonthValue decimal (28, 8) NULL
END