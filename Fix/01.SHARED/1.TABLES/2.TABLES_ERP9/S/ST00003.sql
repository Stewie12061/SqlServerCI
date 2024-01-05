---- Create by truonglam on 2/7/2020 1:41:06 PM
---- Danh mục lịch sử

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST00003]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST00003]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [HistoryID] INT NULL,
  [Description] NVARCHAR(MAX) NULL,
  [RelatedToID] VARCHAR(50) NULL,
  [RelatedToTypeID] INT NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [StatusID] INT NULL,
  [ScreenID] VARCHAR(250) NULL,
  [TableID] VARCHAR(50) NULL
CONSTRAINT [PK_ST00003] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


---- Update by truonglam on 13/03/2020
---- Bổ sung các trường varchar lưu trước đó với giá trị 25==>50

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'ST00003' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'ST00003' AND col.name = 'RelatedToID') 
   ALTER TABLE ST00003 ALTER COLUMN RelatedToID VARCHAR (50)
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'ST00003' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'ST00003' AND col.name = 'TableID') 
   ALTER TABLE ST00003 ALTER COLUMN TableID VARCHAR (50)
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'ST00003' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'ST00003' AND col.name = 'CreateUserID') 
   ALTER TABLE ST00003 ALTER COLUMN CreateUserID VARCHAR (50)
END