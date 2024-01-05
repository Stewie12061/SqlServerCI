---- Create by Nguyễn Tấn Lộc on 7/10/2020 8:58:45 AM
---- Thông tin phiếu đề nghị cấp license

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT2120]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT2120]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [RequestLicenseID] VARCHAR(50) NULL,
  [RequestLicenseName] NVARCHAR(MAX) NULL,
  [AccountID] VARCHAR(50) NULL,
  [Address] NVARCHAR(MAX) NULL,
  [VATNo] NVARCHAR(250) NULL,
  [NameofLegalRepresentative] NVARCHAR(MAX) NULL,
  [Position] NVARCHAR(250) NULL,
  [ContractNo] NVARCHAR(250) NULL,
  [NumberOfUsers] VARCHAR(50) NULL,
  [NumberOfUnitsBranchesUsed] VARCHAR(50) NULL,
  [Tel] VARCHAR(50) NULL,
  [ElectronicBill] TINYINT DEFAULT (0) NULL,
  [Fax] NVARCHAR(250) NULL,
  [Website] NVARCHAR(250) NULL,
  [Email] NVARCHAR(250) NULL,
  [ContactID] VARCHAR(50) NULL,
  [AssignedToUserID] VARCHAR(50) NULL,
  [IsDeadlineTime] TINYINT DEFAULT (0) NULL,
  [NoDeadline] TINYINT DEFAULT (0) NULL,
  [DeadlineTime] DATETIME NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_CRMT2120] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 17/12/2020 - Tấn Lộc: Bổ sung cột Jananese, Chinese, ReportViewOnly, SME, CloudServer, InformationVersion, Server, User, Port, Password--------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2120' AND col.name = 'Jananese')
BEGIN
	ALTER TABLE CRMT2120 ADD Jananese TINYINT DEFAULT 0 NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2120' AND col.name = 'Chinese')
BEGIN
	ALTER TABLE CRMT2120 ADD Chinese TINYINT DEFAULT 0 NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2120' AND col.name = 'ReportViewOnly')
BEGIN
	ALTER TABLE CRMT2120 ADD ReportViewOnly TINYINT DEFAULT 0 NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2120' AND col.name = 'SME')
BEGIN
	ALTER TABLE CRMT2120 ADD SME TINYINT DEFAULT 0 NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2120' AND col.name = 'CloudServer')
BEGIN
	ALTER TABLE CRMT2120 ADD CloudServer TINYINT DEFAULT 0 NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2120' AND col.name = 'InformationVersion')
BEGIN
	ALTER TABLE CRMT2120 ADD InformationVersion VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2120' AND col.name = 'Server')
BEGIN
	ALTER TABLE CRMT2120 ADD Server NVARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2120' AND col.name = 'InformationUser')
BEGIN
	ALTER TABLE CRMT2120 ADD InformationUser NVARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2120' AND col.name = 'Port')
BEGIN
	ALTER TABLE CRMT2120 ADD Port NVARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2120' AND col.name = 'Password')
BEGIN
	ALTER TABLE CRMT2120 ADD Password NVARCHAR(250) NULL
END

-------------------- 31/12/2020 - Tấn Lộc: Bổ sung cột ContractName--------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT2120' AND col.name = 'ContractName')
BEGIN
	ALTER TABLE CRMT2120 ADD ContractName NVARCHAR(MAX) NULL
END