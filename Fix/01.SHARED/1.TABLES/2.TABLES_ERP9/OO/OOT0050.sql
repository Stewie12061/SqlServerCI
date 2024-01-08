---- Create by Khâu Vĩnh Tâm on 6/28/2019 7:57:12 PM
---- Thiết lập đánh giá công việc

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT0050]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT0050]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [TargetsGroupID] VARCHAR(50) NULL,
  [AssessDepartmentID] VARCHAR(50) NULL,
  [AssessUserID1] VARCHAR(50) NULL,
  [AssessUserID2] VARCHAR(50) NULL,
  [AssessOrder] INT NULL,
  [NoDefault] TINYINT DEFAULT 0 NOT NULL,
  [NoDisplay] TINYINT DEFAULT 0 NOT NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_OOT0050] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 10/08/2019 - Vĩnh Tâm: Bổ sung cột DefaultScore ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0050' AND col.name = 'DefaultScore')
BEGIN
	ALTER TABLE OOT0050 ADD DefaultScore INT DEFAULT 0
END

---------------- 15/08/2019 - Vĩnh Tâm: Bổ sung cột AssessRequired ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0050' AND col.name = 'AssessRequired')
BEGIN
	ALTER TABLE OOT0050 ADD AssessRequired TINYINT DEFAULT 0
END

---------------- 21/10/2019 - Vĩnh Tâm: Bổ sung cột APKMaster ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0050' AND col.name = 'APKMaster')
BEGIN
	ALTER TABLE OOT0050 ADD APKMaster UNIQUEIDENTIFIER NULL
END
