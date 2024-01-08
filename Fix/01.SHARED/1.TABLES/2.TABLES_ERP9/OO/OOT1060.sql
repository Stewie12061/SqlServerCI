---- Create by Khâu Vĩnh Tâm on 12/3/2018 3:01:04 PM
---- Danh mục mẫu công việc

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT1060]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT1060]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [TaskSampleID] VARCHAR(50) NOT NULL,
  [TaskSampleName] NVARCHAR(250) NOT NULL,
  [TaskTypeID] VARCHAR(50) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [PriorityID] INT DEFAULT 1 NOT NULL,
  [ExecutionTime] INT NULL,
  [PercentProgress] DECIMAL(10,5) NULL,
  [RelatedToTypeID] INT DEFAULT 48 NULL,
  [IsCommon] TINYINT DEFAULT 0 NULL,
  [Disabled] TINYINT DEFAULT 0 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_OOT1060] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TaskSampleID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 16/09/2019 - Tấn Lộc: Bổ sung cột TargetTypeID (Loại chỉ tiêu) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1060' AND col.name = 'TargetTypeID')
BEGIN
	ALTER TABLE OOT1060 ADD TargetTypeID VARCHAR(25)
END

-------------------- 15/10/2019 - Vĩnh Tâm: Thay đổi kiểu dữ liệu cho cột ExecutionTime --------------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1060' AND col.name = 'ExecutionTime')
BEGIN
	ALTER TABLE dbo.OOT1060 ALTER COLUMN ExecutionTime DECIMAL(28, 8)
END

-------------------- 17/11/2020 - Kiều Nga: Bổ sung cột TaskBlockTypeID (Loại chốt chặn) -------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1060' AND col.name = 'TaskBlockTypeID')
BEGIN
	ALTER TABLE OOT1060 ADD TaskBlockTypeID VARCHAR(50) NULL
END