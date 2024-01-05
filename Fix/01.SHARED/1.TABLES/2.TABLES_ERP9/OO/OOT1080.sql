---- Create by Khâu Vĩnh Tâm on 6/20/2019 11:33:27 AM
---- Danh mục quy định giờ công vi phạm

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT1080]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT1080]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [IsCommon] TINYINT DEFAULT 0 NULL,
  [Disabled] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_OOT1080] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 27/08/2019 - Tấn Lộc: Bổ sung cột TableName (Quy định giờ công vi phạm) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1080' AND col.name = 'TableName')
BEGIN
	ALTER TABLE OOT1080 ADD TableName NVARCHAR(250)
END

-------------------- 26/09/2019 - Tấn Lộc: Bổ sung cột PunishViolated (Phạt cố tình vi phạm) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1080' AND col.name = 'PunishViolated')
BEGIN
	ALTER TABLE OOT1080 ADD PunishViolated Decimal(28,8)
END

-------------------- 26/10/2019 - Vĩnh Tâm: Xóa 2 cột FromHour, ToHour --------------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1080' AND col.name = 'FromHour')
BEGIN
	ALTER TABLE OOT1080 DROP COLUMN FromHour
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1080' AND col.name = 'ToHour')
BEGIN
	ALTER TABLE OOT1080 DROP COLUMN ToHour
END

-------------------- 04/02/2020 - Vĩnh Tâm: Bổ sung cột TableViolatedID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1080' AND col.name = 'TableViolatedID')
BEGIN
	ALTER TABLE OOT1080 ADD TableViolatedID VARCHAR(50)
END
