---- Create by Nguyễn Tấn Lộc on 9/30/2020 3:18:43 PM
---- Thiết lập rules (Detail)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST2021]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST2021]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster_ST2020] UNIQUEIDENTIFIER NULL,
  [DivisionID] VARCHAR(50) NULL,
  [ObjectID] NVARCHAR(MAX) NULL,
  [FilterCondition] NVARCHAR(MAX) NULL,
  [FilterContent] NVARCHAR(MAX) NULL,
  [UserID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_ST2021] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 12/10/2020 - Tấn Lộc: Thay đổi kiểu dữ liệu cho cột APKMaster_ST2020
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST2021' AND col.name = 'APKMaster_ST2020')
BEGIN
	ALTER TABLE ST2021 ALTER COLUMN APKMaster_ST2020 VARCHAR(MAX) NULL
END
	
-- 23/11/2020 - Huỳnh Thử: bổ sung cột DescriptionDetail
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'ST2021' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'ST2021' AND col.name = 'DescriptionDetail') 
   ALTER TABLE ST2021 ADD DescriptionDetail NVARCHAR(MAX) NULL
END
