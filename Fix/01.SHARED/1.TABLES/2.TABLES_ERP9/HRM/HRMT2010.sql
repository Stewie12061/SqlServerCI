---- Create by Nguyễn Hoàng Bảo Thy on 8/10/2017 1:38:51 PM
---- Yêu cầu tuyển dụng

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2010]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2010]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [RecruitRequireID] VARCHAR(50) NOT NULL,
  [RecruitRequireName] NVARCHAR(250) NULL,
  [DutyID] VARCHAR(50) NOT NULL,
  [Gender] VARCHAR(5) NULL,
  [FromAge] INT NULL,
  [ToAge] INT NULL,
  [Appearance] NVARCHAR(250) NULL,
  [Experience] NVARCHAR(250) NULL,
  [EducationLevelID] VARCHAR(50) NULL,
  [FromSalary] DECIMAL(28,8) NULL,
  [ToSalary] DECIMAL(28,8) NULL,
  [WorkDescription] NVARCHAR(2000) NULL,
  [Language1ID] VARCHAR(50) NULL,
  [Language2ID] VARCHAR(50) NULL,
  [Language3ID] VARCHAR(50) NULL,
  [LanguageLevel1ID] VARCHAR(50) NULL,
  [LanguageLevel2ID] VARCHAR(50) NULL,
  [LanguageLevel3ID] VARCHAR(50) NULL,
  [IsInformatics] TINYINT DEFAULT (0) NULL,
  [InformaticsLevel] NVARCHAR(2000) NULL,
  [IsCreativeness] TINYINT DEFAULT (0) NULL,
  [Creativeness] NVARCHAR(2000) NULL,
  [IsProblemSolving] TINYINT DEFAULT (0) NULL,
  [ProblemSolving] NVARCHAR(2000) NULL,
  [IsPrsentation] TINYINT DEFAULT (0) NULL,
  [Prsentation] NVARCHAR(2000) NULL,
  [IsCommunication] TINYINT DEFAULT (0) NULL,
  [Communication] NVARCHAR(2000) NULL,
  [Height] NVARCHAR(50) NULL,
  [Weight] NVARCHAR(50) NULL,
  [HealthStatus] NVARCHAR(250) NULL,
  [Notes] NVARCHAR(2000) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT2010] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [RecruitRequireID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
--- 12/10/2023 - Phương Thảo: Bổ sung cột DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HRMT2010' AND xtype='U')
	BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HRMT2010' AND col.name='DeleteFlg')
		ALTER TABLE HRMT2010 ADD DeleteFlg TINYINT DEFAULT (0) NULL
	END