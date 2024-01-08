/****** Object:  Index [OT3001_Index1]    Script Date: 12/02/2019 - Kim Thư ******/
--OT3001
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OT3001]') AND name = N'OT3001_Index1')
DROP INDEX [OT3001_Index1] ON [dbo].[OT3001] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [OT3001_Index1] ON [dbo].[OT3001] 
(
	[DivisionID] ASC,
	[TranYear] ASC,
	[TranMonth] ASC,
	[OrderDate] ASC,
	[ObjectID] ASC,
	[VoucherTypeID] ASC,
	[OrderStatus] ASC,
	[IsPrinted] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
------------------------------------------------------------------------------------------------

