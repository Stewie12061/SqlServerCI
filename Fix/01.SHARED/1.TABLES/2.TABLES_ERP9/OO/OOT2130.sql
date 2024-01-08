---- Create by Khâu Vĩnh Tâm on 8/13/2019 9:07:58 AM
---- Đánh giá công việc

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2130]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2130]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [DivisionID] VARCHAR(50) NULL,
  [TaskID] VARCHAR(50) NULL,
  [StatusID] VARCHAR(50) NULL,
  [Mark] INT NULL,
  [Note] NVARCHAR(250) NULL,
  [AssessUserID] VARCHAR(50) NULL,
  [TargetsGroupID] VARCHAR(50) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_OOT2130] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 03/09/2019 - Vĩnh Tâm: Bổ sung cột AssessRequired, AssessOrder ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2130' AND col.name = 'AssessRequired')
BEGIN
	ALTER TABLE OOT2130 ADD AssessRequired TINYINT DEFAULT 0
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2130' AND col.name = 'AssessOrder')
BEGIN
	ALTER TABLE OOT2130 ADD AssessOrder INT DEFAULT 0
END

---------------- 18/09/2020 - Trọng Kiên: Thay đổi kiểu dữ liệu cột TargetsGroupID ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2130' AND col.name = 'TargetsGroupID')
BEGIN
	ALTER TABLE OOT2130 ALTER COLUMN TargetsGroupID VARCHAR(50) NULL
END
