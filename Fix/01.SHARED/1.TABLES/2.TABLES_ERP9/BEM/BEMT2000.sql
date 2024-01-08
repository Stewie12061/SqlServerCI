---- Create by Khâu Vĩnh Tâm on 5/26/2020 9:54:52 AM
---- Phiếu Đề nghị thanh toán/Đề nghị thanh toán tạm ứng/Đề nghị tạm ứng

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BEMT2000]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[BEMT2000]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [VoucherNo] VARCHAR(50) NULL,
  [VoucherDate] DATETIME NULL,
  [TypeID] VARCHAR(50) NULL,
  [DepartmentID] VARCHAR(50) NULL,
  [PhoneNumber] VARCHAR(50) NULL,
  [ApplicantID] VARCHAR(50) NULL,
  [MethodPay] VARCHAR(50) NULL,
  [FCT] TINYINT NULL,
  [AdvancePayment] DECIMAL(28,8) NULL,
  [AdvanceUserID] VARCHAR(50) NULL,
  [DueDate] DATETIME NULL,
  [PaymentTermID] VARCHAR(50) NULL,
  [Deadline] DATETIME NULL,
  [StatusID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [APKInherited] UNIQUEIDENTIFIER NULL,
  [InheritVoucherNo] VARCHAR(50) NULL,
  [ApprovingLevel] INT NULL,
  [ApprovedLevel] INT NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_BEMT2000] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 09/06/2020 - Vĩnh Tâm: Bổ sung cột APKMaster_9000, Levels, TranMonth, TranYear, TypeInherit --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'APKMaster_9000')
BEGIN
	ALTER TABLE BEMT2000 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'Levels')
BEGIN
	ALTER TABLE BEMT2000 ADD Levels VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'TranMonth')
BEGIN
	ALTER TABLE BEMT2000 ADD TranMonth INT NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'TranYear')
BEGIN
	ALTER TABLE BEMT2000 ADD TranYear INT NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'TypeInherit')
BEGIN
	EXEC SP_RENAME 'BEMT2000.TypeInherit', 'InheritType', 'COLUMN'
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'InheritType')
BEGIN
	ALTER TABLE BEMT2000 ADD InheritType VARCHAR(50) NULL
END

----------- 19/06/2020 - Vĩnh Tâm: Đổi tên cột ApprovedLevel, StatusID, Applicant -----------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'ApprovedLevel')
BEGIN
	EXEC SP_RENAME 'BEMT2000.ApprovedLevel', 'ApproveLevel', 'COLUMN'
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'StatusID')
BEGIN
	EXEC SP_RENAME 'BEMT2000.StatusID', 'Status', 'COLUMN'
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'Applicant')
BEGIN
	EXEC SP_RENAME 'BEMT2000.Applicant', 'ApplicantID', 'COLUMN'
END

-------------------- 14/07/2020 - Vĩnh Tâm: Bổ sung cột CurrencyID, ExchangeRate --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'CurrencyID')
BEGIN
	ALTER TABLE BEMT2000 ADD CurrencyID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'ExchangeRate')
BEGIN
	ALTER TABLE BEMT2000 ADD ExchangeRate DECIMAL(28,8) NULL
END

----------- 23/07/2020 - Tấn Thành: Bổ sung cột IsAutoCreated -----------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'IsAutoCreated')
BEGIN
	ALTER TABLE BEMT2000 ADD IsAutoCreated INT NULL
END

----------- 26/01/2021 - Vĩnh Tâm: Đổi tên cột Description thành DescriptionMaster vì trùng với tên cột tại Detail -----------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'Description')
BEGIN
	EXEC SP_RENAME 'BEMT2000.Description', 'DescriptionMaster', 'COLUMN'
END

-------------------- 19/01/2021 - Vĩnh Tâm: Bổ sung cột DescriptionMaster --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'DescriptionMaster')
BEGIN
	ALTER TABLE BEMT2000 ADD DescriptionMaster NVARCHAR(MAX) NULL
END

-------------------- 19/02/2021 - Trọng Kiên: Bổ sung cột ConvertedAdvancePayment --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'ConvertedAdvancePayment')
BEGIN
	ALTER TABLE BEMT2000 ADD ConvertedAdvancePayment DECIMAL(28,8) NULL
END

-------------------- 29/03/2021 - Đình Ly: Phân loại Nguồn hình thành --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'FormationID')
BEGIN
	ALTER TABLE BEMT2000 ADD FormationID VARCHAR(250) NULL
END

-------------------- 01/04/2021 - Trọng Kiên: Bổ sung cột IsInherited_2000 --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2000' AND col.name = 'IsInherited_2000')
BEGIN
	ALTER TABLE BEMT2000 ADD IsInherited_2000 TINYINT DEFAULT 0 NULL
END