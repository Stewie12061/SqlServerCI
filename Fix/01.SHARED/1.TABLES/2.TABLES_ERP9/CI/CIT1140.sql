---- Create by Thái Huỳnh Khả Vi on 12/1/2017 3:26:22 PM
---- Danh mục quản lý theo vị trí (master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1140]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CIT1140]
(
  [DivisionID] VARCHAR(50) NOT NULL,
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [WareHouseID] VARCHAR(50) NULL,
  [LevelID] VARCHAR(50) NULL,
  [CreateUserID] VARCHAR(50) NULL, 
  [CreateDate] DATETIME NULL, 
  [LastModifyUserID] VARCHAR(50) NULL, 
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_CIT1140] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='CIT1140' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CIT1140' AND col.name='CreateUserID')
	ALTER TABLE CIT1140 ADD CreateUserID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CIT1140' AND col.name='CreateDate')
	ALTER TABLE CIT1140 ADD CreateDate DATETIME NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CIT1140' AND col.name='LastModifyUserID')
	ALTER TABLE CIT1140 ADD LastModifyUserID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='CIT1140' AND col.name='LastModifyDate')
	ALTER TABLE CIT1140 ADD LastModifyDate DATETIME NULL
END











