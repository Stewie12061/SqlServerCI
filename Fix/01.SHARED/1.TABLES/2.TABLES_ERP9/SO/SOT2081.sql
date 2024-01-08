-- <History>
---- Created by: Hoàng Trúc on 25/11/2019
---- Updated by: Đình Ly on 11/12/2020
---- Updated by: Văn Tài on 24/07/2023 - Bổ sung các cột thiếu của MAITHU.
---- Deatail Dự toán( MAITHU = 107) Details

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[SOT2081]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[SOT2081]
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

CONSTRAINT [PK_SOT2081] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---- Modified by Đình Ly on 12/12/2020: Bổ sung column FileName (File đính kèm)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2081' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'FileName')
    ALTER TABLE SOT2081 ADD FileName NVARCHAR(50) NULL
END

---- Modified by Đình Ly on 12/12/2020: Drop column MoldStatus (Trạng thái khuôn)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2081' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'MoldStatus')
	ALTER TABLE SOT2081 DROP COLUMN MoldStatus
END

---- Modified by Đình Ly on 12/12/2020
---- Modified by Đình Hòa on 07/01/2021 START
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'ContentSampleDate')
BEGIN
	ALTER TABLE SOT2081 ADD ContentSampleDate NVARCHAR(250) NULL
END
ELSE
BEGIN
	ALTER TABLE SOT2081 ALTER COLUMN ContentSampleDate NVARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'ColorSampleDate')
BEGIN
	ALTER TABLE SOT2081 ADD ColorSampleDate NVARCHAR(250) NULL
END
ELSE
BEGIN
	ALTER TABLE SOT2081 ALTER COLUMN ColorSampleDate NVARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'MTSignedSampleDate')
BEGIN
	ALTER TABLE SOT2081 ADD MTSignedSampleDate NVARCHAR(250) NULL
END
ELSE
BEGIN
	ALTER TABLE SOT2081 ALTER COLUMN MTSignedSampleDate NVARCHAR(250) NULL
END
---- Modified by Đình Hòa on 07/01/2021 END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'FileLength')
BEGIN
	ALTER TABLE SOT2081 ADD FileLength DECIMAL(28,8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'FileWidth')
BEGIN
	ALTER TABLE SOT2081 ADD FileWidth DECIMAL(28,8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'FileSum')
BEGIN
	ALTER TABLE SOT2081 ADD FileSum DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2081' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'FileUnitID')
    ALTER TABLE SOT2081 ADD FileUnitID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'Include')
BEGIN
	ALTER TABLE SOT2081 ADD Include NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'Length')
BEGIN
	ALTER TABLE SOT2081 ALTER COLUMN Length VARCHAR(50) NULL
END
ELSE
BEGIN
	ALTER TABLE SOT2081 ADD Length VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'Width')
BEGIN
	ALTER TABLE SOT2081 ALTER COLUMN Width VARCHAR(50) NULL
END
ELSE
BEGIN
	ALTER TABLE SOT2081 ADD Width VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'Height')
BEGIN
	ALTER TABLE SOT2081 ALTER COLUMN Height VARCHAR(50) NULL
END
ELSE
BEGIN
	ALTER TABLE SOT2081 ADD Height VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'ActualQuantity')
BEGIN
	ALTER TABLE SOT2081 ADD ActualQuantity DECIMAL(28,8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'PaperTypeID')
BEGIN
	ALTER TABLE SOT2081 ADD PaperTypeID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'AmountLoss')
BEGIN
	ALTER TABLE SOT2081 ADD AmountLoss DECIMAL(28, 8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'Notes')
BEGIN
	ALTER TABLE SOT2081 ADD Notes NVARCHAR(4000) NULL
END


---- Added New by Văn Tài on 10/07/2023
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2081' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'Orders')
	BEGIN
		ALTER TABLE SOT2081 ADD Orders INT NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'SemiProduct')
	BEGIN
		ALTER TABLE SOT2081 ADD SemiProduct VARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'CutRollApprovePersonID')
	BEGIN
		ALTER TABLE SOT2081 ADD CutRollApprovePersonID VARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'ApproveCutRollStatusID')
	BEGIN
		ALTER TABLE SOT2081 ADD ApproveCutRollStatusID VARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'WaveApprovePersonID')
	BEGIN
		ALTER TABLE SOT2081 ADD WaveApprovePersonID VARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'ApproveWaveStatusID')
	BEGIN
		ALTER TABLE SOT2081 ADD ApproveWaveStatusID VARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'APKDInherited')
	BEGIN
		ALTER TABLE SOT2081 ADD APKDInherited VARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'PrintNumber')
	BEGIN
		ALTER TABLE SOT2081 ADD PrintNumber INT NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'SideColor1')
	BEGIN
		ALTER TABLE SOT2081 ADD SideColor1 NVARCHAR(250) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'ColorPrint01')
	BEGIN
		ALTER TABLE SOT2081 ADD ColorPrint01 NVARCHAR(250) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'SideColor2')
	BEGIN
		ALTER TABLE SOT2081 ADD SideColor2 NVARCHAR(250) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'ColorPrint02')
	BEGIN
		ALTER TABLE SOT2081 ADD ColorPrint02 NVARCHAR(250) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'PercentLoss')
	BEGIN
		ALTER TABLE SOT2081 ADD PercentLoss DECIMAL(28, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'TotalVariableFee')
	BEGIN
		ALTER TABLE SOT2081 ADD TotalVariableFee DECIMAL(28, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'PercentCost')
	BEGIN
		ALTER TABLE SOT2081 ADD PercentCost DECIMAL(28, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'Cost')
	BEGIN
		ALTER TABLE SOT2081 ADD Cost DECIMAL(28, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'PercentProfit')
	BEGIN
		ALTER TABLE SOT2081 ADD PercentProfit DECIMAL(28, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'PercentLoss')
	BEGIN
		ALTER TABLE SOT2081 ADD PercentLoss DECIMAL(28, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'Profit')
	BEGIN
		ALTER TABLE SOT2081 ADD Profit DECIMAL(28, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'SquareMetersPrice')
	BEGIN
		ALTER TABLE SOT2081 ADD SquareMetersPrice DECIMAL(28, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'InvenUnitPrice')
	BEGIN
		ALTER TABLE SOT2081 ADD InvenUnitPrice DECIMAL(28, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'ExchangeRate')
	BEGIN
		ALTER TABLE SOT2081 ADD ExchangeRate DECIMAL(28, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'CurrencyID')
	BEGIN
		ALTER TABLE SOT2081 ADD CurrencyID VARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'PrintTypeID')
	BEGIN
		ALTER TABLE SOT2081 ADD PrintTypeID VARCHAR(50) NULL
	END

	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'InheritAPKMaster')
	BEGIN
		ALTER TABLE SOT2081 DROP COLUMN InheritAPKMaster
	END

	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2081' AND col.name = 'InheritAPKDetail')
	BEGIN
		ALTER TABLE SOT2081 DROP COLUMN InheritAPKDetail
	END
END
