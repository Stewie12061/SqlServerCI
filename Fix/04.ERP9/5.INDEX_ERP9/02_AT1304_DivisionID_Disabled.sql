/****** Object:  Index [02_AT1304_DivisionID_Disabled]    Script Date: 1/27/2014 8:34:13 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT1304]') 
            AND name = N'02_AT1304_DivisionID_Disabled')

CREATE NONCLUSTERED INDEX [02_AT1304_DivisionID_Disabled] ON [dbo].[AT1304]
(
	[DivisionID] ASC,
	[Disabled] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


