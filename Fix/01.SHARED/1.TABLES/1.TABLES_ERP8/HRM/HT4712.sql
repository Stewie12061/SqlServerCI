﻿-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Hoang Phuoc
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT4712]') AND type in (N'U'))
CREATE TABLE [dbo].[HT4712](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](3) NOT NULL,
	[ReportCode] [nvarchar](50) NOT NULL,
	[ColumnID] [int] NOT NULL,
	[FOrders] [int] NULL,
	[Caption] [nvarchar](250) NULL,
	[Disabled] [tinyint] NULL,
	[AmountType] [nvarchar](50) NULL,
	[AmountTypeFrom] [nvarchar](50) NULL,
	[AmountTypeTo] [nvarchar](50) NULL,
	[OtherAmount] [decimal](28, 8) NULL,
	[Signs] [nvarchar](50) NULL,
	[IsTotal] [tinyint] NULL,
	[IsSerie] [tinyint] NULL,
	[FromColumn] [int] NULL,
	[ToColumn] [int] NULL,
	[IsChangeCurrency] [tinyint] NULL,
	CONSTRAINT [PK_HT4712] PRIMARY KEY NONCLUSTERED 
	(
		[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
If Exists (Select * From sysobjects Where name = 'HT4712' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT4712'  and col.name = 'NetIncomeMethod')
           Alter Table HT4712 Add NetIncomeMethod tinyint NULL
END

If Exists (Select * From sysobjects Where name = 'HT4712' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT4712'  and col.name = 'DebitAccountID')
           Alter Table HT4712 Add DebitAccountID NVARCHAR(50) NULL

           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT4712'  and col.name = 'CreditAccountID')
           Alter Table HT4712 Add CreditAccountID NVARCHAR(50) NULL
           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT4712'  and col.name = 'IsSalary')
           Alter Table HT4712 Add IsSalary tinyint NULL           
END

---- Modified by Tiểu Mai on 12/07/2017: Bổ sung cột Mã phân tích ghi nhận Mã chi phí cho BOURBON (CustomizeIndex = 38)
IF EXISTS (SELECT * FROM sysobjects WHERE  name = 'HT4712' and xtype ='U') 
BEGIN 
           IF NOT EXISTS (SELECT * FROM syscolumns col inner join sysobjects tab 
           ON col.id = tab.id WHERE tab.name =   'HT4712'  and col.name = 'AnaID')
           ALTER TABLE HT4712 ADD AnaID NVARCHAR(50) NULL      
END

