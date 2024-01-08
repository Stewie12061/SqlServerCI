/****** Object:  Index [IX_OT2001_DivisionID_SOrderID]    Script Date: 10/09/2012 14:07:22 ******/
--OT2001
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OT2001]') AND name = N'IX_OT2001_DivisionID_SOrderID')
DROP INDEX [IX_OT2001_DivisionID_SOrderID] ON [dbo].[OT2001] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_OT2001_DivisionID_SOrderID]    Script Date: 10/09/2012 14:07:23 ******/
CREATE NONCLUSTERED INDEX [IX_OT2001_DivisionID_SOrderID] ON [dbo].[OT2001] 
(
	[DivisionID] ASC,
	[TranYear] ASC,
	[TranMonth] ASC,
	[SOrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
------------------------------------------------------------------------------------------------

/****** Object:  Index [OT2001_Index1]    Script Date: 12/02/2019 - Kim Thư ******/
--OT2001
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OT2001]') AND name = N'OT2001_Index1')
DROP INDEX [OT2001_Index1] ON [dbo].[OT2001] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [OT2001_Index1] ON [dbo].[OT2001] 
(
	[DivisionID] ASC,
	[TranYear] ASC,
	[TranMonth] ASC,
	[OrderDate] ASC,
	[ObjectID] ASC,
	[VoucherTypeID] ASC,
	[OrderStatus] ASC,
	[OrderTypeID] ASC,
	[IsPrinted] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
------------------------------------------------------------------------------------------------

