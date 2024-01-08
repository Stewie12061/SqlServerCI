--Create by: Phan thanh hoang vu
--Create Date: 25/04/2014
--Drop column "Barcode"
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST00171' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST00171' AND col.name='Barcode')
	ALTER TABLE POST00171 Drop Column Barcode
END
