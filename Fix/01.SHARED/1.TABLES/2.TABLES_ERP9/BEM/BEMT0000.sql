---- Create by Khâu Vĩnh Tâm on 5/21/2020 10:17:29 AM
---- Thiết lập chung module BEM

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BEMT0000]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[BEMT0000]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [ProposalVoucher] VARCHAR(50) NULL,
  [BSTripProposalVoucher] VARCHAR(50) NULL,
  [BSTripTimeVoucher] VARCHAR(50) NULL,
  [BSTripReportVoucher] VARCHAR(50) NULL,
  [TravelExpensesVoucher] VARCHAR(50) NULL,
  [TranslateDocVoucher] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_BEMT0000] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 02/06/2020 - Vĩnh Tâm: Bổ sung cột TranMonth, TranYear
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT0000' AND col.name = 'TranMonth')
BEGIN
	ALTER TABLE BEMT0000 ADD TranMonth INT
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT0000' AND col.name = 'TranYear')
BEGIN
	ALTER TABLE BEMT0000 ADD TranYear INT
END

--- 03/06/2020 - Vĩnh Tâm: Bổ sung các cột MPT Phòng ban, MPT Bộ phận, MPT Chi phí
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT0000' AND col.name = 'DepartmentAnaID')
BEGIN
	ALTER TABLE BEMT0000 ADD DepartmentAnaID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT0000' AND col.name = 'SubsectionAnaID')
BEGIN
	ALTER TABLE BEMT0000 ADD SubsectionAnaID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT0000' AND col.name = 'CostAnaID')
BEGIN
	ALTER TABLE BEMT0000 ADD CostAnaID VARCHAR(50) NULL
END

--- 20/07/2020 - Vĩnh Tâm: Bổ sung các cột ReportCurrencyID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT0000' AND col.name = 'ReportCurrencyID')
BEGIN
	ALTER TABLE BEMT0000 ADD ReportCurrencyID VARCHAR(50) NULL
END
