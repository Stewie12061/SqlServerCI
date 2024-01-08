IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='MTT0090' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MTT0090' AND col.name='IsAdmin')
		ALTER TABLE MTT0090 ADD IsAdmin BIT NOT NULL DEFAULT(0)
	END