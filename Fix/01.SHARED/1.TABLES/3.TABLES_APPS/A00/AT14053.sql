---- Create by Đoàn Duy on 14/11/2022 9:33:05 AM
---- Thiết lập hiển thị workspace

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT14053]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT14053]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [UserID] VARCHAR(50) NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [WorkspaceID] NVARCHAR (250) NULL,
  [OrderNo] int NULL,
  [Visible] TINYINT DEFAULT(0) NULL
CONSTRAINT [PK_AT14053] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 16/11/2022 - Hoài Bảo: Bổ sung cột IsFloatRight, IsFloatLeft ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT14053' AND col.name = 'IsFloatRight')
BEGIN
	ALTER TABLE AT14053 ADD IsFloatRight TINYINT NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT14053' AND col.name = 'IsFloatLeft')
BEGIN
	ALTER TABLE AT14053 ADD IsFloatLeft TINYINT NULL
END