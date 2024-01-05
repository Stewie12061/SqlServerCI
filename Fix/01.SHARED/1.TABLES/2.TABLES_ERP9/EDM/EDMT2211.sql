---- Create by Khánh Đoan on 16/01/2020
----  Thông tin chi tiết thiết lập khoản phí đầu năm 
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2211]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2211]
(

  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [ReceiptTypeID] VARCHAR(50) NULL,			-- Khoản phí
  [PaymentMethod] VARCHAR(50) NULL,			-- Phương thức đóng
  [UnitPrice]      DECIMAL(28,8) NULL,      -- Đơn giá năm nay
  [IsCSVC]         TINYINT       NULL ,     -- Đóng CSVC
  [Amount]         DECIMAL(28,8) NULL, 		-- Tiền phí thực tế
  [Quantity]       DECIMAL(28,8) NULL,		-- Số lượng
  [PromotionID] VARCHAR(50) NULL,           -- Khuyến mãi
  [AmountPromotion] DECIMAL(28,8) NULL,		-- Thành tiền khuyến mãi
  [AmountTotalPromotion] DECIMAL(28,8) NULL,-- Thành tiên sau khuyến mãi
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2211] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


