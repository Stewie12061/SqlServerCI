-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh Lâm
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on 14/03/2017 by Bảo Anh: Bổ sung các trường kế thừa InheritTableID, InheritVoucherID, InheritTransactionID
---- Modified on 20/11/2017 by Hồng Thảo: Bổ sung trường số lượng tồn kho hiện tại StockCurrent ( CustomerIndex=32 )
---- Modified on 06/12/2018 by Như Hàn: Bổ sung VATGroupID
---- Modified on 21/02/2019 by Như Hàn: Bổ sung cột số cấp phải duyệt và số cấp đã duyệt, APKMaster (= OOT9000.APK), trạng thái
---- Modified on 10/06/2019 by Như Hàn: Customize VNF(107) Bổ sung cột số lượng tồn kho của mặt hàng 
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT3102]') AND type in (N'U'))
CREATE TABLE [dbo].[OT3102](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[ROrderID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[RequestPrice] [decimal](28, 8) NULL,
	[OrderQuantity] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[VATPercent] [decimal](28, 8) NULL,
	[VATConvertedAmount] [decimal](28, 8) NULL,
	[DiscountPercent] [decimal](28, 8) NULL,
	[DiscountConvertedAmount] [decimal](28, 8) NULL,
	[DiscountOriginalAmount] [decimal](28, 8) NULL,
	[VATOriginalAmount] [decimal](28, 8) NULL,
	[Orders] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[AdjustQuantity] [decimal](28, 8) NULL,
	[InventoryCommonName] [nvarchar](250) NULL,
	[UnitID] [nvarchar](50) NULL,
	[Finish] [tinyint] NULL,
	[Notes] [nvarchar](250) NULL,
	[Notes01] [nvarchar](250) NULL,
	[Notes02] [nvarchar](250) NULL,
	[PriceList] [decimal](28, 8) NULL,
	[ConvertedQuantity] [decimal](28, 8) NULL,
	[ConvertedSalePrice] [decimal](28, 8) NULL,
	[RefTransactionID] [nvarchar](50) NULL,
	CONSTRAINT [PK_OT3102] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT3102' AND xtype ='U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3102' AND c.name = 'Parameter01')
    ALTER TABLE OT3102 ADD Parameter01 DECIMAL(28,8) NULL
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3102' AND c.name = 'Parameter02')
    ALTER TABLE OT3102 ADD Parameter02 DECIMAL(28,8) NULL
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3102' AND c.name = 'Parameter03')
    ALTER TABLE OT3102 ADD Parameter03 DECIMAL(28,8) NULL
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3102' AND c.name = 'Parameter04')
    ALTER TABLE OT3102 ADD Parameter04 DECIMAL(28,8) NULL
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3102' AND c.name = 'Parameter05')
    ALTER TABLE OT3102 ADD Parameter05 DECIMAL(28,8) NULL
End
If Exists (Select * From sysobjects Where name = 'OT3102' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'OT3102'  and col.name = 'Ana06ID')
Alter Table  OT3102 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT3102' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'InheritTableID')
    ALTER TABLE OT3102 ADD InheritTableID NVARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'InheritVoucherID')
    ALTER TABLE OT3102 ADD InheritVoucherID NVARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'InheritTransactionID')
    ALTER TABLE OT3102 ADD InheritTransactionID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT3102' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'VATGroupID')
    ALTER TABLE OT3102 ADD VATGroupID NVARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'DeleteFlag')
    ALTER TABLE OT3102 ADD DeleteFlag TINYINT DEFAULT 0
END

---- Modified on 21/02/2019 by Như Hàn: Bổ sung cột số cấp phải duyệt và số cấp đã duyệt, APKMaster (= OOT9000.APK)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'ApproveLevel') 
			ALTER TABLE OT3102 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'ApprovingLevel') 
			ALTER TABLE OT3102 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'APKMaster') 
			ALTER TABLE OT3102 DROP COLUMN APKMaster

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'APKMaster_9000') 
			ALTER TABLE OT3102 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'Status') 
			ALTER TABLE OT3102 ADD Status TINYINT NOT NULL DEFAULT(0)
END

---- Modified on 10/06/2019 by Như Hàn: Customize VNF(107) Bổ sung cột số lượng tồn kho của mặt hàng 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'StockCurrent') 
			ALTER TABLE OT3102 ADD StockCurrent DECIMAL(28, 8) NULL
END

---- Modified on 09/12/2019 by Kiều Nga: Bổ sung trường thông số kỹ thuật
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'Specification') 
   ALTER TABLE OT3102 ADD Specification NVARCHAR(Max) NULL 
END

---- Modified on 09/12/2019 by Kiều Nga: Customize MTH(117) Bổ sung MPT mặt hàng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'I01ID') 
   ALTER TABLE OT3102 ADD I01ID NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'I02ID') 
   ALTER TABLE OT3102 ADD I02ID NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'I03ID') 
   ALTER TABLE OT3102 ADD I03ID NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'I04ID') 
   ALTER TABLE OT3102 ADD I04ID NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'I05ID') 
   ALTER TABLE OT3102 ADD I05ID NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'I06ID') 
   ALTER TABLE OT3102 ADD I06ID NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'I07ID') 
   ALTER TABLE OT3102 ADD I07ID NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'I08ID') 
   ALTER TABLE OT3102 ADD I08ID NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'I09ID') 
   ALTER TABLE OT3102 ADD I09ID NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'I10ID') 
   ALTER TABLE OT3102 ADD I10ID NVARCHAR(50) NULL 
END

-- Phương Thảo bổ sung 21/06/2023
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'ConversionFactor') 
   ALTER TABLE OT3102 ADD ConversionFactor DECIMAL(28,8) NULL
END
-- Hoàng Long bổ sung 13/09/2023
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'PONumber') 
   ALTER TABLE OT3102 ADD PONumber NVARCHAR(50) NULL
END

-- Đức Tuyên on 28/11/2023: Bổ sung quy cách + đơn vị quy đổi.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3102' AND xtype = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S01ID') 
	ALTER TABLE OT3102 DROP COLUMN S01ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S02ID') 
	ALTER TABLE OT3102 DROP COLUMN S02ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S03ID') 
	ALTER TABLE OT3102 DROP COLUMN S03ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S04ID') 
	ALTER TABLE OT3102 DROP COLUMN S04ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S05ID') 
	ALTER TABLE OT3102 DROP COLUMN S05ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S06ID') 
	ALTER TABLE OT3102 DROP COLUMN S06ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S07ID') 
	ALTER TABLE OT3102 DROP COLUMN S07ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S08ID') 
	ALTER TABLE OT3102 DROP COLUMN S08ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S09ID') 
	ALTER TABLE OT3102 DROP COLUMN S09ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S10ID') 
	ALTER TABLE OT3102 DROP COLUMN S10ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S11ID') 
	ALTER TABLE OT3102 DROP COLUMN S11ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S12ID') 
	ALTER TABLE OT3102 DROP COLUMN S12ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S13ID') 
	ALTER TABLE OT3102 DROP COLUMN S13ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S14ID') 
	ALTER TABLE OT3102 DROP COLUMN S14ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S15ID') 
	ALTER TABLE OT3102 DROP COLUMN S15ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S16ID') 
	ALTER TABLE OT3102 DROP COLUMN S16ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S17ID') 
	ALTER TABLE OT3102 DROP COLUMN S17ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S18ID') 
	ALTER TABLE OT3102 DROP COLUMN S18ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S19ID') 
	ALTER TABLE OT3102 DROP COLUMN S19ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'S20ID') 
	ALTER TABLE OT3102 DROP COLUMN S20ID

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'OT3102' AND col.name = 'ConvertedUnitID')
		ALTER TABLE OT3102 ADD ConvertedUnitID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='OT3102' AND col.name='Parameter01')
		ALTER TABLE OT3102 ADD Parameter01 Decimal(28,8) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='OT3102' AND col.name='Parameter02')
		ALTER TABLE OT3102 ADD Parameter02 Decimal(28,8) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='OT3102' AND col.name='Parameter03')
		ALTER TABLE OT3102 ADD Parameter03 Decimal(28,8) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='OT3102' AND col.name='Parameter04')
		ALTER TABLE OT3102 ADD Parameter04 Decimal(28,8) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='OT3102' AND col.name='Parameter05')
		ALTER TABLE OT3102 ADD Parameter05 Decimal(28,8) NULL
END
