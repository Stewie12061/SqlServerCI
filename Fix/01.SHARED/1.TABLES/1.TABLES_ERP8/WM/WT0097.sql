﻿---- Create by Nguyễn Hoàng Bảo Thy on 1/10/2017 2:53:29 PM
---- Master chi phí nhập/xuất kho

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WT0097]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[WT0097]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [TranMonth] INT NOT NULL,
  [VoucherTypeID] VARCHAR(50) NULL,
  [TranYear] INT NOT NULL,
  [VoucherID] VARCHAR(50) NOT NULL,
  [VoucherNo] VARCHAR(50) NULL,
  [VoucherDate] DATETIME NULL,
  [ObjectID] VARCHAR(50) NULL,
  [Description] NVARCHAR(1000) NULL,
  [CurrencyID] VARCHAR(50) NULL,
  [WareHouseID] VARCHAR(50) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [IsImportVoucher] TINYINT NULL
CONSTRAINT [PK_WT0097] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [VoucherID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

----Modified by Bảo Thy on 20/03/2017: Bổ sung lưu trạng thái quyết toán
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0097' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT0097' AND col.name = 'IsFinalCost') 
   ALTER TABLE WT0097 ADD IsFinalCost TINYINT NULL 
END
----Modified by Huỳnh Thử on 10/06/2020:
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0097' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT0097' AND col.name = 'IsOtherCosts') 
   ALTER TABLE WT0097 ADD IsOtherCosts TINYINT NULL 
END
