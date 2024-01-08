/****** Object:  UserDefinedTableType [dbo].[TypeOfAV1309]    Script Date: 12/27/2013 *****/
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TypeOfAV1309' AND ss.name = N'dbo')
CREATE TYPE [dbo].[TypeOfAV1309] AS TABLE(
	[DivisionID] [nvarchar](50) NULL,
	[WareHouseID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[InventoryAccountID] [nvarchar](50) NULL,
	[InventoryName] [nvarchar](250) NULL,
	[WareHouseName] [nvarchar](250) NULL,
	[ActBegQty] [decimal](28, 8) NULL,
	[ActBegTotal] [decimal](28, 8) NULL,
	[ActReceivedQty] [decimal](28, 8) NULL,
	[ActReceivedTotal] [decimal](28, 8) NULL,
	[ActDeliveryQty] [decimal](28, 8) NULL,
	[ActEndQty] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL
)



