﻿---- Create by Hồng Thảo on 06/09/2018
---- Danh mục biểu phí

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT1090]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT1090]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [FeeID] VARCHAR(50) NOT NULL,
  [FeeName] NVARCHAR(250) NULL,
  [GradeID] VARCHAR(50) NULL,
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT1090] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [FeeID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


------Modified by Xuân Hiển on 27/12/2019:Thêm combo năm học.

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT1090' AND xtype = 'U')
BEGIN 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1090' AND col.name = 'SchoolYearID') 
   ALTER TABLE EDMT1090 ADD SchoolYearID VARCHAR(50) NULL
   
END


 






