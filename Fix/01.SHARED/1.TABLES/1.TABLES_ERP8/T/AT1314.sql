﻿-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Quốc Cường
---- Modified on 15/02/2016 by Tiểu Mai: Bổ sung 20 cột quy cách hàng hóa
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1314]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1314](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[InventoryNormID] [nvarchar](50) NOT NULL,
	[NormID] [nvarchar](50) NOT NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[WareHouseID] [nvarchar](50) NOT NULL,
	[MinQuantity] [decimal](28, 8) NULL,
	[MaxQuantity] [decimal](28, 8) NULL,
	[ReOrderQuantity] [decimal](28, 8) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT1314] PRIMARY KEY NONCLUSTERED 
(
	[InventoryNormID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--- Modify on 06/01/2015 by Bảo Anh
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1314' AND xtype='U')
	BEGIN
		ALTER TABLE AT1314 ALTER Column NormID nvarchar(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1314' AND col.name='FromDate')
		ALTER TABLE AT1314 ADD FromDate datetime  NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1314' AND col.name='ToDate')
		ALTER TABLE AT1314 ADD ToDate datetime  NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1314' AND col.name='TranMonth')
		ALTER TABLE AT1314 ADD TranMonth int  NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1314' AND col.name='TranYear')
		ALTER TABLE AT1314 ADD TranYear int  NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1314' AND col.name='Notes')
		ALTER TABLE AT1314 ADD Notes nvarchar(250)  NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1314' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1314' AND col.name='IsWareHouse')
		ALTER TABLE AT1314 ADD IsWareHouse int  NULL default 0

	END

--- Modified on 15/02/2016 by Tiểu Mai	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1314' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1314' AND col.name='S01ID')
		ALTER TABLE AT1314 ADD	S01ID NVARCHAR(50)  NULL,
								S02ID NVARCHAR(50)  NULL,
								S03ID NVARCHAR(50)  NULL,
								S04ID NVARCHAR(50)  NULL,
								S05ID NVARCHAR(50)  NULL,
								S06ID NVARCHAR(50)  NULL,
								S07ID NVARCHAR(50)  NULL,
								S08ID NVARCHAR(50)  NULL,
								S09ID NVARCHAR(50)  NULL,
								S10ID NVARCHAR(50)  NULL,
								S11ID NVARCHAR(50)  NULL,
								S12ID NVARCHAR(50)  NULL,
								S13ID NVARCHAR(50)  NULL,
								S14ID NVARCHAR(50)  NULL,
								S15ID NVARCHAR(50)  NULL,
								S16ID NVARCHAR(50)  NULL,
								S17ID NVARCHAR(50)  NULL,
								S18ID NVARCHAR(50)  NULL,
								S19ID NVARCHAR(50)  NULL,
								S20ID NVARCHAR(50)  NULL
END	
