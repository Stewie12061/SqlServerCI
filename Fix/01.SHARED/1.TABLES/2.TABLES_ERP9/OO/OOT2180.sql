---- Create by Nguyễn Tấn Lộc on 11/18/2019 2:07:26 PM
---- Danh mục lịch sử cuộc gọi

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2180]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2180]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [CallDate] DATETIME NULL,
  [DID] VARCHAR(50) NULL,
  [Source] VARCHAR(50) NULL,
  [Destination] VARCHAR(50) NULL,
  [StatusID] VARCHAR(50) NULL,
  [Note] NVARCHAR(MAX) NULL,
  [Duration] VARCHAR(50) NULL,
  [TypeOfCall] VARCHAR(50) NULL,
  [RequestStatus] VARCHAR(50) NULL,
  [Extend] VARCHAR(50) NULL,
  [AccountID] VARCHAR(50) NULL,
  [ContactID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [AccountName] NVARCHAR(250) NULL,
  [ContactName] NVARCHAR(250) NULL
CONSTRAINT [PK_OOT2180] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 29/11/2019 - Truong Lam: Bổ sung cột CallID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2180' AND col.name = 'CallID')
BEGIN
	ALTER TABLE OOT2180 ADD CallID NVARCHAR(250) NULL
END

---------------- 30/11/2019 - Truong Lam: Bổ sung cột Recording ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2180' AND col.name = 'Recording')
BEGIN
	ALTER TABLE OOT2180 ADD Recording NVARCHAR(MAX) NULL
END

---------------- 30/11/2019 - Truong Lam: Bổ sung cột Download ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2180' AND col.name = 'Download')
BEGIN
	ALTER TABLE OOT2180 ADD Download NVARCHAR(MAX) NULL
END

---------------- 30/11/2019 - Truong Lam: Bổ sung cột RequestSupportID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2180' AND col.name = 'RequestSupportID')
BEGIN
	ALTER TABLE OOT2180 ADD RequestSupportID VARCHAR(50) NULL
END

---------------- 30/11/2019 - Tấn Lộc: Thay đổi kiểu dữ liệu của cột Duration ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2180' AND col.name = 'Duration')
BEGIN
	ALTER TABLE OOT2180 ALTER COLUMN Duration INT NULL
END

---------------- 01/07/2021 - Hoài Bảo: Bổ sung cột LeadID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2180' AND col.name = 'LeadID')
BEGIN
	ALTER TABLE OOT2180 ADD LeadID VARCHAR(25) NULL
END

---------------- 01/07/2021 - Hoài Bảo: Update độ dài dữ liệu cột LeadID ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2180' AND col.name = 'LeadID')
BEGIN
	ALTER TABLE OOT2180 ALTER COLUMN LeadID VARCHAR(50) NULL
END