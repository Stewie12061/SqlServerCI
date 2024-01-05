---- Create by Mai Trọng Kiên on 6/3/2020 11:59:28 AM
---- Phiếu đề nghị công tác

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BEMT2020]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[BEMT2020]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [VoucherNo] VARCHAR(50) NULL,
  [VoucherDate] DATETIME NULL,
  [TypeBSTripID] TINYINT DEFAULT (0) NULL,
  [AdvanceCurrencyID] VARCHAR(50) NULL,
  [CountryID] VARCHAR(50) NULL,
  [CityID] VARCHAR(50) NULL,
  [Purpose] NVARCHAR(250) NULL,
  [TheOthers] NVARCHAR(250) NULL,
  [CurrencyID] VARCHAR(50) NULL,
  [TotalFee] DECIMAL(28,8) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [FromDate] Date NULL,
  [ToDate] Date NULL,
  [AdvanceTotalFee] DECIMAL(28,8) NULL
CONSTRAINT [PK_BEMT2020] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 18/06/2020 - Trọng Kiên: Bổ sung cột StartDate ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'FromDate')
BEGIN
	EXEC SP_RENAME 'BEMT2020."FromDate"', 'StartDate', 'COLUMN'
END

---------------- 18/06/2020 - Trọng Kiên: Bổ sung cột EndDate ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'ToDate')
BEGIN
	EXEC SP_RENAME 'BEMT2020."ToDate"', 'EndDate', 'COLUMN'
END

---------------- 18/06/2020 - Trọng Kiên: Bổ sung cột CurrencyID1 ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'CurrencyID')
BEGIN
	EXEC SP_RENAME 'BEMT2020."CurrencyID"', 'CurrencyID1', 'COLUMN'
END

---------------- 18/06/2020 - Trọng Kiên: Bổ sung cột TotalFee1 ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'TotalFee')
BEGIN
	EXEC SP_RENAME 'BEMT2020."TotalFee"', 'TotalFee1', 'COLUMN'
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột APKMaster_9000
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'APKMaster_9000')
BEGIN
	ALTER TABLE BEMT2020 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột StatusID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'StatusID')
BEGIN
	ALTER TABLE BEMT2020 ADD StatusID VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột Note
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'Note')
BEGIN
	ALTER TABLE BEMT2020 ADD Note NVARCHAR(MAX) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột Levels
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'Levels')
BEGIN
	ALTER TABLE BEMT2020 ADD Levels INT NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột APKMaster
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'APKMaster')
BEGIN
	ALTER TABLE BEMT2020 ADD APKMaster UNIQUEIDENTIFIER NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột DivisionID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'DivisionID')
BEGIN
	ALTER TABLE BEMT2020 ADD DivisionID VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột WorkProposal
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'WorkProposal')
BEGIN
	ALTER TABLE BEMT2020 ADD WorkProposal VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột Applicant
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'Applicant')
BEGIN
	ALTER TABLE BEMT2020 ADD Applicant VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột Rank
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'Rank')
BEGIN
	ALTER TABLE BEMT2020 ADD Rank VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột TitleID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'TitleID')
BEGIN
	ALTER TABLE BEMT2020 ADD TitleID VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột DepartmentID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'DepartmentID')
BEGIN
	ALTER TABLE BEMT2020 ADD DepartmentID VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột SectionID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'SectionID')
BEGIN
	ALTER TABLE BEMT2020 ADD SectionID VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột SubsectionID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'SubsectionID')
BEGIN
	ALTER TABLE BEMT2020 ADD SubsectionID VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột TeamID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'TeamID')
BEGIN
	ALTER TABLE BEMT2020 ADD TeamID VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột ObjectID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'ObjectID')
BEGIN
	ALTER TABLE BEMT2020 ADD ObjectID VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột TotalDate
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'TotalDate')
BEGIN
	ALTER TABLE BEMT2020 ADD TotalDate FLOAT NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột Journeys
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'Journeys')
BEGIN
	ALTER TABLE BEMT2020 ADD Journeys NVARCHAR(250) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột Notes
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'Notes')
BEGIN
	ALTER TABLE BEMT2020 ADD Notes NVARCHAR(MAX) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột NoteFee
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'NoteFee')
BEGIN
	ALTER TABLE BEMT2020 ADD NoteFee NVARCHAR(MAX) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột CurrencyID2
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'CurrencyID2')
BEGIN
	ALTER TABLE BEMT2020 ADD CurrencyID2 VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột CurrencyID3
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'CurrencyID3')
BEGIN
	ALTER TABLE BEMT2020 ADD CurrencyID3 VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột CurrencyID4
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'CurrencyID4')
BEGIN
	ALTER TABLE BEMT2020 ADD CurrencyID4 VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột CurrencyID5
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'CurrencyID5')
BEGIN
	ALTER TABLE BEMT2020 ADD CurrencyID5 VARCHAR(50) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột TotalFee2
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'TotalFee2')
BEGIN
	ALTER TABLE BEMT2020 ADD TotalFee2 DECIMAL(28) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột TotalFee3
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'TotalFee3')
BEGIN
	ALTER TABLE BEMT2020 ADD TotalFee3 DECIMAL(28) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột TotalFee4
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'TotalFee4')
BEGIN
	ALTER TABLE BEMT2020 ADD TotalFee4 DECIMAL(28) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột TotalFee5
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'TotalFee5')
BEGIN
	ALTER TABLE BEMT2020 ADD TotalFee5 DECIMAL(28) NULL
END

--- 19/06/2020 - Trọng Kiên: Bổ sung cột ApproveLevel
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'ApproveLevel')
BEGIN
	ALTER TABLE BEMT2020 ADD ApproveLevel INT NULL
END

--- 19/06/2020 - Trọng Kiên: Bổ sung cột ApprovingLevel
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'ApprovingLevel')
BEGIN
	ALTER TABLE BEMT2020 ADD ApprovingLevel INT NULL
END

--- 19/06/2020 - Trọng Kiên: Bổ sung cột Status
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'Status')
BEGIN
	ALTER TABLE BEMT2020 ADD Status VARCHAR(50) NULL
END

--- 10/07/2020 - Trọng Kiên: Thay đổi kiểu dữ liệu Purpose
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'Purpose')
BEGIN
	ALTER TABLE BEMT2020 ALTER COLUMN Purpose NVARCHAR(MAX) NULL
END

--- 10/07/2020 - Trọng Kiên: Thay đổi kiểu dữ liệu TheOthers
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'TheOthers')
BEGIN
	ALTER TABLE BEMT2020 ALTER COLUMN TheOthers NVARCHAR(MAX) NULL
END

--- 10/07/2020 - Trọng Kiên: Thay đổi kiểu dữ liệu NoteFee
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'NoteFee')
BEGIN
	ALTER TABLE BEMT2020 ALTER COLUMN NoteFee NVARCHAR(MAX) NULL
END

--- 23/02/2021 - Văn Tài: Thay đổi kiểu dữ liệu TypeBSTripID
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2020' AND col.name = 'TypeBSTripID')
BEGIN
	declare @name nvarchar(100)
	select @name = o.name from sys.objects o join sys.columns col on o.object_id = col.default_object_id 
	where type = 'D' 
			and parent_object_id = object_id('BEMT2020') 
			and  col.name = 'TypeBSTripID'

	if (@name is not null)
	  begin
		 exec ('alter table [BEMT2020] drop constraint [' + @name +']')
	  end

	ALTER TABLE BEMT2020 ALTER COLUMN TypeBSTripID NVARCHAR(50) NULL
END