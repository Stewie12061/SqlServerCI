---- Create by Khánh Đoan on 16/12/2019
---- Thông tin chi tiết Nghiệp vụ bảo lưu

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2151]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2151]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [ReceiptTypeID] VARCHAR(50) NULL,			-- Khoản  phí
  [PaymentMethod] VARCHAR(50) NULL,			-- Phương thức đóng
  [UnitPrice] DECIMAL(28,8) NULL,           -- Đơn giá 
  [Amount] DECIMAL(28,8) NULL,			    -- Tiền phí
  [AmountReceived] DECIMAL(28,8) NULL,		-- Số tiền phải thu kế thừa xuống 8 
  [AmountReserve]	DECIMAL(28,8) NULL,		-- Số tiền bảo lưu
  [TotalAmount]	DECIMAL(28,8) NULL,		    -- Tổng số tiền bảo lưu
  [MonthReserve] VARCHAR(50) NULL,          -- Số tháng bảo lưu 
  [FromDate] DATETIME NULL,                 -- Ngày bắt đầu gói đóng 
  [ToDate] DATETIME NULL,                   -- Ngày kết thúc gói đóng 
  [IsTransfer] TINYINT DEFAULT (0) NULL,	-- 1: Chuyển nhượng || 0: Trả tiền ngay ở dưới 8
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2151] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

 
 ------Modified by Lương Mỹ on 26/03/2020: Bổ sung lưu biểu phí
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2151' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2151' AND col.name = 'IsTransfer') 
   ALTER TABLE EDMT2151 ADD IsTransfer TINYINT DEFAULT (0) NULL

END 