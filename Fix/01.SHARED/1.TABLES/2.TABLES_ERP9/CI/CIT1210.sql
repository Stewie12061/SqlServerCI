---- Create by Đinh Nhật Quang on 6/27/2022 9:00:11 AM
---- Danh sách nhân viên được chọn giao việc

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1210]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CIT1210]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [GroupID] NVARCHAR(250) NOT NULL,
  [GroupName] NVARCHAR(250) NOT NULL,
  [CreateUserID] NVARCHAR(100) NOT NULL,
  [UserMarkedID] NVARCHAR(100) NOT NULL,
CONSTRAINT [PK_CIT1210] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CIT1210' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CIT1210' AND col.name = 'DivisionID') 
   ALTER TABLE CIT1210 ADD DivisionID NVARCHAR(100) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CIT1210' AND col.name = 'CreateDate') 
   ALTER TABLE CIT1210 ADD CreateDate DATETIME NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CIT1210' AND col.name = 'LastModifyDate') 
   ALTER TABLE CIT1210 ADD LastModifyDate DATETIME NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CIT1210' AND col.name = 'LastModifyUserID') 
   ALTER TABLE CIT1210 ADD LastModifyUserID NVARCHAR(100) NULL 
END