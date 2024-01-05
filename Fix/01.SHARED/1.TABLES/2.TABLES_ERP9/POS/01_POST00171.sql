--Create by: Phan thanh hoang vu
--Create Date: 25/04/2014
--Drop column "Barcode"
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST00171' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST00171' AND col.name='Barcode')
	ALTER TABLE POST00171 Drop Column Barcode
END

--Modified by Thị Phượng Date: 22/03/2018: Bổ sung trường STT để lưu theo đúng thứ tự
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST00171' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00171' AND col.name = 'OrderNo') 
   ALTER TABLE POST00171 ADD OrderNo INT NULL 
END

/*===============================================END OrderNo===============================================*/ 