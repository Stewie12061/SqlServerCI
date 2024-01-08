---- Create by Phan thanh hoàng vũ on 10/4/2017 9:46:00 AM
---- Danh sách công việc

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2110]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2110]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [NodeParent] UNIQUEIDENTIFIER NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [TaskID] VARCHAR(50) NOT NULL,
  [TaskName] NVARCHAR(250) NULL,
  [ParentTaskID] VARCHAR(50) NULL,
  [PreviousTaskID] VARCHAR(50) NULL,
  [TaskTypeID] VARCHAR(50) NULL,
  [TargetTypeID] VARCHAR(50) NULL,
  [PriorityID] TINYINT DEFAULT 0 NULL,
  [AssignedToUserID] VARCHAR(50) NULL,
  [SupportUserID] VARCHAR(50) NULL,
  [ReviewerUserID] VARCHAR(50) NULL,
  [PercentProgress] DECIMAL(28,8) NULL,
  [StatusID] VARCHAR(50) NULL,
  [Orders] INT NULL,
  [IsRepeat] TINYINT DEFAULT 0 NULL,
  [APKSettingTime] UNIQUEIDENTIFIER NULL,
  [PlanStartDate] DATETIME NULL,
  [PlanEndDate] DATETIME NULL,
  [PlanTime] DECIMAL(28,8) NULL,
  [ActualStartDate] DATETIME NULL,
  [ActualEndDate] DATETIME NULL,
  [ActualTime] DECIMAL(28,8) NULL,
  [ProjectID] VARCHAR(50) NULL,
  [ProcessID] VARCHAR(50) NULL,
  [StepID] VARCHAR(50) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [RelatedToTypeID] INT DEFAULT 48 NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_OOT2110] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 11/06/2019 - Vĩnh Tâm: Bổ sung cột IsViolated (Cố tình vi phạm) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'IsViolated')
BEGIN
	ALTER TABLE OOT2110 ADD IsViolated TINYINT NULL
END

-------------------- 16/07/2019 - Đình Ly: Bổ sung thêm cột IsAssessor(Đã có người đánh giá) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'IsAssessor')
BEGIN
	ALTER TABLE OOT2110 ADD IsAssessor TINYINT NULL
END

---------------- 10/07/2019 - Vĩnh Tâm: Bổ sung cột NodeLevel, NodeOrder, TypeRel, APKRel ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'NodeLevel')
BEGIN
	ALTER TABLE OOT2110 ADD NodeLevel INT NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'NodeOrder')
BEGIN
	ALTER TABLE OOT2110 ADD NodeOrder INT NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'TypeRel')
BEGIN
	ALTER TABLE OOT2110 ADD TypeRel VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'APKRel')
BEGIN
	ALTER TABLE OOT2110 ADD APKRel UNIQUEIDENTIFIER NULL
END

---------------- 29/10/2019 - Truong Lam: Bổ sung cột LockID----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'LockID')
BEGIN
  ALTER TABLE OOT2110 ADD LockID TINYINT NULL
END

---------------- 12/11/2019 - Truong Lam: Bổ sung cột IsCycle - Trạng thái công việc định kỳ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'IsCycle')
BEGIN
  ALTER TABLE OOT2110 ADD IsCycle TINYINT NULL
END

---------------- 18/11/2019 - Đình Ly: Bổ sung cột APKViolated ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'APK_Violated')
BEGIN
	EXEC SP_RENAME 'OOT2110."APK_Violated"', 'APKViolated', 'COLUMN'
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'APKViolated')
BEGIN
	ALTER TABLE OOT2110 ADD APKViolated UNIQUEIDENTIFIER NULL
END

---------------- 11/12/2019 - Truong Lam: Bổ sung cột TaskSampleID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'TaskSampleID')
BEGIN
  ALTER TABLE OOT2110 ADD TaskSampleID VARCHAR(50) NULL
END

---------------- 18/11/2020 - Kiều Nga: Bổ sung cột SaleOrderID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'APKSaleOrderID')
BEGIN
  ALTER TABLE OOT2110 ADD APKSaleOrderID UNIQUEIDENTIFIER NULL
END

---------------- 17/12/2020 - Tấn Thành: Bổ sung cột NextPlanDate ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2110' AND col.name = 'NextPlanDate')
BEGIN
  ALTER TABLE OOT2110 ADD NextPlanDate DATETIME NULL
END
