---- Create by AS.0246 on 11/26/2021 3:11:44 PM
---- Thông Tin Vận Chuyển(Đơn Hàng Mua)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OT3007]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OT3007]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [InvoiceNo] NVARCHAR(50) NULL,
  [BillOfLadingNo] NVARCHAR(50) NOT NULL,
  [QuantityContainer] INT DEFAULT 0 NULL,
  [ClearanceExpirationDate] DATETIME NULL,
  [DepartureDate] DATETIME NULL,
  [ArrivalDate] DATETIME NULL,
  [DateFreeCont] NVARCHAR(100) NULL,
  [DateFreePlace] NVARCHAR(100) NULL,
  [CRMajorsID] NVARCHAR(50) NULL,
  [CRMajorsNo] NVARCHAR(50) NULL,
  [InspectionDate] DATETIME NULL,
  [LegalNo] NVARCHAR(50) NULL,
  [CertificateLegalNo] NVARCHAR(50) NULL,
  [TowingDate] DATETIME NULL,
  [POrderID] NVARCHAR(50) NULL,
  [TransactionID] NVARCHAR(50) NULL,
  [ShipDate] DATETIME NULL,
  [CertificateNo] NVARCHAR(50) NULL
CONSTRAINT [PK_OT3007] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [BillOfLadingNo]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3007' AND col.name = 'CertificateNo') 
   ALTER TABLE OT3007 ADD CertificateNo NVARCHAR(50) NULL
END

-- Minh Hiếu update on 18/04/2022 thêm cột loại tiền và tỉ giá niêm yết hải quan
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3007' AND col.name = 'CurrencyID') 
   ALTER TABLE OT3007 ADD CurrencyID NVARCHAR(50) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3007' AND col.name = 'ExchangeRateCustoms') 
   ALTER TABLE OT3007 ADD ExchangeRateCustoms decimal(28,8) default 0
END