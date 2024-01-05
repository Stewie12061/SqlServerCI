---- Create by Khánh Đoan on 16/12/2019
---- Thông tin chi tiết Nghiệp vụ bảo lưu/ chuyển nhượng
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2153]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2153]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [ReceiptTypeID] VARCHAR(50) NULL,				-- Khoản  phí
  [PaymentMethod] VARCHAR(50) NULL,				-- Phương thức đóng
  [Amount] DECIMAL(28,8) NULL,					-- Tiền phí
  [AmountReceived] DECIMAL(28,8) NULL,			-- Số tiền đã thu ERP8 
  [AmountTransfer]	DECIMAL(28,8) NULL,			-- Số tiền chuyển nhượng
  [FromDate] DATETIME NULL,						-- Thời gian bắt đầu gói 
  [ToDate] DATETIME NULL,						-- Thời gian kết thúc gói
  [IsTransferMonth] TINYINT DEFAULT (0) NULL,	--- Cột nhận biết chuyển nhượng tháng 
  [MonthReserve] TINYINT DEFAULT (0) NULL,		--- Số tháng chuyển nhượng                         
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2153] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]

END


------Modified by Lương Mỹ on 26/3/2020: Bổ sung cột chuyển nhượng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2153' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2153' AND col.name = 'IsTransferMonth') 
   ALTER TABLE EDMT2153 ADD IsTransferMonth TINYINT DEFAULT (0) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2153' AND col.name = 'MonthReserve') 
   ALTER TABLE EDMT2153 ADD MonthReserve TINYINT DEFAULT (0) NULL
END 
