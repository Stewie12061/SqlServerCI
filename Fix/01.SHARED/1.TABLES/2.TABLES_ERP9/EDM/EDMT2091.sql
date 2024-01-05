---- Create by Hồng Thảo on 09/09/2018
---- Tạo lịch học năm detail 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2091]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2091]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [ActivityTypeID] VARCHAR(50) NULL,
  [ActivityID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR (50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR (50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2091] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

 ---- Add Columns
----Modified Khánh Đoan : Bổ sung trường Contents
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2091' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2091' AND col.name = 'Contents') 
   ALTER TABLE EDMT2091 ADD Contents NVARCHAR(Max) NULL 
END

