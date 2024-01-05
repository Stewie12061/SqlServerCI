---- Create by Cao Thị Phượng on 10/17/2017 3:48:49 PM
---- Thời gian làm việc

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT0032]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT0032]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [HoursWork] DECIMAL(28,8) NULL,
  [BeginTime] INT NULL,
  [EndTime] INT NULL,
  [IsWorkMon] TINYINT DEFAULT 0 NULL,
  [IsWorkTues] TINYINT DEFAULT 0 NULL,
  [IsWorkWed] TINYINT DEFAULT 0 NULL,
  [IsWorkThurs] TINYINT DEFAULT 0 NULL,
  [IsWorkFri] TINYINT DEFAULT 0 NULL,
  [IsWorkSat] TINYINT DEFAULT 0 NULL,
  [IsWorkSun] TINYINT DEFAULT 0 NULL
CONSTRAINT [PK_OOT0032] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 26/09/2019 - Đình Ly: Bổ sung thêm cột BeginBreak, EndBreak, HoursBreak----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0032' AND col.name = 'BeginBreak')
BEGIN
	ALTER TABLE OOT0032 ADD BeginBreak INT DEFAULT 0
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0032' AND col.name = 'EndBreak')
BEGIN
	ALTER TABLE OOT0032 ADD EndBreak INT DEFAULT 0
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0032' AND col.name = 'HoursBreak')
BEGIN
	ALTER TABLE OOT0032 ADD HoursBreak DECIMAL(28,2)
END
