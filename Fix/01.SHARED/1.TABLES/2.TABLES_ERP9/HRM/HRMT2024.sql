---- Create by Nguyễn Hoàng Bảo Thy on 8/15/2017 2:57:10 PM
---- Đợt tuyển dụng: Yêu cầu tuyển dụng

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2024]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2024]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [RecruitPeriodID] VARCHAR(50) NOT NULL,
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
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT2024] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [RecruitPeriodID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---Modify on 05/09/2023 by Phương Thảo : Bổ sung cột RecruitRequireID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HRMT2024' AND xtype='U')
	BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HRMT2024' AND col.name='RecruitRequireID')
		ALTER TABLE HRMT2024 ADD RecruitRequireID VARCHAR(50) NULL
	END