---- Create by Trương Tấn Thành on 9/24/2020 10:24:00 AM
---- Hành động PipeLine (Các hành động chi tiết của một PipeLine)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST2011]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST2011]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] VARCHAR(50) NULL,
  [PipeLineID] VARCHAR(50) NULL,
  [ActionID] VARCHAR(50) NULL,
  [RefAction] VARCHAR(200) NULL,
  [DestAction] VARCHAR(200) NULL,
  [Statement] VARCHAR(250) NULL,
  [APIUrl] VARCHAR(250) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [IsTrash] TINYINT DEFAULT (1) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifiedUserID] VARCHAR(50) NULL,
  [LastModifiedDate] DATETIME NULL
CONSTRAINT [PK_ST2011] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 30/09/2020 - Trọng Kiên: Bổ sung cột StatementStored
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2011' AND col.name = 'StatementStored')
BEGIN
	ALTER TABLE ST2011 ADD StatementStored VARCHAR(50) NULL
END

--- 30/09/2020 - Trọng Kiên: Bổ sung cột TypeAPI
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2011' AND col.name = 'TypeAPI')
BEGIN
	ALTER TABLE ST2011 ADD TypeAPI VARCHAR(50) NULL
END

--- 30/09/2020 - Trọng Kiên: Bổ sung cột TypeSQL
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2011' AND col.name = 'TypeSQL')
BEGIN
	ALTER TABLE ST2011 ADD TypeSQL VARCHAR(50) NULL
END

--- 30/09/2020 - Trọng Kiên: Bổ sung cột IsTrash
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2011' AND col.name = 'IsTrash')
BEGIN
	ALTER TABLE ST2011 ADD IsTrash TINYINT DEFAULT (0) NULL
END

--- 30/09/2020 - Trọng Kiên: Đổi tên cột RefAction -> RefObject
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2011' AND col.name = 'RefAction')
BEGIN
	EXEC SP_RENAME 'ST2011."RefAction"', 'RefObject', 'COLUMN'
END

--- 30/09/2020 - Trọng Kiên: Đổi tên cột DestAction -> DestObject
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2011' AND col.name = 'DestAction')
BEGIN
	EXEC SP_RENAME 'ST2011."DestAction"', 'DestObject', 'COLUMN'
END

--- 30/09/2020 - Tấn Thành: Bổ sung cột OrderNo
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2011' AND col.name = 'OrderNo')
BEGIN
	ALTER TABLE ST2011 ADD OrderNo INT NULL
END

--- 08/10/2020 - Tấn Thành: Thay đổi tên cột LastModifiedUserID => LastModifyUserID
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2011' AND col.name = 'LastModifiedUserID')
BEGIN
	EXEC sp_RENAME 'ST2011.LastModifiedUserID', 'LastModifyUserID', 'COLUMN'
END

--- 08/10/2020 - Tấn Thành: Thay đổi tên cột LastModifiedDate => LastModifiedDate
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2011' AND col.name = 'LastModifiedDate')
BEGIN
	EXEC sp_RENAME 'ST2011.LastModifiedDate', 'LastModifyDate', 'COLUMN'
END

--- 09/10/2020 - Trọng Kiên: Thay đổi kiểu dữ liệu Statement
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2011' AND col.name = 'Statement')
BEGIN
	ALTER TABLE ST2011 ALTER COLUMN Statement NVARCHAR(MAX) NULL
END

--- 20/10/2020 - Tấn Thành: Thay đổi kiểu dữ liệu ApiURL => Varchar(MAX)
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2011' AND col.name = 'APIUrl')
BEGIN
	ALTER TABLE ST2011 ALTER COLUMN APIUrl VARCHAR(MAX) NULL;
END