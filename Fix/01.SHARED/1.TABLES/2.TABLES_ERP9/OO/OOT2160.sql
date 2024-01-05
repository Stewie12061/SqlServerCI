---- Create by Khâu Vĩnh Tâm on 10/29/2019 10:07:16 AM
---- Quản lý vấn đề

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2160]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2160]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [IssuesID] VARCHAR(50) NULL,
  [IssuesName] NVARCHAR(MAX) NULL,
  [PriorityID] TINYINT DEFAULT (0) NULL,
  [StatusID] VARCHAR(50) NULL,
  [TimeRequest] DATETIME NULL,
  [DeadlineRequest] DATETIME NULL,
  [ProjectID] VARCHAR(50) NULL,
  [TaskID] VARCHAR(50) NULL,
  [AssignedToUserID] VARCHAR(250) NULL,
  [RequestID] INT NULL,
  [ReleaseVerion] NVARCHAR(250) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_OOT2160] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 08/11/2019 - Tấn Lộc: Bổ sung cột TypeOfIssues, SupportRequiredID, InventoryID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2160' AND col.name = 'TypeOfIssues')
BEGIN
	ALTER TABLE OOT2160 ADD TypeOfIssues VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2160' AND col.name = 'SupportRequiredID')
BEGIN
	ALTER TABLE OOT2160 ADD SupportRequiredID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2160' AND col.name = 'InventoryID')
BEGIN
	ALTER TABLE OOT2160 ADD InventoryID VARCHAR(50) NULL
END
-------------------- 24/12/2019 - Tấn Lộc: Bổ sung cột MilestoneID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2160' AND col.name = 'MilestoneID')
BEGIN
	ALTER TABLE OOT2160 ADD MilestoneID VARCHAR(50) NULL
END
---------------- 31/12/2019 - Tấn Lộc: Thay đổi kiểu dữ liệu của cột RequestID ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2160' AND col.name = 'RequestID')
BEGIN
	ALTER TABLE OOT2160 ALTER COLUMN RequestID VARCHAR(50) NULL
END
---------------- 07/01/2020 - Tấn Lộc: Bổ sung cột ReleaseID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2160' AND col.name = 'ReleaseID')
BEGIN
	ALTER TABLE OOT2160 ADD ReleaseID VARCHAR(50) NULL
END
---------------- 01/06/2020 - Tấn Lộc: Bổ sung cột TimeConfirm ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2160' AND col.name = 'TimeConfirm')
BEGIN
	ALTER TABLE OOT2160 ADD TimeConfirm DATETIME NULL
END
---------------- 23/06/2020 - Tấn Lộc: Bổ sung cột ActualStartDate ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2160' AND col.name = 'ActualStartDate')
BEGIN
	ALTER TABLE OOT2160 ADD ActualStartDate DATETIME NULL
END
---------------- 23/06/2020 - Tấn Lộc: Bổ sung cột ActualEndDate ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2160' AND col.name = 'ActualEndDate')
BEGIN
	ALTER TABLE OOT2160 ADD ActualEndDate DATETIME NULL
END
---------------- 24/06/2020 - Tấn Lộc: Bổ sung cột PercentProgress ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2160' AND col.name = 'PercentProgress')
BEGIN
	ALTER TABLE OOT2160 ADD PercentProgress DECIMAL(28,8) DEFAULT (0) NULL
END
---------------- 24/06/2020 - Tấn Lộc: Bổ sung cột ActualTime ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2160' AND col.name = 'ActualTime')
BEGIN
	ALTER TABLE OOT2160 ADD ActualTime DECIMAL(28,8) NULL
END