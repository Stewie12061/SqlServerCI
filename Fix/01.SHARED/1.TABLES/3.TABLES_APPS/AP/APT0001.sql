IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[APT0001]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[APT0001]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NULL,
      [user_id] VARCHAR(50) NULL,
      [route_id] VARCHAR(50) NULL,
      [customer_id] VARCHAR(50) NULL,
      [order_id] VARCHAR(50) NULL,
      [order_no] VARCHAR(50) NULL,
      [order_created_date] DATETIME NULL,
      [discount_percent] DECIMAL(28,8) NULL,
      [discount_money] DECIMAL(28,8) NULL,
      [priority] TINYINT DEFAULT (0) NULL,
      [note] NVARCHAR(250) NULL,
      [product_id] VARCHAR(50) NULL,
      [quantity] INT NULL,
      [unit] VARCHAR(50) NULL,
      [mode] TINYINT DEFAULT (0) NULL,     
      [CreateDate] DATETIME NULL,
	  [OrderStatus] TINYINT NULL
    CONSTRAINT [PK_APT0001] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='APT0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='LastModifyDate')
		ALTER TABLE APT0001 ADD LastModifyDate DATETIME NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='Orders')
		ALTER TABLE APT0001 ADD Orders INT NULL

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='quantity')
		ALTER TABLE APT0001 ALTER COLUMN quantity DECIMAL(28,8) NULL
	END

	--- Modified by Tiểu Mai on 30/03/2016: Bổ sung 2 trường Longitude, Latitude
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='APT0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='Longitude')
		ALTER TABLE APT0001 ADD Longitude DECIMAL(28,8) NULL 

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='Latitude')
		ALTER TABLE APT0001 ADD Latitude DECIMAL(28,8) NULL 

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='UserIDCheck')
		ALTER TABLE APT0001 ADD UserIDCheck VARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='TimeOut')
		ALTER TABLE APT0001 ADD TimeOut DATETIME NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='PriceListID')
		ALTER TABLE APT0001 ADD PriceListID VARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='SalePrice')
		ALTER TABLE APT0001 ADD SalePrice DECIMAL(28,8) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='VATPercent')
		ALTER TABLE APT0001 ADD VATPercent DECIMAL(28,8) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='Address')
		ALTER TABLE APT0001 ADD [Address] NVARCHAR(500) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='DeliveryStatus')
		ALTER TABLE APT0001 ADD DeliveryStatus NVARCHAR(500) NULL

		--- Modified by Hoàng vũ on 28/03/2019: Bổ sung danh sách các trường sau để convert đơn hàng bán trên ERP8 sang APP mobile
		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'VoucherTypeID') 
		   ALTER TABLE APT0001 ADD VoucherTypeID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'InventoryCommonName') 
		   ALTER TABLE APT0001 ADD InventoryCommonName NVARCHAR(250) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'CurrencyID') 
		   ALTER TABLE APT0001 ADD CurrencyID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'ExchangeRate') 
		   ALTER TABLE APT0001 ADD ExchangeRate DECIMAL(28,8) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'VATObjectID') 
		   ALTER TABLE APT0001 ADD VATObjectID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'VATObjectName') 
		   ALTER TABLE APT0001 ADD VATObjectName NVARCHAR(250) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'Contact') 
		   ALTER TABLE APT0001 ADD Contact NVARCHAR(250) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'DeliveryAddress') 
		   ALTER TABLE APT0001 ADD DeliveryAddress NVARCHAR(250) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'ShipDate') 
		   ALTER TABLE APT0001 ADD ShipDate DATETIME NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'PaymentTermID') 
		   ALTER TABLE APT0001 ADD PaymentTermID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'PaymentID') 
		   ALTER TABLE APT0001 ADD PaymentID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'ObjectName') 
		   ALTER TABLE APT0001 ADD ObjectName NVARCHAR(250) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'VatNo') 
		   ALTER TABLE APT0001 ADD VatNo NVARCHAR(250) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'DueDate') 
		   ALTER TABLE APT0001 ADD DueDate DATETIME NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'ContactTel') 
		   ALTER TABLE APT0001 ADD ContactTel NVARCHAR(250) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'Transport') 
		   ALTER TABLE APT0001 ADD Transport NVARCHAR(250) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'ConvertedQuantity') 
		   ALTER TABLE APT0001 ADD ConvertedQuantity DECIMAL(28,8) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'ConvertedSalePrice') 
		   ALTER TABLE APT0001 ADD ConvertedSalePrice DECIMAL(28,8) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'OriginalAmount') 
		   ALTER TABLE APT0001 ADD OriginalAmount DECIMAL(28,8) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'ConvertedAmount') 
		   ALTER TABLE APT0001 ADD ConvertedAmount DECIMAL(28,8) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'DiscountPercent') 
		   ALTER TABLE APT0001 ADD DiscountPercent DECIMAL(28,8) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'DiscountOriginalAmount') 
		   ALTER TABLE APT0001 ADD DiscountOriginalAmount DECIMAL(28,8) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'DiscountConvertedAmount') 
		   ALTER TABLE APT0001 ADD DiscountConvertedAmount DECIMAL(28,8) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'VATGroupID') 
		   ALTER TABLE APT0001 ADD VATGroupID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'VATOriginalAmount') 
		   ALTER TABLE APT0001 ADD VATOriginalAmount DECIMAL(28,8) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'VATConvertedAmount') 
		   ALTER TABLE APT0001 ADD VATConvertedAmount DECIMAL(28,8) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'Ana01ID') 
		   ALTER TABLE APT0001 ADD Ana01ID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'Ana02ID') 
		   ALTER TABLE APT0001 ADD Ana02ID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'Ana03ID') 
		   ALTER TABLE APT0001 ADD Ana03ID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'Ana04ID') 
		   ALTER TABLE APT0001 ADD Ana04ID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'Ana05ID') 
		   ALTER TABLE APT0001 ADD Ana05ID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'Ana06ID') 
		   ALTER TABLE APT0001 ADD Ana06ID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'Ana07ID') 
		   ALTER TABLE APT0001 ADD Ana07ID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'Ana08ID') 
		   ALTER TABLE APT0001 ADD Ana08ID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'Ana09ID') 
		   ALTER TABLE APT0001 ADD Ana09ID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'Ana10ID') 
		   ALTER TABLE APT0001 ADD Ana10ID VARCHAR(50) NULL 
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'IsPicking') 
		   ALTER TABLE APT0001 ADD IsPicking TINYINT DEFAULT (0) NULL
		END

		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'WareHouseID') 
		   ALTER TABLE APT0001 ADD WareHouseID VARCHAR(50) NULL 
		END

		--Là hàng khuyến mãi
		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'IsProInventoryID') 
		   ALTER TABLE APT0001 ADD IsProInventoryID TINYINT NULL 
		END

		--Măt hàng chính được khuyến mãi
		IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0001' AND xtype = 'U')
		BEGIN 
		   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		   ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'ParentInventoryID') 
		   ALTER TABLE APT0001 ADD ParentInventoryID VARCHAR(50) NULL 
		END
		--- Modified by Hoàng vũ on 28/03/2019: Bổ sung danh sách các trường trên để convert đơn hàng bán trên ERP8 sang APP mobile

	END
	--- Modified by Đức Thông on 12/08/2020: Bổ sung 2 trường OrderStatus, VoucherNo
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='APT0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='OrderStatus')
		ALTER TABLE APT0001 ADD OrderStatus TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='VoucherNo')
		ALTER TABLE APT0001 ADD VoucherNo NVARCHAR(50) NULL
	END	

	--- Modified by Đoan Duy on 14/05/2021: Bổ sung cột IsReceiveAmount
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'APT0001' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'IsReceiveAmount')
		ALTER TABLE APT0001 ADD IsReceiveAmount TINYINT NULL
	END

	--- Modified by Đoan Duy on 14/05/2021: Bổ sung cột ReceiveAmount
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'APT0001' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'ReceiveAmount')
		ALTER TABLE APT0001 ADD ReceiveAmount Decimal(28,8) NULL
	END

	--- Modified by Thành Sang on 09/01/2023: Bổ sung 2 trường IsChoosePro, APKMaster_2201
	--- Modified by Thành Sang on 17/11/2023: Bổ sung thêm trường: S01ID, S02ID, S03ID, S04ID, AnaDivisionID, DeliveryType, SalePriceSID
	--- Modified by Thành Sang on 27/12/2023: Bổ sung thêm trường: LastModifyUserID
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='APT0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='IsChoosePro')
		ALTER TABLE APT0001 ADD IsChoosePro TINYINT NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'APKMaster_2201')
		ALTER TABLE APT0001 ADD APKMaster_2201 NVARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'S01ID')
		ALTER TABLE APT0001 ADD S01ID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'S02ID')
		ALTER TABLE APT0001 ADD S02ID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'S03ID')
		ALTER TABLE APT0001 ADD S03ID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'S04ID')
		ALTER TABLE APT0001 ADD S04ID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'AnaDivisionID')
		ALTER TABLE APT0001 ADD AnaDivisionID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'APT0001' AND col.name = 'DeliveryType')
		ALTER TABLE APT0001 ADD DeliveryType VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='SalePriceSID')
		ALTER TABLE APT0001 ADD SalePriceSID DECIMAL(28,8) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id=tab.id WHERE tab.name='APT0001' AND col.name='LastModifyUserID')
		ALTER TABLE APT0001 ADD LastModifyUserID NVARCHAR(50) NULL
	END	

