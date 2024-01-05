---- Create by Khâu Vĩnh Tâm on 12/3/2018 8:37:00 AM
---- Danh sách quy trình, bước và mẫu công việc trong Mẫu dự án

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT1051]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT1051]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [NodeParent] UNIQUEIDENTIFIER NULL,
  [NodeLevel] INT NULL,
  [NodeOrder] INT NULL,
  [ProcessID] VARCHAR(50) NULL,
  [ProcessName] NVARCHAR(250) NULL,
  [DescriptionP] NVARCHAR(MAX) NULL,
  [StepName] NVARCHAR(250) NULL,
  [TaskSampleID] VARCHAR(50) NULL,
  [StepID] VARCHAR(50) NULL,
  [TaskSampleName] NVARCHAR(250) NULL,
  [DescriptionS] NVARCHAR(MAX) NULL,
  [TaskTypeID] VARCHAR(50) NULL,
  [TargetTypeID] VARCHAR(50) NULL,
  [PriorityID] INT NULL,
  [DescriptionT] NVARCHAR(MAX) NULL,
  [ExecutionTime] INT NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_OOT1051] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

----------- 17/10/2019 - Vĩnh Tâm: Điều chỉnh kiểu dữ liệu cho cột ExecutionTime -----------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1051' AND col.name = 'ExecutionTime')
BEGIN
	ALTER TABLE OOT1051 ALTER COLUMN ExecutionTime DECIMAL(28,8) NULL
END
