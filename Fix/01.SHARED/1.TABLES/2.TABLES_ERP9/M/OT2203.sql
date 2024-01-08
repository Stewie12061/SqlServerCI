---- Create by Trọng Kiên on 18/03/2021 1:32:23 PM
---- Update by Kiều Nga on 29/11/2021 : Fix lỗi load lưới detail
---- Chi tiết dự toán nguyên vật liệu

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OT2203]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OT2203]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] NVARCHAR(50) NULL,
  [EstimateID] NVARCHAR(50) NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [MaterialID] NVARCHAR(50) NULL,
  [MaterialQuantity] DECIMAL(28,8) NULL,
  [MDescription] NVARCHAR(250) NULL,
  [Orders] INT NULL,
  [WareHouseID] NVARCHAR(50) NULL,
  [IsPicking] TINYINT NULL,
  [EDetailID] NVARCHAR(50) NULL,
  [UnitID] NVARCHAR(50) NULL,
  [ExpenseID] NVARCHAR(50) NULL,
  [MaterialTypeID] NVARCHAR(50) NULL,
  [ConvertedAmount] DECIMAL(28,8) NULL,
  [MaterialPrice] DECIMAL(28,8) NULL,
  [ConvertedUnit] DECIMAL(28,8) NULL,
  [QuantityUnit] DECIMAL(28,8) NULL,
  [Num01] DECIMAL(28,8) NULL,
  [Num02] DECIMAL(28,8) NULL,
  [ProductID] NVARCHAR(50) NULL,
  [PeriodID] NVARCHAR(50) NULL,
  [MaterialDate] DATETIME NULL,
  [MOrderID] NVARCHAR(50) NULL,
  [SOrderID] NVARCHAR(50) NULL,
  [MTransactionID] NVARCHAR(50) NULL,
  [STransactionID] NVARCHAR(50) NULL,
  [S01ID] VARCHAR(50) NULL,
  [S02ID] VARCHAR(50) NULL,
  [S03ID] VARCHAR(50) NULL,
  [S05ID] VARCHAR(50) NULL,
  [S06ID] VARCHAR(50) NULL,
  [S07ID] VARCHAR(50) NULL,
  [S08ID] VARCHAR(50) NULL,
  [S09ID] VARCHAR(50) NULL,
  [S10ID] VARCHAR(50) NULL,
  [S11ID] VARCHAR(50) NULL,
  [S12ID] VARCHAR(50) NULL,
  [S13ID] VARCHAR(50) NULL,
  [S14ID] VARCHAR(50) NULL,
  [S15ID] VARCHAR(50) NULL,
  [S16ID] VARCHAR(50) NULL,
  [S17ID] VARCHAR(50) NULL,
  [S18ID] VARCHAR(50) NULL,
  [S19ID] VARCHAR(50) NULL,
  [S20ID] VARCHAR(50) NULL,
  [DS20ID] VARCHAR(50) NULL,
  [DS19ID] VARCHAR(50) NULL,
  [DS18ID] VARCHAR(50) NULL,
  [DS17ID] VARCHAR(50) NULL,
  [DS16ID] VARCHAR(50) NULL,
  [DS15ID] VARCHAR(50) NULL,
  [DS14ID] VARCHAR(50) NULL,
  [DS13ID] VARCHAR(50) NULL,
  [DS12ID] VARCHAR(50) NULL,
  [DS11ID] VARCHAR(50) NULL,
  [DS10ID] VARCHAR(50) NULL,
  [DS09ID] VARCHAR(50) NULL,
  [DS08ID] VARCHAR(50) NULL,
  [DS07ID] VARCHAR(50) NULL,
  [DS06ID] VARCHAR(50) NULL,
  [DS05ID] VARCHAR(50) NULL,
  [DS04ID] VARCHAR(50) NULL,
  [DS03ID] VARCHAR(50) NULL,
  [DS02ID] VARCHAR(50) NULL,
  [DS01ID] VARCHAR(50) NULL,
  [S04ID] VARCHAR(50) NULL,
  [TransactionID] VARCHAR(250) NULL,
CONSTRAINT [PK_OT2203] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-- Đình Hoà [21/07/2021] : Merger từ FIX ERP8 -> ERP9
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2203' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'Level')
		ALTER TABLE OT2203 ADD [Level] TINYINT NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2203' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'ApportionID')
		ALTER TABLE OT2203 ADD ApportionID VARCHAR(50) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2203' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'Parameter01')
		ALTER TABLE OT2203 ADD Parameter01 DECIMAL(28) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'Parameter02')
		ALTER TABLE OT2203 ADD Parameter02 DECIMAL(28) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'Parameter03')
		ALTER TABLE OT2203 ADD Parameter03 DECIMAL(28) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'Parameter04')
		ALTER TABLE OT2203 ADD Parameter04 DECIMAL(28) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'Parameter05')
		ALTER TABLE OT2203 ADD Parameter05 DECIMAL(28) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'StandardMaterialQuantity')
		ALTER TABLE OT2203 ADD StandardMaterialQuantity DECIMAL(28,8) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'StandardQuantityUnit')
		ALTER TABLE OT2203 ADD StandardQuantityUnit DECIMAL(28,8) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'StandardMaterialPrice')
		ALTER TABLE OT2203 ADD StandardMaterialPrice DECIMAL(28,8) NULL				
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2203' AND xtype = 'U')
BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'ApporitionID')
		ALTER TABLE OT2203 ADD ApporitionID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'APKMaster')
		ALTER TABLE OT2203 ADD APKMaster UNIQUEIDENTIFIER DEFAULT newid() NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'MaterialOriginal')
		ALTER TABLE OT2203 ADD MaterialOriginal  NVARCHAR(250) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'MaterialGroupID')
		ALTER TABLE OT2203 ADD MaterialGroupID  NVARCHAR(250) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'IsChange')
		ALTER TABLE OT2203 ADD IsChange  TINYINT DEFAULT (0) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'ProductName')
		ALTER TABLE OT2203 ADD ProductName  NVARCHAR(MAX) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'MaterialName')
		ALTER TABLE OT2203 ADD MaterialName  NVARCHAR(MAX) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'UnitName')
		ALTER TABLE OT2203 ADD UnitName  NVARCHAR(MAX) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'DS01IDOriginal')
		ALTER TABLE OT2203 ADD DS01IDOriginal  VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'DS02IDOriginal')
		ALTER TABLE OT2203 ADD DS02IDOriginal  VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'DS03IDOriginal')
		ALTER TABLE OT2203 ADD DS03IDOriginal  VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'GroupInventoryID')
		ALTER TABLE OT2203 ADD GroupInventoryID  NVARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'CreateUserID')
		ALTER TABLE OT2203 ADD CreateUserID  VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'CreateDate')
		ALTER TABLE OT2203 ADD CreateDate  DATETIME NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'LastModifyUserID')
		ALTER TABLE OT2203 ADD LastModifyUserID  VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'LastModifyDate')
		ALTER TABLE OT2203 ADD LastModifyDate  DATETIME NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'DeleteFlg')
		ALTER TABLE OT2203 ADD DeleteFlg  TINYINT DEFAULT (0) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'SemiProduct')
		ALTER TABLE OT2203 ADD SemiProduct VARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'Specification')
		ALTER TABLE OT2203 ADD Specification NVARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'APK_OT2202')
		ALTER TABLE OT2203 ADD APK_OT2202  VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'RoutingID')
		ALTER TABLE OT2203 ADD RoutingID  VARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'PhaseID')
		ALTER TABLE OT2203 ADD PhaseID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'APKNode')
		ALTER TABLE OT2203 ADD APKNode VARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'NodeTypeID')
		ALTER TABLE OT2203 ADD NodeTypeID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'NodeLevel')
		ALTER TABLE OT2203 ADD NodeLevel INT NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'NodeParent')
		ALTER TABLE OT2203 ADD NodeParent UNIQUEIDENTIFIER NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'NodeOrder')
		ALTER TABLE OT2203 ADD NodeOrder INT NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'QuantitativeValue')
		ALTER TABLE OT2203 ADD QuantitativeValue DECIMAL(28) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'LossValue')
		ALTER TABLE OT2203 ADD LossValue DECIMAL(28) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'CoValues')
		ALTER TABLE OT2203 ADD CoValues DECIMAL(28) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'OutsourceID')
		ALTER TABLE OT2203 ADD OutsourceID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'DictatesID')
		ALTER TABLE OT2203 ADD DictatesID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'DisplayName')
		ALTER TABLE OT2203 ADD DisplayName NVARCHAR(500) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'QuantitativeTypeID')
		ALTER TABLE OT2203 ADD QuantitativeTypeID VARCHAR(50) NULL		

		-- Update by Nhật Thanh on 06/10/2023: Tăng độ dài cột đặc tính kỹ thuật
		IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT2203' AND col.name = 'Specification')
		ALTER TABLE OT2203 ALTER COLUMN Specification NVARCHAR(250) NULL
END