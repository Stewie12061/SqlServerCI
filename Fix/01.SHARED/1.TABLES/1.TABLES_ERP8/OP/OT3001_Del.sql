﻿-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on 04/01/2016 by Tiểu Mai: Bổ sung duyệt 2 cấp IsConfirm01, IsConfirm02
---- Modified on 12/14/2018 by Như Hàn: Bổ sung trường tình trạng nhận hàng
---- Modified on 03/19/2018 by Như Hàn: Bổ sung APKMaster (= OOT9000.APK) master bảng duyệt, trạng thái
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT3001_Del]') AND type in (N'U'))
CREATE TABLE [dbo].[OT3001_Del](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[POrderID] [nvarchar](50) NOT NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[ClassifyID] [nvarchar](50) NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[OrderType] [tinyint] NOT NULL,
	[ObjectID] [nvarchar](50) NULL,
	[ReceivedAddress] [nvarchar](250) NULL,
	[Notes] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[OrderStatus] [tinyint] NOT NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[OrderDate] [datetime] NULL,
	[Transport] [nvarchar](100) NULL,
	[PaymentID] [nvarchar](50) NULL,
	[ObjectName] [nvarchar](250) NULL,
	[VATNo] [nvarchar](50) NULL,
	[Address] [nvarchar](250) NULL,
	[ShipDate] [datetime] NULL,
	[ContractNo] [nvarchar](50) NULL,
	[ContractDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[Createdate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[RequestID] [nvarchar](500) NULL,
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
	[Varchar11] [nvarchar](100) NULL,
	[Varchar12] [nvarchar](100) NULL,
	[Varchar13] [nvarchar](100) NULL,
	[Varchar14] [nvarchar](100) NULL,
	[Varchar15] [nvarchar](100) NULL,
	[Varchar16] [nvarchar](100) NULL,
	[Varchar17] [nvarchar](100) NULL,
	[Varchar18] [nvarchar](100) NULL,
	[Varchar19] [nvarchar](100) NULL,
	[Varchar20] [nvarchar](100) NULL,
	[PaymentTermID] [nvarchar](100) NULL,
	[IsConfirm] [tinyint] NOT NULL,
	[DescriptionConfirm] [nvarchar](250) NULL,
 CONSTRAINT [PK_OT3001_Del] PRIMARY KEY NONCLUSTERED 
(
	[POrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OT3001_Del_OrderType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT3001_Del] ADD  CONSTRAINT [DF_OT3001_Del_OrderType]  DEFAULT ((0)) FOR [OrderType]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OT3001_Del_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT3001_Del] ADD  CONSTRAINT [DF_OT3001_Del_Disabled]  DEFAULT ((0)) FOR [Disabled]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OT3001_Del_OrderStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT3001_Del] ADD  CONSTRAINT [DF_OT3001_Del_OrderStatus]  DEFAULT ((0)) FOR [OrderStatus]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__OT3001_Del__IsConfir__7A6CEF3D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT3001_Del] ADD  CONSTRAINT [DF__OT3001_Del__IsConfir__7A6CEF3D]  DEFAULT ((0)) FOR [IsConfirm]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'OT3001_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3001_Del'  and col.name = 'KindVoucherID')
           Alter Table  OT3001_Del Add KindVoucherID tinyint Not Null Default(0)
End 
If Exists (Select * From sysobjects Where name = 'OT3001_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3001_Del'  and col.name = 'DeliveryDate')
           Alter Table  OT3001_Del Add DeliveryDate DateTime Null
END
If Exists (Select * From sysobjects Where name = 'OT3001_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3001_Del'  and col.name = 'SOrderID')
           Alter Table  OT3001_Del Add SOrderID nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT3001_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3001_Del'  and col.name = 'IsPrinted')
           Alter Table  OT3001_Del Add IsPrinted tinyint Not Null Default(0)
End 
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT3001_Del' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT3001_Del' AND col.name = 'PriceListID')
    ALTER TABLE OT3001_Del ADD PriceListID NVARCHAR(50) NULL
END 
If Exists (Select * From sysobjects Where name = 'OT3001_Del' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT3001_Del'  and col.name = 'IsPrinted')
           Alter Table  OT3001_Del Add IsPrinted tinyint  Null Default(0)
End 
If Exists (Select * From sysobjects Where name = 'OT3001_Del' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'OT3001_Del'  and col.name = 'Ana06ID')
Alter Table  OT3001_Del Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End

If Exists (Select * From sysobjects Where name = 'OT3001_Del' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'OT3001_Del'  and col.name = 'IsConfirm01')
Alter Table  OT3001_Del Add IsConfirm01 TINYINT DEFAULT(0) NULL,
						ConfDescription01 NVARCHAR(250) NULL,
						IsConfirm02 TINYINT DEFAULT(0) NULL,
						ConfDescription02 NVARCHAR(250) NULL
End
--Thị Phượng 02/08/2017 Bổ sung trường nhân viên mua hàng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3001_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3001_Del' AND col.name = 'PurchaseManID') 
   ALTER TABLE OT3001_Del ADD PurchaseManID VARCHAR(50) NULL 
END

/*===============================================END PurchaseManID===============================================*/ 
--Thị Phượng 02/08/2017 bổ sung trường đối tượng liên quan để ghi nhận lịch sử
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3001_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3001_Del' AND col.name = 'RelatedToTypeID') 
   ALTER TABLE OT3001_Del ADD RelatedToTypeID INT NULL 
END

/*===============================================END RelatedToTypeID===============================================*/ 

--Như Hàn 12/14/2018 bổ sung trường tình trạng nhận hàng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3001_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3001_Del' AND col.name = 'ReceivingStatus') 
   ALTER TABLE OT3001_Del ADD ReceivingStatus INT DEFAULT 0 NULL 
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT3001_Del' AND xtype = 'U') 
BEGIN
    IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT3001_Del' AND col.name = 'APKMaster')
    ALTER TABLE OT3001_Del DROP COLUMN APKMaster 

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT3001_Del' AND col.name = 'APKMaster_9000')
    ALTER TABLE OT3001_Del ADD APKMaster_9000 UNIQUEIDENTIFIER NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT3001_Del' AND col.name = 'Status') 
	ALTER TABLE OT3001_Del ADD Status TINYINT NOT NULL DEFAULT(0)

END
