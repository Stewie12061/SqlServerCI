---- Create by Nguyễn Hoàng Bảo Thy on 8/28/2017 10:49:10 AM
---- Quyết định tuyển dụng (master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2050]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2050]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [RecDecisionID] VARCHAR(50) NOT NULL,
  [RecDecisionNo] VARCHAR(50) NULL,
  [Description] NVARCHAR(1000) NULL,
  [DecisionDate] DATETIME NULL,
  [Status] TINYINT DEFAULT (0) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT2050] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [RecDecisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---- Modified on 18/02/2019 by Bảo Anh: Bổ sung cột APKMaster (= OOT9000.APK)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HRMT2050' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HRMT2050' AND col.name = 'APKMaster') 
		ALTER TABLE HRMT2050 ADD APKMaster UNIQUEIDENTIFIER NULL
END
--Thu Hà Create 17/10/2023 --Bổ sung cột DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name]='HRMT2050' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id=tab.id WHERE tab.name='HRMT2050' and col.name='DeleteFlg')
	ALTER TABLE HRMT2050 ADD DeleteFlg TINYINT DEFAULT 0 NULL
END