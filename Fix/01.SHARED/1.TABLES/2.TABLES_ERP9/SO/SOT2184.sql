---- Create by Kiều Nga on 11/02/2020
---- Dự toán ( MAITHU = 107) Detail

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT2114]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT2114]
(
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
	[TranMonth] INT NULL,
	[Tranyear] INT NULL,
	[DeleteFlg] TINYINT DEFAULT (0) NULL,
	[KindSuppliers]  NVARCHAR(50) NULL,
	[MaterialID]  NVARCHAR(50) NULL,
	[CartonQuantitation]  DECIMAL(28,8) NULL,
	[UnitID]  NVARCHAR(50) NULL,
	[Quantity] DECIMAL(28,8) NULL,
	[UnitPrice] DECIMAL(28,8) NULL,
	[Amount] DECIMAL(28,8) NULL,
 
CONSTRAINT [PK_CRMT2114] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-- Đình Ly on 08/12/2020

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'PhaseOrder') 
	ALTER TABLE CRMT2114 ADD PhaseOrder INT NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'DisplayName') 
	ALTER TABLE CRMT2114 ADD DisplayName NVARCHAR(500) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'GluingTypeID') 
	ALTER TABLE CRMT2114 ADD GluingTypeID VARCHAR(250) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'QuantityRunWave') 
	ALTER TABLE CRMT2114 ADD QuantityRunWave DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'UnitSizeID') 
	ALTER TABLE CRMT2114 ADD UnitSizeID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'CartonQuantitation') 
	ALTER TABLE CRMT2114 DROP COLUMN CartonQuantitation
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'PhaseID') 
	ALTER TABLE CRMT2114 ADD PhaseID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'Size') 
	ALTER TABLE CRMT2114 ADD Size DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'Cut') 
	ALTER TABLE CRMT2114 ADD Cut DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'Child') 
	ALTER TABLE CRMT2114 ADD Child DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'PrintTypeID')
	ALTER TABLE CRMT2114 ADD PrintTypeID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'RunPaperID')
	ALTER TABLE CRMT2114 ADD RunPaperID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'RunWavePaper')
	ALTER TABLE CRMT2114 ADD RunWavePaper VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'SplitSheets') 
	ALTER TABLE CRMT2114 ADD SplitSheets DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'MoldID') 
	ALTER TABLE CRMT2114 ADD MoldID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'MoldStatusID') 
	ALTER TABLE CRMT2114 ADD MoldStatusID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'MoldDate') 
	ALTER TABLE CRMT2114 ADD MoldDate DATETIME NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'Gsm') 
	ALTER TABLE CRMT2114 ADD Gsm DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'Sheets') 
	ALTER TABLE CRMT2114 ADD Sheets DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'Ram') 
	ALTER TABLE CRMT2114 ADD Ram DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'Kg') 
	ALTER TABLE CRMT2114 ADD Kg DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'M2') 
	ALTER TABLE CRMT2114 ADD M2 DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'AmountLoss') 
	ALTER TABLE CRMT2114 ADD AmountLoss DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'PercentLoss') 
	ALTER TABLE CRMT2114 ADD PercentLoss DECIMAL(28,8) NULL
END

-- Kiều Nga on 11/02/2020

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'APKMaster_9000')
    ALTER TABLE CRMT2114 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'ApproveLevel') 
	ALTER TABLE CRMT2114 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'ApprovingLevel') 
	ALTER TABLE CRMT2114 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'Status') 
	ALTER TABLE CRMT2114 ADD [Status] TINYINT NOT NULL DEFAULT(0)
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S01ID') 
	ALTER TABLE CRMT2114 ADD S01ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S02ID') 
	ALTER TABLE CRMT2114 ADD S02ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S03ID') 
	ALTER TABLE CRMT2114 ADD S03ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S04ID') 
	ALTER TABLE CRMT2114 ADD S04ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S05ID') 
	ALTER TABLE CRMT2114 ADD S05ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S06ID') 
	ALTER TABLE CRMT2114 ADD S06ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S07ID') 
	ALTER TABLE CRMT2114 ADD S07ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S08ID') 
	ALTER TABLE CRMT2114 ADD S08ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S09ID') 
	ALTER TABLE CRMT2114 ADD S09ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S10ID') 
	ALTER TABLE CRMT2114 ADD S10ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S11ID') 
	ALTER TABLE CRMT2114 ADD S11ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S12ID') 
	ALTER TABLE CRMT2114 ADD S12ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S13ID') 
	ALTER TABLE CRMT2114 ADD S13ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S14ID') 
	ALTER TABLE CRMT2114 ADD S14ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S15ID') 
	ALTER TABLE CRMT2114 ADD S15ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S16ID') 
	ALTER TABLE CRMT2114 ADD S16ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S17ID') 
	ALTER TABLE CRMT2114 ADD S17ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S18ID') 
	ALTER TABLE CRMT2114 ADD S18ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S19ID') 
	ALTER TABLE CRMT2114 ADD S19ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'S20ID') 
	ALTER TABLE CRMT2114 ADD S20ID NVARCHAR(50) NULL
END

-- Đình Hòa 05/07/2021 : Bổ sung cột ghi chú NotesDetail
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2114' AND col.name = 'NoteDetail') 
	ALTER TABLE CRMT2114 ADD NoteDetail NVARCHAR(MAX) NULL
END
