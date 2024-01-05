---- Create by Khâu Vĩnh Tâm on 3/22/2019 9:13:35 AM
---- Dữ liệu Thông báo - Cảnh báo

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT9002]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT9002]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [Title] NVARCHAR(MAX) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [ScreenType] INT NULL,
  [ScreenID] VARCHAR(50) NULL,
  [ScreenName] NVARCHAR(250) NULL,
  [ModuleID] VARCHAR(50) NULL,
  [UrlCustom] NVARCHAR(MAX) NULL,
  [Parameters] NVARCHAR(MAX) NULL,
  [DeleteFlag] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_OOT9002] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

ALTER TABLE OOT9002 ALTER COLUMN APKMaster UNIQUEIDENTIFIER NULL
ALTER TABLE OOT9002 ALTER COLUMN Description NVARCHAR(MAX) NULL
ALTER TABLE OOT9002 ALTER COLUMN ScreenType INT NULL
ALTER TABLE OOT9002 ALTER COLUMN ScreenID VARCHAR(50) NULL
ALTER TABLE OOT9002 ALTER COLUMN ScreenName VARCHAR(250) NULL
ALTER TABLE OOT9002 ALTER COLUMN ModuleID VARCHAR(50) NULL

-------------------- 11/06/2019 - Truong Lam: Bổ sung cột EffectDate (Ngày ảnh hưởng) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9002' AND col.name = 'EffectDate')
BEGIN
  ALTER TABLE OOT9002 ADD EffectDate DATETIME NULL
END

-------------------- 11/06/2019 - Truong Lam: Bổ sung cột ExpiryDate (ngày hết hạn) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9002' AND col.name = 'ExpiryDate')
BEGIN
  ALTER TABLE OOT9002 ADD ExpiryDate DATETIME NULL
END

-------------------- 11/06/2019 - Truong Lam: Bổ sung cột Disabled (Ẩn hiện) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9002' AND col.name = 'Disabled')
BEGIN
  ALTER TABLE OOT9002 ADD Disabled TINYINT DEFAULT 0
END

-------------------- 18/07/2019 - Vĩnh Tâm: Bổ sung cột ImageName, ImageUrl --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9002' AND col.name = 'ImageName')
BEGIN
  ALTER TABLE OOT9002 ADD ImageName NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9002' AND col.name = 'ImageUrl')
BEGIN
  ALTER TABLE OOT9002 ADD ImageUrl NVARCHAR(MAX) NULL
END

-------------------- 12/09/2019 - Vĩnh Tâm: Bổ sung cột ShowType --------------------
-- Giá trị:
--	+ 0: Mở màn hình bằng tab hiện tại
--	+ 1: Mở màn hình bằng một tab mới
--	+ 2: Mở màn hình bằng popup
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9002' AND col.name = 'ShowType')
BEGIN
  ALTER TABLE OOT9002 ADD ShowType INT DEFAULT 0
END

-------------------- 20/07/2020 - Tấn Lộc: Bổ sung cột BusinessTypeID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9002' AND col.name = 'BusinessTypeID')
BEGIN
  ALTER TABLE OOT9002 ADD BusinessTypeID INT DEFAULT 0
END

-------------------- 07/12/2021 - Kiều Nga: Bổ sung cột MessageType --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9002' AND col.name = 'MessageType')
BEGIN
  ALTER TABLE OOT9002 ADD MessageType INT DEFAULT 0
END

