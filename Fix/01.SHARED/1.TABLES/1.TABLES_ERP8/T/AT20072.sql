-- <Summary>
---- Bảng sao chép dữ liệu từ AT2007 của 1 tháng,dùng để tính giá xuất kho
-- <History>
---- Create on 27/03/2018 by Bảo Anh
---- Modified on

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT20072]') AND type in (N'U'))
CREATE TABLE [dbo].[AT20072](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[KindVoucherID] [int] NULL,
	[WarehouseID] [nvarchar](50) NULL,
	[WarehouseID2] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[UnitID] [nvarchar](50) NULL,
	[ActualQuantity] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[ConvertedPrice] [decimal](28, 8) NULL, 
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[TableID] [nvarchar](50) NULL,
	[DebitAccountID] [nvarchar](50) NULL,
	[CreditAccountID] [nvarchar](50) NULL,
	[ReTransactionID] [nvarchar](50) NULL,
	[InheritVoucherID] [nvarchar](50) NULL,
	[InheritTransactionID] [nvarchar](50) NULL,
	[InheritTableID] [nvarchar](50) NULL,
	[IsNotUpdatePrice] [TINYINT] NULL,
	[IsReturn] [TINYINT] NULL,
	
 CONSTRAINT [PK_AT20072] PRIMARY KEY NONCLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT20072' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT20072' AND col.name='IsReturn')
		ALTER TABLE AT20072 ADD IsReturn TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT20072' AND col.name='IsNotUpdatePrice')
		ALTER TABLE AT20072 ADD IsNotUpdatePrice TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT20072' AND col.name='InheritTableID')
		ALTER TABLE AT20072 ADD InheritTableID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT20072' AND col.name='InheritVoucherID')
		ALTER TABLE AT20072 ADD InheritVoucherID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT20072' AND col.name='InheritTransactionID')
		ALTER TABLE AT20072 ADD InheritTransactionID VARCHAR(50) NULL
	END
	