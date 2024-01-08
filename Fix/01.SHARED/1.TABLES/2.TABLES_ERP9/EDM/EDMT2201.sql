---- Create by Khánh Đoan on 16/12/2019
---- Nghiệp vụ Thay đổi mức đóng phí Detail
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2201]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2201]
(

  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER  NOT NULL,
  [ReceiptTypeID] VARCHAR(50) NULL,			-- Khoản phí
  [CurrentPaymentMethod] VARCHAR(50) NULL,  -- Phương thức đóng hiện tại
  [AmountOld] DECIMAL(28,8) NULL,		    -- Mức đóng hiện tại
  [PaymentMethod] VARCHAR(50) NULL,			-- Phương thức đóng
  [Quantity] DECIMAL(28,8) NULL,			-- Số lượng
  [AmountPromotion] DECIMAL(28,8) NULL,		-- Thành tiền khuyến mãi
  [AmountTotalPromotion] DECIMAL(28,8) NULL,-- Thành tiền sau khuyến mãi
  [AmountReceived] DECIMAL(28,8) NULL,		-- Số tiền phải thu kế thừa xuống 8 
  [UnitPrice] DECIMAL(28,8) NULL,			-- Đơn giá
  [Amount]	DECIMAL(28,8) NULL,				-- Mức đóng mới/ Tiền  phí thực tế
  [IsCSVC] TINYINT DEFAULT (0) NULL,        
  [IsNew] TINYINT DEFAULT (0) NULL,         -- Check đóng phí mới hoàn toàn 
  [AmountReserve]	DECIMAL(28,8) NULL,		-- Số tiền bảo lưu
  [FromDate] DATETIME NULL,					-- Từ ngày của 1 gói phí
  [ToDate] DATETIME NULL,					-- Đến ngày của 1 gói phí
  [OldFromDate] DATETIME NULL,	            -- Từ ngày gói cũ 
  [OldToDate] DATETIME NULL,                -- Đến ngày gói cũ 
  [IsDisabled] TINYINT DEFAULT (0) NULL,    -- Cột hiển thị hay không hiển thị trên màn hình 
  [DeleteFlg] TINYINT DEFAULT (0) NULL,		-- 0: Dữ liệu hiển thị, 1: Dữ liệu đã xóa, 2: Dữ liệu ngầm
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2201] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END



------Modified by Lương Mỹ on 18/03/2020: Bổ sung cột lưu kế thừa
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2201' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2201' AND col.name = 'InheritTableID') 
   ALTER TABLE EDMT2201 ADD InheritTableID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2201' AND col.name = 'InheritTransactionID') 
   ALTER TABLE EDMT2201 ADD InheritTransactionID VARCHAR(50) NULL



END 


 