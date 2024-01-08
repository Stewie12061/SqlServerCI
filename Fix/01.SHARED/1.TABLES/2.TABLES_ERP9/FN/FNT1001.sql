﻿---- Create by Hồng Thảo on 31/10/2018
---- Danh mục định mức chi phí detail 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[FNT1001]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[FNT1001]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [FeeID] VARCHAR(50) NULL,
  [LevelID] VARCHAR(50) NULL,
  [UnitID] VARCHAR(50) NULL,
  [Quantity] INT NULL,
  [FromAmount] DECIMAL(28,8) NULL,
  [ToAmount] DECIMAL(28,8) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_FNT1001] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END






