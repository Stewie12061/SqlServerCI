IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2160]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2160]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [VoucherNo] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [VoucherDate] DATETIME NULL,
  [Description] NVARCHAR(MAX) NULL,
  [InheritMT2140] TINYINT DEFAULT (0) NULL,
  [MOrderID] VARCHAR(50) NULL,
  [ProductID] VARCHAR(50) NULL,
  [ProductName] NVARCHAR(MAX) NULL,
  [S01ID] VARCHAR(50) NULL,
  [S02ID] VARCHAR(50) NULL,
  [S03ID] VARCHAR(50) NULL,
  [S04ID] VARCHAR(50) NULL,
  [S05ID] VARCHAR(50) NULL,
  [S06ID] VARCHAR(50) NULL,
  [S07ID] VARCHAR(50) NULL,
  [S08ID] VARCHAR(50) NULL,
  [S09ID] VARCHAR(50) NULL,
  [S10ID] VARCHAR(50) NULL,
  [S12ID] VARCHAR(50) NULL,
  [S11ID] VARCHAR(50) NULL,
  [S13ID] VARCHAR(50) NULL,
  [S14ID] VARCHAR(50) NULL,
  [S15ID] VARCHAR(50) NULL,
  [S16ID] VARCHAR(50) NULL,
  [S17ID] VARCHAR(50) NULL,
  [S18ID] VARCHAR(50) NULL,
  [S19ID] VARCHAR(50) NULL,
  [S20ID] VARCHAR(50) NULL,
  [ProductQuantity] DECIMAL(28,8) NULL,
  [ObjectID] VARCHAR(50) NULL,
  [ObjectName] NVARCHAR(MAX) NULL,
  [DateDelivery] DATETIME NULL,
  [OrderStatus] VARCHAR(50) NULL,
  [ApporitionID] VARCHAR(50) NULL,
  [VersionBOM] INT NULL,
  [PhaseID] VARCHAR(50) NULL,
  [PhaseName] NVARCHAR(MAX) NULL,
  [MachineID] VARCHAR(50) NULL,
  [MachineName] NVARCHAR(MAX) NULL,
  [EmployeeID] VARCHAR(MAX) NULL,
  [CommandType] VARCHAR(50) NULL,
  [WorkersLimit] INT NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [MPlanID] VARCHAR(50) NULL
CONSTRAINT [PK_MT2160] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'MT2160' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'ProductID')
    ALTER TABLE MT2160 ADD ProductID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'MT2160' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'PhaseID')
	ALTER TABLE MT2160 ADD PhaseID VARCHAR(50) NULL
END


--- [Văn Tài]	Created	[16/11/2021] - Bổ sung cột cho các database khách hàng cũ.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'MT2160' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'MPlanID')
    ALTER TABLE MT2160 ADD MPlanID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'MOrderID')
    ALTER TABLE MT2160 ADD MOrderID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'InheritMT2140')
    ALTER TABLE MT2160 ADD InheritMT2140 TINYINT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'ProductName')
    ALTER TABLE MT2160 ADD ProductName NVARCHAR(MAX) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'ObjectName')
    ALTER TABLE MT2160 ADD ObjectName NVARCHAR(MAX) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'ProductQuantity')
    ALTER TABLE MT2160 ADD ProductQuantity DECIMAL(28, 8) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'DateDelivery')
    ALTER TABLE MT2160 ADD DateDelivery DATETIME NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'OrderStatus')
    ALTER TABLE MT2160 ADD OrderStatus VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'CommandType')
    ALTER TABLE MT2160 ADD CommandType VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'Description')
    ALTER TABLE MT2160 ADD Description NVARCHAR(MAX) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'ApporitionID')
    ALTER TABLE MT2160 ADD ApporitionID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'ApporitionID')
    ALTER TABLE MT2160 ADD ApporitionID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'WorkersLimit')
    ALTER TABLE MT2160 ADD WorkersLimit INT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'VersionBOM')
    ALTER TABLE MT2160 ADD VersionBOM INT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S01ID')
    ALTER TABLE MT2160 ADD S01ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S02ID')
    ALTER TABLE MT2160 ADD S02ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S03ID')
    ALTER TABLE MT2160 ADD S03ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S04ID')
    ALTER TABLE MT2160 ADD S04ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S05ID')
    ALTER TABLE MT2160 ADD S05ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S06ID')
    ALTER TABLE MT2160 ADD S06ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S07ID')
    ALTER TABLE MT2160 ADD S07ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S08ID')
    ALTER TABLE MT2160 ADD S08ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S09ID')
    ALTER TABLE MT2160 ADD S09ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S10ID')
    ALTER TABLE MT2160 ADD S10ID VARCHAR(50) NULL

	
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S11ID')
    ALTER TABLE MT2160 ADD S11ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S12ID')
    ALTER TABLE MT2160 ADD S12ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S13ID')
    ALTER TABLE MT2160 ADD S13ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S14ID')
    ALTER TABLE MT2160 ADD S14ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S15ID')
    ALTER TABLE MT2160 ADD S15ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S16ID')
    ALTER TABLE MT2160 ADD S16ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S17ID')
    ALTER TABLE MT2160 ADD S17ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S18ID')
    ALTER TABLE MT2160 ADD S18ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S19ID')
    ALTER TABLE MT2160 ADD S19ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2160' AND col.name = 'S20ID')
    ALTER TABLE MT2160 ADD S20ID VARCHAR(50) NULL

END

If Exists (Select * From sysobjects Where name = 'MT2160' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2160'  and col.name = 'SourceNo')
			Alter Table  MT2160 Add SourceNo varchar(50) Null
END

---- Modified by Đức Tuyên on 03/04/2023: Bổ sung trường InheritTableID, InheritVoucherID, InheritTransactionID
If Exists (Select * From sysobjects Where name = 'MT2160' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2160'  and col.name = 'InheritTableID')
			Alter Table  MT2160 Add InheritTableID varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'MT2160' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2160'  and col.name = 'InheritVoucherID')
			Alter Table  MT2160 Add InheritVoucherID varchar(50) Null
End

If Exists (Select * From sysobjects Where name = 'MT2160' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2160'  and col.name = 'InheritTransactionID')
			Alter Table  MT2160 Add InheritTransactionID varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2160' and xtype ='U') 
Begin
			If  exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2160'  and col.name = 'EmployeeID')
            ALTER TABLE MT2160 ALTER COLUMN EmployeeID NVARCHAR(250)
END

If Exists (Select * From sysobjects Where name = 'MT2160' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2160'  and col.name = 'APK_MT2143')
			Alter Table  MT2160 Add APK_MT2143 varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2160' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2160'  and col.name = 'PONumber')
			Alter Table  MT2160 Add PONumber varchar(50) Null
END