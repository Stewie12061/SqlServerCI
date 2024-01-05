-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Quốc Cường
---- Modified by Tiểu Mai on 18/01/2016: Add columns MTP đối tượng, loại hàng 
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1328]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AT1328](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[PromoteID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[OID] [nvarchar](50) NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[FromQuantity] [decimal](28, 8) NULL,
	[ToQuantity] [decimal](28, 8) NULL,
	[Disabled] [TinyInt] NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[IsCommon] [tinyint] NULL,
	[PromoteTypeID] [tinyint] NULL,
	CONSTRAINT [PK_AT1328] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
---- Add giá trị default 
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1328_IsCommon]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1328] ADD  CONSTRAINT [DF_AT1328_IsCommon]  DEFAULT ((0)) FOR [IsCommon]
END

--- Tiểu Mai, 18/01/2016: Add columns
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1328' AND col.name = 'O01ID')
        ALTER TABLE AT1328 ADD	O01ID NVARCHAR(50) NULL,
								O02ID NVARCHAR(50) NULL,
								O03ID NVARCHAR(50) NULL,
								O04ID NVARCHAR(50) NULL,
								O05ID NVARCHAR(50) NULL
--Modified by Thị Phượng: Date 18/01/2018: Bổ sung cột bảng giá theo gói lưu vết bảng giá đc chọn theo gói
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1328' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1328' AND col.name = 'PackagePriceID') 
   ALTER TABLE AT1328 ADD PackagePriceID VARCHAR(50) NULL 
END

/*===============================================END PackagePriceID===============================================*/ 

------Modified by [Hoài Bảo] on [10/05/2022]: Bổ sung cột IsDiscount
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1328' AND col.name = 'IsDiscount')
BEGIN 
   ALTER TABLE AT1328 ADD IsDiscount TINYINT NULL
END