---- Create by Nguyễn Hoàng Bảo Thy on 8/21/2017 1:59:48 PM
---- Lịch phỏng vấn (Master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2030]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2030]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [InterviewScheduleID] VARCHAR(50) NOT NULL,
  [Description] NVARCHAR(250) NULL,
  [InterviewLevel] INT NOT NULL,
  [RecruitPeriodID] VARCHAR(50) NOT NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT2030] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [InterviewScheduleID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
--Thu Hà Create 25/09/2023 --Bổ sung cột AssignedToUserID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name]='HRMT2030' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id=tab.id WHERE tab.name='HRMT2030' and col.name='AssignedToUserID')
	ALTER TABLE HRMT2030 ADD AssignedToUserID VARCHAR(250) NULL
END
--Thu Hà Create 17/10/2023 --Bổ sung cột DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name]='HRMT2030' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id=tab.id WHERE tab.name='HRMT2030' and col.name='DeleteFlg')
	ALTER TABLE HRMT2030 ADD DeleteFlg TINYINT DEFAULT 0 NULL
END
