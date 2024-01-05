---- Create by truonglam on 11/6/2019 12:54:11 PM
---- Yêu cầu hỗ trợ

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2170]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2170]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [SupportRequiredID] VARCHAR(50) NULL,
  [SupportRequiredName] NVARCHAR(250) NULL,
  [PriorityID] TINYINT DEFAULT (0) NULL,
  [StatusID] VARCHAR(50) NULL,
  [TimeRequest] DATETIME NULL,
  [DeadlineRequest] DATETIME NULL,
  [AccountID] VARCHAR(50) NULL,
  [ContactID] VARCHAR(50) NULL,
  [InventoryID] VARCHAR(50) NULL,
  [AssignedToUserID] VARCHAR(250) NULL,
  [ReleaseVerion] NVARCHAR(250) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [TypeOfRequest] VARCHAR(50) NULL
CONSTRAINT [PK_OOT2170] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 24/06/2020 - Tấn Lộc: Bổ sung cột ActualStartDate ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2170' AND col.name = 'ActualStartDate')
BEGIN
	ALTER TABLE OOT2170 ADD ActualStartDate DATETIME NULL
END
---------------- 24/06/2020 - Tấn Lộc: Bổ sung cột ActualEndDate ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2170' AND col.name = 'ActualEndDate')
BEGIN
	ALTER TABLE OOT2170 ADD ActualEndDate DATETIME NULL
END
---------------- 24/06/2020 - Tấn Lộc: Bổ sung cột PercentProgress ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2170' AND col.name = 'PercentProgress')
BEGIN
	ALTER TABLE OOT2170 ADD PercentProgress DECIMAL(28,8) DEFAULT (0) NULL
END
---------------- 24/06/2020 - Tấn Lộc: Bổ sung cột ActualTime ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2170' AND col.name = 'ActualTime')
BEGIN
	ALTER TABLE OOT2170 ADD ActualTime DECIMAL(28,8) NULL
END
---------------- 22/09/2020 - Vĩnh Tâm: Bổ sung cột SupportDictionaryID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2170' AND col.name = 'SupportDictionaryID')
BEGIN
	ALTER TABLE OOT2170 ADD SupportDictionaryID VARCHAR(50) NULL
END