-- <Summary>
---- Thông tin phiếu lắp ráp detail (ANGEL)
-- <History>
---- Created by Tiểu Mai on 27/07/2016
---- Modified on 16/09/2016 by Hải Long: Bổ sung trường thêm 2 trường ReVoucherID, ReTransactionID
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0113]') AND type in (N'U'))
CREATE TABLE [dbo].[AT0113](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[BatchID] [nvarchar](50) NULL,
	[KindVoucherID] [int] NULL, --- 1: Nhap, 2: Xuat
	[ImWareHouseID] [nvarchar](50) NULL,
	[ExWareHouseID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[UnitID] [nvarchar](50) NULL,
	[ActualQuantity] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[IsLedger] INT DEFAULT(0) NULL, --- 0: ko ghi vao so cai, 1: ghi
	[Notes] [nvarchar](250) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[SourceNo] [nvarchar](50) NULL,
	[DebitAccountID] [nvarchar](50) NULL,
	[CreditAccountID] [nvarchar](50) NULL,
	[LocationID] [nvarchar](50) NULL,
	[ImLocationID] [nvarchar](50) NULL,
	[LimitDate] [datetime] NULL,
	[Orders] [int] NOT NULL,
	[ConversionFactor] [decimal](28, 8) NULL,
	[ImStoreManID] [nvarchar](50) NULL,
	[ExStoreManID] [nvarchar](50) NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[Ana06ID] [nvarchar](50) NULL,
	[Ana07ID] [nvarchar](50) NULL,
	[Ana08ID] [nvarchar](50) NULL,
	[Ana09ID] [nvarchar](50) NULL,
	[Ana10ID] [nvarchar](50) NULL,
	[Parameter01] [decimal](28, 8) NULL,
	[Parameter02] [decimal](28, 8) NULL,
	[Parameter03] [decimal](28, 8) NULL,
	[Parameter04] [decimal](28, 8) NULL,
	[Parameter05] [decimal](28, 8) NULL,
	[Parameter06] [decimal](28, 8) NULL,
	[Parameter07] [decimal](28, 8) NULL,
	[Parameter08] [decimal](28, 8) NULL,
	[Parameter09] [decimal](28, 8) NULL,
	[Parameter10] [decimal](28, 8) NULL,
	[ConvertedQuantity] [decimal](28, 8) NULL,
	[ConvertedPrice] [decimal](28, 8) NULL,
	[ConvertedUnitID] [nvarchar](50) NULL,
	
 CONSTRAINT [PK_AT0113] PRIMARY KEY NONCLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0113_CurrencyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0113] ADD  CONSTRAINT [DF_AT0113_CurrencyID]  DEFAULT ('VND') FOR [CurrencyID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0113_ExchangeRate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].AT0113 ADD  CONSTRAINT [DF_AT0113_ExchangeRate]  DEFAULT ((1)) FOR [ExchangeRate]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0113_Orders]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].AT0113 ADD  CONSTRAINT [DF_AT0113_Orders]  DEFAULT ((0)) FOR [Orders]
END

--- Bổ sung trường thêm 2 trường ReVoucherID, ReTransactionID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0113' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0113' AND col.name = 'ReVoucherID')
        ALTER TABLE AT0113 ADD ReVoucherID NVARCHAR(50) NULL
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0113' AND col.name = 'ReTransactionID')
        ALTER TABLE AT0113 ADD ReTransactionID NVARCHAR(50) NULL
    END

--- [Kiều Nga][10/06/2021]Bổ sung trường thêm trường IsNotUpdatePrice, IsReturn,Rate
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0113' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0113' AND col.name = 'IsNotUpdatePrice')
        ALTER TABLE AT0113 ADD IsNotUpdatePrice TINYINT NULL

        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0113' AND col.name = 'IsReturn')
        ALTER TABLE AT0113 ADD IsReturn TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0113' AND col.name = 'Rate')
        ALTER TABLE AT0113 ADD Rate Decimal (28, 8) NULL
    END

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0113' AND xtype = 'U')
BEGIN
    IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0113' AND col.name = 'DivisionID')
	ALTER TABLE AT0113 ALTER COLUMN DivisionID [nvarchar](50) NOT NULL
END

