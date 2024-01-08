﻿---- Create by Nguyễn Hoàng Bảo Thy on 9/21/2017 8:53:00 AM
---- Danh sách nghiệp vụ sử dụng email template

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CMNT1041]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CMNT1041]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [TemplateID] VARCHAR(50) NOT NULL,
  [TransactionTypeID] VARCHAR(50) NOT NULL
CONSTRAINT [PK_CMNT1041] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END