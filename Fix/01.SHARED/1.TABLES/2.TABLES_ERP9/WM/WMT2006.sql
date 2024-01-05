---- Create by Nguy?n Hoàng B?o Thy on 2/26/2018 8:31:45 AM
---- Modified by Kim Thư on 3/8/2018 - Bổ sung trường lưu check phiếu tự sinh khi duyệt phiếu yêu cầu
---- Thông tin master Nh?p-Xu?t-VC WM-9.0

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WMT2006]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[WMT2006]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [VoucherNo] NVARCHAR(50) NULL,
  [VoucherDate] DATETIME NULL,
  [VoucherTypeID] VARCHAR(50) NULL,
  [Description] NVARCHAR(250) NULL,
  [KindVoucherID] TINYINT DEFAULT (0) NULL,
  [Warehouse01ID] VARCHAR(50) NULL,
  [Warehouse02ID] VARCHAR(50) NULL,
  [InventoryTypeID] VARCHAR(50) NULL,
  [ObjectID] VARCHAR(50) NULL,
  [EmployeeID] VARCHAR(50) NULL,
  [Ref01] NVARCHAR(250) NULL,
  [Ref02] NVARCHAR(250) NULL,
  [ContactPerson] NVARCHAR(100) NULL,
  [DeliveryAddress] NVARCHAR(250) NULL,
  [IsSerialized] TINYINT DEFAULT (0) NULL,
  [IsAdjust] TINYINT DEFAULT (0) NULL,
  [IsConsignment] TINYINT DEFAULT (0) NULL,
  [InvoiceNo] VARCHAR(50) NULL,
  [InvoiceDate] DATETIME NULL,
  [ExchangeRate1] DECIMAL(28,8) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_WMT2006] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WMT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WMT2006' AND col.name = 'IsTransferDivision') 
   ALTER TABLE WMT2006 ADD IsTransferDivision TINYINT NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WMT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WMT2006' AND col.name = 'ImDivisionID') 
   ALTER TABLE WMT2006 ADD ImDivisionID VARCHAR(50) NULL
END


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WMT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WMT2006' AND col.name = 'ImWarehouseID') 
   ALTER TABLE WMT2006 ADD ImWarehouseID VARCHAR(50) NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WMT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WMT2006' AND col.name = 'ExWarehouseID') 
   ALTER TABLE WMT2006 ADD ExWarehouseID VARCHAR(50) NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WMT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WMT2006' AND col.name = 'InvoiceNo') 
   ALTER TABLE WMT2006 ADD InvoiceNo VARCHAR(50) NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WMT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WMT2006' AND col.name = 'InvoiceDate') 
   ALTER TABLE WMT2006 ADD InvoiceDate DATETIME NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WMT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WMT2006' AND col.name = 'IsConsignment') 
   ALTER TABLE WMT2006 ADD IsConsignment TINYINT NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WMT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WMT2006' AND col.name = 'ExchangeRate1') 
   ALTER TABLE WMT2006 ADD ExchangeRate1 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WMT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WMT2006' AND col.name = 'IsAdjust') 
   ALTER TABLE WMT2006 ADD IsAdjust TINYINT NULL 
END
/*===============================================END IsAdjust===============================================*/ 

-----------------Bổ sung IsAutoCreate - Phiếu tự sinh khi phiếu yêu cầu được duyệt - Kim Thư ----------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WMT2006' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WMT2006' AND col.name = 'IsAutoCreate') 
   ALTER TABLE WMT2006 ADD IsAutoCreate TINYINT NULL 
END
