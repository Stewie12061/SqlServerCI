---- Create by Phan thanh hoàng vũ on 7/27/2017 5:59:33 PM
---- Phiếu thu (Detail)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POST00802]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POST00802]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [APKMInherited] UNIQUEIDENTIFIER NULL,
  [APKDInherited] UNIQUEIDENTIFIER NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [ShopID] VARCHAR(50) NOT NULL,
  [MemberID] VARCHAR(50) NULL,
  [Amount] DECIMAL(28,8) NOT NULL,
  [ConvertedAmount] DECIMAL(28,8) NULL,
  [Notes] NVARCHAR(250) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [VoucherNoInherited] VARCHAR(50) NULL,
  [Orders] INT NULL
CONSTRAINT [PK_POST00802] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
---Modify By Thị Phượng on 24/08/2017 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST00802' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00802' AND col.name = 'PayAmount') 
   ALTER TABLE POST00802 ADD PayAmount DECIMAL(28,8) NULL 
END
---Modified by Thị Phượng on 08/12/2017 Bổ sung cột Số chứng từ phiếu đặt cọc

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST00802' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00802' AND col.name = 'DepositVoucherNo ') 
   ALTER TABLE POST00802 ADD DepositVoucherNo VARCHAR(50) NULL 
END

---Modified by Kiều Nga on 19/09/2019 Bổ sung cột Phiếu yêu cầu dịch vụ 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST00802' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00802' AND col.name = 'ServiceRequestVoucherNo ') 
   ALTER TABLE POST00802 ADD ServiceRequestVoucherNo VARCHAR(50) NULL 
END
