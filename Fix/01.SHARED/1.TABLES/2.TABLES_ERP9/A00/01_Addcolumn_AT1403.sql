IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1403' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1403' AND col.name='IsExportExcel')
		ALTER TABLE AT1403 ADD IsExportExcel TINYINT NOT NULL DEFAULT(0)
	END

