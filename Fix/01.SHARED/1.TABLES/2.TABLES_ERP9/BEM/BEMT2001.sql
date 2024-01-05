---- Create by Khâu Vĩnh Tâm on 5/26/2020 9:56:17 AM
---- Detail phiếu Đề nghị thanh toán/Đề nghị thanh toán tạm ứng/Đề nghị tạm ứng

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BEMT2001]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[BEMT2001]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [APKMInherited] UNIQUEIDENTIFIER NULL,
  [APKDInherited] UNIQUEIDENTIFIER NULL,
  [InheritVoucherNo] VARCHAR(50) NULL,
  [InheritType] VARCHAR(50) NULL,
  [CostAnaID] VARCHAR(50) NULL,
  [DepartmentAnaID] VARCHAR(50) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [RingiNo] VARCHAR(50) NULL,
  [InvoiceNo] VARCHAR(50) NULL,
  [InvoiceDate] DATETIME NULL,
  [FeeID] VARCHAR(50) NULL,
  [CurrencyID] VARCHAR(50) NULL,
  [ExchangeRate] DECIMAL(28,8) NULL,
  [RequestAmount] DECIMAL(28,8) NULL,
  [BankAccountName] NVARCHAR(250) NULL,
  [ConvertedRequestAmount] DECIMAL(28,8) NULL,
  [SpendAmount] DECIMAL(28,8) NULL,
  [ConvertedSpendAmount] DECIMAL(28,8) NULL,
  [BankAccountID] VARCHAR(50) NULL,
  [ApprovingLevel] INT NULL,
  [StatusID] VARCHAR(50) NULL,
  [ApproveLevel] INT NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_BEMT2001] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 03/06/2020 - Vĩnh Tâm: Bổ sung cột APKMaster
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'APKMaster')
BEGIN
	ALTER TABLE BEMT2001 ADD APKMaster UNIQUEIDENTIFIER NULL
END

-------------------- 11/06/2020 - Vĩnh Tâm: Bổ sung cột RemainingAmount --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'RemainingAmount')
BEGIN
	ALTER TABLE BEMT2001 ADD RemainingAmount DECIMAL(28,8) NULL
END
 
-------------------- 12/06/2020 - Vĩnh Tâm: Bổ sung cột APKMaster_9000, ApprovalNotes, ApprovalDate --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'APKMaster_9000')
BEGIN
	ALTER TABLE BEMT2001 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'ApprovalNotes')
BEGIN
	ALTER TABLE BEMT2001 ADD ApprovalNotes NVARCHAR(500) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'ApprovalDate')
BEGIN
	ALTER TABLE BEMT2001 ADD ApprovalDate DATETIME NULL
END

-------------------- 19/06/2020 - Vĩnh Tâm: Đổi tên cột ApprovedLevel, StatusID, DeparmentAnaID --------------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'ApprovedLevel')
   AND NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
       ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'ApproveLevel')
BEGIN
	EXEC SP_RENAME 'BEMT2001.ApprovedLevel', 'ApproveLevel', 'COLUMN'
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'StatusID')
BEGIN
	EXEC SP_RENAME 'BEMT2001.StatusID', 'Status', 'COLUMN'
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'DeparmentAnaID')
BEGIN
	EXEC SP_RENAME 'BEMT2001.DeparmentAnaID', 'DepartmentAnaID', 'COLUMN'
END
 
-------------------- 20/06/2020 - Vĩnh Tâm: Bổ sung cột OrderNo, DepartmentAnaID, DebitAccountID, CreditAccountID, MediumAccountID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'OrderNo')
BEGIN
	ALTER TABLE BEMT2001 ADD OrderNo INT NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'DepartmentAnaID')
BEGIN
	ALTER TABLE BEMT2001 ADD DepartmentAnaID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'DebitAccountID')
BEGIN
	ALTER TABLE BEMT2001 ADD DebitAccountID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'CreditAccountID')
BEGIN
	ALTER TABLE BEMT2001 ADD CreditAccountID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'MediumAccountID')
BEGIN
	ALTER TABLE BEMT2001 ADD MediumAccountID VARCHAR(50) NULL
END

-------------------- 08/07/2020 - Vĩnh Tâm: Bổ sung cột ListAPKDInherited --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'ListAPKDInherited')
BEGIN
	ALTER TABLE BEMT2001 ADD ListAPKDInherited VARCHAR(MAX) NULL
END

-------------------- 31/03/2021 - Đình Ly: Bổ sung cột TVoucherID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'TVoucherID')
BEGIN
	ALTER TABLE BEMT2001 ADD TVoucherID VARCHAR(MAX) NULL
END

-------------------- 31/03/2021 - Đình Ly: Bổ sung cột TBatchID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'TBatchID')
BEGIN
	ALTER TABLE BEMT2001 ADD TBatchID VARCHAR(MAX) NULL
END

-------------------- 30/03/2021 - Trọng Kiên: Bổ sung cột ConvertedGeneralAmount --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2001' AND col.name = 'ConvertedGeneralAmount')
BEGIN
	ALTER TABLE BEMT2001 ADD ConvertedGeneralAmount DECIMAL(28,8) NULL
END
