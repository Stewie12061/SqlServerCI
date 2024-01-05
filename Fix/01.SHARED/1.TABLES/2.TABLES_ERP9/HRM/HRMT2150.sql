---- Create by Huỳnh Thử on 11/2/2020 11:27:28 AM
---- Danh sách BlackList (Master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2150]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2150]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [VoucherNo] NVARCHAR(250) NULL,
  [VoucherDate] DATETIME NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [Description] NVARCHAR(250) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NOT NULL
CONSTRAINT [PK_HRMT2150] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-- Huỳnh Thử Create 03/11/2020 -- Thiết lập module BlackList
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HRMT2150' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HRMT2150' AND col.name = 'ListUserDelete') 
   ALTER TABLE HRMT2150 ADD ListUserDelete VARCHAR (MAX) NULL
END
