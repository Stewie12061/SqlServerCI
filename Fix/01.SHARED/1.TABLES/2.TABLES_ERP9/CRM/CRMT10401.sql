---- Create by Phan thanh hoàng vũ on 3/7/2017 4:03:02 PM
---- Danh mục giai đoạn

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT10401]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT10401]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [StageID] VARCHAR(50) NOT NULL,
  [StageName] NVARCHAR(250) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [Description] NVARCHAR(250) NULL,
  [OrderNo] INT NULL
CONSTRAINT [PK_CRMT10401] PRIMARY KEY CLUSTERED
(
  [StageID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--Bổ sung cột load combo [loại giai đoạn]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT10401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT10401' AND col.name = 'StageType') 
   ALTER TABLE CRMT10401 ADD StageType INT NOT NULL
END
--Cột quản lý ngầm phân biệt giá trị người dùng thêm mới và giá trị mặc định trong hệ thống (Thắng và thua)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT10401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT10401' AND col.name = 'IsSystem') 
   ALTER TABLE CRMT10401 ADD IsSystem TINYINT DEFAULT (0) NOT NULL
END
--Lấy giá trị % mặc định qua cơ hội hoặc đầu mối theo giai đoạn
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT10401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT10401' AND col.name = 'Rate') 
   ALTER TABLE CRMT10401 ADD Rate DECIMAL(28,8) DEFAULT (0) NULL 
END
---------------- 06/07/2021 - Ngọc Long: Bổ sung cột Color, StageNameE, SystemStatus, DataFilter ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT10401' AND col.name = 'Color')
BEGIN
	ALTER TABLE CRMT10401 ADD Color VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT10401' AND col.name = 'StageNameE')
BEGIN
	ALTER TABLE CRMT10401 ADD StageNameE NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT10401' AND col.name = 'SystemStatus')
BEGIN
	ALTER TABLE CRMT10401 ADD SystemStatus TINYINT NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT10401' AND col.name = 'DataFilter')
BEGIN
	ALTER TABLE CRMT10401 ADD DataFilter TINYINT NULL
END