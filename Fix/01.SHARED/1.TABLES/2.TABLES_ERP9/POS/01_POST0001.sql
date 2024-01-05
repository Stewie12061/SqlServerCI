---------------------------Thêm cột Disabled-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0001' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0001' AND col.name='Disabled')
	ALTER TABLE POST0001 ADD Disabled tinyint NULL
END

---------------------------Xóa cột PageSize-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0001' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0001' AND col.name='PageSize')
	ALTER TABLE POST0001 DROP COLUMN PageSize
END
--------- Modify by Lê Thị Hạnh on 04/07/2014
--------- Thêm mới GroupInventoryID POS-PHUCLONG
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='POST0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='POST0001' AND col.name='GroupInventoryID')
		ALTER TABLE POST0001 ADD GroupInventoryID INT NULL
	END
--------- Modify by Lê Thị Hạnh on 23/07/2014
--------- Sửa kiểu dữ liệu cột GroupInventoryID POS-PHUCLONG (Customize Index: 32)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='POST0001' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='POST0001' AND col.name='GroupInventoryID')
		ALTER TABLE POST0001 ALTER COLUMN GroupInventoryID VARCHAR(50) NULL 
	END
