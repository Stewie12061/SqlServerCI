-- <Summary>
---- Bang tam insert du lieu - Báo cáo thuế: Không tạo trong store in dữ liệu mà đưa ra ngoài riêng
-- <History>
---- Create on 14/02/2014 by Thanh Sơn
---- Modified by Hải Long  on 26/12/2016: Bổ sung trường InventoryID cho ANGEL
---- Modified by Kim Thư   on 12/2/2019: Bổ sung Mã phân tích Ana06ID, Ana06Name cho Bason
---- Modified by Đức Thông on 21/10/2020: Chỉnh sửa độ dài cột TDescription, VDescription, BDescription
---- Modified by Nhựt Trường on 17/06/2021: Bổ sung cột TypeOfAdjust.
---- Modified by Nhựt Trường on 05/07/2021: Bổ sung Mã phân tích Ana02ID, Ana02Name cho Phúc Long.
---- Modified by Nhựt Trường on 14/01/2022: Tăng độ dài trường BDescription từ 250 -> 500.
---- <Example>
IF  EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT7419]') AND TYPE IN (N'U'))
DROP TABLE AT7419
CREATE TABLE [dbo].[AT7419] (
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar] (50) NULL ,
	[VoucherID] [nvarchar] (50) NOT NULL ,
	[BatchID] [nvarchar] (50) NOT NULL ,
	[TransactionID] [nvarchar] (50) NOT NULL ,
	[TransactionTypeID] [nvarchar] (50) NOT NULL ,
	[AccountID] [nvarchar] (50) NULL ,
	[CorAccountID] [nvarchar] (50) NOT NULL ,
	[D_C] [nvarchar] (1) NOT NULL ,
	[DebitAccountID] [nvarchar] (50) NULL ,
	[CreditAccountID] [nvarchar] (50) NULL ,
	[VoucherDate] [datetime] NULL ,
	[VoucherTypeID] [nvarchar] (50) NULL ,
	[VoucherNo] [nvarchar] (50) NULL ,
	[InvoiceDate] [datetime] NULL ,
	[InvoiceNo] [nvarchar] (50)  NULL ,
	[Serial] [nvarchar] (50)  NULL ,
	[ConvertedAmount] [decimal](28, 8) NULL ,
	[OriginalAmount] [decimal](28, 8) NULL ,
	[ImTaxConvertedAmount] [decimal](28, 8) NULL ,
	[ImTaxOriginalAmount] [decimal](28, 8) NULL ,
	[CurrencyID] [nvarchar] (50) NULL ,
	[Quantity] [decimal](28, 8) NULL ,
	[ExchangeRate] [decimal](28, 8) NULL ,
	[SignAmount] [decimal](28, 8) NULL ,
	[OSignAmount] [decimal](28, 8) NULL ,
	[TranMonth] [int] NULL ,
	[TranYear] [int] NULL ,
	[CreateUserID] [nvarchar] (50) NULL ,
	[VDescription] [nvarchar] (500) NULL ,
	[BDescription] [nvarchar] (500) NULL ,
	[TDescription] [nvarchar] (500) NULL ,
	[ObjectID] [nvarchar] (50) NULL ,
	[VATObjectID] [nvarchar] (50) NULL ,
	[VATNo] [nvarchar] (50) NULL ,
	[VATObjectName] [nvarchar] (250) NULL ,
	[ObjectAddress] [nvarchar] (250) NULL ,
	[VATTypeID] [nvarchar] (50) NULL ,
	[VATGroupID] [nvarchar] (50) NULL,
	[DueDate] [datetime] NULL,
	[InvoiceCode] NVARCHAR(50) NULL,
	[InvoiceSign] NVARCHAR(50) NULL 
CONSTRAINT [PK_AT7419] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]			 
) ON [PRIMARY]


---- Modified by Hải Long on 09/12/2016: Bổ sung trường InventoryID cho ANGEL
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7419' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='InventoryID')
		ALTER TABLE AT7419 ADD InventoryID NVARCHAR(50) NULL
	END	

---- Modified by Kim Thư on 12/2/2019: Bổ sung Mã phân tích Ana06ID, Ana06Name cho Bason
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7419' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='Ana06ID')
		ALTER TABLE AT7419 ADD Ana06ID NVARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='Ana06Name')
		ALTER TABLE AT7419 ADD Ana06Name NVARCHAR(MAX) NULL
	END

---- Modified by Nhựt Trường on 17/06/2021: Bổ sung cột TypeOfAdjust
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7419' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='TypeOfAdjust')
		ALTER TABLE AT7419 ADD TypeOfAdjust TINYINT NULL
	END	

---- Modified by Nhựt Trường on 05/07/2021: Bổ sung Mã phân tích Ana02ID, Ana02Name cho Phúc Long
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7419' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='Ana02ID')
		ALTER TABLE AT7419 ADD Ana02ID NVARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='Ana02Name')
		ALTER TABLE AT7419 ADD Ana02Name NVARCHAR(MAX) NULL
	END
	
	
---- Modified by Nhật Thanh on 14/12/2021: Bổ sung trường UserID cho ANGEL
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7419' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='UserID')
		ALTER TABLE AT7419 ADD UserID NVARCHAR(50) NULL
	END	

---- Modified by Nhật Thanh on 14/12/2021: Bổ sung trường CreateDate
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7419' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='CreateDate')
		ALTER TABLE AT7419 ADD CreateDate DATETIME NULL
	END	

---- Modified by Nhựt Trường on 24/01/2022: Tăng độ dài trường BDescription từ 250 -> 500
If Exists (Select * From sysobjects Where name = 'AT7419' and xtype ='U')
Begin
If exists (select * from syscolumns col inner join sysobjects tab
On col.id = tab.id where tab.name = 'AT7419' and col.name = 'BDescription')
Alter Table AT7419 Alter Column BDescription [nvarchar](500) NULL
End

---- Modified by Nhựt Trường on 08/04/2022: Bổ sung trường InventoryName
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7419' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='InventoryName')
		ALTER TABLE AT7419 ADD InventoryName NVARCHAR(250) NULL
	END	

---- Modified by Nhựt Trường on 08/04/2022: Bổ sung trường UnitID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7419' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='UnitID')
		ALTER TABLE AT7419 ADD UnitID NVARCHAR(50) NULL
	END	

---- Modified by Nhựt Trường on 08/04/2022: Bổ sung trường UnitPrice
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7419' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='UnitPrice')
		ALTER TABLE AT7419 ADD UnitPrice DECIMAL(28,8) NULL
	END	

	---- Modified by Đình Định on 10/10/2023: Bổ sung trường IsMultiTax
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7419' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='IsMultiTax')
		ALTER TABLE AT7419 ADD IsMultiTax TINYINT NULL
	END	

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7419' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='VATOriginalAmount')
		ALTER TABLE AT7419 ADD VATOriginalAmount DECIMAL (28, 8)
	END	

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT7419' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT7419' AND col.name='VATConvertedAmount')
		ALTER TABLE AT7419 ADD VATConvertedAmount DECIMAL (28, 8)
	END	

