---- Create by Đinh Nhật Quang on 8/2/2022 11:38:58 AM
---- Chi tiết mặt hàng thông tin vận chuyển.

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OT3008]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OT3008]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] NVARCHAR(3) NOT NULL,
  [TransactionID] NVARCHAR(50) NOT NULL,
  [POrderID] NVARCHAR(50) NULL,
  [InventoryID] NVARCHAR(50) NULL,
  [MethodID] NVARCHAR(50) NULL,
  [OrderQuantity] DECIMAL(28,8) NULL,
  [OriginalAmount] DECIMAL(28,8) NULL,
  [ConvertedAmount] DECIMAL(28,8) NULL,
  [PurchasePrice] DECIMAL(28,8) NULL,
  [VATPercent] DECIMAL(28,8) NULL,
  [VATConvertedAmount] DECIMAL(28,8) NULL,
  [DiscountPercent] DECIMAL(28,8) NULL,
  [DiscountConvertedAmount] DECIMAL(28,8) NULL,
  [DiscountOriginalAmount] DECIMAL(28,8) NULL,
  [VATOriginalAmount] DECIMAL(28,8) NULL,
  [Orders] INT NULL,
  [Description] NVARCHAR(250) NULL,
  [AdjustQuantity] DECIMAL(28,8) NULL,
  [InventoryCommonName] NVARCHAR(250) NULL,
  [UnitID] NVARCHAR(50) NULL,
  [IsPicking] DECIMAL(28,8) NULL,
  [WareHouseID] NVARCHAR(50) NULL,
  [Notes] NVARCHAR(250) NULL,
  [RefTransactionID] NVARCHAR(50) NULL,
  [ROrderID] NVARCHAR(50) NULL,
  [ConvertedQuantity] DECIMAL(28,8) NULL,
  [ImTaxPercent] DECIMAL(28,8) NULL,
  [ImTaxOriginalAmount] DECIMAL(28,8) NULL,
  [ImTaxConvertedAmount] DECIMAL(28,8) NULL,
  [ConvertedSalePrice] DECIMAL(28,8) NULL,
  [BillOfLadingNo] NVARCHAR(50) NULL,
  [DescriptionCost] NVARCHAR(MAX) NULL,
  [ImportAndExportDuties] INT NULL,
  [IExportDutiesConvertedAmount] INT NULL,
  [SafeguardingDuties] INT NULL,
  [SafeguardingDutiesConvertedAmount] INT NULL,
  [DifferentDuties] INT NULL,
  [DifferentDutiesConvertedAmount] INT NULL,
  [SumDuties] INT NULL,
  [ProductPrice] DECIMAL(28,8) NULL,
  [Specification] NVARCHAR(MAX) NULL,
  [Status] TINYINT DEFAULT (0) NOT NULL,
  [ShipDate] DATETIME NULL,
  [ContQuantity] DECIMAL(28,8) NULL,
  [CostTowing] DECIMAL(28,8) NULL,
  [CostOriginalAmount] DECIMAL(28,8) NULL,
  [CostConvertedAmount] DECIMAL(28,8) NULL
CONSTRAINT [PK_OT3008] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3008' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3008' AND col.name = 'ExpectedImportTax') 
   ALTER TABLE OT3008 ADD ExpectedImportTax DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3008' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3008' AND col.name = 'ExpectedSpecialConsumptionTax') 
   ALTER TABLE OT3008 ADD ExpectedSpecialConsumptionTax DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3008' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3008' AND col.name = 'ExpectedValueAddedTax') 
   ALTER TABLE OT3008 ADD ExpectedValueAddedTax DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3008' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3008' AND col.name = 'EstimatedTotalTax') 
   ALTER TABLE OT3008 ADD EstimatedTotalTax DECIMAL(28,8) NULL
END