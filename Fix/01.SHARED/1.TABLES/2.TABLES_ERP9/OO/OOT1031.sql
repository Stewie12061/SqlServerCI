---- Create by Cao Thị Phượng on 10/3/2017 11:10:54 AM
---- Danh sách mẫu công việc theo bước quy trình

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT1031]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT1031]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [TaskSampleID] VARCHAR(25) NOT NULL,
  [TaskSampleName] NVARCHAR(250) NOT NULL,
  [TaskTypeID] VARCHAR(50) NULL,
  [PriorityID] INT NULL,
  [DescriptionT] NVARCHAR(MAX) NULL,
  [ExecutionTime] DECIMAL(28,8) NULL,
  [Notes] NVARCHAR(250) NULL,
  [Orders] INT NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL
CONSTRAINT [PK_OOT1031] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
-------------------- 16/09/2019 - Tấn Lộc: Bổ sung cột TargetTypeID (Loại chỉ tiêu) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1031' AND col.name = 'TargetTypeID')
BEGIN
	ALTER TABLE OOT1031 ADD TargetTypeID VARCHAR(25)
END

----------- 15/10/2019 - Vĩnh Tâm: Điều chỉnh cho phép cột TaskSampleID và TaskSampleName được null -----------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1031' AND col.name = 'TaskSampleID')
BEGIN
	ALTER TABLE OOT1031 ALTER COLUMN TaskSampleID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1031' AND col.name = 'TaskSampleName')
BEGIN
	ALTER TABLE OOT1031 ALTER COLUMN TaskSampleName NVARCHAR(250) NULL
END

----------- 17/10/2019 - Vĩnh Tâm: Điều chỉnh kiểu dữ liệu cho cột ExecutionTime -----------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1031' AND col.name = 'ExecutionTime')
BEGIN
	ALTER TABLE OOT1031 ALTER COLUMN ExecutionTime DECIMAL(28,8) NULL
END
