/****** Object:  Index [AT0114_Index1]    Script Date: 06/03/2019 - Kim Thư ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT0114]') AND name = N'AT0114_Index1')
DROP INDEX [AT0114_Index1] ON [dbo].[AT0114] WITH ( ONLINE = OFF )
GO
CREATE NONCLUSTERED INDEX [AT0114_Index1] ON [dbo].[AT0114] 
(
	[DivisionID] ASC,
	[ReTranYear] ASC,
	[ReTranMonth] ASC,
	[WareHouseID] ASC,
	[ReVoucherID] ASC,
	[ReTransactionID] ASC,
	[InventoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
