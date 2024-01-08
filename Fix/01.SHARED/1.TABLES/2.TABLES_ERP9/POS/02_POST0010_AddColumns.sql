---------------------------Thêm cột WarehouseID-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0010' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0010' AND col.name='WarehouseID')
	ALTER TABLE POST0010 ADD WarehouseID varchar(50) NULL
END

---------------------------Thêm cột WareHouseName-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0010' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0010' AND col.name='WareHouseName')
	ALTER TABLE POST0010 ADD WareHouseName nvarchar(250) NULL
END

---Kiều Nga on 17/09/2019 --Bảng giá linh kiện, dịch vụ
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST0010' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST0010' AND col.name = 'IsServicePriceID') 
   ALTER TABLE POST0010 ADD IsServicePriceID TINYINT NULL 
END

---Kiều Nga on 17/09/2019 --Bảng giá linh kiện, dịch vụ
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST0010' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST0010' AND col.name = 'ServicePriceID') 
   ALTER TABLE POST0010 ADD ServicePriceID VARCHAR(50) NULL 
END
