-- <Summary>
---- 
-- <History>
---- Create on 11/08/2014 by Lê Thị Thu Hiền
---- Modified by Tiểu Mai on 18/01/2016: Add columns MTP đối tượng, loại hàng 
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0109]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0109](
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[DivisionID] [nvarchar](50) NOT NULL,
	[PromoteID] [nvarchar](50) NOT NULL,
	[PromoteName] [nvarchar](250) NOT NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[Description] [nvarchar](250) NULL,
	[IsCommon] [tinyint] NULL,
	[Disabled] [tinyint] NOT NULL,	
	[OrderNo] [int] NOT NULL,
	[FromValues] [decimal](28, 8) NULL,
	[ToValues] [decimal](28, 8) NULL,
	[DiscountPercent] [decimal](28, 8) NULL,
	[DiscountAmount] [decimal](28, 8) NULL,
	[Notes] [nvarchar](250) NULL,	
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,		
 CONSTRAINT [PK_AT0109] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC,
	[PromoteID] ASC,
	[APK] ASC
	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END

--- Tiểu Mai, 18/01/2016: Add columns
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT0109' AND col.name = 'InventoryTypeID')
        ALTER TABLE AT0109 ADD	InventoryTypeID NVARCHAR(50) NULL,
								O01ID NVARCHAR(50) NULL,
								O02ID NVARCHAR(50) NULL,
								O03ID NVARCHAR(50) NULL,
								O04ID NVARCHAR(50) NULL,
								O05ID NVARCHAR(50) NULL

------Modified by [Hoài Bảo] on [06/05/2022]: Bổ sung cột PromoteQuantity
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT0109' AND col.name = 'PromoteQuantity')
BEGIN 
   ALTER TABLE AT0109 ADD PromoteQuantity DECIMAL (28, 8) NULL
END

------Modified by [Hoài Bảo] on [06/05/2022]: Bổ sung cột ObjectID
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT0109' AND col.name = 'ObjectID')
BEGIN 
   ALTER TABLE AT0109 ADD ObjectID NVARCHAR(MAX) NULL
END

------Modified by [Hoài Bảo] on [09/05/2022]: Bổ sung cột ObjectTypeID
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT0109' AND col.name = 'ObjectTypeID')
BEGIN 
   ALTER TABLE AT0109 ADD ObjectTypeID NVARCHAR(50) NULL
END

------Modified by [Hoài Bảo] on [06/06/2022]: Bổ sung cột IsDiscountType, PromotionTypeID, ByPromotionID, InventoryID, UnitID, S01ID -> S20ID
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT0109' AND col.name = 'IsDiscountType')
BEGIN 
   ALTER TABLE AT0109 ADD IsDiscountType TINYINT NULL
END

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT0109' AND col.name = 'PromotionTypeID')
BEGIN 
   ALTER TABLE AT0109 ADD PromotionTypeID TINYINT NULL
END

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT0109' AND col.name = 'ByPromotionID')
BEGIN 
   ALTER TABLE AT0109 ADD ByPromotionID TINYINT NULL
END

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT0109' AND col.name = 'InventoryID')
BEGIN 
   ALTER TABLE AT0109 ADD InventoryID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT0109' AND col.name = 'UnitID')
BEGIN 
   ALTER TABLE AT0109 ADD UnitID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT0109' AND col.name = 'S01ID')
BEGIN 
   ALTER TABLE AT0109 ADD S01ID NVARCHAR(50) NULL,
						  S02ID NVARCHAR(50) NULL,
						  S03ID NVARCHAR(50) NULL,
						  S04ID NVARCHAR(50) NULL,
						  S05ID NVARCHAR(50) NULL,
						  S06ID NVARCHAR(50) NULL,
						  S07ID NVARCHAR(50) NULL,
						  S08ID NVARCHAR(50) NULL,
						  S09ID NVARCHAR(50) NULL,
						  S10ID NVARCHAR(50) NULL,
						  S11ID NVARCHAR(50) NULL,
						  S12ID NVARCHAR(50) NULL,
						  S13ID NVARCHAR(50) NULL,
						  S14ID NVARCHAR(50) NULL,
						  S15ID NVARCHAR(50) NULL,
						  S16ID NVARCHAR(50) NULL,
						  S17ID NVARCHAR(50) NULL,
						  S18ID NVARCHAR(50) NULL,
						  S19ID NVARCHAR(50) NULL,
						  S20ID NVARCHAR(50) NULL
END