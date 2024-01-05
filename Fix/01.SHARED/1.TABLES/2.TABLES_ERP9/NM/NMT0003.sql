---- Create by Tra Giang on 15/08/2018 
---- Thiết lập hệ thống (thông tin chung : loại chứng từ )

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[NMT0003]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[NMT0003]
(
    [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [DivisionID] VARCHAR(50) NOT NULL,
    [VoucherNo] VARCHAR(50)  NULL,
	[MenuDateVoucherNo] VARCHAR(50)  NULL,
    [MarketVoucherNo] VARCHAR(50)  NULL,
    [InvestigateVoucherNo] VARCHAR(50)  NULL,
    [MarketCostVoucherNo] VARCHAR(50)  NULL,
    [ThreeStepSuppliesVoucherNo] VARCHAR(50)  NULL,
    [HealthVoucherNo] VARCHAR(50)  NULL,

  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_NMT0003] PRIMARY KEY CLUSTERED
(
  DivisionID,
  APK
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]

 END

 
