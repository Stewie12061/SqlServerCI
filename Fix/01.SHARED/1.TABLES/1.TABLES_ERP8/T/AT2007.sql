-- <Summary>
---- Thông tin kho [Detail]
-- <History>
---- Create on 06/08/2010 by Mỹ Tuyền
---- Modified on 27/04/2012 by Huỳnh Tấn Phú
---- Modified on 13/12/2012 by Bảo Anh
---- Modified on 07/10/2012 by Bảo Anh
---- Modified on 09/06/2014 by Thanh Sơn
---- Modified on 23/01/2014 by Thanh Sơn
---- Modified on 28/01/2013 by Bảo Anh
---- Modified on 21/08/2013 by Bảo Anh
---- Modified on 15/05/2012 by Việt Khánh
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on 14/08/2020 by Huỳnh Thử -- Merge Code: MEKIO và MTE---- Modified on ... by ...
---- Modified on 13/11/2021 by Đình hòa: Merger cột từ fix dự án sang STD
---- Modified on 24/03/2022 by Nhựt Trường: Tăng độ rộng cho cột 'Lô nhập'.
---- Modified on 29/07/2022 by Nhật Thanh: Tăng độ rộng cho cột Notes
---- Modified on 20/06/2023 by Đình Định: Bổ sung cột ConvertedUnitName.
---- Modified on 28/11/2023 by Trọng Phúc: Bổ sung cột CarID, DriverID.
	---Modified by Minh Dũng on 30/11/2023: Modyfied column from S01ID to S20ID, Convert VARCHAR(50) to NVARCHAR(50)
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT2007]') AND type in (N'U'))
CREATE TABLE [dbo].[AT2007](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[BatchID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[UnitID] [nvarchar](50) NULL,
	[ActualQuantity] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[Notes] [nvarchar](500) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[SaleUnitPrice] [decimal](28, 8) NULL,
	[SaleAmount] [decimal](28, 8) NULL,
	[DiscountAmount] [decimal](28, 8) NULL,
	[SourceNo] [nvarchar](50) NULL,
	[WarrantyNo] [nvarchar](250) NULL,
	[ShelvesID] [nvarchar](50) NULL,
	[FloorID] [nvarchar](50) NULL,
	[DebitAccountID] [nvarchar](50) NULL,
	[CreditAccountID] [nvarchar](50) NULL,
	[LocationID] [nvarchar](50) NULL,
	[ImLocationID] [nvarchar](50) NULL,
	[LimitDate] [datetime] NULL,
	[Orders] [int] NOT NULL,
	[ConversionFactor] [decimal](28, 8) NULL,
	[ReTransactionID] [nvarchar](50) NULL,
	[ReVoucherID] [nvarchar](50) NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[PeriodID] [nvarchar](50) NULL,
	[ProductID] [nvarchar](50) NULL,
	[OrderID] [nvarchar](50) NULL,
	[InventoryName1] [nvarchar](250) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[OTransactionID] [nvarchar](50) NULL,
	[ReSPVoucherID] [nvarchar](50) NULL,
	[ReSPTransactionID] [nvarchar](50) NULL,
	[ETransactionID] [nvarchar](50) NULL,
	[MTransactionID] [nvarchar](50) NULL,
	[Parameter01] [decimal](28, 8) NULL,
	[Parameter02] [decimal](28, 8) NULL,
	[Parameter03] [decimal](28, 8) NULL,
	[Parameter04] [decimal](28, 8) NULL,
	[Parameter05] [decimal](28, 8) NULL,
	[ConvertedQuantity] [decimal](28, 8) NULL,
	[ConvertedPrice] [decimal](28, 8) NULL,
	[ConvertedUnitID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT2007] PRIMARY KEY NONCLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2007_CurrencyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2007] ADD  CONSTRAINT [DF_AT2007_CurrencyID]  DEFAULT ('VND') FOR [CurrencyID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2007_ExchangeRate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2007] ADD  CONSTRAINT [DF_AT2007_ExchangeRate]  DEFAULT ((1)) FOR [ExchangeRate]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2007_Orders]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2007] ADD  CONSTRAINT [DF_AT2007_Orders]  DEFAULT ((0)) FOR [Orders]
END
---- Add Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007' AND col.name='MOrderID')
		ALTER TABLE AT2007 ADD MOrderID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007' AND col.name='SOrderID')
		ALTER TABLE AT2007 ADD SOrderID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007' AND col.name='MTransactionID')
		ALTER TABLE AT2007 ADD MTransactionID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007' AND col.name='STransactionID')
		ALTER TABLE AT2007 ADD STransactionID NVARCHAR(50) NULL
	END
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'OExpenseConvertedAmount')
    Alter Table  AT2007 Add OExpenseConvertedAmount Decimal(28,8) NULL
END
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'WVoucherID')
           Alter Table  AT2007 Add WVoucherID NVARCHAR(50) NULL
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT2007' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT2007' AND col.name='StandardPrice')
	ALTER TABLE AT2007 ADD StandardPrice DECIMAL(28,8) DEFAULT (0) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT2007' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT2007' AND col.name='StandardAmount')
	ALTER TABLE AT2007 ADD StandardAmount DECIMAL(28,8) DEFAULT (0) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007' AND col.name='InheritTableID')
		ALTER TABLE AT2007 ADD InheritTableID NVARCHAR(50) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007' AND col.name='InheritVoucherID')
		ALTER TABLE AT2007 ADD InheritVoucherID VARCHAR(50) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007' AND col.name='InheritTransactionID')
		ALTER TABLE AT2007 ADD InheritTransactionID VARCHAR(50) NULL
	END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT2007' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT2007' AND col.name='RefInfor')
	ALTER TABLE AT2007 ADD RefInfor NVARCHAR(250) NULL
END
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes01')
        Alter Table  AT2007 Add Notes01 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes02')
        Alter Table  AT2007 Add Notes02 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes03')
        Alter Table  AT2007 Add Notes03 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes04')
        Alter Table  AT2007 Add Notes04 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes05')
        Alter Table  AT2007 Add Notes05 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes06')
        Alter Table  AT2007 Add Notes06 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes07')
        Alter Table  AT2007 Add Notes07 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes08')
        Alter Table  AT2007 Add Notes08 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes09')
        Alter Table  AT2007 Add Notes09 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes10')
        Alter Table  AT2007 Add Notes10 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes11')
        Alter Table  AT2007 Add Notes11 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes12')
        Alter Table  AT2007 Add Notes12 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes13')
        Alter Table  AT2007 Add Notes13 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes14')
        Alter Table  AT2007 Add Notes14 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Notes15')
        Alter Table  AT2007 Add Notes15 NVARCHAR(250) NULL
END
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'MarkQuantity')
           Alter Table  AT2007 Add MarkQuantity DECIMAL(28,8) NULL
END
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'LocationCode')
           Alter Table  AT2007 Add LocationCode nvarchar(50) Null
END
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Location01ID')
           Alter Table  AT2007 Add Location01ID nvarchar(50) Null
END
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Location02ID')
           Alter Table  AT2007 Add Location02ID nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Location03ID')
           Alter Table  AT2007 Add Location03ID nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Location04ID')
           Alter Table  AT2007 Add Location04ID nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Location05ID')
           Alter Table  AT2007 Add Location05ID nvarchar(50) Null
END
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin 
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT2007'  and col.name = 'Ana06ID')
	Alter Table  AT2007 Add Ana06ID nvarchar(50) Null,
						 Ana07ID nvarchar(50) Null,
						 Ana08ID nvarchar(50) Null,
						 Ana09ID nvarchar(50) Null,
						 Ana10ID nvarchar(50) Null

	--- Modify on 18/01/2016 by Bảo Anh: Bổ sung mã vạch và số lượng thùng (customize Angel)
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'KITID')
		ALTER TABLE AT2007 ADD KITID NVARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'KITQuantity')
		ALTER TABLE AT2007 ADD KITQuantity DECIMAL(28,8) NULL
End
--- Modify on 01/02/2016 by Hoàng Vũ: Bổ sung Theo dõi vết của hóa đơn bán hàng, hóa đơn bán hàng theo bộ (customize Hoàng trần)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'TVoucherID')
        ALTER TABLE AT2007 ADD TVoucherID VARCHAR(50) NULL
    END
--- Modify on 01/02/2016 by Hoàng Vũ: Bổ sung Theo dõi vết của hóa đơn bán hàng, hóa đơn bán hàng theo bộ (customize Hoàng trần)	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'TTransactionID')
        ALTER TABLE AT2007 ADD TTransactionID VARCHAR(50) NULL
    END
--- Modify on 01/02/2016 by Hoàng Vũ: Lưu vết kế thừa
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'InheritTableID')
        ALTER TABLE AT2007 ADD InheritTableID NVARCHAR(50) NULL
    END
--- Modify on 01/02/2016 by Hoàng Vũ: Lưu vết kế thừa	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'InheritVoucherID')
        ALTER TABLE AT2007 ADD InheritVoucherID VARCHAR(50) NULL
    END
--- Modify on 01/02/2016 by Hoàng Vũ: Lưu vết kế thừa	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'InheritTransactionID')
        ALTER TABLE AT2007 ADD InheritTransactionID VARCHAR(50) NULL
    END	
    
--- Modified on 05/09/2016 by Bảo Thy: Lưu thông tin ghi nhận đơn hàng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'SOrderIDRecognition')
        ALTER TABLE AT2007 ADD SOrderIDRecognition VARCHAR(50) NULL
    END
---Modified by Thị Phượng on 07/12/2017: Bổ sung số serial
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'SerialNo') 
   ALTER TABLE AT2007 ADD SerialNo VARCHAR(100) NULL 
END
/*===============================================END SerialNo===============================================*/
--Thị Phượng Date 02/01/2018 Bổ sung số thẻ bảo hành
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'WarrantyCard') 
   ALTER TABLE AT2007 ADD WarrantyCard NVARCHAR(250) NULL 
END 

/*===============================================END PVoucherNo===============================================*/
--Huỳnh Thử Date 03/10/2019 Bổ sung số Mã Pallet 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'PVoucherNo') 
   ALTER TABLE AT2007 ADD PVoucherNo NVARCHAR(250) NULL 
END 

/*===============================================END PLocationID===============================================*/
--Huỳnh Thử Date 03/10/2019 Bổ sung vị trí ô 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'PLocationID') 
   ALTER TABLE AT2007 ADD PLocationID NVARCHAR(250) NULL 
END 

--Huỳnh Thử Date 03/02/2019 Mở rộng ký tự InventoryName1
ALTER TABLE dbo.AT2007 ALTER COLUMN InventoryName1 NVARCHAR(500) NULL;

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'WarrantyNo') 
   ALTER TABLE AT2007 ADD WarrantyNo NVARCHAR(250) NULL 
END 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'ShelvesID') 
   ALTER TABLE AT2007 ADD ShelvesID NVARCHAR(50) NULL 
END 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'FloorID') 
   ALTER TABLE AT2007 ADD FloorID NVARCHAR(250) NULL 
END 

-- Huỳnh Thử [23/07/2020] -- Bổ sung cột IsRound để phân biệt khi nào làm tròn
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'IsRound') 
   ALTER TABLE AT2007 ADD IsRound TINYINT DEFAULT 0 
END 

----- Modify by Huỳnh Thử on 14/08/2020: Merge Code: MEKIO và MTE
--- Modify on 01/02/2016 by Phương Thảo: Add column IsCalculated: Lưu vết đã tính giá	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'IsCalculated')
        ALTER TABLE AT2007 ADD IsCalculated TINYINT NULL
    END


--- Modified by Đình Hòa on 13/01/2021: Merger fix Dự án dang STD  
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'PS01ID')
        ALTER TABLE AT2007 ADD	PS01ID NVARCHAR(50) NULL,
								PS02ID NVARCHAR(50) NULL,
								PS03ID NVARCHAR(50) NULL,
								PS04ID NVARCHAR(50) NULL,
								PS05ID NVARCHAR(50) NULL,
								PS06ID NVARCHAR(50) NULL,
								PS07ID NVARCHAR(50) NULL,
								PS08ID NVARCHAR(50) NULL,
								PS09ID NVARCHAR(50) NULL,
								PS10ID NVARCHAR(50) NULL,
								PS11ID NVARCHAR(50) NULL,
								PS12ID NVARCHAR(50) NULL,
								PS13ID NVARCHAR(50) NULL,
								PS14ID NVARCHAR(50) NULL,
								PS15ID NVARCHAR(50) NULL,
								PS16ID NVARCHAR(50) NULL,
								PS17ID NVARCHAR(50) NULL,
								PS18ID NVARCHAR(50) NULL,
								PS19ID NVARCHAR(50) NULL,
								PS20ID NVARCHAR(50) NULL
    END
---Modified by Tra Giang on 01/04/2019: Bổ sung lưu vết phiếu nhập kho(AIC) 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'InheritPO') 
   ALTER TABLE AT2007 ADD InheritPO VARCHAR(50) NULL 
END

---Modified by Như Hàn on 05/06/2019: Bổ sung IsRepairItem - Là hàng gia công sửa chữa
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'IsRepairItem') 
   ALTER TABLE AT2007 ADD IsRepairItem BIT 
END

---Modified by Văn Minh on 03/03/2020: Bổ sung VoucherNo_PO - VoucherNo của đơn hàng mua
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'VoucherNo_PO') 
   ALTER TABLE AT2007 ADD VoucherNo_PO Nvarchar(50) 
END

---Modified by Văn Minh on 03/03/2020: Bổ sung VoucherNo_YCNK - VoucherNo của phiếu YC
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'VoucherNo_YCNK') 
   ALTER TABLE AT2007 ADD VoucherNo_YCNK Nvarchar(50) 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007' AND col.name='SOrderID')
		ALTER TABLE AT2007 ALTER COLUMN SOrderID NVARCHAR(4000) NULL
	END
	
	---- Modified by Nhật Thanh on 14/12/2021: Bổ sung cột trạng thái khi update phiếu lắp ráp 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007' AND col.name='IsAssembly')
		ALTER TABLE AT2007 ADD IsAssembly TINYINT NULL
	END
	
---Modified by Nhựt Trường on 24/03/2022: Tăng độ rộng cho cột 'Lô nhập'
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name = 'AT2007' and col.name = 'SourceNo')
           Alter Table AT2007 Alter Column SourceNo [nvarchar](250) NULL          
End
If Exists (Select * From sysobjects Where name = 'AT2007' and xtype ='U') 
Begin
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name = 'AT2007' and col.name = 'Notes')
           Alter Table AT2007 Alter Column Notes [nvarchar](500) NULL          
End

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'IsProInventoryID') 
   ALTER TABLE AT2007 ADD IsProInventoryID TINYINT NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'ApkMT2161') 
   ALTER TABLE AT2007 ADD ApkMT2161 [varchar](100) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'ConvertedUnitName') 
   ALTER TABLE AT2007 ADD ConvertedUnitName NVARCHAR (20) NULL
END

---Modified by Hoàng Long on 28/09/2023: Bổ sung trường sô PO
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'PONumber') 
   ALTER TABLE AT2007 ADD PONumber Nvarchar(50) 
END

	---Modified by Trọng Phúc on 28/11/2023: Bổ sung trường mã xe, tên tài xế
IF EXISTS(SELECT * FROM CustomerIndex WHERE CustomerName = 166)
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'DriverID') 
	ALTER TABLE AT2007 ADD DriverID VARCHAR(50) 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'CarID') 
	ALTER TABLE AT2007 ADD CarID VARCHAR(50) 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN
	---Modified by Minh Dũng on 30/11/2023: Modyfied column from S01ID to S20ID, Convert VARCHAR(50) to NVARCHAR(50)
	--Update loại bỏ quy cách (Bảng quy cách moudule WM: WT8899)--
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S01ID') 
	ALTER TABLE AT2007 DROP COLUMN S01ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S02ID') 
	ALTER TABLE AT2007 DROP COLUMN S02ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S03ID') 
	ALTER TABLE AT2007 DROP COLUMN S03ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S04ID') 
	ALTER TABLE AT2007 DROP COLUMN S04ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S05ID') 
	ALTER TABLE AT2007 DROP COLUMN S05ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S06ID') 
	ALTER TABLE AT2007 DROP COLUMN S06ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S07ID') 
	ALTER TABLE AT2007 DROP COLUMN S07ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S08ID') 
	ALTER TABLE AT2007 DROP COLUMN S08ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S09ID') 
	ALTER TABLE AT2007 DROP COLUMN S09ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S10ID') 
	ALTER TABLE AT2007 DROP COLUMN S10ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S11ID') 
	ALTER TABLE AT2007 DROP COLUMN S11ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S12ID') 
	ALTER TABLE AT2007 DROP COLUMN S12ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S13ID') 
	ALTER TABLE AT2007 DROP COLUMN S13ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S14ID') 
	ALTER TABLE AT2007 DROP COLUMN S14ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S15ID') 
	ALTER TABLE AT2007 DROP COLUMN S15ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S16ID') 
	ALTER TABLE AT2007 DROP COLUMN S16ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S17ID') 
	ALTER TABLE AT2007 DROP COLUMN S17ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S18ID') 
	ALTER TABLE AT2007 DROP COLUMN S18ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S19ID') 
	ALTER TABLE AT2007 DROP COLUMN S19ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'S20ID') 
	ALTER TABLE AT2007 DROP COLUMN S20ID
END
---Modified by Ngô Dũng on 19/12/2023: Bổ sung trường số seri, ngày sản xuất, lệnh sản xuất 
IF EXISTS(SELECT * FROM CustomerIndex WHERE CustomerName = 166)
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'SeriNo') 
	ALTER TABLE AT2007 ADD SeriNo NVARCHAR(50) 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'ProductionOrder') 
	ALTER TABLE AT2007 ADD ProductionOrder NVARCHAR(50)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'ImVoucherDate') 
	ALTER TABLE AT2007 ADD ImVoucherDate DATE

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'ReVoucherNo') 
	ALTER TABLE AT2007 ADD ReVoucherNo NVARCHAR(50)
END

---Modified by Bi Phan on 20/12/2023: Bổ sung trường ObjectTHCPID, ObjectTHCPName, ProductID, ProductName
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'ObjectTHCPID') 
	ALTER TABLE AT2007 ADD ObjectTHCPID NVARCHAR(250) 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'ObjectTHCPName') 
	ALTER TABLE AT2007 ADD ObjectTHCPName NVARCHAR(250) 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'ProductID') 
	ALTER TABLE AT2007 ADD ProductID NVARCHAR(250) 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007' AND col.name = 'ProductName') 
	ALTER TABLE AT2007 ADD ProductName NVARCHAR(250) 
END
