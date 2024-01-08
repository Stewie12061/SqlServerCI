--- Created on 20/03/2014 by Phan thanh hoàng vu
--- Du lieu phieu xuat tam bang Detail
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POST00153]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POST00153](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[TransactionID] [varchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[WareHouseID] [varchar](50) NULL,
	[WareHouseName] [nvarchar](250) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[InventoryName] [nvarchar](250) NULL,
	[UnitID] [nvarchar](50) NULL,
	[UnitName] [nvarchar](250) NULL,
	[SalePrice] [decimal](28, 8) NULL,
	[Quantity] [decimal](28, 8) NULL,
	[Description] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_POST00153] PRIMARY KEY CLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
End