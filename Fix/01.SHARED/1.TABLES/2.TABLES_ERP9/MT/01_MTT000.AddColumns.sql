IF EXISTS (SELECT * FROM sysobjects WHERE NAME='MTT0000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MTT0000' AND col.name='PageSize')
	ALTER TABLE MTT0000 ADD PageSize INT DEFAULT (25) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='MTT0000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MTT0000' AND col.name='EduVoucherTypeID')
	ALTER TABLE MTT0000 ADD EduVoucherTypeID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='MTT0000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MTT0000' AND col.name='StopVoucherTypeID')
	ALTER TABLE MTT0000 ADD StopVoucherTypeID VARCHAR(50) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='MTT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MTT0000' AND col.name='BranchAna')
		ALTER TABLE MTT0000 ADD BranchAna VARCHAR(50) NULL
	END
