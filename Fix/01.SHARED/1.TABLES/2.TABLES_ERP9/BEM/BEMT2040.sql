---- Create by Mai Trọng Kiên on 5/28/2020 10:55:28 AM
---- Báo cáo công tác

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BEMT2040]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[BEMT2040]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [DivisionID] VARCHAR(50) NULL,
  [VoucherNo] VARCHAR(50) NULL,
  [WorkProposal] NVARCHAR(MAX) NULL,
  [Applicant] NVARCHAR(250) NULL,
  [DateReport] DateTime NULL,
  [WorkPlace] NVARCHAR(250) NULL,
  [WorkDate] DateTime NULL,
  [SubsectionID] VARCHAR(50) NULL,
  [Purpose] NVARCHAR(250) NULL,
  [WorkResults] NVARCHAR(MAX) NULL,
  [ContentDetails] NVARCHAR(MAX) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_BEMT2040] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột APKMaster_9000
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2040' AND col.name = 'APKMaster_9000')
BEGIN
	ALTER TABLE BEMT2040 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột StatusID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2040' AND col.name = 'StatusID')
BEGIN
	ALTER TABLE BEMT2040 ADD StatusID VARCHAR(50) NULL
END
--- 18/06/2020 - Trọng Kiên: Bổ sung cột Note
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2040' AND col.name = 'Note')
BEGIN
	ALTER TABLE BEMT2040 ADD Note NVARCHAR(MAX) NULL
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột Levels
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2040' AND col.name = 'Levels')
BEGIN
	ALTER TABLE BEMT2040 ADD Levels INT NULL
END

--- 19/06/2020 - Trọng Kiên: Bổ sung cột ApproveLevel
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2040' AND col.name = 'ApproveLevel')
BEGIN
	ALTER TABLE BEMT2040 ADD ApproveLevel INT NULL
END

--- 19/06/2020 - Trọng Kiên: Bổ sung cột ApprovingLevel
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2040' AND col.name = 'ApprovingLevel')
BEGIN
	ALTER TABLE BEMT2040 ADD ApprovingLevel INT NULL
END

--- 19/06/2020 - Trọng Kiên: Bổ sung cột Status
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2040' AND col.name = 'Status')
BEGIN
	ALTER TABLE BEMT2040 ADD Status VARCHAR(50) NULL
END

--- 10/07/2020 - Trọng Kiên: Thay đổi kiểu dữ liệu Purpose
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2040' AND col.name = 'Purpose')
BEGIN
	ALTER TABLE BEMT2040 ALTER COLUMN Purpose NVARCHAR(MAX) NULL
END