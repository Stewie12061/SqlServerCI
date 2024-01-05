IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0129]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[AT0129]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [TemplateID] VARCHAR(50) NOT NULL,
      [TemplateName] NVARCHAR(250) NULL,
      [EmailTitle] NVARCHAR(250) NULL,
      [EmailGroupID] VARCHAR(50) NULL,
      [IsHTML] TINYINT DEFAULT (0) NULL,
      [EmailBody] NVARCHAR(4000) NULL,
      [IsCommon] TINYINT DEFAULT (0) NOT NULL,
      [Disabled] TINYINT DEFAULT (0) NOT NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_AT0129] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [TemplateID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
---------------------------- AlterColumns--------------------------------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0129' AND xtype='U')
BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0129' AND col.name='EmailBody')
			ALTER TABLE AT0129 ALTER COLUMN EmailBody NVARCHAR(max) NULL 
		ELSE		
			ALTER TABLE AT0129 ADD EmailBody NVARCHAR(MAX) NULL 

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0129' AND col.name='TemplateID')
			ALTER TABLE AT0129 ADD TemplateID VARCHAR(50) NULL 

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0129' AND col.name='EmailGroupID')
			ALTER TABLE AT0129 ALTER COLUMN EmailGroupID VARCHAR(50) NULL 
		ELSE
			ALTER TABLE AT0129 ADD EmailGroupID VARCHAR(50) NULL

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0129' AND col.name='TemplateName')
			ALTER TABLE AT0129 ALTER COLUMN TemplateName NVARCHAR(250) NULL 
		ELSE		
			ALTER TABLE AT0129 ADD TemplateName NVARCHAR(250) NULL 

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0129' AND col.name='EmailTitle')
			ALTER TABLE AT0129 ALTER COLUMN EmailTitle NVARCHAR(250) NULL 
		ELSE		
			ALTER TABLE AT0129 ADD EmailTitle NVARCHAR(250) NULL 

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0129' AND col.name='IsHTML')
			ALTER TABLE AT0129 ALTER COLUMN IsHTML TINYINT NULL 
		ELSE		
			ALTER TABLE AT0129 ADD IsHTML TINYINT NULL 
END


