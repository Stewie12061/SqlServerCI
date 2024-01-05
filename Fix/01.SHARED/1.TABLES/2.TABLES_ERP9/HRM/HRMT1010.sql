---- Create by Nguyễn Hoàng Bảo Thy on 7/18/2017 2:09:08 PM
---- Danh mục hình thức phỏng vấn (Master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT1010]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT1010]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [InterviewTypeID] VARCHAR(50) NOT NULL,
  [InterviewTypeName] NVARCHAR(1000) NULL,
  [DutyID] VARCHAR(50) NOT NULL,
  [Note] NVARCHAR(1000) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT1010] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [InterviewTypeID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT1010' AND col.name = 'Notes')
BEGIN
	ALTER TABLE HRMT1010 ALTER COLUMN Notes NVARCHAR(MAX) NULL
END
--Thu Hà Create 17/10/2023 --Bổ sung cột DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name]='HRMT1010' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id=tab.id WHERE tab.name='HRMT1010' and col.name='DeleteFlg')
	ALTER TABLE HRMT1010 ADD DeleteFlg TINYINT DEFAULT 0 NULL
END