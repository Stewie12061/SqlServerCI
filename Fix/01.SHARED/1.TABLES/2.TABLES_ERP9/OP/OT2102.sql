-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Cam Loan
---- Modified by Le Thi Thu Hien on 13/12/2011
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on 31/08/2015 by Tiểu Mai: Bổ sung cột Số lượng (cửa) QuoQuantity01 và 5 tham số Parameter
---- Modified on 05/08/2021 by Nhựt Trường: Bổ sung cột loại tiền và tỷ giá.
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT2102]') AND type in (N'U'))
CREATE TABLE [dbo].[OT2102](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[QuotationID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[QuoQuantity] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[Notes] [nvarchar](250) NULL,
	[VATPercent] [decimal](28, 8) NULL,
	[VATConvertedAmount] [decimal](28, 8) NULL,
	[VATOriginalAmount] [decimal](28, 8) NULL,
	[UnitID] [nvarchar](50) NULL,
	[Orders] [int] NULL,
	[DiscountPercent] [decimal](28, 8) NULL,
	[DiscountOriginalAmount] [decimal](28, 8) NULL,
	[DiscountConvertedAmount] [decimal](28, 8) NULL,
	[InventoryCommonName] [nvarchar](250) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Notes01] [nvarchar](250) NULL,
	[Notes02] [nvarchar](250) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[VATGroupID] [nvarchar](50) NULL,
	[finish] [tinyint] NULL,
	[ConvertedQuantity] [decimal](28, 8) NULL,
	[ConvertedSalePrice] [decimal](28, 8) NULL,
 CONSTRAINT [PK_OT2102] PRIMARY KEY NONCLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'Parameter01')
           Alter Table  OT2102 Add Parameter01 decimal(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'Parameter02')
           Alter Table  OT2102 Add Parameter02 decimal(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'Parameter03')
           Alter Table  OT2102 Add Parameter03 decimal(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'Parameter04')
           Alter Table  OT2102 Add Parameter04 decimal(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'Parameter05')
           Alter Table  OT2102 Add Parameter05 decimal(28,8) NULL
END
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'ConvertedSalepriceInput')
           Alter Table  OT2102 Add ConvertedSalepriceInput decimal(28,8) Null
End
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'ReceiveDate')
           Alter Table  OT2102 Add ReceiveDate DateTime Null
End 
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'Barcode')
           Alter Table  OT2102 Add Barcode nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'Markup')
           Alter Table  OT2102 Add Markup DECIMAL(28,8) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'OriginalAmountOutput')
           Alter Table  OT2102 Add OriginalAmountOutput decimal(28,8) Null
END
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'Ana06ID')
Alter Table  OT2102 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
END
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QuoQuantity01')
           Alter Table  OT2102 Add QuoQuantity01 decimal(28,8) Null
End
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
BEGIN
			
			If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD01')
           Alter Table  OT2102 Add QD01 decimal(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD02')
           Alter Table  OT2102 Add QD02 decimal(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD03')
           Alter Table  OT2102 Add QD03 decimal(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD04')
           Alter Table  OT2102 Add QD04 decimal(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD05')
           Alter Table  OT2102 Add QD05 decimal(28,8) NULL			
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD06')
           Alter Table  OT2102 Add QD06 decimal(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD07')
           Alter Table  OT2102 Add QD07 decimal(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD08')
           Alter Table  OT2102 Add QD08 decimal(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD09')
           Alter Table  OT2102 Add QD09 decimal(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD10')
           Alter Table  OT2102 Add QD10 decimal(28,8) NULL  
END
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
BEGIN
			
			If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD01')
           Alter Table  OT2102 ALTER COLUMN QD01 NVARCHAR(250)           
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD02')
           Alter Table  OT2102 ALTER COLUMN QD02 NVARCHAR(250)          
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD03')
           Alter Table  OT2102 ALTER COLUMN QD03 NVARCHAR(250)           
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD04')
           Alter Table  OT2102 ALTER COLUMN QD04 NVARCHAR(250)           
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD05')
           Alter Table  OT2102 ALTER COLUMN QD05 NVARCHAR(250)			
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD06')
           Alter Table  OT2102 ALTER COLUMN QD06 NVARCHAR(250)           
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD07')
           Alter Table  OT2102 ALTER COLUMN QD07 NVARCHAR(250)           
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD08')
           Alter Table  OT2102 ALTER COLUMN QD08 NVARCHAR(250)           
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD09')
           Alter Table  OT2102 ALTER COLUMN QD09 NVARCHAR(250)           
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'QD10')
           Alter Table  OT2102 ALTER COLUMN QD10 NVARCHAR(250)  
END

----Modified by Tấn Phú on 04/07/2019: bổ sung Lập báo giá kế thừa từ yêu cầu mua hàng (Đức Tin)
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
BEGIN
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name ='OT2102'  and col.name = 'RequestPrice')
    Alter Table  OT2102 Add RequestPrice decimal(28,8) Null
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2102' AND xtype = 'U')
BEGIN  
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'InheritTableID') 
   ALTER TABLE OT2102 ADD InheritTableID NVARCHAR(50) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'InheritVoucherID') 
   ALTER TABLE OT2102 ADD InheritVoucherID NVARCHAR(50) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'InheritTransactionID') 
   ALTER TABLE OT2102 ADD InheritTransactionID NVARCHAR(50) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2102' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'InheritTransactionID') 
   ALTER TABLE OT2102 ADD InheritTransactionID NVARCHAR(50) NULL 
END
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2102' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'APKMaster_9000')
    ALTER TABLE OT2102 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'ApproveLevel') 
	ALTER TABLE OT2102 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'ApprovingLevel') 
	ALTER TABLE OT2102 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'Status') 
	ALTER TABLE OT2102 ADD [Status] TINYINT NOT NULL DEFAULT(0)
END

----Modified by Kiều Nga on 27/09/2019: bổ sung hệ số (Đức Tin)
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'Coefficient') 
ALTER TABLE OT2102 ADD [Coefficient] decimal(28,8) Null
END

----Modified by Kiều Nga on 26/10/2019: bổ sung hệ số (Đức Tín)
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'Specification') 
ALTER TABLE OT2102 ADD [Specification] NVARCHAR(MAX) NULL
END

----Modified by Nhựt Trường on 05/08/2021: Bổ sung cột loại tiền
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'CurrencyID') 
ALTER TABLE OT2102 ADD [CurrencyID] NVARCHAR(50) NULL
END

----Modified by Nhựt Trường on 05/08/2021: Bổ sung cột tỷ giá
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'ExchangeRate') 
ALTER TABLE OT2102 ADD [ExchangeRate] decimal(28,8) Null
END

----Modified by Kiều Nga on 25/11/2021: Bổ sung cột InventoryGroupAnaTypeID
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'InventoryGroupAnaTypeID') 
ALTER TABLE OT2102 ADD [InventoryGroupAnaTypeID] NVARCHAR(50) NULL
END

----Modified by Kiều Nga on 12/01/2022: thay đổi kiểu dữ liệu Notes,Notes01,Notes02 sang NVARCHAR(MAX)
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
Begin
IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'Notes') 
ALTER TABLE OT2102 ALTER COLUMN Notes NVARCHAR(MAX) NULL

IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'Notes01') 
ALTER TABLE OT2102 ALTER COLUMN Notes01 NVARCHAR(MAX) NULL

IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'Notes01') 
ALTER TABLE OT2102 ALTER COLUMN Notes02 NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'IsProInventoryID')
ALTER TABLE OT2102 ADD IsProInventoryID tinyint NULL

----Modified by Viết Toàn on 30/11/2023: Bổ sung 20 cột quy cách
If Exists (Select * From sysobjects Where name = 'OT2102' and xtype ='U') 
BEGIN
			
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S01ID')
			Alter Table  OT2102 ADD S01ID NVARCHAR(250)           
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S02ID')
			Alter Table  OT2102 ADD S02ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S03ID')
			Alter Table  OT2102 ADD S03ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S04ID')
			Alter Table  OT2102 ADD S04ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S05ID')
			Alter Table  OT2102 ADD S05ID NVARCHAR(250)			   
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S06ID')
			Alter Table  OT2102 ADD S06ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S07ID')
			Alter Table  OT2102 ADD S07ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S08ID')
			Alter Table  OT2102 ADD S08ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S09ID')
			Alter Table  OT2102 ADD S09ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S10ID')
			Alter Table  OT2102 ADD S10ID NVARCHAR(250)  
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S11ID')
			Alter Table  OT2102 ADD S11ID NVARCHAR(250)           
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S12ID')
			Alter Table  OT2102 ADD S12ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S13ID')
			Alter Table  OT2102 ADD S13ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S14ID')
			Alter Table  OT2102 ADD S14ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S15ID')
			Alter Table  OT2102 ADD S15ID NVARCHAR(250)			   
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S16ID')
			Alter Table  OT2102 ADD S16ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S17ID')
			Alter Table  OT2102 ADD S17ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S18ID')
			Alter Table  OT2102 ADD S18ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S19ID')
			Alter Table  OT2102 ADD S19ID NVARCHAR(250)             
			If not exists (select * from syscolumns col inner join sysobjects tab
			On col.id = tab.id where tab.name =   'OT2102'  and col.name = 'S20ID')
			Alter Table  OT2102 ADD S20ID NVARCHAR(250)  

			IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'ConvertedUnitID')
			ALTER TABLE OT2102 ADD ConvertedUnitID VARCHAR(50) NULL

			IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'OT2102' AND col.name = 'OrderQuantity')
			ALTER TABLE OT2102 ADD OrderQuantity DECIMAL(28, 8) NULL
END