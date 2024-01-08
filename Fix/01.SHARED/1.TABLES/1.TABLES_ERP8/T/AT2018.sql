-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT2018]') AND type in (N'U'))
CREATE TABLE [dbo].[AT2018](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[WareHouseID] [nvarchar](50) NOT NULL,
	[WareHouseName] [nvarchar](250) NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[Orders] [nvarchar](250) NULL,
	[VoucherDate] [datetime] NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[ImVoucherDate] [datetime] NULL,
	[ImVoucherNo] [nvarchar](50) NULL,
	[ImSourceNo] [nvarchar](50) NULL,
	[ImWareHouseID] [nvarchar](50) NULL,
	[ImQuantity] [decimal](28, 8) NULL,
	[ImUnitPrice] [decimal](28, 8) NULL,
	[ImConvertedAmount] [decimal](28, 8) NULL,
	[ImOriginalAmount] [decimal](28, 8) NULL,
	[ImConvertedQuantity] [decimal](28, 8) NULL,
	[ExVoucherDate] [datetime] NULL,
	[ExVoucherNo] [nvarchar](50) NULL,
	[ExSourceNo] [nvarchar](50) NULL,
	[ExWareHouseID] [nvarchar](50) NULL,
	[ExQuantity] [decimal](28, 8) NULL,
	[ExUnitPrice] [decimal](28, 8) NULL,
	[ExConvertedAmount] [decimal](28, 8) NULL,
	[ExOriginalAmount] [decimal](28, 8) NULL,
	[ExConvertedQuantity] [decimal](28, 8) NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[InventoryName] [nvarchar](250) NULL,
	[UnitID] [nvarchar](50) NULL,
	[ConversionFactor] [decimal](28, 8) NULL,
	[ConversionUnitID] [nvarchar](50) NULL,
	[ConversionFactor2] [decimal](28, 8) NULL,
	[Operator] [tinyint] NULL,
	[BeginQuantity] [decimal](28, 8) NULL,
	[BeginAmount] [decimal](28, 8) NULL,
	[EndQuantity] [decimal](28, 8) NULL,
	[EndAmount] [decimal](28, 8) NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[Ana01Name] [nvarchar](250) NULL,
	[Ana02Name] [nvarchar](250) NULL,
	[Ana03Name] [nvarchar](250) NULL,
	[Ana04Name] [nvarchar](250) NULL,
	[Ana05Name] [nvarchar](250) NULL,
	[Notes01] [nvarchar](250) NULL,
	CONSTRAINT [PK_AT2018] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
If Exists (Select * From sysobjects Where name = 'AT2018' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'AT2018'  and col.name = 'Ana06ID')
Alter Table  AT2018 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End
If Exists (Select * From sysobjects Where name = 'AT2018' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'AT2018'  and col.name = 'Ana06Name')
Alter Table  AT2018 Add Ana06Name nvarchar(50) Null,
					 Ana07Name nvarchar(50) Null,
					 Ana08Name nvarchar(50) Null,
					 Ana09Name nvarchar(50) Null,
					 Ana10Name nvarchar(50) Null
End

---Modified by Bảo Thy on 08/05/2017: Bổ sung 20 quy cách (TUNGTEX)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2018' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S01ID') 
   ALTER TABLE AT2018 ADD S01ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S02ID') 
   ALTER TABLE AT2018 ADD S02ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S03ID') 
   ALTER TABLE AT2018 ADD S03ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S04ID') 
   ALTER TABLE AT2018 ADD S04ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S05ID') 
   ALTER TABLE AT2018 ADD S05ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S06ID') 
   ALTER TABLE AT2018 ADD S06ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S07ID') 
   ALTER TABLE AT2018 ADD S07ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S08ID') 
   ALTER TABLE AT2018 ADD S08ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S09ID') 
   ALTER TABLE AT2018 ADD S09ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S10ID') 
   ALTER TABLE AT2018 ADD S10ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S11ID') 
   ALTER TABLE AT2018 ADD S11ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S12ID') 
   ALTER TABLE AT2018 ADD S12ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S13ID') 
   ALTER TABLE AT2018 ADD S13ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S14ID') 
   ALTER TABLE AT2018 ADD S14ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S15ID') 
   ALTER TABLE AT2018 ADD S15ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S16ID') 
   ALTER TABLE AT2018 ADD S16ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S17ID') 
   ALTER TABLE AT2018 ADD S17ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S18ID') 
   ALTER TABLE AT2018 ADD S18ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S19ID') 
   ALTER TABLE AT2018 ADD S19ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT2018' AND col.name = 'S20ID') 
   ALTER TABLE AT2018 ADD S20ID VARCHAR(50) NULL 
	
END