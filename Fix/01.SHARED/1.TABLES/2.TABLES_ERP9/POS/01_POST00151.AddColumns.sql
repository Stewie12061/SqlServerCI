---------------------------Trang thai hoan tat/chua hoan tat-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST00151' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST00151' AND col.name='Status')
	ALTER TABLE POST00151 ADD Status TinyInt DEFAULT (0) NULL
END
