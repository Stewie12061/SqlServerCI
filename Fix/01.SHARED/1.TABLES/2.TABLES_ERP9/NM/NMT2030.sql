---- Create by Tra Giang on 16/08/2018 
---- Nghiệp Vụ: Cập nhật Phiếu điều tra dinh dưỡng ( master )

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[NMT2030]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[NMT2030]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [InvestigateVoucherNo] VARCHAR(50) NOT NULL, 
  [InvestigateVoucherDate] DATETIME NOT NULL,
  
   [MarketVoucherNo] VARCHAR(50) NOT NULL,
    [MenuVoucherNo] VARCHAR(50) NOT  NULL,
	[Description] NVARCHAR(250) NOT NULL,
	[TotalStudent] INT NULL,
	[RealityStudent] INT NOT  NULL,
	[QuotaUnitPrice] DECIMAL(28,8) NOT NULL,
	[RealityUnitPrice] DECIMAL(28,8) NOT NULL,
	[DifferenceAmount] DECIMAL(28,8) NOT NULL,

  [DeleteFlg] TINYINT Default 0 NOT NULL ,
  [TranMonth] int NOT NULL,
  [TranYear] int NOT NULL, 
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_NMT2030] PRIMARY KEY CLUSTERED
(
  [APK] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END





  