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
  [POrderID] NVARCHAR(50) NOT NULL,
  [TransactionID] NVARCHAR(50) NOT NULL,
  [ShipDate] DATETIME NULL,
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
   ON col.id = tab.id WHERE tab.name = 'OT3007' AND col.name = 'VoucherNo') 
   ALTER TABLE OT3007 ADD VoucherNo NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3007' AND col.name = 'PaymentDate') 
   ALTER TABLE OT3007 ADD [PaymentDate]  DATETIME NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3007' AND col.name = 'FinishedProductionDate') 
   ALTER TABLE OT3007 ADD [FinishedProductionDate]  DATETIME NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3007' AND col.name = 'ImportPort') 
   ALTER TABLE OT3007 ADD [ImportPort] NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3007' AND col.name = 'ImportPortDate') 
   ALTER TABLE OT3007 ADD [ImportPortDate]  DATETIME NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3007' AND col.name = 'DeliveryAddress') 
   ALTER TABLE OT3007 ADD [DeliveryAddress] NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT3007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT3007' AND col.name = 'DeliveryAddressDate') 
   ALTER TABLE OT3007 ADD [DeliveryAddressDate] DATETIME NULL 
END


