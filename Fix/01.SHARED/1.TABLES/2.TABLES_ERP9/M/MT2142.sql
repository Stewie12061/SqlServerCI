---- Create by Mai Trọng Kiên on 2/1/2021 3:07:16 PM
---- Kế hoạch sản xuất (Detail_Máy_SX_01)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2142]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2142]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [MachineID] VARCHAR(50) NULL,
  [MachineName] NVARCHAR(MAX) NULL,
  [VoucherNoProduct] VARCHAR(50) NULL,
  [UnitID] VARCHAR(50) NULL,
  [UnitName] NVARCHAR(MAX) NULL,
  [TimeLimit] DECIMAL(28, 8) NULL,
  [TimeNumber] DECIMAL(28, 8) NULL,
  [StartDateManufacturing] DATETIME NULL,
  [Quantity01] DECIMAL(28,8) NULL,
  [Quantity02] DECIMAL(28,8) NULL,
  [Quantity03] DECIMAL(28,8) NULL,
  [Quantity04] DECIMAL(28,8) NULL,
  [Quantity05] DECIMAL(28,8) NULL,
  [Quantity06] DECIMAL(28,8) NULL,
  [Quantity07] DECIMAL(28,8) NULL,
  [Quantity08] DECIMAL(28,8) NULL,
  [Quantity09] DECIMAL(28,8) NULL,
  [Quantity10] DECIMAL(28,8) NULL,
  [Quantity11] DECIMAL(28,8) NULL,
  [Quantity12] DECIMAL(28,8) NULL,
  [Quantity13] DECIMAL(28,8) NULL,
  [Quantity14] DECIMAL(28,8) NULL,
  [Quantity15] DECIMAL(28,8) NULL,
  [Quantity16] DECIMAL(28,8) NULL,
  [Quantity17] DECIMAL(28,8) NULL,
  [Quantity18] DECIMAL(28,8) NULL,
  [Quantity19] DECIMAL(28,8) NULL,
  [Quantity20] DECIMAL(28,8) NULL,
  [Quantity21] DECIMAL(28,8) NULL,
  [Quantity22] DECIMAL(28,8) NULL,
  [Quantity23] DECIMAL(28,8) NULL,
  [Quantity24] DECIMAL(28,8) NULL,
  [Quantity25] DECIMAL(28,8) NULL,
  [Quantity26] DECIMAL(28,8) NULL,
  [Quantity27] DECIMAL(28,8) NULL,
  [Quantity28] DECIMAL(28,8) NULL,
  [Quantity29] DECIMAL(28,8) NULL,
  [Quantity30] DECIMAL(28,8) NULL,
  [Quantity31] DECIMAL(28,8) NULL,
  [Quantity32] DECIMAL(28,8) NULL,
  [Quantity33] DECIMAL(28,8) NULL,
  [Quantity34] DECIMAL(28,8) NULL,
  [Quantity35] DECIMAL(28,8) NULL,
  [Quantity36] DECIMAL(28,8) NULL,
  [Quantity37] DECIMAL(28,8) NULL,
  [Quantity38] DECIMAL(28,8) NULL,
  [Quantity39] DECIMAL(28,8) NULL,
  [Quantity40] DECIMAL(28,8) NULL,
  [Quantity41] DECIMAL(28,8) NULL,
  [Quantity42] DECIMAL(28,8) NULL,
  [Quantity43] DECIMAL(28,8) NULL,
  [Quantity44] DECIMAL(28,8) NULL,
  [Quantity45] DECIMAL(28,8) NULL,
  [Quantity46] DECIMAL(28,8) NULL,
  [Quantity47] DECIMAL(28,8) NULL,
  [Quantity48] DECIMAL(28,8) NULL,
  [Quantity49] DECIMAL(28,8) NULL,
  [Quantity50] DECIMAL(28,8) NULL,
  [Quantity51] DECIMAL(28,8) NULL,
  [Quantity52] DECIMAL(28,8) NULL,
  [Quantity53] DECIMAL(28,8) NULL,
  [Quantity54] DECIMAL(28,8) NULL,
  [Quantity55] DECIMAL(28,8) NULL,
  [Quantity56] DECIMAL(28,8) NULL,
  [Quantity57] DECIMAL(28,8) NULL,
  [Quantity58] DECIMAL(28,8) NULL,
  [Quantity59] DECIMAL(28,8) NULL,
  [Quantity60] DECIMAL(28,8) NULL,
  [Orders] INT NULL,
  [GoalLimit] VARCHAR(250) NULL,
  [PhaseID] VARCHAR(250) NULL,
  [PhaseName] NVARCHAR(MAX) NULL,
  [TimeNumberPlan] DECIMAL(28,8) NULL,
  [WorkersLimit] INT NULL,
  [SpaceTimes] INT NULL
CONSTRAINT [PK_MT2142] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 12/04/2021 - Trọng Kiên: Bổ sung cột PhaseID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2142' AND col.name = 'PhaseID')
BEGIN
	ALTER TABLE MT2142 ADD PhaseID VARCHAR(250) NULL
END

---------------- 12/04/2021 - Trọng Kiên: Bổ sung cột PhaseName ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2142' AND col.name = 'PhaseName')
BEGIN
	ALTER TABLE MT2142 ADD PhaseName NVARCHAR(MAX) NULL
END

---------------- 12/04/2021 - Trọng Kiên: Bổ sung cột TimeNumberPlan ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2142' AND col.name = 'TimeNumberPlan')
BEGIN
	ALTER TABLE MT2142 ADD TimeNumberPlan DECIMAL(28,8) NULL
END
ELSE
BEGIN
	ALTER TABLE MT2142 ALTER COLUMN TimeNumberPlan DECIMAL(28,8) NULL
END

---------------- 12/04/2021 - Trọng Kiên: Bổ sung cột WorkersLimit ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2142' AND col.name = 'WorkersLimit')
BEGIN
	ALTER TABLE MT2142 ADD WorkersLimit DECIMAL(28, 8) NULL
END
ELSE
BEGIN
	ALTER TABLE MT2142 ALTER COLUMN WorkersLimit DECIMAL(28, 8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2142' AND col.name = 'TimeLimit')
BEGIN
	ALTER TABLE MT2142 ADD TimeLimit DECIMAL(28, 8) NULL
END
ELSE
BEGIN
	ALTER TABLE MT2142 ALTER COLUMN TimeLimit DECIMAL(28, 8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2142' AND col.name = 'TimeNumber')
BEGIN
	ALTER TABLE MT2142 ADD TimeNumber DECIMAL(28, 8) NULL
END
ELSE
BEGIN
	ALTER TABLE MT2142 ALTER COLUMN TimeNumber DECIMAL(28, 8) NULL
END

---------------- 12/04/2021 - Trọng Kiên: Bổ sung cột SpaceTimes ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2142' AND col.name = 'SpaceTimes')
BEGIN
	ALTER TABLE MT2142 ADD SpaceTimes DECIMAL(28, 8) NULL
END

---------------- 02/03/2023 - Nhật Quang: Begin Add
If Exists (Select * From sysobjects Where name = 'MT2142' and xtype ='U') 
Begin
			---------------- 03/04/2023 - Thanh Lượng: Begin Add
			--Bổ sung column LineProduceID
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2142'  and col.name = 'LineProduceID')
			Alter Table  MT2142 Add LineProduceID varchar(50) Null
			---------------- 03/04/2023 - Thanh Lượng: Begin End

			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2142'  and col.name = 'LineProduce')
			BEGIN
				ALTER Table  MT2142 Add LineProduce Nvarchar(250) NULL
            END
			ELSE
			BEGIN
				ALTER TABLE dbo.MT2142 ALTER COLUMN LineProduce NVARCHAR(250) NULL
			END
			
END

If Exists (Select * From sysobjects Where name = 'MT2142' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2142'  and col.name = 'MaterialID')
			Alter Table  MT2142 Add MaterialID varchar(50) Null
END

If Exists (Select * From sysobjects Where name = 'MT2142' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2142'  and col.name = 'MaterialName')
			Alter Table  MT2142 Add MaterialName varchar(250) Null
END

If Exists (Select * From sysobjects Where name = 'MT2142' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2142'  and col.name = 'APK_MT2141')
			Alter Table  MT2142 Add APK_MT2141 varchar(250) Null
END
---------------- 02/03/2023 - Nhật Quang: End Add

If Exists (Select * From sysobjects Where name = 'MT2142' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2142'  and col.name = 'TotalQuantity')
			Alter Table  MT2142 Add TotalQuantity  DECIMAL(28,8) NULL
END
---------------- 13/09/2023 - Thanh Lượng: Bổ sung cột Specification ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT2142' AND col.name = 'Specification')
BEGIN
	ALTER TABLE MT2142 ADD Specification NVARCHAR(500) NULL
END

---------------- 21/11/2023 - Viết Toàn: Bổ sung số lượng sản xuất tối đa thời gian định mức ----------------
If Exists (Select * From sysobjects Where name = 'MT2142' and xtype ='U') 
Begin
			If not exists (select * from syscolumns col inner join sysobjects tab 
			On col.id = tab.id where tab.name =   'MT2142'  and col.name = 'QuantityOfDay')
			Alter Table  MT2142 Add QuantityOfDay  DECIMAL(28,8) NULL
END