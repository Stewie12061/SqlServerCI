---- Create by Cao Thị Phượng on 11/7/2017 9:32:22 AM
---- Thiết lập cảnh báo cá nhân detail

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT0043]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT0043]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [UserID] VARCHAR(50) NOT NULL,
  [EventID] VARCHAR(50) NOT NULL,
  [SendNotification] TINYINT DEFAULT 0 NULL,
  [SendEmail] TINYINT DEFAULT 0 NULL,
  [SendSMS] TINYINT DEFAULT 0 NULL,
  [RemindAfterDay] INT NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_OOT0043] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 19/08/2019 - Truong Lam: Bổ sung cột ModuleID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0043' AND col.name = 'ModuleID')
BEGIN
  ALTER TABLE OOT0043 ADD ModuleID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0043' AND col.name = 'GroupID')
BEGIN
  ALTER TABLE OOT0043 ADD GroupID VARCHAR(50) NULL
END

-------------------- 26/05/2021 - Tấn Lộc: Bổ sung cột Warning --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0043' AND col.name = 'Warning')
BEGIN
  ALTER TABLE OOT0043 ADD Warning TINYINT DEFAULT 0 NULL
END