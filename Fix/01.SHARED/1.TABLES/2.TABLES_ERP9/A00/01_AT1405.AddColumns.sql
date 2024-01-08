IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1405' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1405' AND col.name='IsLock')
		ALTER TABLE AT1405 ADD IsLock TINYINT NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1405' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1405' AND col.name='LanguageID')
		ALTER TABLE AT1405 ADD LanguageID VARCHAR(50) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1405' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1405' AND col.name='PageSize')
		ALTER TABLE AT1405 ADD PageSize INT NULL
	END
