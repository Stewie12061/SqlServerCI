IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CCMT0005]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[CCMT0005]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [GroupID] NVARCHAR(50) NOT NULL,
      [UserID] VARCHAR(50) NOT NULL,
    CONSTRAINT [PK_CCMT0005] PRIMARY KEY CLUSTERED
      (
      [GroupID], [UserID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0005' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'CCMT0005' AND col.name = 'IsRead') 
		   ALTER TABLE CCMT0005 ADD IsRead Tinyint NULL Default 0
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0005' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'CCMT0005' AND col.name = 'Deleted') 
		   ALTER TABLE CCMT0005 ADD Deleted Tinyint NULL Default 0
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0005' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'CCMT0005' AND col.name = 'DeleteDate') 
		   ALTER TABLE CCMT0005 ADD DeleteDate DateTime NULL
END