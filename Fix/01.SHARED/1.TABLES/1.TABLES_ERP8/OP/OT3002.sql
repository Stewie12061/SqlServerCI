-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh Lâm
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on 18/08/2016 by Hải Long: Bổ sung các trường cho ABA
---- Modified on 10/12/2018 by Như Hàn: Bổ sung trường thông số kỹ thuật (AIC)
---- Modified on 21/02/2019 by Như Hàn: Bổ sung cột số cấp phải duyệt và số cấp đã duyệt, APKMaster (= OOT9000.APK), trạng thái
---- Modified on 18/06/2019 by Kim Thư: Bổ sung các trường RequestQuantity và RequestConvertedQuantity - lưu số lượng từ yêu cầu mua hàng
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT3002]') AND type in (N'U'))
CREATE TABLE [dbo].[OT3002](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[POrderID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[MethodID] [nvarchar](50) NULL,
	[OrderQuantity] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[PurchasePrice] [decimal](28, 8) NULL,
	[VATPercent] [decimal](28, 8) NULL,
	[VATConvertedAmount] [decimal](28, 8) NULL,
	[DiscountPercent] [decimal](28, 8) NULL,
	[DiscountConvertedAmount] [decimal](28, 8) NULL,
	[IsPicking] [tinyint] NOT NULL,
	[Quantity01] [decimal](28, 8) NULL,
	[Quantity02] [decimal](28, 8) NULL,
	[Quantity03] [decimal](28, 8) NULL,
	[Quantity04] [decimal](28, 8) NULL,
	[Quantity05] [decimal](28, 8) NULL,
	[Quantity06] [decimal](28, 8) NULL,
	[Quantity07] [decimal](28, 8) NULL,
	[Quantity08] [decimal](28, 8) NULL,
	[Quantity09] [decimal](28, 8) NULL,
	[Quantity10] [decimal](28, 8) NULL,
	[Quantity11] [decimal](28, 8) NULL,
	[Quantity12] [decimal](28, 8) NULL,
	[Quantity13] [decimal](28, 8) NULL,
	[Quantity14] [decimal](28, 8) NULL,
	[Quantity15] [decimal](28, 8) NULL,
	[Quantity16] [decimal](28, 8) NULL,
	[Quantity17] [decimal](28, 8) NULL,
	[Quantity18] [decimal](28, 8) NULL,
	[Quantity19] [decimal](28, 8) NULL,
	[Quantity20] [decimal](28, 8) NULL,
	[Quantity21] [decimal](28, 8) NULL,
	[Quantity22] [decimal](28, 8) NULL,
	[Quantity23] [decimal](28, 8) NULL,
	[Quantity24] [decimal](28, 8) NULL,
	[Quantity25] [decimal](28, 8) NULL,
	[Quantity26] [decimal](28, 8) NULL,
	[Quantity27] [decimal](28, 8) NULL,
	[Quantity28] [decimal](28, 8) NULL,
	[Quantity29] [decimal](28, 8) NULL,
	[Quantity30] [decimal](28, 8) NULL,
	[WareHouseID] [nvarchar](50) NULL,
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
	[RefTransactionID] [nvarchar](50) NULL,
	[ROrderID] [nvarchar](50) NULL,
	[ConvertedQuantity] [decimal](28, 8) NULL,
	[ImTaxPercent] [decimal](28, 8) NULL,
	[ImTaxOriginalAmount] [decimal](28, 8) NULL,
	[ImTaxConvertedAmount] [decimal](28, 8) NULL,
	[ConvertedSalePrice] [decimal](28, 8) NULL,
	[BillOfLadingNo] NVARCHAR(50) NULL,
	[ShipDate] datetime,
	[ContQuantity] INT NULL,
	[CostTowing] INT NULL,
	[CostOriginalAmount] INT NULL,
	[CostConvertedAmount] INT NULL,
	[DescriptionCost] NVARCHAR(max) NULL,
	[ImportAndExportDuties] INT NULL,
	[IExportDutiesConvertedAmount] INT NULL,
	[SafeguardingDuties] INT NULL,
	[SafeguardingDutiesConvertedAmount] INT NULL,
	[DifferentDuties] INT NULL,
	[DifferentDutiesConvertedAmount] INT NULL,
	[SumDuties] INT NULL,
	[ProductPrice] [decimal](28, 8) NULL
	CONSTRAINT [PK_OT3002] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'ShipDate')
           Alter Table  OT3002 Add ShipDate DateTime Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'ReceiveDate')
           Alter Table  OT3002 Add ReceiveDate DateTime Null
End 
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT3002' AND xtype ='U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3002' AND c.name = 'Parameter01')
    ALTER TABLE OT3002 ADD Parameter01 DECIMAL(28,8) NULL
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3002' AND c.name = 'Parameter02')
    ALTER TABLE OT3002 ADD Parameter02 DECIMAL(28,8) NULL
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3002' AND c.name = 'Parameter03')
    ALTER TABLE OT3002 ADD Parameter03 DECIMAL(28,8) NULL
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3002' AND c.name = 'Parameter04')
    ALTER TABLE OT3002 ADD Parameter04 DECIMAL(28,8) NULL
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3002' AND c.name = 'Parameter05')
    ALTER TABLE OT3002 ADD Parameter05 DECIMAL(28,8) NULL
END
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'Notes03')
           Alter Table  OT3002 Add Notes03 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'Notes04')
           Alter Table  OT3002 Add Notes04 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'Notes05')
           Alter Table  OT3002 Add Notes05 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'Notes06')
           Alter Table  OT3002 Add Notes06 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'Notes07')
           Alter Table  OT3002 Add Notes07 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'Notes08')
           Alter Table  OT3002 Add Notes08 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'Notes09')
           Alter Table  OT3002 Add Notes09 nvarchar(250) Null
End 
---- StrParameter01-->StrParameter20
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter01')
           Alter Table  OT3002 Add StrParameter01 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter02')
           Alter Table  OT3002 Add StrParameter02 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter03')
           Alter Table  OT3002 Add StrParameter03 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter04')
           Alter Table  OT3002 Add StrParameter04 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter05')
           Alter Table  OT3002 Add StrParameter05 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter06')
           Alter Table  OT3002 Add StrParameter06 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter07')
           Alter Table  OT3002 Add StrParameter07 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter08')
           Alter Table  OT3002 Add StrParameter08 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter09')
           Alter Table  OT3002 Add StrParameter09 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter10')
           Alter Table  OT3002 Add StrParameter10 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter11')
           Alter Table  OT3002 Add StrParameter11 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter12')
           Alter Table  OT3002 Add StrParameter12 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter13')
           Alter Table  OT3002 Add StrParameter13 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter14')
           Alter Table  OT3002 Add StrParameter14 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter15')
           Alter Table  OT3002 Add StrParameter15 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter16')
           Alter Table  OT3002 Add StrParameter16 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter17')
           Alter Table  OT3002 Add StrParameter17 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter18')
           Alter Table  OT3002 Add StrParameter18 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter19')
           Alter Table  OT3002 Add StrParameter19 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'StrParameter20')
           Alter Table  OT3002 Add StrParameter20 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'OT3002'  and col.name = 'Ana06ID')
Alter Table  OT3002 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End

---- Modified by Hải Long on 18/08/2016: Bổ sung các trường cho ABA
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT3002' AND xtype='U')
	BEGIN
		--Bổ sung 20 cột nvarchar01 -> nvarchar20 cho ABA
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar01')
		ALTER TABLE OT3002 ADD nvarchar01 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar02')
		ALTER TABLE OT3002 ADD nvarchar02 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar03')
		ALTER TABLE OT3002 ADD nvarchar03 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar04')
		ALTER TABLE OT3002 ADD nvarchar04 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar05')
		ALTER TABLE OT3002 ADD nvarchar05 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar06')
		ALTER TABLE OT3002 ADD nvarchar06 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar07')
		ALTER TABLE OT3002 ADD nvarchar07 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar08')
		ALTER TABLE OT3002 ADD nvarchar08 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar09')
		ALTER TABLE OT3002 ADD nvarchar09 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar10')
		ALTER TABLE OT3002 ADD nvarchar10 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar11')
		ALTER TABLE OT3002 ADD nvarchar11 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar12')
		ALTER TABLE OT3002 ADD nvarchar12 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar13')
		ALTER TABLE OT3002 ADD nvarchar13 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar14')
		ALTER TABLE OT3002 ADD nvarchar14 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar15')
		ALTER TABLE OT3002 ADD nvarchar15 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar16')
		ALTER TABLE OT3002 ADD nvarchar16 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar17')
		ALTER TABLE OT3002 ADD nvarchar17 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar18')
		ALTER TABLE OT3002 ADD nvarchar18 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar19')
		ALTER TABLE OT3002 ADD nvarchar19 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='nvarchar20')
		ALTER TABLE OT3002 ADD nvarchar20 NVARCHAR(100) NULL
	END

--- Modified by Phuong Thao on 28/07/2017: Bo sung cac truong luu vet khi Ke thua DHSX de tao DH mua
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN  
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'InheritTableID') 
   ALTER TABLE OT3002 ADD InheritTableID NVARCHAR(50) NULL 
END

/*===============================================END InheritTableID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'InheritVoucherID') 
   ALTER TABLE OT3002 ADD InheritVoucherID NVARCHAR(50) NULL 
END

/*===============================================END InheritVoucherID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'InheritTransactionID') 
   ALTER TABLE OT3002 ADD InheritTransactionID NVARCHAR(50) NULL 
END

/*===============================================END InheritTransactionID===============================================*/ 


--- Bổ sung trường thông số kỹ thuật (AIC)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'Specification') 
   ALTER TABLE OT3002 ADD Specification NVARCHAR(Max) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'ApproveLevel') 
			ALTER TABLE OT3002 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'ApprovingLevel') 
			ALTER TABLE OT3002 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'APKMaster') 
			ALTER TABLE OT3002 DROP COLUMN APKMaster 

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'APKMaster_9000') 
			ALTER TABLE OT3002 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'Status') 
			ALTER TABLE OT3002 ADD Status TINYINT NOT NULL DEFAULT(0)
END

--- Modify by Trà Giang on 10/03/2020: Bổ sung trường: số đơn hàng mua, hiệu, quy cách cái/ thùng cho KH Tân Hòa Lợi ( Customer = 122) 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'RefPOrderID ') 
   ALTER TABLE OT3002 ADD RefPOrderID  NVARCHAR(50) NULL 
END
ALTER TABLE OT3002 DROP COLUMN RefPOrderID;

---- Modified on 18/06/2019 by Kim Thư: Bổ sung các trường RequestQuantity và RequestConvertedQuantity - lưu số lượng từ yêu cầu mua hàng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'RequestQuantity') 
   ALTER TABLE OT3002 ADD RequestQuantity DECIMAL(28,8) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'RequestConvertedQuantity') 
   ALTER TABLE OT3002 ADD RequestConvertedQuantity DECIMAL(28,8) NULL
END

---- Modified on 28/08/2020 by Huỳnh Thử: Bổ sung trường IsProInventoryID Hàng khuyến mãi
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'IsProInventoryID') 
   ALTER TABLE OT3002 ADD IsProInventoryID TINYINT NOT NULL DEFAULT(0)
   
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'CostOriginalAmount') 
   ALTER TABLE OT3002 ADD CostOriginalAmount DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'CostConvertedAmount') 
   ALTER TABLE OT3002 ADD CostConvertedAmount DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'DescriptionCost') 
   ALTER TABLE OT3002 ADD DescriptionCost  NVARCHAR(MAX) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'ImportAndExportDuties') 
   ALTER TABLE OT3002 ADD ImportAndExportDuties DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'IExportDutiesConvertedAmount') 
   ALTER TABLE OT3002 ADD IExportDutiesConvertedAmount DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'SafeguardingDuties') 
   ALTER TABLE OT3002 ADD SafeguardingDuties DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'SafeguardingDutiesConvertedAmount') 
   ALTER TABLE OT3002 ADD SafeguardingDutiesConvertedAmount DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'DifferentDuties') 
   ALTER TABLE OT3002 ADD DifferentDuties DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'DifferentDutiesConvertedAmount') 
   ALTER TABLE OT3002 ADD DifferentDutiesConvertedAmount DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'SumDuties') 
   ALTER TABLE OT3002 ADD SumDuties DECIMAL(28,8) NULL


END

---- Modified on 22/02/2022 by Minh Hiếu: Bổ sung trường
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'BillOfLadingNo') 
   ALTER TABLE OT3002 ADD BillOfLadingNo NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'ShipDate') 
   ALTER TABLE OT3002 ADD ShipDate DateTime
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'ContQuantity') 
   ALTER TABLE OT3002 ADD ContQuantity  DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'CostTowing') 
   ALTER TABLE OT3002 ADD CostTowing DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'CostOriginalAmount') 
   ALTER TABLE OT3002 ADD CostOriginalAmount DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'CostConvertedAmount') 
   ALTER TABLE OT3002 ADD CostConvertedAmount DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'DescriptionCost') 
   ALTER TABLE OT3002 ADD DescriptionCost NVARCHAR(MAX) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'ImportAndExportDuties') 
   ALTER TABLE OT3002 ADD ImportAndExportDuties DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'IExportDutiesConvertedAmount') 
   ALTER TABLE OT3002 ADD IExportDutiesConvertedAmount DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'SafeguardingDuties') 
   ALTER TABLE OT3002 ADD SafeguardingDuties DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'SafeguardingDutiesConvertedAmount') 
   ALTER TABLE OT3002 ADD SafeguardingDutiesConvertedAmount DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'DifferentDuties') 
   ALTER TABLE OT3002 ADD DifferentDuties DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'DifferentDutiesConvertedAmount') 
   ALTER TABLE OT3002 ADD DifferentDutiesConvertedAmount DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'SumDuties') 
   ALTER TABLE OT3002 ADD SumDuties DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'ProductPrice') 
   ALTER TABLE OT3002 ADD ProductPrice DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'SourceNo') 
   ALTER TABLE OT3002 ADD SourceNo NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'ReceivedDate') 
   ALTER TABLE OT3002 ADD ReceivedDate DATETIME NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'IsDuplicate') 
   ALTER TABLE OT3002 ADD IsDuplicate NVARCHAR(10) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'IsUpdate') 
   ALTER TABLE OT3002 ADD IsUpdate NVARCHAR(10) NULL
END

-- Phương Thảo bổ sung 21/06/2023
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'ConversionFactor') 
   ALTER TABLE OT3002 ADD ConversionFactor DECIMAL(28,8) NULL
END

 -- Đức Tuyên Update on 17/08/2023 Bổ sung lưu mã phân tích mặt hàng theo thiết lập động
IF ((select CustomerName From CustomerIndex) = 161) -- Khách hàng INNOTEK
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
	BEGIN 
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'I01ID') 
		ALTER TABLE OT3002 ADD I01ID [nvarchar](50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'I02ID') 
		ALTER TABLE OT3002 ADD I02ID [nvarchar](50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'I03ID') 
		ALTER TABLE OT3002 ADD I03ID [nvarchar](50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'I04ID') 
		ALTER TABLE OT3002 ADD I04ID [nvarchar](50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'I05ID') 
		ALTER TABLE OT3002 ADD I05ID [nvarchar](50) NULL
		
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'I06ID') 
		ALTER TABLE OT3002 ADD I06ID [nvarchar](50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'I07ID') 
		ALTER TABLE OT3002 ADD I07ID [nvarchar](50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'I08ID') 
		ALTER TABLE OT3002 ADD I08ID [nvarchar](50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'I09ID') 
		ALTER TABLE OT3002 ADD I09ID [nvarchar](50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'I10ID') 
		ALTER TABLE OT3002 ADD I10ID [nvarchar](50) NULL
	END
END

-- Hoàng Long bổ sung 13/09/2023
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'PONumber') 
   ALTER TABLE OT3002 ADD PONumber [nvarchar](50) NULL
END

-- Đình Định update on 20/09/2023: BBL - Bổ sung cột WareHouseFee.
IF ((SELECT CustomerName From CustomerIndex WITH (NOLOCK)) = 38)
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
	BEGIN 
	 IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	 ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'WareHouseFee') 
	 ALTER TABLE OT3002 ADD WareHouseFee DECIMAL(28,8) NULL
	END
END

-- Đức Tuyên on 28/11/2023: Bổ sung quy cách + đơn vị quy đổi.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S01ID') 
	ALTER TABLE OT3002 DROP COLUMN S01ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S02ID') 
	ALTER TABLE OT3002 DROP COLUMN S02ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S03ID') 
	ALTER TABLE OT3002 DROP COLUMN S03ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S04ID') 
	ALTER TABLE OT3002 DROP COLUMN S04ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S05ID') 
	ALTER TABLE OT3002 DROP COLUMN S05ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S06ID') 
	ALTER TABLE OT3002 DROP COLUMN S06ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S07ID') 
	ALTER TABLE OT3002 DROP COLUMN S07ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S08ID') 
	ALTER TABLE OT3002 DROP COLUMN S08ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S09ID') 
	ALTER TABLE OT3002 DROP COLUMN S09ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S10ID') 
	ALTER TABLE OT3002 DROP COLUMN S10ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S11ID') 
	ALTER TABLE OT3002 DROP COLUMN S11ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S12ID') 
	ALTER TABLE OT3002 DROP COLUMN S12ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S13ID') 
	ALTER TABLE OT3002 DROP COLUMN S13ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S14ID') 
	ALTER TABLE OT3002 DROP COLUMN S14ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S15ID') 
	ALTER TABLE OT3002 DROP COLUMN S15ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S16ID') 
	ALTER TABLE OT3002 DROP COLUMN S16ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S17ID') 
	ALTER TABLE OT3002 DROP COLUMN S17ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S18ID') 
	ALTER TABLE OT3002 DROP COLUMN S18ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S19ID') 
	ALTER TABLE OT3002 DROP COLUMN S19ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'S20ID') 
	ALTER TABLE OT3002 DROP COLUMN S20ID

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'ConvertedUnitID')
		ALTER TABLE OT3002 ADD ConvertedUnitID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'ConvertedQuantity')
		ALTER TABLE OT3002 ADD ConvertedQuantity DECIMAL(28,8) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'ConvertedUnitPrice')
		ALTER TABLE OT3002 ADD ConvertedUnitPrice DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='Parameter01')
		ALTER TABLE OT3002 ADD Parameter01 Decimal(28,8) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='Parameter02')
		ALTER TABLE OT3002 ADD Parameter02 Decimal(28,8) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='Parameter03')
		ALTER TABLE OT3002 ADD Parameter03 Decimal(28,8) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='Parameter04')
		ALTER TABLE OT3002 ADD Parameter04 Decimal(28,8) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id=tab.id WHERE tab.name='OT3002' AND col.name='Parameter05')
		ALTER TABLE OT3002 ADD Parameter05 Decimal(28,8) NULL
END

-- Xuân Nguyên update on 02/01/2024: BBL - Bổ sung cột OrderID.
IF ((SELECT CustomerName From CustomerIndex WITH (NOLOCK)) = 38)
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002' AND xtype = 'U')
	BEGIN 
	 IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	 ON col.id = tab.id WHERE tab.name = 'OT3002' AND col.name = 'OrderID') 
	 ALTER TABLE OT3002 ADD OrderID [nvarchar](50) NULL
	END
END