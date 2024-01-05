﻿---- Create by Nguyễn Tấn Lộc on 7/15/2020 10:09:13 AM
---- File Lic và đối tượng liên quan

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT2132]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT2132]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [AttachID] INT NULL,
  [RelatedToID] VARCHAR(250) NULL,
  [RelatedToTypeID_REL] INT NULL
CONSTRAINT [PK_CRMT2132] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END