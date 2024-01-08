-- <Summary>
---- 
-- <History>
---- Create on 23/06/2021 by Đoàn Duy
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CCMT0001]') AND type in (N'U'))
CREATE TABLE [dbo].[CCMT0001](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](3) NOT NULL,
	[SOrderID] [bigint] NOT NULL IDENTITY(1,1),
	[VoucherTypeID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherNoApp] [nvarchar](50) NULL,
	[OrderDate] [datetime] NULL,
	[ContractNo] [nvarchar](50) NULL,
	[ContractDate] [datetime] NULL,
	[ClassifyID] [nvarchar](50) NULL,
	[OrderType] [tinyint] NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[DeliveryAddress] [nvarchar](250) NULL,
	[Notes] [nvarchar](250) NULL,
	[Disabled] [tinyint]  NULL,
	[OrderStatus] [tinyint]  NULL,
	[QuotationID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,	
	[EmployeeID] [nvarchar](50) NULL,
	[Transport] [nvarchar](250) NULL,
	[PaymentID] [nvarchar](50) NULL,
	[ObjectName] [nvarchar](250) NULL,
	[VatNo] [nvarchar](50) NULL,
	[Address] [nvarchar](250) NULL,
	[IsPeriod] [tinyint] NULL,
	[IsPlan] [tinyint] NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[SalesManID] [nvarchar](50) NULL,
	[ShipDate] [datetime] NULL,
	[InheritSOrderID] [nvarchar](50) NULL,
	[DueDate] [datetime] NULL,
	[PaymentTermID] [nvarchar](50) NULL,
	[FileType] [int] NULL,
	[Contact] [nvarchar](100) NULL,
	[VATObjectID] [nvarchar](50) NULL,
	[VATObjectName] [nvarchar](250) NULL,
	[IsInherit] [tinyint] NULL,
	[IsConfirm] [tinyint] NULL,
	[DescriptionConfirm] [nvarchar](250) NULL,
	[PeriodID] [nvarchar](50) NULL,
 CONSTRAINT [PK_CCMT0001] PRIMARY KEY NONCLUSTERED 
(
	[SOrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CCMT0001_OrderType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CCMT0001] ADD CONSTRAINT [DF_CCMT0001_OrderType] DEFAULT ((0)) FOR [OrderType]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CCMT0001_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CCMT0001] ADD CONSTRAINT [DF_CCMT0001_Disabled] DEFAULT ((0)) FOR [Disabled]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CCMT0001_OrderStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CCMT0001] ADD CONSTRAINT [DF_CCMT0001_OrderStatus] DEFAULT ((0)) FOR [OrderStatus]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__CCMT0001__IsConfir__7884A6CB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CCMT0001] ADD CONSTRAINT [DF__CCMT0001__IsConfir__7884A6CB] DEFAULT ((0)) FOR [IsConfirm]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'CCMT0001' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CCMT0001'  and col.name = 'SalesMan2ID')
           Alter Table  CCMT0001 Add SalesMan2ID nvarchar(50) Null
End 
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CCMT0001' AND xtype ='U') 
BEGIN
    IF EXISTS 
    (
    SELECT * 
    FROM syscolumns col 
    INNER JOIN sysobjects tab ON col.id = tab.id 
    WHERE tab.name = 'CCMT0001' 
    AND col.name = 'InheritSOrderID'
    )
    ALTER TABLE CCMT0001
    ALTER COLUMN InheritSOrderID NVARCHAR(400) NULL
END
IF(ISNULL(COL_LENGTH('CCMT0001', 'PriceListID'), 0) <= 0)
	ALTER TABLE CCMT0001 ADD PriceListID NVARCHAR(50) NULL
If Exists (Select * From sysobjects Where name = 'CCMT0001' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CCMT0001'  and col.name = 'IsPrinted')
           Alter Table  CCMT0001 Add IsPrinted tinyint  Null Default(0)           
           --- Sinolife:Bổ sung trường nhận biết đơn hàng có tính hoa hồng doanh số không (trường hợp đã được chiết khấu trên đơn hàng)
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CCMT0001'  and col.name = 'IsSalesCommission')
           Alter Table  CCMT0001 Add IsSalesCommission tinyint  Null Default(0)       
End 
If Exists (Select * From sysobjects Where name = 'CCMT0001' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CCMT0001'  and col.name = 'IsPrinted')
           Alter Table  CCMT0001 Add IsPrinted tinyint Null Default(0)
END
If Exists (Select * From sysobjects Where name = 'CCMT0001' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'CCMT0001'  and col.name = 'Ana06ID')
Alter Table  CCMT0001 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'CCMT0001' and xtype ='U') --Customize Secoin phân biệt đơn hàng bán chính và đơn hàng điều chỉnh
Begin 
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'CCMT0001'  and col.name = 'OrderTypeID')
	Alter Table  CCMT0001 Add OrderTypeID tinyint Null Default(0)
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='CCMT0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CCMT0001' AND col.name='ImpactLevel')
		ALTER TABLE CCMT0001 ADD ImpactLevel TINYINT NULL
	END
---- Bổ sung IsConfirm01, ConfDescription01, IsConfirm02, ConfDescription02 cho duyệt đơn hàng 2 cấp[Customize LAVO]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='CCMT0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CCMT0001' AND col.name='IsConfirm01')
		ALTER TABLE CCMT0001 ADD IsConfirm01 TINYINT DEFAULT(0) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='CCMT0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CCMT0001' AND col.name='ConfDescription01')
		ALTER TABLE CCMT0001 ADD ConfDescription01 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='CCMT0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CCMT0001' AND col.name='IsConfirm02')
		ALTER TABLE CCMT0001 ADD IsConfirm02 TINYINT DEFAULT(0) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='CCMT0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CCMT0001' AND col.name='ConfDescription02')
		ALTER TABLE CCMT0001 ADD ConfDescription02 NVARCHAR(250) NULL
	END
---Bổ sung ConfirmDate (Thời gian duyệt đơn hàng)--CustomizeIndex = 51 (Hoàng Trần)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'ConfirmDate')
        ALTER TABLE CCMT0001 ADD ConfirmDate DATETIME NULL
    END
---Bổ sung ConfirmUserID (Người duyệt đơn hàng)--CustomizeIndex = 51 (Hoàng Trần)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'ConfirmUserID')
        ALTER TABLE CCMT0001 ADD ConfirmUserID VARCHAR(50) NULL
    END
---Bổ sung RouteID (Đơn hàng theo tuyến)--CustomizeIndex = 51 (Hoàng Trần)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'RouteID')
        ALTER TABLE CCMT0001 ADD RouteID NVARCHAR(50) NULL
    END	
---Bổ sung IsInvoice (Ghi chú lấy từ đối tượng khách hàng qua đơn hàng)--CustomizeIndex = 51 (Hoàng Trần)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'IsInvoice')
        ALTER TABLE CCMT0001 ADD IsInvoice TINYINT NULL
    END	
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'InheritApportionID')
        ALTER TABLE CCMT0001 ADD InheritApportionID VARCHAR(50) NULL
    END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'DiscountSalesAmount')
        ALTER TABLE CCMT0001 ADD DiscountSalesAmount Decimal(28,8) NULL
    END	 	
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'DiscountPercentSOrder')
        ALTER TABLE CCMT0001 ADD DiscountPercentSOrder Decimal(28,8) NULL, DiscountAmountSOrder Decimal(28,8) NULL
    END	 
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'ShipAmount')
        ALTER TABLE CCMT0001 ADD ShipAmount Decimal(28,8) NULL
    END	 
	
--Bổ sung cột IsAllocation cho ABA	   	    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
    BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CCMT0001' AND col.name='IsAllocation')
		ALTER TABLE CCMT0001 ADD IsAllocation TINYINT DEFAULT(0) NULL
    END	 
    
    
---- Modified by Hải Long on 13/02/2017: Bổ sung 2 trường AdjustSOrderID khi kế thừa phiếu điều chỉnh đơn hàng sx (HHP)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='CCMT0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CCMT0001' AND col.name='AdjustSOrderID')
		ALTER TABLE CCMT0001 ADD AdjustSOrderID NVARCHAR(50) NULL
	END   		
--- Modified by Cao Thị Phượng on 31/05/2017: Bổ sung thêm trường RelatedToTypeID hỗ trợ SO trên web
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'RelatedToTypeID') 
   ALTER TABLE CCMT0001 ADD RelatedToTypeID TINYINT DEFAULT(7)  NULL 
END

---- Modified on 09/05/2019 by Kim Thư: Bổ sung RefNo01, RefNo02 (Song Bình)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'RefNo01') 
   ALTER TABLE CCMT0001 ADD RefNo01 NVARCHAR(MAX) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'RefNo02') 
   ALTER TABLE CCMT0001 ADD RefNo02 NVARCHAR(MAX) NULL 
END


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
BEGIN 
   IF  EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'RelatedToTypeID') 
   ALTER TABLE CCMT0001 Alter column RelatedToTypeID TINYINT NULL 
END



---- Modified by Tiểu Mai on 06/08/2018: Bổ sung trường IsWholeSale (bán sỉ/lẻ) cho ATTOM (CustomizeIndex = 98)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'IsWholeSale') 
	ALTER TABLE CCMT0001 ADD IsWholeSale TINYINT DEFAULT(0)  NULL 
   
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'IsWholeSale') 
	ALTER TABLE CCMT0001 Alter column IsWholeSale TINYINT NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'IsObjectConfirm') 
	ALTER TABLE CCMT0001 ADD IsObjectConfirm TINYINT NULL
   
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'NoteConfirm') 
	ALTER TABLE CCMT0001 ADD NoteConfirm NVARCHAR(250) NULL
   
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'DateConfirm') 
	ALTER TABLE CCMT0001 ADD DateConfirm DATETIME NULL
END
--- Modified by Tra Giang on 13/12/2018: Bổ sung thêm trường ProductDate ( ngày sản xuất) 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'ProductDate') 
   ALTER TABLE CCMT0001 ADD ProductDate DATETIME  NULL 
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CCMT0001' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'APKMaster_9000')
    ALTER TABLE CCMT0001 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CCMT0001' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'Status')
    ALTER TABLE CCMT0001 ADD [Status] tinyint NULL DEFAULT ((0))
END

--- Modified by Kiều Nga on 18/12/2019: Bổ sung thêm trường check ngày giao hàng
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CCMT0001' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'IsShipDate')
    ALTER TABLE CCMT0001 ADD [IsShipDate] tinyint NULL DEFAULT ((0))
END

--- Modified by Kiều Nga on 26/03/2020: Bổ sung thêm trường công việc
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CCMT0001' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'TaskID')
    ALTER TABLE CCMT0001 ADD [TaskID] Nvarchar(50) NULL 
END
--Trà Giang on 10/03/2020: Bổ sung trường Nhà cung cấp ở Đơn hàng sản xuất ( Customer 122 = Tân Hòa Lợi) 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'SupplierID') 
   ALTER TABLE CCMT0001 ADD SupplierID NVARCHAR(50)  NULL 
END

--- Modified by Kiều Nga on 09/07/2020: Bổ sung ngày tàu chạy customize MAITHU
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CCMT0001' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'ShipStartDate')
    ALTER TABLE CCMT0001 ADD [ShipStartDate] DATETIME NULL
END

--- Modified by Kiều Nga on 09/07/2020: Bổ sung ngày tàu chạy customize MAITHU
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CCMT0001' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'ShipStartDate')
    ALTER TABLE CCMT0001 ADD [ShipStartDate] DATETIME NULL
END

--- Modified by Đức Thông on 12/08/2020: Bổ sung số chứng từ trên APP (customize SAVI)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CCMT0001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'VoucherNoApp')
    ALTER TABLE CCMT0001 ADD VoucherNoApp NVARCHAR(50) NULL
END

--- Modified by Đoan Duy on 14/05/2021: Bổ sung cột IsReceiveAmount
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CCMT0001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'IsReceiveAmount')
    ALTER TABLE CCMT0001 ADD IsReceiveAmount TINYINT NULL
END

--- Modified by Đoan Duy on 14/05/2021: Bổ sung cột ReceiveAmount
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CCMT0001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'ReceiveAmount')
    ALTER TABLE CCMT0001 ADD ReceiveAmount Decimal(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CCMT0001' AND xtype = 'U')
BEGIN 
   IF  EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CCMT0001' AND col.name = 'DivisionID') 
   ALTER TABLE CCMT0001 Alter column DivisionID NVARCHAR(50) NOT NULL 
END