---- Create by Như Hàn on 26/03/2019
---- Thiết lập hệ thống PO

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POT0000]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POT0000]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherRequest] VARCHAR(50) NULL,
  [VoucherPriceQuote] VARCHAR(50) NULL,
  [VoucherDeliverySchedule] VARCHAR(50) NULL,
  [VoucherBookCount] VARCHAR(50) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_POT0000] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---- Add Loại CT Tiến độ nhận hàng
 IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
     ON col.id = tab.id WHERE tab.name = 'POT0000' AND col.name = 'VoucherDeliverySchedule')
	ALTER TABLE POT0000 ADD [VoucherDeliverySchedule] VARCHAR(50) NULL
	
	---- Loại CT Book cont đơn hàng xuất khẩu
 IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
     ON col.id = tab.id WHERE tab.name = 'POT0000' AND col.name = 'VoucherBookCont')
	ALTER TABLE POT0000 ADD [VoucherBookCont] VARCHAR(50) NULL

---- Modified on 29/07/2020 by Kiều Nga: Bổ sung trường VoucherPurchaseOrder (Loại CT Đơn hàng mua)
 IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
     ON col.id = tab.id WHERE tab.name = 'POT0000' AND col.name = 'VoucherPurchaseOrder')
	ALTER TABLE POT0000 ADD [VoucherPurchaseOrder] VARCHAR(50) NULL
