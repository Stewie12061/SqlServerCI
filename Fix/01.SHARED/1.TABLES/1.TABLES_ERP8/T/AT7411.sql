-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Thanh Nguyen
---- Modified on 21/09/2015 by Tiểu Mai: Add 2 columns: DebitAccountID, CreditAccountID
---- Modified on 12/02/2019 by Kim Thư: Bổ sung Ana06ID, Ana06Name cho Bason
---- Modified on 20/03/2019 by Kim Thư: Bổ sung TDescription cho Bason
---- Modified on 12/07/2019 by Kim Thư: Bổ sung InventoryID, InventoryName
---- Modified on 05/07/2021 by Nhựt Trường: Bổ sung Mã phân tích Ana02ID, Ana02Name cho Phúc Long.
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT7411]') AND type in (N'U'))
CREATE TABLE [dbo].[AT7411](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[BatchID] [nvarchar](50) NULL,
	[VoucherID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[InvoiceDate] [datetime] NULL,
	[Serial] [nvarchar](50) NULL,
	[VDescription] [nvarchar](250) NULL,
	[BDescription] [nvarchar](250) NULL,
	[VoucherDate] [datetime] NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[OriginalTaxAmount] [decimal](28, 8) NULL,
	[ConvertedTaxAmount] [decimal](28, 8) NULL,
	[OriginalNetAmount] [decimal](28, 8) NULL,
	[ConvertedNetAmount] [decimal](28, 8) NULL,
	[SignNetAmount] [decimal](28, 8) NULL,
	[SignTaxAmount] [decimal](28, 8) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[VATObjectID] [nvarchar](50) NULL,
	[VATNo] [nvarchar](50) NULL,
	[VATObjectName] [nvarchar](250) NULL,
	[ObjectAddress] [nvarchar](250) NULL,
	[VATGroupID] [nvarchar](50) NULL,
	[VATTypeID] [nvarchar](50) NULL,
	[CreateUserID] [varbinary](50) NULL,
	[VATRate] [nvarchar](50) NULL,
	[Quantity] [decimal](28, 8) NULL,
	[DueDate] [datetime] NULL,
	[VATTradeName] [nvarchar](250) NULL,
	[InvoiceCode] [nvarchar](50) NULL,
	[InvoiceSign] [nvarchar](50) NULL,
	CONSTRAINT [PK_AT7411] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

-- Add columns
If Exists (Select * From sysobjects Where name = 'AT7411' and xtype ='U') 
BEGIN
	If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7411'  and col.name = 'DebitAccountID')
           Alter Table  AT7411 Add DebitAccountID NVARCHAR(50) NULL
    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7411'  and col.name = 'CreditAccountID')
           Alter Table  AT7411 Add CreditAccountID NVARCHAR(50) NULL       
END

-- Add columns
If Exists (Select * From sysobjects Where name = 'AT7411' and xtype ='U') 
BEGIN
	If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7411'  and col.name = 'InvoiceCode')
           Alter Table  AT7411 Add InvoiceCode NVARCHAR(50) NULL
    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7411'  and col.name = 'InvoiceSign')
           Alter Table  AT7411 Add InvoiceSign NVARCHAR(50) NULL       
END

---- Modified on 12/02/2019 by Kim Thư: Bổ sung Ana06ID, Ana06Name cho Bason
If Exists (Select * From sysobjects Where name = 'AT7411' and xtype ='U') 
BEGIN
	If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7411'  and col.name = 'Ana06ID')
           Alter Table  AT7411 Add Ana06ID NVARCHAR(50) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7411'  and col.name = 'Ana06Name')
           Alter Table  AT7411 Add Ana06Name NVARCHAR(MAX) NULL
END

---- Modified on 20/03/2019 by Kim Thư: Bổ sung TDescription cho Bason
If Exists (Select * From sysobjects Where name = 'AT7411' and xtype ='U') 
BEGIN
	If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7411'  and col.name = 'TDescription')
           Alter Table  AT7411 Add TDescription NVARCHAR(MAX) NULL
END 

---- Modified on 12/07/2019 by Kim Thư: Bổ sung InventoryID, InventoryName
If Exists (Select * From sysobjects Where name = 'AT7411' and xtype ='U') 
BEGIN
	If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7411'  and col.name = 'InventoryID')
           Alter Table  AT7411 Add InventoryID VARCHAR(50) NULL
	
	If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7411'  and col.name = 'InventoryName')
           Alter Table  AT7411 Add InventoryName NVARCHAR(MAX) NULL
END 

---- Modified on 05/07/2021 by Nhựt Trường: Bổ sung Ana02ID, Ana02Name cho Phúc Long
If Exists (Select * From sysobjects Where name = 'AT7411' and xtype ='U') 
BEGIN
	If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7411'  and col.name = 'Ana02ID')
           Alter Table  AT7411 Add Ana02ID NVARCHAR(50) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7411'  and col.name = 'Ana02Name')
           Alter Table  AT7411 Add Ana02Name NVARCHAR(MAX) NULL
END
---- Modified by Nhật Thanh on 14/12/2021: Bổ sung trường UserID cho ANGEL
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7411' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7411' AND col.name='UserID')
		ALTER TABLE AT7411 ADD UserID NVARCHAR(50) NULL
	END	
	---- Modified by Nhật Thanh on 14/12/2021: Bổ sung trường CreateDate
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7411' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7411' AND col.name='CreateDate')
		ALTER TABLE AT7411 ADD CreateDate DATETIME NULL
	END	

---- Modified by Nhựt Trường on 08/04/2022: Bổ sung trường UnitID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7411' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7411' AND col.name='UnitID')
		ALTER TABLE AT7411 ADD UnitID NVARCHAR(50) NULL
	END

---- Modified by Nhựt Trường on 08/04/2022: Bổ sung trường UnitPrice
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7411' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7411' AND col.name='UnitPrice')
		ALTER TABLE AT7411 ADD UnitPrice DECIMAL(28,8) NULL
	END	

	---- Modified by Đình Định on 10/10/2023: Bổ sung trường IsMultiTax
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7411' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7411' AND col.name='IsMultiTax')
		ALTER TABLE AT7411 ADD IsMultiTax TINYINT NULL
	END

---- Modified by Kiều Nga on 13/10/2023: Bổ sung trường TypeID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7411' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7411' AND col.name='TypeID')
		ALTER TABLE AT7411 ADD TypeID INT NULL
	END	