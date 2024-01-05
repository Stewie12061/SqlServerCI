-- <Summary>
---- Thông tin kho [Detail] _ Table lưu thông tin kho bị delete khỏi hệ thống. 
-- <History>
---- Create on 18/12/2019 by Trà Giang.

---- Modified on 27/04/2012 by Huỳnh Tấn Phú
---- Modified on 13/12/2012 by Bảo Anh
---- Modified on 07/10/2012 by Bảo Anh
---- Modified on 09/06/2014 by Thanh Sơn
---- Modified on 23/01/2014 by Thanh Sơn
---- Modified on 28/01/2013 by Bảo Anh
---- Modified on 21/08/2013 by Bảo Anh
---- Modified on 15/05/2012 by Việt Khánh
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on 01/04/2019 by Tra Giang: Bổ sung trường lưu vết phiếu nhập kho khi tạo phiếu xuất kế thừa đơn hàng mua (AIC)
---- Modified on 05/06/2019 by Như Hàn: Bổ sung trường "Là hàng gia công sửa chữa" cho VNF
---- Chuyến fix từ Dự án sang STD by Đình Hòa 13/01/2021
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT2007_Del]') AND type in (N'U'))
CREATE TABLE [dbo].[AT2007_Del](
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
	[Notes] [nvarchar](250) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[SaleUnitPrice] [decimal](28, 8) NULL,
	[SaleAmount] [decimal](28, 8) NULL,
	[DiscountAmount] [decimal](28, 8) NULL,
	[SourceNo] [nvarchar](50) NULL,
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
 CONSTRAINT [PK_AT2007_Del] PRIMARY KEY NONCLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2007_Del_CurrencyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2007_Del] ADD  CONSTRAINT [DF_AT2007_Del_CurrencyID]  DEFAULT ('VND') FOR [CurrencyID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2007_Del_ExchangeRate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2007_Del] ADD  CONSTRAINT [DF_AT2007_Del_ExchangeRate]  DEFAULT ((1)) FOR [ExchangeRate]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2007_Del_Orders]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2007_Del] ADD  CONSTRAINT [DF_AT2007_Del_Orders]  DEFAULT ((0)) FOR [Orders]
END
---- Add Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007_Del' AND col.name='MOrderID')
		ALTER TABLE AT2007_Del ADD MOrderID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007_Del' AND col.name='SOrderID')
		ALTER TABLE AT2007_Del ADD SOrderID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007_Del' AND col.name='MTransactionID')
		ALTER TABLE AT2007_Del ADD MTransactionID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007_Del' AND col.name='STransactionID')
		ALTER TABLE AT2007_Del ADD STransactionID NVARCHAR(50) NULL
	END
If Exists (Select * From sysobjects Where name = 'AT2007_Del' and xtype ='U') 
Begin
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'OExpenseConvertedAmount')
    Alter Table  AT2007_Del Add OExpenseConvertedAmount Decimal(28,8) NULL
END
If Exists (Select * From sysobjects Where name = 'AT2007_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'WVoucherID')
           Alter Table  AT2007_Del Add WVoucherID NVARCHAR(50) NULL
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT2007_Del' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT2007_Del' AND col.name='StandardPrice')
	ALTER TABLE AT2007_Del ADD StandardPrice DECIMAL(28,8) DEFAULT (0) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT2007_Del' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT2007_Del' AND col.name='StandardAmount')
	ALTER TABLE AT2007_Del ADD StandardAmount DECIMAL(28,8) DEFAULT (0) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007_Del' AND col.name='InheritTableID')
		ALTER TABLE AT2007_Del ADD InheritTableID NVARCHAR(50) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007_Del' AND col.name='InheritVoucherID')
		ALTER TABLE AT2007_Del ADD InheritVoucherID VARCHAR(50) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT2007_Del' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT2007_Del' AND col.name='InheritTransactionID')
		ALTER TABLE AT2007_Del ADD InheritTransactionID VARCHAR(50) NULL
	END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT2007_Del' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT2007_Del' AND col.name='RefInfor')
	ALTER TABLE AT2007_Del ADD RefInfor NVARCHAR(250) NULL
END
If Exists (Select * From sysobjects Where name = 'AT2007_Del' and xtype ='U') 
Begin
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes01')
        Alter Table  AT2007_Del Add Notes01 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes02')
        Alter Table  AT2007_Del Add Notes02 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes03')
        Alter Table  AT2007_Del Add Notes03 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes04')
        Alter Table  AT2007_Del Add Notes04 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes05')
        Alter Table  AT2007_Del Add Notes05 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes06')
        Alter Table  AT2007_Del Add Notes06 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes07')
        Alter Table  AT2007_Del Add Notes07 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes08')
        Alter Table  AT2007_Del Add Notes08 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes09')
        Alter Table  AT2007_Del Add Notes09 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes10')
        Alter Table  AT2007_Del Add Notes10 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes11')
        Alter Table  AT2007_Del Add Notes11 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes12')
        Alter Table  AT2007_Del Add Notes12 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes13')
        Alter Table  AT2007_Del Add Notes13 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes14')
        Alter Table  AT2007_Del Add Notes14 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Notes15')
        Alter Table  AT2007_Del Add Notes15 NVARCHAR(250) NULL
END
If Exists (Select * From sysobjects Where name = 'AT2007_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'MarkQuantity')
           Alter Table  AT2007_Del Add MarkQuantity DECIMAL(28,8) NULL
END
If Exists (Select * From sysobjects Where name = 'AT2007_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'LocationCode')
           Alter Table  AT2007_Del Add LocationCode nvarchar(50) Null
END
If Exists (Select * From sysobjects Where name = 'AT2007_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Location01ID')
           Alter Table  AT2007_Del Add Location01ID nvarchar(50) Null
END
If Exists (Select * From sysobjects Where name = 'AT2007_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Location02ID')
           Alter Table  AT2007_Del Add Location02ID nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'AT2007_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Location03ID')
           Alter Table  AT2007_Del Add Location03ID nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'AT2007_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Location04ID')
           Alter Table  AT2007_Del Add Location04ID nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'AT2007_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Location05ID')
           Alter Table  AT2007_Del Add Location05ID nvarchar(50) Null
END
If Exists (Select * From sysobjects Where name = 'AT2007_Del' and xtype ='U') 
Begin 
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT2007_Del'  and col.name = 'Ana06ID')
	Alter Table  AT2007_Del Add Ana06ID nvarchar(50) Null,
						 Ana07ID nvarchar(50) Null,
						 Ana08ID nvarchar(50) Null,
						 Ana09ID nvarchar(50) Null,
						 Ana10ID nvarchar(50) Null

	--- Modify on 18/01/2016 by Bảo Anh: Bổ sung mã vạch và số lượng thùng (customize Angel)
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'KITID')
		ALTER TABLE AT2007_Del ADD KITID NVARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'KITQuantity')
		ALTER TABLE AT2007_Del ADD KITQuantity DECIMAL(28,8) NULL
End
--- Modify on 01/02/2016 by Hoàng Vũ: Bổ sung Theo dõi vết của hóa đơn bán hàng, hóa đơn bán hàng theo bộ (customize Hoàng trần)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'TVoucherID')
        ALTER TABLE AT2007_Del ADD TVoucherID VARCHAR(50) NULL
    END
--- Modify on 01/02/2016 by Hoàng Vũ: Bổ sung Theo dõi vết của hóa đơn bán hàng, hóa đơn bán hàng theo bộ (customize Hoàng trần)	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'TTransactionID')
        ALTER TABLE AT2007_Del ADD TTransactionID VARCHAR(50) NULL
    END
--- Modify on 01/02/2016 by Hoàng Vũ: Lưu vết kế thừa
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'InheritTableID')
        ALTER TABLE AT2007_Del ADD InheritTableID NVARCHAR(50) NULL
    END
--- Modify on 01/02/2016 by Hoàng Vũ: Lưu vết kế thừa	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'InheritVoucherID')
        ALTER TABLE AT2007_Del ADD InheritVoucherID VARCHAR(50) NULL
    END
--- Modify on 01/02/2016 by Hoàng Vũ: Lưu vết kế thừa	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'InheritTransactionID')
        ALTER TABLE AT2007_Del ADD InheritTransactionID VARCHAR(50) NULL
    END	
    
--- Modified on 05/09/2016 by Bảo Thy: Lưu thông tin ghi nhận đơn hàng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'SOrderIDRecognition')
        ALTER TABLE AT2007_Del ADD SOrderIDRecognition VARCHAR(50) NULL
    END
---Modified by Thị Phượng on 07/12/2017: Bổ sung số serial
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'SerialNo') 
   ALTER TABLE AT2007_Del ADD SerialNo VARCHAR(100) NULL 
END
/*===============================================END SerialNo===============================================*/
--Thị Phượng Date 02/01/2018 Bổ sung số thẻ bảo hành
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'WarrantyCard') 
   ALTER TABLE AT2007_Del ADD WarrantyCard NVARCHAR(250) NULL 
END 

 --- Modified by Tiểu Mai on 23/05/2018: Bổ sung 20 quy cách cho sản phẩm   
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'PS01ID')
        ALTER TABLE AT2007_Del ADD	PS01ID NVARCHAR(50) NULL,
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
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'InheritPO') 
   ALTER TABLE AT2007_Del ADD InheritPO VARCHAR(50) NULL 
END

---Modified by Như Hàn on 05/06/2019: Bổ sung IsRepairItem - Là hàng gia công sửa chữa
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2007_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2007_Del' AND col.name = 'IsRepairItem') 
   ALTER TABLE AT2007_Del ADD IsRepairItem BIT 
END
