---- Create by Đinh Nhật Quang on 8/2/2022 11:38:58 AM
---- Chi tiết mặt hàng thông tin vận chuyển.

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OT3010]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OT3010]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] NVARCHAR(3) NOT NULL,
  [InvoiceNo] NVARCHAR(50) NULL,
  [BillOfLadingNo] NVARCHAR(50) NULL,
  [QuantityContainer] INT DEFAULT 0,
  [CostTowing] DECIMAL(28,8) NULL,
  [CostAmount] DECIMAL(28,8) NULL,
  [ContLiftingCosts] DECIMAL(28,8) NULL,
  [ContLiftingCostsAmount] DECIMAL(28,8) NULL,
  [ContUnloadingCosts] DECIMAL(28,8) NULL,
  [ContUnloadingCostsAmount] DECIMAL(28,8) NULL,
  [DiffCosts1] NVARCHAR(50) NULL,
  [DiffCosts1Amount] DECIMAL(28,8) NULL,
  [DiffCosts2] NVARCHAR(50) NULL,
  [DiffCosts2Amount] DECIMAL(28,8) NULL,
  [DiffCosts3] NVARCHAR(50) NULL,
  [DiffCosts3Amount] DECIMAL(28,8) NULL,
  [DescriptionCost] NVARCHAR(50) NULL,
  [POrderID] NVARCHAR(50) NULL,
  [CreateDate] [datetime] NULL,
  [CreateUserID] [varchar](50) NULL,
  [LastModifyUserID] [varchar](50) NULL,
  [LastModifyDate] [datetime] NULL,
  [DeleteFlag] [int] NULL
CONSTRAINT [PK_OT3010] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

