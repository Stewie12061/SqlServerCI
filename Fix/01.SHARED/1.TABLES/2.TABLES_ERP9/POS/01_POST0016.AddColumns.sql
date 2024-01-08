---------------------------Khach dua-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0016' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0016' AND col.name='Cash')
	ALTER TABLE POST0016 ADD Cash Decimal(28,6) DEFAULT (0) NULL
END
----------------------------Tien thua--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0016' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0016' AND col.name='Change')
	ALTER TABLE POST0016 ADD Change Decimal(28,6) DEFAULT (0) NULL
END
