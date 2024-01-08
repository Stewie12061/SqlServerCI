---- Create by Cao Thị Phượng on 9/22/2017 3:53:46 PM
---- Thiết lập thời gian làm việc

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT0030]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT0030]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [YearID] VARCHAR(50) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [RelatedToTypeID] INT NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_OOT0030] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 23/04/2020 - Vĩnh Tâm: Bổ sung cột PunishLate --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT0030' AND col.name = 'PunishLate')
BEGIN
  ALTER TABLE OOT0030 ADD PunishLate DECIMAL(28,8) NULL
END
