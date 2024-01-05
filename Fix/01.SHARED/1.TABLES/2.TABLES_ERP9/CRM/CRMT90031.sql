---- Create by Cao Thị Phượng on 3/3/2017 9:39:10 AM
---- Danh mục ghi chú

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT90031]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT90031]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [NotesID] INT identity(1,1) NOT NULL,
  [NotesSubject] NVARCHAR(250) NOT NULL,
  [Description] NVARCHAR(MAX) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_CRMT90031] PRIMARY KEY CLUSTERED
(
  [NotesID] DESC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
--Bổ sung trường DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90031' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90031' AND col.name = 'DeleteFlg') 
   ALTER TABLE CRMT90031 ADD DeleteFlg TINYINT DEFAULT (0) NULL 
END
--Edit kiểu dữ liệu của notesSubject và Description
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90031' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90031' AND col.name = 'NotesSubject') 
   ALTER TABLE CRMT90031 ALTER COLUMN NotesSubject NTEXT NULL
END 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90031' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90031' AND col.name = 'Description') 
   ALTER TABLE CRMT90031 ALTER COLUMN [Description] NTEXT NULL
END 
--Edit kiểu dữ liệu của CreateUserID và LastModifyUserID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90031' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90031' AND col.name = 'CreateUserID') 
   ALTER TABLE CRMT90031 ALTER COLUMN CreateUserID NVARCHAR(50) NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90031' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90031' AND col.name = 'LastModifyUserID') 
   ALTER TABLE CRMT90031 ALTER COLUMN LastModifyUserID NVARCHAR(50) NULL
END 