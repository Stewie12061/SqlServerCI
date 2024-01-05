---- Create by Tấn Lộc on 12/04/2022 9:39:10 AM
---- Danh mục comment tương tương với khách hàng thông qua các kênh

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT90032]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT90032]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [NotesID] INT identity(1,1) NOT NULL,
  [NotesSubject] NVARCHAR(250) NOT NULL,
  [CommentDescription] NVARCHAR(MAX) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_CRMT90032] PRIMARY KEY CLUSTERED
(
  [NotesID] DESC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
--Bổ sung trường DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90032' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90032' AND col.name = 'DeleteFlg') 
   ALTER TABLE CRMT90032 ADD DeleteFlg TINYINT DEFAULT (0) NULL 
END
--Edit kiểu dữ liệu của notesSubject và CommentDescription
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90032' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90032' AND col.name = 'NotesSubject') 
   ALTER TABLE CRMT90032 ALTER COLUMN NotesSubject NTEXT NULL
END 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90032' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90032' AND col.name = 'CommentDescription') 
   ALTER TABLE CRMT90032 ALTER COLUMN [CommentDescription] NTEXT NULL
END 
--Edit kiểu dữ liệu của CreateUserID và LastModifyUserID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90032' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90032' AND col.name = 'CreateUserID') 
   ALTER TABLE CRMT90032 ALTER COLUMN CreateUserID NVARCHAR(250) NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90032' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90032' AND col.name = 'LastModifyUserID') 
   ALTER TABLE CRMT90032 ALTER COLUMN LastModifyUserID NVARCHAR(250) NULL
END 