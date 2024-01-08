-- <Summary>
---- Chi tiết bảng giá theo số lượng nhóm hàng 
-- <History>
---- Create on 01/11/2021 by Kiều Nga
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CT0153]') AND type in (N'U'))
CREATE TABLE [dbo].[CT0153](
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
 CONSTRAINT [PK_CT0153] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
If Exists (Select * From sysobjects Where name = 'CT0153' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0153'  and col.name = 'ConvertedUnitPrice')
           Alter Table  CT0153 Add ConvertedUnitPrice decimal NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0153'  and col.name = 'ConvertedMinPrice')
           Alter Table  CT0153 Add ConvertedMinPrice decimal NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0153'  and col.name = 'ConvertedMaxPrice')
           Alter Table  CT0153 Add ConvertedMaxPrice decimal NULL           
End
If Exists (Select * From sysobjects Where name = 'CT0153' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0153'  and col.name = 'ConvertedUnitPrice')
           Alter Table  CT0153 Add ConvertedUnitPrice decimal NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0153'  and col.name = 'ConvertedMinPrice')
           Alter Table  CT0153 Add ConvertedMinPrice decimal NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0153'  and col.name = 'ConvertedMaxPrice')
           Alter Table  CT0153 Add ConvertedMaxPrice decimal NULL           
           --- Modify on 16/01/2014 by Bao Anh: customize cho Sinolife       
		   If not exists (select * from syscolumns col inner join sysobjects tab 
		   On col.id = tab.id where tab.name =   'CT0153'  and col.name = 'PaymentID')
		   Alter Table  CT0153 Add PaymentID nvarchar(50) Null
		   --- Modify on 17/02/2014 by Bao Anh: customize cho Sinolife (dùng MPT8 làm mặt hàng)
		   If not exists (select * from syscolumns col inner join sysobjects tab 
		   On col.id = tab.id where tab.name =   'CT0153'  and col.name = 'InventoryIDSNL')
		   Alter Table  CT0153 Add InventoryIDSNL nvarchar(50) Null

		    --- Modify on 09/09/2015 by Thanh Thinh: customize cho ABA Thêm Cột Phí Trả Khay
		   If not exists (select * from syscolumns col inner join sysobjects tab 
		   On col.id = tab.id where tab.name =   'CT0153'  and col.name = 'TrayPrice')
		   Alter Table  CT0153 Add TrayPrice decimal Null
		   --- Modify on 09/09/2015 by Thanh Thinh: customize cho ABA Thêm Cột Phí Rớt Điểm Khay
		   If not exists (select * from syscolumns col inner join sysobjects tab 
		   On col.id = tab.id where tab.name =   'CT0153'  and col.name = 'DecreaseTrayPrice')
		   Alter Table  CT0153 Add DecreaseTrayPrice decimal Null
END
---- Alter Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='CT0153' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT0153' AND col.name='ConvertedUnitPrice')
		ALTER TABLE CT0153 ALTER COLUMN ConvertedUnitPrice DECIMAL(28,8) NULL 
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='CT0153' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT0153' AND col.name='ConvertedMinPrice')
		ALTER TABLE CT0153 ALTER COLUMN ConvertedMinPrice DECIMAL(28,8) NULL 
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='CT0153' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT0153' AND col.name='ConvertedMaxPrice')
		ALTER TABLE CT0153 ALTER COLUMN ConvertedMaxPrice DECIMAL(28,8) NULL 
	END
---- Drop Columns
If Exists (Select * From sysobjects Where name = 'CT0153' and xtype ='U') 
Begin
        If exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'CT0153'  and col.name = 'InventoryIDSNL')
			Alter table CT0153 drop column InventoryIDSNL
End

----- Modified by Phương Thảo on 25/04/2017: Add column AddCost01-AddCost15 (customize Đông Dương)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost01') 
   ALTER TABLE CT0153 ADD AddCost01 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost02') 
   ALTER TABLE CT0153 ADD AddCost02 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost03') 
   ALTER TABLE CT0153 ADD AddCost03 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost04') 
   ALTER TABLE CT0153 ADD AddCost04 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost05') 
   ALTER TABLE CT0153 ADD AddCost05 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost06') 
   ALTER TABLE CT0153 ADD AddCost06 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost07') 
   ALTER TABLE CT0153 ADD AddCost07 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost08') 
   ALTER TABLE CT0153 ADD AddCost08 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost09') 
   ALTER TABLE CT0153 ADD AddCost09 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost10') 
   ALTER TABLE CT0153 ADD AddCost10 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost11') 
   ALTER TABLE CT0153 ADD AddCost11 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost12') 
   ALTER TABLE CT0153 ADD AddCost12 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost13') 
   ALTER TABLE CT0153 ADD AddCost13 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost14') 
   ALTER TABLE CT0153 ADD AddCost14 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'AddCost15') 
   ALTER TABLE CT0153 ADD AddCost15 DECIMAL(28,8) NULL 
END
---Modify by Thị Phượng Bổ sung hệ số CA (CustomizeIndex =79 (Minh Sang))
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'CA') 
   ALTER TABLE CT0153 ADD CA DECIMAL(28,8) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'CAAmount') 
   ALTER TABLE CT0153 ADD CAAmount DECIMAL(28,8) NULL 
END

/*===============================================END CA===============================================*/ 
--Thị Phượng bổ sung cột giá bán trả góp (MINH SANG)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'InstallmentPrice') 
   ALTER TABLE CT0153 ADD InstallmentPrice DECIMAL(28,8) NULL 
END

/*===============================================END InstallmentPrice===============================================*/ 



---- Modified by Phương Thảo on 23/08/2017: Bổ sung 20 cột quy cách

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S01ID') 
   ALTER TABLE CT0153 ADD S01ID VARCHAR(50) NULL 
END
/*===============================================END S01ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S02ID') 
   ALTER TABLE CT0153 ADD S02ID VARCHAR(50) NULL 
END

/*===============================================END S02ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S03ID') 
   ALTER TABLE CT0153 ADD S03ID VARCHAR(50) NULL 
END

/*===============================================END S03ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S04ID') 
   ALTER TABLE CT0153 ADD S04ID VARCHAR(50) NULL 
END

/*===============================================END S04ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S05ID') 
   ALTER TABLE CT0153 ADD S05ID VARCHAR(50) NULL 
END

/*===============================================END S05ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S06ID') 
   ALTER TABLE CT0153 ADD S06ID VARCHAR(50) NULL 
END

/*===============================================END S06ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S07ID') 
   ALTER TABLE CT0153 ADD S07ID VARCHAR(50) NULL 
END

/*===============================================END S07ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S08ID') 
   ALTER TABLE CT0153 ADD S08ID VARCHAR(50) NULL 
END

/*===============================================END S08ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S09ID') 
   ALTER TABLE CT0153 ADD S09ID VARCHAR(50) NULL 
END

/*===============================================END S09ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S10ID') 
   ALTER TABLE CT0153 ADD S10ID VARCHAR(50) NULL 
END

/*===============================================END S10ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S11ID') 
   ALTER TABLE CT0153 ADD S11ID VARCHAR(50) NULL 
END

/*===============================================END S11ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S12ID') 
   ALTER TABLE CT0153 ADD S12ID VARCHAR(50) NULL 
END

/*===============================================END S12ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S13ID') 
   ALTER TABLE CT0153 ADD S13ID VARCHAR(50) NULL 
END

/*===============================================END S13ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S14ID') 
   ALTER TABLE CT0153 ADD S14ID VARCHAR(50) NULL 
END

/*===============================================END S14ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S15ID') 
   ALTER TABLE CT0153 ADD S15ID VARCHAR(50) NULL 
END

/*===============================================END S15ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S16ID') 
   ALTER TABLE CT0153 ADD S16ID VARCHAR(50) NULL 
END

/*===============================================END S16ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S17ID') 
   ALTER TABLE CT0153 ADD S17ID VARCHAR(50) NULL 
END

/*===============================================END S17ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S18ID') 
   ALTER TABLE CT0153 ADD S18ID VARCHAR(50) NULL 
END

/*===============================================END S18ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S19ID') 
   ALTER TABLE CT0153 ADD S19ID VARCHAR(50) NULL 
END

/*===============================================END S19ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'S20ID') 
   ALTER TABLE CT0153 ADD S20ID VARCHAR(50) NULL 
END

/*===============================================END S20ID===============================================*/ 
---Thị Phượng ON 10/01/2018 thêm trường IsGift 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'IsGift') 
   ALTER TABLE CT0153 ADD IsGift TINYINT NULL 
END

-- Danh - 2018/04/13 Thêm trường xử lý bảng giá trước/sau thuế
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'VATPercent') 
   ALTER TABLE CT0153 ADD VATPercent decimal(28, 8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'VATAmount') 
   ALTER TABLE CT0153 ADD VATAmount decimal(28, 8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'TotalAmount') 
   ALTER TABLE CT0153 ADD TotalAmount decimal(28, 8) NULL
END

---Trà Giang ON 02/08/2018 thêm trường Giá sỉ WholesalePrice 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'WholesalePrice') 
   ALTER TABLE CT0153 ADD WholesalePrice decimal(28, 8) NULL 
END

---Hoàng vũ ON 08/05/2019 thêm trường [Điểm nhân viên phụ kho]: Notes03 phục vụ cho bán hàng trên POS và Đơn hàng bán trên APP (Ghi nhân điểm tính lương theo sản phẩm) => NHANNGOC
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'Notes03') 
   ALTER TABLE CT0153 ADD Notes03 NVARCHAR(250) NULL 
END

--- Đức Thông ON 06/10/2020 thêm trường IsAppDisplay (SAVI): Có hiện thị ở bảng giá trên APP không
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'IsAppDisplay') 
   ALTER TABLE CT0153 ADD IsAppDisplay TINYINT NULL 
END

--- Lê Hoàng ON 30/10/2020 thêm 5 BonusRate trường tỷ lệ huê hồng : để tính tỷ lệ huê hồng cho nhân viên
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'BonusRate01') 
   ALTER TABLE CT0153 ADD BonusRate01 DECIMAL(28, 8) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'BonusRate02') 
   ALTER TABLE CT0153 ADD BonusRate02 DECIMAL(28, 8) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'BonusRate03') 
   ALTER TABLE CT0153 ADD BonusRate03 DECIMAL(28, 8) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'BonusRate04') 
   ALTER TABLE CT0153 ADD BonusRate04 DECIMAL(28, 8) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'BonusRate05') 
   ALTER TABLE CT0153 ADD BonusRate05 DECIMAL(28, 8) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'InventoryTypeID') 
   ALTER TABLE CT0153 ADD InventoryTypeID NVARCHAR(50) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'Value') 
   ALTER TABLE CT0153 ADD Value NVARCHAR(250) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CT0153' AND col.name = 'APKValue') 
   ALTER TABLE CT0153 ADD APKValue uniqueidentifier NULL 
END

