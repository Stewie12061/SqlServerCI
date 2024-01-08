---- Create by Phan Hải Long on 9/18/2017 1:45:02 PM
---- Yêu cầu đào tạo

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2080]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2080]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [TrainingRequestID] NVARCHAR(50) NOT NULL,
  [DepartmentID] NVARCHAR(50) NULL,
  [TrainingFieldID] NVARCHAR(50) NULL,
  [NumberEmployee] INT NULL,
  [TrainingFromDate] DATETIME NULL,
  [TrainingToDate] DATETIME NULL,
  [Description1] NVARCHAR(1000) NULL,
  [Description2] NVARCHAR(1000) NULL,
  [AssignedToUserID] NVARCHAR(50) NULL,
  [CreateUserID] NVARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] NVARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT2080] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TrainingRequestID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 06/08/2020 - Trọng Kiên: Bổ sung cột AssignedToUserName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2080' AND col.name = 'AssignedToUserName')
BEGIN
	ALTER TABLE HRMT2080 ADD AssignedToUserName NVARCHAR(MAX) NULL
END

--- 17/10/2023 - Minh Trí: Bổ sung cột DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HRMT2080' AND xtype='U')
	BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HRMT2080' AND col.name='DeleteFlg')
		ALTER TABLE HRMT2080 ADD DeleteFlg TINYINT DEFAULT (0) NULL
	END