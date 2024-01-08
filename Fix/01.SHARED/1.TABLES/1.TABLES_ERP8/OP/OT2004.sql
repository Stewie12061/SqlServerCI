-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Cam Loan
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT2004]') AND type in (N'U'))
CREATE TABLE [dbo].[OT2004](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[SOrderID] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[CostID] [nvarchar](50) NULL,
	[Amount] [decimal](28, 8) NULL,
	[Disabled] [tinyint] NULL,
	[Orders] [int] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_OT2004] PRIMARY KEY NONCLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2004' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2004' AND col.name = 'Ana01ID')
		ALTER TABLE OT2004 ADD Ana01ID nvarchar(50) Null
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2004' AND col.name = 'Ana02ID')
		ALTER TABLE OT2004 ADD Ana02ID nvarchar(50) Null
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2004' AND col.name = 'Ana03ID')
		ALTER TABLE OT2004 ADD Ana03ID nvarchar(50) Null
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2004' AND col.name = 'Ana04ID')
		ALTER TABLE OT2004 ADD Ana04ID nvarchar(50) Null
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2004' AND col.name = 'Ana05ID')
		ALTER TABLE OT2004 ADD Ana05ID nvarchar(50) Null
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2004' AND col.name = 'Ana06ID')
		ALTER TABLE OT2004 ADD Ana06ID nvarchar(50) Null
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2004' AND col.name = 'Ana07ID')
		ALTER TABLE OT2004 ADD Ana07ID nvarchar(50) Null
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2004' AND col.name = 'Ana08ID')
		ALTER TABLE OT2004 ADD Ana08ID nvarchar(50) Null
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2004' AND col.name = 'Ana09ID')
		ALTER TABLE OT2004 ADD Ana09ID nvarchar(50) Null
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2004' AND col.name = 'Ana10ID')
		ALTER TABLE OT2004 ADD Ana10ID nvarchar(50) Null
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2004' AND col.name = 'IsProInventoryID')
		ALTER TABLE OT2004 ADD IsProInventoryID [tinyint] NULL
END