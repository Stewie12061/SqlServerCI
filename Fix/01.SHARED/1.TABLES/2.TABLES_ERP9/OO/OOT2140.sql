---- Create by Khâu Vĩnh Tâm on 6/14/2019 3:57:34 PM
---- Định mức chi phí dự án

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2140]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2140]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [ProjectID] VARCHAR(50) NULL,
  [Disabled] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_OOT2140] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 23/07/2019 - Vĩnh Tâm: Bổ sung cột APKMaster_9000, Levels, DeleteFlg --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2140' AND col.name = 'APKMaster_9000')
BEGIN
	ALTER TABLE OOT2140 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2140' AND col.name = 'Levels')
BEGIN
	ALTER TABLE OOT2140 ADD Levels VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2140' AND col.name = 'DeleteFlg')
BEGIN
	ALTER TABLE OOT2140 ADD DeleteFlg TINYINT DEFAULT 0
END
-------------------- 24/10/2019 - Đình Ly: Bổ sung cột Status, QuotationID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2140' AND col.name = 'Status')
BEGIN
	ALTER TABLE OOT2140 ADD Status TINYINT NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2140' AND col.name = 'QuotationID')
BEGIN
	ALTER TABLE OOT2140 ADD QuotationID VARCHAR(50) NULL
END


