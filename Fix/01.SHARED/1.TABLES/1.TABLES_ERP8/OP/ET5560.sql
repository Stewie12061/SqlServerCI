-- <Summary>
---- Bảng tạm chứa dữ liệu import excel khách hàng FUYUEH
-- <History>
---- Create on 05/04/2016 by Kim Vu
---- Modified on 14/04/2016 by Kim Vu Add Columns DIEN< NUOC
---- Modified on 26/6/2019 by Kim Thư: Bổ sung cột DVBS, QC
---- Modified on 03/11/2020 by Đức Thông: Bổ sung 2 cột PRO, PTQ
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ET5560]') AND type in (N'U'))
CREATE TABLE [dbo].[ET5560](
	[Serial] [nvarchar](50) NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[InvoiceDate] [datetime] NULL,
	[ObjectID] [nvarchar](50) NULL,
	[TMB] [decimal](28, 8) NULL,
	[PQL] [decimal](28, 8) NULL,
	[TKO] [decimal](28, 8) NULL,
	[SL] [INT] NULL)
	
--	Add Columns DIEN NUOC
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'ET5560' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'ET5560' AND col.name = 'NUO')
    ALTER TABLE ET5560 ADD NUO DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'ET5560' AND col.name = 'DIE')
    ALTER TABLE ET5560 ADD DIE DECIMAL(28,8) NULL
END

---- Modified on 26/6/2019 by Kim Thư: Bổ sung cột DVBS, QC
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'ET5560' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'ET5560' AND col.name = 'DVBS')
    ALTER TABLE ET5560 ADD DVBS DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'ET5560' AND col.name = 'QC')
    ALTER TABLE ET5560 ADD QC DECIMAL(28,8) NULL
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'ET5560' AND col.name = 'SL')
    ALTER TABLE ET5560 ADD SL INT NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'ET5560' AND col.name = 'PRO')
    ALTER TABLE ET5560 ADD PRO DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'ET5560' AND col.name = 'PTQ')
    ALTER TABLE ET5560 ADD PTQ  DECIMAL(28,8) NULL
END


	