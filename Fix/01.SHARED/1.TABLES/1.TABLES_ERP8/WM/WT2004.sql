-- <Summary>
---- Thông tin chi phí lưu kho
-- <History>
---- Create on 01/11/2019 by Khánh Đoan

---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WT2004]') AND type in (N'U'))
CREATE TABLE [dbo].[WT2004](
	[APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[VoucherID]  VARCHAR(50) NOT NULL,
	[VoucherDate] DATETIME NULL,
	[BeginPallet] INT  NULL,
	[BeginQuantity]DECIMAL(28,8) NULL,
	[DebitPallet]	INT NULL,
	[DebitQuantity] DECIMAL(28,8) NULL,
	[CreditPallet] INT NULL,
	[CreditQuantity] DECIMAL(28,8) NULL,
	[EndingPallet] INT NULL,
	[EndingQuantity ]DECIMAL(28,8) NULL,
	[CostExPallet] DECIMAL(28,8) NULL,
	[EndCostPallet] DECIMAL(28,8) NULL,
	[UnitPrice ] DECIMAL(28,8) NULL,
	[RoomID] NVARCHAR(50) NULL

CONSTRAINT [PK_WT2004] PRIMARY KEY NONCLUSTERED 
(
	[APK],
	[DivisionID]
	
	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


--- Modified by Huỳnh Thử on 29/11/2019: Bổ sung cột RoomName
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT2004' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2004' AND col.name = 'RoomName') 
   ALTER TABLE WT2004 ADD RoomName NVARCHAR(50) NULL 
END


--- Modified by Huỳnh Thử on 29/11/2019: Bổ sung cột tồn dầu trọng lượng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT2004' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2004' AND col.name = 'BeginWeight') 
   ALTER TABLE WT2004 ADD BeginWeight DECIMAL(28,8) NULL DEFAULT 0 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2004' AND col.name = 'DebitWeight') 
   ALTER TABLE WT2004 ADD DebitWeight DECIMAL(28,8) NULL DEFAULT 0 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2004' AND col.name = 'CreditWeight') 
   ALTER TABLE WT2004 ADD CreditWeight DECIMAL(28,8) NULL DEFAULT 0 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2004' AND col.name = 'EndingWeight') 
   ALTER TABLE WT2004 ADD EndingWeight DECIMAL(28,8) NULL DEFAULT 0 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2004' AND col.name = 'BeginGradeLevel') 
   ALTER TABLE WT2004 ADD BeginGradeLevel DECIMAL(28,8) NULL DEFAULT 0 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2004' AND col.name = 'DebitGradeLevel') 
   ALTER TABLE WT2004 ADD DebitGradeLevel DECIMAL(28,8) NULL DEFAULT 0 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2004' AND col.name = 'CreditGradeLevel') 
   ALTER TABLE WT2004 ADD CreditGradeLevel DECIMAL(28,8) NULL DEFAULT 0 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2004' AND col.name = 'EndingGradeLevel') 
   ALTER TABLE WT2004 ADD EndingGradeLevel DECIMAL(28,8) NULL DEFAULT 0 

   ---- Add Columns Huỳnh Thử [25/07/2020]-- Fix lỗi chạy tool run all Fix
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2004' AND col.name = 'ObjectID') 
   ALTER TABLE WT2004 ADD ObjectID NVARCHAR(50) NULL 
END

