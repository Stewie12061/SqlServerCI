-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Tố Oanh 
---- Modified on 31/10/2012 by Bảo Anh: Thêm trường ReMarkQuantity, DeMarkQuantity, EndMarkQuantity
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0114]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0114](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[InventoryID] [nvarchar](50) NULL,
	[WareHouseID] [nvarchar](50) NULL,
	[ReVoucherID] [nvarchar](50) NULL,
	[ReTransactionID] [nvarchar](50) NULL,
	[ReVoucherNo] [nvarchar](50) NULL,
	[ReVoucherDate] [datetime] NULL,
	[ReTranMonth] [int] NULL,
	[ReTranYear] [int] NULL,
	[ReSourceNo] [nvarchar](50) NULL,
	[ReWarrantyNo] [nvarchar](250) NULL,
	[ReShelvesID] [nvarchar](50) NULL,
	[ReFloorID] [nvarchar](50) NULL,
	
	[LimitDate] [datetime] NULL,
	[ReQuantity] [decimal](28, 8) NULL,
	[DeQuantity] [decimal](28, 8) NULL,
	[EndQuantity] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[DeVoucherID] [nvarchar](50) NULL,
	[DeTransactionID] [nvarchar](50) NULL,
	[DeVoucherNo] [nvarchar](50) NULL,
	[DeVoucherDate] [nvarchar](50) NULL,
	[DeLocationNo] [nvarchar](50) NULL,
	[DeTranMonth] [int] NULL,
	[DeTranYear] [int] NULL,
	[Status] [tinyint] NOT NULL,
	[IsLocked] [tinyint] NOT NULL
	CONSTRAINT [PK_AT0114] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON

)
) ON [PRIMARY]
END
---- Update giá trị default
IF NOT EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0114_IsLocked]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0114] ADD  CONSTRAINT [DF_AT0114_IsLocked]  DEFAULT ((0)) FOR [IsLocked]
END
IF NOT EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0114_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0114] ADD  CONSTRAINT [DF_AT0114_Status]  DEFAULT ((0)) FOR [Status]
END
---- AddColumns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0114' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0114' AND col.name='ReMarkQuantity')
		ALTER TABLE AT0114 ADD ReMarkQuantity DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0114' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0114' AND col.name='DeMarkQuantity')
		ALTER TABLE AT0114 ADD DeMarkQuantity DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0114' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0114' AND col.name='EndMarkQuantity')
		ALTER TABLE AT0114 ADD EndMarkQuantity DECIMAL(28,8) NULL
	END

---Modified by Bảo Thy on 19/04/2017: Bổ sung 20 quy cách (TUNGTEX)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0114' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S01ID') 
   ALTER TABLE AT0114 ADD S01ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S02ID') 
   ALTER TABLE AT0114 ADD S02ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S03ID') 
   ALTER TABLE AT0114 ADD S03ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S04ID') 
   ALTER TABLE AT0114 ADD S04ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S05ID') 
   ALTER TABLE AT0114 ADD S05ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S06ID') 
   ALTER TABLE AT0114 ADD S06ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S07ID') 
   ALTER TABLE AT0114 ADD S07ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S08ID') 
   ALTER TABLE AT0114 ADD S08ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S09ID') 
   ALTER TABLE AT0114 ADD S09ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S10ID') 
   ALTER TABLE AT0114 ADD S10ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S11ID') 
   ALTER TABLE AT0114 ADD S11ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S12ID') 
   ALTER TABLE AT0114 ADD S12ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S13ID') 
   ALTER TABLE AT0114 ADD S13ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S14ID') 
   ALTER TABLE AT0114 ADD S14ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S15ID') 
   ALTER TABLE AT0114 ADD S15ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S16ID') 
   ALTER TABLE AT0114 ADD S16ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S17ID') 
   ALTER TABLE AT0114 ADD S17ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S18ID') 
   ALTER TABLE AT0114 ADD S18ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S19ID') 
   ALTER TABLE AT0114 ADD S19ID VARCHAR(50) NULL 
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'S20ID') 
   ALTER TABLE AT0114 ADD S20ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'ReWarrantyNo') 
   ALTER TABLE AT0114 ADD ReWarrantyNo VARCHAR(250) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'ReShelvesID') 
   ALTER TABLE AT0114 ADD ReShelvesID VARCHAR(250) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'ReFloorID') 
   ALTER TABLE AT0114 ADD ReFloorID VARCHAR(250) NULL 
	
END

	----- Modify by Huỳnh Thử on 14/08/2020: Merge Code: MEKIO và MTE
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'AccountID') 
   ALTER TABLE AT0114 ADD AccountID VARCHAR(250) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0114' AND col.name = 'IsAVGData') 
   ALTER TABLE AT0114 ADD IsAVGData TINYINT DEFAULT 0
