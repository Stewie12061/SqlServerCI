-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Quốc Cường
---- Modified on 06/01/2021 by Lê Hoàng : Bổ sung cột OriginalValue (đồng bộ các trường ERP8, ERP9)
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1312]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1312](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[AccountID] [nvarchar](50) NOT NULL,
	[GroupID] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AT1312] PRIMARY KEY NONCLUSTERED 
(
	[InventoryID] ASC,
	[AccountID] ASC,
	[GroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Bổ sung cột OriginalValue
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1323' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'AT1323' AND col.name = 'OriginalValue')
   ALTER TABLE AT1323 ADD OriginalValue TINYINT NULL DEFAULT (0)
END