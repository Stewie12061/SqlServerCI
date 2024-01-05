IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MTT0099]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[MTT0099]
     (
      [CodeMaster] VARCHAR(50) NOT NULL,
      [ID] VARCHAR(50) NOT NULL,
      [OrderNo] INT NULL,
      [Description] NVARCHAR(250) NULL,
      [DescriptionE] NVARCHAR(250) NULL,
      [Disabled] TINYINT DEFAULT (0) NULL
    CONSTRAINT [PK_MTT0099] PRIMARY KEY CLUSTERED
      (
      [CodeMaster],
      [ID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---------------- 28/07/2021 - Tấn Lộc: Bổ sung cột CodeMasterName ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'MTT0099' AND col.name = 'CodeMasterName')
BEGIN
	ALTER TABLE MTT0099 ADD CodeMasterName NVARCHAR(MAX) NULL
END
