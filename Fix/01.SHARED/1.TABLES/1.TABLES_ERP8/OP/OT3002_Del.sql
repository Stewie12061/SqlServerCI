-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh Lâm
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on 18/08/2016 by Hải Long: Bổ sung các trường cho ABA
---- Modified on 10/12/2018 by Như Hàn: Bổ sung trường thông số kỹ thuật (AIC)
---- Modified on 21/02/2019 by Như Hàn: Bổ sung cột số cấp phải duyệt và số cấp đã duyệt, APKMaster (= OOT9000.APK), trạng thái
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT3002_Del]') AND type in (N'U'))
CREATE TABLE [dbo].[OT3002_Del](
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
	CONSTRAINT [PK_OT3002_Del] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'ShipDate')
           Alter Table  OT3002_Del Add ShipDate DateTime Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'ReceiveDate')
           Alter Table  OT3002_Del Add ReceiveDate DateTime Null
End 
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT3002_Del' AND xtype ='U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3002_Del' AND c.name = 'Parameter01')
    ALTER TABLE OT3002_Del ADD Parameter01 DECIMAL(28,8) NULL
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3002_Del' AND c.name = 'Parameter02')
    ALTER TABLE OT3002_Del ADD Parameter02 DECIMAL(28,8) NULL
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3002_Del' AND c.name = 'Parameter03')
    ALTER TABLE OT3002_Del ADD Parameter03 DECIMAL(28,8) NULL
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3002_Del' AND c.name = 'Parameter04')
    ALTER TABLE OT3002_Del ADD Parameter04 DECIMAL(28,8) NULL
    IF NOT EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects t 
    ON c.id = t.id WHERE t.name = 'OT3002_Del' AND c.name = 'Parameter05')
    ALTER TABLE OT3002_Del ADD Parameter05 DECIMAL(28,8) NULL
END
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'Notes03')
           Alter Table  OT3002_Del Add Notes03 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'Notes04')
           Alter Table  OT3002_Del Add Notes04 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'Notes05')
           Alter Table  OT3002_Del Add Notes05 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'Notes06')
           Alter Table  OT3002_Del Add Notes06 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'Notes07')
           Alter Table  OT3002_Del Add Notes07 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'Notes08')
           Alter Table  OT3002_Del Add Notes08 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'Notes09')
           Alter Table  OT3002_Del Add Notes09 nvarchar(250) Null
End 
---- StrParameter01-->StrParameter20
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter01')
           Alter Table  OT3002_Del Add StrParameter01 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter02')
           Alter Table  OT3002_Del Add StrParameter02 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter03')
           Alter Table  OT3002_Del Add StrParameter03 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter04')
           Alter Table  OT3002_Del Add StrParameter04 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter05')
           Alter Table  OT3002_Del Add StrParameter05 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter06')
           Alter Table  OT3002_Del Add StrParameter06 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter07')
           Alter Table  OT3002_Del Add StrParameter07 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter08')
           Alter Table  OT3002_Del Add StrParameter08 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter09')
           Alter Table  OT3002_Del Add StrParameter09 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter10')
           Alter Table  OT3002_Del Add StrParameter10 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter11')
           Alter Table  OT3002_Del Add StrParameter11 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter12')
           Alter Table  OT3002_Del Add StrParameter12 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter13')
           Alter Table  OT3002_Del Add StrParameter13 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter14')
           Alter Table  OT3002_Del Add StrParameter14 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter15')
           Alter Table  OT3002_Del Add StrParameter15 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter16')
           Alter Table  OT3002_Del Add StrParameter16 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter17')
           Alter Table  OT3002_Del Add StrParameter17 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter18')
           Alter Table  OT3002_Del Add StrParameter18 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter19')
           Alter Table  OT3002_Del Add StrParameter19 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'StrParameter20')
           Alter Table  OT3002_Del Add StrParameter20 nvarchar(250) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3002_Del' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'OT3002_Del'  and col.name = 'Ana06ID')
Alter Table  OT3002_Del Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End

---- Modified by Hải Long on 18/08/2016: Bổ sung các trường cho ABA
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT3002_Del' AND xtype='U')
	BEGIN
		--Bổ sung 20 cột nvarchar01 -> nvarchar20 cho ABA
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar01')
		ALTER TABLE OT3002_Del ADD nvarchar01 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar02')
		ALTER TABLE OT3002_Del ADD nvarchar02 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar03')
		ALTER TABLE OT3002_Del ADD nvarchar03 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar04')
		ALTER TABLE OT3002_Del ADD nvarchar04 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar05')
		ALTER TABLE OT3002_Del ADD nvarchar05 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar06')
		ALTER TABLE OT3002_Del ADD nvarchar06 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar07')
		ALTER TABLE OT3002_Del ADD nvarchar07 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar08')
		ALTER TABLE OT3002_Del ADD nvarchar08 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar09')
		ALTER TABLE OT3002_Del ADD nvarchar09 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar10')
		ALTER TABLE OT3002_Del ADD nvarchar10 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar11')
		ALTER TABLE OT3002_Del ADD nvarchar11 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar12')
		ALTER TABLE OT3002_Del ADD nvarchar12 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar13')
		ALTER TABLE OT3002_Del ADD nvarchar13 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar14')
		ALTER TABLE OT3002_Del ADD nvarchar14 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar15')
		ALTER TABLE OT3002_Del ADD nvarchar15 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar16')
		ALTER TABLE OT3002_Del ADD nvarchar16 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar17')
		ALTER TABLE OT3002_Del ADD nvarchar17 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar18')
		ALTER TABLE OT3002_Del ADD nvarchar18 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar19')
		ALTER TABLE OT3002_Del ADD nvarchar19 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT3002_Del' AND col.name='nvarchar20')
		ALTER TABLE OT3002_Del ADD nvarchar20 NVARCHAR(100) NULL
	END

--- Modified by Phuong Thao on 28/07/2017: Bo sung cac truong luu vet khi Ke thua DHSX de tao DH mua
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002_Del' AND xtype = 'U')
BEGIN  
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002_Del' AND col.name = 'InheritTableID') 
   ALTER TABLE OT3002_Del ADD InheritTableID NVARCHAR(50) NULL 
END

/*===============================================END InheritTableID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002_Del' AND col.name = 'InheritVoucherID') 
   ALTER TABLE OT3002_Del ADD InheritVoucherID NVARCHAR(50) NULL 
END

/*===============================================END InheritVoucherID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002_Del' AND col.name = 'InheritTransactionID') 
   ALTER TABLE OT3002_Del ADD InheritTransactionID NVARCHAR(50) NULL 
END

/*===============================================END InheritTransactionID===============================================*/ 


--- Bổ sung trường thông số kỹ thuật (AIC)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002_Del' AND col.name = 'Specification') 
   ALTER TABLE OT3002_Del ADD Specification NVARCHAR(Max) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002_Del' AND xtype = 'U')
BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002_Del' AND col.name = 'ApproveLevel') 
			ALTER TABLE OT3002_Del ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002_Del' AND col.name = 'ApprovingLevel') 
			ALTER TABLE OT3002_Del ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002_Del' AND col.name = 'APKMaster') 
			ALTER TABLE OT3002_Del DROP COLUMN APKMaster 

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002_Del' AND col.name = 'APKMaster_9000') 
			ALTER TABLE OT3002_Del ADD APKMaster_9000 UNIQUEIDENTIFIER NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT3002_Del' AND col.name = 'Status') 
			ALTER TABLE OT3002_Del ADD Status TINYINT NOT NULL DEFAULT(0)
END
--- Modify by Trà Giang on 10/03/2020: Bổ sung trường: số đơn hàng mua, hiệu, quy cách cái/ thùng cho KH Tân Hòa Lợi ( Customer = 122) 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3002_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3002_Del' AND col.name = 'RefPOrderID ') 
   ALTER TABLE OT3002_Del ADD RefPOrderID  NVARCHAR(50) NULL 
END
ALTER TABLE OT3002_Del DROP COLUMN RefPOrderID;