--Create by: Phan thanh hoang vu
--Create Date: 25/04/2014
--Drop column "TableID"
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0017' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0017' AND col.name='TableID')
	ALTER TABLE POST0017 Drop Column TableID
END

