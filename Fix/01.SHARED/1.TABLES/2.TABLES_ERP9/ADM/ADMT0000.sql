﻿---- Create by Nguyễn Tấn Lộc on 3/30/2020 4:53:31 PM
---- Thiết lập hệ thống Modules ADM

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ADMT0000]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ADMT0000]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [AdminServer] NVARCHAR(250) NULL,
  [AdminUser] NVARCHAR(250) NULL,
  [AdminPassword] NVARCHAR(250) NULL,
  [AdminDatabase] NVARCHAR(250) NULL,
  [ERPServer] NVARCHAR(250) NULL,
  [ERPUser] NVARCHAR(250) NULL,
  [ERPPassword] NVARCHAR(250) NULL,
  [ERPDatabase] NVARCHAR(250) NULL,
  [LinkSource] NVARCHAR(MAX) NULL,
  [LinkFixSQL] NVARCHAR(MAX) NULL,
  [UserID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_ADMT0000] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END