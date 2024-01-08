---- Create by Nguyễn Hoàng Bảo Thy on 8/28/2017 10:50:12 AM
---- Quyết định tuyển dụng (Detail)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2051]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2051]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [CandidateID] VARCHAR(50) NOT NULL,
  [RecDecisionID] VARCHAR(50) NOT NULL,
  [RecruitPeriodID] VARCHAR(50) NOT NULL,
  [Status] TINYINT DEFAULT (0) NULL,
  [IsTransferedHRM] TINYINT DEFAULT (0) NULL
CONSTRAINT [PK_HRMT2051] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---- Modified on 18/02/2019 by Bảo Anh: Bổ sung cột số cấp phải duyệt và số cấp đã duyệt, APKMaster (= OOT9000.APK)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HRMT2051' AND xtype = 'U')
BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HRMT2051' AND col.name = 'ApproveLevel') 
			ALTER TABLE HRMT2051 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HRMT2051' AND col.name = 'ApprovingLevel') 
			ALTER TABLE HRMT2051 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HRMT2051' AND col.name = 'APKMaster') 
			ALTER TABLE HRMT2051 ADD APKMaster UNIQUEIDENTIFIER NULL
END