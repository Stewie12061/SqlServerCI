﻿-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT7608]') AND type in (N'U'))
CREATE TABLE [dbo].[AT7608](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[LineCode] [nvarchar](50) NOT NULL,
	[LineDescription] [nvarchar](250) NULL,
	[PrintCode] [nvarchar](50) NULL,
	[Amount1] [decimal](28, 8) NULL,
	[Amount2] [decimal](28, 8) NULL,
	[AccuSign] [nvarchar](5) NULL,
	[Accumulator] [nvarchar](100) NULL,
	[Level1] [tinyint] NULL,
	[PrintStatus] [tinyint] NULL,
	[Type] [tinyint] NOT NULL,
	[LineDescriptionE] [nvarchar](250) NULL,
	[Notes] [nvarchar](250) NULL,
 CONSTRAINT [PK_AT7608] PRIMARY KEY NONCLUSTERED 
(
	[LineCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT7608_Amount1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT7608] ADD  CONSTRAINT [DF_AT7608_Amount1]  DEFAULT ((0)) FOR [Amount1]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT7608_Amount2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT7608] ADD  CONSTRAINT [DF_AT7608_Amount2]  DEFAULT ((0)) FOR [Amount2]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT7608_Type]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT7608] ADD  CONSTRAINT [DF_AT7608_Type]  DEFAULT ((0)) FOR [Type]
END


--- Bổ sung trường Amount10, Amount11, Amount1A, Amount2A, Amount10A, Amount11A cho PACIFIC
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT7608' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT7608' AND col.name = 'Amount10')
        ALTER TABLE AT7608 ADD Amount10 DECIMAL(28,8) NULL DEFAULT ((0))
    
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT7608' AND col.name = 'Amount11')
        ALTER TABLE AT7608 ADD Amount11 DECIMAL(28,8) NULL DEFAULT ((0))  
    
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT7608' AND col.name = 'Amount1A')
        ALTER TABLE AT7608 ADD Amount1A DECIMAL(28,8) NULL DEFAULT ((0))
    
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT7608' AND col.name = 'Amount2A')
        ALTER TABLE AT7608 ADD Amount2A DECIMAL(28,8) NULL DEFAULT ((0))
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT7608' AND col.name = 'Amount10A')
        ALTER TABLE AT7608 ADD Amount10A DECIMAL(28,8) NULL DEFAULT ((0))
    
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT7608' AND col.name = 'Amount11A')
        ALTER TABLE AT7608 ADD Amount11A DECIMAL(28,8) NULL DEFAULT ((0))         
    END  
   