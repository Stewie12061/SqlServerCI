-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on 21/03/2014 by Bảo Anh: Xoa field InventoryIDSNL
---- Modified on 10/09/2020 by Văn Tài: Bổ sung các cột từ 8.3.7 DA sang.
---- Modified on 10/09/2020 by Đức Thông: thêm trường IsAppDisplay (SAVI): Có hiện thị ở bảng giá trên APP không
---- Modified on 30/10/2020 by Lê Hoàng : thêm 5 BonusRate trường tỷ lệ huê hồng : để tính tỷ lệ huê hồng cho nhân viên
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT1302]') AND type in (N'U'))
CREATE TABLE [dbo].[OT1302](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[DetailID] [nvarchar](50) NOT NULL,
	[ID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[MinPrice] [decimal](28, 8) NULL,
	[MaxPrice] [decimal](28, 8) NULL,
	[Notes] [nvarchar](250) NULL,
	[Orders] [int] NULL,
	[Notes01] [nvarchar](250) NULL,
	[Notes02] [nvarchar](250) NULL,
	[DiscountPercent] [decimal](28, 8) NULL,
	[DiscountAmount] [decimal](28, 8) NULL,
	[SaleOffPercent01] [decimal](28, 8) NULL,
	[SaleOffAmount01] [decimal](28, 8) NULL,
	[SaleOffPercent02] [decimal](28, 8) NULL,
	[SaleOffAmount02] [decimal](28, 8) NULL,
	[SaleOffPercent03] [decimal](28, 8) NULL,
	[SaleOffAmount03] [decimal](28, 8) NULL,
	[SaleOffPercent04] [decimal](28, 8) NULL,
	[SaleOffAmount04] [decimal](28, 8) NULL,
	[SaleOffPercent05] [decimal](28, 8) NULL,
	[SaleOffAmount05] [decimal](28, 8) NULL,
 CONSTRAINT [PK_OT1302] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
If Exists (Select * From sysobjects Where name = 'OT1302' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1302'  and col.name = 'ConvertedUnitPrice')
           Alter Table  OT1302 Add ConvertedUnitPrice decimal NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1302'  and col.name = 'ConvertedMinPrice')
           Alter Table  OT1302 Add ConvertedMinPrice decimal NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1302'  and col.name = 'ConvertedMaxPrice')
           Alter Table  OT1302 Add ConvertedMaxPrice decimal NULL           
End
If Exists (Select * From sysobjects Where name = 'OT1302' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1302'  and col.name = 'ConvertedUnitPrice')
           Alter Table  OT1302 Add ConvertedUnitPrice decimal NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1302'  and col.name = 'ConvertedMinPrice')
           Alter Table  OT1302 Add ConvertedMinPrice decimal NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT1302'  and col.name = 'ConvertedMaxPrice')
           Alter Table  OT1302 Add ConvertedMaxPrice decimal NULL           
           --- Modify on 16/01/2014 by Bao Anh: customize cho Sinolife       
		   If not exists (select * from syscolumns col inner join sysobjects tab 
		   On col.id = tab.id where tab.name =   'OT1302'  and col.name = 'PaymentID')
		   Alter Table  OT1302 Add PaymentID nvarchar(50) Null
		   --- Modify on 17/02/2014 by Bao Anh: customize cho Sinolife (dùng MPT8 làm mặt hàng)
		   If not exists (select * from syscolumns col inner join sysobjects tab 
		   On col.id = tab.id where tab.name =   'OT1302'  and col.name = 'InventoryIDSNL')
		   Alter Table  OT1302 Add InventoryIDSNL nvarchar(50) Null

		    --- Modify on 09/09/2015 by Thanh Thinh: customize cho ABA Thêm Cột Phí Trả Khay
		   If not exists (select * from syscolumns col inner join sysobjects tab 
		   On col.id = tab.id where tab.name =   'OT1302'  and col.name = 'TrayPrice')
		   Alter Table  OT1302 Add TrayPrice decimal Null
		   --- Modify on 09/09/2015 by Thanh Thinh: customize cho ABA Thêm Cột Phí Rớt Điểm Khay
		   If not exists (select * from syscolumns col inner join sysobjects tab 
		   On col.id = tab.id where tab.name =   'OT1302'  and col.name = 'DecreaseTrayPrice')
		   Alter Table  OT1302 Add DecreaseTrayPrice decimal Null
END
---- Alter Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT1302' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT1302' AND col.name='ConvertedUnitPrice')
		ALTER TABLE OT1302 ALTER COLUMN ConvertedUnitPrice DECIMAL(28,8) NULL 
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT1302' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT1302' AND col.name='ConvertedMinPrice')
		ALTER TABLE OT1302 ALTER COLUMN ConvertedMinPrice DECIMAL(28,8) NULL 
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT1302' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT1302' AND col.name='ConvertedMaxPrice')
		ALTER TABLE OT1302 ALTER COLUMN ConvertedMaxPrice DECIMAL(28,8) NULL 
	END
---- Drop Columns
If Exists (Select * From sysobjects Where name = 'OT1302' and xtype ='U') 
Begin
        If exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'OT1302'  and col.name = 'InventoryIDSNL')
			Alter table OT1302 drop column InventoryIDSNL
End

----- Modified by Phương Thảo on 25/04/2017: Add column AddCost01-AddCost15 (customize Đông Dương)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost01') 
   ALTER TABLE OT1302 ADD AddCost01 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost02') 
   ALTER TABLE OT1302 ADD AddCost02 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost03') 
   ALTER TABLE OT1302 ADD AddCost03 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost04') 
   ALTER TABLE OT1302 ADD AddCost04 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost05') 
   ALTER TABLE OT1302 ADD AddCost05 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost06') 
   ALTER TABLE OT1302 ADD AddCost06 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost07') 
   ALTER TABLE OT1302 ADD AddCost07 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost08') 
   ALTER TABLE OT1302 ADD AddCost08 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost09') 
   ALTER TABLE OT1302 ADD AddCost09 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost10') 
   ALTER TABLE OT1302 ADD AddCost10 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost11') 
   ALTER TABLE OT1302 ADD AddCost11 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost12') 
   ALTER TABLE OT1302 ADD AddCost12 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost13') 
   ALTER TABLE OT1302 ADD AddCost13 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost14') 
   ALTER TABLE OT1302 ADD AddCost14 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'AddCost15') 
   ALTER TABLE OT1302 ADD AddCost15 DECIMAL(28,8) NULL 
END
---Modify by Thị Phượng Bổ sung hệ số CA (CustomizeIndex =79 (Minh Sang))
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'CA') 
   ALTER TABLE OT1302 ADD CA DECIMAL(28,8) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'CAAmount') 
   ALTER TABLE OT1302 ADD CAAmount DECIMAL(28,8) NULL 
END

/*===============================================END CA===============================================*/ 
--Thị Phượng bổ sung cột giá bán trả góp (MINH SANG)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'InstallmentPrice') 
   ALTER TABLE OT1302 ADD InstallmentPrice DECIMAL(28,8) NULL 
END

/*===============================================END InstallmentPrice===============================================*/ 



---- Modified by Phương Thảo on 23/08/2017: Bổ sung 20 cột quy cách

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S01ID') 
   ALTER TABLE OT1302 ADD S01ID VARCHAR(50) NULL 
END
/*===============================================END S01ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S02ID') 
   ALTER TABLE OT1302 ADD S02ID VARCHAR(50) NULL 
END

/*===============================================END S02ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S03ID') 
   ALTER TABLE OT1302 ADD S03ID VARCHAR(50) NULL 
END

/*===============================================END S03ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S04ID') 
   ALTER TABLE OT1302 ADD S04ID VARCHAR(50) NULL 
END

/*===============================================END S04ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S05ID') 
   ALTER TABLE OT1302 ADD S05ID VARCHAR(50) NULL 
END

/*===============================================END S05ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S06ID') 
   ALTER TABLE OT1302 ADD S06ID VARCHAR(50) NULL 
END

/*===============================================END S06ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S07ID') 
   ALTER TABLE OT1302 ADD S07ID VARCHAR(50) NULL 
END

/*===============================================END S07ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S08ID') 
   ALTER TABLE OT1302 ADD S08ID VARCHAR(50) NULL 
END

/*===============================================END S08ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S09ID') 
   ALTER TABLE OT1302 ADD S09ID VARCHAR(50) NULL 
END

/*===============================================END S09ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S10ID') 
   ALTER TABLE OT1302 ADD S10ID VARCHAR(50) NULL 
END

/*===============================================END S10ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S11ID') 
   ALTER TABLE OT1302 ADD S11ID VARCHAR(50) NULL 
END

/*===============================================END S11ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S12ID') 
   ALTER TABLE OT1302 ADD S12ID VARCHAR(50) NULL 
END

/*===============================================END S12ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S13ID') 
   ALTER TABLE OT1302 ADD S13ID VARCHAR(50) NULL 
END

/*===============================================END S13ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S14ID') 
   ALTER TABLE OT1302 ADD S14ID VARCHAR(50) NULL 
END

/*===============================================END S14ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S15ID') 
   ALTER TABLE OT1302 ADD S15ID VARCHAR(50) NULL 
END

/*===============================================END S15ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S16ID') 
   ALTER TABLE OT1302 ADD S16ID VARCHAR(50) NULL 
END

/*===============================================END S16ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S17ID') 
   ALTER TABLE OT1302 ADD S17ID VARCHAR(50) NULL 
END

/*===============================================END S17ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S18ID') 
   ALTER TABLE OT1302 ADD S18ID VARCHAR(50) NULL 
END

/*===============================================END S18ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S19ID') 
   ALTER TABLE OT1302 ADD S19ID VARCHAR(50) NULL 
END

/*===============================================END S19ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'S20ID') 
   ALTER TABLE OT1302 ADD S20ID VARCHAR(50) NULL 
END

/*===============================================END S20ID===============================================*/ 
---Thị Phượng ON 10/01/2018 thêm trường IsGift 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'IsGift') 
   ALTER TABLE OT1302 ADD IsGift TINYINT NULL 
END

-- Danh - 2018/04/13 Thêm trường xử lý bảng giá trước/sau thuế
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'VATPercent') 
   ALTER TABLE OT1302 ADD VATPercent decimal(28, 8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'VATAmount') 
   ALTER TABLE OT1302 ADD VATAmount decimal(28, 8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'TotalAmount') 
   ALTER TABLE OT1302 ADD TotalAmount decimal(28, 8) NULL
END

---Trà Giang ON 02/08/2018 thêm trường Giá sỉ WholesalePrice 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'WholesalePrice') 
   ALTER TABLE OT1302 ADD WholesalePrice decimal(28, 8) NULL 
END

---Hoàng vũ ON 08/05/2019 thêm trường [Điểm nhân viên phụ kho]: Notes03 phục vụ cho bán hàng trên POS và Đơn hàng bán trên APP (Ghi nhân điểm tính lương theo sản phẩm) => NHANNGOC
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'Notes03') 
   ALTER TABLE OT1302 ADD Notes03 NVARCHAR(250) NULL 
END

--- Đức Thông ON 06/10/2020 thêm trường IsAppDisplay (SAVI): Có hiện thị ở bảng giá trên APP không
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'IsAppDisplay') 
   ALTER TABLE OT1302 ADD IsAppDisplay TINYINT NULL 
END

--- Lê Hoàng ON 30/10/2020 thêm 5 BonusRate trường tỷ lệ huê hồng : để tính tỷ lệ huê hồng cho nhân viên
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'BonusRate01') 
   ALTER TABLE OT1302 ADD BonusRate01 DECIMAL(28, 8) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'BonusRate02') 
   ALTER TABLE OT1302 ADD BonusRate02 DECIMAL(28, 8) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'BonusRate03') 
   ALTER TABLE OT1302 ADD BonusRate03 DECIMAL(28, 8) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'BonusRate04') 
   ALTER TABLE OT1302 ADD BonusRate04 DECIMAL(28, 8) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'BonusRate05') 
   ALTER TABLE OT1302 ADD BonusRate05 DECIMAL(28, 8) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1302' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT1302' AND col.name = 'RetailPrice') 
   ALTER TABLE OT1302 ADD RetailPrice DECIMAL(28, 8) NULL 
END