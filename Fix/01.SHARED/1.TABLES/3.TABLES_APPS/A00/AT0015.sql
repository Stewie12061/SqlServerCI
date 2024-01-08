---- Create by Đoàn Duy on 10/02/2021
---- Danh mục server hosting cloud 1boss
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0015]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0015]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [ServerID] NVARCHAR(50) NOT NULL, -- mã server
  [ServerName] NVARCHAR(MAX) NOT NULL, -- Tên server
  [ServerIP] NVARCHAR(MAX) NOT NULL, -- IP của server
  [MainAPIPort] VARCHAR(10) NOT NULL,
  [MaximumRegister] int NOT NULL,
  [CreateDate] DateTime NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [AT0015_PK] PRIMARY KEY CLUSTERED
(
  [ServerID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END



IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0015' AND col.name = 'IsTrial')
BEGIN
	ALTER TABLE AT0015 ADD IsTrial TINYINT DEFAULT 0 NULL
END