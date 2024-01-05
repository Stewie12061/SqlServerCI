------ Modify by Lê Thị Hạnh on 10/07/2014
------ Bổ sung thêm trường vào bảng POST0033 theo file Phân tích màn hình POSF0040
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='POST0033' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='POST0033' AND col.name='AccruedScore')
		ALTER TABLE POST0033 ADD AccruedScore INT NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='POST0033' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='POST0033' AND col.name='PayScoreRate')
		ALTER TABLE POST0033 ADD PayScoreRate DECIMAL(28,8) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='POST0033' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='POST0033' AND col.name='PayScore')
		ALTER TABLE POST0033 ADD PayScore INT NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='POST0033' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='POST0033' AND col.name='AmountOfPoint')
		ALTER TABLE POST0033 ADD AmountOfPoint DECIMAL(28,8) NULL
	END
------- MODIFY BY LÊ THỊ HẠNH ON 11/07/2014
------- THÊM TRƯỜNG LƯU MÁY IN HÓA ĐƠN
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='POST0033' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='POST0033' AND col.name='DefaultPrinter3')
		ALTER TABLE POST0033 ADD DefaultPrinter3 NVARCHAR(250) NULL
	END

