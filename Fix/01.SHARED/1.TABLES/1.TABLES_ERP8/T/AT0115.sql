-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Tố Oanh 
---- Modified on 14/08/2020 by Huỳnh Thử -- Merge Code: MEKIO và MTE
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0115]') AND type in (N'U'))
--DROP TABLE [dbo].[AT0115]
CREATE TABLE [dbo].[AT0115](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[WareHouseID] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherID] [nvarchar](50) NULL,
	[TransactionID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[PriceQuantity] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[ReVoucherID] [nvarchar](50) NULL,
	[ReTransactionID] [nvarchar](50) NULL,
	[ReVoucherDate] [datetime] NULL,
	[ReVoucherNo] [nvarchar](50) NULL,
	CONSTRAINT [PK_AT0115] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON
)
) ON [PRIMARY]

DECLARE @CustomerIndex INT 
SELECT @CustomerIndex = CustomerName FROM dbo.CustomerIndex 
---Modified by Bảo Thy on 19/04/2017: Bổ sung 20 quy cách (TUNGTEX)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0115' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S01ID') 
   ALTER TABLE AT0115 ADD S01ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S02ID') 
   ALTER TABLE AT0115 ADD S02ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S03ID') 
   ALTER TABLE AT0115 ADD S03ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S04ID') 
   ALTER TABLE AT0115 ADD S04ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S05ID') 
   ALTER TABLE AT0115 ADD S05ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S06ID') 
   ALTER TABLE AT0115 ADD S06ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S07ID') 
   ALTER TABLE AT0115 ADD S07ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S08ID') 
   ALTER TABLE AT0115 ADD S08ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S09ID') 
   ALTER TABLE AT0115 ADD S09ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S10ID') 
   ALTER TABLE AT0115 ADD S10ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S11ID') 
   ALTER TABLE AT0115 ADD S11ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S12ID') 
   ALTER TABLE AT0115 ADD S12ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S13ID') 
   ALTER TABLE AT0115 ADD S13ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S14ID') 
   ALTER TABLE AT0115 ADD S14ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S15ID') 
   ALTER TABLE AT0115 ADD S15ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S16ID') 
   ALTER TABLE AT0115 ADD S16ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S17ID') 
   ALTER TABLE AT0115 ADD S17ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S18ID') 
   ALTER TABLE AT0115 ADD S18ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S19ID') 
   ALTER TABLE AT0115 ADD S19ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'S20ID') 
   ALTER TABLE AT0115 ADD S20ID VARCHAR(50) NULL 
	
END


	----- Modify by Huỳnh Thử on 14/08/2020: Merge Code: MEKIO và MTE
	----- Modify by Phương Thảo on 06/09/2016: Add column CreateDate, CreateUserID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0115' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'CreateDate')
        ALTER TABLE AT0115 ADD CreateDate DATETIME NULL

        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0115' AND col.name = 'CreateUserID')
        ALTER TABLE AT0115 ADD CreateUserID NVARCHAR(50) NULL

    END
