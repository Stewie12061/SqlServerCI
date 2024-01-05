IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name= 'WorkHistory')
		ALTER TABLE DRT2019 ADD WorkHistory NVARCHAR(MAX) NULL
	END
