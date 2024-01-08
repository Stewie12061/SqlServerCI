-- <Summary>
---- 
-- <History>
---- Create on 23/09/2011 by Lê Thị Thu Hiền
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on 15/06/2015 by Hoàng vũ: Bổ sung thêm trường OrderTypeID dùng để phân biệt đơn hàng bán và đơn hàng điều chỉnh (Khách hàng secoin)
---- Modified on26/06/2015 by Lê Thị Hạnh: Bổ sung ImpactLevel, duyệt đơn hàng 2 cấp cho đơn hàng bán ---- <Example>
---- Modified on 15/06/2015 by Hoàng vũ: Bổ sung thêm trường ConfirmDate,ConfirmUserID , RouteID, IsInvoice, ghi nhận thời gian duyệt, Tuyến giao hàng, Ghi chú lấy từ đoiố tượng qua đơn hàng (Khách hàng Hoàng Trần)
---- Modified on 22/12/2015 by Tiểu Mai: Bổ sung trường InheritApportionID (đính bộ định mức theo quy cách cho ĐHSX)
---- Modified on 04/01/2016 by Tieu Mai: Bo sung truong DiscountSalesAmount
---- Modified on 18/01/2016 by Tieu Mai: Bo sung truong DiscountPercentSOrder, DiscountAmountSOrder
---- Modified on 05/05/2016 by Tiểu Mai: Bổ sung trường ShipAmount
---- Modified on 09/05/2019 by Kim Thư: Bổ sung RefNo01, RefNo02 (Song Bình)
---- Modified by Tiểu Mai on 06/08/2018: Bổ sung trường IsWholeSale (bán sỉ/lẻ) cho ATTOM (CustomizeIndex = 98)
---- Modified by Tiểu Mai on 06/08/2018: Bổ sung trường IsObjectConfirm,NoteConfirm,DateConfirm cho ATTOM (CustomizeIndex = 98)
---- Modified on 13/12/2018 by Tra Giang: Bổ sung trường ProductDate (ngày sản xuất) cho CustormerIndex =104 (NNP)
---- Modified on 04/03/2019 by Tra Giang: Bỏ NOT NULL các trường RelatedToTypeID, IsWholeSale
---- Modified on 08/12/2020 by Đức Thông: Bổ sung số chứng từ trên APP (customize SAVI)
---- Modified on 22/09/2020 by Đức Thông: Sửa lại kiểu dữ liệu của số chứng từ trên APP (datetime --> nvarchar(50))
--- Modified by Đoan Duy on 14/05/2021: Bổ sung cột ReceiveAmount, IsReceiveAmount
--- Modified by Xuân Nguyên on 23/11/2021: Sửa độ dài cột Contact thành 250
--- Modified by Minh Hiếu on 14/01/2022: Thêm cột ContactorID
--- Modified by Minh Hiếu on 09/02/2022: Sửa độ dài cột Notes thành 1000
--- Modified by Hoài Thanh on 28/06/2022: Bổ sung trường Longitude, Latitude
--- Modified by Hoàng Long on 10/11/2023: Bổ sung trường PONumber
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT2001]') AND type in (N'U'))
CREATE TABLE [dbo].[OT2001](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](3) NOT NULL,
	[SOrderID] [nvarchar](50) NOT NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherNoApp] [nvarchar](50) NULL,
	[OrderDate] [datetime] NULL,
	[ContractNo] [nvarchar](50) NULL,
	[ContractDate] [datetime] NULL,
	[ClassifyID] [nvarchar](50) NULL,
	[OrderType] [tinyint] NOT NULL,
	[ObjectID] [nvarchar](50) NULL,
	[DeliveryAddress] [nvarchar](250) NULL,
	[Notes] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[OrderStatus] [tinyint] NOT NULL,
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
	[IsConfirm] [tinyint] NOT NULL,
	[DescriptionConfirm] [nvarchar](250) NULL,
	[PeriodID] [nvarchar](50) NULL,
	[ContactorID] [nvarchar](50) NULL,
 CONSTRAINT [PK_OT2001] PRIMARY KEY NONCLUSTERED 
(
	[SOrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OT2001_OrderType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT2001] ADD CONSTRAINT [DF_OT2001_OrderType] DEFAULT ((0)) FOR [OrderType]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OT2001_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT2001] ADD CONSTRAINT [DF_OT2001_Disabled] DEFAULT ((0)) FOR [Disabled]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OT2001_OrderStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT2001] ADD CONSTRAINT [DF_OT2001_OrderStatus] DEFAULT ((0)) FOR [OrderStatus]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__OT2001__IsConfir__7884A6CB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT2001] ADD CONSTRAINT [DF__OT2001__IsConfir__7884A6CB] DEFAULT ((0)) FOR [IsConfirm]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'OT2001' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2001'  and col.name = 'SalesMan2ID')
           Alter Table  OT2001 Add SalesMan2ID nvarchar(50) Null
End 
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype ='U') 
BEGIN
    IF EXISTS 
    (
    SELECT * 
    FROM syscolumns col 
    INNER JOIN sysobjects tab ON col.id = tab.id 
    WHERE tab.name = 'OT2001' 
    AND col.name = 'InheritSOrderID'
    )
    ALTER TABLE OT2001
    ALTER COLUMN InheritSOrderID NVARCHAR(400) NULL
END
IF(ISNULL(COL_LENGTH('OT2001', 'PriceListID'), 0) <= 0)
	ALTER TABLE OT2001 ADD PriceListID NVARCHAR(50) NULL
If Exists (Select * From sysobjects Where name = 'OT2001' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2001'  and col.name = 'IsPrinted')
           Alter Table  OT2001 Add IsPrinted tinyint  Null Default(0)           
           --- Sinolife:Bổ sung trường nhận biết đơn hàng có tính hoa hồng doanh số không (trường hợp đã được chiết khấu trên đơn hàng)
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2001'  and col.name = 'IsSalesCommission')
           Alter Table  OT2001 Add IsSalesCommission tinyint  Null Default(0)       
End 
If Exists (Select * From sysobjects Where name = 'OT2001' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2001'  and col.name = 'IsPrinted')
           Alter Table  OT2001 Add IsPrinted tinyint Not Null Default(0)
END
If Exists (Select * From sysobjects Where name = 'OT2001' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'OT2001'  and col.name = 'Ana06ID')
Alter Table  OT2001 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'OT2001' and xtype ='U') --Customize Secoin phân biệt đơn hàng bán chính và đơn hàng điều chỉnh
Begin 
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'OT2001'  and col.name = 'OrderTypeID')
	Alter Table  OT2001 Add OrderTypeID tinyint Null Default(0)
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2001' AND col.name='ImpactLevel')
		ALTER TABLE OT2001 ADD ImpactLevel TINYINT NULL
	END
---- Bổ sung IsConfirm01, ConfDescription01, IsConfirm02, ConfDescription02 cho duyệt đơn hàng 2 cấp[Customize LAVO]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2001' AND col.name='IsConfirm01')
		ALTER TABLE OT2001 ADD IsConfirm01 TINYINT DEFAULT(0) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2001' AND col.name='ConfDescription01')
		ALTER TABLE OT2001 ADD ConfDescription01 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2001' AND col.name='IsConfirm02')
		ALTER TABLE OT2001 ADD IsConfirm02 TINYINT DEFAULT(0) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2001' AND col.name='ConfDescription02')
		ALTER TABLE OT2001 ADD ConfDescription02 NVARCHAR(250) NULL
	END
---Bổ sung ConfirmDate (Thời gian duyệt đơn hàng)--CustomizeIndex = 51 (Hoàng Trần)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'ConfirmDate')
        ALTER TABLE OT2001 ADD ConfirmDate DATETIME NULL
    END
---Bổ sung ConfirmUserID (Người duyệt đơn hàng)--CustomizeIndex = 51 (Hoàng Trần)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'ConfirmUserID')
        ALTER TABLE OT2001 ADD ConfirmUserID VARCHAR(50) NULL
    END
---Bổ sung RouteID (Đơn hàng theo tuyến)--CustomizeIndex = 51 (Hoàng Trần)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'RouteID')
        ALTER TABLE OT2001 ADD RouteID NVARCHAR(50) NULL
    END	
---Bổ sung IsInvoice (Ghi chú lấy từ đối tượng khách hàng qua đơn hàng)--CustomizeIndex = 51 (Hoàng Trần)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'IsInvoice')
        ALTER TABLE OT2001 ADD IsInvoice TINYINT NULL
    END	
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'InheritApportionID')
        ALTER TABLE OT2001 ADD InheritApportionID VARCHAR(50) NULL
    END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'DiscountSalesAmount')
        ALTER TABLE OT2001 ADD DiscountSalesAmount Decimal(28,8) NULL
    END	 	
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'DiscountPercentSOrder')
        ALTER TABLE OT2001 ADD DiscountPercentSOrder Decimal(28,8) NULL, DiscountAmountSOrder Decimal(28,8) NULL
    END	 
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'ShipAmount')
        ALTER TABLE OT2001 ADD ShipAmount Decimal(28,8) NULL
    END	 
	
--Bổ sung cột IsAllocation cho ABA	   	    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
    BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2001' AND col.name='IsAllocation')
		ALTER TABLE OT2001 ADD IsAllocation TINYINT DEFAULT(0) NULL
    END	 
    
    
---- Modified by Hải Long on 13/02/2017: Bổ sung 2 trường AdjustSOrderID khi kế thừa phiếu điều chỉnh đơn hàng sx (HHP)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2001' AND col.name='AdjustSOrderID')
		ALTER TABLE OT2001 ADD AdjustSOrderID NVARCHAR(50) NULL
	END   		
--- Modified by Cao Thị Phượng on 31/05/2017: Bổ sung thêm trường RelatedToTypeID hỗ trợ SO trên web
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'RelatedToTypeID') 
   ALTER TABLE OT2001 ADD RelatedToTypeID TINYINT DEFAULT(7)  NULL 
END

---- Modified on 09/05/2019 by Kim Thư: Bổ sung RefNo01, RefNo02 (Song Bình)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'RefNo01') 
   ALTER TABLE OT2001 ADD RefNo01 NVARCHAR(MAX) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'RefNo02') 
   ALTER TABLE OT2001 ADD RefNo02 NVARCHAR(MAX) NULL 
END


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
BEGIN 
   IF  EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'RelatedToTypeID') 
   ALTER TABLE OT2001 Alter column RelatedToTypeID TINYINT NULL 
END



---- Modified by Tiểu Mai on 06/08/2018: Bổ sung trường IsWholeSale (bán sỉ/lẻ) cho ATTOM (CustomizeIndex = 98)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'IsWholeSale') 
	ALTER TABLE OT2001 ADD IsWholeSale TINYINT DEFAULT(0)  NULL 
   
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'IsWholeSale') 
	ALTER TABLE OT2001 Alter column IsWholeSale TINYINT NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'IsObjectConfirm') 
	ALTER TABLE OT2001 ADD IsObjectConfirm TINYINT NULL
   
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'NoteConfirm') 
	ALTER TABLE OT2001 ADD NoteConfirm NVARCHAR(250) NULL
   
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'DateConfirm') 
	ALTER TABLE OT2001 ADD DateConfirm DATETIME NULL
END
--- Modified by Tra Giang on 13/12/2018: Bổ sung thêm trường ProductDate ( ngày sản xuất) 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'ProductDate') 
   ALTER TABLE OT2001 ADD ProductDate DATETIME  NULL 
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'APKMaster_9000')
    ALTER TABLE OT2001 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'Status')
    ALTER TABLE OT2001 ADD [Status] tinyint NULL DEFAULT ((0))
END

--- Modified by Kiều Nga on 18/12/2019: Bổ sung thêm trường check ngày giao hàng
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'IsShipDate')
    ALTER TABLE OT2001 ADD [IsShipDate] tinyint NULL DEFAULT ((0))
END

--- Modified by Kiều Nga on 26/03/2020: Bổ sung thêm trường công việc
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'TaskID')
    ALTER TABLE OT2001 ADD [TaskID] Nvarchar(50) NULL 
END
--Trà Giang on 10/03/2020: Bổ sung trường Nhà cung cấp ở Đơn hàng sản xuất ( Customer 122 = Tân Hòa Lợi) 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'SupplierID') 
   ALTER TABLE OT2001 ADD SupplierID NVARCHAR(50)  NULL 
END

--- Modified by Kiều Nga on 09/07/2020: Bổ sung ngày tàu chạy customize MAITHU
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'ShipStartDate')
    ALTER TABLE OT2001 ADD [ShipStartDate] DATETIME NULL
END

--- Modified by Kiều Nga on 09/07/2020: Bổ sung ngày tàu chạy customize MAITHU
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'ShipStartDate')
    ALTER TABLE OT2001 ADD [ShipStartDate] DATETIME NULL
END

--- Modified by Đức Thông on 12/08/2020: Bổ sung số chứng từ trên APP (customize SAVI)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'VoucherNoApp')
    ALTER TABLE OT2001 ADD VoucherNoApp NVARCHAR(50) NULL
END

--- Modified by Đoan Duy on 14/05/2021: Bổ sung cột IsReceiveAmount
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'IsReceiveAmount')
    ALTER TABLE OT2001 ADD IsReceiveAmount TINYINT NULL
END

--- Modified by Đoan Duy on 14/05/2021: Bổ sung cột ReceiveAmount
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'ReceiveAmount')
    ALTER TABLE OT2001 ADD ReceiveAmount Decimal(28,8) NULL
END


--- Modified by Minh Hiếu on 14/01/2022: Bổ sung cột ContactorID
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'ContactorID')
    ALTER TABLE OT2001 ADD ContactorID NVARCHAR(50) NULL
END
--- Modified by Xuân Nguyên on 23/11/2021: Sửa độ dài cột Contact thành 250
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2001' AND xtype='U')
	BEGIN
		 IF EXISTS 
    (
    SELECT * 
    FROM syscolumns col 
    INNER JOIN sysobjects tab ON col.id = tab.id 
    WHERE tab.name = 'OT2001' 
    AND col.name = 'Contact'
    )
		ALTER TABLE OT2001 ALTER COLUMN [Contact] Nvarchar(250) NULL
	END

	--- Modified by Nhật Thanh on 29/12/2021: Bổ sung cột DealerID
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'DealerID')
    ALTER TABLE OT2001 ADD DealerID NVARCHAR(50) NULL
END


--- Modified by Minh Hiếu on 09/02/2022: Sửa độ dài cột Notes thành 1000
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2001' AND xtype='U')
	BEGIN
		 IF EXISTS 
    (
    SELECT * 
    FROM syscolumns col 
    INNER JOIN sysobjects tab ON col.id = tab.id 
    WHERE tab.name = 'OT2001' 
    AND col.name = 'Notes'
    )
		ALTER TABLE OT2001 ALTER COLUMN [Notes] Nvarchar(1000) NULL
	END

--  Modified by Minh Hiếu on
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'APKMaster_2201')
    ALTER TABLE OT2001 ADD APKMaster_2201 NVARCHAR(50) NULL
END

--- Modified by Hoài Thanh on 28/06/2022: Bổ sung 2 trường Longitude, Latitude
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2001' AND col.name='Longitude')
	ALTER TABLE OT2001 ADD Longitude DECIMAL(28,8) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2001' AND col.name='Latitude')
	ALTER TABLE OT2001 ADD Latitude DECIMAL(28,8) NULL 
END

--- Modified by Đức Tuyên on 21/04/2023: Bổ sung trường DeliveryAddressInfo riêng cho HIPC
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U')
BEGIN
	IF ((SELECT CustomerName FROM dbo.CustomerIndex) = 158 )
	BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2001' AND col.name='DeliveryAddressInfo')
	ALTER TABLE OT2001 ADD DeliveryAddressInfo NVARCHAR(250) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2001' AND col.name='Notes')
	ALTER TABLE OT2001 ALTER COLUMN Notes NVARCHAR(MAX) NULL 
	END
END

--- Modified by Thành Sang on 31/01/2023: Bổ sung trường IsComplete dùng cho BBL
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'IsComplete')
    ALTER TABLE OT2001 ADD IsComplete TINYINT NULL
END

--- Modified by Hoàng long on 10/11/2023: Bổ sung trường PONumber dùng cho PANGLOBE
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'PONumber')
    ALTER TABLE OT2001 ADD PONumber TINYINT NULL
END

--- Modified by Hoàng long on 17/11/2023: Bổ sung trường ManagerCostPaid dùng cho NCK
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'ManagerCostPaid')
    ALTER TABLE OT2001 ADD ManagerCostPaid  Nvarchar(1000) NULL
END

--- Modified by Kiều Nga on 21/12/2023: Bổ sung trường WareHouseID_HT (customize Hưng Thịnh)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2001' AND xtype = 'U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'WareHouseID')
    ALTER TABLE OT2001 DROP COLUMN WareHouseID

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'OT2001' AND col.name = 'WareHouseID_HT')
    ALTER TABLE OT2001 ADD WareHouseID_HT  NVARCHAR(50) NULL
END
