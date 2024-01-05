---- Create by Xuân Hiển on 27/12/2019 10:27:31 AM
---- Nghiệp vụ Phiếu thông tin tư vấn Detail


IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2001]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2001]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [ReceiptTypeID] VARCHAR(50) NULL,   --Khoản phí 
  [PaymentMethod] VARCHAR(50) NULL,  --- phương thức thanh toán 
  [UnitPrice] DECIMAL(28,8) NULL,  ----Đơn giá 
  [IsCSVC] TINYINT DEFAULT (0) NULL, --CSVC
  [Quantity] INT NULL,              --số lượng 
  [Amount] DECIMAL(28,8) NULL,   ---- số tiền thực tế 
  [AmountPromotion] DECIMAL(28,8) NULL, ---Thành tiền khuyến mãi 
  [AmountTotalPromotion] DECIMAL(28,8) NULL, ----Thành tiền sau khuyến mãi 
  [FromDate] DATETIME NULL,                   ----Ngày bắt đầu gói 
  [ToDate] DATETIME NULL,                     ----Ngày kết thúc gói
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2001] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


 




