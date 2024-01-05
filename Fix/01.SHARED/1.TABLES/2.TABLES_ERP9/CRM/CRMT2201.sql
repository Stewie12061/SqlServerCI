---- Create by Nguyễn Tấn Lộc on 10/2/2021 7:30:04 PM
---- Thiết lập danh sách cuộc gọi

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT2201]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT2201]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyDate] DATETIME NULL,
  [VoucherBusiness] VARCHAR(250) NULL,
  [VoucherBusinessName] NVARCHAR(MAX) NULL,
  [Address] NVARCHAR(MAX) NULL,
  [Email] NVARCHAR(MAX) NULL,
  [Tel] VARCHAR(250) NULL,
  [UserID] VARCHAR(50) NULL,
  [StatusCall] VARCHAR(50) NULL
CONSTRAINT [PK_CRMT2201] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
---------------- 13/10/2021 - Hoài Bảo: Bổ sung cột Position(Chức danh/Chức vụ), CompanyName ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2201' AND col.name = 'Position')
BEGIN
	ALTER TABLE CRMT2201 ADD Position NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2201' AND col.name = 'CompanyName')
BEGIN
	ALTER TABLE CRMT2201 ADD CompanyName NVARCHAR(MAX) NULL
END
---------------- 20/10/2021 - Hoài Bảo: Bổ sung cột STT(Số thứ tự) ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2201' AND col.name = 'STT')
BEGIN
	ALTER TABLE CRMT2201 ADD STT INT NULL
END