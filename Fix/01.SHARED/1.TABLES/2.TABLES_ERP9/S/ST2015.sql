---- Create by Trọng Kiên on 9/24/2020 4:02:55 PM
---- Danh mục đối tượng tham chiếu

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST2015]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST2015]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [ObjectID] VARCHAR(50) NULL,
  [RefObjectName] NVARCHAR(250) NULL,
  [ObjectTableName] VARCHAR(50) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifiedUserID] VARCHAR(50) NULL,
  [LastModifiedDate] DATETIME NULL
CONSTRAINT [PK_ST2015] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 30/09/2020 - Trọng Kiên: Bổ sung cột ObjectTableNameDetail
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2015' AND col.name = 'ObjectTableNameDetail')
BEGIN
	ALTER TABLE ST2015 ADD ObjectTableNameDetail VARCHAR(50) NULL
END

--- 30/09/2020 - Trọng Kiên: Bổ sung cột Area
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2015' AND col.name = 'Area')
BEGIN
	ALTER TABLE ST2015 ADD Area VARCHAR(50) NULL
END

--- 30/09/2020 - Trọng Kiên: Bổ sung cột FormID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2015' AND col.name = 'FormID')
BEGIN
	ALTER TABLE ST2015 ADD FormID VARCHAR(50) NULL
END

--- 01/10/2020 - Trọng Kiên: Bổ sung cột VoucherSettingTable
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2015' AND col.name = 'VoucherSettingTable')
BEGIN
	ALTER TABLE ST2015 ADD VoucherSettingTable VARCHAR(50) NULL
END

--- 01/10/2020 - Trọng Kiên: Bổ sung cột VoucherSettingColumn
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2015' AND col.name = 'VoucherSettingColumn')
BEGIN
	ALTER TABLE ST2015 ADD VoucherSettingColumn VARCHAR(50) NULL
END

--- 08/10/2020 - Tấn Thành: Thay đổi tên cột LastModifiedUserID => LastModifyUserID
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2015' AND col.name = 'LastModifiedUserID')
BEGIN
	EXEC sp_RENAME 'ST2015.LastModifiedUserID', 'LastModifyUserID', 'COLUMN'
END

--- 08/10/2020 - Tấn Thành: Thay đổi tên cột LastModifiedDate => LastModifiedDate
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2015' AND col.name = 'LastModifiedDate')
BEGIN
	EXEC sp_RENAME 'ST2015.LastModifiedDate', 'LastModifyDate', 'COLUMN'
END