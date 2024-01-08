-- <Summary>
---- 
-- <History>
---- Create on 23/05/2011 by Huỳnh Tấn Phú
---- Modified by Thanh Sơn on 24/04/2015: Bổ sung cột StandardVoucherID
---- Modified on 3/02/2015 by Hoàng Vũ: Bổ sung cột InheritTableID, InheritVoucherID, InheritTransactionID để check kế thừa
---- Modified by Thanh Sơn on 13/05/2015: Bổ sung 20 mã phân tích quy cách hàng
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on 18/06/2015 by Hoàng Vũ: Bổ sung cột ExtraID (Customize Index Secoin)
---- Modified on 06/07/2015 by Thanh Sơn: Bổ sung cột YDQuantity
---- Modified on 19/08/2015 by QUốc Tuấn: Bổ sung cột ReadyQuantity,PlanPercent,PlanQuantity
---- Modified on 18/11/2015 by Tiểu Mai: Bỏ 20 cột S01ID-->S02ID vì đã sử dụng table OT8899
---- Modified by Tiểu Mai on 12/05/2016: Bổ sung cột DiscountSaleAmountDetail cho ANGEL
---- Modified by Hải Long on 25/08/2016: Bổ sung các trường cho ABA
---- Modified by Hải Long on 07/09/2016: Bổ sung các trường cho ANPHAT
---- Modified by Thị Phượng on 21/11/2016: Bổ sung cột IsBorrow cho Hoàng Trần check vật tư cho mượn
---- Modified by Tra Giang  on 16/11/2018: Bổ sung cột ObjectID_NNP, InventoryQuantity,PickingQuantity cho Nguyên Nguyên Phước 
---- Modified by Tra Giang  on 20/03/2019: Kiểm tra tồn tại ObjectID thì thực hiện xóa.
---- Modified by Hoàng Vũ  on 04/04/2019: Lưu vết mặt hàng chính của hàng khuyến mãi
---- Modified by Như Hàn on 09/07/2019: Lưu vết hàng cho mượn CustomerIndex = 107 (VNF)
---- Modified by Hoài Phong on 21/10/2020: Bổ sung trường PriceListID, để chi tiết mã hàng mua với giá sỉ  hay giá lẻ trên App HH
---- Modified by Nhựt Trường on 11/08/2021: Bổ sung trường CurrencyID, ExchangeRate.
---- Modified by Kiều Nga on 25/11/2021: Bổ sung trường InventoryGroupAnaTypeID.
---- Modified by Kiều Nga on 08/12/2021: Bổ sung trường MinPrice.
---- Modified by Hoài Bảo on 17/05/2022: Bổ sung trường DiscountAmount.
---- Modified by Thành Sang on 21/12/2022 : Bổ sung trường IsChoosePro
---- Modified by Xuân Nguyên on 05/01/2023: Bổ sung trường ProductID,ProductName cho Thiên Nam
---- Modified by Thanh Lượng on 22/05/2023: Bổ sung merge code từ Gree
---- Modified by Thành Sang on 12/06/2023: Bổ sung trường WarehouseFee cho BOURBON
---- Modified by Đình Định on 15/06/2023: BBL - Bổ sung trường QuantityOfWarehouseRental Số lượng thuê kho.

---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT2002]') AND type in (N'U'))
CREATE TABLE [dbo].[OT2002](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[SOrderID] [nvarchar](50) NOT NULL,
	[InventoryID] [nvarchar](50) NULL,
	[MethodID] [nvarchar](50) NULL,
	[OrderQuantity] [decimal](28, 8) NULL,
	[SalePrice] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[VATOriginalAmount] [decimal](28, 8) NULL,
	[VATConvertedAmount] [decimal](28, 8) NULL,
	[VATPercent] [decimal](28, 8) NULL,
	[DiscountConvertedAmount] [decimal](28, 8) NULL,
	[DiscountPercent] [decimal](28, 8) NULL,
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
	[LinkNo] [nvarchar](50) NULL,
	[EndDate] [datetime] NULL,
	[Orders] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[RefInfor] [nvarchar](250) NULL,
	[CommissionPercent] [decimal](28, 8) NULL,
	[CommissionCAmount] [decimal](28, 8) NULL,
	[CommissionOAmount] [decimal](28, 8) NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[InventoryCommonName] [nvarchar](250) NULL,
	[UnitID] [nvarchar](50) NULL,
	[Finish] [tinyint] NULL,
	[AdjustQuantity] [decimal](28, 8) NULL,
	[FileID] [nvarchar](50) NULL,
	[RefOrderID] [nvarchar](50) NULL,
	[SourceNo] [decimal](28, 8) NULL,
	[Cal01] [decimal](28, 8) NULL,
	[Cal02] [decimal](28, 8) NULL,
	[Cal03] [decimal](28, 8) NULL,
	[Cal04] [decimal](28, 8) NULL,
	[Cal05] [decimal](28, 8) NULL,
	[Cal06] [decimal](28, 8) NULL,
	[Cal07] [decimal](28, 8) NULL,
	[Cal08] [decimal](28, 8) NULL,
	[Cal09] [decimal](28, 8) NULL,
	[Cal10] [decimal](28, 8) NULL,
	[Notes] [nvarchar](250) NULL,
	[Notes01] [nvarchar](250) NULL,
	[Notes02] [nvarchar](250) NULL,
	[QuotationID] [nvarchar](50) NULL,
	[VATGroupID] [nvarchar](50) NULL,
	[QuoTransactionID] [nvarchar](50) NULL,
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
	[PriceList] [decimal](28, 8) NULL,
	[Varchar01] [nvarchar](100) NULL,
	[Varchar02] [nvarchar](100) NULL,
	[Varchar03] [nvarchar](100) NULL,
	[Varchar04] [nvarchar](100) NULL,
	[Varchar05] [nvarchar](100) NULL,
	[Varchar06] [nvarchar](100) NULL,
	[Varchar07] [nvarchar](100) NULL,
	[Varchar08] [nvarchar](100) NULL,
	[Varchar09] [nvarchar](100) NULL,
	[Varchar10] [nvarchar](100) NULL,
	[ConvertedQuantity] [decimal](28, 8) NULL,
	[SOKitTransactionID] [nvarchar](50) NULL,
	[ConvertedSalePrice] [decimal](28, 8) NULL,
	[nvarchar01] [nvarchar](100) NULL,
	[nvarchar02] [nvarchar](100) NULL,
	[nvarchar03] [nvarchar](100) NULL,
	[nvarchar04] [nvarchar](100) NULL,
	[nvarchar05] [nvarchar](100) NULL,
	[nvarchar06] [nvarchar](100) NULL,
	[nvarchar07] [nvarchar](100) NULL,
	[nvarchar08] [nvarchar](100) NULL,
	[nvarchar09] [nvarchar](100) NULL,
	[nvarchar10] [nvarchar](100) NULL,
 CONSTRAINT [PK_OT2002] PRIMARY KEY NONCLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OT2002_IsPicking]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT2002] ADD  CONSTRAINT [DF_OT2002_IsPicking]  DEFAULT ((0)) FOR [IsPicking]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Allowance')
           Alter Table  OT2002 Add Allowance NVARCHAR(250) NULL
End
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter01')
           Alter Table  OT2002 Add Parameter01 DECIMAL(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter02')
           Alter Table  OT2002 Add Parameter02 DECIMAL(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter03')
           Alter Table  OT2002 Add Parameter03 DECIMAL(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter04')
           Alter Table  OT2002 Add Parameter04 DECIMAL(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter05')
           Alter Table  OT2002 Add Parameter05 DECIMAL(28,8) NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name = 'StandardPrice')
	ALTER TABLE OT2002 ADD StandardPrice DECIMAL(28,8) DEFAULT (0) NULL
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name = 'YDQuantity')
	ALTER TABLE OT2002 ADD YDQuantity DECIMAL(28,8) NULL
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='StandardAmount')
	ALTER TABLE OT2002 ADD StandardAmount DECIMAL(28,8) DEFAULT (0) NULL
END
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter01')
           Alter Table  OT2002 Add Parameter01 DECIMAL(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter02')
           Alter Table  OT2002 Add Parameter02 DECIMAL(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter03')
           Alter Table  OT2002 Add Parameter03 DECIMAL(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter04')
           Alter Table  OT2002 Add Parameter04 DECIMAL(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter05')
           Alter Table  OT2002 Add Parameter05 DECIMAL(28,8) NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'StandardVoucherID')
		ALTER TABLE OT2002 ADD StandardVoucherID VARCHAR(50) NULL
	END
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Markup')
           Alter Table  OT2002 Add Markup decimal(28,8) Null
END
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'OriginalAmountOutput')
           Alter Table  OT2002 Add OriginalAmountOutput decimal(28,8) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'DeliveryDate')
           Alter Table  OT2002 Add DeliveryDate DateTime Null
END
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'ConvertedSalepriceInput')
           Alter Table  OT2002 Add ConvertedSalepriceInput decimal(28,8) Null
End 
if(isnull(COL_LENGTH('OT2002','RefSOrderID'),0)<=0)
ALTER TABLE OT2002 ADD RefSOrderID nvarchar(20) NULL
if(isnull(COL_LENGTH('OT2002','RefSTransactionID'),0)<=0)
ALTER TABLE OT2002 ADD RefSTransactionID nvarchar(50) NULL
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'ShipDate')
           Alter Table  OT2002 Add ShipDate DateTime Null
END
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'InheritTableID')
			Alter Table  OT2002 Add InheritTableID varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'InheritVoucherID')
			Alter Table  OT2002 Add InheritVoucherID varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'InheritTransactionID')
			Alter Table  OT2002 Add InheritTransactionID varchar(50) Null
END
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter01')
           Alter Table  OT2002 Add Parameter01 DECIMAL(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter02')
           Alter Table  OT2002 Add Parameter02 DECIMAL(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter03')
           Alter Table  OT2002 Add Parameter03 DECIMAL(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter04')
           Alter Table  OT2002 Add Parameter04 DECIMAL(28,8) NULL           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Parameter05')
           Alter Table  OT2002 Add Parameter05 DECIMAL(28,8) NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S01ID')
		ALTER TABLE OT2002 ADD S01ID VARCHAR(50) NULL
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S02ID')
		ALTER TABLE OT2002 ADD S02ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S03ID')
		ALTER TABLE OT2002 ADD S03ID VARCHAR(50) NULL
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S04ID')
		ALTER TABLE OT2002 ADD S04ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S05ID')
		ALTER TABLE OT2002 ADD S05ID VARCHAR(50) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S06ID')
		ALTER TABLE OT2002 ADD S06ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S07ID')
		ALTER TABLE OT2002 ADD S07ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S08ID')
		ALTER TABLE OT2002 ADD S08ID VARCHAR(50) NULL
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S09ID')
		ALTER TABLE OT2002 ADD S09ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S10ID')
		ALTER TABLE OT2002 ADD S10ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S11ID')
		ALTER TABLE OT2002 ADD S11ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S12ID')
		ALTER TABLE OT2002 ADD S12ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S13ID')
		ALTER TABLE OT2002 ADD S13ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S14ID')
		ALTER TABLE OT2002 ADD S14ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S15ID')
		ALTER TABLE OT2002 ADD S15ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S16ID')
		ALTER TABLE OT2002 ADD S16ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S17ID')
		ALTER TABLE OT2002 ADD S17ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S18ID')
		ALTER TABLE OT2002 ADD S18ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S19ID')
		ALTER TABLE OT2002 ADD S19ID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S20ID')
		ALTER TABLE OT2002 ADD S20ID VARCHAR(50) NULL
	END
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'OT2002'  and col.name = 'Ana06ID')
Alter Table  OT2002 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U') --Secoin Lưu thông tin mã phụ
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'ExtraID')
		ALTER TABLE OT2002 ADD ExtraID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'ReadyQuantity')
		ALTER TABLE OT2002 ADD ReadyQuantity DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'PlanPercent')
		ALTER TABLE OT2002 ADD PlanPercent DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'PlanQuantity')
		ALTER TABLE OT2002 ADD PlanQuantity DECIMAL(28,8) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME = 'OT2002' AND xtype = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S01ID')
	ALTER TABLE OT2002 DROP COLUMN S01ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S02ID')
	ALTER TABLE OT2002 DROP COLUMN S02ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S03ID')
	ALTER TABLE OT2002 DROP COLUMN S03ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S04ID')
	ALTER TABLE OT2002 DROP COLUMN S04ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S05ID')
	ALTER TABLE OT2002 DROP COLUMN S05ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S06ID')
	ALTER TABLE OT2002 DROP COLUMN S06ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S07ID')
	ALTER TABLE OT2002 DROP COLUMN S07ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S08ID')
	ALTER TABLE OT2002 DROP COLUMN S08ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S09ID')
	ALTER TABLE OT2002 DROP COLUMN S09ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S10ID')
	ALTER TABLE OT2002 DROP COLUMN S10ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S11ID')
	ALTER TABLE OT2002 DROP COLUMN S11ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S12ID')
	ALTER TABLE OT2002 DROP COLUMN S12ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S13ID')
	ALTER TABLE OT2002 DROP COLUMN S13ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S14ID')
	ALTER TABLE OT2002 DROP COLUMN S14ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S15ID')
	ALTER TABLE OT2002 DROP COLUMN S15ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S16ID')
	ALTER TABLE OT2002 DROP COLUMN S16ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S17ID')
	ALTER TABLE OT2002 DROP COLUMN S17ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S18ID')
	ALTER TABLE OT2002 DROP COLUMN S18ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S19ID')
	ALTER TABLE OT2002 DROP COLUMN S19ID
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'S20ID')
	ALTER TABLE OT2002 DROP COLUMN S20ID
END	

--- Modify on 11/01/2016 by Bảo Anh: Bổ sung các trường cho Angel
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
    BEGIN
		--- Check là hàng khuyến mãi
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'IsProInventoryID')
        ALTER TABLE OT2002 ADD IsProInventoryID tinyint NULL

		--- Số lượng xuất kho thực tế
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'SOActualQuantity')
        ALTER TABLE OT2002 ADD SOActualQuantity decimal(28,8) NULL

		--Mặt hàng chính khuyến mãi (lưu vết mặt hàng chính)
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'ParentInventoryID') 
		ALTER TABLE OT2002 ADD ParentInventoryID VARCHAR(50) NULL 
		
    END
--- Modify on 16/03/2016 by quốc tuấn: bổ sung thêm trường cho APP Mobile
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='AppInheritOrderID')
		ALTER TABLE OT2002 ADD AppInheritOrderID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ReAPK')
		ALTER TABLE OT2002 ADD ReAPK VARCHAR(50) NULL
	END

---- Modified by Tiểu Mai on 12/05/2016: Bổ sung cột DiscountSaleAmountDetail cho ANGEL
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='DiscountSaleAmountDetail')
		ALTER TABLE OT2002 ADD DiscountSaleAmountDetail DECIMAL(28,8) NULL
	END

---- Modified by Hải Long on 18/08/2016: Bổ sung các trường cho ABA
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		--Bổ sung cột KmNumber cho ABA
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='KmNumber')
		ALTER TABLE OT2002 ADD KmNumber DECIMAL(28,8) DEFAULT(0) NULL
		--Bổ sung 20 cột nvarchar21 -> nvarchar40 cho ABA
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar11')
		ALTER TABLE OT2002 ADD Varchar11 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar12')
		ALTER TABLE OT2002 ADD Varchar12 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar13')
		ALTER TABLE OT2002 ADD Varchar13 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar14')
		ALTER TABLE OT2002 ADD Varchar14 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar15')
		ALTER TABLE OT2002 ADD Varchar15 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar16')
		ALTER TABLE OT2002 ADD Varchar16 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar17')
		ALTER TABLE OT2002 ADD Varchar17 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar18')
		ALTER TABLE OT2002 ADD Varchar18 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar19')
		ALTER TABLE OT2002 ADD Varchar19 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar20')
		ALTER TABLE OT2002 ADD Varchar20 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar21')
		ALTER TABLE OT2002 ADD Varchar21 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar22')
		ALTER TABLE OT2002 ADD Varchar22 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar23')
		ALTER TABLE OT2002 ADD Varchar23 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar24')
		ALTER TABLE OT2002 ADD Varchar24 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar25')
		ALTER TABLE OT2002 ADD Varchar25 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar26')
		ALTER TABLE OT2002 ADD Varchar26 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar27')
		ALTER TABLE OT2002 ADD Varchar27 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar28')
		ALTER TABLE OT2002 ADD Varchar28 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar29')
		ALTER TABLE OT2002 ADD Varchar29 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Varchar30')
		ALTER TABLE OT2002 ADD Varchar30 NVARCHAR(100) NULL
	END

---- Modified by Tiểu Mai on 22/07/2016: Bổ sung cột cho ANGEL
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='EstimateQuantity')
		ALTER TABLE OT2002 ADD	EstimateQuantity DECIMAL(28,8) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='BeginQuantity')
		ALTER TABLE OT2002 ADD BeginQuantity DECIMAL(28,8) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='MinQuantity')
		ALTER TABLE OT2002 ADD MinQuantity DECIMAL(28,8) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='InventoryEndDate')
		ALTER TABLE OT2002 ADD InventoryEndDate DECIMAL(28,8) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='PlanDate')
		ALTER TABLE OT2002 ADD PlanDate DATETIME
			
	END
	
---- Modified by Bảo Thy on 31/08/2016: Bổ sung cột SOrderIDRecognition cho ANPHAT
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'SOrderIDRecognition')
        ALTER TABLE OT2002 ADD SOrderIDRecognition VARCHAR(50) NULL
    END
    
---- Modified by Hải Long on 05/09/2016: Bổ sung các trường cho ANPHAT
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Ana02IDAP')
		ALTER TABLE OT2002 ADD Ana02IDAP NVARCHAR(50) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ExportType')
		ALTER TABLE OT2002 ADD ExportType NVARCHAR(250) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='NotesAP')
		ALTER TABLE OT2002 ADD NotesAP NVARCHAR(250) NULL
	END    

---- Modified by Hải Long on 13/02/2017: Bổ sung 2 trường AdjustSOrderID, AdjustTransactionID khi kế thừa phiếu điều chỉnh đơn hàng sx (HHP)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='AdjustSOrderID')
		ALTER TABLE OT2002 ADD AdjustSOrderID NVARCHAR(50) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='AdjustTransactionID')
		ALTER TABLE OT2002 ADD AdjustTransactionID NVARCHAR(50) NULL
	END   		

---- Modified by Thị Phượng on 21/11/2016: Bổ sung cột IsBorrow cho Hoàng Trần check vật tư cho mượn
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='IsBorrow')
		ALTER TABLE OT2002 ADD IsBorrow tinyint NULL
	END

--- Modified by Tiểu Mai on 06/08/2018: Bổ sung cột Ngày giao hàng yêu cầu, ngày giao hàng tiến độ (ATTOM)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='RequireDate')
		ALTER TABLE OT2002 ADD RequireDate DATETIME NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ScheduleDate')
		ALTER TABLE OT2002 ADD ScheduleDate DATETIME NULL
	END

	--- Modified by Tra Giang on 06/11/2018: Bổ sung cột ObjectID, InventoryQuantity,PickingQuantity cho Nguyên Nguyên Phước 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectID_NNP')
		ALTER TABLE OT2002 ADD ObjectID_NNP NVARCHAR(50) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='InventoryQuantity')
		ALTER TABLE OT2002 ADD InventoryQuantity DECIMAL(28,8) NULL
	END
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='PickingQuantity')
		ALTER TABLE OT2002 ADD PickingQuantity DECIMAL(28,8) NULL
	END
	--- Modified by Tra Giang on 20/03/2019: Kiểm tra tồn tại ObjectID thì xóa 
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF  EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ObjectID')
		ALTER TABLE OT2002 DROP COLUMN ObjectID;
	END


	---- Modified by Như Hàn on 09/07/2019: Lưu vết hàng cho mượn CustomerIndex = 107 (VNF)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'IsInvenBorrow') 
   ALTER TABLE OT2002 ADD IsInvenBorrow BIT NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2002' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'APKMaster_9000')
    ALTER TABLE OT2002 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'ApproveLevel') 
	ALTER TABLE OT2002 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'ApprovingLevel') 
	ALTER TABLE OT2002 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'Status') 
	ALTER TABLE OT2002 ADD [Status] TINYINT NOT NULL DEFAULT(0)
END

---- Modified by Hoài Phong on 21/09/2020: Bổ sung trường PriceListID, để  chi tiết mã hàng mua với giá sỉ  hay giá lẻ trên App HH
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='PriceListID')
		ALTER TABLE OT2002 ADD PriceListID NVARCHAR(50) NULL		
	END 

---- Modified by Nhựt Trường on 11/08/2021: Bổ sung trường CurrencyID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='CurrencyID')
		ALTER TABLE OT2002 ADD CurrencyID NVARCHAR(50) NULL		
	END

---- Modified by Nhựt Trường on 11/08/2021: Bổ sung trường ExchangeRate
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ExchangeRate')
		ALTER TABLE OT2002 ADD ExchangeRate DECIMAL(28,8) NULL		
	END

---- Modified by Kiều Nga on 25/11/2021: Bổ sung trường InventoryGroupAnaTypeID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='InventoryGroupAnaTypeID')
		ALTER TABLE OT2002 ADD InventoryGroupAnaTypeID NVARCHAR(50) NULL	
	END

---- Modified by Kiều Nga on 08/12/2021: Bổ sung trường MinPrice
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='MinPrice')
		ALTER TABLE OT2002 ADD MinPrice DECIMAL(28,8) NULL	
	END


---- Modified by Minh Hiếu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='DeliveryAddressID')
		ALTER TABLE OT2002 ADD DeliveryAddressID NVARCHAR(50) NULL	

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='DeliveryDate')
		ALTER TABLE OT2002 ADD DeliveryDate DATETIME NULL	

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='Weight')
		ALTER TABLE OT2002 ADD Weight DECIMAL(28,8) DEFAULT(0)	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='DeliveryAddress')
		ALTER TABLE OT2002 ADD DeliveryAddress NVARCHAR(250) NULL	

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'APKMaster_2201')
		ALTER TABLE OT2002 ADD APKMaster_2201 NVARCHAR(50) NULL

	END

---- Modified by Hoài Bảo on 17/05/2022: Bổ sung trường DiscountAmount
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='DiscountAmount')
		ALTER TABLE OT2002 ADD DiscountAmount DECIMAL(28,8) NULL
	END

	--- Modify on 21/12/2022 by Thành Sang: Bổ sung các trường cho BBA
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2002' AND xtype = 'U')
    BEGIN
		--- Check là hàng khuyến mãi
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'IsChoosePro')
        ALTER TABLE OT2002 ADD IsChoosePro tinyint NULL
    END

---- Modified by Xuân Nguyên on 04/01/2023: Bổ sung trường ProductID,ProductName cho Thiên Nam
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ProductID')
		ALTER TABLE OT2002 ADD ProductID NVARCHAR(250) NULL	
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2002' AND col.name='ProductName')
		ALTER TABLE OT2002 ADD ProductName NVARCHAR(250) NULL	
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'nvarchar11')
    ALTER TABLE OT2002 ADD nvarchar11 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'nvarchar12')
    ALTER TABLE OT2002 ADD nvarchar12 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'nvarchar13')
    ALTER TABLE OT2002 ADD nvarchar13 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'nvarchar14')
    ALTER TABLE OT2002 ADD nvarchar14 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'nvarchar15')
    ALTER TABLE OT2002 ADD nvarchar15 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'nvarchar16')
    ALTER TABLE OT2002 ADD nvarchar16 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'nvarchar17')
    ALTER TABLE OT2002 ADD nvarchar17 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'nvarchar18')
    ALTER TABLE OT2002 ADD nvarchar18 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'nvarchar19')
    ALTER TABLE OT2002 ADD nvarchar19 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'nvarchar20')
    ALTER TABLE OT2002 ADD nvarchar20 nvarchar(50) NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2002' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'KITID')
    ALTER TABLE OT2002 ADD KITID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'KITQuantity')
    ALTER TABLE OT2002 ADD KITQuantity int NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'RetailPrice')
    ALTER TABLE OT2002 ADD RetailPrice decimal(28,8) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'WarehouseFee')
    ALTER TABLE OT2002 ADD WarehouseFee decimal(28,8) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'QuantityOfWarehouseRental')
    ALTER TABLE OT2002 ADD QuantityOfWarehouseRental DECIMAL(28,8) NULL
END
---------------- 13/09/2023 - Thanh Lượng: Bổ sung cột Specification ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'Specification')
BEGIN
	ALTER TABLE OT2002 ADD Specification NVARCHAR(500) NULL
END

----Modified by Viết Toàn on 30/11/2023
If Exists (Select * From sysobjects Where name = 'OT2002' and xtype ='U') 
BEGIN  

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'ConvertedUnitID')
		ALTER TABLE OT2002 ADD ConvertedUnitID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'OT2002' AND col.name = 'ConvertedRetailPrice')
		ALTER TABLE OT2002 ADD ConvertedRetailPrice DECIMAL(28, 8) NULL
END
