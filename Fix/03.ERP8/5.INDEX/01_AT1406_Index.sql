/****** Object:  Index [AT1406_Index1]    Script Date: 08/03/2019 ******/
--AT1406
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT1406]') AND name = N'AT1406_Index1')
DROP INDEX [AT1406_Index1] ON [dbo].[AT1406] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [AT1406_Index1]    Script Date: 08/03/2019 ******/
CREATE NONCLUSTERED INDEX [AT1406_Index1] ON [dbo].[AT1406] 
(
	[DivisionID] ASC,
	[ModuleID] ASC,
	[GroupID] ASC,
	[DataType] ASC,
	[DataID] ASC,
	[Permission] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

