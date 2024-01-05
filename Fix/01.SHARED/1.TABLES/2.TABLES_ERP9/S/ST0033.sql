---- Create by Trương Tấn Thành on 11/20/2020 8:51:30 AM
---- Bảng Automation

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST0033]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST0033]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [FromDate] DATETIME NULL,
  [TypeOfRecurrence] TINYINT DEFAULT (0) NULL,
  [RecurrenceValue] INT NULL,
  [DaysOfWeek] VARCHAR(250) NULL,
  [DaysOfMonth] VARCHAR(250) NULL,
  [WeekOfMonth] VARCHAR(250) NULL,
  [MonthOfYear] VARCHAR(250) NULL,
  [IsAdvancedSettings] TINYINT DEFAULT (0) NULL,
  [IsExpired] TINYINT DEFAULT (0) NULL,
  [ToDate] DATETIME NULL,
  [IsRepeat] TINYINT DEFAULT (0) NULL,
  [Duration] INT NULL,
  [TypeOfDuration] TINYINT DEFAULT (0) NULL,
  [RepeatTime] INT NULL,
  [TypeOfRepeatTime] TINYINT DEFAULT (0) NULL,
  [LastRunTime] DATETIME NULL,
  [LastRepeatRunTime] DATETIME NULL,
  [IsFirstRun] TINYINT DEFAULT (1) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_ST0033] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 30/11/2020 - Tấn Thành: Bổ sung cột ScheduleType
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0033' AND col.name = 'ScheduleType')
BEGIN
	ALTER TABLE ST0033 ADD ScheduleType TINYINT DEFAULT(0) 
END

--- 10/12/2020 - Tấn Thành: Bổ sung cột IsTrash
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0033' AND col.name = 'IsTrash')
BEGIN
	ALTER TABLE ST0033 ADD IsTrash TINYINT DEFAULT(1) 
END

--- 14/12/2020 - Tấn Thành: Bổ sung cột TimeRunBefore
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0033' AND col.name = 'TimeRunBefore')
BEGIN
	ALTER TABLE ST0033 ADD TimeRunBefore INT DEFAULT(1) 
END

--- 14/12/2020 - Tấn Thành: Bổ sung cột TypeOfTimeRunBefore
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0033' AND col.name = 'TypeOfTimeRunBefore')
BEGIN
	ALTER TABLE ST0033 ADD TypeOfTimeRunBefore TINYINT DEFAULT(1) 
END

--- 29/12/2020 - Tấn Thành: Thay đổi tên cột BusinessType => BusinessScreen
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0033' AND col.name = 'BusinessType')
BEGIN
	EXEC sp_RENAME 'ST0033.BusinessType', 'BusinessScreen', 'COLUMN'
END

--- 29/12/2020 - Tấn Thành: Bổ sung cột BusinessScreen
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0033' AND col.name = 'BusinessScreen')
BEGIN
	ALTER TABLE ST0033 ADD BusinessScreen VARCHAR(50) NULL 
END