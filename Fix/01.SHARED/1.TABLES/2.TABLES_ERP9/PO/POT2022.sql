-- <Summary>
---- 
-- <History>
---- Create on 14/03/2019 by Như Hàn: Bảng yêu cầu báo giá nhà cung cấp (Detail)
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POT2022]') AND type in (N'U'))
CREATE TABLE [dbo].[POT2022](
	[APK] [uniqueidentifier] NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[OrderID] [INT] NULL,
	[InventoryID] [varchar](50) NULL,
	[UnitPrice] [decimal](28) NULL,
	[Quantity] [decimal](28) NULL,
	[RequestPrice] [decimal](28) NULL,
	[Notes] [nvarchar](500) NULL,
	[TechnicalSpecifications] [nvarchar](max) NULL,
	[InheritTableID] [varchar](50) NULL,
	[InheritAPK] [varchar](50) NULL,
	[InheritAPKDetail] [varchar](50) NULL,
	[DeleteFlag] [int] NULL,
	[IsSelectPrice] [int] NULL
	
 CONSTRAINT [PK_POT2022] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'Quantity')
    ALTER TABLE POT2022 ADD Quantity decimal(28) NULL
	
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'POT2022' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'APKMaster_9000')
    ALTER TABLE POT2022 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'ApproveLevel') 
	ALTER TABLE POT2022 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'ApprovingLevel') 
	ALTER TABLE POT2022 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'Status') 
	ALTER TABLE POT2022 ADD [Status] TINYINT NOT NULL DEFAULT(0)
END

-- Đức Tuyên on 28/11/2023: Bổ sung quy cách + đơn vị quy đổi.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POT2022' AND xtype = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S01ID') 
	ALTER TABLE POT2022 DROP COLUMN S01ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S02ID') 
	ALTER TABLE POT2022 DROP COLUMN S02ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S03ID') 
	ALTER TABLE POT2022 DROP COLUMN S03ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S04ID') 
	ALTER TABLE POT2022 DROP COLUMN S04ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S05ID') 
	ALTER TABLE POT2022 DROP COLUMN S05ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S06ID') 
	ALTER TABLE POT2022 DROP COLUMN S06ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S07ID') 
	ALTER TABLE POT2022 DROP COLUMN S07ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S08ID') 
	ALTER TABLE POT2022 DROP COLUMN S08ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S09ID') 
	ALTER TABLE POT2022 DROP COLUMN S09ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S10ID') 
	ALTER TABLE POT2022 DROP COLUMN S10ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S11ID') 
	ALTER TABLE POT2022 DROP COLUMN S11ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S12ID') 
	ALTER TABLE POT2022 DROP COLUMN S12ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S13ID') 
	ALTER TABLE POT2022 DROP COLUMN S13ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S14ID') 
	ALTER TABLE POT2022 DROP COLUMN S14ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S15ID') 
	ALTER TABLE POT2022 DROP COLUMN S15ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S16ID') 
	ALTER TABLE POT2022 DROP COLUMN S16ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S17ID') 
	ALTER TABLE POT2022 DROP COLUMN S17ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S18ID') 
	ALTER TABLE POT2022 DROP COLUMN S18ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S19ID') 
	ALTER TABLE POT2022 DROP COLUMN S19ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'S20ID') 
	ALTER TABLE POT2022 DROP COLUMN S20ID

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'UnitID')
		ALTER TABLE POT2022 ADD UnitID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'ConvertedUnitID')
		ALTER TABLE POT2022 ADD ConvertedUnitID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'ConvertedQuantity')
		ALTER TABLE POT2022 ADD ConvertedQuantity DECIMAL(28,8) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'ConvertedUnitPrice')
		ALTER TABLE POT2022 ADD ConvertedUnitPrice DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='POT2022' AND col.name='Parameter01')
		ALTER TABLE POT2022 ADD Parameter01 Decimal(28,8) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='POT2022' AND col.name='Parameter02')
		ALTER TABLE POT2022 ADD Parameter02 Decimal(28,8) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='POT2022' AND col.name='Parameter03')
		ALTER TABLE POT2022 ADD Parameter03 Decimal(28,8) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='POT2022' AND col.name='Parameter04')
		ALTER TABLE POT2022 ADD Parameter04 Decimal(28,8) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='POT2022' AND col.name='Parameter05')
		ALTER TABLE POT2022 ADD Parameter05 Decimal(28,8) NULL
		--- 26/12/2023 - Thanh Lượng: Bổ sung cột PONumber
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'POT2022' AND col.name = 'PONumber')
		ALTER TABLE POT2022 ADD PONumber NVARCHAR(50) NULL

END
