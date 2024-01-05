---- Create by Trương Tấn Thành on 1/19/2021 1:07:37 PM
---- Thiết lập biến môi trường

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST2101]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST2101]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] VARCHAR(50) NULL,
  [TypeID] TINYINT DEFAULT (1) NULL,
  [GroupID] TINYINT NULL,
  [KeyName] VARCHAR(250) NULL,
  [KeyValue] VARCHAR(250) NULL,
  [ValueDataType] TINYINT DEFAULT (1) NULL,
  [DefaultValue] TINYINT DEFAULT (1) NULL,
  [ModuleID] VARCHAR(50) NULL,
  [IsEnvironment] TINYINT DEFAULT (0) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [DescriptionE] VARCHAR(MAX) NULL,
  [OrderNo] INT,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_ST2101] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 20/04/2022 - Hoài Thanh: Chỉnh type cột KeyValue thành varchar(max) để lưu zalo_refresh_token ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2101' AND col.name = 'KeyValue')
BEGIN
	ALTER TABLE ST2101 ALTER COLUMN KeyValue VARCHAR(MAX) NULL
END
