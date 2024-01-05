---- Create by Trương Tấn Thành on 9/16/2020 4:45:18 PM
---- Danh mục Pipeline

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST2010]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST2010]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [PipeLineID] VARCHAR(50) NULL,
  [PipeLineName] NVARCHAR(MAX) NULL,
  [StatusID] INT NULL,
  [RefObject] VARCHAR(200) NULL,
  [ConditionTypeID] VARCHAR(50) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifiedUserID] VARCHAR(50) NULL,
  [LastModifiedDate] DATETIME NULL
CONSTRAINT [PK_ST2010] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 08/10/2020 - Tấn Thành: Thay đổi tên cột LastModifiedUserID => LastModifyUserID
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2010' AND col.name = 'LastModifiedUserID')
BEGIN
	EXEC sp_RENAME 'ST2010.LastModifiedUserID', 'LastModifyUserID', 'COLUMN'
END

--- 08/10/2020 - Tấn Thành: Thay đổi tên cột LastModifiedDate => LastModifiedDate
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2010' AND col.name = 'LastModifiedDate')
BEGIN
	EXEC sp_RENAME 'ST2010.LastModifiedDate', 'LastModifyDate', 'COLUMN'
END

--- 29/09/2020 - Tấn Thành: Bổ sung cột ActionActive
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2010' AND col.name = 'ActionActive')
BEGIN
	ALTER TABLE ST2010 ADD ActionActive VARCHAR(50) NULL
END

--- 08/01/2021 - Tấn Thành: Thay đổi tên cột IsNoObject => IsSystem
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2010' AND col.name = 'IsNoObject')
	AND NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'ST2010' AND col.name = 'IsSystem')
BEGIN
	EXEC sp_RENAME 'ST2010.IsNoObject', 'IsSystem', 'COLUMN'
END

--- 08/01/2021 - Tấn Thành: Bổ sung cột IsSystem
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2010' AND col.name = 'IsSystem')
BEGIN
	ALTER TABLE ST2010 ADD IsSystem TINYINT DEFAULT(0)
END

--- 08/01/2021 - Tấn Thành: Thay đổi tên cột APKAutomation => APKSettingTime
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2010' AND col.name = 'APKAutomation')
	AND NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'ST2010' AND col.name = 'APKSettingTime')

BEGIN
	EXEC sp_RENAME 'ST2010.APKAutomation', 'APKSettingTime', 'COLUMN'
END

--- 08/01/2021 - Tấn Thành: Bổ sung cột APKAutomation
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2010' AND col.name = 'APKSettingTime')
BEGIN
	ALTER TABLE ST2010 ADD APKSettingTime UNIQUEIDENTIFIER NULL
END