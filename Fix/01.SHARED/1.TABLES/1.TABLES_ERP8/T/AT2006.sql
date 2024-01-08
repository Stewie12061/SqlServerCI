-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Mỹ Tuyền
---- Modified on 07/01/2012 by Lê Thị Thu Hiền
---- Modified on 25/01/2013 by Bảo Anh
---- Modified on 31/10/2011 by Nguyễn Bình Minh
---- Modified on 29/01/2013 by Việt Khánh
---- Modified on 27/12/2013 by Bảo Anh
---- Modified on 24/06/2014 by Lê Thị Thu Hiền
---- Modified on 21/10/2015 by Kim Vu Bo sung 20 Columns SParameter khach hang
---- Modified on 20/01/2016 by Thị Phượng Bổ sung CashierID và CashierTime customize Hoàng Trần
---- Modified on 01/03/2016 by Tiểu Mai: Bổ sung IsProduct (Nhập từ sản xuất) cho Angel
---- Modified on 04/03/2016 by Hoàng vũ: Bổ sung IsDeposit (In thông tin cọc, nợ) cho phiếu điều phối Hoàng trần
---- Modified on 16/10/2020 by Hoài Phong: Bổ sung tăng thêm ký tự
---- Modified on 26/10/2020 by Trọng Kiên: Bổ sung cột IsLedger
---- Modified on 02/12/2020 by Hoài Phong: Bổ sung cột IsReceiving
---- Modified on 13/11/2021 by Đình hòa: Merger cột PaymentTime,TransferMoneyTime,DeliveryDate,IsAutoVoucherID từ fix dự án sang STD
---- Modified on 05/01/2023 by Thanh Lượng: [2023/01/IS/0017] - Bổ sung tăng thêm chiều dài cột RefNo01 từ 100 -> 250 
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT2006]') AND type in (N'U'))
CREATE TABLE [dbo].[AT2006](
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
	[RefNo01] [nvarchar](250) NULL,
	[RefNo02] [nvarchar](100) NULL,
	[RDAddress] [nvarchar](500) NULL,
	[ContactPerson] [nvarchar](500) NULL,
	[VATObjectName] [nvarchar](250) NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT2006] PRIMARY KEY NONCLUSTERED 
(	[DivisionID] ASC,
	[VoucherID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Add Columns
If Exists (Select * From sysobjects Where name = 'AT2006' and xtype ='U') 
Begin
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'MOrderID')
    Alter Table  AT2006 Add MOrderID nvarchar(50) Null 

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'ApportionID')
    Alter Table  AT2006 Add ApportionID nvarchar(50) Null

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT2006' AND col.name='IsVoucher')
	ALTER TABLE AT2006 ADD IsVoucher TINYINT DEFAULT(0) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT2006' AND col.name='IsGoodsFirstVoucher')
	ALTER TABLE AT2006 ADD IsGoodsFirstVoucher TINYINT DEFAULT(0) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name = 'AT2006' and col.name = 'IsGoodsRecycled') 
	Alter Table  AT2006 Add IsGoodsRecycled tinyint Null 

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'EVoucherID')
	Alter Table  AT2006 Add EVoucherID nvarchar(500) NULL

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'IsInheritWarranty')
    Alter Table  AT2006 Add IsInheritWarranty tinyint Null

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT2006' AND col.name='ImVoucherID')
	ALTER TABLE AT2006 ADD ImVoucherID VARCHAR(50) NULL

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'ReVoucherID')
    Alter Table  AT2006 Add ReVoucherID nvarchar(50) Null 

---- Add Columns Transport
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter01')
    Alter Table  AT2006 Add SParameter01 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter02')
    Alter Table  AT2006 Add SParameter02 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter03')
    Alter Table  AT2006 Add SParameter03 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter04')
    Alter Table  AT2006 Add SParameter04 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter05')
    Alter Table  AT2006 Add SParameter05 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter06')
    Alter Table  AT2006 Add SParameter06 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter07')
    Alter Table  AT2006 Add SParameter07 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter08')
    Alter Table  AT2006 Add SParameter08 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter09')
    Alter Table  AT2006 Add SParameter09 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter10')
    Alter Table  AT2006 Add SParameter10 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter11')
    Alter Table  AT2006 Add SParameter11 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter12')
    Alter Table  AT2006 Add SParameter12 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter13')
    Alter Table  AT2006 Add SParameter13 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter14')
    Alter Table  AT2006 Add SParameter14 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter15')
    Alter Table  AT2006 Add SParameter15 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter16')
    Alter Table  AT2006 Add SParameter16 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter17')
    Alter Table  AT2006 Add SParameter17 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter18')
    Alter Table  AT2006 Add SParameter18 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter19')
    Alter Table  AT2006 Add SParameter19 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT2006'  and col.name = 'SParameter20')
    Alter Table  AT2006 Add SParameter20 nvarchar(250) Null
End
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2006_TableID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2006] ADD  CONSTRAINT [DF_AT2006_TableID]  DEFAULT ('AT2006') FOR [TableID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2006_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2006] ADD  CONSTRAINT [DF_AT2006_Status]  DEFAULT ((0)) FOR [Status]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2006_IsGoodsRecycled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2006] ADD  CONSTRAINT DF_AT2006_IsGoodsRecycled  DEFAULT ((0)) FOR IsGoodsRecycled
END

--CustomizeIndex = 51 (Hoàng Trần)--
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U') --Tuyến giao hàng
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'RouteID')
        ALTER TABLE AT2006 ADD RouteID VARCHAR(50) NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--	
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')--Xác nhân thời gian về
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'InTime')
        ALTER TABLE AT2006 ADD InTime DATETIME NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--	
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')--Xác nhận thời gian đi
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'OutTime')
        ALTER TABLE AT2006 ADD OutTime DATETIME NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--	
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')--Nhân viên giao hàng
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'DeliveryEmployeeID')
        ALTER TABLE AT2006 ADD DeliveryEmployeeID VARCHAR(50) NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--	
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')--Trạng thái hoàn tất phiếu điều phối
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'DeliveryStatus')
        ALTER TABLE AT2006 ADD DeliveryStatus TINYINT NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--	
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')--Phiếu nhập, phiếu xuất, phiếu chuyển kho (Phiếu điều phối) lập trên web hay ứng dụng: 0=Ứng dụng; 1=Web
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsWeb')
        ALTER TABLE AT2006 ADD IsWeb TINYINT NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U') --Nhân viên thủ quỹ xác nhận
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
			ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'CashierID')
			ALTER TABLE AT2006 ADD CashierID VARCHAR(50) NULL
	END
--CustomizeIndex = 51 (Hoàng Trần)--
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U') --Thời gian thủ quỹ xác nhận
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'CashierTime')
        ALTER TABLE AT2006 ADD CashierTime DATETIME NULL
    END
--CustomizeIndex = 51 (Hoàng Trần)--	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')--in thông tin coc, nợ (Phiếu điều phối)
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsDeposit')
        ALTER TABLE AT2006 ADD IsDeposit TINYINT NULL
    END
--- Add columns by Tieu Mai: IsProduct(Nhap tu san xuat) - CustomizeIndex = 57 (ANGEL)
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsProduct')
        ALTER TABLE AT2006 ADD IsProduct TINYINT DEFAULT(0) NULL
    END
    
--- Add columns by Tieu Mai: Đối tượng vận chuyển - CustomizeIndex = 57 (ANGEL)
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'ObjectShipID')
        ALTER TABLE AT2006 ADD ObjectShipID NVARCHAR(50) NULL
    END

--- Add columns by Bảo Thy: CustomizeIndex = 70 (EIMSKIP)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'ContractID') 
   ALTER TABLE AT2006 ADD ContractID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'ContractNo') 
   ALTER TABLE AT2006 ADD ContractNo VARCHAR(50) NULL 

    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsCalCost') 
   ALTER TABLE AT2006 ADD IsCalCost TINYINT DEFAULT(0) NULL
END

-- Add columns by Phương Thảo: IsReturn: Nhập kho trả lại
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsReturn') 
   ALTER TABLE AT2006 ADD IsReturn TINYINT NULL 
END

-- Add columns by Hải Long: IsDelivery: Phiếu VCNB giao hàng (Bê Tông Long An)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsDelivery') 
   ALTER TABLE AT2006 ADD IsDelivery TINYINT NULL 
END
--add columns by Thị Phượng: Customize = 87 (OKIA) on 25/12/2017s
---BEGIN---
-- Đã Check in
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsInTime') 
   ALTER TABLE AT2006 ADD IsInTime TINYINT NULL 
   	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsNotUpdatePrice')
	ALTER TABLE AT2006 ADD IsNotUpdatePrice TINYINT DEFAULT(0) NULL
END
-- Xác nhận đi
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsOutTime') 
   ALTER TABLE AT2006 ADD IsOutTime TINYINT NULL 
END
-- Đã thu tiền
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsPayment') 
   ALTER TABLE AT2006 ADD IsPayment TINYINT NULL 
END
-- Đã chuyển khoản
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsTransferMoney') 
   ALTER TABLE AT2006 ADD IsTransferMoney TINYINT NULL 
END
-- Đã nhận tiền
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsReceiptMoney') 
   ALTER TABLE AT2006 ADD IsReceiptMoney TINYINT NULL 
END
-- Tăng ký tự 
-- ALTER COLUMN
-- ContactPerson
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'ContactPerson') 
   ALTER TABLE AT2006 ALTER COLUMN ContactPerson NVARCHAR(500) NULL 
END
---END---
--RDAddress
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'RDAddress') 
   ALTER TABLE AT2006 ALTER COLUMN RDAddress NVARCHAR(500) NULL 
END
-- Bổ sung cột IsLedger
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsLedger') 
   ALTER TABLE AT2006 ADD IsLedger TINYINT NULL DEFAULT 0
END

-- [Hoài Phong] [02/12/2020] Bổ sung cột IsReceiving
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsReceiving') 
   ALTER TABLE AT2006 ADD IsReceiving TINYINT NULL DEFAULT 0
END

---- Đình Hòa [13/01/2021] Merger fix từ dự án sang STD
----Lưu thêm thời gian [Đã thu tiền khách]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'PaymentTime') 
   ALTER TABLE AT2006 ADD PaymentTime DATETIME NULL 
END
/*===============================================END PaymentTime===============================================*/

--Lưu thêm thời gian [Đã chuyển khoản về công ty]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'TransferMoneyTime') 
   ALTER TABLE AT2006 ADD TransferMoneyTime DATETIME NULL 
END
/*===============================================END TransferMoneyTime===============================================*/ 

--- Add columns : Đối tượng vận chuyển - Thời gian gửi hàng cho ATTOM (dùng chung ObjectShipID với ANGEL, chỉ bổ sung DeliveryDate)
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'DeliveryDate')
        ALTER TABLE AT2006 ADD DeliveryDate DATETIME NULL
    END

--Add columns : Trường này mục đích là giúp cho người dùng phân biệt được phiếu này sinh ra tự động hay nhập bằng tay (nếu sinh ra tự động thì khi xóa chứng từ gốc sẽ xóa chứng từ tự dộng này, ngược lại thì không tự xóa)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsAutoVoucherID') 
   ALTER TABLE AT2006 ADD IsAutoVoucherID TINYINT NULL 
END
/*===============================================END IsAutoVoucherID===============================================*/ 
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsNotJoinPrice')
        ALTER TABLE AT2006 ADD IsNotJoinPrice TINYINT DEFAULT(0) NULL
    END

	--- Add columns by Nhặt Thanh on 14/12/2021: Bổ sung trường: InvoiceNo
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'InvoiceNo')
        ALTER TABLE AT2006 ADD InvoiceNo NVARCHAR(50)  NULL
    END

	--- Add columns by Nhặt Thanh on 22/02/2022: Bổ sung trường phương tiện vận chuyển
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'Transportation')
        ALTER TABLE AT2006 ADD Transportation NVARCHAR(50)  NULL
    END

--- Add columns by Hoài Thanh on 15/05/2023: Bổ sung trường IsAutoSellOut để check những phiếu nhập/xuất kho sinh tự động từ đơn hàng sell out
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'IsAutoSellOut') 
   ALTER TABLE AT2006 ADD IsAutoSellOut TINYINT NULL 
END
/*===============================================END IsAutoSellOut===============================================*/ 

---Modified by Hoàng Long on 13/09/2023: Bổ sung trường sô PO
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'PONumber') 
   ALTER TABLE AT2006 ADD PONumber Nvarchar(50) 
END

---Modified by Ngô Dũng on 20/12/2023: Bổ sung trường tài xế và xe (NKC)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'DriverID') 
   ALTER TABLE AT2006 ADD DriverID Nvarchar(500) 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2006' AND col.name = 'CarID') 
   ALTER TABLE AT2006 ADD CarID Nvarchar(500) 
END