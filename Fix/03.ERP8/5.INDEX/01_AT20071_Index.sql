/****** Object:  Index [AT2007_DivisionID_VoucherID]    Script Date: 10/09/2012 14:15:35 ******/
--AT2007
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT20071]') AND name = N'AT20071_TABLEID_KindVoucherID_DebitAccountID_Old')
DROP INDEX [AT20071_TABLEID_KindVoucherID_DebitAccountID_Old] ON [dbo].[AT20071] WITH ( ONLINE = OFF )
GO
/****** Object:  Index [AT20071_TABLEID_KindVoucherID_DebitAccountID_Old]    Script Date: 04/07/2020 16:55:30 ******/
CREATE NONCLUSTERED INDEX [AT20071_TABLEID_KindVoucherID_DebitAccountID_Old] ON [dbo].[AT20071] 
(
	[TABLEID] ASC,
	[KindVoucherID] ASC,
	[DebitAccountID_Old] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY];
GO


