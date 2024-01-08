---- Create by Bảo Anh on 11/07/2017
---- Dữ liệu code master

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT0099]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[LMT0099]
(
  [CodeMaster] VARCHAR(50) NOT NULL,
  [OrderNo] INT NOT NULL,
  [ID] VARCHAR(50) NOT NULL,
  [Description] NVARCHAR(250) NOT NULL,
  [DescriptionE] NVARCHAR(250) NOT NULL,
  [Disabled] TINYINT DEFAULT (0) NOT NULL,
  [LanguageID] VARCHAR(50) NULL
CONSTRAINT [PK_LMT0099] PRIMARY KEY CLUSTERED
(
  [CodeMaster],
  [ID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 28/07/2021 - Tấn Lộc: Bổ sung cột CodeMasterName ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'LMT0099' AND col.name = 'CodeMasterName')
BEGIN
	ALTER TABLE LMT0099 ADD CodeMasterName NVARCHAR(MAX) NULL
END