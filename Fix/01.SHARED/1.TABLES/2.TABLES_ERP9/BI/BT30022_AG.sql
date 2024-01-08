﻿---- Create by Nguyễn Hoàng Bảo Thy on 27/06/2016 3:17:35 PM
---- Import dữ liệu thưởng doanh số nhân viên (Angel)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BT30022_AG]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[BT30022_AG]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [VoucherID] VARCHAR(50) NOT NULL,
      [VoucherNo] VARCHAR(50) NULL,
      [VoucherDate] DATETIME NULL,
      [TransactionID] VARCHAR(50) NOT NULL,
      [TranMonth] INT NULL,
      [TranYear] INT NULL,
      [Amount] DECIMAL(28,8) NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [VoucherTypeID] VARCHAR(50) NULL
    CONSTRAINT [PK_BT30022_AG] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [VoucherID],
      [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END