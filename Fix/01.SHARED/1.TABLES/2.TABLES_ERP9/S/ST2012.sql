---- Create by Trương Tấn Thành on 9/24/2020 10:26:50 AM
---- Điều kiện thực thi PipeLine

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST2012]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST2012]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [DivisionID] VARCHAR(50) NULL,
  [PipeLineID] VARCHAR(50) NULL,
  [ConditionObject] VARCHAR(50) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifiedUserID] VARCHAR(50) NULL,
  [LastModifiedDate] DATETIME NULL
CONSTRAINT [PK_ST2012] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 29/09/2020 - Tấn Thành: Bổ sung cột ConditionValue
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'ConditionValue')
BEGIN
	ALTER TABLE ST2012 ADD ConditionValue VARCHAR(50) NULL
END

--- 29/09/2020 - Tấn Thành: Xóa cột Operation
IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'OperationID')
BEGIN
	ALTER TABLE ST2012 DROP COLUMN OperationID
END

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'Operation')
BEGIN
	ALTER TABLE ST2012 ADD Operation VARCHAR(50) NULL
END

--- 29/09/2020 - Tấn Thành: Xóa cột RefObject
IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'RefObject')
BEGIN
	ALTER TABLE ST2012 DROP COLUMN RefObject
END

--- 29/09/2020 - Tấn Thành: Xóa cột StatusTypeID
IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'StatusTypeID')
BEGIN
	ALTER TABLE ST2012 DROP COLUMN StatusTypeID
END

--- 29/09/2020 - Tấn Thành: Bổ sung cột ControlType
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'ControlType')
BEGIN
	ALTER TABLE ST2012 ADD ControlType VARCHAR(50) NULL
END

--- 06/10/2020 - Tấn Thành: Thay đổi dữ liệu cột ConditionValue thành NVARCHAR
IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'ConditionValue')
BEGIN
	ALTER TABLE ST2012 
	ALTER COLUMN ConditionValue NVARCHAR(200) NULL
END

--- 07/10/2020 - Tấn Thành: Bổ sung cột OrderNo
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'OrderNo')
BEGIN
	ALTER TABLE ST2012 ADD OrderNo INT NULL
END

--- 08/10/2020 - Tấn Thành: Thay đổi tên cột LastModifiedUserID => LastModifyUserID
IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'LastModifiedUserID')
BEGIN
	EXEC sp_RENAME 'ST2012.LastModifiedUserID', 'LastModifyUserID', 'COLUMN'
END

--- 08/10/2020 - Tấn Thành: Thay đổi tên cột LastModifiedDate => LastModifyDate
IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'LastModifiedDate')
BEGIN
	EXEC sp_RENAME 'ST2012.LastModifiedDate', 'LastModifyDate', 'COLUMN'
END

--- 09/10/2020 - Tấn Thành: Bổ sung cột ConditionObjectName
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'ConditionObjectName')
BEGIN
	ALTER TABLE ST2012 ADD ConditionObjectName NVARCHAR(200) NULL
END

--- 09/10/2020 - Tấn Thành: Fix lỗi sai tên cột DivisionID
IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'DivisonID')
BEGIN
	EXEC SP_RENAME 'ST2012.DivisonID', 'DivisionID', 'COLUMN'
END

--- 13/10/2020 - Tấn Thành: Bổ sung cột IsRequired
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2012' AND col.name = 'IsRequired')
BEGIN
	ALTER TABLE ST2012 ADD IsRequired TINYINT NULL
END