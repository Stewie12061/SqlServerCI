---- Create by Khâu Vĩnh Tâm on 1/7/2019 6:23:57 PM
---- Danh sách bước và mẫu công việc trong Quy trình

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT1021]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT1021]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [NodeParent] UNIQUEIDENTIFIER NULL,
  [NodeLevel] INT NULL,
  [NodeOrder] INT NULL,
  [StepID] VARCHAR(50) NULL,
  [StepName] NVARCHAR(250) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [TaskSampleID] VARCHAR(50) NULL,
  [TaskSampleName] NVARCHAR(250) NULL,
  [TaskTypeID] VARCHAR(50) NULL,
  [PriorityID] INT NULL,
  [DescriptionT] NVARCHAR(MAX) NULL,
  [ExecutionTime] INT NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_OOT1021] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
-------------------- 16/09/2019 - Tấn Lộc: Bổ sung cột TargetTypeID (Loại chỉ tiêu) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1021' AND col.name = 'TargetTypeID')
BEGIN
	ALTER TABLE OOT1021 ADD TargetTypeID VARCHAR(25)
END

----------- 17/10/2019 - Vĩnh Tâm: Điều chỉnh kiểu dữ liệu cho cột ExecutionTime -----------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1021' AND col.name = 'ExecutionTime')
BEGIN
	ALTER TABLE OOT1021 ALTER COLUMN ExecutionTime DECIMAL(28,8) NULL
END
