---- Create by Trương Tấn Thành on 9/17/2020 1:12:18 PM
---- Hành động - Action (Combobox)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST2014]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST2014]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [ActionID] VARCHAR(50) NULL,
  [ActionName] NVARCHAR(250) NULL,
  [RefObject] VARCHAR(50) NULL,
  [ActionClient] VARCHAR(50) NULL,
  [ActionSever] VARCHAR(50) NULL,
  [PopupUrl] VARCHAR(200) NULL,
  [Description] NVARCHAR(250) NULL,
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifiedUserID] VARCHAR(50) NULL,
  [LastModifiedDate] DATETIME NULL
CONSTRAINT [PK_ST2014] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 29/09/2020 - [Tấn Thành] Bổ sung cột ActionType 
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2014' AND col.name = 'ActionType')
BEGIN
	ALTER TABLE ST2014 ADD ActionType INT
END

--- 08/10/2020 - Tấn Thành: Thay đổi tên cột LastModifiedUserID => LastModifyUserID
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2014' AND col.name = 'LastModifiedUserID')
BEGIN
	EXEC sp_RENAME 'ST2014.LastModifiedUserID', 'LastModifyUserID', 'COLUMN'
END

--- 08/10/2020 - Tấn Thành: Thay đổi tên cột LastModifiedDate => LastModifiedDate
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2014' AND col.name = 'LastModifiedDate')
BEGIN
	EXEC sp_RENAME 'ST2014.LastModifiedDate', 'LastModifyDate', 'COLUMN'
END

--- 08/10/2020 - Trọng Kiên: Bổ sung cột ObjectTableName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2014' AND col.name = 'ObjectTableName')
BEGIN
	ALTER TABLE ST2014 ADD ObjectTableName VARCHAR(50) NULL
END