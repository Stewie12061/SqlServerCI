-- <Summary>
---- Bổ sung table lưu thông tin dữ liêu bị delete khỏi hệ thống
-- <History>
---- Create on 018/12/2019 by Trà Giang
---- Chuyến fix từ Dự án sang STD by Đình Hòa 13/01/2021

---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT2006_Del]') AND type in (N'U'))
CREATE TABLE [dbo].[AT2006_Del](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[TableID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[ObjectID] [nvarchar](50) NULL,
	[ProjectID] [nvarchar](50) NULL,
	[OrderID] [nvarchar](50) NULL,
	[BatchID] [nvarchar](50) NULL,
	[WareHouseID] [nvarchar](50) NULL,
	[ReDeTypeID] [nvarchar](50) NULL,
	[KindVoucherID] [int] NULL,
	[WareHouseID2] [nvarchar](50) NULL,
	[Status] [tinyint] NOT NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[RefNo01] [nvarchar](100) NULL,
	[RefNo02] [nvarchar](100) NULL,
	[RDAddress] [nvarchar](250) NULL,
	[ContactPerson] [nvarchar](100) NULL,
	[VATObjectName] [nvarchar](250) NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT2006_Del] PRIMARY KEY NONCLUSTERED 
(	[DivisionID] ASC,
	[VoucherID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Add Columns
If Exists (Select * From sysobjects Where name = 'AT2006_Del' and xtype ='U') 
Begin
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'MOrderID')
    Alter Table  AT2006_Del Add MOrderID nvarchar(50) Null 

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'ApportionID')
    Alter Table  AT2006_Del Add ApportionID nvarchar(50) Null

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT2006_Del' AND col.name='IsVoucher')
	ALTER TABLE AT2006_Del ADD IsVoucher TINYINT DEFAULT(0) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT2006_Del' AND col.name='IsGoodsFirstVoucher')
	ALTER TABLE AT2006_Del ADD IsGoodsFirstVoucher TINYINT DEFAULT(0) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name = 'AT2006_Del' and col.name = 'IsGoodsRecycled') 
	Alter Table  AT2006_Del Add IsGoodsRecycled tinyint Null 

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'EVoucherID')
	Alter Table  AT2006_Del Add EVoucherID nvarchar(500) NULL

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'IsInheritWarranty')
    Alter Table  AT2006_Del Add IsInheritWarranty tinyint Null

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT2006_Del' AND col.name='ImVoucherID')
	ALTER TABLE AT2006_Del ADD ImVoucherID VARCHAR(50) NULL

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'ReVoucherID')
    Alter Table  AT2006_Del Add ReVoucherID nvarchar(50) Null 

---- Add Columns Transport
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter01')
    Alter Table  AT2006_Del Add SParameter01 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter02')
    Alter Table  AT2006_Del Add SParameter02 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter03')
    Alter Table  AT2006_Del Add SParameter03 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter04')
    Alter Table  AT2006_Del Add SParameter04 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter05')
    Alter Table  AT2006_Del Add SParameter05 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter06')
    Alter Table  AT2006_Del Add SParameter06 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter07')
    Alter Table  AT2006_Del Add SParameter07 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter08')
    Alter Table  AT2006_Del Add SParameter08 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter09')
    Alter Table  AT2006_Del Add SParameter09 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter10')
    Alter Table  AT2006_Del Add SParameter10 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter11')
    Alter Table  AT2006_Del Add SParameter11 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter12')
    Alter Table  AT2006_Del Add SParameter12 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter13')
    Alter Table  AT2006_Del Add SParameter13 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter14')
    Alter Table  AT2006_Del Add SParameter14 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter15')
    Alter Table  AT2006_Del Add SParameter15 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter16')
    Alter Table  AT2006_Del Add SParameter16 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter17')
    Alter Table  AT2006_Del Add SParameter17 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter18')
    Alter Table  AT2006_Del Add SParameter18 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter19')
    Alter Table  AT2006_Del Add SParameter19 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006_Del'  and col.name = 'SParameter20')
    Alter Table  AT2006_Del Add SParameter20 nvarchar(250) Null
End
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2006_Del_TableID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2006_Del] ADD  CONSTRAINT [DF_AT2006_Del_TableID]  DEFAULT ('AT2006_Del') FOR [TableID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2006_Del_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2006_Del] ADD  CONSTRAINT [DF_AT2006_Del_Status]  DEFAULT ((0)) FOR [Status]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2006_Del_IsGoodsRecycled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2006_Del] ADD  CONSTRAINT DF_AT2006_Del_IsGoodsRecycled  DEFAULT ((0)) FOR IsGoodsRecycled
END

--CustomizeIndex = 51 (Hoàng Trần)--
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U') --Tuyến giao hàng
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'RouteID')
        ALTER TABLE AT2006_Del ADD RouteID VARCHAR(50) NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--	
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')--Xác nhân thời gian về
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'InTime')
        ALTER TABLE AT2006_Del ADD InTime DATETIME NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--	
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')--Xác nhận thời gian đi
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'OutTime')
        ALTER TABLE AT2006_Del ADD OutTime DATETIME NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--	
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')--Nhân viên giao hàng
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'DeliveryEmployeeID')
        ALTER TABLE AT2006_Del ADD DeliveryEmployeeID VARCHAR(50) NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--	
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')--Trạng thái hoàn tất phiếu điều phối
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'DeliveryStatus')
        ALTER TABLE AT2006_Del ADD DeliveryStatus TINYINT NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--	
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')--Phiếu nhập, phiếu xuất, phiếu chuyển kho (Phiếu điều phối) lập trên web hay ứng dụng: 0=Ứng dụng; 1=Web
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'IsWeb')
        ALTER TABLE AT2006_Del ADD IsWeb TINYINT NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U') --Nhân viên thủ quỹ xác nhận
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
			ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'CashierID')
			ALTER TABLE AT2006_Del ADD CashierID VARCHAR(50) NULL
	END
--CustomizeIndex = 51 (Hoàng Trần)--
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U') --Thời gian thủ quỹ xác nhận
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'CashierTime')
        ALTER TABLE AT2006_Del ADD CashierTime DATETIME NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')--in thông tin coc, nợ (Phiếu điều phối)
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'IsDeposit')
        ALTER TABLE AT2006_Del ADD IsDeposit TINYINT NULL
    END
--- Add columns by Tieu Mai: IsProduct(Nhap tu san xuat) - CustomizeIndex = 57 (ANGEL)
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'IsProduct')
        ALTER TABLE AT2006_Del ADD IsProduct TINYINT DEFAULT(0) NULL
    END
    
--- Add columns by Tieu Mai: Đối tượng vận chuyển - CustomizeIndex = 57 (ANGEL)
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'ObjectShipID')
        ALTER TABLE AT2006_Del ADD ObjectShipID NVARCHAR(50) NULL
    END

--- Add columns by Bảo Thy: CustomizeIndex = 70 (EIMSKIP)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'ContractID') 
   ALTER TABLE AT2006_Del ADD ContractID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'ContractNo') 
   ALTER TABLE AT2006_Del ADD ContractNo VARCHAR(50) NULL 

    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'IsCalCost') 
   ALTER TABLE AT2006_Del ADD IsCalCost TINYINT DEFAULT(0) NULL
END

-- Add columns by Phương Thảo: IsReturn: Nhập kho trả lại
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'IsReturn') 
   ALTER TABLE AT2006_Del ADD IsReturn TINYINT NULL 
END

-- Add columns by Hải Long: IsDelivery: Phiếu VCNB giao hàng (Bê Tông Long An)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'IsDelivery') 
   ALTER TABLE AT2006_Del ADD IsDelivery TINYINT NULL 
END
--add columns by Thị Phượng: Customize = 87 (OKIA) on 25/12/2017s
---BEGIN---
-- Đã Check in
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'IsInTime') 
   ALTER TABLE AT2006_Del ADD IsInTime TINYINT NULL 
END
-- Xác nhận đi
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'IsOutTime') 
   ALTER TABLE AT2006_Del ADD IsOutTime TINYINT NULL 
END
--Lưu thêm là thời gian [Đã thu tiền khách]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'IsPayment') 
   ALTER TABLE AT2006_Del ADD IsPayment TINYINT NULL 
END
-- Lưu thêm là thời gian [Đã chuyển khoản về công ty]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'IsTransferMoney') 
   ALTER TABLE AT2006_Del ADD IsTransferMoney TINYINT NULL 
END
-- Đã nhận tiền
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'IsReceiptMoney') 
   ALTER TABLE AT2006_Del ADD IsReceiptMoney TINYINT NULL 
END

----Lưu thêm thời gian [Đã thu tiền khách]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'PaymentTime') 
   ALTER TABLE AT2006_Del ADD PaymentTime DATETIME NULL 
END
/*===============================================END PaymentTime===============================================*/

--Lưu thêm thời gian [Đã chuyển khoản về công ty]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'TransferMoneyTime') 
   ALTER TABLE AT2006_Del ADD TransferMoneyTime DATETIME NULL 
END
/*===============================================END TransferMoneyTime===============================================*/ 

--- Add columns by Tieu Mai on 23/07/2018: Đối tượng vận chuyển - Thời gian gửi hàng cho ATTOM (dùng chung ObjectShipID với ANGEL, chỉ bổ sung DeliveryDate)
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'DeliveryDate')
        ALTER TABLE AT2006_Del ADD DeliveryDate DATETIME NULL
    END

--Add columns by Hoàng Vũ on  26/06/2019: Trường này mục đích là giúp cho người dùng phân biệt được phiếu này sinh ra tự động hay nhập bằng tay 
--(nếu sinh ra tự động thì khi xóa chứng từ gốc sẽ xóa chứng từ tự dộng này, ngược lại thì không tự xóa)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006_Del' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006_Del' AND col.name = 'IsAutoVoucherID') 
   ALTER TABLE AT2006_Del ADD IsAutoVoucherID TINYINT NULL 
END
/*===============================================END IsAutoVoucherID===============================================*/ 