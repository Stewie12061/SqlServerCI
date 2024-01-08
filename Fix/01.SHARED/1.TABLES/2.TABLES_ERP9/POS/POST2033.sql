---- Create by Tieumai on 6/11/2018 1:13:58 PM
---- Lưu thông tin chung khi chốt ca bán hàng

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POST2033]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POST2033]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [ShopID] NVARCHAR(50) NOT NULL,
  [ShiftID] NVARCHAR(50) NOT NULL,
  [TranMonth] INT NOT NULL,
  [TranYear] INT NOT NULL,
  [ShiftDate] DATETIME NOT NULL,
  [IsLockShift] TINYINT DEFAULT (0) NOT NULL,
  [OpenTime] DATETIME NULL,
  [CloseTime] DATETIME NULL,
  [CreateUserID] NVARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] NVARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [BeginAmount] DECIMAL(28,8) NULL,
  [CloseAmount] DECIMAL(28,8) NULL,
  [SysInvoiceNumber] DECIMAL(28,8) NULL,
  [SystemAmount] DECIMAL(28,8) NULL,
  [SysTransferAmount] DECIMAL(28,8) NULL,
  [SysCreditAmount] DECIMAL(28,8) NULL,
  [SysDebitAmount] DECIMAL(28,8) NULL,
  [SysDebitTransferAmount] DECIMAL(28,8) NULL,
  [SysBookAmount] DECIMAL(28,8) NULL,
  [SysBookTransferAmount] DECIMAL(28,8) NULL,
  [RealAmount] DECIMAL(28,8) NULL,
  [DeviationAmount] DECIMAL(28,8) NULL,
  [HandoverAmount] DECIMAL(28,8) NULL,
  [IsHandoverType] TINYINT DEFAULT (0) NOT NULL,
  [CardStubsNumber] DECIMAL(28,8) NULL,
  [VoucherStubsNumber] DECIMAL(28,8) NULL,
  [InvoiceNumber] DECIMAL(28,8) NULL,
  [EmployeeID1] NVARCHAR(50) NULL,
  [EmployeeID2] NVARCHAR(50) NULL,
  [Description] NVARCHAR(250) NULL,
  [ReAPK] NVARCHAR(500) NULL
CONSTRAINT [PK_POST2033] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [ShopID],
  [ShiftID],
  [ShiftDate]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
