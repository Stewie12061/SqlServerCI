---- Create by Khâu Vĩnh Tâm on 4/4/2019 9:14:30 AM
---- Dữ liệu Thông báo - Cảnh báo theo User

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT9003]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT9003]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [UserID] VARCHAR(50) NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [IsRead] TINYINT DEFAULT 0 NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL
CONSTRAINT [PK_OOT9003] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 23/07/2020 - Tấn Lộc: Đổi tên cột IsReaded thành IsRead --------------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9003' AND col.name = 'IsReaded')
BEGIN
  EXEC sp_RENAME 'OOT9003.IsReaded', 'IsRead', 'COLUMN'
END

-------------------- 27/10/2020 - Trọng Kiên: Đổi tên cột DeleteFlag thành DeleteFlg --------------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9003' AND col.name = 'DeleteFlag')
BEGIN
  EXEC sp_RENAME 'OOT9003.DeleteFlag', 'DeleteFlg', 'COLUMN'
END

-------------------- 18/11/2020 - Tấn Thành: Bổ sung cột CreateUserID, CreateDate, LastModifyUserID, LastModifyDate--------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9003' AND col.name = 'CreateUserID')
BEGIN
  ALTER TABLE OOT9003 ADD CreateUserID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9003' AND col.name = 'CreateDate')
BEGIN
  ALTER TABLE OOT9003 ADD CreateDate DATETIME
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9003' AND col.name = 'LastModifyUserID')
BEGIN
  ALTER TABLE OOT9003 ADD LastModifyUserID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT9003' AND col.name = 'LastModifyDate')
BEGIN
  ALTER TABLE OOT9003 ADD LastModifyDate DATETIME
END

