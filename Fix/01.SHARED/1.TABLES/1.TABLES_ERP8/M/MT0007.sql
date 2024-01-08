-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT0007]') AND type in (N'U'))
CREATE TABLE [dbo].[MT0007](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](3) NOT NULL,
	[MaterialGroupID] [nvarchar](50) NOT NULL,
	[MaterialID] [nvarchar](50) NOT NULL,
	[CoValues] [decimal](28, 8) NULL,
	[Description] [nvarchar](250) NULL,
	[Orders] [tinyint] NULL,
 CONSTRAINT [PK_MT0007] PRIMARY KEY CLUSTERED 
(
	[MaterialGroupID] ASC,
	[MaterialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



-- Bổ sung 20 cột quy cách cho khách hàng TDCLA
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'MT0007' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S01ID') 
   ALTER TABLE MT0007 ADD S01ID NVARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S02ID') 
   ALTER TABLE MT0007 ADD S02ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S03ID') 
   ALTER TABLE MT0007 ADD S03ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S04ID') 
   ALTER TABLE MT0007 ADD S04ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S05ID') 
   ALTER TABLE MT0007 ADD S05ID NVARCHAR(50) NULL    
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S06ID') 
   ALTER TABLE MT0007 ADD S06ID NVARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S07ID') 
   ALTER TABLE MT0007 ADD S07ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S08ID') 
   ALTER TABLE MT0007 ADD S08ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S09ID') 
   ALTER TABLE MT0007 ADD S09ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S10ID') 
   ALTER TABLE MT0007 ADD S10ID NVARCHAR(50) NULL       
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S11ID') 
   ALTER TABLE MT0007 ADD S11ID NVARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S12ID') 
   ALTER TABLE MT0007 ADD S12ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S13ID') 
   ALTER TABLE MT0007 ADD S13ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S14ID') 
   ALTER TABLE MT0007 ADD S14ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S15ID') 
   ALTER TABLE MT0007 ADD S15ID NVARCHAR(50) NULL    
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S16ID') 
   ALTER TABLE MT0007 ADD S16ID NVARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S17ID') 
   ALTER TABLE MT0007 ADD S17ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S18ID') 
   ALTER TABLE MT0007 ADD S18ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S19ID') 
   ALTER TABLE MT0007 ADD S19ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT0007' AND col.name = 'S20ID') 
   ALTER TABLE MT0007 ADD S20ID NVARCHAR(50) NULL               	
END 