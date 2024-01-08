---- Create by Đoàn Duy on 10/02/2021
---- Thông tin thuê bao cloud của khách hàng 1boss
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0014]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0014]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [SubscriberID] VARCHAR(50) NOT NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [URL_Web] NVARCHAR(MAX) NOT NULL, 
  [URL_API] NVARCHAR(MAX) NOT NULL,
  [Port_Web] int NOT NULL, 
  [Port_API] int NOT NULL,
  [Subdomain] VARCHAR(50) NOT NULL,
  [ServerID] NVARCHAR(MAX) NOT NULL, -- IP publish của server
  [CreateDate] DateTime NULL,
  [EndDate] DateTime NULL,
  [IsTrial] TINYINT DEFAULT (0) NULL,
  [MemoryStorage] Decimal DEFAULT (0) NULL,
  [MaxUser] int DEFAULT (0) NULL,
  [SourceID] VARCHAR(50) NULL, -- CRMT2210 link với tính năng đăng ký dùng thử
  [CustomerID] VARCHAR(50) NULL, -- khách hàng sử dụng chính thức
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [AT0014_PK] PRIMARY KEY CLUSTERED
(
  [SubscriberID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0014' AND col.name = 'StatusID')
BEGIN
	ALTER TABLE AT0014 ADD StatusID  Varchar(50) NULL
END

---------------- 28/03/2022 - Hoài Bảo: Bổ sung cột DisplayID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0014' AND col.name = 'DisplayID')
BEGIN
	ALTER TABLE AT0014 ADD DisplayID INT IDENTITY(1,1) NOT NULL
END

---------------- 29/04/2022 - Tấn Lộc: Thay đổi kiểu dữ liệu của cột URL_Web, URL_API, Port_Web, Port_API, Subdomain, ServerID ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0014' AND col.name = 'URL_Web')
BEGIN
	ALTER TABLE AT0014 ALTER COLUMN URL_Web NVARCHAR(MAX) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0014' AND col.name = 'URL_API')
BEGIN
	ALTER TABLE AT0014 ALTER COLUMN URL_API NVARCHAR(MAX) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0014' AND col.name = 'Port_Web')
BEGIN
	ALTER TABLE AT0014 ALTER COLUMN Port_Web INT NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0014' AND col.name = 'Port_API')
BEGIN
	ALTER TABLE AT0014 ALTER COLUMN Port_API INT NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0014' AND col.name = 'Subdomain')
BEGIN
	ALTER TABLE AT0014 ALTER COLUMN Subdomain VARCHAR(500) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0014' AND col.name = 'ServerID')
BEGIN
	ALTER TABLE AT0014 ALTER COLUMN ServerID NVARCHAR(MAX) NULL
END

---------------- 29/04/2022 - Tấn Lộc: Bổ sung thêm cột IsOfficial ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0014' AND col.name = 'IsOfficial')
BEGIN
	ALTER TABLE AT0014 ADD IsOfficial TINYINT DEFAULT (0) NULL
END

---------------- 29/04/2022 - Tấn Lộc: Bổ sung thêm cột Email - dùng để gửi thông tin cho khách hàng đăng kí ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0014' AND col.name = 'Email')
BEGIN
	ALTER TABLE AT0014 ADD Email NVARCHAR (MAX) NULL
END

---------------- 11/05/2022 - Tấn Lộc: Bổ sung thêm cột LeadID, OpportunityID - dùng để gửi thông tin cho khách hàng đăng kí ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0014' AND col.name = 'LeadID')
BEGIN
	ALTER TABLE AT0014 ADD LeadID NVARCHAR (500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0014' AND col.name = 'OpportunityID')
BEGIN
	ALTER TABLE AT0014 ADD OpportunityID NVARCHAR (500) NULL
END