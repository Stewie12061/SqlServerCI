-- <Summary>
---- 
-- <History>
---- Create on 21/02/2019 by Kim Thư: Lưu dữ liệu báo cáo xuất kho bán hàng
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WT0165]') AND type in (N'U'))

CREATE TABLE [dbo].[WT0165](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [varchar](50) NOT NULL,
	[UserID] [VARCHAR](50) NOT NULL,
	[InventoryID] [nvarchar](50) NULL,
	[InventoryName] [nvarchar](250) NULL,
	[UnitID] [nvarchar](50) NULL,
	[UnitName] [nvarchar](250) NULL,
	[Quantity1] [decimal](28, 8) NULL,
	[Quantity2] [decimal](28, 8) NULL,
	[Quantity3] [decimal](28, 8) NULL,
	[Quantity4] [decimal](28, 8) NULL,
	[Quantity5] [decimal](28, 8) NULL,
	[Quantity6] [decimal](28, 8) NULL,
	[Quantity7] [decimal](28, 8) NULL,
	[Quantity8] [decimal](28, 8) NULL,
	[Quantity9] [decimal](28, 8) NULL,
	[Quantity10] [decimal](28, 8) NULL,
	[Quantity11] [decimal](28, 8) NULL,
	[Quantity12] [decimal](28, 8) NULL,
	[Quantity13] [decimal](28, 8) NULL,
	[Quantity14] [decimal](28, 8) NULL,
	[Quantity15] [decimal](28, 8) NULL,
	[Quantity16] [decimal](28, 8) NULL,
	[Quantity17] [decimal](28, 8) NULL,
	[Quantity18] [decimal](28, 8) NULL,
	[Quantity19] [decimal](28, 8) NULL,
	[Quantity20] [decimal](28, 8) NULL,
	[Quantity21] [decimal](28, 8) NULL,
	[Quantity22] [decimal](28, 8) NULL,
	[Quantity23] [decimal](28, 8) NULL,
	[Quantity24] [decimal](28, 8) NULL,
	[TotalQuantity] [decimal](28, 8) NULL,
	[I07ID] [nvarchar](50) NULL,
	[InAnaName7] [nvarchar](250) NULL,
	CONSTRAINT [PK_WT0165] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON
)
) ON [PRIMARY]
