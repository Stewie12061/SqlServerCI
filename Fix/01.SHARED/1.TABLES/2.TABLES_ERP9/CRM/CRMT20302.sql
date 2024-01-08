---- Create by Đình Hòa 07/12/2020
---- Mối liên hệ giữa Đầu mới và định vị

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT20302]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT20302]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [CampaignDetailID] VARCHAR(50) NULL,
  [StatusDetailID] VARCHAR(50) NULL,
  [SerminarID] VARCHAR(MAX) NULL,
  [ThematicID] VARCHAR(MAX) NULL
CONSTRAINT [PK_CRMT20302] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT20302' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT20302' AND col.name = 'CreateDate')
    ALTER TABLE CRMT20302 ADD CreateDate DATETIME NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT20302' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT20302' AND col.name = 'CreateUserID')
    ALTER TABLE CRMT20302 ADD CreateUserID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT20302' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT20302' AND col.name = 'LastModifyDate')
    ALTER TABLE CRMT20302 ADD LastModifyDate DATETIME NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT20302' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT20302' AND col.name = 'LastModifyUserID')
    ALTER TABLE CRMT20302 ADD LastModifyUserID  VARCHAR(50) NULL
END