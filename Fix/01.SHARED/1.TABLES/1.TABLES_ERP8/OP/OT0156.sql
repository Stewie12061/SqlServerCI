-- <Summary>
---- 
-- <History>
---- Create on 02/03/2016 by Bảo Anh: chi tiết kế hoạch mua hàng tổng hợp (Angel)
---- Modified by Tiểu Mai on 14/07/2016: Bổ sung trường PriceListID
---- Modified on ... by ...

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT0156]') AND type in (N'U'))
CREATE TABLE [dbo].[OT0156](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[InventoryID] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,
	[RequireQuantity] decimal(28,8) NULL,
	[BeginQuantity] decimal(28,8) NULL,
	[MinQuantity] decimal(28,8) NULL,
	[PlanQuantity] decimal(28,8) NULL,
	[ActualQuantity] decimal(28,8) NULL,
	[SourceID] tinyint NULL,
	[ObjectID] [nvarchar](50) NULL,
	[UnitPrice] decimal(28,8) NULL,
	[OriginalAmount] decimal(28,8) NULL,
	[OrderDate] datetime NULL,
	[ReceiveDate] datetime NULL,
	[Notes] [nvarchar](250) NULL,
	[InheritTableID] [nvarchar](50) NULL,
	[InheritVoucherID] [nvarchar](50) NULL,
	[InheritTransactionID] [nvarchar](50) NULL,
 CONSTRAINT [PK_OT0156] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT0156' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT0156' AND col.name = 'PriceListID')
    ALTER TABLE OT0156 ADD PriceListID NVARCHAR(50) NULL
    
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT0156' AND col.name = 'InheritTransactionID')
    ALTER TABLE OT0156 ALTER COLUMN InheritTransactionID NVARCHAR(500) NULL
END

---- Modified by Kim Thư on 19/02/2019: Bổ sung cột ReOrderQuantity, OrderedQuantity, RemainQuantity, BeginDate
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT0156' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT0156' AND col.name = 'ReOrderQuantity')
    ALTER TABLE OT0156 ADD ReOrderQuantity DECIMAL(28,8) NULL
    
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT0156' AND col.name = 'OrderedQuantity')
    ALTER TABLE OT0156 ADD OrderedQuantity DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT0156' AND col.name = 'RemainQuantity')
    ALTER TABLE OT0156 ADD RemainQuantity DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT0156' AND col.name = 'BeginDate')
    ALTER TABLE OT0156 ADD BeginDate DATETIME NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT0156' AND col.name = 'AdjustedUp')
    ALTER TABLE OT0156 ADD AdjustedUp DECIMAL(28,8) NULL

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT0156' AND col.name = 'AdjustedDown')
    ALTER TABLE OT0156 ADD AdjustedDown DECIMAL(28,8) NULL
	
END
