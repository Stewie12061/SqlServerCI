---- Create by Trà Giang on 26/11/2019
---- Updated by Đình Ly on 10/12/2020
---- Deatail Dự toán( MAITHU = 107) Detail

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT2111]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT2111]
(
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[APKMInherited] [uniqueidentifier] NULL,
	[APKDInherited] [uniqueidentifier] NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
	[TranMonth] INT NULL,
	[Tranyear] INT NULL,
	[DeleteFlg] TINYINT DEFAULT (0) NULL,
	[PaperTypeID] VARCHAR(50) NOT NULL,
	[ActualQuantity] INT NULL,
	[Notes] NVARCHAR(250) NULL,
	[Length] INT NULL,
	[Width] INT NULL,
	[Height] INT NULL,
	[PrintTypeID] VARCHAR(50) NULL,
	[PrintNumber] INT NULL,
	[SideColor1] TINYINT NULL,
	[ColorPrint01] NVARCHAR(250) NULL,
	[SideColor2] TINYINT NULL,
	[ColorPrint02] NVARCHAR(250) NULL,
	[AmountLoss] DECIMAL(28,8) NULL,
	[PercentLoss] DECIMAL(28,8) NULL,
	[OffsetQuantity] DECIMAL(28,8) NULL,
	[FilmDate] DATETIME NULL,
	[FilmStatus] NVARCHAR(50) NULL,
	[MoldStatus] NVARCHAR(50) NULL,
	[TotalVariableFee]  DECIMAL(28,8) NULL,
	[PercentCost]  DECIMAL(28,8) NULL,
	[Cost]  DECIMAL(28,8) NULL,
	[PercentProfit]  DECIMAL(28,8) NULL,
	[Profit]  DECIMAL(28,8) NULL,
	[InvenUnitPrice]  DECIMAL(28,8) NULL,
	[SquareMetersPrice]  DECIMAL(28,8) NULL,
	[ExchangeRate]  DECIMAL(28,8) NULL,
	[CurrencyID] NVARCHAR(50) NULL

CONSTRAINT [PK_CRMT2111] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---- Modified by Đình Ly on 12/12/2020: Bổ sung column FileName (File đính kèm)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2111' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'FileName')
    ALTER TABLE CRMT2111 ADD FileName NVARCHAR(50) NULL
END

---- Modified by Đình Ly on 12/12/2020: Drop column MoldStatus (Trạng thái khuôn)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2111' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'MoldStatus')
	ALTER TABLE CRMT2111 DROP COLUMN MoldStatus
END

---- Modified by Đình Hòa on 07/01/2021 START
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'ContentSampleDate')
BEGIN
	ALTER TABLE CRMT2111 ADD ContentSampleDate NVARCHAR(250) NULL
END
ELSE
BEGIN
	ALTER TABLE CRMT2111 ALTER COLUMN ContentSampleDate NVARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'ColorSampleDate')
BEGIN
	ALTER TABLE CRMT2111 ADD ColorSampleDate NVARCHAR(250) NULL
END
ELSE
BEGIN
	ALTER TABLE CRMT2111 ALTER COLUMN ColorSampleDate NVARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'MTSignedSampleDate')
BEGIN
	ALTER TABLE CRMT2111 ADD MTSignedSampleDate NVARCHAR(250) NULL
END
ELSE
BEGIN
	ALTER TABLE CRMT2111 ALTER COLUMN MTSignedSampleDate NVARCHAR(250) NULL
END
---- Modified by Đình Hòa on 07/01/2021 END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'FileLength')
BEGIN
	ALTER TABLE CRMT2111 ADD FileLength DECIMAL(28,8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'FileWidth')
BEGIN
	ALTER TABLE CRMT2111 ADD FileWidth DECIMAL(28,8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'FileSum')
BEGIN
	ALTER TABLE CRMT2111 ADD FileSum DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2111' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'FileUnitID')
    ALTER TABLE CRMT2111 ADD FileUnitID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'Include')
BEGIN
	ALTER TABLE CRMT2111 ADD Include NVARCHAR(50) NULL
END

---- Modified by Kiều Nga on 18/10/2022 bổ sung cột TotalProfitCost 
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'TotalProfitCost')
BEGIN
	ALTER TABLE CRMT2111 ADD TotalProfitCost DECIMAL(28,8) NULL
END

---- Modified by Kiều Nga on 18/10/2022 bổ sung cột TotalAmount 
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'TotalAmount')
BEGIN
	ALTER TABLE CRMT2111 ADD TotalAmount DECIMAL(28,8) NULL
END

---- Modified by Văn Tài on 28/02/2023 bổ sung cột TotalSetupTime 
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'TotalSetupTime')
BEGIN
	ALTER TABLE CRMT2111 ADD TotalSetupTime DECIMAL(28,8) NULL
END

---- Modified by Văn Tài on 28/02/2023 bổ sung cột PrintTypeID 
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2111' AND col.name = 'PrintTypeID')
BEGIN
	ALTER TABLE CRMT2111 ADD PrintTypeID NVARCHAR(50) NULL
END