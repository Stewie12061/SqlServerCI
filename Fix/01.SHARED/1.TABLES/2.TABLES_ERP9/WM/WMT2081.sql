---- Create by Kim Thư on 31/07/2018 
---- Thông tin detail Nhập-Xuất-VCNB WM-9.0

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WMT2081]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[WMT2081]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [InventoryID] VARCHAR(50) NOT NULL,
  [UnitID] VARCHAR(50) NULL,
  [UnitPrice] DECIMAL(28,8) NULL,
  [ActualQuantity] DECIMAL(28,8) NULL,
  [ActualAmount] DECIMAL(28,8) NULL,
  [ConvertedUnitID] VARCHAR(50) NULL,
  [ConvertedPrice] DECIMAL(28,8) NULL,
  [ConvertedQuantity] DECIMAL(28,8) NULL,
  [ConvertedAmount] DECIMAL(28,8) NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [InheritTableID] VARCHAR(50) NULL,
  [InheritAPKMaster] VARCHAR(50) NULL,
  [InheritAPK] VARCHAR(50) NULL,
  [Ana01ID] NVARCHAR(50) NULL,
  [Ana02ID] NVARCHAR(50) NULL,
  [Ana03ID] NVARCHAR(50) NULL,
  [Ana04ID] NVARCHAR(50) NULL,
  [Ana05ID] NVARCHAR(50) NULL,
  [Ana06ID] NVARCHAR(50) NULL,
  [Ana07ID] NVARCHAR(50) NULL,
  [Ana08ID] NVARCHAR(50) NULL,
  [Ana09ID] NVARCHAR(50) NULL,
  [Ana10ID] NVARCHAR(50) NULL,
  [Parameter01] DECIMAL(28,8) NULL,
  [Parameter02] DECIMAL(28,8) NULL,
  [Parameter03] DECIMAL(28,8) NULL,
  [Parameter04] DECIMAL(28,8) NULL,
  [Parameter05] DECIMAL(28,8) NULL,
  [Notes] NVARCHAR(250) NULL,
  [ConfirmStatus] TINYINT DEFAULT (0) NULL,
  [ConfirmDate] DATETIME NULL,
  [AWBNo] VARCHAR(50) NULL,
  [OrderNo] VARCHAR(50) NULL, --Số đơn hàng
  [HAWBNo] VARCHAR(50) NULL, --Số giao nhận
  [ERP8VoucherID] VARCHAR(50) NULL
CONSTRAINT [PK_WMT2081] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WMT2081' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'WMT2081' AND col.name = 'ConfirmStatus')
    ALTER TABLE WMT2081 ADD ConfirmStatus TINYINT DEFAULT (0) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'WMT2081' AND col.name = 'ConfirmDate')
    ALTER TABLE WMT2081 ADD ConfirmDate DATETIME NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'WMT2081' AND col.name = 'OrderNo')
    ALTER TABLE WMT2081 ADD OrderNo VARCHAR(50) NULL
END


