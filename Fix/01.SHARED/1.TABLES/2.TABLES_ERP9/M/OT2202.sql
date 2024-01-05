---- Create by Trọng Kiên on 18/03/2021 1:32:23 PM
---- Update by Kiều Nga on 29/11/2021 : Fix lỗi load lưới detail
---- Chi tiết thành phẩm cần dự trù

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OT2202]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OT2202]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] NVARCHAR(50) NULL,
  [EstimateID] NVARCHAR(50) NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [ProductID] NVARCHAR(50) NULL,
  [ProductQuantity] DECIMAL(28,8) NULL,
  [PDescription] NVARCHAR(250) NULL,
  [LinkNo] NVARCHAR(50) NULL,
  [Orders] INT NULL,
  [UnitID] NVARCHAR(50) NULL,
  [Ana01ID] NVARCHAR(50) NULL,
  [Ana02ID] NVARCHAR(50) NULL,
  [Ana03ID] NVARCHAR(50) NULL,
  [Ana04ID] NVARCHAR(50) NULL,
  [Ana05ID] NVARCHAR(50) NULL,
  [MOTransactionID] NVARCHAR(50) NULL,
  [MOrderID] NVARCHAR(50) NULL,
  [SOrderID] NVARCHAR(50) NULL,
  [MTransactionID] NVARCHAR(50) NULL,
  [STransactionID] NVARCHAR(50) NULL,
  [Ana06ID] NVARCHAR(50) NULL,
  [Ana07ID] NVARCHAR(50) NULL,
  [Ana08ID] NVARCHAR(50) NULL,
  [Ana09ID] NVARCHAR(50) NULL,
  [Ana10ID] NVARCHAR(50) NULL,
  [RefInfor] NVARCHAR(250) NULL,
  [ED01] NVARCHAR(250) NULL,
  [ED02] NVARCHAR(250) NULL,
  [ED03] NVARCHAR(250) NULL,
  [ED04] NVARCHAR(250) NULL,
  [ED05] NVARCHAR(250) NULL,
  [ED06] NVARCHAR(250) NULL,
  [ED07] NVARCHAR(250) NULL,
  [ED08] NVARCHAR(250) NULL,
  [ED09] NVARCHAR(250) NULL,
  [ED10] NVARCHAR(250) NULL,
  [EDetailID] VARCHAR(250) NULL,
CONSTRAINT [PK_OT2202] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-- Đình Hoà [21/07/2021] : Merger từ FIX ERP8 -> ERP9
If Exists (Select * From sysobjects Where name = 'OT2202' and xtype ='U') 
BEGIN
			
		If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'OT2202'  and col.name = 'InheritTableID')
           Alter Table  OT2202 ADD InheritTableID NVARCHAR(50) NULL

		If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'OT2202'  and col.name = 'InheritVoucherID')
           Alter Table  OT2202 ADD InheritVoucherID NVARCHAR(50) NULL

		If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'OT2202'  and col.name = 'InheritTransactionID')
           Alter Table  OT2202 ADD InheritTransactionID NVARCHAR(50) NULL		
END

---- Modified by Tiểu Mai on 04/11/2016: Bổ sung cột cho ANGEL
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2202' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2202' AND col.name='BeginQuantity')
		ALTER TABLE OT2202 ADD BeginQuantity DECIMAL(28,8) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2202' AND col.name='MinQuantity')
		ALTER TABLE OT2202 ADD MinQuantity DECIMAL(28,8) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2202' AND col.name='IsCalculator')
		ALTER TABLE OT2202 ADD IsCalculator TINYINT DEFAULT(0)
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2202' AND col.name='MaterialQuantity')
		ALTER TABLE OT2202 ADD MaterialQuantity DECIMAL(28,8) NULL
END 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2202' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2202' AND col.name='AdjustSOrderID')
		ALTER TABLE OT2202 ADD AdjustSOrderID NVARCHAR(50) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2202' AND col.name='AdjustTransactionID')
		ALTER TABLE OT2202 ADD AdjustTransactionID NVARCHAR(50) NULL
	END  

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2202' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'ApportionID')
    ALTER TABLE OT2202 ADD ApportionID nvarchar(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2202' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'ApporitionID')
    ALTER TABLE OT2202 ADD ApporitionID nvarchar(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2202' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'ProductName')
    ALTER TABLE OT2202 ADD ProductName NVARCHAR(MAX) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'UnitName')
    ALTER TABLE OT2202 ADD UnitName NVARCHAR(MAX) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S01ID')
    ALTER TABLE OT2202 ADD S01ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S02ID')
    ALTER TABLE OT2202 ADD S02ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S03ID')
    ALTER TABLE OT2202 ADD S03ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S04ID')
    ALTER TABLE OT2202 ADD S04ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S05ID')
    ALTER TABLE OT2202 ADD S05ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S06ID')
    ALTER TABLE OT2202 ADD S06ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S07ID')
    ALTER TABLE OT2202 ADD S07ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S08ID')
    ALTER TABLE OT2202 ADD S08ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S09ID')
    ALTER TABLE OT2202 ADD S09ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S10ID')
    ALTER TABLE OT2202 ADD S10ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S11ID')
    ALTER TABLE OT2202 ADD S11ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S12ID')
    ALTER TABLE OT2202 ADD S12ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S13ID')
    ALTER TABLE OT2202 ADD S13ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S14ID')
    ALTER TABLE OT2202 ADD S14ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S15ID')
    ALTER TABLE OT2202 ADD S15ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S16ID')
    ALTER TABLE OT2202 ADD S16ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S17ID')
    ALTER TABLE OT2202 ADD S17ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S18ID')
    ALTER TABLE OT2202 ADD S18ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S19ID')
    ALTER TABLE OT2202 ADD S19ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S20ID')
    ALTER TABLE OT2202 ADD S20ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'S20ID')
    ALTER TABLE OT2202 ADD S20ID nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'VersionBOM')
    ALTER TABLE OT2202 ADD VersionBOM VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'InventoryTP')
    ALTER TABLE OT2202 ADD InventoryTP VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'APKMaster')
    ALTER TABLE OT2202 ADD APKMaster UNIQUEIDENTIFIER DEFAULT newid() NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'CreateUserID')
    ALTER TABLE OT2202 ADD CreateUserID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'CreateDate')
    ALTER TABLE OT2202 ADD CreateDate DATETIME NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'LastModifyUserID')
    ALTER TABLE OT2202 ADD LastModifyUserID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'LastModifyDate')
    ALTER TABLE OT2202 ADD LastModifyDate DATETIME NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'DeleteFlg')
    ALTER TABLE OT2202 ADD DeleteFlg TINYINT DEFAULT (0) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'APK_BomVersion')
	ALTER TABLE OT2202 ADD APK_BomVersion  VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar01')
    ALTER TABLE OT2202 ADD nvarchar01 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar02')
    ALTER TABLE OT2202 ADD nvarchar02 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar03')
    ALTER TABLE OT2202 ADD nvarchar03 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar04')
    ALTER TABLE OT2202 ADD nvarchar04 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar05')
    ALTER TABLE OT2202 ADD nvarchar05 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar06')
    ALTER TABLE OT2202 ADD nvarchar06 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar07')
    ALTER TABLE OT2202 ADD nvarchar07 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar08')
    ALTER TABLE OT2202 ADD nvarchar08 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar09')
    ALTER TABLE OT2202 ADD nvarchar09 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar10')
    ALTER TABLE OT2202 ADD nvarchar10 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar11')
    ALTER TABLE OT2202 ADD nvarchar11 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar12')
    ALTER TABLE OT2202 ADD nvarchar12 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar13')
    ALTER TABLE OT2202 ADD nvarchar13 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar14')
    ALTER TABLE OT2202 ADD nvarchar14 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar15')
    ALTER TABLE OT2202 ADD nvarchar15 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar16')
    ALTER TABLE OT2202 ADD nvarchar16 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar17')
    ALTER TABLE OT2202 ADD nvarchar17 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar18')
    ALTER TABLE OT2202 ADD nvarchar18 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar19')
    ALTER TABLE OT2202 ADD nvarchar19 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2202' AND col.name = 'nvarchar20')
    ALTER TABLE OT2202 ADD nvarchar20 nvarchar(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OT2202'  and col.name = 'InheritTableID')
	ALTER TABLE OT2202 ADD InheritTableID varchar(50) Null

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	On col.id = tab.id where tab.name =   'OT2202'  and col.name = 'InheritVoucherID')
	ALTER TABLE OT2202 ADD InheritVoucherID varchar(50) Null

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	On col.id = tab.id where tab.name =   'OT2202'  and col.name = 'InheritTransactionID')
	ALTER TABLE OT2202 ADD InheritTransactionID varchar(50) Null
END