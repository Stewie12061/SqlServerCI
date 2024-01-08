﻿-- <Summary>
---- 
-- <History>
---- Create on 29/03/2013 by Bảo Quỳnh
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT340001]') AND type in (N'U'))
CREATE TABLE [dbo].[HT340001](
	[APK] [uniqueidentifier] NOT NULL DEFAULT (NEWID()),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[ProjectID] [nvarchar](50) NULL,
	[Income01] [decimal](28, 8) NULL,
	[Income02] [decimal](28, 8) NULL,
	[Income03] [decimal](28, 8) NULL,
	[Income04] [decimal](28, 8) NULL,
	[Income05] [decimal](28, 8) NULL,
	[Income06] [decimal](28, 8) NULL,
	[Income07] [decimal](28, 8) NULL,
	[Income08] [decimal](28, 8) NULL,
	[Income09] [decimal](28, 8) NULL,
	[Income10] [decimal](28, 8) NULL,
	[Income11] [decimal](28, 8) NULL,
	[Income12] [decimal](28, 8) NULL,
	[Income13] [decimal](28, 8) NULL,
	[Income14] [decimal](28, 8) NULL,
	[Income15] [decimal](28, 8) NULL,
	[Income16] [decimal](28, 8) NULL,
	[Income17] [decimal](28, 8) NULL,
	[Income18] [decimal](28, 8) NULL,
	[Income19] [decimal](28, 8) NULL,
	[Income20] [decimal](28, 8) NULL,
	[SubAmount01] [decimal](28, 8) NULL,
	[SubAmount02] [decimal](28, 8) NULL,
	[SubAmount03] [decimal](28, 8) NULL,
	[SubAmount04] [decimal](28, 8) NULL,
	[SubAmount05] [decimal](28, 8) NULL,
	[SubAmount06] [decimal](28, 8) NULL,
	[SubAmount07] [decimal](28, 8) NULL,
	[SubAmount08] [decimal](28, 8) NULL,
	[SubAmount09] [decimal](28, 8) NULL,
	[SubAmount10] [decimal](28, 8) NULL,
	[SubAmount11] [decimal](28, 8) NULL,
	[SubAmount12] [decimal](28, 8) NULL,
	[SubAmount13] [decimal](28, 8) NULL,
	[SubAmount14] [decimal](28, 8) NULL,
	[SubAmount15] [decimal](28, 8) NULL,
	[SubAmount16] [decimal](28, 8) NULL,
	[SubAmount17] [decimal](28, 8) NULL,
	[SubAmount18] [decimal](28, 8) NULL,
	[SubAmount19] [decimal](28, 8) NULL,
	[SubAmount20] [decimal](28, 8) NULL,
	[IGAbsentAmount01] [decimal](28, 8) NULL,
	[IGAbsentAmount02] [decimal](28, 8) NULL,
	[IGAbsentAmount03] [decimal](28, 8) NULL,
	[IGAbsentAmount04] [decimal](28, 8) NULL,
	[IGAbsentAmount05] [decimal](28, 8) NULL,
	[IGAbsentAmount06] [decimal](28, 8) NULL,
	[IGAbsentAmount07] [decimal](28, 8) NULL,
	[IGAbsentAmount08] [decimal](28, 8) NULL,
	[IGAbsentAmount09] [decimal](28, 8) NULL,
	[IGAbsentAmount10] [decimal](28, 8) NULL,
	[IGAbsentAmount11] [decimal](28, 8) NULL,
	[IGAbsentAmount12] [decimal](28, 8) NULL,
	[IGAbsentAmount13] [decimal](28, 8) NULL,
	[IGAbsentAmount14] [decimal](28, 8) NULL,
	[IGAbsentAmount15] [decimal](28, 8) NULL,
	[IGAbsentAmount16] [decimal](28, 8) NULL,
	[IGAbsentAmount17] [decimal](28, 8) NULL,
	[IGAbsentAmount18] [decimal](28, 8) NULL,
	[IGAbsentAmount19] [decimal](28, 8) NULL,
	[IGAbsentAmount20] [decimal](28, 8) NULL,
	[IGAbsentAmount21] [decimal](28, 8) NULL,
	[IGAbsentAmount22] [decimal](28, 8) NULL,
	[IGAbsentAmount23] [decimal](28, 8) NULL,
	[IGAbsentAmount24] [decimal](28, 8) NULL,
	[IGAbsentAmount25] [decimal](28, 8) NULL,
	[IGAbsentAmount26] [decimal](28, 8) NULL,
	[IGAbsentAmount27] [decimal](28, 8) NULL,
	[IGAbsentAmount28] [decimal](28, 8) NULL,
	[IGAbsentAmount29] [decimal](28, 8) NULL,
	[IGAbsentAmount30] [decimal](28, 8) NULL,
	[IGAbsentAmount31] [decimal](28, 8) NULL,
	[IGAbsentAmount32] [decimal](28, 8) NULL,
	[IGAbsentAmount33] [decimal](28, 8) NULL,
	[IGAbsentAmount34] [decimal](28, 8) NULL,
	[IGAbsentAmount35] [decimal](28, 8) NULL,
	[IGAbsentAmount36] [decimal](28, 8) NULL,
	[IGAbsentAmount37] [decimal](28, 8) NULL,
	[IGAbsentAmount38] [decimal](28, 8) NULL,
	[IGAbsentAmount39] [decimal](28, 8) NULL,
	[IGAbsentAmount40] [decimal](28, 8) NULL,
 CONSTRAINT [PK_HT340001] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC,
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
If Exists (Select * From sysobjects Where name = 'HT340001' and xtype ='U') 
Begin
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT340001'  and col.name = 'Income21')
       Alter Table  HT340001 Add Income21 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT340001'  and col.name = 'Income22')
       Alter Table  HT340001 Add Income22 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT340001'  and col.name = 'Income23')
       Alter Table  HT340001 Add Income23 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT340001'  and col.name = 'Income24')
       Alter Table  HT340001 Add Income24 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT340001'  and col.name = 'Income25')
       Alter Table  HT340001 Add Income25 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT340001'  and col.name = 'Income26')
       Alter Table  HT340001 Add Income26 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT340001'  and col.name = 'Income27')
       Alter Table  HT340001 Add Income27 decimal(28,8) Null       
	   If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT340001'  and col.name = 'Income28')
       Alter Table  HT340001 Add Income28 decimal(28,8) Null
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT340001'  and col.name = 'Income29')
       Alter Table  HT340001 Add Income29 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT340001'  and col.name = 'Income30')
       Alter Table  HT340001 Add Income30 decimal(28,8) Null
End



