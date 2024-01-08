﻿---- Create by Trà Giang on 26/11/2019
---- Phiếu yêu cầu khách hàng ( MAITHU = 107) MPT load động

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT2102]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT2102]
(
	[APK] [UNIQUEIDENTIFIER] DEFAULT NEWID() NOT NULL,
	[DivisionID] [VARCHAR](50) NOT NULL,
	[APKMaster] [UNIQUEIDENTIFIER] NOT NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
	[TranMonth] INT NULL,
	[TranYear] INT NULL,
    [Type] INT NULL,
	[AnaID] VARCHAR(50) NOT NULL,
	[AnaName] NVARCHAR(250) NULL,
	[LengthZenSuppo] DECIMAL(28,8) NULL,
	[WidthZenSuppo] DECIMAL(28,8) NULL,
	[DeleteFlg] TINYINT DEFAULT (0) NULL
 
CONSTRAINT [PK_CRMT2102] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END