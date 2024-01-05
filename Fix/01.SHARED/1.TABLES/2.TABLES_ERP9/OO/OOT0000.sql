---- Create by Trương Ngọc Phương Thảo on 6/26/2017 10:41:00 AM
---- Modified by Vĩnh Tâm on 16/10/2019
---- Thiết lập hệ thống

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT0000]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT0000]
(
  [DivisionID] NVARCHAR(50) NOT NULL,
  [HMaxPerMonth] DECIMAL(28,8) NULL,
  [HMaxPerTime] DECIMAL(28,8) NULL,
  [TMaxPerMonth] INT NULL,
  [NoSalaryAbsentID] NVARCHAR(50) NULL,
  [MinusSalaryAbsentID] NVARCHAR(50) NULL,
  [DayExp] INT NULL
CONSTRAINT [PK_OOT0000] PRIMARY KEY CLUSTERED
(
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 16/10/2019 - Vĩnh Tâm: Bổ sung cột TranMonth, TranYear
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0000' AND col.name = 'TranMonth')
BEGIN
	ALTER TABLE OOT0000 ADD TranMonth INT
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0000' AND col.name = 'TranYear')
BEGIN
	ALTER TABLE OOT0000 ADD TranYear INT
END
