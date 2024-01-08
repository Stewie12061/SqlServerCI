-- <Summary>
---- Chi tiết mặt hàng trong hợp đồng (customize Angel)
-- <History>
---- Create on 03/01/2016 by Bảo Anh
---- Modify on 12/12/2022 by Phương Thảo Update Type  cột DivisionID

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1031]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1031](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[ContractID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[UnitID] [nvarchar](50) NULL,
	[OrderQuantity] [decimal](28, 8) NULL,
	[SalePrice] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[VATGroupID] [nvarchar](50) NULL,
	[VATOriginalAmount] [decimal](28, 8) NULL,
	[VATConvertedAmount] [decimal](28, 8) NULL,
	[VATPercent] [decimal](28, 8) NULL,
	[DiscountOriginalAmount] [decimal](28, 8) NULL,
	[DiscountConvertedAmount] [decimal](28, 8) NULL,
	[DiscountPercent] [decimal](28, 8) NULL,
	[Notes] [nvarchar](250) NULL,
	[InheritTableID] [nvarchar] (20) NULL,
	[InheritVoucherID] [nvarchar](50) NULL,
	[InheritTransactionID] [nvarchar](50) NULL,
	
 CONSTRAINT [PK_AT1031] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[ContractID] ASC,
	[TransactionID]
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1031' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'BeginDate') 
   ALTER TABLE AT1031 ADD BeginDate DATETIME NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'EndDate') 
   ALTER TABLE AT1031 ADD EndDate DATETIME NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'ActBeginDate') 
   ALTER TABLE AT1031 ADD ActBeginDate DATETIME NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'ActEndDate') 
   ALTER TABLE AT1031 ADD ActEndDate DATETIME NULL
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'InventoryTypeID') 
   ALTER TABLE AT1031 ADD InventoryTypeID VARCHAR(50) NULL  

END


-- Bổ sung cột orders, đơn giá, số lượng quy đổi, 20 cột quy cách cho khách hàng TDCLA
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1031' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'Orders') 
   ALTER TABLE AT1031 ADD Orders INT NULL	
	
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'ConvertedOrderQuantity') 
   ALTER TABLE AT1031 ADD ConvertedOrderQuantity DECIMAL(28, 8) NULL
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'ConvertedSalePrice') 
   ALTER TABLE AT1031 ADD ConvertedSalePrice DECIMAL(28, 8) NULL  	
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S01ID') 
   ALTER TABLE AT1031 ADD S01ID VARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S02ID') 
   ALTER TABLE AT1031 ADD S02ID VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S03ID') 
   ALTER TABLE AT1031 ADD S03ID VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S04ID') 
   ALTER TABLE AT1031 ADD S04ID VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S05ID') 
   ALTER TABLE AT1031 ADD S05ID VARCHAR(50) NULL    
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S06ID') 
   ALTER TABLE AT1031 ADD S06ID VARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S07ID') 
   ALTER TABLE AT1031 ADD S07ID VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S08ID') 
   ALTER TABLE AT1031 ADD S08ID VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S09ID') 
   ALTER TABLE AT1031 ADD S09ID VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S10ID') 
   ALTER TABLE AT1031 ADD S10ID VARCHAR(50) NULL       
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S11ID') 
   ALTER TABLE AT1031 ADD S11ID VARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S12ID') 
   ALTER TABLE AT1031 ADD S12ID VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S13ID') 
   ALTER TABLE AT1031 ADD S13ID VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S14ID') 
   ALTER TABLE AT1031 ADD S14ID VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S15ID') 
   ALTER TABLE AT1031 ADD S15ID VARCHAR(50) NULL    
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S16ID') 
   ALTER TABLE AT1031 ADD S16ID VARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S17ID') 
   ALTER TABLE AT1031 ADD S17ID VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S18ID') 
   ALTER TABLE AT1031 ADD S18ID VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S19ID') 
   ALTER TABLE AT1031 ADD S19ID VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'S20ID') 
   ALTER TABLE AT1031 ADD S20ID VARCHAR(50) NULL               	
END 

---- Modified by Bảo Thy on 15/01/2018: bổ sung thông tin Đơn giá quy đổi theo mét và Số lượng Mét/cọc (CustomerIndex=80)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1031' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'UnitQuantity') 
   ALTER TABLE AT1031 ADD UnitQuantity DECIMAL(28,8) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'ConvertedUnitPrice') 
   ALTER TABLE AT1031 ADD ConvertedUnitPrice DECIMAL(28,8) NULL 
END

-- Bổ sung Ana01ID, Ana02ID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1031' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'Ana01ID') 
   ALTER TABLE AT1031 ADD Ana01ID VARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'Ana02ID') 
   ALTER TABLE AT1031 ADD Ana02ID VARCHAR(50) NULL 
END

---- Modified by Kiều Nga on 12/11/2020 : Bổ sung mã phân tích 4,5,6,7 customize CBD
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1031' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'Ana04ID') 
   ALTER TABLE AT1031 ADD Ana04ID VARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'Ana05ID') 
   ALTER TABLE AT1031 ADD Ana05ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'Ana06ID') 
   ALTER TABLE AT1031 ADD Ana06ID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'Ana07ID') 
   ALTER TABLE AT1031 ADD Ana07ID VARCHAR(50) NULL 
END

-- Bổ sung cột DiscountAmount
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1031' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'DiscountAmount') 
   ALTER TABLE AT1031 ADD DiscountAmount DECIMAL(28, 8) NULL
END

-- Update Type  cột DivisionID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1031' AND xtype = 'U')
BEGIN
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1031' AND col.name = 'DivisionID') 
   ALTER TABLE AT1031  ALTER COLUMN DivisionID nvarchar(50) NOT NULL
END