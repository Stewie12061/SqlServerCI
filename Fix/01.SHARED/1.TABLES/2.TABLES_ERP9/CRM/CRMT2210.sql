---- Danh sách dùng thử 1Boss, Lead bàn giao, Ao cơ hội
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT2210]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT2210]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [DisplayID] INT IDENTITY(1,1) NOT NULL,
  [SourceID] VARCHAR(50) NULL,
  [SourceName] NVARCHAR(MAX) NULL,
  [Tel] NVARCHAR(100) NULL,
  [Address] NVARCHAR(MAX) NULL,
  [Email] NVARCHAR(100) NULL,
  [JobTitle] NVARCHAR(MAX) NULL,
  [CompanyName] NVARCHAR(MAX) NULL,
  [StatusID] Varchar(50) NULL,
  [TypeOfSource] VARCHAR(50) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [ProductInfo] NVARCHAR(MAX) NULL,
  [IsComfirmOpportunity] TINYINT DEFAULT (0) NULL,
  [IsComfirmCustomers] TINYINT DEFAULT (0) NULL,
  [IsComfirmLead] TINYINT DEFAULT (0) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
CONSTRAINT [CRMT2210_PK] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


---------------- 24/06/2020 - Tấn Lộc: Bổ sung cột DomainERR9, UserName, Password ----------------
---------------- 3 cột này bổ sung vào với mục đích là mapping EmailTemplate có biến chứ không lưu và không sử dụng ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'DomainERR9')
BEGIN
	ALTER TABLE CRMT2210 ADD DomainERR9 NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'UserName')
BEGIN
	ALTER TABLE CRMT2210 ADD UserName NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'Password')
BEGIN
	ALTER TABLE CRMT2210 ADD Password NVARCHAR(MAX) NULL
END

---------------- 25/02/2022 - Hoài Thanh: Bổ sung cột UserID, ProfilePic, Locale, Timezone, Gender, City, District, Note, TagName, Ward, BirthDate, FormID, FormName, AssignedToUserID ----------------
---------------- 14 cột này bổ sung vào với mục đích là lấy thông tin người dùng facebook và Zalo ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'UserID')
BEGIN
	ALTER TABLE CRMT2210 ADD UserID NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'ProfilePic')
BEGIN
	ALTER TABLE CRMT2210 ADD ProfilePic NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'Locale')
BEGIN
	ALTER TABLE CRMT2210 ADD Locale NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'Timezone')
BEGIN
	ALTER TABLE CRMT2210 ADD Timezone int NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'Gender')
BEGIN
	ALTER TABLE CRMT2210 ADD Gender NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'City')
BEGIN
	ALTER TABLE CRMT2210 ADD City NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'District')
BEGIN
	ALTER TABLE CRMT2210 ADD District NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'Notes')
BEGIN
	ALTER TABLE CRMT2210 ADD Notes NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'TagNames')
BEGIN
	ALTER TABLE CRMT2210 ADD TagNames NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'Ward')
BEGIN
	ALTER TABLE CRMT2210 ADD Ward NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'BirthDate')
BEGIN
	ALTER TABLE CRMT2210 ADD BirthDate DateTime NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'FormID')
BEGIN
	ALTER TABLE CRMT2210 ADD FormID VARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'FormName')
BEGIN
	ALTER TABLE CRMT2210 ADD FormName NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'AssignedToUserID')
BEGIN
	ALTER TABLE CRMT2210 ADD AssignedToUserID NVARCHAR(MAX) NULL
END

---------------- 17/03/2022 - Tấn Lộc: Thay đổi kiểu dữ liệu của cột SourceID ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'SourceID')
BEGIN
	ALTER TABLE CRMT2210 ALTER COLUMN SourceID VARCHAR(500) NULL
END

---------------- 17/03/2022 - Tấn Lộc: Bổ sung cột Chiến Dịch cho Ao Đầu mối ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'CampaignID')
BEGIN
	ALTER TABLE CRMT2210 ADD CampaignID NVARCHAR(250) NULL
END

---------------- 12/04/2022 - Đoàn Duy: Bổ xung cột IsCommon cho Ao Đầu mối ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'IsCommon')
BEGIN
	ALTER TABLE CRMT2210 ADD IsCommon TINYINT NULL DEFAULT 1
END

---------------- 12/04/2022 - Đoàn Duy: Bổ xung cột SubDomain cho Ao Đầu mối ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'SubDomain')
BEGIN
	ALTER TABLE CRMT2210 ADD SubDomain VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'TeamID')
BEGIN
	ALTER TABLE CRMT2210 ADD TeamID NVARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'CampaignMedium')
BEGIN
	ALTER TABLE CRMT2210 ADD CampaignMedium NVARCHAR(250) NULL
END

---------------- 08/03/2023 - Hoài Thanh: Bổ sung cột Link (link từ nguồn Ladipage) ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'Link')
BEGIN
	ALTER TABLE CRMT2210 ADD Link NVARCHAR(MAX) NULL
END

---------------- 29/06/202 - Văn Tài: Bổ xung cột IsComfirmLead cho Ao đầu mối  ---------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'IsComfirmLead')
BEGIN
	ALTER TABLE CRMT2210 ADD IsComfirmLead TINYINT NULL DEFAULT 0
END


IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2210' AND col.name = 'DisplayID')
BEGIN
	ALTER TABLE CRMT2210 ADD DisplayID INT IDENTITY (1,1) NOT NULL
END
