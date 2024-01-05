---- Create by Mai Trọng Kiên on 2/1/2021 3:07:16 PM
---- Kế hoạch sản xuất (Detail_phiếu thông tin sản xuất)
---- Modified on 21/11/2022 by Đức Tuyên: Bổ sung cột InheritTableID, InheritVoucherID, InheritTransactionID để check kế thừa 'Đơn hàng sản xuất'

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2141]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2141]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [VoucherNoProduct] VARCHAR(50) NULL,
  [InventoryID] VARCHAR(50) NULL,
  [InventoryName] NVARCHAR(MAX) NULL,
  [ObjectID] VARCHAR(50) NULL,
  [ObjectName] NVARCHAR(MAX) NULL,
  [DateDelivery] DATETIME NULL,
  [StartDate] DATETIME NULL,
  [EndDate] DATETIME NULL,
  [StatusID] VARCHAR(50) NULL,
  [StatusName] NVARCHAR(MAX) NULL,
  [Orders] INT NULL
CONSTRAINT [PK_MT2141] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 12/04/2021 - Trọng Kiên: Bổ sung cột NodeID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2141' AND col.name = 'NodeID')
BEGIN
	ALTER TABLE MT2141 ADD NodeID VARCHAR(50) NULL
END

---------------- 12/04/2021 - Trọng Kiên: Bổ sung cột VersionBOM ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2141' AND col.name = 'VersionBOM')
BEGIN
	ALTER TABLE MT2141 ADD VersionBOM INT NULL
END

---------------- 12/04/2021 - Trọng Kiên: Bổ sung cột Number ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2141' AND col.name = 'Number')
BEGIN
	ALTER TABLE MT2141 ADD Number INT NULL
END

---------------- 12/04/2021 - Trọng Kiên: Bổ sung cột Quantity ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2141' AND col.name = 'Quantity')
BEGIN
	ALTER TABLE MT2141 ADD Quantity DECIMAL(28,8) NULL
END

---------------- 12/04/2021 - Trọng Kiên: Bổ sung cột EndDatePlan ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2141' AND col.name = 'EndDatePlan')
BEGIN
	ALTER TABLE MT2141 ADD EndDatePlan DATETIME NULL
END

---------------- 12/04/2021 - Trọng Kiên: Bổ sung cột UnitID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2141' AND col.name = 'UnitID')
BEGIN
	ALTER TABLE MT2141 ADD UnitID VARCHAR(50) NULL
END

---------------- 12/04/2021 - Trọng Kiên: Bổ sung cột UnitName ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2141' AND col.name = 'UnitName')
BEGIN
	ALTER TABLE MT2141 ADD UnitName NVARCHAR(250) NULL
END

If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'InheritTableID')
			Alter Table  MT2141 Add InheritTableID varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'InheritVoucherID')
			Alter Table  MT2141 Add InheritVoucherID varchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'InheritTransactionID')
			Alter Table  MT2141 Add InheritTransactionID varchar(50) Null
END
If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'nvarchar01')
			Alter Table  MT2141 Add nvarchar01 varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'nvarchar02')
			Alter Table  MT2141 Add nvarchar02 varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'nvarchar03')
			Alter Table  MT2141 Add nvarchar03 varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'nvarchar04')
			Alter Table  MT2141 Add nvarchar04 varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'nvarchar05')
			Alter Table  MT2141 Add nvarchar05 varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'nvarchar06')
			Alter Table  MT2141 Add nvarchar06 varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'nvarchar07')
			Alter Table  MT2141 Add nvarchar07 varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'nvarchar08')
			Alter Table  MT2141 Add nvarchar08 varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'nvarchar09')
			Alter Table  MT2141 Add nvarchar09 varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'nvarchar10')
			Alter Table  MT2141 Add nvarchar10 varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2141' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2141'  and col.name = 'APK_BomVersion')
			Alter Table  MT2141 Add APK_BomVersion varchar(50) Null
END
---------------- 13/09/2023 - Thanh Lượng: Bổ sung cột Specification ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2141' AND col.name = 'Specification')
BEGIN
	ALTER TABLE MT2141 ADD Specification NVARCHAR(500) NULL
END