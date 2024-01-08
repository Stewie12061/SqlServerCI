---- Create by Đặng Thị Tiểu Mai on 05/09/2016 2:31:09 PM
---- Kế hoạch sản xuất tháng - Detail (AN PHÁT)
---- Modified by Tiểu Mai on 17/10/2016: Bổ sung trường ObjectID1 (CustomizeIndex = 54 -- An Phát)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT0182]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[MT0182]
     (
		[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
		[DivisionID] NVARCHAR(50) NOT NULL,
		[VoucherID] NVARCHAR(50) NULL,
		[TransactionID] NVARCHAR(50) DEFAULT NEWID() NOT NULL,
		[TranMonth] INT NULL,
		[TranYear] INT NULL,
		[ObjectID2] NVARCHAR(50) NULL,
		[PO] NVARCHAR(250) NULL,
		[InventoryID] NVARCHAR(50) NULL,
		[UnitID] NVARCHAR(50) NULL,
		[S01ID] NVARCHAR(50) NULL,
		[S02ID] NVARCHAR(50) NULL,
		[S03ID] NVARCHAR(50) NULL,
		[S04ID] NVARCHAR(50) NULL,
		[S05ID] NVARCHAR(50) NULL,
		[S06ID] NVARCHAR(50) NULL,
		[S07ID] NVARCHAR(50) NULL,
		[S08ID] NVARCHAR(50) NULL,
		[S09ID] NVARCHAR(50) NULL,
		[S10ID] NVARCHAR(50) NULL,
		[S11ID] NVARCHAR(50) NULL,
		[S12ID] NVARCHAR(50) NULL,
		[S13ID] NVARCHAR(50) NULL,
		[S14ID] NVARCHAR(50) NULL,
		[S15ID] NVARCHAR(50) NULL,
		[S16ID] NVARCHAR(50) NULL,
		[S17ID] NVARCHAR(50) NULL,
		[S18ID] NVARCHAR(50) NULL,
		[S19ID] NVARCHAR(50) NULL,
		[S20ID] NVARCHAR(50) NULL,
		[Quantity] DECIMAL(28,8) NULL,
		[UnitPrice] DECIMAL(28,8) NULL,
		[ConvertedAmount] DECIMAL(28,8) NULL,
		[SyncDate] DATETIME NULL,
		[DeliverDate] DATETIME NULL,
		[Notes] NVARCHAR(250) NULL,
		[Ana01ID] NVARCHAR(50) NULL,
		[Ana02ID] NVARCHAR(50) NULL,
		[Ana03ID] NVARCHAR(50) NULL,
		[Ana04ID] NVARCHAR(50) NULL,
		[Ana05ID] NVARCHAR(50) NULL,
		[Ana06ID] NVARCHAR(50) NULL,
		[Ana07ID] NVARCHAR(50) NULL,
		[Ana08ID] NVARCHAR(50) NULL,
		[Ana09ID] NVARCHAR(50) NULL,
		[Ana10ID] NVARCHAR(50) NULL,
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
		[NextQuantity] DECIMAL(28,8) NULL,
		[Orders] INT NULL
    CONSTRAINT [PK_MT0182] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

--- Modified by Tiểu Mai on 17/10/2016: Bổ sung trường ObjectID1 (CustomizeIndex = 54 -- An Phát)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'MT0182' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'MT0182' AND col.name = 'ObjectID1')
		ALTER TABLE MT0182 ADD ObjectID1 NVARCHAR(50) NULL
	END

--- Modified by Tiểu Mai on 26/10/2016: Bổ sung cho An Phát (CustomizeIndex = 54 )
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'MT0182' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'MT0182' AND col.name = 'InvoiceNo')
		ALTER TABLE MT0182 ADD InvoiceNo NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'MT0182' AND col.name = 'InvoiceDate')
		ALTER TABLE MT0182 ADD InvoiceDate DATETIME NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'MT0182' AND col.name = 'ExchangeRate')
		ALTER TABLE MT0182 ADD ExchangeRate DECIMAL(28,8) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'MT0182' AND col.name = 'PhaseDecimal')
		ALTER TABLE MT0182 ADD PhaseDecimal DECIMAL(28,8) NULL
	END
	
