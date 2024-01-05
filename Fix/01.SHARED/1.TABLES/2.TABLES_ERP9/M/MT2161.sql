---- Create by Trọng Kiên on 13/04/2021 10:56:26 AM
---- Detail lệnh sản xuất

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2161]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2161]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [StartDate] DATETIME NULL,
  [UnitID] VARCHAR(50) NULL,
  [UnitName] NVARCHAR(250) NULL,
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
  [MaterialID] VARCHAR(50) NULL,
  [MaterialName] NVARCHAR(MAX) NULL,
  [MaterialQuantity] DECIMAL(28,8) NULL,
  [Description] NVARCHAR(MAX) NULL
CONSTRAINT [PK_MT2161] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'MT2161' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2161' AND col.name = 'PhaseID')
    ALTER TABLE MT2161 ADD PhaseID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'MT2161' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT2161' AND col.name = 'MachineID')
    ALTER TABLE MT2161 ADD MachineID VARCHAR(50) NULL
END

---- Modified by Kiều Nga on 27/01/2022: Bổ sung trường InheritTableID, InheritVoucherID, InheritTransactionID
If Exists (Select * From sysobjects Where name = 'MT2161' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2161'  and col.name = 'InheritTableID')
			Alter Table  MT2161 Add InheritTableID varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'MT2161' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2161'  and col.name = 'InheritVoucherID')
			Alter Table  MT2161 Add InheritVoucherID varchar(50) Null
End

If Exists (Select * From sysobjects Where name = 'MT2161' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2161'  and col.name = 'InheritTransactionID')
			Alter Table  MT2161 Add InheritTransactionID varchar(50) Null
END


If Exists (Select * From sysobjects Where name = 'MT2161' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2161'  and col.name = 'PONumber')
			Alter Table  MT2161 Add PONumber varchar(50) Null
END

---------------- 13/09/2023 - Thanh Lượng: Bổ sung cột Specification ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2161' AND col.name = 'Specification')
BEGIN
	ALTER TABLE MT2161 ADD Specification NVARCHAR(500) NULL
END