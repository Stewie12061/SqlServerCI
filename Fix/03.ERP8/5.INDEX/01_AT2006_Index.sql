/****** Object:  Index [AT2006_DivisionID_TranMonth]    Script Date: 10/09/2012 14:11:35 ******/
--AT2006
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT2006]') AND name = N'AT2006_DivisionID_TranMonth')
DROP INDEX [AT2006_DivisionID_TranMonth] ON [dbo].[AT2006] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [AT2006_DivisionID_TranMonth]    Script Date: 10/09/2012 14:11:35 ******/
CREATE NONCLUSTERED INDEX [AT2006_DivisionID_TranMonth] ON [dbo].[AT2006] 
(
	[DivisionID] ASC,
	[TranYear] ASC,
	[TranMonth] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
------------------------------------------------------------------------------------------------

/****** Object:  Index [AT2006_Index1]    Script Date: 12/02/2019 - Kim Thư ******/
--AT2006
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT2006]') AND name = N'AT2006_Index1')
DROP INDEX [AT2006_Index1] ON [dbo].[AT2006] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [AT2006_Index1] ON [dbo].[AT2006] 
(
	[DivisionID] ASC,
	[TranYear] ASC,
	[TranMonth] ASC,
	[VoucherDate] ASC,
	[KindVoucherID] ASC,
	[VoucherTypeID] ASC,
	[VoucherNo] ASC,
	[ObjectID] ASC,
	[WareHouseID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
------------------------------------------------------------------------------------------------
/****** Object:  Index [AT2007_AT2006_Index2]    Script Date: 06/03/2019 - Kim Thư ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT2006]') AND name = N'AT2006_Index2')
DROP INDEX [AT2006_Index2] ON [dbo].[AT2006] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [AT2006_Index2] ON [dbo].[AT2006] 
(
	[DivisionID] ASC,
	[KindVoucherID] ASC
)INCLUDE ([VoucherID])
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Index [AT2006_Index3]    Script Date: 06/03/2019 - Kim Thư ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT2006]') AND name = N'AT2006_Index3')
DROP INDEX [AT2006_Index3] ON [dbo].[AT2006] WITH ( ONLINE = OFF )
GO
CREATE NONCLUSTERED INDEX [AT2006_Index3] ON [dbo].[AT2006] 
(
	[DivisionID] ASC,
	[WareHouseID2] ASC
)INCLUDE ([VoucherID])
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
