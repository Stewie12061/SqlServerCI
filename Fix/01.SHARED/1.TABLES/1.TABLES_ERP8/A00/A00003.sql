-- <Summary>
---- 
-- <History>
---- Create on 22/12/2010 by Vĩnh Phong
---- Modified on 17/06/2021 by Đoàn Duy: Bổ xung các cột Image01 -> Image08
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[A00003]') AND type in (N'U'))
CREATE TABLE [dbo].[A00003](
	[APK] [uniqueidentifier] NOT NULL default NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[Image01ID] [image] NULL,
	[Image02ID] [image] NULL,
 CONSTRAINT [PK_A00003] PRIMARY KEY CLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

---------------- 17/06/2021 -Đoàn Duy Bổ xung các cột Image01 -> Image08 ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'A00003' AND col.name = 'Image01')
BEGIN
	ALTER TABLE A00003 ADD Image01 VARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'A00003' AND col.name = 'Image02')
BEGIN
	ALTER TABLE A00003 ADD Image02 VARCHAR(MAX) NULL
END
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'A00003' AND col.name = 'Image03')
BEGIN
	ALTER TABLE A00003 ADD Image03 VARCHAR(MAX) NULL
END
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'A00003' AND col.name = 'Image04')
BEGIN
	ALTER TABLE A00003 ADD Image04 VARCHAR(MAX) NULL
END
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'A00003' AND col.name = 'Image05')
BEGIN
	ALTER TABLE A00003 ADD Image05 VARCHAR(MAX) NULL
END
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'A00003' AND col.name = 'Image06')
BEGIN
	ALTER TABLE A00003 ADD Image06 VARCHAR(MAX) NULL
END
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'A00003' AND col.name = 'Image07')
BEGIN
	ALTER TABLE A00003 ADD Image07 VARCHAR(MAX) NULL
END
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'A00003' AND col.name = 'Image08')
BEGIN
	ALTER TABLE A00003 ADD Image08 VARCHAR(MAX) NULL
END
