---- Create by Nguyễn Hoàng Bảo Thy on 7/21/2017 2:33:16 PM
---- Thông tin cá nhân hồ sơ ứng viên

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT1030]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT1030]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [CandidateID] VARCHAR(50) NOT NULL,
  [LastName] NVARCHAR(250) NULL,
  [MiddleName] NVARCHAR(250) NULL,
  [FirstName] NVARCHAR(250) NULL,
  [ImageID] IMAGE NULL,
  [RecruitStatus] TINYINT DEFAULT (0) NULL,
  [Gender] VARCHAR(5) NULL,
  [Birthday] DATETIME NULL,
  [BornPlace] NVARCHAR(1000) NULL,
  [NationalityID] VARCHAR(50) NULL,
  [ReligionID] VARCHAR(50) NULL,
  [NativeCountry] NVARCHAR(1000) NULL,
  [IdentifyCardNo] NVARCHAR(50) NULL,
  [IdentifyPlace] NVARCHAR(250) NULL,
  [IdentifyCityID] VARCHAR(50) NULL,
  [IdentifyDate] DATETIME NULL,
  [IdentifyEnd] DATETIME NULL,
  [IsSingle] TINYINT DEFAULT (0) NULL,
  [HealthStatus] NVARCHAR(250) NULL,
  [Height] NVARCHAR(50) NULL,
  [Weight] NVARCHAR(50) NULL,
  [PassportNo] NVARCHAR(250) NULL,
  [PassportDate] DATETIME NULL,
  [PassportEnd] DATETIME NULL,
  [PermanentAddress] NVARCHAR(1000) NULL,
  [TemporaryAddress] NVARCHAR(1000) NULL,
  [EthnicID] VARCHAR(50) NULL,
  [PhoneNumber] NVARCHAR(250) NULL,
  [Email] NVARCHAR(250) NULL,
  [Fax] NVARCHAR(250) NULL,
  [Note] NVARCHAR(250) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT1030] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [CandidateID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END