---- Create by Phan thanh hoàng vũ on 11/2/2017 3:51:17 PM
---- Thiết lập thời gian lặp lại

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT0033]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT0033]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [InheritVoucherID] UNIQUEIDENTIFIER NULL,
  [InheritTableID] VARCHAR(50) NULL,
  [RecurrenceTypeID] INT NULL,
  [EveryDays] TINYINT NULL,
  [DayNumber] INT NULL,
  [EveryWeekday] TINYINT NULL,
  [DayOfMonthYear] TINYINT NULL,
  [DayOfMonthYear1] TINYINT NULL,
  [IsSunday] TINYINT DEFAULT (0) NULL,
  [IsMonday] TINYINT DEFAULT (0) NULL,
  [IsTuesday] TINYINT DEFAULT (0) NULL,
  [IsWednesday] TINYINT DEFAULT (0) NULL,
  [IsThursday] TINYINT DEFAULT (0) NULL,
  [IsFriday] TINYINT DEFAULT (0) NULL,
  [IsSaturday] TINYINT DEFAULT (0) NULL,
  [TheDays] VARCHAR(250) NULL,
  [TheDay] INT NULL,
  [TheMonth] INT NULL,
  [TheMonth1] INT NULL,
  [DayOfWeek] INT NULL,
  [DayOfWeek1] INT NULL,
  [WeekOfMonth] INT NULL,
  [WeekOfMonth1] INT NULL,
  [FromDate] DATETIME NULL,
  [IsToDate] TINYINT DEFAULT (0) NULL,
  [ToDate] DATETIME NULL,
  [StartTime] DATETIME NULL,
  [EndTime] DATETIME NULL,
  [IsReminder] TINYINT DEFAULT (0) NULL,
  [Reminder] VARCHAR(50) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_OOT0033] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 13/11/2019 - Truong Lam: Bổ sung cột IsNumberOfRepeat - Số lần lặp lại----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0033' AND col.name = 'IsNumberOfRepeat')
BEGIN
  ALTER TABLE OOT0033 ADD IsNumberOfRepeat INT NULL
END

---------------- 13/11/2019 - Truong Lam: Bổ sung cột TypeOfRepeatID - Số lần lặp lại----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0033' AND col.name = 'TypeOfRepeatID')
BEGIN
  ALTER TABLE OOT0033 ADD TypeOfRepeatID TINYINT NULL
END

---------------- 02/12/2019 - Truong Lam: Bổ sung cột TheMonthYear ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0033' AND col.name = 'TheMonthYear')
BEGIN
  ALTER TABLE OOT0033 ADD TheMonthYear INT NULL
END

---------------- 02/12/2019 - Truong Lam: Bổ sung cột TheMonthYear1 ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0033' AND col.name = 'TheMonthYear1')
BEGIN
  ALTER TABLE OOT0033 ADD TheMonthYear1 INT NULL
END

---------------- 02/12/2019 - Truong Lam: Bổ sung cột TheYear1 ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0033' AND col.name = 'TheYear1')
BEGIN
  ALTER TABLE OOT0033 ADD TheYear1 INT NULL
END

---------------- 02/12/2019 - Truong Lam: Bổ sung cột TheYear ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0033' AND col.name = 'TheYear')
BEGIN
  ALTER TABLE OOT0033 ADD TheYear INT NULL
END