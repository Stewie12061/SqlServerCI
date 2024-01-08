---- Create by Khâu Vĩnh Tâm on 10/21/2019 3:27:47 PM
---- Thiết lập đánh giá công việc/dự án (Master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT0051]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT0051]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [ObjectID] VARCHAR(50) NULL,
  [NotUseAssess] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_OOT0051] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 10/08/2019 - Vĩnh Tâm: Bổ sung cột TargetsGroupID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0051' AND col.name = 'TargetsGroupID')
BEGIN
	ALTER TABLE OOT0051 ADD TargetsGroupID VARCHAR(MAX) NULL
END