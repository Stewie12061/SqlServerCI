---- Create by Nguyễn Hoàng Bảo Thy on 8/21/2017 3:02:24 PM
---- Kết quả vòng phỏng vấn

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2041]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2041]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [InterviewLevel] INT NOT NULL,
  [InterviewStatus] TINYINT NULL,
  [Comment] NVARCHAR(1000) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT2041] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-- Tấn Lộc Create 25/09/2023 -- Bổ sung cột InterviewDate và InterviewAddress
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HRMT2041' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HRMT2041' AND col.name = 'InterviewDate') 
   ALTER TABLE HRMT2041 ADD InterviewDate DateTime  NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HRMT2041' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HRMT2041' AND col.name = 'InterviewAddress') 
   ALTER TABLE HRMT2041 ADD InterviewAddress NVARCHAR(MAX)  NULL
END