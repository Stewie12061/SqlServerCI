---- Create by Kim Thư on 31/07/2018 
---- Thông tin master yêu cầu nhập - xuất - vcnb WM-9.0

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WMT2080]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[WMT2080]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [VoucherNo] NVARCHAR(50) NULL,
  [VoucherDate] DATETIME NULL,
  [VoucherTypeID] VARCHAR(50) NULL,
  [Description] NVARCHAR(250) NULL,
  [KindVoucherID] TINYINT DEFAULT (0) NULL,
  [ImWarehouseID] VARCHAR(50) NULL,
  [ExWarehouseID] VARCHAR(50) NULL,
  [InventoryTypeID] VARCHAR(50) NULL,
  [ObjectID] VARCHAR(50) NULL,
  [EmployeeID] VARCHAR(50) NULL,
  [Ref01] NVARCHAR(250) NULL,
  [Ref02] NVARCHAR(250) NULL,
  [ContactPerson] NVARCHAR(100) NULL,
  [DeliveryAddress] NVARCHAR(250) NULL,
  [IsAdjust] TINYINT DEFAULT (0) NULL,
  [IsConsignment] TINYINT DEFAULT (0) NULL,
  [InvoiceNo] VARCHAR(50) NULL,
  [InvoiceDate] DATETIME NULL,
  [CurrencyID] VARCHAR(5) NULL,
  [ExchangeRate] DECIMAL(28,8) NULL,
  [IsCheck] TINYINT NOT NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_WMT2080] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


/*===============================================END IsAdjust===============================================*/ 