---------------------------Thêm cột EVoucherNo-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0024' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0024' AND col.name='EVoucherNo')
	ALTER TABLE POST0024 ADD EVoucherNo varchar(50) NULL
END