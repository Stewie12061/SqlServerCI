
---- Create by Phan thanh hoàng vũ on 7/27/2017 5:58:18 PM
---- Phiếu thu (Master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POST00801]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POST00801]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [ShopID] VARCHAR(50) NOT NULL,
  [VoucherTypeID] VARCHAR(50) NULL,
  [VoucherNo] VARCHAR(50) NOT NULL,
  [VoucherDate] DATETIME NOT NULL,
  [TranMonth] INT NOT NULL,
  [TranYear] INT NOT NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NOT NULL,
  [CurrencyID] VARCHAR(50) NOT NULL,
  [ExchangeRate] DECIMAL(28,8) NOT NULL,
  [EmployeeID] VARCHAR(50) NOT NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [CashierID] NVARCHAR(250) NULL,
  [RelatedToTypeID] TINYINT DEFAULT 24 NULL,
  [Description] NVARCHAR(MAX) NULL
CONSTRAINT [PK_POST00801] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
--Modified by Thị Phượng on 08/12/2017: Quản lý phiếu thu tiền cọc (1: Tiền thu đặt cọc; 0: khác)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST00801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00801' AND col.name = 'IsDeposit') 
   ALTER TABLE POST00801 ADD IsDeposit TINYINT NULL 
END
--Modified by Thị Phượng on 08/12/2017: Quản lý phiếu thu sinh ngầm từ các nguồn (1: Phiếu đặt cọc, 2: Phiếu bán hàng; 3: Phiếu đối hàng[Thu tiền chênh lệch])
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST00801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00801' AND col.name = 'IsPayInvoice') 
   ALTER TABLE POST00801 ADD IsPayInvoice TINYINT NULL 
END

---Modified by Hoàng vũ on 06/03/2018: Cho phép khai báo nhiều hình thức thanh toán thay thế cho dùng 1 phương thức thanh toán là trường PaymentID  do phượng làm ban đầu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST00801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00801' AND col.name = 'APKPaymentID') 
   ALTER TABLE POST00801 ADD APKPaymentID UNIQUEIDENTIFIER NULL 
END

/*===============================================END APKPaymentID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST00801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00801' AND col.name = 'PaymentObjectAmount01') 
   ALTER TABLE POST00801 ADD PaymentObjectAmount01 DECIMAL(28,8) NULL 
END

/*===============================================END PaymentObjectAmount01===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST00801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00801' AND col.name = 'PaymentObjectAmount02') 
   ALTER TABLE POST00801 ADD PaymentObjectAmount02 DECIMAL(28,8) NULL 
END

/*===============================================END PaymentObjectAmount02===============================================*/ 
---Modified by Thị Phượng on 21/12/2017: Bổ sung cột Hình thức thanh toán cho phiếu thu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST00801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00801' AND col.name = 'PaymentID') 
   ALTER TABLE POST00801 ADD PaymentID VARCHAR(50) NULL 
END

--Modified by Hoàng vũ Date: 12/02/2019: Bổ sung trường phân biệt dữ liệu đã cắt số liệu so với ERP (Trường hợp Nếu cắt số liệu thì Bắn dữ liệu qua bảng POST00162 và update lại trường này già trị =1 ) => trước tiên làm cho OKIA
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST00801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00801' AND col.name = 'IsCutDataERP') 
   ALTER TABLE POST00801 ADD IsCutDataERP TINYINT NULL 
END
/*===============================================END IsCutDataERP===============================================*/ 

--Modified by Kiều Nga Date: 19/09/2019: Bổ sung trường check phiếu yêu cầu dịch vụ
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00801' AND col.name = 'IsServiceRequest') 
   ALTER TABLE POST00801 ADD IsServiceRequest TINYINT NULL 
END

