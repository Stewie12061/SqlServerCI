/****** Object:  Index [01_AT2027_DivisionID_VoucherID_InheritVoucherID]    Script Date: 07/04/2014 11:43:41 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT2027]') 
            AND name = N'01_AT2027_DivisionID_VoucherID_InheritVoucherID')
CREATE NONCLUSTERED INDEX [01_AT2027_DivisionID_VoucherID_InheritVoucherID] ON [dbo].[AT2027]
(
	[DivisionID] ASC,
	[VoucherID] ASC,
	[InheritVoucherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

