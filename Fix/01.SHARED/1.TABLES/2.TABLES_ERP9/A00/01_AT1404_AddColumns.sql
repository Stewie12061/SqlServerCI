--Add column 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1404' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1404' AND col.name='Disabled')
		ALTER TABLE AT1404 ADD Disabled TINYINT NOT NULL DEFAULT(0)
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1404' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1404' AND col.name='SourceID')
		ALTER TABLE AT1404 ADD SourceID VARCHAR(50) NULL
	END

-- Modified by Tấn Thành on 25/02/2021: Bổ sung cột CustomerIndex.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1404' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1404' AND col.name='CustomerIndex')
		ALTER TABLE AT1404 ADD CustomerIndex INT NULL
	END

-- [21/12/2022] - [Tấn Lộc] - Begin Add
-- Bổ sung cột OderNo Sắp xếp vị trí phân quyền màn hình
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1404' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1404' AND col.name='OrderNo')
		BEGIN
		   ALTER TABLE AT1404 ADD OrderNo INT NULL 
		END	
	END