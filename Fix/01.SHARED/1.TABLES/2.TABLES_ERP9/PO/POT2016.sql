﻿---- Create by Tieumai on 7/4/2018 10:22:22 AM
---- Đơn đặt hàng sỉ/nội bộ (detail)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POT2016]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POT2016]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [APK_Master] UNIQUEIDENTIFIER NOT NULL,
  [InventoryTypeID] NVARCHAR(50) NULL,
  [InventoryID] NVARCHAR(50) NULL,
  [UnitID] NVARCHAR(50) NULL,
  [OrderQuantity] DECIMAL(28,8) NULL,
  [OrderPrice] DECIMAL(28,8) NULL,
  [OriginalAmount] DECIMAL(28,8) NULL,
  [ConvertedAmount] DECIMAL(28,8) NULL,
  [Notes] NVARCHAR(250) NULL,
  [DepositAmount] DECIMAL(28,8) NULL,
  [DepositConAmount] DECIMAL(28,8) NULL,
  [DepositNotes] NVARCHAR(250) NULL,
  [RequireDate] DATETIME NULL,
  [ScheduleDate] DATETIME NULL,
  [Ana01ID] NVARCHAR(50) NULL,
  [Ana02ID] NVARCHAR(50) NULL,
  [Ana03ID] NVARCHAR(50) NULL,
  [Ana04ID] NVARCHAR(50) NULL,
  [Ana05ID] NVARCHAR(50) NULL,
  [Ana06ID] NVARCHAR(50) NULL,
  [Ana07ID] NVARCHAR(50) NULL,
  [Ana08ID] NVARCHAR(50) NULL,
  [Ana09ID] NVARCHAR(50) NULL,
  [Ana10ID] NVARCHAR(50) NULL
CONSTRAINT [PK_POT2016] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END