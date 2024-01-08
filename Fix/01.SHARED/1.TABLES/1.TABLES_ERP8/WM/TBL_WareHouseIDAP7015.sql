-- <Summary>
---- Dữ liệu kho truyền vào để xuất sổ chi tiết vật tư
-- <History>
---- Create on 12/12/2018 by Kim Thư
---- Modified on 20/05/2019 by Kim Thư: Không dùng bảng này nữa do AP7015 đã trả thẳng dữ liệu, không đụng view
---- <Example>
--IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TBL_WareHouseIDAP7015]') AND type in (N'U'))
--CREATE TABLE [dbo].[TBL_WareHouseIDAP7015](
--	WareHouseID VARCHAR(50)
--)
--IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='TBL_WareHouseIDAP7015' AND xtype='U')
--BEGIN
--	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
--	ON col.id=tab.id WHERE tab.name='TBL_WareHouseIDAP7015' AND col.name='UserID')
--	ALTER TABLE TBL_WareHouseIDAP7015 ADD UserID VARCHAR(50) NULL
--END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='TBL_WareHouseIDAP7015' AND xtype='U')
BEGIN
	DROP TABLE TBL_WareHouseIDAP7015
END

