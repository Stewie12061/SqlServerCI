---- Create by Cao Thị Phượng on 11/7/2017 9:30:32 AM
---- Edited by Truong Lam on 24/08/2019
---- Thiết lập cảnh báo cá nhân

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT0042]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT0042]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [EventID] VARCHAR(50) NOT NULL,
  [EventName] NVARCHAR(250) NOT NULL,
  [SMSTemplate] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_OOT0042] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 19/08/2019 - Truong Lam: Bổ sung cột ModuleID, EmailTemplateID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0042' AND col.name = 'ModuleID')
BEGIN
  ALTER TABLE OOT0042 ADD ModuleID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0042' AND col.name = 'EmailTemplateID')
BEGIN
  ALTER TABLE OOT0042 ADD EmailTemplateID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0042' AND col.name = 'InitID')
BEGIN
  ALTER TABLE OOT0042 ADD InitID TINYINT NULL
END

-------------------- 26/05/2021 - Tấn Lộc: Bổ sung cột WarningTypeID - [Loại thông báo] --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0042' AND col.name = 'WarningTypeID')
BEGIN
  ALTER TABLE OOT0042 ADD WarningTypeID VARCHAR(50) NULL
END