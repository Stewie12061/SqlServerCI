﻿---- Create by Nguyễn Hoàng Bảo Thy on 7/20/2017 9:05:40 AM
---- Định biên tuyển dụng (master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT1020]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT1020]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [BoundaryID] VARCHAR(50) NOT NULL,
  [Description] NVARCHAR(100) NULL,
  [DepartmentID] VARCHAR(50) NOT NULL,
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [CostBoundary] DECIMAL(28,8) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT1020] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [BoundaryID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
--Thanh Hải Create 13/10/2023 --Bổ sung cột DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name]='HRMT1020' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id=tab.id WHERE tab.name='HRMT1020' and col.name='DeleteFlg')
	ALTER TABLE HRMT1020 ADD DeleteFlg TINYINT DEFAULT 0 NULL
END