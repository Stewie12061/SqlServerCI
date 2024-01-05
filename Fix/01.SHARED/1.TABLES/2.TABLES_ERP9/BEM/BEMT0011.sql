﻿---- Create by Trương Tấn Thành on 5/21/2020 10:12:29 AM
---- Bảng thiết lập tài khoản theo mã phân tích

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BEMT0011]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[BEMT0011]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [CostAnaTypeID] VARCHAR(50) NULL,
  [DepartmentAnaTypeID] VARCHAR(50) NULL,
  [AccountID] VARCHAR(250) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_BEMT0011] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END