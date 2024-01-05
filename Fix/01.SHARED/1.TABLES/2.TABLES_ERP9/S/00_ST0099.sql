--- Created on 30/10/2014 by Hoang Tu

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST0099]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST0099](
	[CodeMaster] [varchar](50) NOT NULL,
	[ID] [int] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[DescriptionE] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
 CONSTRAINT [PK_ ST0099] PRIMARY KEY CLUSTERED 
(
	[CodeMaster] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END

--- 16/11/2020 Lê Hoàng: Bổ sung cột ID1
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0099' AND col.name = 'ID1')
BEGIN
	ALTER TABLE ST0099 ADD ID1 VARCHAR(50) NULL
END

--- 16/11/2020 Lê Hoàng: Bổ sung cột OrderNo
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0099' AND col.name = 'OrderNo')
BEGIN
	ALTER TABLE ST0099 ADD OrderNo INT NULL
END

--- 16/11/2020 Lê Hoàng: Bổ sung cột LanguageID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0099' AND col.name = 'LanguageID')
BEGIN
	ALTER TABLE ST0099 ADD LanguageID NVARCHAR(MAX) NULL
END

---------------- 28/07/2021 - Tấn Lộc: Bổ sung cột CodeMasterName ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0099' AND col.name = 'CodeMasterName')
BEGIN
	ALTER TABLE ST0099 ADD CodeMasterName NVARCHAR(MAX) NULL
END

