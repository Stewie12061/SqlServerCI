﻿---- Create by Như Hàn on 07/12/2018 
---- Dữ liệu Mua hàng từ Quản lý dự án
---- Modifier by ... on...

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POT2033]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POT2033]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR (50),
  [ASCIDProJ] INT NULL, 
  [ASCOrderID] INT,
  [ASCOrderDetail] INT,
  [ASCOrderNo] NVARCHAR (500),
  [ASCDescription] NVARCHAR (1000),
  [ASCQuantity] DECIMAL(28,8),
  [ASCIDInven] INT,
  [ASCOrderDate] DATETIME,
  [IsInherit] INT,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
  
CONSTRAINT [PK_POT2033] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
