---- Create by Trương Tấn Thành on 5/26/2020 8:48:26 AM
---- Đơn xin duyệt công tác/nghỉ phép về nước

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BEMT2010]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[BEMT2010]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [VoucherNo] VARCHAR(50) NULL,
  [VoucherDate] DATETIME NULL,
  [TypeID] TINYINT DEFAULT (0) NULL,
  [TypeBSTripID] TINYINT DEFAULT (0) NULL,
  [DepartmentCharged] VARCHAR(50) NULL,
  [StatusID] TINYINT DEFAULT (0) NULL,
  [Applicant] VARCHAR(50) NULL,
  [AdvancePaymentUserID] NVARCHAR(250) NULL,
  [AdvanceEstimate] DECIMAL(28,8) NULL,
  [AdvanceCurrencyID] VARCHAR(50) NULL,
  [DutyID] VARCHAR(50) NULL,
  [TitleID] VARCHAR(50) NULL,
  [DepartmentID] VARCHAR(50) NULL,
  [SectionID] VARCHAR(50) NULL,
  [SubsectionID] VARCHAR(50) NULL,
  [TeamID] VARCHAR(50) NULL,
  [StartDate] DATETIME NULL,
  [EndDate] DATETIME NULL,
  [TotalDate] INT NULL,
  [CountryID] VARCHAR(50) NULL,
  [CityID] VARCHAR(50) NULL,
  [CompanyName] NVARCHAR(250) NULL,
  [Purpose] NVARCHAR(250) NULL,
  [EmergencyReason] NVARCHAR(250) NULL,
  [TheOthers] NVARCHAR(250) NULL,
  [TicketFee] DECIMAL(28,8) NULL,
  [Journeys] NVARCHAR(250) NULL,
  [MeetingFee] DECIMAL(28,8) NULL,
  [OtherFee] DECIMAL(28,8) NULL,
  [ReasonOtherFee] NVARCHAR(250) NULL,
  [LivingFee] DECIMAL(28,8) NULL,
  [TravellingFee] DECIMAL(28,8) NULL,
  [Accommodation] NVARCHAR(250) NULL,
  [NumberOfDateStay] INT NULL,
  [BusinessFeePerDay] DECIMAL(28,8) NULL,
  [CurrencyID] VARCHAR(50) NULL,
  [TotalFee] DECIMAL(28,8) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_BEMT2010] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 10/06/2020 - Tấn Thành: Bổ sung cột APKMaster_9000
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'APKMaster_9000')
BEGIN
	ALTER TABLE BEMT2010 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

--- 10/06/2020 - Tấn Thành: Bổ sung cột Levels
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'Levels')
BEGIN
	ALTER TABLE BEMT2010 ADD Levels VARCHAR(50) NULL
END

--- 10/06/2020 - Tấn Thành: Bổ sung cột TranMonth
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'TranMonth')
BEGIN
	ALTER TABLE BEMT2010 ADD TranMonth INT NULL
END

--- 10/06/2020 - Tấn Thành: Bổ sung cột TranYear
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'TranYear')
BEGIN
	ALTER TABLE BEMT2010 ADD TranYear INT NULL
END

--- 10/06/2020 - Tấn Thành: Bổ sung cột DeleteFlg
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'DeleteFlg')
BEGIN
	ALTER TABLE BEMT2010 ADD DeleteFlg TINYINT DEFAULT (0) NULL
END

--- 20/06/2020 - Tấn Thành: Bổ sung cột ApproveLevel
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'ApproveLevel')
BEGIN
	ALTER TABLE BEMT2010 ADD ApproveLevel INT NULL
END

--- 20/06/2020 - Tấn Thành: Bổ sung cột ApprovingLevel
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'ApprovingLevel')
BEGIN
	ALTER TABLE BEMT2010 ADD ApprovingLevel INT NULL
END

--- 20/06/2020 - Tấn Thành: Bổ sung cột Status
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'Status')
BEGIN
	ALTER TABLE BEMT2010 ADD Status VARCHAR(50) NULL
END

--- 10/07/2020 - Tấn Thành: Thay đổi kiểu dữ liệu CompanyName
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'CompanyName')
BEGIN
	ALTER TABLE BEMT2010 ALTER COLUMN CompanyName NVARCHAR(MAX) NULL
END

--- 10/07/2020 - Tấn Thành: Thay đổi kiểu dữ liệu Purpose
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'Purpose')
BEGIN
	ALTER TABLE BEMT2010 ALTER COLUMN Purpose NVARCHAR(MAX) NULL
END

--- 10/07/2020 - Tấn Thành: Thay đổi kiểu dữ liệu EmergencyReason
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'EmergencyReason')
BEGIN
	ALTER TABLE BEMT2010 ALTER COLUMN EmergencyReason NVARCHAR(MAX) NULL
END

--- 10/07/2020 - Tấn Thành: Thay đổi kiểu dữ liệu TheOthers
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'TheOthers')
BEGIN
	ALTER TABLE BEMT2010 ALTER COLUMN TheOthers NVARCHAR(MAX) NULL
END

--- 10/07/2020 - Tấn Thành: Thay đổi kiểu dữ liệu Journeys
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'Journeys')
BEGIN
	ALTER TABLE BEMT2010 ALTER COLUMN Journeys NVARCHAR(MAX) NULL
END

--- 10/07/2020 - Tấn Thành: Thay đổi kiểu dữ liệu ReasonOtherFee
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'ReasonOtherFee')
BEGIN
	ALTER TABLE BEMT2010 ALTER COLUMN ReasonOtherFee NVARCHAR(MAX) NULL
END

--- 10/07/2020 - Tấn Thành: Thay đổi kiểu dữ liệu Accommodation
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'Accommodation')
BEGIN
	ALTER TABLE BEMT2010 ALTER COLUMN Accommodation NVARCHAR(MAX) NULL
END

--- 12/12/2020 - Vĩnh Tâm: Bổ sung cột ProcessID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2010' AND col.name = 'ProcessID')
BEGIN
	ALTER TABLE BEMT2010 ADD ProcessID VARCHAR(50) NULL
END