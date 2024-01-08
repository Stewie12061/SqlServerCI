---- Create by Hồng Thảo on 6/1/2020
---- Lưu deatil khoản phí của học sinh trong năm học 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2014]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2014]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [FeeID] VARCHAR(50) NULL ,
  [ReceiptTypeID] VARCHAR(50) NULL,			-- Khoản phí,
  [PaymentMethod] VARCHAR(50) NULL,  --- phương thức thanh toán 
  [UnitPrice] DECIMAL(28,8) NULL,  ----Đơn giá 
  [IsCSVC] TINYINT DEFAULT (0) NULL,
  [Quantity] INT NULL,              --số lượng 
  [Amount] DECIMAL(28,8) NULL,   ---- số tiền thực tế 
  [AmountPromotion] DECIMAL(28,8) NULL, ---Thành tiền khuyến mãi 
  [AmountTotalPromotion] DECIMAL(28,8) NULL, ----Thành tiền sau khuyến mãi 
  [FromDate] DATETIME NULL,		                ---Ngày bắt đầu khoản phí 			
  [ToDate] DATETIME NULL,					    ---Ngày kết thúc khoản phí 
  [AmountEstimate] DECIMAL(28,8) NULL,          --- Số tiền lên dự thu 
  [InheritVoucherID] VARCHAR(50) NULL,          --- Lưu vết kế thừa từ đăng ký dịch vụ APK master 
  [InheritTransactionID] VARCHAR(50) NULL,      --- Lưu vết kế thừa đăng ký dịch vụ APKDetail 
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2014] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


 

 



