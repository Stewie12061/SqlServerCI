/****** Object:  Index [AT2008_Index1]    Script Date: 06/03/2019 - Kim Thư ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT2008]') AND name = N'AT2008_Index1')
DROP INDEX [AT2008_Index1] ON [dbo].[AT2008] WITH ( ONLINE = OFF )
GO
CREATE NONCLUSTERED INDEX [AT2008_Index1] ON [dbo].[AT2008] 
(
	[DivisionID] ASC,
	[TranYear] ASC,
	[TranMonth] ASC,
	[WareHouseID] ASC,
	[InventoryAccountID] ASC,
	[InventoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
