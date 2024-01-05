IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CCMT0006]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[CCMT0006]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [GroupID] NVARCHAR(50) NOT NULL,
      [Content] NVARCHAR(MAX) NOT NULL,
      [CreateUserID] VARCHAR(50) NOT NULL,
      [CreateDate] DATETIME NULL,
	  [LastModifyUserID] VARCHAR(50) NOT NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_CCMT0006] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0006' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'CCMT0006' AND col.name = 'DeletedByUsers') 
		   ALTER TABLE CCMT0006 ADD DeletedByUsers NVARCHAR(MAX) NULL
END

--1: ảnh, 2: video, 3: Nghiệp vụ
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0006' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'CCMT0006' AND col.name = 'Type') 
		   ALTER TABLE CCMT0006 ADD Type int NULL
END

--Lưu json thông tin nghiệp vụ được chia sẻ hoặc muốn lưu gì lưu tùy case mà xử lý 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0006' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'CCMT0006' AND col.name = 'ExtraData') 
		   ALTER TABLE CCMT0006 ADD ExtraData NVARCHAR(MAX) NULL
END