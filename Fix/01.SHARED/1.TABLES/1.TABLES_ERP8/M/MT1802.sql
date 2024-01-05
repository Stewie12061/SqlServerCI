---- Create by Đặng Thị Tiểu Mai on 25/02/2016 11:12:23 AM
---- Thống kê sản xuất (Detail - Angel)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT1802]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[MT1802]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [VoucherID] NVARCHAR(50) NOT NULL,
      [TransactionID] NVARCHAR(50) NOT NULL,
      [CombineID] NVARCHAR(50) NULL,
      [TableID] NVARCHAR(50) NULL,
      [InventoryID] NVARCHAR(50) NULL,
      [UnitID] NVARCHAR(50) NULL,
      [ProductID] NVARCHAR(50) NULL,
      [ProductUnitID] NVARCHAR(50) NULL,
      [LateQuantity] DECIMAL(28,8) NULL,
      [RecieveQuantity] DECIMAL(28,8) NULL,
      [UseQuantity] DECIMAL(28,8) NULL,
      [RemainQuantity] DECIMAL(28,8) NULL,
      [Shift] NVARCHAR(50) NULL,
      [BeginTime] DATETIME NULL,
      [EndTime] DATETIME NULL,
      [ActualTime] NVARCHAR(50) NULL,
      [LimitDate] DATETIME NULL,
      [ActualQuantity] DECIMAL(28,8) NULL,
      [IsImport] TINYINT DEFAULT (0) NULL,
      [WarehouseID] NVARCHAR(50) NULL,
      [TypeTab] TINYINT NULL,
      [ErrorQuantity] DECIMAL(28,8) NULL,
      [ErrorTypeID] NVARCHAR(50) NULL,
      [RecycleQuantity] DECIMAL(28,8) NULL,
      [FixQuantity] DECIMAL(28,8) NULL,
      [CancelQuantity] DECIMAL(28,8) NULL,
      [StopCausal] NVARCHAR(250) NULL,
      [Parameter01] NVARCHAR(100) NULL,
      [Parameter02] NVARCHAR(100) NULL,
      [Parameter03] NVARCHAR(100) NULL,
      [Parameter04] NVARCHAR(100) NULL,
      [Parameter05] NVARCHAR(100) NULL,
      [Parameter06] NVARCHAR(100) NULL,
      [Parameter07] NVARCHAR(100) NULL,
      [Parameter08] NVARCHAR(100) NULL,
      [Parameter09] NVARCHAR(100) NULL,
      [Parameter10] NVARCHAR(100) NULL,
      [Parameter11] NVARCHAR(100) NULL,
      [Parameter12] NVARCHAR(100) NULL,
      [Parameter13] NVARCHAR(100) NULL,
      [Parameter14] NVARCHAR(100) NULL,
      [Parameter15] NVARCHAR(100) NULL,
      [Parameter16] NVARCHAR(100) NULL,
      [Parameter17] NVARCHAR(100) NULL,
      [Parameter18] NVARCHAR(100) NULL,
      [Parameter19] NVARCHAR(100) NULL,
      [Parameter20] NVARCHAR(100) NULL,
      [Orders] INT NULL,
      [ReVoucherID] NVARCHAR(50),
      [ReTransactionID] NVARCHAR(50),
      [Ana01ID] NVARCHAR(50),
      [Ana02ID] NVARCHAR(50),
      [Ana03ID] NVARCHAR(50),
      [Ana04ID] NVARCHAR(50),
      [Ana05ID] NVARCHAR(50),
      [Ana06ID] NVARCHAR(50),
      [Ana07ID] NVARCHAR(50),
      [Ana08ID] NVARCHAR(50),
      [Ana09ID] NVARCHAR(50),
      [Ana10ID] NVARCHAR(50)
    CONSTRAINT [PK_MT1802] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [VoucherID],
      [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END


---- Modified by Hải Long on 08/08/2017: Bổ sung các cột (Bê Tông Long An)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='MT1802' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S01ID')
		ALTER TABLE MT1802 ADD S01ID NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S02ID')
		ALTER TABLE MT1802 ADD S02ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S03ID')
		ALTER TABLE MT1802 ADD S03ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S04ID')
		ALTER TABLE MT1802 ADD S04ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S05ID')
		ALTER TABLE MT1802 ADD S05ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S06ID')
		ALTER TABLE MT1802 ADD S06ID NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S07ID')
		ALTER TABLE MT1802 ADD S07ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S08ID')
		ALTER TABLE MT1802 ADD S08ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S09ID')
		ALTER TABLE MT1802 ADD S09ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S10ID')
		ALTER TABLE MT1802 ADD S10ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S11ID')
		ALTER TABLE MT1802 ADD S11ID NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S12ID')
		ALTER TABLE MT1802 ADD S12ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S13ID')
		ALTER TABLE MT1802 ADD S13ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S14ID')
		ALTER TABLE MT1802 ADD S14ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S15ID')
		ALTER TABLE MT1802 ADD S15ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S16ID')
		ALTER TABLE MT1802 ADD S16ID NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S17ID')
		ALTER TABLE MT1802 ADD S17ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S18ID')
		ALTER TABLE MT1802 ADD S18ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S19ID')
		ALTER TABLE MT1802 ADD S19ID NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='S20ID')
		ALTER TABLE MT1802 ADD S20ID NVARCHAR(50) NULL															
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='ConvertedActualQuantity')
		ALTER TABLE MT1802 ADD ConvertedActualQuantity DECIMAL(28,8) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='InheritVoucherID')
		ALTER TABLE MT1802 ADD InheritVoucherID NVARCHAR(50) NULL															
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='InheritTransactionID')
		ALTER TABLE MT1802 ADD InheritTransactionID NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT1802' AND col.name='InheritTableID')
		ALTER TABLE MT1802 ADD InheritTableID NVARCHAR(50) NULL					
	END	