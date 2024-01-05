---- Create by Phan thanh hoàng vũ on 10/30/2017 10:50:23 AM
---- Danh sách checklist công việc

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2111]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2111]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [ChecklistName] NVARCHAR(MAX) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [IsComplete] TINYINT DEFAULT (0) NULL,
  [IsConfirm] TINYINT DEFAULT (0) NULL,
  [DeleteFlag] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_OOT2111] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 15/08/2019 - Vĩnh Tâm: Bổ sung cột DeleteFlg --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2111' AND col.name = 'DeleteFlg')
BEGIN
	ALTER TABLE OOT2111 ADD DeleteFlg TINYINT DEFAULT 0
END