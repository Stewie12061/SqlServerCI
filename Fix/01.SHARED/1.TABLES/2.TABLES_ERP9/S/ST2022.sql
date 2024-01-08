---- Create by Nguyễn Tấn Lộc on 9/30/2020 4:07:27 PM
---- Thiết lập Rules (Detail)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST2022]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST2022]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster_ST2020] UNIQUEIDENTIFIER NULL,
  [DivisionID] VARCHAR(50) NULL,
  [ModuleID] NVARCHAR(250) NULL,
  [ScreenID] NVARCHAR(250) NULL,
  [TableID] NVARCHAR(250) NULL,
  [VoucherBusiness] VARCHAR(250) NULL,
  [UserID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_ST2022] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 12/10/2020 - Tấn Lộc: Bổ sung cột VoucherBusinessName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2022' AND col.name = 'VoucherBusinessName')
BEGIN
	ALTER TABLE ST2022 ADD VoucherBusinessName NVARCHAR(MAX) NULL
END

--- 12/10/2020 - Tấn Lộc: Thay đổi kiểu dữ liệu cho cột APKMaster_ST2020
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2022' AND col.name = 'APKMaster_ST2020')
BEGIN
	ALTER TABLE ST2022 ALTER COLUMN APKMaster_ST2020 VARCHAR(MAX) NULL
END

--- 12/10/2020 - Tấn Lộc: Bổ sung cột APKRelBusiness
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2022' AND col.name = 'APKRelBusiness')
BEGIN
	ALTER TABLE ST2022 ADD APKRelBusiness VARCHAR(250) NULL
END