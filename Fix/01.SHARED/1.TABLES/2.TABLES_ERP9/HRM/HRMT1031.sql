---- Create by Nguyễn Hoàng Bảo Thy on 7/21/2017 2:34:35 PM
---- Thông tin tuyển dụng hồ sơ ứng viên

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT1031]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT1031]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [CandidateID] VARCHAR(50) NOT NULL,
  [RecPeriodID] VARCHAR(50) NULL,
  [DepartmentID] VARCHAR(50) NULL,
  [DutyID] VARCHAR(50) NULL,
  [RecruitStatus] VARCHAR(5) DEFAULT 0 NULL,
  [ReceiveFileDate] DATETIME NULL,
  [ReceiveFilePlace] NVARCHAR(250) NULL,
  [ResourceID] VARCHAR(50) NULL,
  [WorkType] TINYINT DEFAULT (0) NULL,
  [Startdate] DATETIME NULL,
  [RequireSalary] NVARCHAR(250) NULL,
  [RecReason] NVARCHAR(1000) NULL,
  [Strength] NVARCHAR(1000) NULL,
  [Weakness] NVARCHAR(1000) NULL,
  [CareerAim] NVARCHAR(1000) NULL,
  [PersonalAim] NVARCHAR(1000) NULL,
  [Aptitude] NVARCHAR(1000) NULL,
  [Hobby] NVARCHAR(1000) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT1031] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [CandidateID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---- Modified on 18/02/2019 by Bảo Anh: Bổ sung cột bảng đánh giá tuyển dụng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HRMT1031' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HRMT1031' AND col.name = 'EvaluationKitID') 
   ALTER TABLE HRMT1031 ADD EvaluationKitID VARCHAR(50) NULL 
END

---------------- 05/10/2022 - Tấn Lộc: Update độ dài dữ liệu cột CandidateID ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT1031' AND col.name = 'CandidateID')
BEGIN
	ALTER TABLE HRMT1031 ALTER COLUMN CandidateID VARCHAR(250) NOT NULL
END