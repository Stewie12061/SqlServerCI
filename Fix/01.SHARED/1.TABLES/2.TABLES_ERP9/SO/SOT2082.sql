-- <History>
---- Created by: Hoàng Trúc on 19/12/2019
---- Updated by: Đình Ly on 08/12/2020
---- Updated by: Văn Tài on 24/07/2023 - Bổ sung các cột thiếu của MAITHU.
---- Thông tin sản xuất ( MAITHU = 107) Details

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[SOT2082]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[SOT2082]
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
 
CONSTRAINT [PK_SOT2082] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-- Đình Ly on 16/12/2020

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'PhaseOrder') 
	ALTER TABLE SOT2082 ADD PhaseOrder INT NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'DisplayName') 
	ALTER TABLE SOT2082 ADD DisplayName NVARCHAR(500) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'QuantityRunWave') 
	ALTER TABLE SOT2082 ADD QuantityRunWave DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'UnitSizeID') 
	ALTER TABLE SOT2082 ADD UnitSizeID VARCHAR(50) NULL
END

-- Đình Ly on 08/12/2020

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'CartonQuantitation') 
	ALTER TABLE SOT2082 DROP COLUMN CartonQuantitation
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'PhaseID') 
	ALTER TABLE SOT2082 ADD PhaseID VARCHAR(50) NULL
END

--- Văn Tài ON 13/07/2023 - Bổ sung cột lưu trữ cấu trúc và ghi vết APK của bộ BOM Version - MT2123
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'NodeTypeID') 
	ALTER TABLE SOT2082 ADD NodeTypeID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'APKNodeParent') 
	ALTER TABLE SOT2082 ADD APKNodeParent VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'Size') 
	ALTER TABLE SOT2082 ADD Size DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'Cut') 
	ALTER TABLE SOT2082 ADD Cut DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'Child') 
	ALTER TABLE SOT2082 ADD Child DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'PrintTypeID')
	ALTER TABLE SOT2082 ADD PrintTypeID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'RunPaperID')
	ALTER TABLE SOT2082 ADD RunPaperID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'RunWavePaper')
	ALTER TABLE SOT2082 ADD RunWavePaper VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'SplitSheets') 
	ALTER TABLE SOT2082 ADD SplitSheets DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'MoldID') 
	ALTER TABLE SOT2082 ADD MoldID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'MoldStatusID') 
	ALTER TABLE SOT2082 ADD MoldStatusID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'MoldDate') 
	ALTER TABLE SOT2082 ADD MoldDate DATETIME NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'Gsm') 
	ALTER TABLE SOT2082 ADD Gsm DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'Sheets') 
	ALTER TABLE SOT2082 ADD Sheets DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'Ram') 
	ALTER TABLE SOT2082 ADD Ram DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'Kg') 
	ALTER TABLE SOT2082 ADD Kg DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'M2') 
	ALTER TABLE SOT2082 ADD M2 DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'AmountLoss') 
	ALTER TABLE SOT2082 ADD AmountLoss DECIMAL(28,8) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'PercentLoss') 
	ALTER TABLE SOT2082 ADD PercentLoss DECIMAL(28,8) NULL
END

-- Kiều Nga on 11/02/2020

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'APKMaster_9000')
    ALTER TABLE SOT2082 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'ApproveLevel') 
	ALTER TABLE SOT2082 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'ApprovingLevel') 
	ALTER TABLE SOT2082 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'Status') 
	ALTER TABLE SOT2082 ADD [Status] TINYINT NOT NULL DEFAULT(0)
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S01ID') 
	ALTER TABLE SOT2082 ADD S01ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S02ID') 
	ALTER TABLE SOT2082 ADD S02ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S03ID') 
	ALTER TABLE SOT2082 ADD S03ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S04ID') 
	ALTER TABLE SOT2082 ADD S04ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S05ID') 
	ALTER TABLE SOT2082 ADD S05ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S06ID') 
	ALTER TABLE SOT2082 ADD S06ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S07ID') 
	ALTER TABLE SOT2082 ADD S07ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S08ID') 
	ALTER TABLE SOT2082 ADD S08ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S09ID') 
	ALTER TABLE SOT2082 ADD S09ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S10ID') 
	ALTER TABLE SOT2082 ADD S10ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S11ID') 
	ALTER TABLE SOT2082 ADD S11ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S12ID') 
	ALTER TABLE SOT2082 ADD S12ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S13ID') 
	ALTER TABLE SOT2082 ADD S13ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S14ID') 
	ALTER TABLE SOT2082 ADD S14ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S15ID') 
	ALTER TABLE SOT2082 ADD S15ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S16ID') 
	ALTER TABLE SOT2082 ADD S16ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S17ID') 
	ALTER TABLE SOT2082 ADD S17ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S18ID') 
	ALTER TABLE SOT2082 ADD S18ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S19ID') 
	ALTER TABLE SOT2082 ADD S19ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'S20ID') 
	ALTER TABLE SOT2082 ADD S20ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'GluingTypeID') 
	ALTER TABLE SOT2082 ADD GluingTypeID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2082' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'NodeTypeID') 
	ALTER TABLE SOT2082 ADD NodeTypeID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'APKNodeParent') 
	ALTER TABLE SOT2082 ADD APKNodeParent VARCHAR(50) NULL
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'KindSuppliers') 
	ALTER TABLE SOT2082 ADD KindSuppliers VARCHAR(50) NULL
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'Quantity') 
	ALTER TABLE SOT2082 ADD Quantity DECIMAL(28, 8) NULL
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'UnitPrice') 
	ALTER TABLE SOT2082 ADD UnitPrice DECIMAL(28, 8) NULL
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'Amount') 
	ALTER TABLE SOT2082 ADD Amount DECIMAL(28, 8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'ProductID') 
	ALTER TABLE SOT2082 ADD ProductID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'SemiProduct') 
	ALTER TABLE SOT2082 ADD SemiProduct VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'APK_SOT2081') 
	ALTER TABLE SOT2082 ADD APK_SOT2081 VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'SOT2082' AND col.name = 'Orders') 
	ALTER TABLE SOT2082 ADD Orders INT NULL
	
END