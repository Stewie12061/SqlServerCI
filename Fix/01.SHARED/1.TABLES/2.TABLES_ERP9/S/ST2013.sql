---- Create by Trọng Kiên on 9/24/2020 10:43:14 AM
---- Cập nhật hành động (Detail)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST2013]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST2013]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster_Pipeline] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [APKMaster_Action] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] VARCHAR(50) NULL,
  [DestColumn] VARCHAR(50) NULL,
  [TypeID] VARCHAR(50) NULL,
  [TypeName] NVARCHAR(250) NULL,
  [RefData] VARCHAR(50) NULL,
  [Value] VARCHAR(50) NULL,
  [Notes] NVARCHAR(250) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_ST2013] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 30/09/2020 - Trọng Kiên: Bổ sung cột IsTrash
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'IsTrash')
BEGIN
	ALTER TABLE ST2013 ADD IsTrash TINYINT DEFAULT (0) NULL
END

--- 30/09/2020 - Trọng Kiên: Bổ sung cột DestTable
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'DestTable')
BEGIN
	ALTER TABLE ST2013 ADD DestTable VARCHAR (50) NULL
END

--- 30/09/2020 - Trọng Kiên: Đổi tên cột RefData -> RefColumn
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'RefData')
BEGIN
	EXEC SP_RENAME 'ST2013."RefData"', 'RefColumn', 'COLUMN'
END

--- 01/10/2020 - Trọng Kiên: Bổ sung cột VoucherSettingTable
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'VoucherSettingTable')
BEGIN
	ALTER TABLE ST2013 ADD VoucherSettingTable VARCHAR(50) NULL
END

--- 01/10/2020 - Trọng Kiên: Bổ sung cột VoucherSettingColumn
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'VoucherSettingColumn')
BEGIN
	ALTER TABLE ST2013 ADD VoucherSettingColumn VARCHAR(50) NULL
END

--- 01/10/2020 - Trọng Kiên: Bổ sung cột RequiremedField
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'RequiremedField')
BEGIN
	ALTER TABLE ST2013 ADD RequiremedField INT NULL
END

--- 06/10/2020 - Trọng Kiên: Thay đổi kiểu dữ liệu Value
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'Value')
BEGIN
	ALTER TABLE ST2013 ALTER COLUMN Value NVARCHAR(250) NULL
END

--- 06/10/2020 - Trọng Kiên: Bổ sung cột TypeValue
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'TypeValue')
BEGIN
	ALTER TABLE ST2013 ADD TypeValue INT NULL
END

--- 06/10/2020 - Trọng Kiên: Bổ sung cột ComboboxValue
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'ComboboxValue')
BEGIN
	ALTER TABLE ST2013 ADD ComboboxValue NVARCHAR(50) NULL
END

--- 08/10/2020 - Trọng Kiên: Bổ sung cột SysComboboxID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'SysComboboxID')
BEGIN
	ALTER TABLE ST2013 ADD SysComboboxID NVARCHAR(50) NULL
END

--- 08/10/2020 - Trọng Kiên: Bổ sung cột DestColumnName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'DestColumnName')
BEGIN
	ALTER TABLE ST2013 ADD DestColumnName NVARCHAR(250) NULL
END

--- 08/10/2020 - Trọng Kiên: Bổ sung cột RefColumnName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'RefColumnName')
BEGIN
	ALTER TABLE ST2013 ADD RefColumnName NVARCHAR(250) NULL
END

--- 08/10/2020 - Trọng Kiên: Bổ sung cột ComboboxValueName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'ComboboxValueName')
BEGIN
	ALTER TABLE ST2013 ADD ComboboxValueName NVARCHAR(250) NULL
END

--- 08/10/2020 - Trọng Kiên: Bổ sung cột OrderNo
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2013' AND col.name = 'OrderNo')
BEGIN
	ALTER TABLE ST2013 ADD OrderNo NVARCHAR(250) NULL
END