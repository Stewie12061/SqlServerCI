-- <Summary>
---- Thông tin kho theo từng loại chi phí [Detail]
-- <History>
---- Create on 02/10/2021 by Nhựt Trường
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT2040]') AND type in (N'U'))
CREATE TABLE [dbo].[AT2040](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[BatchID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[UnitID] [nvarchar](50) NULL,
	[ActualQuantity] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[Notes] [nvarchar](250) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[SaleUnitPrice] [decimal](28, 8) NULL,
	[SaleAmount] [decimal](28, 8) NULL,
	[DiscountAmount] [decimal](28, 8) NULL,
	[SourceNo] [nvarchar](50) NULL,
	[WarrantyNo] [nvarchar](250) NULL,
	[ShelvesID] [nvarchar](50) NULL,
	[FloorID] [nvarchar](50) NULL,
	[DebitAccountID] [nvarchar](50) NULL,
	[CreditAccountID] [nvarchar](50) NULL,
	[LocationID] [nvarchar](50) NULL,
	[ImLocationID] [nvarchar](50) NULL,
	[LimitDate] [datetime] NULL,
	[Orders] [int] NOT NULL,
	[ConversionFactor] [decimal](28, 8) NULL,
	[ReTransactionID] [nvarchar](50) NULL,
	[ReVoucherID] [nvarchar](50) NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[Ana06ID] [nvarchar](50) Null,
	[Ana07ID] [nvarchar](50) Null,
	[Ana08ID] [nvarchar](50) Null,
	[Ana09ID] [nvarchar](50) Null,
	[Ana10ID] [nvarchar](50) Null,
	[PeriodID] [nvarchar](50) NULL,
	[ProductID] [nvarchar](50) NULL,
	[OrderID] [nvarchar](50) NULL,
	[InventoryName1] [nvarchar](500) NULL,
	[OTransactionID] [nvarchar](50) NULL,
	[ReSPVoucherID] [nvarchar](50) NULL,
	[ReSPTransactionID] [nvarchar](50) NULL,
	[ETransactionID] [nvarchar](50) NULL,
	[MTransactionID] [nvarchar](50) NULL,
	[Parameter01] [decimal](28, 8) NULL,
	[Parameter02] [decimal](28, 8) NULL,
	[Parameter03] [decimal](28, 8) NULL,
	[Parameter04] [decimal](28, 8) NULL,
	[Parameter05] [decimal](28, 8) NULL,
	[ConvertedQuantity] [decimal](28, 8) NULL,
	[ConvertedPrice] [decimal](28, 8) NULL,
	[ConvertedUnitID] [nvarchar](50) NULL,
	[MOrderID] [NVARCHAR](50) NULL,
	[SOrderID] [NVARCHAR](50) NULL,
	[STransactionID] [NVARCHAR](50) NULL,
	OExpenseConvertedAmount Decimal(28,8) NULL,
	WVoucherID NVARCHAR(50) NULL,
	StandardPrice DECIMAL(28,8) DEFAULT (0) NULL,
	StandardAmount DECIMAL(28,8) DEFAULT (0) NULL,
	InheritTableID NVARCHAR(50) NULL,
	InheritVoucherID VARCHAR(50) NULL,
	InheritTransactionID VARCHAR(50) NULL,
	RefInfor NVARCHAR(250) NULL,
	Notes01 NVARCHAR(250) NULL,
	Notes02 NVARCHAR(250) NULL,
	Notes03 NVARCHAR(250) NULL,
	Notes04 NVARCHAR(250) NULL,
	Notes05 NVARCHAR(250) NULL,
	LocationCode nvarchar(50) Null,
	Location01ID nvarchar(50) Null,
	Location02ID nvarchar(50) Null,
	Location03ID nvarchar(50) Null,
	Location04ID nvarchar(50) Null,
	Location05ID nvarchar(50) Null,
	KITID NVARCHAR(50) NULL,
	KITQuantity DECIMAL(28,8) NULL,
	TVoucherID VARCHAR(50) NULL,
	TTransactionID VARCHAR(50) NULL,
	SOrderIDRecognition VARCHAR(50) NULL,
	SerialNo VARCHAR(100) NULL,
	WarrantyCard NVARCHAR(250) NULL,
	PVoucherNo NVARCHAR(250) NULL,
	PLocationID NVARCHAR(250) NULL,
	IsRound TINYINT DEFAULT 0,
	IsCalculated TINYINT NULL,
	InheritPO VARCHAR(50) NULL,
	IsRepairItem BIT,
	VoucherNo_PO Nvarchar(50),
	VoucherNo_YCNK Nvarchar(50),
	ProductCostTypeID Nvarchar(50) NOT NULL,
	ExpenseID Nvarchar(50) NULL
	CONSTRAINT [PK_AT2040] PRIMARY KEY NONCLUSTERED 
(
	[TransactionID] ASC,
	[ProductCostTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2040_CurrencyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2040] ADD  CONSTRAINT [DF_AT2040_CurrencyID]  DEFAULT ('VND') FOR [CurrencyID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2040_ExchangeRate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2040] ADD  CONSTRAINT [DF_AT2040_ExchangeRate]  DEFAULT ((1)) FOR [ExchangeRate]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT2040_Orders]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT2040] ADD  CONSTRAINT [DF_AT2040_Orders]  DEFAULT ((0)) FOR [Orders]
END

If Exists (Select * From sysobjects Where name = 'AT2040' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT2040'  and col.name = 'MarkQuantity')
           Alter Table  AT2040 Add MarkQuantity DECIMAL(28,8) NULL
END
If Exists (Select * From sysobjects Where name = 'AT2040' and xtype ='U') 
Begin
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2040'  and col.name = 'Notes06')
        Alter Table  AT2040 Add Notes06 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2040'  and col.name = 'Notes07')
        Alter Table  AT2040 Add Notes07 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2040'  and col.name = 'Notes08')
        Alter Table  AT2040 Add Notes08 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2040'  and col.name = 'Notes09')
        Alter Table  AT2040 Add Notes09 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2040'  and col.name = 'Notes10')
        Alter Table  AT2040 Add Notes10 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2040'  and col.name = 'Notes11')
        Alter Table  AT2040 Add Notes11 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2040'  and col.name = 'Notes12')
        Alter Table  AT2040 Add Notes12 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2040'  and col.name = 'Notes13')
        Alter Table  AT2040 Add Notes13 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2040'  and col.name = 'Notes14')
        Alter Table  AT2040 Add Notes14 NVARCHAR(250) NULL           
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT2040'  and col.name = 'Notes15')
        Alter Table  AT2040 Add Notes15 NVARCHAR(250) NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2040' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2040' AND col.name = 'PS01ID')
        ALTER TABLE AT2040 ADD	PS01ID NVARCHAR(50) NULL,
								PS02ID NVARCHAR(50) NULL,
								PS03ID NVARCHAR(50) NULL,
								PS04ID NVARCHAR(50) NULL,
								PS05ID NVARCHAR(50) NULL,
								PS06ID NVARCHAR(50) NULL,
								PS07ID NVARCHAR(50) NULL,
								PS08ID NVARCHAR(50) NULL,
								PS09ID NVARCHAR(50) NULL,
								PS10ID NVARCHAR(50) NULL,
								PS11ID NVARCHAR(50) NULL,
								PS12ID NVARCHAR(50) NULL,
								PS13ID NVARCHAR(50) NULL,
								PS14ID NVARCHAR(50) NULL,
								PS15ID NVARCHAR(50) NULL,
								PS16ID NVARCHAR(50) NULL,
								PS17ID NVARCHAR(50) NULL,
								PS18ID NVARCHAR(50) NULL,
								PS19ID NVARCHAR(50) NULL,
								PS20ID NVARCHAR(50) NULL
    END
