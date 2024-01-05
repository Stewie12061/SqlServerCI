-- <Summary>
---- Detail tình hình sản xuất (Bê Tông Long An)
-- <History>
---- Create on 15/08/2017 by Hải Long
---- Modified on 09/11/2018 by Kim Thư: Bổ sung cột DiscountedUnitPrice và ConvertedDiscountedUnitPrice lưu đơn giá sau khi đã chiết khấu
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1036]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1036](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[InventoryID] [nvarchar](50) NULL,					
	[UnitID] [nvarchar](50) NULL,
	[ConvertedQuantity] [decimal](28,8) NULL,	
	[ConvertedPrice] [decimal](28,8) NULL,	
	[DiscountRate] [decimal](28,8) NULL,				
	[DiscountAmount] [decimal](28,8) NULL,		
	[OriginalAmount] [decimal](28,8) NULL,	
	[ConvertedAmount] [decimal](28,8) NULL,		
	[InheritVoucherID] [nvarchar](50) NULL,	
	[InheritTransactionID] [nvarchar](50) NULL,
	[AT9000VoucherID] [nvarchar](50) NULL,
	[AT9000TransactionID] [nvarchar](50) NULL,			
	[Orders] [int] NULL	
 CONSTRAINT [PK_AT1036] PRIMARY KEY NONCLUSTERED 
(
	[VoucherID] ASC,
	[TransactionID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


--- Modified by Hải Long on 28/09/2017: Bổ sung trường DiscountSaleAmountDetail
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1036' AND xtype = 'U')
BEGIN      
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1036' AND col.name = 'DiscountSaleAmountDetail')
    ALTER TABLE AT1036 ADD DiscountSaleAmountDetail DECIMAL(28,8) NULL                   
END	 

---- Modified on 09/11/2018 by Kim Thư: Bổ sung cột DiscountedUnitPrice lưu đơn giá sau khi đã chiết khấu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1036' AND xtype = 'U')
BEGIN      
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1036' AND col.name = 'DiscountedUnitPrice')
    ALTER TABLE AT1036 ADD DiscountedUnitPrice DECIMAL(28,8) NULL
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1036' AND col.name = 'ConvertedDiscountedUnitPrice')
    ALTER TABLE AT1036 ADD ConvertedDiscountedUnitPrice DECIMAL(28,8) NULL                       
END	 