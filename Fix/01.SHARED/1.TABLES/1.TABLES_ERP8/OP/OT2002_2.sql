-- <Summary>
---- 
-- <History>
---- Tách riêng tạo cột do nếu chạy chung với fix table OT2002 sẽ báo lỗi giới hạn tổng kích thước các cột
---- Create by Kim Thư on 09/05/2019: Bổ sung cột cho Song Bình

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='InventoryCommonName')
	ALTER TABLE OT2002 ADD InventoryCommonName NVARCHAR(MAX) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Aut')
	ALTER TABLE OT2002 ADD Aut VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Cut')
	ALTER TABLE OT2002 ADD Cut VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Date01')
	ALTER TABLE OT2002 ADD Date01 DATETIME NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Date02')
	ALTER TABLE OT2002 ADD Date02 DATETIME NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Date03')
	ALTER TABLE OT2002 ADD Date03 DATETIME NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Date04')
	ALTER TABLE OT2002 ADD Date04 DATETIME NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Date05')
	ALTER TABLE OT2002 ADD Date05 DATETIME NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='DestLocn')
	ALTER TABLE OT2002 ADD DestLocn NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Notes03')
	ALTER TABLE OT2002 ADD Notes03 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Notes04')
	ALTER TABLE OT2002 ADD Notes04 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Notes05')
	ALTER TABLE OT2002 ADD Notes05 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectAddress01')
	ALTER TABLE OT2002 ADD ObjectAddress01 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectAddress02')
	ALTER TABLE OT2002 ADD ObjectAddress02 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectCity01')
	ALTER TABLE OT2002 ADD ObjectCity01 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectCity02')
	ALTER TABLE OT2002 ADD ObjectCity02 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectCntry01')
	ALTER TABLE OT2002 ADD ObjectCntry01 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectCntry02')
	ALTER TABLE OT2002 ADD ObjectCntry02 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectID01')
	ALTER TABLE OT2002 ADD ObjectID01 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectID02')
	ALTER TABLE OT2002 ADD ObjectID02 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectName01')
	ALTER TABLE OT2002 ADD ObjectName01 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectName02')
	ALTER TABLE OT2002 ADD ObjectName02 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectState01')
	ALTER TABLE OT2002 ADD ObjectState01 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectState02')
	ALTER TABLE OT2002 ADD ObjectState02 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectZip01')
	ALTER TABLE OT2002 ADD ObjectZip01 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectZip02')
	ALTER TABLE OT2002 ADD ObjectZip02 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='OrigLocn')
	ALTER TABLE OT2002 ADD OrigLocn NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='RefName01')
	ALTER TABLE OT2002 ADD RefName01 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='RefName02')
	ALTER TABLE OT2002 ADD RefName02 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='SurDesc1')
	ALTER TABLE OT2002 ADD SurDesc1 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='SurDesc2')
	ALTER TABLE OT2002 ADD SurDesc2 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='SurDesc3')
	ALTER TABLE OT2002 ADD SurDesc3 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='SurDesc4')
	ALTER TABLE OT2002 ADD SurDesc4 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='SurDesc5')
	ALTER TABLE OT2002 ADD SurDesc5 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='SurDesc6')
	ALTER TABLE OT2002 ADD SurDesc6 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='SurDesc7')
	ALTER TABLE OT2002 ADD SurDesc7 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='SurDesc8')
	ALTER TABLE OT2002 ADD SurDesc8 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='SvAbbrew')
	ALTER TABLE OT2002 ADD SvAbbrew NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='SvType')
	ALTER TABLE OT2002 ADD SvType NVARCHAR(250) NULL
END



