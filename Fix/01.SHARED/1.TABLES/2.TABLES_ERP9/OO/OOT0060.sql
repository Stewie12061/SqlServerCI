---- Create by Khâu Vĩnh Tâm on 8/21/2019 8:52:59 PM
---- Thiết lập hệ thống module OO

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT0060]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT0060]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [VoucherTask] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_OOT0060] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
----------------
---- 09/10/2019 - Vĩnh Tâm: Bổ sung cột TaskHourDecimal --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0060' AND col.name = 'TaskHourDecimal')
BEGIN
	ALTER TABLE OOT0060 ADD TaskHourDecimal INT DEFAULT 0
END

---- 09/10/2019 - Vĩnh Tâm: Bổ sung cột VoucherStatus --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0060' AND col.name = 'VoucherStatus')
BEGIN
	ALTER TABLE OOT0060 ADD VoucherStatus VARCHAR(50) NULL
END

---- 09/10/2019 - Vĩnh Tâm: Bổ sung cột VoucherTaskSample --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0060' AND col.name = 'VoucherTaskSample')
BEGIN
	ALTER TABLE OOT0060 ADD VoucherTaskSample VARCHAR(50) NULL
END

---- 09/10/2019 - Vĩnh Tâm: Bổ sung cột VoucherStep --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0060' AND col.name = 'VoucherStep')
BEGIN
	ALTER TABLE OOT0060 ADD VoucherStep VARCHAR(50) NULL
END

---- 09/10/2019 - Vĩnh Tâm: Bổ sung cột VoucherProcess --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0060' AND col.name = 'VoucherProcess')
BEGIN
	ALTER TABLE OOT0060 ADD VoucherProcess VARCHAR(50) NULL
END

---- 09/10/2019 - Vĩnh Tâm: Bổ sung cột VoucherProjectSample --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0060' AND col.name = 'VoucherProjectSample')
BEGIN
	ALTER TABLE OOT0060 ADD VoucherProjectSample VARCHAR(50) NULL
END

---- 09/10/2019 - Vĩnh Tâm: Bổ sung cột VoucherProject --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0060' AND col.name = 'VoucherProject')
BEGIN
	ALTER TABLE OOT0060 ADD VoucherProject VARCHAR(50) NULL
END

---- 23/10/2019 - Tấn Lộc: Bổ sung cột VoucherIssues --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0060' AND col.name = 'VoucherIssues')
BEGIN
	ALTER TABLE OOT0060 ADD VoucherIssues VARCHAR(50) NULL
END

---- 07/11/2019 - Tấn Lộc: Bổ sung cột VoucherRequest --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0060' AND col.name = 'VoucherRequest')
BEGIN
	ALTER TABLE OOT0060 ADD VoucherRequest VARCHAR(50) NULL
END

---- 25/12/2019 - Tấn Lộc: Bổ sung cột VoucherMilestone --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0060' AND col.name = 'VoucherMilestone')
BEGIN
	ALTER TABLE OOT0060 ADD VoucherMilestone VARCHAR(50) NULL
END

---- 25/12/2019 - Tấn Lộc: Bổ sung cột VoucherRelease --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0060' AND col.name = 'VoucherRelease')
BEGIN
	ALTER TABLE OOT0060 ADD VoucherRelease VARCHAR(50) NULL
END

---- 25/12/2019 - Tấn Lộc: Bổ sung cột VoucherRelease --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT0060' AND col.name = 'VoucherBooking')
BEGIN
	ALTER TABLE OOT0060 ADD VoucherBooking VARCHAR(50) NULL
END
