﻿---- Create by Tra Giang on 16/08/2018 
---- Danh mục bữa ăn

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[NMT1060]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[NMT1060]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [MealID] VARCHAR(50) NOT NULL,
  [MealName] NVARCHAR(250) NULL,
  [Description] NVARCHAR(250) NULL,
  [IsCommon] TINYINT NULL,
  [Disabled] TINYINT NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_NMT1060] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [MealID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


