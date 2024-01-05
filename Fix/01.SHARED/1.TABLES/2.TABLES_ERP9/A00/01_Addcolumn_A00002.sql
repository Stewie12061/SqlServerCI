IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='A00002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='A00002' AND col.name='FormID')
		ALTER TABLE A00002 ADD FormID [nvarchar](50) NULL
	END