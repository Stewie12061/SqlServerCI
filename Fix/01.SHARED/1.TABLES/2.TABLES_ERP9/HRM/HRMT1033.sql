---- Create by Nguyễn Hoàng Bảo Thy on 7/21/2017 2:37:17 PM
---- Kinh nghiệm làm việc hồ sơ ứng viên

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT1033]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT1033]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [CandidateID] VARCHAR(50) NULL,
  [CompanyName] NVARCHAR(1000) NULL,
  [CompanyAddress] NVARCHAR(1000) NULL,
  [CountryID] VARCHAR(50) NULL,
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [Duty] NVARCHAR(250) NULL,
  [Reason] NVARCHAR(1000) NULL,
  [Notes] NVARCHAR(1000) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT1033] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 05/10/2022 - Tấn Lộc: Update độ dài dữ liệu cột CandidateID ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT1033' AND col.name = 'CandidateID')
BEGIN
	ALTER TABLE HRMT1033 ALTER COLUMN CandidateID VARCHAR(250) NULL
END