---- Create by Nguyễn Hoàng Bảo Thy on 1/10/2017 2:57:46 PM
---- Update by Huỳnh Thử on 25/07/2020 -- Fix lỗi chạy tool run all Fix
---- Detail chi phí nhập/xuất kho

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WT0098]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[WT0098]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [TransactionID] VARCHAR(50) NOT NULL,
  [VoucherID] VARCHAR(50) NOT NULL,
  [InventoryID] VARCHAR(50) NULL,
  [CostID] VARCHAR(50) NOT NULL,
  [CostUnitPrice] DECIMAL(28,8) NULL,
  [ConvertCoefficient] DECIMAL(28,8) NULL,
  [Quantity] DECIMAL(28,8) NULL,
  [ConvertQuantity] DECIMAL(28,8) NULL,
  [OriginalAmount] DECIMAL(28,8) NULL,
  [ConvertAmount] DECIMAL(28,8) NULL,
  [InheritVoucherID] VARCHAR(50) NULL,
  [ContractID] VARCHAR(50) NULL,
  [InheritTransactionID] VARCHAR(50) NULL
CONSTRAINT [PK_WT0098] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TransactionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0098' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'WT0098' AND col.name = 'InventoryID')
        ALTER TABLE WT0098 ADD InventoryID NVARCHAR(50) NULL
    END

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0098' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'WT0098' AND col.name = 'WareHouseID')
        ALTER TABLE WT0098 ADD WareHouseID NVARCHAR(50) NULL
    END

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0098' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'WT0098' AND col.name = 'UnitID')
        ALTER TABLE WT0098 ADD UnitID NVARCHAR(50) NULL
    END

